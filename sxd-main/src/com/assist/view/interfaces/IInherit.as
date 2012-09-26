package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IInherit
    {

        public function IInherit();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function init(param1:int) : void;

        function clear() : void;

        function set onClose(param1:Function) : void;

        function set onDrugInherit(param1:Function) : void;

        function set onDrugBeInherit(param1:Function) : void;

        function set onInherit(param1:Function) : void;

        function set onRoleInheritChoose(param1:Function) : void;

        function set onRoleBeInheritChoose(param1:Function) : void;

        function set onIngotLevelCheck(param1:Function) : void;

        function set onShwoDialog(param1:Function) : void;

        function renderRoleInheritList(param1:Array) : void;

        function renderRoleBeInheritList(param1:Array) : void;

        function renderRoleCompare(param1:Object, param2:Object, param3:Array) : void;

        function renderInheritSuccess() : void;

    }
}
