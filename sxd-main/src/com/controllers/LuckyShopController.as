package com.controllers
{

    public class LuckyShopController extends Base
    {

        public function LuckyShopController()
        {
            return;
        }// end function

        public function getLuckyShopItemList() : Object
        {
            return this._data.luckyShop.getLuckyShopItemList();
        }// end function

        public function getLuckyShopRecordList() : Array
        {
            return this._data.luckyShop.getLuckyShopRecordList();
        }// end function

        public function buyLuckyShopItem() : Object
        {
            return this._data.luckyShop.buyLuckyShopItem();
        }// end function

        public function refreshLuckyShop() : Object
        {
            return this._data.luckyShop.refreshLuckyShop();
        }// end function

        public function get isItemDataReturn() : Boolean
        {
            return this._data.luckyShop.isItemDataReturn;
        }// end function

    }
}
