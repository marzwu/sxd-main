﻿package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Faction_Base extends Object
    {
        public static const YES:int = 0;
        public static const NO:int = 1;
        public static const ACTION_SUCCESS:int = 2;
        public static const CAMP_ERR:int = 3;
        public static const INSUFFICIENT_COIN:int = 4;
        public static const NOT_FREE_PLAYER:int = 5;
        public static const FOUND_ONE_FACTION:int = 6;
        public static const FACTION_NAME_EXISTED:int = 7;
        public static const FACTION_NAME_INVALID:int = 8;
        public static const FACTION_DESC_INVALID:int = 9;
        public static const FACTION_NOT_EXIST:int = 10;
        public static const NOT_FACTION_MASTER:int = 11;
        public static const IN_FACTION_WAR:int = 12;
        public static const AWARDING_ROLL_CAKE:int = 13;
        public static const IN_WORLD_FACTION_WAR:int = 14;
        public static const REQUEST_NUM_LIMIT:int = 15;
        public static const FACTION_REQUESTING:int = 16;
        public static const REQUEST_NOT_EXIST:int = 17;
        public static const FACTION_NO_EXIST:int = 18;
        public static const NO_MANAGER_AUTH:int = 19;
        public static const FACTION_SIZE_LIMIT:int = 20;
        public static const FACTION_MANAGE_NO_PERMIT:int = 21;
        public static const MEMBER_NO_EXIST:int = 22;
        public static const MANAGER_NUM_LIMIT:int = 23;
        public static const HAD_FACTION_JOB:int = 24;
        public static const JOB_NOT_EXIST:int = 25;
        public static const WFW_GIFT:int = 26;
        public static const FACTION_NOTICE_INVALID:int = 27;
        public static const NO_FACTION_JOB:int = 28;
        public static const NOT_FACTION_MEMBER:int = 29;
        public static const FACTION_MASTER:int = 30;
        public static const NOT_FACTION_JOB:int = 31;
        public static const SUCCESS:int = 32;
        public static const OFFERINGS_NO_EXIST:int = 33;
        public static const COUNT_USED:int = 34;
        public static const INSUFFICIENT_INGOT:int = 35;
        public static const NO_ENOUGTH_VIP:int = 36;
        public static const INSUFFICIENT_SKILL:int = 37;
        public static const BLESSING_TIMES:int = 38;
        public static const COIN_ADD:int = 39;
        public static const NEW_MEMBER:int = 40;
        public static const QUIT_FACTION:int = 41;
        public static const KICKOUT_MEMBER:int = 42;
        public static const MASTER_TRANSFER:int = 43;
        public static const DISMISS_JOB:int = 44;
        public static const APPOINT_JOB:int = 45;
        public static const INCENSE:int = 46;
        public static const CALL_SEAL_SATAN:int = 47;
        public static const CALL_EAT:int = 48;
        public static const JOIN_EAT:int = 49;
        public static const CALL_EAT_AEARD:int = 50;
        public static const FACTION_ROLL_CAKE:int = 51;
        public static const FACTION_ROLL_CAKE_SCORE_AWARD:int = 52;
        public static const FACTION_ROLL_CAKE_JOIN_COUNT_AWARD:int = 53;
        public static const JOIN_SUCCESS:int = 54;
        public static const IS_JOIN:int = 55;
        public static const FULL_MEMBER:int = 56;
        public static const TEAM_EXPIRED:int = 57;
        public static const CALL_SUCCESS:int = 58;
        public static const FULL_NPC:int = 59;
        public static const NOT_JOIN:int = 60;
        public static const ERROR:int = 61;
        public static const KEEP:int = 62;
        public static const HELP:int = 63;
        public static const AWARD:int = 64;
        public static const TODAY_IS_CALL:int = 65;
        public static const IS_CALL:int = 66;
        public static const TIME_UP:int = 67;
        public static const NO_BANQUET:int = 68;
        public static const IS_EAT:int = 69;
        public static const FAIL:int = 70;
        public static const IS_MASTER:int = 71;
        public static const NO_ENOUGH_TIMES:int = 72;
        public static const found_faction:Object = {module:100, action:234, request:[Utils.StringUtil, Utils.StringUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const disband_faction:Object = {module:100, action:10, request:[Utils.IntUtil], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const faction_request:Object = {module:100, action:57, request:[Utils.IntUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const cancel_request:Object = {module:100, action:92, request:[Utils.IntUtil], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const accept_request:Object = {module:100, action:222, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const deny_request:Object = {module:100, action:175, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const appoint_job:Object = {module:100, action:3, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const dismiss_job:Object = {module:100, action:48, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const kickout_member:Object = {module:100, action:134, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const master_transfer:Object = {module:100, action:63, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const faction_list:Object = {module:100, action:17, request:[Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], response:[Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil]]};
        public static const request_list:Object = {module:100, action:103, request:[Utils.IntUtil], response:[[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const member_list:Object = {module:100, action:39, request:[Utils.IntUtil, Utils.StringUtil], response:[[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const modify_faction_desc:Object = {module:100, action:24, request:[Utils.IntUtil, Utils.StringUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const modify_faction_notice:Object = {module:100, action:197, request:[Utils.IntUtil, Utils.StringUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const quit_faction:Object = {module:100, action:4, request:[], response:[Utils.ByteUtil]};
        public static const quit_job:Object = {module:100, action:147, request:[], response:[Utils.ByteUtil]};
        public static const my_faction_info:Object = {module:100, action:7, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const found_faction_coin:Object = {module:100, action:136, request:[], response:[Utils.IntUtil]};
        public static const modify_group_number:Object = {module:100, action:231, request:[Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const faction_contribution_list:Object = {module:100, action:183, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const faction_god_info:Object = {module:100, action:180, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const incense:Object = {module:100, action:42, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const get_blessing_count:Object = {module:100, action:203, request:[], response:[Utils.IntUtil, Utils.IntUtil]};
        public static const blessing_count_change:Object = {module:100, action:228, request:[], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const faction_message_notify:Object = {module:100, action:216, request:[], response:[Utils.ByteUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const clean_faction_request:Object = {module:100, action:206, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const join_seal_satan:Object = {module:100, action:30, request:[], response:[Utils.ByteUtil]};
        public static const seal_satan_call_npc:Object = {module:100, action:158, request:[], response:[Utils.ByteUtil]};
        public static const seal_satan_join_notify:Object = {module:100, action:200, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]]};
        public static const seal_satan_call_faction_member:Object = {module:100, action:123, request:[], response:[Utils.ByteUtil]};
        public static const seal_satan_info:Object = {module:100, action:135, request:[], response:[Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const seal_satan_award_notify:Object = {module:100, action:212, request:[], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const seal_satan_member_list:Object = {module:100, action:181, request:[], response:[[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]]};
        public static const close_seal_satan:Object = {module:100, action:230, request:[], response:[Utils.ByteUtil]};
        public static const call_eat_info:Object = {module:100, action:174, request:[], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const call_eat:Object = {module:100, action:97, request:[], response:[Utils.ByteUtil]};
        public static const call_eat_detailed_info:Object = {module:100, action:235, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const join_eat:Object = {module:100, action:226, request:[], response:[Utils.ByteUtil]};
        public static const get_faction_level:Object = {module:100, action:236, request:[], response:[Utils.IntUtil]};
        public static const is_can_join_activity:Object = {module:100, action:38, request:[], response:[Utils.ByteUtil]};
        public static const get_faction_master_trace:Object = {module:100, action:245, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const seize_the_throne:Object = {module:100, action:77, request:[], response:[Utils.ByteUtil]};
        public static const faction_roll_cake_remain_times:Object = {module:100, action:76, request:[], response:[Utils.ByteUtil]};
        public static const faction_roll_cake_info:Object = {module:100, action:12, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, Utils.IntUtil]]};
        public static const roll_cake:Object = {module:100, action:20, request:[], response:[Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, [Utils.ByteUtil]]};
        public static const receive_call_join_faction:Object = {module:100, action:82, request:[], response:[Utils.IntUtil, Utils.StringUtil]};
        public static const invite_info:Object = {module:100, action:151, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const Actions:Array = ["found_faction", "disband_faction", "faction_request", "cancel_request", "accept_request", "deny_request", "appoint_job", "dismiss_job", "kickout_member", "master_transfer", "faction_list", "request_list", "member_list", "modify_faction_desc", "modify_faction_notice", "quit_faction", "quit_job", "my_faction_info", "found_faction_coin", "modify_group_number", "faction_contribution_list", "faction_god_info", "incense", "get_blessing_count", "blessing_count_change", "faction_message_notify", "clean_faction_request", "join_seal_satan", "seal_satan_call_npc", "seal_satan_join_notify", "seal_satan_call_faction_member", "seal_satan_info", "seal_satan_award_notify", "seal_satan_member_list", "close_seal_satan", "call_eat_info", "call_eat", "call_eat_detailed_info", "join_eat", "get_faction_level", "is_can_join_activity", "get_faction_master_trace", "seize_the_throne", "faction_roll_cake_remain_times", "faction_roll_cake_info", "roll_cake", "receive_call_join_faction", "invite_info"];

        public function Mod_Faction_Base()
        {
            return;
        }// end function

    }
}
