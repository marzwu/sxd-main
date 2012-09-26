package com.views
{
    import com.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class InCampWarView extends SportWarView
    {
        public var auto:Boolean;

        public function InCampWarView() : void
        {
            _type = WarType.CampWar;
            return;
        }// end function

        override public function show() : void
        {
            removeWar();
            super.show();
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(InCampWarViewLang.LoadInfo, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            if (this._ctrl.heroesWar.getWarMode["mode"] == 0)
            {
                _data.call(Mod_CampWar_Base.get_war_result, loadResources, []);
            }
            else
            {
                _data.call(Mod_HeroesWar_Base.get_war_result, loadResources, []);
            }
            return;
        }// end function

        override protected function loadRoleResource() : void
        {
            if (this._ctrl.heroesWar.getWarMode["mode"] == 0)
            {
                _warData = _ctrl.campWar.warResult;
            }
            else
            {
                _warData = _ctrl.heroesWar.warResult;
            }
            super.loadRoleResource();
            return;
        }// end function

        override protected function createTarget() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.playerId = _ctrl.player.playerId;
            _war.autoWar = this.auto;
            if (this._ctrl.heroesWar.getWarMode["mode"] == 0)
            {
                _war.sportDetailData = _ctrl.campWar.warDetail;
                _loc_1 = _ctrl.campWar.awardCoin;
                _loc_2 = _ctrl.campWar.awardFame;
            }
            else
            {
                _war.sportDetailData = _ctrl.heroesWar.warDetail;
                _loc_1 = _ctrl.heroesWar.awardCoin;
                _loc_2 = _ctrl.heroesWar.awardFame;
            }
            var _loc_3:String = "";
            if (_loc_2 > 0 && _loc_1 > 0)
            {
                _loc_3 = Lang.sprintf(InCampWarViewLang.AwardFameCoin, "<font color=\"#00ff00\">+" + _loc_2 + "</font>", "<font color=\"#00ff00\">+" + _loc_1 + "</font>");
            }
            else if (_loc_2 > 0 && _loc_1 == 0)
            {
                _loc_3 = Lang.sprintf(InCampWarViewLang.AwardFame, "<font color=\"#00ff00\">+" + _loc_2 + "</font>");
            }
            else if (_loc_2 == 0 && _loc_1 > 0)
            {
                _loc_3 = Lang.sprintf(InCampWarViewLang.AwardfCoin, "<font color=\"#00ff00\">+" + _loc_1 + "</font>");
            }
            else
            {
                _loc_3 = InCampWarViewLang.NonAward;
            }
            _war.sportAwardText = _loc_3;
            return;
        }// end function

    }
}
