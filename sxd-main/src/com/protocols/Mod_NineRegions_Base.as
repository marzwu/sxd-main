package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_NineRegions_Base extends Object
    {
        public static const CHALLENGE_SUCCESS:int = 0;
        public static const CHALLENGE_LEVEL:int = 1;
        public static const CHALLENGE_TOWER:int = 2;
        public static const CHALLENGE_REGION:int = 3;
        public static const CHALLENGE_OTHER:int = 4;
        public static const SUCCESS:int = 5;
        public static const FAILED:int = 6;
        public static const FULL_TEAM_NUMBER:int = 7;
        public static const INVALID_TEAM_ID:int = 8;
        public static const FULL_MEMBER:int = 9;
        public static const ERROR_REGION:int = 10;
        public static const DEPLOY:int = 11;
        public static const NODEPLOY:int = 12;
        public static const LIMIT_MEMBER_NUMBER:int = 13;
        public static const NO_LEADER:int = 14;
        public static const UPDATE_TEAM_INFO:int = 15;
        public static const LEADER_DISSOLVE:int = 16;
        public static const KICK_OUT_TEAM:int = 17;
        public static const HAVE_WAR_RESULT:int = 18;
        public static const CAN_CHALLENGE_HIDDEN:int = 19;
        public static const CANT_CHALLENGE_HIDDEN:int = 20;
        public static const open_panel:Object = {module:210, action:236, request:[], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const start_challenge:Object = {module:210, action:126, request:[Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil, Utils.ByteUtil]};
        public static const get_player_bless_level:Object = {module:210, action:213, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const open_team_panel:Object = {module:210, action:199, request:[Utils.IntUtil], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil]]};
        public static const get_player_team_info:Object = {module:210, action:133, request:[], response:[Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil]]};
        public static const create_region_team:Object = {module:210, action:178, request:[Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const dissolve_region_team:Object = {module:210, action:252, request:[], response:[]};
        public static const join_region_team:Object = {module:210, action:101, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const exit_region_team:Object = {module:210, action:135, request:[], response:[Utils.ByteUtil]};
        public static const get_helper_role_list:Object = {module:210, action:51, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]]};
        public static const choose_helper_role:Object = {module:210, action:29, request:[Utils.IntUtil, Utils.ByteUtil], response:[Utils.ByteUtil]};
        public static const kick_member:Object = {module:210, action:238, request:[Utils.IntUtil], response:[]};
        public static const close_team_panel:Object = {module:210, action:127, request:[], response:[]};
        public static const fight_region:Object = {module:210, action:140, request:[], response:[Utils.ByteUtil]};
        public static const get_war_result:Object = {module:210, action:208, request:[], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]], [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil]]};
        public static const notify:Object = {module:210, action:139, request:[], response:[Utils.ByteUtil]};
        public static const leave_region_war:Object = {module:210, action:226, request:[Utils.IntUtil], response:[]};
        public static const notify_new_team:Object = {module:210, action:47, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil]};
        public static const notify_drop_team:Object = {module:210, action:134, request:[], response:[Utils.IntUtil]};
        public static const notify_update_member_number:Object = {module:210, action:30, request:[], response:[Utils.IntUtil, Utils.ByteUtil]};
        public static const check_is_can_challenge:Object = {module:210, action:87, request:[Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const get_player_cd_time:Object = {module:210, action:11, request:[], response:[Utils.ShortUtil]};
        public static const sort_region_team:Object = {module:210, action:7, request:[Utils.StringUtil], response:[]};
        public static const challenge_hidden_level:Object = {module:210, action:192, request:[Utils.IntUtil], response:[Utils.ByteUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]]]};
        public static const notify_hidden_level:Object = {module:210, action:42, request:[], response:[Utils.IntUtil]};
        public static const Actions:Array = ["open_panel", "start_challenge", "get_player_bless_level", "open_team_panel", "get_player_team_info", "create_region_team", "dissolve_region_team", "join_region_team", "exit_region_team", "get_helper_role_list", "choose_helper_role", "kick_member", "close_team_panel", "fight_region", "get_war_result", "notify", "leave_region_war", "notify_new_team", "notify_drop_team", "notify_update_member_number", "check_is_can_challenge", "get_player_cd_time", "sort_region_team", "challenge_hidden_level", "notify_hidden_level"];

        public function Mod_NineRegions_Base()
        {
            return;
        }// end function

    }
}
