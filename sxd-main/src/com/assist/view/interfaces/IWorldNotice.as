package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IWorldNotice
    {

        public function IWorldNotice();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function show(param1:String, param2:int) : void;

    }
}
