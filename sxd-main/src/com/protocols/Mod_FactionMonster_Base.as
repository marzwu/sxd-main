package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_FactionMonster_Base extends Object
    {
        public static const OPEN:int = 0;
        public static const CLOSE:int = 1;
        public static const OVER:int = 2;
        public static const SUCCESS:int = 3;
        public static const MONSTER_DEAD:int = 4;
        public static const CD_TIME:int = 5;
        public static const FULL_BAG:int = 6;
        public static const FAILED:int = 7;
        public static const get_status:Object = {module:235, action:160, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil]]};
        public static const get_monster_info:Object = {module:235, action:112, request:[], response:[Utils.ShortUtil, [Utils.IntUtil]]};
        public static const start_fight:Object = {module:235, action:91, request:[Utils.IntUtil], response:[Utils.ByteUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]], Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const notify:Object = {module:235, action:121, request:[], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const join:Object = {module:235, action:11, request:[], response:[]};
        public static const get_win_player_list:Object = {module:235, action:198, request:[], response:[[Utils.IntUtil, Utils.StringUtil]]};
        public static const is_can_get_award:Object = {module:235, action:247, request:[], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const get_award:Object = {module:235, action:50, request:[], response:[Utils.ByteUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const notify_get_award:Object = {module:235, action:100, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const Actions:Array = ["get_status", "get_monster_info", "start_fight", "notify", "join", "get_win_player_list", "is_can_get_award", "get_award", "notify_get_award"];

        public function Mod_FactionMonster_Base()
        {
            return;
        }// end function

    }
}
