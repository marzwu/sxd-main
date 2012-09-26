package com.views
{
    import com.*;
    import com.assist.data.mission.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class DreamSectionWarView extends SportWarView
    {
        public var warData:WarData;
        public var aura:int;

        public function DreamSectionWarView() : void
        {
            _type = WarType.DreamSectionWar;
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
                _view.showLoading(DreamSectionWarViewLang.LoadInfo, param3, (param2 + 1), param1);
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

        override protected function createTarget() : void
        {
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.playerId = _ctrl.player.playerId;
            if (this.aura)
            {
                _war.sportAwardText = Lang.sprintf(DreamSectionWarViewLang.Award, "<font color=\"#00ff00\">+" + this.aura + "</font>");
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
