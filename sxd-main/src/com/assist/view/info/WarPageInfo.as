package com.assist.view.info
{

    public class WarPageInfo extends Object
    {
        private var _enemyList:Array;
        public var _totalGetPrestige:int;

        public function WarPageInfo()
        {
            this._enemyList = new Array();
            return;
        }// end function

        public function set enemyList(param1:Array) : void
        {
            this._enemyList = param1;
            return;
        }// end function

        public function get enemyList() : Array
        {
            return this._enemyList.concat();
        }// end function

    }
}
