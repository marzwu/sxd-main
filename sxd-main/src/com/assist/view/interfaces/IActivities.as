package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface IActivities
    {

        public function IActivities();

        function get content() : MovieClip;

        function set buttonEffect(param1:Class) : void;

        function set tip(param1:ITip) : void;

        function set activityVisible(param1:Boolean) : void;

        function set diffTime(param1:int) : void;

        function getActivityPoint(param1:String) : Point;

        function isAutoOpen(param1:Boolean) : void;

        function autoActivityClick(param1:String) : void;

        function set onActivityStart(param1:Function) : void;

        function set onActivityTimerClick(param1:Function) : void;

        function visibleBtnEffect(param1:String, param2:String, param3:Boolean) : void;

        function set activityRuneNum(param1:int) : void;

        function addActivity(param1:String) : void;

        function removeActivity(param1:String) : void;

        function activityTip(param1:String, param2:String) : void;

        function isLoaderActivitie(param1:String) : Boolean;

        function activityTimer(param1:String, param2:Object) : void;

        function hideActivityTimer(param1:String, param2:String) : void;

        function set onMinute(param1:Function) : void;

        function playOpenFunctionMc(param1:Array) : void;

        function set functionOpenPlayEnd(param1:Function) : void;

        function clear() : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

    }
}
