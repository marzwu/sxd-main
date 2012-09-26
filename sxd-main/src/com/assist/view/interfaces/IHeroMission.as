package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IHeroMission
    {

        public function IHeroMission();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set isShowPractice(param1:Boolean) : void;

        function set onPractice(param1:Function) : void;

        function autoMissionId(param1:int, param2:String, param3:int) : void;

        function set onRefresh(param1:Function) : void;

        function set getRefreshData(param1:Object) : void;

        function clear() : void;

        function set onStartMission(param1:Function) : void;

        function set onChangeTown(param1:Function) : void;

        function set getTownIdList(param1:Array) : void;

        function set getTownInfo(param1:Object) : void;

        function set onRefreshHeroMission(param1:Function) : void;

        function set townHeroMission(param1:Array) : void;

        function set openHeroMission(param1:Array) : void;

    }
}
