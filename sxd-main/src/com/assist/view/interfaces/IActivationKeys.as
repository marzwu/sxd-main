package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IActivationKeys
    {

        public function IActivationKeys();

        function get content() : Sprite;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set nickName(param1:String) : void;

        function set url(param1:String) : void;

        function set webDomain(param1:String) : void;

        function set onSuccess(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onDebug(param1:Function) : void;

        function init() : void;

        function clear() : void;

    }
}
