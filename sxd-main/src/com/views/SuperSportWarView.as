package com.views
{
    import com.*;
    import com.assist.data.mission.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class SuperSportWarView extends SportWarView
    {
        public var awardFame:int;
        public var awardCoin:int;
        public var warData:WarData;
        public var reportId:int;
        public var detail:Object;

        public function SuperSportWarView() : void
        {
            _type = WarType.SuperSportWar;
            return;
        }// end function

        override public function show() : void
        {
            if (myself(defenderPlayerId))
            {
                return;
            }
            super.show();
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(SuperSportWarViewLang.LoadInfo, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            loadResources();
            return;
        }// end function

        override protected function loadRoleResource() : void
        {
            _warData = this.warData;
            _warData.reportId = this.reportId;
            super.loadRoleResource();
            return;
        }// end function

        override protected function createTarget() : void
        {
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.playerId = _ctrl.player.playerId;
            _war.sportDetailData = this.detail;
            if (this.awardCoin || this.awardFame)
            {
                _war.sportAwardText = Lang.sprintf(SuperSportWarViewLang.Award, "<font color=\"#00ff00\">" + this.awardCoin + "</font>", "<font color=\"#00ff00\">" + this.awardFame + "</font>");
            }
            _popup.removeMask();
            return;
        }// end function

        override protected function onCloseHandler(param1:Boolean) : void
        {
            clearRoles();
            closeWar();
            if (onClose is Function)
            {
                onClose(param1);
            }
            return;
        }// end function

    }
}
