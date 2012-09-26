package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IWeekRanking
    {

        public function IWeekRanking();

        function get content() : MovieClip;

        function clear() : void;

        function set onClose(param1:Function) : void;

        function getWeekRankingData(param1:Object) : void;

        function close() : void;

        function init() : void;

        function set tip(param1:ITip) : void;

        function set onShowPlayerInfo(param1:Function) : void;

    }
}
