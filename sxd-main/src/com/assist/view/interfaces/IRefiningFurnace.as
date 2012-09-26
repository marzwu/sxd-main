package com.assist.view.interfaces
{
    import com.assist.view.interfaces.item.*;
    import flash.display.*;

    public interface IRefiningFurnace extends IDragTitleBar
    {

        public function IRefiningFurnace();

        function get content() : MovieClip;

        function onClose(param1:Function) : void;

        function getPageBox() : IBoxUI;

        function set dropList(param1:Array) : void;

        function set onRefining(param1:Function) : void;

        function set playerLv(param1:int) : void;

        function set boxItemId(param1:int) : void;

        function set onTip(param1:Function) : void;

        function set produceItems(param1:Array) : void;

        function set vipLevel(param1:int) : void;

        function onSetCookie(param1:Function) : void;

        function onGetCookie(param1:Function) : void;

        function set purpleRoleList(param1:Array) : void;

    }
}
