package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ITip2
    {

        public function ITip2();

        function set oParent(param1:Sprite) : void;

        function set delay(param1:int) : void;

        function show(param1:String, param2:String, param3:int) : void;

        function hide() : void;

        function reposition(param1:Number, param2:Number) : void;

    }
}
