package com.views
{
    import com.assist.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.serverWar.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class ServerWarRecordView extends Base implements IView
    {
        private var _target:IServerWarRecord;
        private var _info:ServerWarInfo;
        private var _updateTime:int = 0;
        private var _linkData:Array;

        public function ServerWarRecordView()
        {
            return;
        }// end function

        public function show() : void
        {
            this._info = _ctrl.serverWar.info;
            if (this._info.statePlayer == Mod_ServerWar_Base.CLOSE)
            {
                _view.serverWarSignUp.show();
            }
            else
            {
                this.get_standings();
            }
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._target != null && this._target.content.stage != null;
        }// end function

        private function loadComplete() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("ServerWarRecord", "MCRecord") as IServerWarRecord;
                this._target.onClose = this.close;
                this._target.onLink = this.onLink;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            if (this.inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            this._target.update(_ctrl.serverWar.dieoutTip, this.rule, _ctrl.serverWar.dieoutWarList);
            return;
        }// end function

        public function update() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._info = _ctrl.serverWar.info;
            this.get_standings();
            return;
        }// end function

        private function onLink(param1:String) : void
        {
            var _loc_2:Array = null;
            var _loc_3:ClickTipList = null;
            this._linkData = param1.split("_");
            if (this._linkData[0] == "war")
            {
                _view.strategyWar.isServerWar = this._info.isCrossService;
                _view.strategyWar.sameServer = this._info.isThisService;
                _view.strategyWar.warType = WarType.ServerWar;
                _view.strategyWar.version = this._linkData[2];
                _view.strategyWar.reportId = int(this._linkData[1]);
                _view.strategyWar.show();
            }
            else if (this._linkData[0] == "player")
            {
                if (_ctrl.player.playerId == int(this._linkData[1]))
                {
                    return;
                }
                _loc_2 = [ServerWarRecordViewLang.See, ServerWarRecordViewLang.Add, ServerWarRecordViewLang.Send, ServerWarRecordViewLang.Talk];
                _loc_3 = new ClickTipList(_loc_2, _loc_2, this.onTextClick);
                setTimeout(_view.tip.iTip.clickToOpen, 50, _loc_3);
            }
            return;
        }// end function

        private function onTextClick(param1:String) : void
        {
            var _loc_2:* = int(this._linkData[1]);
            var _loc_3:* = this._linkData[2];
            if (param1 == ServerWarRecordViewLang.See)
            {
                _view.otherRoleMsg.init(_loc_2, _loc_3);
                _view.otherRoleMsg.show();
            }
            else if (param1 == ServerWarRecordViewLang.Add)
            {
                _view.friendList.addFriend(_loc_3, _loc_2);
            }
            else if (param1 == ServerWarRecordViewLang.Talk)
            {
                this._view.friendChat.get_friendinfo_chatrecord_list(_loc_2);
            }
            else if (param1 == ServerWarRecordViewLang.Send)
            {
                this._view.sendFlower.sendPlayerID = _loc_2;
                this._view.sendFlower.show();
            }
            return;
        }// end function

        public function get rule() : String
        {
            if (this._info.isThisService)
            {
                return ServerWarRecordViewLang.OutRule5;
            }
            return ServerWarRecordViewLang.OutRule3;
        }// end function

        private function get_standings() : void
        {
            _data.call(Mod_ServerWar_Base.get_standings, this.get_standings_back, []);
            return;
        }// end function

        private function get_standings_back() : void
        {
            loadAssets("ServerWarRecord", null, ServerWarRecordViewLang.Talk, false, false, this.loadComplete);
            return;
        }// end function

    }
}
