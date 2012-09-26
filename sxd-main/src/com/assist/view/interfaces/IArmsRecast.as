package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IArmsRecast extends IContent, IDragTitleBar
    {

        public function IArmsRecast();

        function initdropList1(param1:Array, param2:Object) : void;

        function initdropList2(param1:Array, param2:Object) : void;

        function set onSelect1(param1:Function) : void;

        function set onSelect2(param1:Function) : void;

        function set onOk(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function runAction() : void;

        function get box1() : Sprite;

        function get box2() : Sprite;

    }
}
