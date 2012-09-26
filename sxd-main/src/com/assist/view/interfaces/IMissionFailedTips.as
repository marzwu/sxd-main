package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface IMissionFailedTips
    {

        public function IMissionFailedTips();

        function get content() : MovieClip;

        function clear() : void;

        function set onClose(param1:Function) : void;

        function renderImages(param1:Array, param2:Array) : void;

        function set onFunctionOpen(param1:Function) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

    }
}
