package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_NewTopWar_Base extends Object
    {
        public static const CLOSE:int = 0;
        public static const SIGN_OPEN:int = 1;
        public static const SIGN_CLOSE:int = 2;
        public static const TAOTAI:int = 3;
        public static const TAOTAI_END:int = 4;
        public static const WORLD_1:int = 5;
        public static const WORLD_1_END:int = 6;
        public static const WORLD_2:int = 7;
        public static const WORLD_2_END:int = 8;
        public static const WORLD_3:int = 9;
        public static const WORLD_3_END:int = 10;
        public static const WORLD_4:int = 11;
        public static const WORLD_4_END:int = 12;
        public static const SUCCESS:int = 13;
        public static const REQUIRE_LEVEL:int = 14;
        public static const TEAM_NAME_INVALID:int = 15;
        public static const TEAM_NAME_EXISTED:int = 16;
        public static const NOT_ENOUGTH_COIN:int = 17;
        public static const IN_OTHER_TEAM:int = 18;
        public static const NOT_OPEN:int = 19;
        public static const ERROR:int = 20;
        public static const REQUEST_NOT_EXISTED:int = 21;
        public static const FULL_MEMBER:int = 22;
        public static const MEMBER_NOT_EXISTED:int = 23;
        public static const TEAM_IS_SIGN:int = 24;
        public static const TEAM_NOT_EXISTED:int = 25;
        public static const DEPLOY:int = 26;
        public static const NODEPLOY:int = 27;
        public static const FAILED:int = 28;
        public static const SIGN_NOT_OPEN:int = 29;
        public static const create_team:Object = {module:211, action:190, request:[Utils.StringUtil], response:[Utils.ByteUtil]};
        public static const disband_team:Object = {module:211, action:8, request:[], response:[Utils.ByteUtil]};
        public static const accept_request:Object = {module:211, action:168, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const deny_request:Object = {module:211, action:188, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const batch_deny_request:Object = {module:211, action:11, request:[], response:[Utils.ByteUtil]};
        public static const kickout_member:Object = {module:211, action:131, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const request:Object = {module:211, action:243, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const cancel_request:Object = {module:211, action:219, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const quit_team:Object = {module:211, action:214, request:[], response:[Utils.ByteUtil]};
        public static const my_team_info:Object = {module:211, action:125, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], Utils.ByteUtil]};
        public static const request_list:Object = {module:211, action:139, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const team_list:Object = {module:211, action:209, request:[Utils.StringUtil, Utils.StringUtil, Utils.IntUtil], response:[Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil], Utils.StringUtil, Utils.StringUtil]};
        public static const helper_role_list:Object = {module:211, action:68, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]]};
        public static const choose_helper_role:Object = {module:211, action:2, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const deploy_list:Object = {module:211, action:62, request:[], response:[Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.ByteUtil]]};
        public static const change_position:Object = {module:211, action:46, request:[Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const sign_list:Object = {module:211, action:233, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const sign:Object = {module:211, action:113, request:[], response:[Utils.ByteUtil]};
        public static const get_top_war_step:Object = {module:211, action:44, request:[], response:[Utils.ByteUtil, Utils.ByteUtil]};
        public static const get_war_report:Object = {module:211, action:40, request:[Utils.IntUtil], response:[Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]], [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil], [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil]]};
        public static const local_war_report_list:Object = {module:211, action:60, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil], [Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, [Utils.StringUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const team_info:Object = {module:211, action:107, request:[Utils.IntUtil], response:[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const update_step:Object = {module:211, action:48, request:[], response:[Utils.ByteUtil]};
        public static const rank_list:Object = {module:211, action:242, request:[], response:[[Utils.StringUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.StringUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const throne:Object = {module:211, action:132, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.StringUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const Actions:Array = ["create_team", "disband_team", "accept_request", "deny_request", "batch_deny_request", "kickout_member", "request", "cancel_request", "quit_team", "my_team_info", "request_list", "team_list", "helper_role_list", "choose_helper_role", "deploy_list", "change_position", "sign_list", "sign", "get_top_war_step", "get_war_report", "local_war_report_list", "team_info", "update_step", "rank_list", "throne"];

        public function Mod_NewTopWar_Base()
        {
            return;
        }// end function

    }
}
