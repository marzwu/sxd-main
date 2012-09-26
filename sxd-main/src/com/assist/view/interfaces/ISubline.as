package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ISubline
    {

        public function ISubline();

        function get content() : Sprite;

        function set onClose(param1:Function) : void;

        function receive(param1:Array, param2:int) : void;

        function set onSendLine(param1:Function) : void;

        function clear() : void;

    }
}
