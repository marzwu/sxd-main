package com.datas
{
    import com.assist.server.*;
    import com.haloer.data.*;

    public class WorshipMarsData extends Base
    {
        private var _objMarsInfo:Object;
        private var _aryIncenseLog:Array;
        private var _objIncense:Object;
        private var _objGetBlessingTimesAndExpAdd:Object;
        private var _objGetRemainIncenseTimes:Object;
        private var objIncenseColor:Object;

        public function WorshipMarsData()
        {
            this._objMarsInfo = {};
            this._aryIncenseLog = [];
            this._objIncense = {};
            this._objGetBlessingTimesAndExpAdd = {};
            this._objGetRemainIncenseTimes = {};
            this.objIncenseColor = {1:16777215, 2:44783, 3:16776960};
            return;
        }// end function

        public function get marsInfo() : Object
        {
            return this._objMarsInfo;
        }// end function

        public function get incenseLog() : Array
        {
            return this._aryIncenseLog;
        }// end function

        public function get marsIncense() : Object
        {
            return this._objIncense;
        }// end function

        public function get getBlessingTimesAndExpAdd() : Object
        {
            return this._objGetBlessingTimesAndExpAdd;
        }// end function

        public function get getRemainIncenseTimes() : Object
        {
            return this._objGetRemainIncenseTimes;
        }// end function

        private function sortByTime(param1:Object, param2:Object) : int
        {
            var _loc_3:* = param1["time"];
            var _loc_4:* = param2["time"];
            if (_loc_3 < _loc_4)
            {
                return 1;
            }
            if (_loc_3 > _loc_4)
            {
                return -1;
            }
            return 0;
        }// end function

        private function get serverTime() : int
        {
            var _loc_1:* = new Date().getTime() / 1000;
            return _loc_1 - this._data.player.diffServerTime;
        }// end function

        public function mars_info(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this._objMarsInfo = {};
            oObject.list(param1, this._objMarsInfo, ["mars_level", "mars_exp", "require_exp", "incense_count", "total_count", "is_cover"]);
            this._aryIncenseLog = [];
            for each (_loc_3 in param1[(param1.length - 1)])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["player_id", "player_name", "incense_id", "exp", "time"]);
                _loc_2["player_name"] = this._data.player.removeNickNameSuffix(_loc_2["player_name"]);
                _loc_2["incense_name"] = MarsType.getOfferingName(_loc_2["incense_id"]);
                _loc_2["color"] = this.objIncenseColor[_loc_2["incense_id"]];
                _loc_2["chinese_time"] = DateTime.formatFromSecond2(_loc_2["time"], this.serverTime);
                this._aryIncenseLog.push(_loc_2);
            }
            this._aryIncenseLog.sort(this.sortByTime);
            return;
        }// end function

        public function incense(param1:Array) : void
        {
            this._objIncense = {result:param1[0]};
            return;
        }// end function

        public function get_blessing_times_and_exp_add(param1:Array) : void
        {
            this._objGetBlessingTimesAndExpAdd = {};
            oObject.list(param1, this._objGetBlessingTimesAndExpAdd, ["count", "exp_add"]);
            return;
        }// end function

        public function blessing_times_and_exp_add_notify(param1:Array) : void
        {
            return;
        }// end function

        public function get_remain_incense_times(param1:Array) : void
        {
            this._objGetRemainIncenseTimes = {};
            oObject.list(param1, this._objGetRemainIncenseTimes, ["remain_incense_times"]);
            return;
        }// end function

    }
}
