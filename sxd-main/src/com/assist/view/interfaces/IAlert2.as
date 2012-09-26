package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IAlert2
    {

        public function IAlert2();

        function set oParent(param1:Sprite) : void;

        function set onClose(param1:Function) : void;

        function show(param1:String) : void;

        function hide() : void;

        function reposition(param1:Number, param2:Number) : void;

    }
}
