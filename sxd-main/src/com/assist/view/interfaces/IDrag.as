package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.utils.*;

    public interface IDrag
    {

        public function IDrag();

        function get targets() : Dictionary;

        function set onMouseDown(param1:Function) : void;

        function addTarget(param1:DisplayObject, param2:DisplayObject) : void;

        function removeTarget(param1:DisplayObject) : void;

        function toString() : String;

    }
}
