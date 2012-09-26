package com.assist.view.interfaces.map
{
    import flash.geom.*;

    public interface IMcBeelzebubTrials extends IContent
    {

        public function IMcBeelzebubTrials();

        function setTeamInfo(param1:Array) : void;

        function set roleList(param1:Array) : void;

        function playerChangeRole(param1:int, param2:int) : void;

        function set onOpenOther(param1:Function) : void;

        function set onExit(param1:Function) : void;

        function set onChangeRole(param1:Function) : void;

        function set onChangeRoleOk(param1:Function) : void;

        function set onShowPlayerInfoView(param1:Function) : void;

        function set onOutFun(param1:Function) : void;

        function set onSortTeam(param1:Function) : void;

        function clear() : void;

        function set onCallHelp(param1:Function) : void;

        function set hasFaction(param1:Boolean) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

    }
}
