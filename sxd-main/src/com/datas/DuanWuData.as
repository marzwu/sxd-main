package com.datas
{
    import com.haloer.data.*;

    public class DuanWuData extends Base
    {
        private var _worshipState:Array;
        private var _worship:Array;
        public var stateResult:int = 0;
        public var getItemResult:int = 0;

        public function DuanWuData()
        {
            return;
        }// end function

        public function isWorshiped() : int
        {
            return this._worshipState[0];
        }// end function

        public function getZongziNum() : int
        {
            return this._worshipState[1];
        }// end function

        public function getRecordList() : Array
        {
            var _loc_1:* = new Array();
            if (this._worshipState[2].length != 0)
            {
                _loc_1 = this.returnList(this._worshipState[2]);
            }
            return _loc_1;
        }// end function

        public function worshipResult() : int
        {
            return this._worship[0];
        }// end function

        public function worshipZongziNum() : int
        {
            return this._worship[1];
        }// end function

        public function worshipList() : Array
        {
            var _loc_1:* = new Array();
            if (this._worship[2].length != 0)
            {
                _loc_1 = this.returnList(this._worship[2]);
            }
            return _loc_1;
        }// end function

        private function returnList(param1:Array) : Array
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            var _loc_2:* = new Array();
            for each (_loc_3 in param1)
            {
                
                _loc_4 = {};
                oObject.list(_loc_3, _loc_4, ["player_id", "nickname", "type", "time"]);
                _loc_4.chinese_time = DateTime.formatFromSecond2(_loc_4["time"], this.serverTime);
                _loc_2.push(_loc_4);
            }
            return _loc_2;
        }// end function

        private function get serverTime() : Number
        {
            var _loc_1:* = new Date().getTime() / 1000;
            return _loc_1 - _data.player.diffServerTime;
        }// end function

        public function worship_state(param1:Array) : void
        {
            this._worshipState = param1;
            return;
        }// end function

        public function worship(param1:Array) : void
        {
            this._worship = param1;
            return;
        }// end function

        public function zongzi_state(param1:Array) : void
        {
            this.stateResult = param1[0];
            return;
        }// end function

        public function get_zongzi(param1:Array) : void
        {
            this.getItemResult = param1[0];
            return;
        }// end function

    }
}
