package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ITriggerFunction
    {

        public function ITriggerFunction();

        function get content() : MovieClip;

        function newFunction(param1:Array) : void;

        function set onStart(param1:Function) : void;

        function set triggerUrl(param1:String) : void;

        function clear() : void;

    }
}
