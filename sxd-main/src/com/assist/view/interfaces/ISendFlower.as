package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ISendFlower
    {

        public function ISendFlower();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function init() : void;

        function clear() : void;

        function renderSendFlowerInfo(param1:Object, param2:Array) : void;

        function renderSendFlowerRanking(param1:Array) : void;

        function set onClose(param1:Function) : void;

        function set onSendFlower(param1:Function) : void;

        function set onQueryFlower(param1:Function) : void;

        function set onTextLink(param1:Function) : void;

        function set onIsValentineDay(param1:Function) : void;

    }
}
