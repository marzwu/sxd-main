package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IVip
    {

        public function IVip();

        function get content() : Sprite;

        function set drag(param1:IDrag) : void;

        function info(param1:String, param2:String, param3:String) : void;

        function set onClose(param1:Function) : void;

        function set onRecharge(param1:Function) : void;

        function set onShowVIPInfo(param1:Function) : void;

        function renderProgressBar(param1:int, param2:int, param3:int) : void;

        function clear() : void;

        function set showFirstPayBtn(param1:Boolean) : void;

        function set showOnePayBtn(param1:Boolean) : void;

    }
}
