package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IPreventIndulge
    {

        public function IPreventIndulge();

        function get content() : MovieClip;

        function set onCloseBtn(param1:Function) : void;

        function clear() : void;

        function render(param1:int) : void;

        function renderOkBtn(param1:String) : void;

        function get identity() : String;

        function set onOkBtn(param1:Function) : void;

    }
}
