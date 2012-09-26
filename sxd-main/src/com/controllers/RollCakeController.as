package com.controllers
{
    import com.assist.server.*;
    import com.protocols.*;

    public class RollCakeController extends Base
    {
        public var reollIngot:int = 0;

        public function RollCakeController()
        {
            return;
        }// end function

        public function get getState() : Object
        {
            var _loc_1:* = _data.rollCake.getState;
            var _loc_2:* = this.renderRollData2(_loc_1);
            return _loc_2;
        }// end function

        public function get rollData() : Object
        {
            var _loc_1:* = _data.rollCake.rollData;
            var _loc_2:* = this.renderRollData2(_loc_1);
            return _loc_2;
        }// end function

        public function get addCount() : Object
        {
            var _loc_1:* = _data.rollCake.addCount;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.count = _loc_1[1];
            return _loc_2;
        }// end function

        public function get getCount() : Object
        {
            var _loc_1:* = _data.rollCake.getCount;
            var _loc_2:Object = {};
            _loc_2.count = _loc_1[0];
            _loc_2.freeRobeNum = _loc_1[1];
            _loc_2.robeMaxNum = _loc_1[2];
            return _loc_2;
        }// end function

        public function get rerollData() : Object
        {
            var _loc_1:* = _data.rollCake.rerollData;
            var _loc_2:* = this.renderRollData(_loc_1);
            return _loc_2;
        }// end function

        private function renderRollData(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.msg = param1[0];
            _loc_2.type = param1[1];
            _loc_2.typeName = RollCakeType.getRollCakeNickName(_loc_2.type);
            _loc_2.awardSkill = RollCakeType.getRollCakeSkill(_loc_2.type);
            _loc_2.statePoint = RollCakeType.getRollCakeStatePoint(_loc_2.type);
            _loc_2.coin = RollCakeType.getRollCakeCoin(_loc_2.type);
            _loc_2.canFree = param1[2];
            _loc_2.rerollIngot = param1[3];
            if (_loc_2.msg == Mod_RollCake_Base.SUCCESS)
            {
                this.reollIngot = _loc_2.rerollIngot;
            }
            _loc_2.numList = [];
            _loc_2.numList.push({id:1, num:param1[4]});
            _loc_2.numList.push({id:2, num:param1[5]});
            _loc_2.numList.push({id:3, num:param1[6]});
            _loc_2.numList.push({id:4, num:param1[7]});
            _loc_2.numList.push({id:5, num:param1[8]});
            _loc_2.numList.push({id:6, num:param1[9]});
            this.sortTime(_loc_2.numList);
            return _loc_2;
        }// end function

        private function renderRollData2(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.msg = param1[0];
            _loc_2.type = param1[1];
            _loc_2.typeName = RollCakeType.getRollCakeNickName(_loc_2.type);
            _loc_2.awardSkill = RollCakeType.getRollCakeSkill(_loc_2.type);
            _loc_2.statePoint = RollCakeType.getRollCakeStatePoint(_loc_2.type);
            _loc_2.coin = RollCakeType.getRollCakeCoin(_loc_2.type);
            _loc_2.rerollIngot = param1[2];
            if (_loc_2.msg == Mod_RollCake_Base.SUCCESS || _loc_2.msg == Mod_RollCake_Base.HAVE_RECORD)
            {
                this.reollIngot = _loc_2.rerollIngot;
            }
            _loc_2.numList = [];
            _loc_2.numList.push({id:1, num:param1[3]});
            _loc_2.numList.push({id:2, num:param1[4]});
            _loc_2.numList.push({id:3, num:param1[5]});
            _loc_2.numList.push({id:4, num:param1[6]});
            _loc_2.numList.push({id:5, num:param1[7]});
            _loc_2.numList.push({id:6, num:param1[8]});
            this.sortTime(_loc_2.numList);
            return _loc_2;
        }// end function

        private function sortTime(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 1;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = 0;
                while (_loc_4 < (_loc_2 - 1))
                {
                    
                    if (param1[_loc_4]["num"] < param1[(_loc_4 + 1)]["num"])
                    {
                        _loc_5 = param1[_loc_4];
                        param1[_loc_4] = param1[(_loc_4 + 1)];
                        param1[(_loc_4 + 1)] = _loc_5;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function get getAward() : Object
        {
            var _loc_1:* = _data.rollCake.getAward;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get isAuto() : int
        {
            var _loc_1:* = _data.rollCake.isAuto;
            return _loc_1[0];
        }// end function

        public function get setAuto() : int
        {
            var _loc_1:* = _data.rollCake.setAuto;
            return _loc_1[0];
        }// end function

    }
}
