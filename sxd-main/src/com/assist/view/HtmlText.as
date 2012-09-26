package com.assist.view
{

    public class HtmlText extends Object
    {
        public static const Yellow:uint = 16776960;
        public static const Red:uint = 16711680;
        public static const White:uint = 16777215;
        public static const Green:uint = 65280;
        public static const Green2:uint = 39236;
        public static const Blue:uint = 255;
        public static const Orange:uint = 16225309;
        public static const Blue2:uint = 44783;
        public static const Yellow2:uint = 16773632;
        public static const Purple:uint = 16711935;
        public static const Yellow3:uint = 15425792;
        public static const Gray:uint = 6710886;

        public function HtmlText()
        {
            return;
        }// end function

        public static function yellow(param1:String) : String
        {
            return format(param1, Yellow);
        }// end function

        public static function red(param1:String) : String
        {
            return format(param1, Red);
        }// end function

        public static function white(param1:String) : String
        {
            return format(param1, White);
        }// end function

        public static function green(param1:String) : String
        {
            return format(param1, Green);
        }// end function

        public static function green2(param1:String) : String
        {
            return format(param1, Green2);
        }// end function

        public static function blue(param1:String) : String
        {
            return format(param1, Blue);
        }// end function

        public static function orange(param1:String) : String
        {
            return format(param1, Orange);
        }// end function

        public static function blue2(param1:String) : String
        {
            return format(param1, Blue2);
        }// end function

        public static function yellow2(param1:String) : String
        {
            return format(param1, Yellow2);
        }// end function

        public static function yellow3(param1:String) : String
        {
            return format(param1, Yellow3);
        }// end function

        public static function purple(param1:String) : String
        {
            return format(param1, Purple);
        }// end function

        public static function gray(param1:String) : String
        {
            return format(param1, Gray);
        }// end function

        public static function format(param1:String, param2:uint = 0, param3:uint = 12, param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:String = null, param9:String = null) : String
        {
            if (param5)
            {
                param1 = "<b>" + param1 + "</b>";
            }
            if (param6)
            {
                param1 = "<i>" + param1 + "</i>";
            }
            if (param7)
            {
                param1 = "<u>" + param1 + "</u>";
            }
            var _loc_10:String = "";
            if (param4)
            {
                _loc_10 = _loc_10 + (" face=\"" + param4 + "\"");
            }
            if (param3 > 0)
            {
                _loc_10 = _loc_10 + (" size=\"" + param3 + "\"");
            }
            _loc_10 = _loc_10 + (" color=\"#" + param2.toString(16) + "\"");
            param1 = "<font" + _loc_10 + ">" + param1 + "</font>";
            if (param8)
            {
                param1 = "<a href=\"" + param8 + "\" target=\"_blank\">" + param1 + "</a>";
            }
            if (param9)
            {
                param1 = "<p align=\"" + param9 + "\">" + param1 + "</p>";
            }
            return param1;
        }// end function

    }
}
