package com.views
{
    import com.assist.view.interfaces.*;
    import com.assist.view.standaloneChat.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;

    public class StandaloneChatView extends Base implements IView
    {
        private var _chat:IChat;
        private var _type:int;
        private var _parent:Sprite;
        private var _relatedView:IView;
        private var _onSend:Function;
        public var channelId:int;

        public function StandaloneChatView()
        {
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._chat && this._chat.content.parent;
        }// end function

        public function show() : void
        {
            loadAssets("Chat", this.render, StandaloneChatViewLang.LoadInfo, true, true);
            return;
        }// end function

        public function sendChatCallBack() : void
        {
            return;
        }// end function

        public function render() : void
        {
            if (this._relatedView == null)
            {
                return;
            }
            this._chat = _view.getAssetsObject("Chat", "Chat") as IChat;
            this._parent.addChild(this._chat.content);
            this._chat.tip = _view.tip.iTip;
            this._chat.content.x = 1;
            this._chat.content.y = 600 - 187;
            this._chat.onSendChat = function (param1:Object) : void
            {
                param1.channelId = 10000 + _ctrl.multiMission.multiWarData.multipleTeamId;
                _view.chat.chat_with_players(param1, sendChatCallBack);
                return;
            }// end function
            ;
            this._chat.onTextLink = function (event:TextEvent) : void
            {
                return;
            }// end function
            ;
            _view.chat.patchChat(this.broToPlayerCallBack);
            this._chat.visibleFunction = 0;
            this.initSystemMsg();
            return;
        }// end function

        private function initSystemMsg() : void
        {
            var _loc_1:String = "<font color=\"#FFF100\">";
            switch(this._type)
            {
                case StandaloneChatType.MultiWar:
                {
                    _loc_1 = _loc_1 + StandaloneChatViewLang.WelcomeMulti;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_1 = _loc_1 + "</font>";
            this.sendInfo(_loc_1);
            return;
        }// end function

        public function open(param1:IView, param2:Sprite, param3:Function, param4:int) : void
        {
            this._relatedView = param1;
            this._parent = param2;
            this._onSend = param3;
            this._type = param4;
            this.show();
            return;
        }// end function

        public function broToPlayerCallBack() : void
        {
            var _loc_1:* = this._ctrl.chat.message;
            this._chat.getChatData = _loc_1;
            return;
        }// end function

        public function receiveSysMsg(param1:String) : void
        {
            this.sendInfo(param1);
            return;
        }// end function

        private function sendInfo(param1:String) : void
        {
            this._chat.addMainShow(param1, Mod_Chat_Base.ACTIVITY, true);
            return;
        }// end function

        private function get typeName() : String
        {
            var _loc_1:String = null;
            switch(this._type)
            {
                case StandaloneChatType.MultiWar:
                {
                    _loc_1 = StandaloneChatViewLang.War;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            _view.chat.resetPatchChat();
            if (this.inStage)
            {
                this._chat.content.parent.removeChild(this._chat.content);
            }
            this._parent = null;
            this._relatedView = null;
            return;
        }// end function

        public function reposition() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._chat.content.y = Structure.stageHeight - 187;
            return;
        }// end function

    }
}
