package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface IProcessTips
    {

        public function IProcessTips();

        function get content() : Sprite;

        function set visible(param1:Boolean) : void;

        function set oParent(param1:Sprite) : void;

        function set onClose(param1:Function) : void;

        function set onAction(param1:Function) : void;

        function render(param1:Object) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

    }
}
