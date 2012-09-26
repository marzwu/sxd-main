package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IStrategy
    {

        public function IStrategy();

        function get content() : MovieClip;

        function set showStrategyWar(param1:Function) : void;

        function set drag(param1:IDrag) : void;

        function set onClose(param1:Function) : void;

        function clear() : void;

        function renderPlayerList(param1:Array, param2:String) : void;

    }
}
