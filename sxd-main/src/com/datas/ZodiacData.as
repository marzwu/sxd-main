package com.datas
{
    import com.assist.server.*;
    import com.haloer.data.*;

    public class ZodiacData extends Base
    {
        private var _objZodiacInfo:Object;
        private var _objChallenge:Object;
        private var _awardGoldOilId:int;
        private var _awardAura:int;
        private var _warData:Array;

        public function ZodiacData()
        {
            this._objZodiacInfo = {};
            this._objChallenge = {};
            return;
        }// end function

        public function get zodiacInfo() : Object
        {
            return this._objZodiacInfo;
        }// end function

        public function get challengeResult() : Object
        {
            return this._objChallenge;
        }// end function

        public function get awardGoldOilId() : int
        {
            return this._awardGoldOilId;
        }// end function

        public function get awardAura() : int
        {
            return this._awardAura;
        }// end function

        public function get warData() : Array
        {
            return this._warData;
        }// end function

        public function zodiac_info(param1:Array) : void
        {
            this._objZodiacInfo = {};
            oObject.list(param1, this._objZodiacInfo, ["now_zodiac_level", "now_barrier", "next_zodiac_level", "next_barrier", "require_level", "gold_oil_id", "heaven"]);
            this._objZodiacInfo["gold_oil_name"] = ItemType.getName(this._objZodiacInfo["gold_oil_id"]);
            this._objZodiacInfo["heaven_name"] = ZodiacType.getZodiaName(this._objZodiacInfo["heaven"]);
            return;
        }// end function

        public function challenge(param1:Array) : void
        {
            this._objChallenge = {};
            oObject.list(param1, this._objChallenge, ["result", "zodiac_level", "barrier", "gold_oil_id"]);
            this._awardGoldOilId = param1[param1.length - 3];
            this._awardAura = param1[param1.length - 2];
            this._warData = param1[(param1.length - 1)][0];
            return;
        }// end function

    }
}
