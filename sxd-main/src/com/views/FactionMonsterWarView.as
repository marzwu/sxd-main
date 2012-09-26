package com.views
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class FactionMonsterWarView extends SportWarView
    {
        public var warData:WarData;
        public var bInStage:Boolean;

        public function FactionMonsterWarView() : void
        {
            _type = WarType.FactionMonsterWar;
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
            this.bInStage = true;
            super.show();
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(FactionMonsterWarViewLang.LoadInfo, param3, (param2 + 1), param1);
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

        override protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            param1.push("WarIcon");
            param2.push(URI.mapUrl + "faction_monster/faction_monster.png");
            param1.push("Background");
            param2.push(URI.mapUrl + "faction_monster/" + (Math.floor(Math.random() * 4) + 1) + ".swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            var _loc_1:String = null;
            var _loc_2:String = null;
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.background = background;
            if (_ctrl.factionMonster.awardCoin > 0 || _ctrl.factionMonster.awardExperience > 0)
            {
                _loc_1 = _ctrl.factionMonster.awardCoin > 0 ? (FactionMonsterWarViewLang.Coin + " " + HtmlText.green("+" + _ctrl.factionMonster.awardCoin)) : ("");
                _loc_2 = _ctrl.factionMonster.awardExperience > 0 ? (FactionMonsterWarViewLang.JingYan + " " + HtmlText.green("+" + _ctrl.factionMonster.awardExperience)) : ("");
                _war.sportAwardText = FactionMonsterWarViewLang.Award + "：" + _loc_1 + " " + _loc_2;
            }
            return;
        }// end function

        override protected function onCloseHandler(param1:Boolean) : void
        {
            this.bInStage = false;
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
