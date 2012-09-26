package com.controllers
{
    import com.assist.data.mission.*;
    import com.assist.server.*;

    public class ZodiacController extends Base
    {

        public function ZodiacController()
        {
            return;
        }// end function

        public function get zodiacInfo() : Object
        {
            return this._data.zodiac.zodiacInfo;
        }// end function

        public function get challengeResult() : Object
        {
            return this._data.zodiac.challengeResult;
        }// end function

        public function get awardGoldOilName() : String
        {
            return GoldOilType.getOilName(_data.zodiac.awardGoldOilId);
        }// end function

        public function get awardAura() : int
        {
            return _data.zodiac.awardAura;
        }// end function

        public function get warData() : WarData
        {
            var _loc_1:* = new WarData();
            _loc_1.format([0, 0, 0, [_data.zodiac.warData]]);
            return _loc_1;
        }// end function

    }
}
