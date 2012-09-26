package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IBeelzebubTrials
    {

        public function IBeelzebubTrials();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function getOpenUI(param1:int) : void;

        function set leaderFactionId(param1:int) : void;

        function set nickname(param1:String) : void;

        function clear() : void;

        function set createBeelzebubID(param1:int) : void;

        function set onClose(param1:Function) : void;

        function set teamlist(param1:Array) : void;

        function set createbeelzebublist(param1:Array) : void;

        function set joinbeelzebublist(param1:Array) : void;

        function set onGetTeamList(param1:Function) : void;

        function set challengeTimes(param1:Object) : void;

        function set createganglimit(param1:int) : void;

        function set conditionCurrent(param1:int) : void;

        function set newTeam(param1:Object) : void;

        function set dropTeamID(param1:int) : void;

        function set onJoin(param1:Function) : void;

        function set teamMemberNum(param1:Object) : void;

        function set onCreateTeam(param1:Function) : void;

        function set teamId(param1:int) : void;

        function set onExitTeam(param1:Function) : void;

    }
}
