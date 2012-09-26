package com.datas
{

    public class LuckyWheelData extends Base
    {
        private var _openInfo:Array;
        private var _cardInfo:Array;
        private var _runInfo:Array;

        public function LuckyWheelData()
        {
            return;
        }// end function

        public function get state() : int
        {
            return this._openInfo[0];
        }// end function

        public function get openInfo() : Object
        {
            var _loc_1:Object = {};
            _loc_1.faction_today_con = this._openInfo[1];
            _loc_1.rosefinch_number = this._openInfo[2];
            return _loc_1;
        }// end function

        public function get runState() : int
        {
            return this._runInfo[0];
        }// end function

        public function get runInfo() : Object
        {
            var _loc_1:Object = {};
            _loc_1.type = this._runInfo[1];
            _loc_1.rosefinch_number = this._runInfo[2];
            _loc_1.item_id = this._runInfo[3];
            return _loc_1;
        }// end function

        public function open_lucky_wheel(param1:Array) : void
        {
            this._openInfo = param1;
            return;
        }// end function

        public function start_lucky_wheel(param1:Array) : void
        {
            this._runInfo = param1;
            return;
        }// end function

    }
}
