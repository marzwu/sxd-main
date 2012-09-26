package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IGoldOilShop
    {

        public function IGoldOilShop();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function init() : void;

        function renderGoldOilShop(param1:Array) : void;

        function renderMyStatePoint(param1:int, param2:int) : void;

        function set onConvert(param1:Function) : void;

    }
}
