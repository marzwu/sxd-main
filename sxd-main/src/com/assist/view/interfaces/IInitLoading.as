package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IInitLoading
    {

        public function IInitLoading();

        function get content() : MovieClip;

        function set tip(param1:String) : void;

        function render(param1:String, param2:int) : void;

    }
}
