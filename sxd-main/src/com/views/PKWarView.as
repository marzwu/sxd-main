package com.views
{
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class PKWarView extends SportWarView
    {

        public function PKWarView() : void
        {
            _type = WarType.PKWar;
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
            onClose = function (param1:Boolean) : void
            {
                _popup.removeMask();
                return;
            }// end function
            ;
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(PKWarViewLang.LoadInfo, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            var handler:* = function (param1:Boolean) : void
            {
                if (param1 == false)
                {
                    _popup.addMask();
                    _data.call(Mod_Pk_Base.start_war, loadResources, [defenderPlayerId]);
                }
                return;
            }// end function
            ;
            _view.toolbar.checkWarCdTime(handler);
            return;
        }// end function

        override protected function loadRoleResource() : void
        {
            _warData = _ctrl.pkWar.warData;
            _warData.reportId = _ctrl.pkWar.reportId;
            super.loadRoleResource();
            return;
        }// end function

        override protected function createTarget() : void
        {
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.sportAwardText = "";
            return;
        }// end function

        public function test() : void
        {
            _view.pkWar.defenderPlayerId = 45;
            _view.pkWar.show();
            return;
        }// end function

    }
}
