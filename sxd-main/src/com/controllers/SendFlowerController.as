package com.controllers
{
    import com.haloer.data.*;

    public class SendFlowerController extends Base
    {

        public function SendFlowerController()
        {
            return;
        }// end function

        public function sendFlowerRecord() : Array
        {
            var _loc_2:Object = null;
            var _loc_1:* = this._data.sendFlower.sendFlowerRecord();
            for each (_loc_2 in _loc_1)
            {
                
                _loc_2["chinese_time"] = DateTime.formatFromSecond2(_loc_2["send_time"], this._ctrl.player.serverTime);
            }
            return _loc_1;
        }// end function

        public function sendFlowerInfo() : Object
        {
            return this._data.sendFlower.sendFlowerInfo();
        }// end function

        public function sendPlayerFlower() : Object
        {
            return this._data.sendFlower.sendPlayerFlower();
        }// end function

        public function sendFlowerRanking() : Array
        {
            return this._data.sendFlower.sendFlowerRanking();
        }// end function

        public function getSendFlowerRankingWeek() : Array
        {
            return this._data.sendFlower.getSendFlowerRankingWeek();
        }// end function

    }
}
