package com.datas
{
    import com.assist.server.*;
    import com.haloer.data.*;

    public class AssistantData extends Base
    {
        private var _aryBoxInfo:Array;
        private var _objGetAward:Object;
        private var _objCompleteNumber:Object;
        private var _boxInfo:Array;
        private var _liveNum:int;

        public function AssistantData()
        {
            this._aryBoxInfo = [];
            this._objGetAward = {};
            this._objCompleteNumber = {};
            this._boxInfo = [];
            return;
        }// end function

        public function get getBoxInfo() : Array
        {
            return this._aryBoxInfo;
        }// end function

        public function get getAward() : Object
        {
            return this._objGetAward;
        }// end function

        public function get completeNumber() : Object
        {
            return this._objCompleteNumber;
        }// end function

        public function get boxInfo() : Array
        {
            return this._boxInfo;
        }// end function

        public function get liveNum() : int
        {
            return this._liveNum;
        }// end function

        private function getBoxData(param1:Array) : Array
        {
            var _loc_9:Object = null;
            var _loc_10:int = 0;
            var _loc_2:* = AssistantAwardType.getIdList();
            var _loc_3:Array = [];
            var _loc_4:* = param1[0];
            var _loc_5:* = AssistantAwardType.getBoxCount(this._data.player.vipLevel);
            var _loc_6:int = 1;
            var _loc_7:* = _loc_5;
            _loc_6 = 1;
            while (_loc_6 <= _loc_5)
            {
                
                if (param1[_loc_6] == 0)
                {
                    _loc_7 = _loc_6;
                    break;
                }
                _loc_6++;
            }
            var _loc_8:* = _loc_7;
            while (_loc_8 > (_loc_7 - 1))
            {
                
                _loc_9 = {};
                _loc_9["box_id"] = _loc_2[(_loc_8 - 1)];
                _loc_9["completed_get"] = param1[_loc_8] == 1;
                _loc_9["vip"] = AssistantAwardType.getVIP(_loc_9["box_id"]);
                _loc_9["total_count"] = AssistantAwardType.getTimes(_loc_9["box_id"]);
                _loc_10 = AssistantAwardType.getMaxTimes();
                _loc_9["completed_count"] = _loc_4 > _loc_10 ? (_loc_10) : (_loc_4);
                _loc_9["name"] = AssistantAwardType.getName(_loc_9["box_id"]);
                _loc_9["skill"] = AssistantAwardType.getSkill(_loc_9["box_id"]);
                _loc_9["item_count"] = AssistantAwardType.getCardNum(_loc_9["box_id"]);
                if (this._data.player.level <= 39)
                {
                    _loc_9["item_id"] = 145;
                }
                else if (this._data.player.level <= 59)
                {
                    _loc_9["item_id"] = 344;
                }
                else if (this._data.player.level <= 69)
                {
                    _loc_9["item_id"] = 345;
                }
                else if (this._data.player.level <= 89)
                {
                    _loc_9["item_id"] = 346;
                }
                else if (this._data.player.level >= 90)
                {
                    _loc_9["item_id"] = 347;
                }
                _loc_9["item_color"] = ItemType.getItemColor(_loc_9["item_id"]);
                _loc_9["item_name"] = ItemType.getName(_loc_9["item_id"]);
                _loc_3.unshift(_loc_9);
                _loc_8 = _loc_8 - 1;
            }
            return _loc_3;
        }// end function

        public function renderBoxInfo(param1:Array) : Array
        {
            var _loc_6:Object = null;
            var _loc_2:* = AssistantAwardType.getIdList();
            var _loc_3:* = _loc_2.length;
            var _loc_4:Array = [];
            var _loc_5:int = 1;
            while (_loc_5 <= _loc_3)
            {
                
                _loc_6 = {};
                _loc_6.type = param1[_loc_5];
                _loc_6.targetNum = AssistantAwardType.getActiveDegree(_loc_5);
                _loc_6.skillNum = AssistantAwardType.getSkill(_loc_5);
                _loc_6.coin = AssistantAwardType.getCoin(_loc_5);
                _loc_6.cardNum = AssistantAwardType.getCardNum(_loc_5);
                _loc_4.push(_loc_6);
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public function info(param1:Array) : void
        {
            this._aryBoxInfo = this.getBoxData(param1);
            this._liveNum = param1[0] * 5;
            this._boxInfo = this.renderBoxInfo(param1);
            return;
        }// end function

        public function get_award(param1:Array) : void
        {
            this._objGetAward = {};
            oObject.list(param1, this._objGetAward, ["result"]);
            return;
        }// end function

        public function complete_number(param1:Array) : void
        {
            this._objCompleteNumber = {};
            oObject.list(param1, this._objCompleteNumber, ["complete_number"]);
            return;
        }// end function

    }
}
