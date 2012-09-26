package com.assist.view.interfaces
{
    import com.assist.view.info.*;

    public interface ITower extends IContent, IDragTitleBar
    {

        public function ITower();

        function initData(param1:TowerInfo) : void;

        function updateInfo(param1:int = 0) : void;

        function set onWar(param1:Function) : void;

        function set onAuto(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onReset(param1:Function) : void;

        function set onStop(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function set onGoToNext(param1:Function) : void;

        function set onTownClick(param1:Function) : void;

        function set hideTowerVisible(param1:Boolean) : void;

        function get autoSellL() : Boolean;

        function get autoSellZ() : Boolean;

    }
}
