package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class AudienceView extends Base implements IView
    {
        private var _Audience:IAudience;

        public function AudienceView()
        {
            return;
        }// end function

        public function show() : void
        {
            _data.call(Mod_Friend_Base.get_listeners, this.renderShow, [1], false);
            return;
        }// end function

        private function get_listeners(param1:int) : void
        {
            _data.call(Mod_Friend_Base.get_listeners, this.getListenersCallBack, [param1]);
            return;
        }// end function

        private function renderShow() : void
        {
            this.loadResource(this.render);
            return;
        }// end function

        private function loadResource(param1:Function) : void
        {
            loadAssets("Audience", param1, AudienceViewLang.AddAudience);
            return;
        }// end function

        private function render() : void
        {
            this._Audience = _view.getAssetsObject("Audience", "Audience") as IAudience;
            _popup.addView(this, this._Audience.content);
            this._Audience.drag = _view.drag.iDrag;
            this._Audience.tip = _view.tip.iTip;
            _view.center(sign, this._Audience.content);
            this.renderList();
            return;
        }// end function

        private function getListenersCallBack() : void
        {
            this._Audience.audienceData = this._ctrl.friend.getListeners;
            return;
        }// end function

        public function set onlineState(param1:Object) : void
        {
            if (this.inStage)
            {
                this._Audience.isOnLine = param1;
            }
            return;
        }// end function

        private function renderList() : void
        {
            this._Audience.audienceData = this._ctrl.friend.getListeners;
            this._Audience.isOpenPk = FunctionType.isOpened(FunctionType.SendFlower);
            this._Audience.onGetAudience = function (param1:int) : void
            {
                get_listeners(param1);
                return;
            }// end function
            ;
            this._Audience.onShowPerson = function (param1:Object) : void
            {
                _view.otherRoleMsg.init(param1.id, param1.name);
                _view.otherRoleMsg.show();
                return;
            }// end function
            ;
            this._Audience.onMoveFriend = function (param1:Object) : void
            {
                _view.friendList.addFriend(param1.name, 0);
                return;
            }// end function
            ;
            this._Audience.onChatShow = function (param1:int) : void
            {
                _view.friendChat.get_friendinfo_chatrecord_list(param1);
                return;
            }// end function
            ;
            this._Audience.onButtleFriend = function (param1:Object) : void
            {
                _view.pkWar.defenderPlayerId = param1.id;
                _view.pkWar.show();
                return;
            }// end function
            ;
            this._Audience.onSendFlower = function (param1:Object) : void
            {
                _view.sendFlower.sendPlayerID = param1.id;
                _view.sendFlower.show();
                return;
            }// end function
            ;
            this._Audience.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            return;
        }// end function

        public function close() : void
        {
            this._Audience.close();
            this._Audience = null;
            Helper.gc();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

    }
}
