package com.datas
{
    import com.assist.server.*;
    import com.haloer.data.*;

    public class ConsumeAlertSettingData extends Base
    {
        private var _aryPlayerConsumeAlertSetInfo:Array;
        private var _objPlayerConsumeAlertSet:Object;

        public function ConsumeAlertSettingData()
        {
            this._aryPlayerConsumeAlertSetInfo = [];
            this._objPlayerConsumeAlertSet = {};
            return;
        }// end function

        public function get playerConsumeAlertSetInfo() : Array
        {
            return this._aryPlayerConsumeAlertSetInfo;
        }// end function

        public function get playerConsumeAlertSet() : Object
        {
            return this._objPlayerConsumeAlertSet;
        }// end function

        public function player_consume_alert_set_info(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            this._aryPlayerConsumeAlertSetInfo = [];
            for each (_loc_2 in param1[0])
            {
                
                _loc_3 = {};
                oObject.list(_loc_2, _loc_3, ["id", "state"]);
                _loc_3["text"] = ConsumeAlertSetType.getDescription(_loc_3["id"]);
                _loc_3["vip"] = ConsumeAlertSetType.getVIP(_loc_3["id"]);
                _loc_3["lock"] = ConsumeAlertSetType.getLock(_loc_3["id"]);
                this._aryPlayerConsumeAlertSetInfo.push(_loc_3);
            }
            this._aryPlayerConsumeAlertSetInfo.sortOn("lock", Array.NUMERIC);
            return;
        }// end function

        public function player_consume_alert_set(param1:Array) : void
        {
            this._objPlayerConsumeAlertSet = {};
            oObject.list(param1, this._objPlayerConsumeAlertSet, ["result"]);
            return;
        }// end function

    }
}
