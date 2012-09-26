package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class FriendMessageView extends Base implements IView
    {
        private var _messageList:Array;
        private var _message:IFriendMessage;
        public var isShowMostBox:Boolean = false;

        public function FriendMessageView()
        {
            return;
        }// end function

        public function patchReceiveMessage() : void
        {
            _data.patch(Mod_Friend_Base.receive_message_from_friend, this.receiveMessageCallBack);
            return;
        }// end function

        public function cancelPatchReceiveMessage() : void
        {
            _data.cancelPatch(Mod_Friend_Base.receive_message_from_friend);
            return;
        }// end function

        public function message_box_list() : void
        {
            if (this._messageList == null)
            {
                _data.call(Mod_Friend_Base.message_box_list, this.messageBoxCallBack, []);
            }
            else
            {
                this.isShowFriend();
            }
            return;
        }// end function

        private function receiveMessageCallBack() : void
        {
            var _loc_1:* = _ctrl.friend.receiveMessageFromFriend;
            this.addSingularMissage(_loc_1);
            return;
        }// end function

        private function messageBoxCallBack() : void
        {
            var _loc_1:* = _ctrl.friend.messageBoxList;
            this._messageList = _loc_1;
            this.isShowFriend();
            return;
        }// end function

        private function isShowFriend() : void
        {
            var _loc_1:* = this._messageList.length;
            if (_loc_1 > 0)
            {
                if (this._message == null)
                {
                    return;
                }
                this._message.geMessageList = this._messageList;
                _view.toolbar.friendMsg(0);
            }
            else
            {
                _view.friendList.switchSelf();
            }
            return;
        }// end function

        private function messageBoxForColoseCallBack() : void
        {
            if (this._messageList == null)
            {
                return;
            }
            var _loc_1:* = this._messageList.length;
            _view.toolbar.friendMsg(_loc_1);
            return;
        }// end function

        public function show() : void
        {
            loadAssets("FriendMessage", this.render, FriendMessageViewLang.LoadInfo, true, true);
            return;
        }// end function

        private function render() : void
        {
            this._message = _view.getAssetsObject("FriendMessage", "FriendMessage") as IFriendMessage;
            _popup.addView(this, this._message.content);
            this._message.onOpenFriend = function (param1:int) : void
            {
                _view.friendChat.onAutoShowChat = param1;
                return;
            }// end function
            ;
            this._message.onOpenFriendList = function () : void
            {
                _view.friendList.show();
                return;
            }// end function
            ;
            this._message.onShowMost = function (param1:Boolean) : void
            {
                if (param1 == isShowMostBox)
                {
                    return;
                }
                isShowMostBox = param1;
                _view.toolbar.friendMsg(0);
                return;
            }// end function
            ;
            this._message.onClearAll = function (param1:Array) : void
            {
                clearMessageAll(param1);
                return;
            }// end function
            ;
            this.patchReceiveMessage();
            this.reposition();
            return;
        }// end function

        public function clear() : void
        {
            if (this._message == null)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.Friend) == false)
            {
                return;
            }
            this.isShowMostBox = false;
            this.messageBoxForColoseCallBack();
            this._message.clearMostMessage();
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (inStage == false)
            {
                return;
            }
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                this._message.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

        public function clearMessageAll(param1:Array) : void
        {
            var _loc_4:int = 0;
            if (this._message == null)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.Friend) == false)
            {
                return;
            }
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1[_loc_3]["messageId"];
                _view.friendList.check_receive_message(_loc_4);
                _loc_3++;
            }
            this._messageList = [];
            return;
        }// end function

        public function clearList() : void
        {
            this._messageList = [];
            return;
        }// end function

        public function addSingularMissage(param1:Object) : void
        {
            var _loc_2:Boolean = false;
            var _loc_3:Boolean = false;
            if (this._message == null)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.Friend) == false)
            {
                return;
            }
            if (_view.friendChat.checkPlayerId(param1.playerId))
            {
                return;
            }
            if (param1.isAchievement == false)
            {
                _loc_2 = AllChatLimit.isWordsLimit(param1);
                _loc_3 = AllChatLimit.isShieldPlayerTalk(param1);
                if (_loc_2 || _loc_3 == false)
                {
                    this.clearMessageList = param1.playerId;
                    _view.friendList.check_receive_message(param1.playerId);
                    _view.toolbar.friendMsg(this._messageList.length);
                    return;
                }
            }
            this._message.addSingularMissage = param1;
            if (this._messageList != null)
            {
                this._messageList.push(param1);
            }
            return;
        }// end function

        public function set clearAble(param1:int) : void
        {
            if (this._message == null)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.Friend) == false)
            {
                return;
            }
            this._message.clearAble = param1;
            this.clearMessageList = param1;
            return;
        }// end function

        public function set clearMessageList(param1:int) : void
        {
            var _loc_4:Object = null;
            if (this._messageList == null || this._messageList.length <= 0)
            {
                return;
            }
            var _loc_2:* = this._messageList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._messageList[_loc_3];
                if (_loc_4.playerId == param1)
                {
                    this._messageList.splice(_loc_3, 1);
                    return;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function set additionalHeight(param1:int) : void
        {
            if (this._message == null)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.Friend) == false)
            {
                return;
            }
            this._message.additionalHeight = param1;
            return;
        }// end function

        public function updateDepth(param1:IView) : void
        {
            if (inStage && (param1 as WarView != null || param1 as SuperSportView != null || param1 as SuperSportWarView != null || param1 as StrategyWarView != null || param1 as TakeBibleRoadView != null))
            {
                _popup.addView(this, this._message.content);
            }
            return;
        }// end function

    }
}
