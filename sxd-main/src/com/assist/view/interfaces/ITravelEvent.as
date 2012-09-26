package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ITravelEvent
    {

        public function ITravelEvent();

        function get content() : MovieClip;

        function set onSureClick(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set getClearIngo(param1:int) : void;

        function set eventInfo(param1:Object) : void;

        function set awardInfo(param1:String) : void;

        function set onAutoClear(param1:Function) : void;

        function close() : void;

        function set visibleIngot(param1:Boolean) : void;

    }
}
