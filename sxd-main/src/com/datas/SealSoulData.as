package com.datas
{
    import com.haloer.data.*;

    public class SealSoulData extends Base
    {
        public var SoulInfoList:Array;
        public var itemInfo:Array;
        public var equipPlayerSoul:Array;
        public var removePlayerSoul:Array;
        public var swapSoul:Array;
        public var moveSoul:Array;
        public var openSoulKey:Array;
        public var getResetCount:Array;
        public var getStoneCount:Array;
        public var soulAtributeReset:Array;
        public var getTowerKey:Array;
        public var sellPlayerSoul:Array;
        public var tenTimesReset:Array;
        public var playerSoulValue:Array;
        public var notifyGet:Object;
        public var getDayStone:Object;
        public var dayStoneCount:Object;
        public var swapSealSoul:Object;
        public var LockData:Array;
        public var WillToUnlock:Array;
        public var SaveLock:Array;
        public var UpBuff:Array;

        public function SealSoulData()
        {
            this.notifyGet = {};
            this.getDayStone = {};
            this.dayStoneCount = {};
            this.swapSealSoul = {};
            return;
        }// end function

        public function soul_info_by_location(param1:Array) : void
        {
            this.SoulInfoList = param1[0];
            return;
        }// end function

        public function get_item_info_by_role_id(param1:Array) : void
        {
            this.itemInfo = param1;
            return;
        }// end function

        public function equip_player_soul(param1:Array) : void
        {
            this.equipPlayerSoul = param1;
            return;
        }// end function

        public function remove_player_soul(param1:Array) : void
        {
            this.removePlayerSoul = param1;
            return;
        }// end function

        public function swap_soul(param1:Array) : void
        {
            this.swapSoul = param1;
            return;
        }// end function

        public function move_soul(param1:Array) : void
        {
            this.moveSoul = param1;
            return;
        }// end function

        public function open_player_soul_key(param1:Array) : void
        {
            this.openSoulKey = param1;
            return;
        }// end function

        public function soul_attribute_reset(param1:Array) : void
        {
            this.soulAtributeReset = param1;
            return;
        }// end function

        public function get_tower_key(param1:Array) : void
        {
            this.getTowerKey = param1;
            return;
        }// end function

        public function sell_player_soul(param1:Array) : void
        {
            this.sellPlayerSoul = param1;
            return;
        }// end function

        public function get_ten_times_reset_value(param1:Array) : void
        {
            this.tenTimesReset = param1;
            return;
        }// end function

        public function set_player_soul_value(param1:Array) : void
        {
            this.playerSoulValue = param1;
            return;
        }// end function

        public function get_reset_count(param1:Array) : void
        {
            this.getResetCount = param1;
            return;
        }// end function

        public function get_stone_count(param1:Array) : void
        {
            this.getStoneCount = param1;
            return;
        }// end function

        public function lock(param1:Array) : void
        {
            this.LockData = param1;
            return;
        }// end function

        public function will_to_unlock(param1:Array) : void
        {
            this.WillToUnlock = param1;
            return;
        }// end function

        public function get_item_info_by_player_item_id(param1:Array) : void
        {
            _data.item.get_item_info_by_player_item_id(param1);
            return;
        }// end function

        public function notify_get(param1:Array) : void
        {
            oObject.list(param1, this.notifyGet, ["state"]);
            return;
        }// end function

        public function get_day_stone(param1:Array) : void
        {
            oObject.list(param1, this.getDayStone, ["state", "stone_coun"]);
            return;
        }// end function

        public function day_stone_count(param1:Array) : void
        {
            oObject.list(param1, this.dayStoneCount, ["count"]);
            return;
        }// end function

        public function swap_seal_soul(param1:Array) : void
        {
            oObject.list(param1, this.swapSealSoul, ["state"]);
            return;
        }// end function

        public function save_lock(param1:Array) : void
        {
            this.SaveLock = param1;
            return;
        }// end function

        public function up_buff(param1:Array) : void
        {
            this.UpBuff = param1;
            return;
        }// end function

    }
}
