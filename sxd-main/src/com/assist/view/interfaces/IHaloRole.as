package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IHaloRole
    {

        public function IHaloRole();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onClose(param1:Function) : void;

        function clear() : void;

        function set onTip(param1:Function) : void;

        function set onChange(param1:Function) : void;

        function getButtleData(param1:Object) : void;

        function getButtleList(param1:Array) : void;

    }
}
