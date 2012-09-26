package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_SuperSport_Base extends Object
    {
        public static const SUCCESS:int = 0;
        public static const INVALID_RANKING:int = 1;
        public static const NOT_ENOUGH_CHALLENGE_TIMES:int = 2;
        public static const HAVE_CD_TIME:int = 3;
        public static const NOT_IN_CHALLENGE_TIME:int = 4;
        public static const NOT_ENOUGH_INGOT:int = 5;
        public static const FULL_BUY_TIMES:int = 6;
        public static const START_AWARD:int = 7;
        public static const END_AWARD:int = 8;
        public static const WIN_TOP:int = 9;
        public static const KILL_WIN_TOP:int = 10;
        public static const RANKING_TOP:int = 11;
        public static const UPDATE_RANKING_TOP:int = 12;
        public static const AWARD_TOP:int = 13;
        public static const open_super_sport:Object = {module:109, action:31, request:[], response:[Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil]]};
        public static const get_challenge_list:Object = {module:109, action:34, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const start_challenge:Object = {module:109, action:91, request:[Utils.IntUtil], response:[Utils.ByteUtil, Utils.ShortUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]]]]};
        public static const clear_cd_time:Object = {module:109, action:164, request:[], response:[Utils.ByteUtil]};
        public static const buy_challenge_times:Object = {module:109, action:112, request:[], response:[Utils.ByteUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil]};
        public static const notify_new_sport_war_report:Object = {module:109, action:74, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil]};
        public static const notify:Object = {module:109, action:122, request:[], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const close_super_sport:Object = {module:109, action:150, request:[], response:[]};
        public static const get_player_war_report:Object = {module:109, action:178, request:[Utils.IntUtil], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]]]};
        public static const get_ranking_top:Object = {module:109, action:29, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.ShortUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ShortUtil]]};
        public static const notify_update_win_top:Object = {module:109, action:121, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil]};
        public static const notify_global:Object = {module:109, action:26, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil], [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil], [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil], [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil], [Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const get_cd_time:Object = {module:109, action:109, request:[], response:[Utils.IntUtil]};
        public static const get_challenge_times:Object = {module:109, action:21, request:[], response:[Utils.IntUtil]};
        public static const Actions:Array = ["open_super_sport", "get_challenge_list", "start_challenge", "clear_cd_time", "buy_challenge_times", "notify_new_sport_war_report", "notify", "close_super_sport", "get_player_war_report", "get_ranking_top", "notify_update_win_top", "notify_global", "get_cd_time", "get_challenge_times"];

        public function Mod_SuperSport_Base()
        {
            return;
        }// end function

    }
}
