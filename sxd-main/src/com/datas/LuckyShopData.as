package com.datas
{
    import com.assist.server.*;
    import com.assist.view.pack.*;
    import com.haloer.data.*;
    import com.protocols.*;
    import flash.utils.*;

    public class LuckyShopData extends Base
    {
        private var _aryLuckyShopItemList:Array;
        private var _aryLuckyShopRecordList:Array;
        private var _aryBuyLuckyShopItem:Array;
        private var _aryRefreshLuckyShop:Array;
        private var _timeId:int = 0;
        private var _reqList:Array;
        public var isItemDataReturn:Boolean = true;

        public function LuckyShopData()
        {
            this._aryLuckyShopItemList = [];
            this._aryLuckyShopRecordList = [];
            this._aryBuyLuckyShopItem = [];
            this._aryRefreshLuckyShop = [];
            this._reqList = [];
            return;
        }// end function

        public function getLuckyShopItemList() : Object
        {
            var _loc_1:* = this.getItemList(this._aryLuckyShopItemList[0]);
            var _loc_2:Object = {item_list:_loc_1, refresh_hour:this._aryLuckyShopItemList[1], refresh_seconds:this._aryLuckyShopItemList[2], refresh_ingot:this._aryLuckyShopItemList[3]};
            return _loc_2;
        }// end function

        public function getLuckyShopRecordList() : Array
        {
            var _loc_1:Object = null;
            var _loc_3:Array = null;
            var _loc_2:Array = [];
            for each (_loc_3 in this._aryLuckyShopRecordList[0])
            {
                
                _loc_1 = {};
                oObject.list(_loc_3, _loc_1, ["player_id", "player_name", "item_id", "timestamp"]);
                _loc_1["player_name"] = this._data.player.removeNickNameSuffix(_loc_1["player_name"]);
                _loc_1["color"] = ItemType.getItemColor(_loc_1["item_id"]);
                _loc_1["name"] = ItemType.getName(_loc_1["item_id"]);
                if (ItemType.getTypeId(_loc_1["item_id"]) == ItemType.ZaWu)
                {
                    _loc_1["number"] = ItemType.getMaxRepeatNum(ItemType.ZaWu);
                }
                else
                {
                    _loc_1["number"] = null;
                }
                _loc_2.push(_loc_1);
            }
            return _loc_2;
        }// end function

        public function buyLuckyShopItem() : Object
        {
            var _loc_1:Object = {result:this._aryBuyLuckyShopItem[0]};
            return _loc_1;
        }// end function

        public function refreshLuckyShop() : Object
        {
            var _loc_1:Object = {result:this._aryRefreshLuckyShop[0], item_list:this.getItemList(this._aryRefreshLuckyShop[1])};
            return _loc_1;
        }// end function

        private function getItemList(param1:Array) : Array
        {
            var _loc_2:Object = null;
            var _loc_4:Array = null;
            var _loc_5:ItemBasically = null;
            var _loc_3:Array = [];
            for each (_loc_4 in param1)
            {
                
                _loc_2 = {};
                oObject.list(_loc_4, _loc_2, ["item_id", "can_buy"]);
                _loc_5 = ItemBasically.empty;
                _loc_5 = ItemBasically.getBasic(_loc_2["item_id"]);
                _loc_2["coin"] = _loc_5.price;
                _loc_2["color"] = ItemType.getItemColor(_loc_2["item_id"]);
                _loc_2["name"] = ItemType.getName(_loc_2["item_id"]);
                _loc_2["url"] = _loc_5.getImgUrl(0);
                if (ItemType.getTypeId(_loc_2["item_id"]) == ItemType.ZaWu)
                {
                    _loc_2["number"] = ItemType.getMaxRepeatNum(ItemType.ZaWu);
                    _loc_2["coin"] = _loc_2["coin"] * _loc_2["number"];
                }
                else
                {
                    _loc_2["number"] = null;
                }
                if (ItemType.getTypeId(_loc_2["item_id"]) == ItemType.BianShen)
                {
                    _loc_2["sort"] = _loc_2["item_id"] + _loc_2["coin"] * 1000;
                }
                else
                {
                    _loc_2["sort"] = _loc_2["item_id"] + _loc_2["coin"];
                }
                _loc_3.push(_loc_2);
            }
            _loc_3.sortOn(["sort"], Array.NUMERIC);
            return _loc_3;
        }// end function

        private function getItemInfo(param1:int) : void
        {
            this.isItemDataReturn = false;
            this._reqList[param1] = [param1];
            if (this._timeId == 0)
            {
                this._timeId = setTimeout(this.get_item_basical_infos, 20);
            }
            return;
        }// end function

        private function get_item_basical_infos() : void
        {
            var _loc_2:Array = null;
            this._timeId = 0;
            var _loc_1:Array = [];
            for each (_loc_2 in this._reqList)
            {
                
                _loc_1.push(_loc_2);
            }
            _data.call(Mod_Item_Base.get_item_basical_infos, this.getItemBasicalInfosCallBack, [_loc_1]);
            return;
        }// end function

        private function getItemBasicalInfosCallBack() : void
        {
            this.isItemDataReturn = true;
            return;
        }// end function

        public function lucky_shop_item_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            this._aryLuckyShopItemList = param1;
            for each (_loc_2 in this._aryLuckyShopItemList[0])
            {
                
                this.getItemInfo(_loc_2[0]);
            }
            return;
        }// end function

        public function lucky_shop_record_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            this._aryLuckyShopRecordList = param1;
            for each (_loc_2 in this._aryLuckyShopRecordList[0])
            {
                
                this.getItemInfo(_loc_2[2]);
            }
            return;
        }// end function

        public function buy_lucky_shop_item(param1:Array) : void
        {
            this._aryBuyLuckyShopItem = param1;
            return;
        }// end function

        public function refresh_lucky_shop(param1:Array) : void
        {
            var _loc_2:Array = null;
            this._aryRefreshLuckyShop = param1;
            for each (_loc_2 in this._aryRefreshLuckyShop[1])
            {
                
                this.getItemInfo(_loc_2[0]);
            }
            return;
        }// end function

    }
}
