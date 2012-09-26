package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IMultiMission
    {

        public function IMultiMission();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function set onShowJoinTeamLimity(param1:Function) : void;

        function set visibleSystemInfo(param1:Boolean) : void;

        function set openFastJoin(param1:Boolean) : void;

        function set renderSystemInfo(param1:String) : void;

        function set onMinTarget(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function set onClear(param1:Function) : void;

        function set onRandomJoin(param1:Function) : void;

        function set getJoinLimit(param1:Array) : void;

        function set onJoinTeamLimit(param1:Function) : void;

        function set getJoinTeamList(param1:Array) : void;

        function set getJoinTeamData(param1:Object) : void;

        function set onJoin(param1:Function) : void;

        function set dropTeam(param1:int) : void;

        function set getTeamMemberNum(param1:Object) : void;

        function set getCreateLimit(param1:Array) : void;

        function set onCreateTeam(param1:Function) : void;

        function set getTeamListData(param1:Object) : void;

        function set isAutoStart(param1:Boolean) : void;

        function set onLeftTeam(param1:Function) : void;

        function set onStart(param1:Function) : void;

        function set onAutoStart(param1:Function) : void;

        function set onKickedOutMember(param1:Function) : void;

        function set onTeamLabel(param1:Function) : void;

    }
}
