package com.assist.view.interfaces
{
    import flash.geom.*;

    public interface IRefiningIconContainer extends IContent
    {

        public function IRefiningIconContainer();

        function set curRoleList(param1:Array) : void;

        function clearByRoleId(param1:int) : void;

        function set onIconClick(param1:Function) : void;

        function updateFav(param1:int, param2:int) : void;

        function set ingotValue(param1:Number) : void;

        function set coinsValue(param1:Number) : void;

        function set onTip(param1:Function) : void;

        function set closeFun(param1:Function) : void;

        function showRune(param1:Boolean) : void;

        function set onOpenRune(param1:Function) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

    }
}
