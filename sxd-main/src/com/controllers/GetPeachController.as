package com.controllers
{
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.lang.client.com.controllers.*;

    public class GetPeachController extends Base
    {
        public var PeachLv:int = 0;

        public function GetPeachController()
        {
            return;
        }// end function

        public function get buyMonkeys() : Object
        {
            var _loc_1:* = _data.getPeach.buyMonkeys;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get peachInfo() : Object
        {
            var _loc_1:* = _data.getPeach.peachInfo;
            var _loc_2:Object = {};
            _loc_2.peachLv = _loc_1[0];
            this.PeachLv = _loc_2.peachLv;
            _loc_2.fruitLv = 70 + _loc_2.peachLv * 5;
            var _loc_3:* = PeachType.getExp(_loc_2.peachLv);
            _loc_2.getExp = _loc_3;
            var _loc_4:* = _loc_2.peachLv + 1;
            _loc_2.levelMax = _loc_2.peachLv >= PeachType.MaxLevel;
            var _loc_5:* = _loc_2.levelMax ? (PeachType.MaxLevel) : (_loc_4);
            var _loc_6:* = PeachType.getExp(_loc_5);
            _loc_2.nextExp = _loc_6;
            if (_loc_3 > 10000)
            {
                _loc_2.getExp = Math.floor(_loc_3 / 10000) + GetPeachControllerLang.Wan;
                _loc_2.nextExp = Math.floor(_loc_6 / 10000) + GetPeachControllerLang.Wan;
            }
            _loc_2.peachNum = _loc_1[1];
            return _loc_2;
        }// end function

        public function get playerInfo() : Object
        {
            var _loc_1:* = _data.getPeach.playerInfo;
            var _loc_2:Object = {};
            _loc_2.playerCount = _loc_1[0];
            _loc_2.haveMonkeyNum = _loc_1[1];
            _loc_2.canBuyCount = _loc_1[2];
            return _loc_2;
        }// end function

        public function get warResult() : int
        {
            return _data.getPeach.warResult;
        }// end function

        public function get warExp() : int
        {
            return _data.getPeach.warExp;
        }// end function

        public function get warData() : WarData
        {
            return _data.getPeach.warData;
        }// end function

        public function get warAura() : int
        {
            return _data.getPeach.warAura;
        }// end function

    }
}
