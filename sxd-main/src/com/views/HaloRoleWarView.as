package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class HaloRoleWarView extends SportWarView
    {
        public var warData:WarData;
        public var aura:int;

        public function HaloRoleWarView() : void
        {
            _type = WarType.HaloRoleWar;
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
                _view.showLoading(HaloRoleWarViewLang.LoadInfo, param3, (param2 + 1), param1);
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
            param2.push(URI.mapUrl + "halo_role/war_icon.png");
            param1.push("Background");
            param2.push(URI.mapUrl + "halo_role/" + (Math.floor(Math.random() * 3) + 1) + ".swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.playerId = _ctrl.player.playerId;
            if (this.aura)
            {
                _war.sportAwardText = Lang.sprintf(HaloRoleWarViewLang.Award, "<font color=\"#00ff00\">+" + this.aura + "</font>");
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
