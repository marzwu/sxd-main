package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IDailyQuest
    {

        public function IDailyQuest();

        function get content() : MovieClip;

        function set onCloseBtn(param1:Function) : void;

        function clear() : void;

        function render() : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set serverTime(param1:int) : void;

        function get questID() : int;

        function set onAbortBtn(param1:Function) : void;

        function set onAcceptBtn(param1:Function) : void;

        function set onCompleteBtn(param1:Function) : void;

        function set onImmeCompleteBtn(param1:Function) : void;

        function set onRefreshBtn(param1:Function) : void;

        function set onFullStarBtn(param1:Function) : void;

        function renderDailyQuestInfo(param1:Object) : void;

    }
}
