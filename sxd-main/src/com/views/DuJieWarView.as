﻿package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class DuJieWarView extends SportWarView
    {
        public var warData:WarData;

        public function DuJieWarView() : void
        {
            _type = WarType.DuJieWar;
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(DuJieWarViewLang.LoadInfo, param3, (param2 + 1), param1);
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
            param2.push(URI.mapUrl + "dujie/dujie.png");
            param1.push("Background");
            param2.push(URI.mapUrl + "dujie/dujie.swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            var _loc_1:String = null;
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.background = background;
            _war.sportDetailData = {attackerInspire:_ctrl.worldBossMap.combatBuff};
            if (_ctrl.dujie.addHealth)
            {
                _loc_1 = _ctrl.dujie.roleId == _ctrl.player.mainRoleId ? (_ctrl.player.nickname) : (RoleType.getRoleName(_ctrl.dujie.roleId));
                _war.sportAwardText = Lang.sprintf(DuJieWarViewLang.Award, _loc_1, HtmlText.green("+" + _ctrl.dujie.addHealth), "<font color=\"#" + DuJieType.getSpiritColor(_ctrl.dujie.spiritStateId).toString(16) + "\">" + DuJieType.getSpiritName(_ctrl.dujie.spiritStateId) + DuJieType.getSpiritLevelInfo(_ctrl.dujie.spiritStateLevel) + "</font>", _ctrl.dujie.awardAura ? (DuJieWarViewLang.Aura + HtmlText.green("+" + _ctrl.dujie.awardAura)) : (""));
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
