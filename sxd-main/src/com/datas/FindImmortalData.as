package com.datas
{

    public class FindImmortalData extends Base
    {
        private var _open:Array;
        private var _start:Array;
        private var _goad:Array;
        private var _award:Array;
        private var _flagNum:int;

        public function FindImmortalData()
        {
            return;
        }// end function

        public function get openFindImmortal() : Object
        {
            var _loc_1:Object = {};
            _loc_1.can_buy_number = this._open[0];
            _loc_1.award = this.renderAward(this._open);
            _loc_1.state = this._open[3];
            _loc_1.imgId = this._open[4];
            return _loc_1;
        }// end function

        public function get start() : Object
        {
            var _loc_1:Object = {};
            _loc_1.type = this._start[0];
            _loc_1.award = this.renderAward(this._start);
            _loc_1.state = this._start[3];
            _loc_1.imgId = this._start[4];
            _loc_1.remain_number = this._start[5];
            return _loc_1;
        }// end function

        public function get goadResult() : Object
        {
            var _loc_1:Object = {};
            _loc_1.type = this._goad[0];
            _loc_1.award = this.renderAward(this._goad);
            _loc_1.state = this._goad[3];
            _loc_1.imgId = this._goad[4];
            return _loc_1;
        }// end function

        public function get pickUpAward() : Object
        {
            var _loc_1:Object = {};
            _loc_1.type = this._award[0];
            _loc_1.award = this.renderAward(this._award);
            return _loc_1;
        }// end function

        public function get flagNum() : int
        {
            return this._flagNum;
        }// end function

        private function renderAward(param1) : Object
        {
            if (param1 == 0)
            {
                return {};
            }
            var _loc_2:Object = {};
            _loc_2.fame = param1[1];
            _loc_2.skill = param1[2];
            return _loc_2;
        }// end function

        public function open_find_immortal(param1:Array) : void
        {
            this._open = param1;
            return;
        }// end function

        public function start_find_immortal(param1:Array) : void
        {
            this._start = param1;
            return;
        }// end function

        public function goad(param1:Array) : void
        {
            this._goad = param1;
            return;
        }// end function

        public function pickup_award(param1:Array) : void
        {
            this._award = param1;
            return;
        }// end function

        public function get_xun_xian_ling_number(param1:Array) : void
        {
            this._flagNum = param1[0];
            return;
        }// end function

    }
}
