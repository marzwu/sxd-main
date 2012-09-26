package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IRanking
    {

        public function IRanking();

        function get content() : MovieClip;

        function render() : void;

        function clear() : void;

        function set onSecondRankingData(param1:Function) : void;

        function set onRankingFieldData(param1:Function) : void;

        function set onRankingData(param1:Function) : void;

        function set onMyRankingBtn(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set playerID(param1:String) : void;

        function get playerID() : String;

        function set secondRankingID(param1:String) : void;

        function get secondRankingID() : String;

        function get firstRankingType() : String;

        function set pageCurrent(param1:int) : void;

        function get pageCurrent() : int;

        function set pageCount(param1:int) : void;

    }
}
