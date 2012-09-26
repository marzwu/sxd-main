package com.views
{
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class FriendChatView extends Base implements IView
    {
        private var _groupId:int = 0;
        private var _gmListData:Object;
        public var _chat:IFriendChat;
        private var _showNum:int = 0;
        private var _chatPlayerList:Array;

        public function FriendChatView()
        {
            this._gmListData = {};
            this._chatPlayerList = [];
            return;
        }// end function

        public function get_friendinfo_chatrecord_list(param1:int) : void
        {
            if (this.checkChatLen(param1) == false)
            {
                return;
            }
            if (param1 == this._ctrl.player.playerId)
            {
                return;
            }
            this.getPlayerId = param1;
            _view.friendMessage.clearAble = param1;
            if (_view.toolbar.showChatId == param1)
            {
                _view.toolbar.showChatId = 0;
            }
            _view.tip2.showTip(FriendChatViewLang.Wait, FriendChatViewLang.GetDate, TipType.Process);
            _data.call(Mod_Friend_Base.get_friendinfo_chatrecord_list, this.friendinfoChatrecordCallBack, [param1]);
            return;
        }// end function

        private function send_message_to_friend(param1:int, param2:String, param3:String, param4:String) : void
        {
            _data.call(Mod_Friend_Base.send_message_to_friend, this.sendMessageCallBack, [param1, param2, param3, param4]);
            return;
        }// end function

        private function receive_message_from_friend() : void
        {
            _data.patch(Mod_Friend_Base.receive_message_from_friend, this.receiveMessageCallBack);
            return;
        }// end function

        public function get_group(param1:String, param2:int) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._groupId = param2;
            _data.call(Mod_Friend_Base.get_group, this.getGroupCallBack, [param2, param1]);
            return;
        }// end function

        private function notify_enter_state(param1:int, param2:int) : void
        {
            _data.call(Mod_Friend_Base.notify_enter_state, new Function(), [param1, param2]);
            return;
        }// end function

        private function receive_friend_enter_state() : void
        {
            _data.patch(Mod_Friend_Base.receive_friend_enter_state, this.receiveFriendEnterCallBack);
            return;
        }// end function

        private function friendinfoChatrecordCallBack() : void
        {
            _view.tip2.hideTip();
            if (this.inStage == false)
            {
                this.show();
                return;
            }
            var _loc_1:* = _ctrl.friend.getFriendinfoChatrecordList;
            this._chat.getPlayerInfo = _loc_1;
            this._chat.getChatList(_loc_1.chatRecordList, _loc_1.playerId);
            if (_loc_1.isGm == false)
            {
                this.get_group(_loc_1.name, _loc_1.playerId);
            }
            return;
        }// end function

        private function sendMessageCallBack() : void
        {
            var _loc_1:* = _ctrl.friend.sendMessageToFriend;
            if (_loc_1.msg == Mod_Friend_Base.SEND_SUCCESS)
            {
                this._chat.getChatData(_loc_1, _loc_1.playerId);
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function receiveMessageCallBack() : void
        {
            var _loc_1:* = _ctrl.friend.receiveMessageFromFriend;
            this._chat.getChatData(_loc_1, _loc_1.playerId);
            if (this.checkPlayerId(_loc_1.playerId) == false)
            {
                _view.friendMessage.addSingularMissage(_loc_1);
            }
            return;
        }// end function

        private function getGroupCallBack() : void
        {
            var _loc_1:* = _ctrl.friend.getGroup;
            if (_loc_1.msg == Mod_Friend_Base.FRIEND_NOT_FOUND)
            {
                this.renderMsg(_loc_1);
            }
            else
            {
                this._chat.btnState(_loc_1.msg, this._groupId);
            }
            return;
        }// end function

        private function receiveFriendEnterCallBack() : void
        {
            var _loc_1:* = _ctrl.friend.receiveFriendEnterState;
            this._chat.getFriendEnterState(_loc_1.friendId, _loc_1.state);
            return;
        }// end function

        private function renderMsg(param1:Object) : void
        {
            switch(param1.msg)
            {
                case Mod_Friend_Base.FRIEND_NOT_FOUND:
                {
                    _view.showTip(FriendChatViewLang.FriendNotFound);
                    break;
                }
                case Mod_Friend_Base.FUNCTION_NO_OPEN:
                {
                    _view.showTip(FriendChatViewLang.FunctionNoOpen);
                    break;
                }
                case Mod_Friend_Base.IN_BLCAKLIST:
                {
                    _view.showTip(FriendChatViewLang.InBlcakList);
                    break;
                }
                case Mod_Friend_Base.SEND_ERROR:
                {
                    _view.showTip(FriendChatViewLang.SendError);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function show() : void
        {
            loadAssets("FriendChatBox", this.render, FriendChatViewLang.LoadAssets);
            return;
        }// end function

        public function set gmListData(param1:Object) : void
        {
            return;
        }// end function

        private function render() : void
        {
            this._chat = _view.getAssetsObject("FriendChatBox", "FriendChatBox") as IFriendChat;
            _popup.addView(this, this._chat.content);
            _view.center(sign, this._chat.content);
            this._chat.tip = _view.tip.iTip;
            this._chat.drag = _view.drag.iDrag;
            this._chat.onSendChat = function (param1:Object) : void
            {
                send_message_to_friend(param1.id, param1.msg, param1.eipNum, param1.eipIndex);
                return;
            }// end function
            ;
            this._chat.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._chat.onAddFriend = function (param1:Object) : void
            {
                _view.friendList.addFriend(param1.name, param1.playerId);
                return;
            }// end function
            ;
            this._chat.onBlackList = function (param1:Object) : void
            {
                _view.friendList.addBlackList = param1;
                return;
            }// end function
            ;
            this._chat.onDeleteFriend = function (param1:Object) : void
            {
                _view.friendList.deleteFrined = param1;
                return;
            }// end function
            ;
            this._chat.onSendFlower = function (param1:Object) : void
            {
                _view.sendFlower.sendPlayerID = param1.playerId;
                _view.sendFlower.show();
                return;
            }// end function
            ;
            this._chat.onTip = function (param1:String) : void
            {
                switch(param1)
                {
                    case "CHATFULL":
                    {
                        _view.showTip(FriendChatViewLang.ChatFull);
                        ;
                    }
                    default:
                    {
                        ;
                    }
                }
                return;
            }// end function
            ;
            this._chat.onButtleFriend = function (param1:Object) : void
            {
                _view.pkWar.defenderPlayerId = param1.playerId;
                _view.pkWar.show();
                return;
            }// end function
            ;
            this._chat.onClearFriend = function (param1:int) : void
            {
                clearPlayerId = param1;
                return;
            }// end function
            ;
            this._chat.onShowPerson = function (param1:Object) : void
            {
                _view.otherRoleMsg.init(param1.playerId, param1.name);
                _view.otherRoleMsg.show();
                return;
            }// end function
            ;
            this._chat.onEnterState = function (param1:int, param2:int) : void
            {
                notify_enter_state(param1, param2);
                return;
            }// end function
            ;
            this._chat.isShowSendFlower = FunctionType.isOpened(FunctionType.SendFlower);
            this._chat.init();
            this.friendinfoChatrecordCallBack();
            this.receive_message_from_friend();
            this.receive_friend_enter_state();
            return;
        }// end function

        public function set onAutoShowChat(param1:int) : void
        {
            if (this.checkChatLen(param1) == false)
            {
                return;
            }
            this.getPlayerId = param1;
            this.get_friendinfo_chatrecord_list(param1);
            return;
        }// end function

        public function set onlineState(param1:Object) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._chat.onlineState = param1;
            return;
        }// end function

        public function set getPlayerId(param1:int) : void
        {
            if (this.checkPlayerId(param1) == false)
            {
                this._chatPlayerList.push(param1);
            }
            this.cleckChat = param1;
            return;
        }// end function

        public function set clearPlayerId(param1:int) : void
        {
            var _loc_4:int = 0;
            var _loc_2:* = this._chatPlayerList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._chatPlayerList[_loc_3];
                if (_loc_4 == param1)
                {
                    this._chatPlayerList.splice(_loc_3, 1);
                    return;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function set cleckChat(param1:int) : void
        {
            _ctrl.friend.clearPlayerId = param1;
            _view.friendList.check_receive_message(param1);
            var _loc_2:* = _ctrl.friend.getUnreceiveFriendList;
            var _loc_3:* = _loc_2 == null ? (0) : (_loc_2.length);
            _view.toolbar.friendMsg(_loc_3);
            return;
        }// end function

        public function checkPlayerId(param1:int) : Boolean
        {
            var _loc_4:int = 0;
            var _loc_2:* = this._chatPlayerList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._chatPlayerList[_loc_3];
                if (_loc_4 == param1)
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        public function checkChatLen(param1:int) : Boolean
        {
            var _loc_4:int = 0;
            var _loc_2:* = this._chatPlayerList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._chatPlayerList[_loc_3];
                if (_loc_4 == param1)
                {
                    return true;
                }
                _loc_3++;
            }
            if (_loc_2 >= 10)
            {
                _view.showTip(FriendChatViewLang.ChatAll);
            }
            return _loc_2 < 10;
        }// end function

        public function close() : void
        {
            this._chatPlayerList = [];
            _popup.closeView(this);
            this.clear();
            return;
        }// end function

        public function clear() : void
        {
            this._chat.clear();
            _data.cancelPatch(Mod_Friend_Base.receive_message_from_friend);
            _data.cancelPatch(Mod_Friend_Base.receive_friend_enter_state);
            _view.friendMessage.patchReceiveMessage();
            return;
        }// end function

    }
}
