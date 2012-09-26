﻿package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_ServerWar_Base extends Object
    {
        public static const RACE_TYPE_CLOSE:int = 0;
        public static const RACE_TYPE_STAGE_SELECT_RACE:int = 1;
        public static const RACE_TYPE_STAGE_RACE:int = 2;
        public static const RACE_TYPE_WORLD_SELECT_RACE:int = 3;
        public static const RACE_TYPE_WORLD_RACE:int = 4;
        public static const WORLD_WAR_LEVEL_NULL:int = 5;
        public static const WORLD_WAR_LEVEL_70:int = 6;
        public static const WORLD_WAR_LEVEL_80:int = 7;
        public static const WORLD_WAR_LEVEL_90:int = 8;
        public static const CLOSE:int = 9;
        public static const SERVER_WAR_STOP:int = 10;
        public static const SERVER_WAR_PREPARE:int = 11;
        public static const SERVER_WAR_APPLY:int = 12;
        public static const SERVER_WAR_APPLY_COMPLETE:int = 13;
        public static const SERVER_WAR_TIANBANG:int = 14;
        public static const SERVER_WAR_DIBANG:int = 15;
        public static const SERVER_WAR_DIBANG_COMPLETE:int = 16;
        public static const SERVER_WAR_16:int = 17;
        public static const SERVER_WAR_16_COMPLETE:int = 18;
        public static const SERVER_WAR_8:int = 19;
        public static const SERVER_WAR_8_COMPLETE:int = 20;
        public static const SERVER_WAR_4:int = 21;
        public static const SERVER_WAR_4_COMPLETE:int = 22;
        public static const SERVER_WAR_2:int = 23;
        public static const SERVER_WAR_2_COMPLETE:int = 24;
        public static const SERVER_WAR_1:int = 25;
        public static const SERVER_WAR_1_COMPLETE:int = 26;
        public static const GROUP_NULL:int = 27;
        public static const GROUP_TIAN_BANG:int = 28;
        public static const GROUP_DI_BANG:int = 29;
        public static const SUCCESS:int = 30;
        public static const REAPPLY:int = 31;
        public static const REQUEST_LEVEL:int = 32;
        public static const NO_APPLY_STEP:int = 33;
        public static const REBET:int = 34;
        public static const INVALID_RACE:int = 35;
        public static const NOT_ENOUGH_COIN:int = 36;
        public static const get_race_step:Object = {module:151, action:82, request:[], response:[Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, [Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, [Utils.StringUtil, Utils.StringUtil]]};
        public static const get_standings:Object = {module:151, action:169, request:[], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.StringUtil]]};
        public static const get_race_list:Object = {module:151, action:16, request:[Utils.ByteUtil, Utils.ByteUtil], response:[Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.StringUtil, Utils.StringUtil, Utils.LongUtil, [Utils.ShortUtil], Utils.StringUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil, Utils.StringUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.StringUtil, Utils.StringUtil, Utils.LongUtil, [Utils.ShortUtil], Utils.StringUtil, Utils.ShortUtil, Utils.ByteUtil], [Utils.IntUtil, Utils.IntUtil, Utils.StringUtil], [Utils.IntUtil], [Utils.IntUtil], [Utils.IntUtil], [Utils.IntUtil], Utils.IntUtil, [Utils.IntUtil]]};
        public static const get_war_result_list:Object = {module:151, action:224, request:[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil]]};
        public static const get_race_standings:Object = {module:151, action:122, request:[], response:[[Utils.ByteUtil, Utils.IntUtil, Utils.StringUtil, [Utils.ByteUtil, Utils.IntUtil, Utils.StringUtil], Utils.ByteUtil, Utils.ByteUtil]]};
        public static const apply:Object = {module:151, action:86, request:[], response:[Utils.ByteUtil]};
        public static const get_player_war_report:Object = {module:151, action:227, request:[Utils.IntUtil], response:[Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]]};
        public static const get_player_bet:Object = {module:151, action:186, request:[], response:[[Utils.ByteUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil]]};
        public static const bet:Object = {module:151, action:134, request:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const get_bet_coin_rank:Object = {module:151, action:202, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.StringUtil, Utils.LongUtil]]};
        public static const Actions:Array = ["get_race_step", "get_standings", "get_race_list", "get_war_result_list", "get_race_standings", "apply", "get_player_war_report", "get_player_bet", "bet", "get_bet_coin_rank"];

        public function Mod_ServerWar_Base()
        {
            return;
        }// end function

    }
}
