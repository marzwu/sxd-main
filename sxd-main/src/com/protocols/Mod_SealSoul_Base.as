package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_SealSoul_Base extends Object
    {
        public static const SUCCEED:int = 0;
        public static const FAILED:int = 1;
        public static const NO_ENOUGH_INGOT:int = 2;
        public static const LOCK:int = 3;
        public static const NO_ENOUGH_COIN:int = 4;
        public static const NO_RECORD:int = 5;
        public static const NO_LOCK:int = 6;
        public static const INVALID_LOCATION:int = 7;
        public static const PLAYER_ERROR:int = 8;
        public static const NOT_ENOUGH_STONE:int = 9;
        public static const NOT_ENOUGH_NINE:int = 10;
        public static const soul_info_by_location:Object = {module:107, action:176, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const swap_soul:Object = {module:107, action:106, request:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const move_soul:Object = {module:107, action:136, request:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const get_item_info_by_role_id:Object = {module:107, action:10, request:[Utils.IntUtil], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const open_player_soul_key:Object = {module:107, action:14, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const soul_attribute_reset:Object = {module:107, action:248, request:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const get_tower_key:Object = {module:107, action:84, request:[], response:[Utils.IntUtil]};
        public static const sell_player_soul:Object = {module:107, action:134, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const get_ten_times_reset_value:Object = {module:107, action:142, request:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const set_player_soul_value:Object = {module:107, action:3, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const get_item_info_by_player_item_id:Object = {module:107, action:166, request:[Utils.IntUtil], response:[Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const get_reset_count:Object = {module:107, action:5, request:[], response:[Utils.IntUtil]};
        public static const get_stone_count:Object = {module:107, action:33, request:[], response:[Utils.IntUtil]};
        public static const lock:Object = {module:107, action:19, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const will_to_unlock:Object = {module:107, action:30, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const notify_get:Object = {module:107, action:183, request:[], response:[Utils.ByteUtil]};
        public static const get_day_stone:Object = {module:107, action:79, request:[Utils.ByteUtil], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const swap_seal_soul:Object = {module:107, action:199, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const day_stone_count:Object = {module:107, action:157, request:[], response:[Utils.IntUtil]};
        public static const save_lock:Object = {module:107, action:54, request:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const up_buff:Object = {module:107, action:127, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const Actions:Array = ["soul_info_by_location", "swap_soul", "move_soul", "get_item_info_by_role_id", "open_player_soul_key", "soul_attribute_reset", "get_tower_key", "sell_player_soul", "get_ten_times_reset_value", "set_player_soul_value", "get_item_info_by_player_item_id", "get_reset_count", "get_stone_count", "lock", "will_to_unlock", "notify_get", "get_day_stone", "swap_seal_soul", "day_stone_count", "save_lock", "up_buff"];

        public function Mod_SealSoul_Base()
        {
            return;
        }// end function

    }
}
