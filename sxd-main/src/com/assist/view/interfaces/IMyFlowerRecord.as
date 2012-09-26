package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IMyFlowerRecord
    {

        public function IMyFlowerRecord();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function init() : void;

        function clear() : void;

        function renderMyFlowerRecord(param1:Object, param2:Array) : void;

        function renderSendFlowerRanking(param1:Array) : void;

        function set onTextLink(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onQueryFlower(param1:Function) : void;

    }
}
