package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IArmsGold extends IContent, IDragTitleBar
    {

        public function IArmsGold();

        function set onOk(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onSelect(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function get mcBox() : Sprite;

        function get btnHelp() : DisplayObject;

        function playEffect() : void;

        function initDropList(param1:Array, param2:Object) : void;

    }
}
