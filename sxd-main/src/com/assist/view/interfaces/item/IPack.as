package com.assist.view.interfaces.item
{
    import flash.display.*;

    public interface IPack extends IContent, IBoxPack, IDragTitleBar
    {

        public function IPack();

        function set onClose(param1:Function) : void;

        function set onBtn1(param1:Function) : void;

        function set onBtn2(param1:Function) : void;

        function set onBtn3(param1:Function) : void;

        function get Btn1() : DisplayObject;

        function get Btn2() : DisplayObject;

        function get Btn3() : DisplayObject;

        function get BtnClose() : DisplayObject;

        function updateBoxCount(param1:int) : void;

    }
}
