package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Town_Base extends Object
    {
        public static const SUCCESS:int = 0;
        public static const FAILED:int = 1;
        public static const FULL:int = 2;
        public static const NOT_ENOUGH_INGOT:int = 3;
        public static const ON_PRACTICE:int = 4;
        public static const OFF_PRACTICE:int = 5;
        public static const FINISHED_PRACTICE:int = 6;
        public static const TYPE_NONE:int = 7;
        public static const TYPE_PARTNER:int = 8;
        public static const TYPE_PET:int = 9;
        public static const TYPE_CAT:int = 10;
        public static const enter_town:Object = {module:94, action:217, request:[Utils.IntUtil], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const leave_town:Object = {module:94, action:65, request:[], response:[Utils.IntUtil]};
        public static const move_to:Object = {module:94, action:159, request:[Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil], response:[Utils.IntUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.ShortUtil]};
        public static const get_players:Object = {module:94, action:137, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.StringUtil, Utils.ShortUtil, Utils.ShortUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const player_follow_role_change:Object = {module:94, action:203, request:[], response:[Utils.IntUtil, Utils.IntUtil]};
        public static const player_count:Object = {module:94, action:0, request:[], response:[Utils.IntUtil]};
        public static const player_follow_setting_change:Object = {module:94, action:224, request:[], response:[Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil]};
        public static const Actions:Array = ["enter_town", "leave_town", "move_to", "get_players", "player_follow_role_change", "player_count", "player_follow_setting_change"];

        public function Mod_Town_Base()
        {
            return;
        }// end function

    }
}
