package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_FindImmortal_Base extends Object
    {
        public static const SUCCESS:int = 0;
        public static const NOT_ENOUGH_COIN:int = 1;
        public static const HAVE_NOT_NUMBER:int = 2;
        public static const GOADING:int = 3;
        public static const NOT_ENOUGH_INGOT:int = 4;
        public static const FAILED:int = 5;
        public static const HAVE_NOT_FIND:int = 6;
        public static const open_find_immortal:Object = {module:229, action:91, request:[], response:[Utils.ByteUtil, Utils.ShortUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil]};
        public static const start_find_immortal:Object = {module:229, action:214, request:[], response:[Utils.ByteUtil, Utils.ShortUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil]};
        public static const goad:Object = {module:229, action:44, request:[], response:[Utils.ByteUtil, Utils.ShortUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil]};
        public static const pickup_award:Object = {module:229, action:105, request:[], response:[Utils.ByteUtil, Utils.ShortUtil, Utils.IntUtil]};
        public static const get_xun_xian_ling_number:Object = {module:229, action:54, request:[], response:[Utils.IntUtil]};
        public static const Actions:Array = ["open_find_immortal", "start_find_immortal", "goad", "pickup_award", "get_xun_xian_ling_number"];

        public function Mod_FindImmortal_Base()
        {
            return;
        }// end function

    }
}
