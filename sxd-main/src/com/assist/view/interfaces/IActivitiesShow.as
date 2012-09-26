package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface IActivitiesShow
    {

        public function IActivitiesShow();

        function get content() : MovieClip;

        function closePanel() : void;

        function addActivity(param1:Object) : void;

        function removeActivity(param1:Object) : void;

        function openPanel(param1:Point) : void;

        function set onStartActivity(param1:Function) : void;

        function get isOnStage() : Boolean;

        function get isEmpty() : Boolean;

        function set notCloseViewList(param1:Array) : void;

        function set updatePoint(param1:Point) : void;

    }
}
