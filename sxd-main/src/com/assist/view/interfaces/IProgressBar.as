package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IProgressBar
    {

        public function IProgressBar();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function show(param1:String, param2:int, param3:Function) : void;

        function clear() : void;

    }
}
