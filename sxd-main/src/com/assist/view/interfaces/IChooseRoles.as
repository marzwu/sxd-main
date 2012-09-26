package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IChooseRoles
    {

        public function IChooseRoles();

        function get content() : Sprite;

        function set tip(param1:ITip) : void;

        function set onStart(param1:Function) : void;

        function set error(param1:String) : void;

        function init(param1:int, param2:int, param3:int, param4:int) : void;

        function clear() : void;

    }
}
