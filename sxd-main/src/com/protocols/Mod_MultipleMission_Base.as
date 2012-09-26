package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_MultipleMission_Base extends Object
    {
        public static const NOT_LIMIT:int = 0;
        public static const SAME_CANO:int = 1;
        public static const SAME_GANG:int = 2;
        public static const ATTACK_ARMY:int = 3;
        public static const DEFENSE_ARMY:int = 4;
        public static const ALL_RECORD:int = 5;
        public static const SUCCESS:int = 6;
        public static const INVALID_MULTIPLE_MISSION_ID:int = 7;
        public static const FULL_TEAM_NUMBER:int = 8;
        public static const INVALID_TEAM_ID:int = 9;
        public static const FULL_MEMBER:int = 10;
        public static const NOT_SAME_CANO:int = 11;
        public static const NOT_SAME_GANG:int = 12;
        public static const LIMIT_MEMBER_NUMBER:int = 13;
        public static const UPDATE_TEAM_INFO:int = 14;
        public static const HAVE_WAR_RESULT:int = 15;
        public static const START_MULTIPLE_MISSION:int = 16;
        public static const STOP_MULTIPLE_MISSION:int = 17;
        public static const NO_BODY:int = 18;
        public static const open_multiple_mission:Object = {module:174, action:63, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.IntUtil], [Utils.IntUtil, Utils.StringUtil], [Utils.IntUtil, Utils.StringUtil]]};
        public static const get_multiple_mission_team_list:Object = {module:174, action:251, request:[Utils.IntUtil, Utils.ByteUtil], response:[[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.IntUtil]]};
        public static const get_player_team_info:Object = {module:174, action:228, request:[], response:[Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.ShortUtil]]};
        public static const create_multiple_mission_team:Object = {module:174, action:44, request:[Utils.IntUtil, Utils.ByteUtil], response:[Utils.ByteUtil]};
        public static const dissolve_multiple_mission_team:Object = {module:174, action:48, request:[], response:[]};
        public static const join_multiple_mission_team:Object = {module:174, action:6, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const exit_multiple_mission_team:Object = {module:174, action:173, request:[], response:[]};
        public static const sort_multiple_mission_team:Object = {module:174, action:114, request:[Utils.StringUtil], response:[]};
        public static const kicked_out_member:Object = {module:174, action:216, request:[Utils.IntUtil], response:[]};
        public static const close_multiple_mission:Object = {module:174, action:154, request:[], response:[]};
        public static const fight_multiple_mission:Object = {module:174, action:102, request:[], response:[Utils.ByteUtil]};
        public static const get_war_result:Object = {module:174, action:127, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, [Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil], Utils.IntUtil], [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, [Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil], Utils.IntUtil], [[Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]], [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]], [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]]], [Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil], Utils.IntUtil], [Utils.IntUtil, Utils.ShortUtil]]};
        public static const notify:Object = {module:174, action:38, request:[], response:[[Utils.ByteUtil]]};
        public static const get_multiple_mission_status:Object = {module:174, action:162, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil]]};
        public static const leave_multiple_mission_war:Object = {module:174, action:155, request:[Utils.IntUtil], response:[]};
        public static const notify_new_team:Object = {module:174, action:59, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.IntUtil]};
        public static const notify_drop_team:Object = {module:174, action:174, request:[], response:[Utils.IntUtil]};
        public static const notify_update_member_number:Object = {module:174, action:82, request:[], response:[Utils.IntUtil, Utils.ByteUtil]};
        public static const check_is_can_challenge:Object = {module:174, action:43, request:[], response:[Utils.ByteUtil]};
        public static const get_player_cd_time:Object = {module:174, action:55, request:[], response:[Utils.ShortUtil]};
        public static const random_join:Object = {module:174, action:208, request:[], response:[Utils.ByteUtil]};
        public static const Actions:Array = ["open_multiple_mission", "get_multiple_mission_team_list", "get_player_team_info", "create_multiple_mission_team", "dissolve_multiple_mission_team", "join_multiple_mission_team", "exit_multiple_mission_team", "sort_multiple_mission_team", "kicked_out_member", "close_multiple_mission", "fight_multiple_mission", "get_war_result", "notify", "get_multiple_mission_status", "leave_multiple_mission_war", "notify_new_team", "notify_drop_team", "notify_update_member_number", "check_is_can_challenge", "get_player_cd_time", "random_join"];

        public function Mod_MultipleMission_Base()
        {
            return;
        }// end function

    }
}
