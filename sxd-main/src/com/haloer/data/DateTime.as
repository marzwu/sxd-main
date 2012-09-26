package com.haloer.data
{
    import com.*;
    import com.lang.client.com.haloer.data.*;

    public class DateTime extends Object
    {

        public function DateTime()
        {
            return;
        }// end function

        public static function formatFromSecond(param1:uint) : String
        {
            var _loc_2:* = Math.floor(param1 / 3600);
            var _loc_3:* = Math.floor((param1 - _loc_2 * 3600) / 60);
            var _loc_4:* = param1 % 60;
            var _loc_5:* = OneDigitAddZero(_loc_2);
            var _loc_6:* = OneDigitAddZero(_loc_3);
            var _loc_7:* = OneDigitAddZero(_loc_4);
            if (_loc_5 == "00")
            {
                return _loc_6 + ":" + _loc_7;
            }
            return _loc_5 + ":" + _loc_6 + ":" + _loc_7;
        }// end function

        public static function formatFromSecond1(param1:uint) : String
        {
            var _loc_2:* = Math.floor(param1 / 3600);
            var _loc_3:* = Math.floor((param1 - _loc_2 * 3600) / 60);
            var _loc_4:* = param1 % 60;
            var _loc_5:* = _loc_2.toString();
            var _loc_6:* = _loc_3.toString();
            var _loc_7:* = _loc_4.toString();
            var _loc_8:String = "";
            if (_loc_5 != "0")
            {
                _loc_8 = Lang.sprintf(DateTimeLang.Hour, _loc_5);
            }
            if (_loc_6 != "0")
            {
                _loc_8 = _loc_8 + Lang.sprintf(DateTimeLang.Minute, _loc_6);
            }
            if (_loc_7 != "0")
            {
                _loc_8 = _loc_8 + Lang.sprintf(DateTimeLang.Second, _loc_7);
            }
            return _loc_8;
        }// end function

        public static function formatFromSecond2(param1:uint, param2:uint) : String
        {
            var _loc_3:* = param2 - param1;
            var _loc_4:* = Math.floor(_loc_3 / (3600 * 24));
            if (Math.floor(_loc_3 / (3600 * 24)) > 30)
            {
                return DateTimeLang.OngMonthAgo;
            }
            if (_loc_4 >= 2 && _loc_4 <= 30)
            {
                return Lang.sprintf(DateTimeLang.DayAgo, _loc_4);
            }
            if (_loc_4 == 1)
            {
                return DateTimeLang.Yesterday;
            }
            var _loc_5:* = Math.floor(_loc_3 / 3600);
            if (Math.floor(_loc_3 / 3600) >= 1)
            {
                return Lang.sprintf(DateTimeLang.HourAgo, _loc_5);
            }
            var _loc_6:* = Math.floor(_loc_3 / 60);
            if (Math.floor(_loc_3 / 60) >= 30)
            {
                return DateTimeLang.HalfAnHour;
            }
            if (_loc_6 > 0 && _loc_6 < 30)
            {
                return Lang.sprintf(DateTimeLang.SecondAgo, _loc_6);
            }
            return DateTimeLang.Just;
        }// end function

        private static function OneDigitAddZero(param1:uint) : String
        {
            if (param1 < 10)
            {
                return "0" + param1;
            }
            return param1.toString();
        }// end function

    }
}
