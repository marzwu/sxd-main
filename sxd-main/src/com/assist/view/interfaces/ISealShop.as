package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ISealShop
    {

        public function ISealShop();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function init() : void;

        function renderSealShop(param1:Array) : void;

        function renderJadeInfo(param1:int) : void;

        function set onConvert(param1:Function) : void;

        function setRealmInfo(param1:int, param2:int, param3:Boolean) : void;

        function set onChange(param1:Function) : void;

        function set onOpenRealm(param1:Function) : void;

    }
}
