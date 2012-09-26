package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_TopWar_Base extends Object
    {
        public static const YES:int = 0;
        public static const NO:int = 1;
        public static const SUCCESS:int = 2;
        public static const TOP_WAR_NOT_OPEN:int = 3;
        public static const NOT_ENOUGTH_LEVEL:int = 4;
        public static const HAVE_TEAM:int = 5;
        public static const IN_TEAM:int = 6;
        public static const FULL_TEAM_NUMBER:int = 7;
        public static const TIMES_USE:int = 8;
        public static const INVALID_TEAM_ID:int = 9;
        public static const FULL_MEMBER:int = 10;
        public static const FAILED:int = 11;
        public static const DEPLOY:int = 12;
        public static const NODEPLOY:int = 13;
        public static const UPDATE_TEAM_INFO:int = 14;
        public static const LEADER_DISSOLVE:int = 15;
        public static const KICK_OUT_TEAM:int = 16;
        public static const START_MATCH:int = 17;
        public static const START_TOP_WAR:int = 18;
        public static const STOP_TOP_WAR:int = 19;
        public static const OPEN:int = 20;
        public static const CLOSE:int = 21;
        public static const open_top_war:Object = {module:238, action:244, request:[], response:[Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil], Utils.ByteUtil]};
        public static const close_top_war:Object = {module:238, action:166, request:[], response:[]};
        public static const create_team:Object = {module:238, action:141, request:[], response:[Utils.ByteUtil]};
        public static const dissolve_team:Object = {module:238, action:56, request:[], response:[]};
        public static const join_team:Object = {module:238, action:26, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const exit_team:Object = {module:238, action:18, request:[], response:[Utils.ByteUtil]};
        public static const kicked_out_member:Object = {module:238, action:10, request:[Utils.IntUtil], response:[]};
        public static const notify_new_team:Object = {module:238, action:186, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil]};
        public static const notify_drop_team:Object = {module:238, action:241, request:[], response:[Utils.IntUtil]};
        public static const notify_update_team:Object = {module:238, action:139, request:[], response:[Utils.IntUtil, Utils.ByteUtil]};
        public static const get_player_team_info:Object = {module:238, action:123, request:[], response:[Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const helper_role_list:Object = {module:238, action:16, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]]};
        public static const choose_helper_role:Object = {module:238, action:100, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const deploy_list:Object = {module:238, action:212, request:[], response:[Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]]};
        public static const change_position:Object = {module:238, action:184, request:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const match:Object = {module:238, action:143, request:[], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const get_war_result:Object = {module:238, action:137, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]], Utils.IntUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil]};
        public static const notify:Object = {module:238, action:19, request:[], response:[Utils.ByteUtil]};
        public static const score_rank:Object = {module:238, action:45, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const get_top_war_state:Object = {module:238, action:148, request:[], response:[Utils.ByteUtil]};
        public static const Actions:Array = ["open_top_war", "close_top_war", "create_team", "dissolve_team", "join_team", "exit_team", "kicked_out_member", "notify_new_team", "notify_drop_team", "notify_update_team", "get_player_team_info", "helper_role_list", "choose_helper_role", "deploy_list", "change_position", "match", "get_war_result", "notify", "score_rank", "get_top_war_state"];

        public function Mod_TopWar_Base()
        {
            return;
        }// end function

    }
}
