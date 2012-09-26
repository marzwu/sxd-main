package com.assist.view.interfaces
{

    public interface IDuJie extends IContent, IDragTitleBar
    {

        public function IDuJie();

        function init(param1:Object, param2:Object, param3:Array) : void;

        function set onOk(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function get selectRole() : Object;

        function get selectLineup() : int;

    }
}
