package com.controllers
{

    public class InheritController extends Base
    {

        public function InheritController()
        {
            return;
        }// end function

        public function get roleList() : Array
        {
            return this._data.inherit.roleList;
        }// end function

        public function get roleAttribute() : Object
        {
            return this._data.inherit.roleAttribute;
        }// end function

        public function get attributeAfterInherit() : Array
        {
            return this._data.inherit.attributeAfterInherit;
        }// end function

        public function get inherit() : Object
        {
            return this._data.inherit.roleInherit;
        }// end function

    }
}
