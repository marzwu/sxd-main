package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import flash.events.*;

    public class TakeBibleWarView extends SportWarView
    {
        public var awardFame:int;
        public var awardCoin:int;
        public var warData:WarData;
        public var reportId:int;
        public var detail:Object;

        public function TakeBibleWarView() : void
        {
            _type = WarType.TakeBibleWar;
            return;
        }// end function

        override public function show() : void
        {
            super.show();
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(TakeBibleWarViewLang.LoadInfo, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            _popup.addMask();
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

        override protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            param1.push("WarIcon");
            param2.push(URI.mapUrl + "take_bible/war_icon.png");
            param1.push("Background");
            param2.push(URI.mapUrl + "take_bible/1.swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.playerId = _ctrl.player.playerId;
            _war.sportDetailData = this.detail;
            _war.onSportDetailLink = _view.toolbar.onTextLink;
            if (this.awardCoin || this.awardFame)
            {
                _war.sportAwardText = Lang.sprintf(TakeBibleWarViewLang.Award, "<font color=\"#00ff00\">" + this.awardCoin + "</font>", "<font color=\"#00ff00\">" + this.awardFame + "</font>");
            }
            return;
        }// end function

        private function onSportDetailLink(event:TextEvent) : void
        {
            return;
        }// end function

    }
}
