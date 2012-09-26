package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IChooseCamp
    {

        public function IChooseCamp();

        function get content() : MovieClip;

        function set onGotoTown(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function close() : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

    }
}
