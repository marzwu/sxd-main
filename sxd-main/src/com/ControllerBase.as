package com
{

    public class ControllerBase extends SuperBase
    {
        protected var _data:Data;
        protected var _lang:Lang;

        public function ControllerBase()
        {
            return;
        }// end function

        public function get lang() : Lang
        {
            return this._lang;
        }// end function

        public function init(param1:Data, param2:Lang) : void
        {
            this._data = param1;
            this._lang = param2;
            return;
        }// end function

        protected function createObject(param1:Class, param2:String = "") : Object
        {
            param2 = param1 + "";
            param2 = param2.replace(/Controller\]$""Controller\]$/, "");
            return createObjectBase(param1, param2, null, this as Controller, this._data);
        }// end function

    }
}
