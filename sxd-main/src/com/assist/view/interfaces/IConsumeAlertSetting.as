package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IConsumeAlertSetting
    {

        public function IConsumeAlertSetting();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function init() : void;

        function clear() : void;

        function render(param1:Array) : void;

        function renderSubmit() : void;

        function set onClose(param1:Function) : void;

        function set onSubmit(param1:Function) : void;

    }
}
