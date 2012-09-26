package com.datas
{

    public class RollCakeData extends Base
    {
        private var _rollData:Array;
        private var _addCount:Array;
        private var _getCount:Array;
        private var _rerollData:Array;
        private var _getAward:Array;
        public var getState:Array;
        public var isAuto:Array;
        public var setAuto:Array;

        public function RollCakeData()
        {
            return;
        }// end function

        public function get rollData() : Array
        {
            return this._rollData;
        }// end function

        public function get addCount() : Array
        {
            return this._addCount;
        }// end function

        public function get getCount() : Array
        {
            return this._getCount;
        }// end function

        public function get rerollData() : Array
        {
            return this._rerollData;
        }// end function

        public function get getAward() : Array
        {
            return this._getAward;
        }// end function

        public function roll(param1:Array) : void
        {
            this._rollData = param1;
            return;
        }// end function

        public function add_count(param1:Array) : void
        {
            this._addCount = param1;
            return;
        }// end function

        public function get_count(param1:Array) : void
        {
            this._getCount = param1;
            return;
        }// end function

        public function reroll(param1:Array) : void
        {
            this._rerollData = param1;
            return;
        }// end function

        public function get_award(param1:Array) : void
        {
            this._getAward = param1;
            return;
        }// end function

        public function get_state(param1:Array) : void
        {
            this.getState = param1;
            return;
        }// end function

        public function is_auto(param1:Array) : void
        {
            this.isAuto = param1;
            return;
        }// end function

        public function set_auto(param1:Array) : void
        {
            this.setAuto = param1;
            return;
        }// end function

    }
}
