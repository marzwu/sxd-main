package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IAchievementComplete
    {

        public function IAchievementComplete();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set onShowAchievement(param1:Function) : void;

        function set onShowTownCartoon(param1:Function) : void;

        function onMcButtonMouseClick() : void;

        function show(param1:Object) : void;

        function reposition(param1:Number, param2:Number) : void;

    }
}
