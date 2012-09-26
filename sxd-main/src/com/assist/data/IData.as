package com.assist.data
{

    public interface IData
    {

        public function IData();

        function call(param1:Object, param2:Function, param3:Array, param4:Boolean = true) : void;

        function patch(param1:Object, param2:Function) : void;

        function cancelPatch(param1:Object) : void;

        function set onClose(param1:Function) : void;

        function close() : void;

    }
}
