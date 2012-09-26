package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IPartnersInfo
    {

        public function IPartnersInfo();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function clear() : void;

        function close() : void;

        function getPartnersId(param1:int, param2:String) : void;

    }
}
