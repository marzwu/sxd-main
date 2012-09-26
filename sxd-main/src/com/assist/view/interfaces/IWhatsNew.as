package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IWhatsNew
    {

        public function IWhatsNew();

        function get content() : Sprite;

        function set drag(param1:IDrag) : void;

        function set tip(param1:ITip) : void;

        function set onClose(param1:Function) : void;

        function set onDrama(param1:Function) : void;

        function set data(param1:String) : void;

    }
}
