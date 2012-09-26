package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ILuckyShop
    {

        public function ILuckyShop();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function get itemID() : int;

        function render() : void;

        function clear() : void;

        function renderItemList(param1:Array) : void;

        function renderRefreshInfo(param1:Object) : void;

        function renderLuckyRecordList(param1:Array) : void;

        function renderBuyLuckyShopItem() : void;

        function renderRefreshFail() : void;

        function updateCdTime(param1:int) : void;

        function set onCloseBtn(param1:Function) : void;

        function set onRefreshBtn(param1:Function) : void;

        function set onBuyBtn(param1:Function) : void;

        function set onTextLink(param1:Function) : void;

    }
}
