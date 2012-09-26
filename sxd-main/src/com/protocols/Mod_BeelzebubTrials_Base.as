package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_BeelzebubTrials_Base extends Object
    {
        public static const NOT_LIMIT:int = 0;
        public static const SAME_GANG:int = 1;
        public static const ALL_RECORD:int = 2;
        public static const SUCCESS:int = 3;
        public static const INVALID_BEELZEBUB_TRIALS_ID:int = 4;
        public static const FULL_TEAM_NUMBER:int = 5;
        public static const INVALID_TEAM_ID:int = 6;
        public static const FULL_MEMBER:int = 7;
        public static const NOT_SAME_CANO:int = 8;
        public static const NOT_SAME_GANG:int = 9;
        public static const FAILED:int = 10;
        public static const DEPLOY:int = 11;
        public static const NODEPLOY:int = 12;
        public static const LIMIT_MEMBER_NUMBER:int = 13;
        public static const NO_LEADER:int = 14;
        public static const UPDATE_TEAM_INFO:int = 15;
        public static const LEADER_DISSOLVE:int = 16;
        public static const KICK_OUT_TEAM:int = 17;
        public static const HAVE_WAR_RESULT:int = 18;
        public static const START_BEELZEBUB_TRAILS:int = 19;
        public static const STOP_BEELZEBUB_TRAILS:int = 20;
        public static const get_beelzebub_trials_open_time:Object = {module:86, action:7, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil]]};
        public static const open_beelzebub_trials:Object = {module:86, action:1, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [Utils.IntUtil, Utils.StringUtil], [Utils.IntUtil, Utils.StringUtil], Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil]]};
        public static const get_beelzebub_trials_team_list:Object = {module:86, action:166, request:[Utils.IntUtil, Utils.ByteUtil], response:[[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const get_player_team_info:Object = {module:86, action:3, request:[], response:[Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil]]};
        public static const create_beelzebub_trials_team:Object = {module:86, action:103, request:[Utils.IntUtil, Utils.ByteUtil], response:[Utils.ByteUtil]};
        public static const dissolve_beelzebub_trials_team:Object = {module:86, action:80, request:[], response:[]};
        public static const join_beelzebub_trials_team:Object = {module:86, action:83, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const exit_beelzebub_trials_team:Object = {module:86, action:118, request:[], response:[Utils.ByteUtil]};
        public static const get_helper_role_list:Object = {module:86, action:178, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]]};
        public static const choose_helper_role:Object = {module:86, action:202, request:[Utils.IntUtil, Utils.ByteUtil], response:[Utils.ByteUtil]};
        public static const sort_beelzebub_trials_team:Object = {module:86, action:53, request:[Utils.StringUtil], response:[]};
        public static const kicked_out_member:Object = {module:86, action:70, request:[Utils.IntUtil], response:[]};
        public static const close_beelzebub_trials:Object = {module:86, action:61, request:[], response:[]};
        public static const fight_beelzebub_trials:Object = {module:86, action:16, request:[], response:[Utils.ByteUtil]};
        public static const get_war_result:Object = {module:86, action:91, request:[], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil]]};
        public static const notify:Object = {module:86, action:60, request:[], response:[Utils.ByteUtil]};
        public static const leave_beelzebub_trials_war:Object = {module:86, action:247, request:[Utils.IntUtil], response:[]};
        public static const notify_new_team:Object = {module:86, action:227, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const notify_drop_team:Object = {module:86, action:234, request:[], response:[Utils.IntUtil]};
        public static const notify_update_member_number:Object = {module:86, action:174, request:[], response:[Utils.IntUtil, Utils.ByteUtil]};
        public static const check_is_can_challenge:Object = {module:86, action:205, request:[], response:[Utils.ByteUtil]};
        public static const get_player_cd_time:Object = {module:86, action:12, request:[], response:[Utils.ShortUtil]};
        public static const get_player_can_challenge_list:Object = {module:86, action:95, request:[], response:[[Utils.IntUtil]]};
        public static const Actions:Array = ["get_beelzebub_trials_open_time", "open_beelzebub_trials", "get_beelzebub_trials_team_list", "get_player_team_info", "create_beelzebub_trials_team", "dissolve_beelzebub_trials_team", "join_beelzebub_trials_team", "exit_beelzebub_trials_team", "get_helper_role_list", "choose_helper_role", "sort_beelzebub_trials_team", "kicked_out_member", "close_beelzebub_trials", "fight_beelzebub_trials", "get_war_result", "notify", "leave_beelzebub_trials_war", "notify_new_team", "notify_drop_team", "notify_update_member_number", "check_is_can_challenge", "get_player_cd_time", "get_player_can_challenge_list"];

        public function Mod_BeelzebubTrials_Base()
        {
            return;
        }// end function

    }
}
