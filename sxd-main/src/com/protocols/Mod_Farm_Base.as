﻿package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Farm_Base extends Object
    {
        public static const PLANT:int = 0;
        public static const NO_PLANT:int = 1;
        public static const EXP_HERBS:int = 2;
        public static const COIN_HERBS:int = 3;
        public static const WAR:int = 4;
        public static const INVITE:int = 5;
        public static const NOINVITE:int = 6;
        public static const SUCCESS:int = 7;
        public static const TOP_HERBS:int = 8;
        public static const NOT_ENOUGH_INGOT:int = 9;
        public static const IS_TOP_HERBS:int = 10;
        public static const NO_ENOUGHT_COIN_TREE_COUNT:int = 11;
        public static const REACH_MAX_LAND_COUNT:int = 12;
        public static const NOT_PLAYER_ROLE:int = 13;
        public static const IS_MAIN_ROLE:int = 14;
        public static const ROLE_LEVEL:int = 15;
        public static const PASS:int = 16;
        public static const REMAIN:int = 17;
        public static const NO_REMAIN:int = 18;
        public static const NO_INGOT:int = 19;
        public static const NO_ENOUGTH_TIMES:int = 20;
        public static const NO_VIP:int = 21;
        public static const IS_PLANT:int = 22;
        public static const CAN_NOT_UP:int = 23;
        public static const get_farmlandinfo_list:Object = {module:197, action:196, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil], Utils.IntUtil]};
        public static const get_player_roleinfo_list:Object = {module:197, action:232, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]]};
        public static const get_herbs_seed:Object = {module:197, action:249, request:[Utils.ByteUtil], response:[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const refresh_herbs_seed:Object = {module:197, action:121, request:[Utils.ByteUtil], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const get_top_herbs_seed:Object = {module:197, action:224, request:[Utils.ByteUtil], response:[Utils.ByteUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const plant_herbs:Object = {module:197, action:193, request:[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil]};
        public static const harvest:Object = {module:197, action:149, request:[Utils.IntUtil], response:[Utils.ByteUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const reclamation:Object = {module:197, action:14, request:[], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const check_role_state:Object = {module:197, action:182, request:[Utils.IntUtil, Utils.ByteUtil], response:[Utils.ByteUtil]};
        public static const harvest_check_remain_exp:Object = {module:197, action:50, request:[Utils.IntUtil], response:[Utils.IntUtil, Utils.ByteUtil]};
        public static const get_simple_farmlandinfo:Object = {module:197, action:66, request:[], response:[Utils.IntUtil, Utils.IntUtil]};
        public static const clear_farmland_cd:Object = {module:197, action:85, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const buy_coin_tree_count_info:Object = {module:197, action:27, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const buy_coin_tree_count:Object = {module:197, action:7, request:[], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const coin_tree_count_notify:Object = {module:197, action:70, request:[], response:[Utils.IntUtil]};
        public static const ingot_for_farmland:Object = {module:197, action:228, request:[Utils.IntUtil], response:[Utils.IntUtil]};
        public static const up_farmland_level:Object = {module:197, action:199, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const Actions:Array = ["get_farmlandinfo_list", "get_player_roleinfo_list", "get_herbs_seed", "refresh_herbs_seed", "get_top_herbs_seed", "plant_herbs", "harvest", "reclamation", "check_role_state", "harvest_check_remain_exp", "get_simple_farmlandinfo", "clear_farmland_cd", "buy_coin_tree_count_info", "buy_coin_tree_count", "coin_tree_count_notify", "ingot_for_farmland", "up_farmland_level"];

        public function Mod_Farm_Base()
        {
            return;
        }// end function

    }
}
