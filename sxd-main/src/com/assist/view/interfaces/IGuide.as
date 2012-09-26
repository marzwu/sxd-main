package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IGuide
    {

        public function IGuide();

        function get content() : Sprite;

        function set text(param1:String) : void;

        function set dir(param1:String) : void;

        function set x(param1:Number) : void;

        function set y(param1:Number) : void;

        function set onClick(param1:Function) : void;

        function clear() : void;

    }
}
