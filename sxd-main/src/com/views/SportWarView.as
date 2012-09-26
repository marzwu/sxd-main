package com.views
{
    import com.assist.*;
    import com.assist.view.war.*;

    public class SportWarView extends WarView implements IView
    {
        public var defenderPlayerId:int;

        public function SportWarView() : void
        {
            _type = WarType.SportWar;
            return;
        }// end function

        override public function show() : void
        {
            if (_view.multiMission.inStageWithTip)
            {
                return;
            }
            if (_view.multiMission.isMinimumWithTip)
            {
                return;
            }
            if (WarType.CampWar != _type && _view.campWar.inStageWithTip)
            {
                return;
            }
            if (WarType.WorldBossWar != _type && _view.worldBossMap.inStageWithTip)
            {
                return;
            }
            isLastMonster = false;
            this.start();
            return;
        }// end function

        protected function start() : void
        {
            onClose = function (param1:Boolean) : void
            {
                _popup.removeMask();
                return;
            }// end function
            ;
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading("", param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            _popup.addMask();
            return;
        }// end function

        override protected function loadRoleResource() : void
        {
            super.loadRoleResource();
            return;
        }// end function

        override protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            param1.push("WarIcon");
            param2.push(URI.sportUrl + "war_icon.png");
            param1.push("Background");
            param2.push(URI.sportUrl + (Math.floor(Math.random() * 4) + 1) + ".swf");
            return;
        }// end function

        protected function removeWar() : void
        {
            if (_war)
            {
                _war.close();
                closeWar();
            }
            return;
        }// end function

        protected function myself(param1:int) : Boolean
        {
            if (_ctrl.player.playerId == param1)
            {
                _view.showTip("不能与自己对战");
                return true;
            }
            return false;
        }// end function

    }
}
