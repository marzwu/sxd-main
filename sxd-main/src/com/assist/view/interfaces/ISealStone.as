package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ISealStone
    {

        public function ISealStone();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set onGetDayStone(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function init() : void;

        function render(param1:Object) : void;

    }
}
