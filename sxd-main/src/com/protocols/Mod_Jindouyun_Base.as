﻿package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Jindouyun_Base extends Object
    {
        public static const SUCCESS:int = 0;
        public static const REACH_MAX_COUNT:int = 1;
        public static const NO_JOIN_RACE:int = 2;
        public static const IS_TRUBO:int = 3;
        public static const RACE_START:int = 4;
        public static const NO_INGOT:int = 5;
        public static const BEEN_GET:int = 6;
        public static const WIN:int = 7;
        public static const LOSE:int = 8;
        public static const ERROR:int = 9;
        public static const enter_race:Object = {module:19, action:29, request:[], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const turbo:Object = {module:19, action:254, request:[], response:[Utils.ByteUtil]};
        public static const get_race_data:Object = {module:19, action:82, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, [Utils.IntUtil]]]};
        public static const get_award:Object = {module:19, action:216, request:[], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const leave_race:Object = {module:19, action:115, request:[], response:[Utils.ByteUtil]};
        public static const Actions:Array = ["enter_race", "turbo", "get_race_data", "get_award", "leave_race"];

        public function Mod_Jindouyun_Base()
        {
            return;
        }// end function

    }
}
