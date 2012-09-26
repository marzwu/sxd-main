package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IRefine extends IContent, IDragTitleBar
    {

        public function IRefine();

        function showLianDan() : void;

        function showLianZhi() : void;

        function set itemMsg(param1:String) : void;

        function set itemUrl(param1:String) : void;

        function set itemNum(param1:int) : void;

        function get itemBox() : Sprite;

        function initList(param1:Array, param2:String) : void;

        function set onAutoMission(param1:Function) : void;

        function set onLianZhi(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function set itemLv(param1:Boolean) : void;

        function set updateItemLv(param1:Function) : void;

        function onSetCookie(param1:Function) : void;

        function onGetCookie(param1:Function) : void;

    }
}
