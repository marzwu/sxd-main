package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Mission_Base extends Object
    {
        public static const NORMAL_ATTACK:int = 0;
        public static const BACK_ATTACK:int = 1;
        public static const MAGIC_ATTACK:int = 2;
        public static const STUNT_ATTACK:int = 3;
        public static const TIAN_XUAN_WU_YIN_ADDON_ATTRIBUTE:int = 4;
        public static const GU_WU_SHU_ADD_MOMENTUM:int = 5;
        public static const HUI_CHUN_ADD_HEALTH:int = 6;
        public static const MIAO_SHOU_HUI_CHUN_ADD_HEALTH:int = 7;
        public static const ZHI_LIAO_ADD_HEALTH:int = 8;
        public static const XI_XUE_ADD_HEALTH:int = 9;
        public static const HUAN_MING_CHANGE_HEALTH:int = 10;
        public static const CHENG_TIAN_ZAI_WU_ADDON_ATTRIBUTE:int = 11;
        public static const DECREASE_HEALTH_LIST:int = 12;
        public static const QING_NIAN_HUA_SHU:int = 13;
        public static const SUCCESS:int = 14;
        public static const REFIGHT:int = 15;
        public static const SCORE_A:int = 16;
        public static const SCORE_B:int = 17;
        public static const SCORE_C:int = 18;
        public static const LESS_POWER:int = 19;
        public static const PICKUP_SUCCESS:int = 20;
        public static const PICKUP_FAILED:int = 21;
        public static const REPICKUP:int = 22;
        public static const COIN:int = 23;
        public static const INGOT:int = 24;
        public static const SKILL:int = 25;
        public static const FAILED:int = 26;
        public static const get_sections:Object = {module:80, action:240, request:[Utils.IntUtil], response:[[Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil]]};
        public static const enter_mission:Object = {module:80, action:213, request:[Utils.IntUtil], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const fight_monster:Object = {module:80, action:36, request:[Utils.IntUtil, Utils.ByteUtil], response:[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]], [Utils.IntUtil, Utils.IntUtil], [Utils.IntUtil, Utils.ByteUtil], [Utils.IntUtil, Utils.ByteUtil], [[Utils.StringUtil, [Utils.StringUtil, Utils.StringUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]], [Utils.StringUtil, [Utils.StringUtil, Utils.StringUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]], Utils.IntUtil, Utils.ByteUtil, Utils.ShortUtil, Utils.ShortUtil]};
        public static const rank_mission:Object = {module:80, action:98, request:[], response:[Utils.ShortUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil], Utils.ShortUtil]};
        public static const open_box:Object = {module:80, action:167, request:[], response:[Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil], Utils.ShortUtil]};
        public static const pickup_award:Object = {module:80, action:226, request:[], response:[Utils.ByteUtil]};
        public static const sign_play_mission_video:Object = {module:80, action:108, request:[Utils.IntUtil], response:[]};
        public static const get_monster_strategy_list:Object = {module:80, action:75, request:[Utils.IntUtil], response:[Utils.IntUtil, [Utils.StringUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil]]};
        public static const get_player_war_report:Object = {module:80, action:159, request:[Utils.IntUtil], response:[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]], [Utils.IntUtil, Utils.IntUtil], [Utils.IntUtil, Utils.ByteUtil], [Utils.IntUtil, Utils.ByteUtil], [[Utils.StringUtil, [Utils.StringUtil, Utils.StringUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]], [Utils.StringUtil, [Utils.StringUtil, Utils.StringUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]], Utils.IntUtil, Utils.ByteUtil, Utils.ShortUtil, Utils.ShortUtil]};
        public static const random_item:Object = {module:80, action:119, request:[], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const fetch_random_item:Object = {module:80, action:208, request:[Utils.IntUtil], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const Actions:Array = ["get_sections", "enter_mission", "fight_monster", "rank_mission", "open_box", "pickup_award", "sign_play_mission_video", "get_monster_strategy_list", "get_player_war_report", "random_item", "fetch_random_item"];

        public function Mod_Mission_Base()
        {
            return;
        }// end function

    }
}
