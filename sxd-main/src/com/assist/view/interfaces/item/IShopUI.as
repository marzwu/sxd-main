package com.assist.view.interfaces.item
{

    public interface IShopUI extends IContent, IBoxPack, IDragTitleBar
    {

        public function IShopUI();

        function initPage(param1:int, param2:int) : void;

        function set tab(param1:int) : void;

        function get tab() : int;

        function set onClose(param1:Function) : void;

        function set onPageCilck(param1:Function) : void;

        function set onTabCilck(param1:Function) : void;

    }
}
