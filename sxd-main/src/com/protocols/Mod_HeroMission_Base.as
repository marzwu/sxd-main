﻿package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_HeroMission_Base extends Object
    {
        public static const SCORE_A:int = 0;
        public static const SCORE_B:int = 1;
        public static const SCORE_C:int = 2;
        public static const SUCCESS:int = 3;
        public static const NOT_ENOUGH_INGOT:int = 4;
        public static const FULL_BUY_TIMES:int = 5;
        public static const BAG_FULL:int = 6;
        public static const NOT_ENOUGH_POWER:int = 7;
        public static const NO_MISSION:int = 8;
        public static const NEW_WAR_REPORT:int = 9;
        public static const FINISH:int = 10;
        public static const get_hero_mission_list:Object = {module:42, action:35, request:[Utils.ShortUtil], response:[[Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], Utils.ByteUtil, Utils.ByteUtil, Utils.ShortUtil]};
        public static const buy_hero_challenge:Object = {module:42, action:240, request:[Utils.ShortUtil], response:[Utils.ByteUtil]};
        public static const start_practice:Object = {module:42, action:142, request:[Utils.ShortUtil, Utils.ByteUtil], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const stop_practice:Object = {module:42, action:0, request:[], response:[]};
        public static const notify:Object = {module:42, action:18, request:[], response:[Utils.ByteUtil, [[Utils.IntUtil, Utils.IntUtil], [Utils.IntUtil, Utils.IntUtil], Utils.ShortUtil], [Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil], [Utils.IntUtil, Utils.IntUtil], Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil], Utils.ShortUtil]};
        public static const get_continue_practice_info:Object = {module:42, action:93, request:[], response:[Utils.ByteUtil, Utils.ShortUtil, [Utils.IntUtil], Utils.IntUtil, Utils.ByteUtil]};
        public static const continue_practice:Object = {module:42, action:102, request:[], response:[]};
        public static const quickly:Object = {module:42, action:107, request:[], response:[Utils.ByteUtil]};
        public static const Actions:Array = ["get_hero_mission_list", "buy_hero_challenge", "start_practice", "stop_practice", "notify", "get_continue_practice_info", "continue_practice", "quickly"];

        public function Mod_HeroMission_Base()
        {
            return;
        }// end function

    }
}
