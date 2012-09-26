package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IFlowerWeekRanking
    {

        public function IFlowerWeekRanking();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function renderRankingList(param1:Array) : void;

        function init() : void;

        function clear() : void;

        function set onClose(param1:Function) : void;

        function set onTextLink(param1:Function) : void;

        function set onIconClick(param1:Function) : void;

    }
}
