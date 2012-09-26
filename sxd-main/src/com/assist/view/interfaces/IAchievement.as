package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IAchievement
    {

        public function IAchievement();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function init() : void;

        function renderAchievementList(param1:Array) : void;

        function gotoAchievementLabel(param1:int) : void;

    }
}
