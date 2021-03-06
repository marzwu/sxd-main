﻿package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_GetPeach_Base extends Object
    {
        public static const SUCCESS:int = 0;
        public static const NOT_ENOUGH_PEACH_COUNT:int = 1;
        public static const WAR_CD:int = 2;
        public static const FAILURE:int = 3;
        public static const get_peach:Object = {module:166, action:43, request:[], response:[Utils.ByteUtil, Utils.IntUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]], Utils.IntUtil]};
        public static const buy_monkeys:Object = {module:166, action:66, request:[], response:[Utils.ByteUtil]};
        public static const peach_info:Object = {module:166, action:42, request:[], response:[Utils.ByteUtil, Utils.ByteUtil]};
        public static const player_info:Object = {module:166, action:31, request:[], response:[Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil]};
        public static const Actions:Array = ["get_peach", "buy_monkeys", "peach_info", "player_info"];

        public function Mod_GetPeach_Base()
        {
            return;
        }// end function

    }
}
