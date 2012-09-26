package com.views
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class TowerWarView extends SportWarView
    {
        public var warData:WarData;
        public var autoSellL:Boolean = false;
        public var autoSellZ:Boolean = false;

        public function TowerWarView() : void
        {
            _type = WarType.TowerWar;
            isBoss = true;
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(TowerWarViewLang.LoadInfo, param3, (param2 + 1), param1);
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
            param2.push(URI.mapUrl + "tower/war_icon.png");
            param1.push("Background");
            param2.push(URI.sportUrl + (Math.floor(Math.random() * 3) + 1) + ".swf");
            param1.push("Aura");
            param2.push(URI.effectsUrl + "aura.swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            var _loc_3:uint = 0;
            var _loc_4:int = 0;
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.background = background;
            _war.sportDetailData = {attackerInspire:_ctrl.worldBossMap.combatBuff};
            var _loc_1:String = "";
            if (_ctrl.tower.warExp > 0)
            {
                _loc_1 = TowerWarViewLang.Exp + HtmlText.green("+" + _ctrl.tower.warExp) + "  ";
            }
            if (_ctrl.tower.warFame > 0)
            {
                _loc_1 = _loc_1 + TowerWarViewLang.Fame + HtmlText.green("+" + _ctrl.tower.warFame) + "  ";
            }
            if (_ctrl.tower.warCoin > 0)
            {
                _loc_1 = _loc_1 + TowerWarViewLang.Coin + HtmlText.green("+" + _ctrl.tower.warCoin) + "  ";
            }
            if (_ctrl.tower.warAura > 0)
            {
                _loc_1 = _loc_1 + TowerWarViewLang.Aura + HtmlText.green("+" + _ctrl.tower.warAura) + "  ";
            }
            var _loc_2:* = _ctrl.tower.warSoulId;
            if (_loc_2 > 0)
            {
                _loc_3 = SoulType.getQualityColor(SoulType.getSoulQualityId(_loc_2));
                _loc_1 = _loc_1 + TowerWarViewLang.Soul + "<font color=\"#" + _loc_3.toString(16) + "\">" + SoulType.getSoulName(_loc_2) + "</font>";
                _loc_4 = SoulType.getSoulQualityId(_loc_2);
                if (_loc_4 == 1 && this.autoSellL || _loc_4 == 2 && this.autoSellZ)
                {
                    _loc_1 = _loc_1 + HtmlText.yellow2("(" + TowerWarViewLang.Sell + ")");
                }
            }
            _war.sportAwardText = _loc_1;
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
