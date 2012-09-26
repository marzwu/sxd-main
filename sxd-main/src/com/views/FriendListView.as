package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class FriendListView extends Base implements IView
    {
        private var _favourite:String = "FAVOURITE";
        private var _cancelFavourite:String = "CANCEL_FAVOURITE";
        private var _friend:String = "FRIEND";
        private var _blackList:String = "BLACKLIST";
        private var _lastContact:String = "LAST_CONTACT";
        private var _moveList:String = "MOVELIST";
        private var _deleteList:String = "DELETELIST";
        private var _friendList:IFriendList;
        private var _isShowChat:Boolean = false;
        private var _friendShow:Boolean = false;
        private var _openType:String = "FRIEND";
        private var _friendName:String = "";
        private var _friendId:int = 0;
        private var _moveInfo:String = "";
        private var _moveType:String = "";
        private var _moveData:Object;
        private var _chetPlayerId:int = 0;
        public var showChatId:int = 0;
        private var _chatData:Object;
        private var _alert:IAlert;

        public function FriendListView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (inStage)
            {
                return;
            }
            var _loc_1:* = _ctrl.friend.getUnreceiveFriendList;
            var _loc_2:int = 0;
            if (_loc_1 != null && _loc_1.length > 0)
            {
                _loc_2 = _loc_1.length;
            }
            if (_loc_2 > 0)
            {
                this._openType = this._lastContact;
            }
            else
            {
                this._openType = this._friend;
            }
            this.get_Friend_List(this._openType);
            return;
        }// end function

        private function add_Friend(param1:int, param2:String) : void
        {
            this.addLoadMc(FriendListViewLang.Wait, FriendListViewLang.SelectFriend);
            _data.call(Mod_Friend_Base.add_friend, this.addFriendCallback, [param1, param2]);
            return;
        }// end function

        private function get_group(param1:int, param2:String) : void
        {
            _data.call(Mod_Friend_Base.get_group, this.getGroupCallback, [param1, param2]);
            return;
        }// end function

        private function add_Black(param1:String) : void
        {
            _data.call(Mod_Friend_Base.add_to_black, this.addBlackCallback, [param1]);
            return;
        }// end function

        public function check_receive_message(param1:int) : void
        {
            _data.call(Mod_Friend_Base.check_receive_message, new Function(), [param1]);
            return;
        }// end function

        private function delete_Friend(param1:int) : void
        {
            _data.call(Mod_Friend_Base.delete_friend, this.deleteFriendCallback, [param1]);
            return;
        }// end function

        private function get_Friend_List(param1:String) : void
        {
            this._openType = param1;
            _data.call(Mod_Friend_Base.get_friend_list, this.getFriendListCallback, [Mod_Friend_Base[param1]]);
            return;
        }// end function

        public function add_favourite_friend(param1:int) : void
        {
            _data.call(Mod_Friend_Base.add_favourite_friend, this.adFavouriteFriendCallBack, [param1]);
            return;
        }// end function

        public function cancel_favourite_friend(param1:int) : void
        {
            _data.call(Mod_Friend_Base.cancel_favourite_friend, this.cancelFavouriteFriendCallBack, [param1]);
            return;
        }// end function

        private function renderShow() : void
        {
            this.loadResource(this.render);
            return;
        }// end function

        private function loadResource(param1:Function) : void
        {
            loadAssets("FriendList", this.render, FriendListViewLang.LoadAssets);
            return;
        }// end function

        private function render() : void
        {
            this._friendList = _view.getAssetsObject("FriendList", "FriendList") as IFriendList;
            _popup.addView(this, this._friendList.content);
            _view.center(sign, this._friendList.content);
            this._friendList.drag = _view.drag.iDrag;
            this._friendList.tip = _view.tip.iTip;
            this.alert = _view.alert.iAlert;
            this.renderList();
            this._moveType = this._friend;
            return;
        }// end function

        private function addFriendCallback() : void
        {
            var _loc_1:* = _ctrl.friend.addFriend();
            this.renderMsg(_loc_1.msg, this._friend);
            if (this._chatData != null && this._chatData.id > 0)
            {
                _view.friendChat.get_group(this._chatData.name, this._chatData.id);
            }
            if (this.inStage == false)
            {
                this.alert = _view.alert.iAlert;
                return;
            }
            this._friendList.addFriendInfo = _loc_1.info;
            this.renderFriendList();
            return;
        }// end function

        private function addFriendForIdCallBack() : void
        {
            var _loc_1:* = _ctrl.friend.addFriendById();
            this.renderMsg(_loc_1.msg, this._friend);
            return;
        }// end function

        private function addBlackCallback() : void
        {
            var _loc_1:* = _ctrl.friend.addBlack();
            this.renderMsg(_loc_1.msg, this._blackList);
            _view.friendChat.get_group(this._chatData.name, this._chatData.id);
            return;
        }// end function

        private function getFriendListCallback() : void
        {
            var _loc_1:* = _ctrl.friend.getFriendList();
            this.clearFriendMsg(_loc_1);
            if (this.inStage == false)
            {
                _data.call(Mod_Friend_Base.get_playerinfo, this.renderShow, [], false);
            }
            else
            {
                this._friendList.getFriendList = _loc_1;
            }
            return;
        }// end function

        private function clearFriendMsg(param1:Array) : void
        {
            var _loc_4:Object = null;
            var _loc_5:Boolean = false;
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1[_loc_3];
                _loc_5 = _view.friendChat.checkPlayerId(_loc_4.id);
                if (_loc_5)
                {
                    _loc_4.msg = 0;
                    _loc_4.onLine = _loc_4.tempOnLine;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function getGroupCallback() : void
        {
            var _loc_1:* = _ctrl.friend.getGroup;
            switch(_loc_1.msg)
            {
                case Mod_Friend_Base.FRIEND:
                {
                    if (this._moveType == this._blackList)
                    {
                        if (this._openType == this._friend)
                        {
                            this.add_Black(this._friendName);
                        }
                        else
                        {
                            this.renderBlackOrFriend(FriendListViewLang.AddBlackListInfo, this.addBlackListInfo);
                        }
                    }
                    else
                    {
                        this.add_Friend(this._friendId, this._friendName);
                    }
                    break;
                }
                case Mod_Friend_Base.BLACKLIST:
                {
                    if (this._moveType == this._friend)
                    {
                        if (this._openType == this._blackList)
                        {
                            this.add_Friend(this._friendId, this._friendName);
                        }
                        else
                        {
                            this.renderBlackOrFriend(FriendListViewLang.AddFriendListInfo, this.addFriendListInfo);
                        }
                    }
                    else
                    {
                        this.add_Black(this._friendName);
                    }
                    break;
                }
                case Mod_Friend_Base.STRANGER:
                {
                    if (this._moveType == this._friend)
                    {
                        this.add_Friend(this._friendId, this._friendName);
                    }
                    else
                    {
                        this.add_Black(this._friendName);
                    }
                    break;
                }
                case Mod_Friend_Base.FRIEND_NOT_FOUND:
                {
                    if (this._moveType == this._friend)
                    {
                        this.add_Friend(this._friendId, this._friendName);
                    }
                    else
                    {
                        this.add_Black(this._friendName);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function moveFriendCallBack() : void
        {
            var _loc_1:* = _ctrl.friend.moveFriend();
            this.renderMsg(_loc_1.msg, this._moveType);
            _view.friendChat.get_group(this._chatData.name, this._chatData.id);
            return;
        }// end function

        private function deleteFriendCallback() : void
        {
            var _loc_1:* = _ctrl.friend.deleteFriend();
            this.renderMsg(_loc_1.msg, this._deleteList);
            _view.friendChat.get_group(this._chatData.name, this._chatData.id);
            this.renderFriendList();
            return;
        }// end function

        public function adFavouriteFriendCallBack() : void
        {
            var _loc_1:* = _ctrl.friend.addFavouriteFriend;
            this.renderMsg(_loc_1, this._favourite);
            this.renderFriendList();
            return;
        }// end function

        public function cancelFavouriteFriendCallBack() : void
        {
            var _loc_1:* = _ctrl.friend.cancelFavouriteFriend;
            this.renderMsg(_loc_1, this._cancelFavourite);
            this.renderFriendList();
            return;
        }// end function

        private function renderList() : void
        {
            this._friendList.getPlayerData = _ctrl.friend.getPlayerInfo();
            this._friendList.isOpenPk = URI.canPk;
            this._friendList.isShowInvitation = URI.weiBoNickName;
            this.getFriendListCallback();
            this._friendList.onOpenFriendType = this._openType;
            this._friendList.isOpenSendFlower = FunctionType.isOpened(FunctionType.SendFlower);
            var str:* = URI.nickNameSuffix();
            var merge:* = str.length > 0;
            this._friendList.isMerge = merge;
            this._friendList.onFriend = function () : void
            {
                get_Friend_List(_friend);
                return;
            }// end function
            ;
            this._friendList.onAudience = function () : void
            {
                if (_view.audience.inStage == false)
                {
                    _view.audience.show();
                }
                else
                {
                    _view.audience.close();
                }
                return;
            }// end function
            ;
            this._friendList.onRecent = function () : void
            {
                get_Friend_List(_lastContact);
                return;
            }// end function
            ;
            this._friendList.onBlackList = function () : void
            {
                get_Friend_List(_blackList);
                return;
            }// end function
            ;
            this._friendList.onShowPerson = function (param1:Object) : void
            {
                _view.otherRoleMsg.close();
                _view.otherRoleMsg.init(param1.id, param1.name);
                _view.otherRoleMsg.show();
                return;
            }// end function
            ;
            this._friendList.onAddInfo = function (param1:String, param2:String) : void
            {
                _moveType = param1;
                _friendName = param2;
                get_group(0, param2);
                return;
            }// end function
            ;
            this._friendList.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._friendList.onButtleFriend = function (param1:Object) : void
            {
                _view.pkWar.defenderPlayerId = param1.id;
                _view.pkWar.show();
                return;
            }// end function
            ;
            this._friendList.onDeleteFriend = function (param1:Object) : void
            {
                _chatData = param1;
                delete_Friend(param1.id);
                return;
            }// end function
            ;
            this._friendList.onMoveFriend = function (param1:Object, param2:String, param3:String) : void
            {
                get_group(0, param1.name);
                _friendName = param1.name;
                _chatData = param1;
                _moveData = {};
                _moveData = param1;
                _moveType = param2;
                _moveInfo = param3;
                return;
            }// end function
            ;
            this._friendList.onChatShow = function (param1:Object) : void
            {
                var _loc_2:* = param1.id;
                check_receive_message(_loc_2);
                _chetPlayerId = _loc_2;
                _view.friendChat.get_friendinfo_chatrecord_list(_loc_2);
                return;
            }// end function
            ;
            this._friendList.onSendFlower = function (param1:Object) : void
            {
                _view.sendFlower.sendPlayerID = param1.id;
                _view.sendFlower.show();
                return;
            }// end function
            ;
            this._friendList.onMsgOpen = function (param1:Object) : void
            {
                var _loc_2:* = param1.id;
                check_receive_message(_loc_2);
                _view.friendChat.onAutoShowChat = param1.id;
                get_Friend_List(_openType);
                return;
            }// end function
            ;
            this._friendList.onInvitation = function () : void
            {
                _view.switchWeiBoFriend(true);
                return;
            }// end function
            ;
            this._friendList.onAddFavourite = function (param1:Object) : void
            {
                add_favourite_friend(param1.id);
                return;
            }// end function
            ;
            this._friendList.onCancelFavourite = function (param1:Object) : void
            {
                cancel_favourite_friend(param1.id);
                return;
            }// end function
            ;
            return;
        }// end function

        public function addFriend(param1:String = "", param2:int = 0) : void
        {
            this._chatData = {};
            this._chatData.name = param1;
            this._chatData.id = param2;
            this._moveType = this._friend;
            this._friendName = param1;
            this._friendId = param2;
            this.get_group(param2, this._friendName);
            return;
        }// end function

        public function set deleteFrined(param1:Object) : void
        {
            this._chatData = param1;
            this._chatData.id = param1.playerId;
            this.delete_Friend(param1.playerId);
            return;
        }// end function

        public function set addBlackList(param1:Object) : void
        {
            this._chatData = param1;
            this._chatData.id = param1.playerId;
            this.add_Black(param1.name);
            return;
        }// end function

        public function closeChat() : void
        {
            this._chetPlayerId = 0;
            return;
        }// end function

        public function set onlineState(param1:Object) : void
        {
            if (this.inStage)
            {
                this._friendList.isOnLine = param1;
            }
            return;
        }// end function

        public function set messageCount(param1:Object) : void
        {
            var _loc_2:Boolean = false;
            if (this.inStage)
            {
                _loc_2 = _view.friendChat.checkPlayerId(param1.id);
                if (_loc_2 == false)
                {
                    this._friendList.friendMsgNum = param1;
                }
            }
            return;
        }// end function

        public function set alert(param1:IAlert) : void
        {
            this._alert = param1;
            return;
        }// end function

        public function renderBlackOrFriend(param1:String, param2:Function) : void
        {
            var _loc_3:uint = 0;
            if (this._alert == null)
            {
                this.alert = _view.alert.iAlert;
            }
            this._alert.yesLabel = FriendListViewLang.Sure;
            this._alert.noLabel = FriendListViewLang.Cancel;
            _loc_3 = AlertButtonType.Yes | AlertButtonType.No;
            this._alert.show(param1, _loc_3, param2);
            return;
        }// end function

        public function addFriendListInfo(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.add_Friend(this._friendId, this._friendName);
                    break;
                }
                case AlertButtonType.No:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function addLoadMc(param1:String, param2:String) : void
        {
            _view.tip2.showTip(param1, param2, TipType.Process);
            return;
        }// end function

        public function addBlackListInfo(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.add_Black(this._friendName);
                    break;
                }
                case AlertButtonType.No:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function renderMsg(param1:int, param2:String) : void
        {
            var _loc_3:Boolean = false;
            var _loc_4:Boolean = false;
            switch(param1)
            {
                case Mod_Friend_Base.SUCCESS:
                {
                    break;
                }
                case Mod_Friend_Base.ADD_SUCCESS:
                {
                    _loc_3 = true;
                    if (param2 == this._friend)
                    {
                        _view.showTip(FriendListViewLang.AddFriendSuccess, null, TipType.Success);
                    }
                    else
                    {
                        _view.showTip(FriendListViewLang.AddBlackSuccess, null, TipType.Success);
                    }
                    this.renderFriendList();
                    break;
                }
                case Mod_Friend_Base.FRIEND_NOT_FOUND:
                {
                    _view.showTip(FriendListViewLang.FriendNotFound);
                    break;
                }
                case Mod_Friend_Base.ADD_SELF:
                {
                    _view.showTip(FriendListViewLang.AddSelf);
                    break;
                }
                case Mod_Friend_Base.EXIST_IN_FRIENDGROUP:
                {
                    _view.showTip(FriendListViewLang.ExistInFriendGroup);
                    break;
                }
                case Mod_Friend_Base.EXIST_IN_BLACKLISTGROUP:
                {
                    _view.showTip(FriendListViewLang.ExistInBlacklistgroup);
                    break;
                }
                case Mod_Friend_Base.FRIENDGROUP_GT_UPPER_LIMIT:
                {
                    _view.showTip(FriendListViewLang.FriendGroupGtUpperLimit);
                    break;
                }
                case Mod_Friend_Base.DELETE_SUCCESS:
                {
                    _loc_4 = true;
                    _view.showTip(FriendListViewLang.DeleteSuccess);
                    this.renderFriendList();
                    break;
                }
                case Mod_Friend_Base.DELETE_ERROR:
                {
                    _view.showTip(FriendListViewLang.DeleteError);
                    break;
                }
                case Mod_Friend_Base.FUNCTION_NO_OPEN:
                {
                    _view.showTip(FriendListViewLang.FunctionNoOpen);
                    break;
                }
                case Mod_Friend_Base.HASADDED:
                {
                    _view.showTip(FriendListViewLang.ExistInFriendGroup);
                    break;
                }
                case Mod_Friend_Base.ERRPLAYERID:
                {
                    _view.showTip(FriendListViewLang.ERRPLAYERID);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function renderFriendList() : void
        {
            if (!inStage)
            {
                return;
            }
            this.get_Friend_List(this._openType);
            return;
        }// end function

        public function alertInfo(param1:String, param2:String, param3:int) : void
        {
            _view.showTip(param1, param2, param3);
            return;
        }// end function

        public function close() : void
        {
            _ctrl.friend.showChatId = 0;
            this._isShowChat = false;
            this._openType = this._friend;
            if (this._friendList != null)
            {
                this._friendList.close();
                this._friendList = null;
            }
            _popup.closeView(this);
            Helper.gc();
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

    }
}
