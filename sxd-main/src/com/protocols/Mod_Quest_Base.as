package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Quest_Base extends Object
    {
        public static const MONSTER:int = 0;
        public static const GETITEM:int = 1;
        public static const GETQUESTITEM:int = 2;
        public static const SCENEITEM:int = 3;
        public static const NOONE:int = 4;
        public static const SUCCEED:int = 5;
        public static const FAILED:int = 6;
        public static const PACKFULL:int = 7;
        public static const NONQUEST:int = 8;
        public static const NEWQUEST:int = 9;
        public static const ITEM:int = 10;
        public static const IS_SHOW:int = 11;
        public static const NO_SHOW:int = 12;
        public static const EXITSQUEST:int = 13;
        public static const COMPLETELIMIT:int = 14;
        public static const NOENOUGHLEVEL:int = 15;
        public static const NOENOUGHINGOT:int = 16;
        public static const PACK_FULL:int = 17;
        public static const npc_info_by_npcid:Object = {module:37, action:100, request:[Utils.IntUtil], response:[[Utils.IntUtil, Utils.ByteUtil]]};
        public static const npc_info_by_questid:Object = {module:37, action:92, request:[Utils.IntUtil], response:[Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const accept_quest:Object = {module:37, action:84, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const finish_quest:Object = {module:37, action:237, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const complete_quest:Object = {module:37, action:127, request:[Utils.IntUtil], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil]};
        public static const list_player_quest:Object = {module:37, action:179, request:[], response:[[Utils.IntUtil, Utils.ByteUtil]]};
        public static const giveup_quest:Object = {module:37, action:249, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const can_receive_quest:Object = {module:37, action:135, request:[Utils.IntUtil], response:[[Utils.IntUtil]]};
        public static const town_quest_show:Object = {module:37, action:114, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const day_quest_list:Object = {module:37, action:34, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const day_accept_quest:Object = {module:37, action:253, request:[Utils.IntUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const day_giveup_quest:Object = {module:37, action:230, request:[Utils.IntUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const day_quest_refresh:Object = {module:37, action:166, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const day_now_complete:Object = {module:37, action:108, request:[Utils.IntUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const day_get_award:Object = {module:37, action:69, request:[Utils.IntUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const day_quest_refresh_star:Object = {module:37, action:248, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const finish_all_day_quest:Object = {module:37, action:202, request:[], response:[Utils.ByteUtil]};
        public static const Actions:Array = ["npc_info_by_npcid", "npc_info_by_questid", "accept_quest", "finish_quest", "complete_quest", "list_player_quest", "giveup_quest", "can_receive_quest", "town_quest_show", "day_quest_list", "day_accept_quest", "day_giveup_quest", "day_quest_refresh", "day_now_complete", "day_get_award", "day_quest_refresh_star", "finish_all_day_quest"];

        public function Mod_Quest_Base()
        {
            return;
        }// end function

    }
}
