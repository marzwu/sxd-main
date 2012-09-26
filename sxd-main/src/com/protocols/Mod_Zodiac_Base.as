package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Zodiac_Base extends Object
    {
        public static const SUCCESS:int = 0;
        public static const FAIL:int = 1;
        public static const TOP_HEAVEN:int = 2;
        public static const NOT_ENOUGTH_PLAYER_LEVEL:int = 3;
        public static const BAG_FULL:int = 4;
        public static const CD_TIME:int = 5;
        public static const zodiac_info:Object = {module:188, action:152, request:[], response:[Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const challenge:Object = {module:188, action:197, request:[], response:[Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]]]};
        public static const Actions:Array = ["zodiac_info", "challenge"];

        public function Mod_Zodiac_Base()
        {
            return;
        }// end function

    }
}
