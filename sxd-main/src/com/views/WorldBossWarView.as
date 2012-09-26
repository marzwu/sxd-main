package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class WorldBossWarView extends SportWarView
    {
        public var worldBossId:int;
        public var warData:WarData;

        public function WorldBossWarView() : void
        {
            _type = WarType.WorldBossWar;
            isBoss = true;
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
                _view.showLoading(WorldBossWarViewLang.LoadInfo, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            _popup.addMask();
            showEffect();
            loadMainRoleResource(this.showWarScene);
            return;
        }// end function

        private function showWarScene() : void
        {
            loadResources1(this.warData);
            return;
        }// end function

        override protected function getMonsterResources() : void
        {
            return;
        }// end function

        override protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            var _loc_3:* = TownType.getSign(WorldBossType.getTownIdByBossId(this.worldBossId));
            var _loc_4:* = _loc_3;
            _loc_4 = MonsterType.sameResource(_loc_4);
            param1.push("WarIcon");
            param2.push(URI.worldBossUrl + "war_icon_" + _loc_4 + ".png");
            param1.push("WorldBossMomentum");
            param2.push(URI.effectsUrl + "WorldBossMomentum.swf");
            var _loc_5:Array = [_loc_4];
            getRoleResources(_loc_5, _loc_5, true);
            return;
        }// end function

        override protected function createTarget() : void
        {
            var _loc_6:String = null;
            _view.hideLoading();
            _war = new _cWar();
            _war.warData = _warData;
            _war.background = background;
            _war.playerId = _ctrl.player.playerId;
            _war.sportDetailData = {attackerInspire:_ctrl.worldBossMap.combatBuff};
            var _loc_1:* = _ctrl.worldBossMap.awards;
            var _loc_2:* = _loc_1["coin"];
            var _loc_3:* = _loc_1["exp"];
            var _loc_4:* = _loc_1["fame"];
            var _loc_5:* = _loc_1["hurt"];
            if (_loc_2 || _loc_3 || _loc_4 || _loc_5)
            {
                _loc_6 = "";
                if (_loc_5 > 0)
                {
                    _loc_6 = Lang.sprintf(WorldBossWarViewLang.Hurt, "<font color=\"#eb6100\">" + _loc_5 + "</font>") + "  ";
                }
                if (_loc_4 > 0 && _loc_2 > 0)
                {
                    _loc_6 = _loc_6 + (Lang.sprintf(WorldBossWarViewLang.Fame, "<font color=\"#00ff00\">+" + _loc_4 + "</font>") + "   " + Lang.sprintf(WorldBossWarViewLang.Coin, "<font color=\"#00ff00\">+" + _loc_2 + "</font>"));
                }
                else if (_loc_4 > 0 && _loc_2 == 0)
                {
                    _loc_6 = _loc_6 + (Lang.sprintf(WorldBossWarViewLang.Fame, "<font color=\"#00ff00\">+" + _loc_4 + "</font>") + "  " + WorldBossWarViewLang.CoinFull);
                }
                else if (_loc_4 == 0 && _loc_2 > 0)
                {
                    _loc_6 = _loc_6 + (Lang.sprintf(WorldBossWarViewLang.Coin, "<font color=\"#00ff00\">+" + _loc_2 + "</font>") + "  " + WorldBossWarViewLang.FameFull);
                }
                else
                {
                    _loc_6 = _loc_6 + WorldBossWarViewLang.FameCoinFull;
                }
                _war.sportAwardText = _loc_6;
            }
            return;
        }// end function

        override protected function onCloseHandler(param1:Boolean) : void
        {
            closeWar();
            if (onClose is Function)
            {
                onClose(param1);
            }
            return;
        }// end function

    }
}
