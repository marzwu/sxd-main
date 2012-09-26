package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IPanelLoading
    {

        public function IPanelLoading();

        function get content() : MovieClip;

        function setLoadingProgress(param1:int, param2:int = 1, param3:int = 1) : void;

        function setLoadingText(param1:String) : void;

        function init() : void;

    }
}
