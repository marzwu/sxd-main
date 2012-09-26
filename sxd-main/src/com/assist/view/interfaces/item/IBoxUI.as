package com.assist.view.interfaces.item
{
    import flash.display.*;

    public interface IBoxUI extends IContent
    {

        public function IBoxUI();

        function set id(param1:int) : void;

        function get icon() : Sprite;

        function set lock(param1:Boolean) : void;

        function set num(param1:String) : void;

        function set itemName(param1:String) : void;

        function set itemPrice(param1:String) : void;

        function set lockLight(param1:Boolean) : void;

        function set light(param1:Boolean) : void;

    }
}
