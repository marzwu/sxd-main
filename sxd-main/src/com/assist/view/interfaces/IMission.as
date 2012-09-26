package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IMission
    {

        public function IMission();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function set onFcousList(param1:Function) : void;

        function autoMissionId(param1:int, param2:String, param3:int) : void;

        function set openMissionType(param1:int) : void;

        function set onStartMission(param1:Function) : void;

        function set mainMissionList(param1:Array) : void;

        function set openMainMission(param1:Array) : void;

        function set onStartPractice(param1:Function) : void;

        function set isOpenPractice(param1:Boolean) : void;

        function set onRefreshHeroMission(param1:Function) : void;

        function set townHeroMission(param1:Array) : void;

        function set openHeroMission(param1:Array) : void;

    }
}
