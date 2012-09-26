package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IActivityWindow
    {

        public function IActivityWindow();

        function get content() : MovieClip;

        function set buttonEffect(param1:Class) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onClose(param1:Function) : void;

        function moveFileInfo(param1:String, param2:String) : void;

        function set onStartActivity(param1:Function) : void;

        function set onIsCheck(param1:Function) : void;

        function set activityList(param1:Array) : void;

        function set activityUrl(param1:String) : void;

        function clear() : void;

    }
}
