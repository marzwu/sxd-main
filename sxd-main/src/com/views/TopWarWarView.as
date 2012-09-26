package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class TopWarWarView extends SportWarView
    {
        public var warData:WarData;

        public function TopWarWarView() : void
        {
            _type = WarType.TopWarWar;
            return;
        }// end function

        override public function show() : void
        {
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
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
                _view.showLoading(TopWarWarViewLang.LoadInfo, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            loadResources();
            return;
        }// end function

        override protected function loadRoleResource() : void
        {
            _warData = this.warData;
            super.loadRoleResource();
            return;
        }// end function

        override protected function getStudyStuntPlayerIds() : Array
        {
            var _loc_5:int = 0;
            var _loc_1:* = _ctrl.topWar.playerIdList;
            var _loc_2:Array = [];
            var _loc_3:* = _loc_1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_1[_loc_4];
                _loc_2.push([_loc_5]);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        override protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            param1.push("WarIcon");
            param2.push(URI.mapUrl + "top_war/top_war.png");
            param1.push("Background");
            param2.push(URI.mapUrl + "top_war/top_war.swf");
            param1.push("Aura");
            param2.push(URI.effectsUrl + "aura.swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.background = background;
            _war.sportAwardText = "";
            _war.equitData = _ctrl.topWar.equitData;
            _war.leaderId = _ctrl.topWar.leaderId;
            _war.warData = _warData;
            if (_ctrl.topWar.warCoin || _ctrl.topWar.warFame || _ctrl.topWar.awardScore || _ctrl.topWar.awardWinScore)
            {
                _war.sportAwardText = Lang.sprintf(TopWarWarViewLang.Award, _ctrl.topWar.warCoin ? (TopWarWarViewLang.coin + HtmlText.yellow("+" + _ctrl.topWar.warCoin)) : (""), _ctrl.topWar.warFame ? (TopWarWarViewLang.fame + HtmlText.green("+" + _ctrl.topWar.warFame)) : (""), _ctrl.topWar.awardScore ? (TopWarWarViewLang.awardScore + HtmlText.green("+" + _ctrl.topWar.awardScore)) : (""), _ctrl.topWar.awardWinScore ? (TopWarWarViewLang.awardWinScore + HtmlText.green("+" + _ctrl.topWar.awardWinScore)) : (""));
            }
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
