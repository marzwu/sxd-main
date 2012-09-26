package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IFateInfo
    {

        public function IFateInfo();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onClose(param1:Function) : void;

        function getPlayerLevel(param1:int, param2:Boolean) : void;

        function set getFragmentNum(param1:int) : void;

        function set onExchange(param1:Function) : void;

        function init() : void;

        function clear() : void;

    }
}
