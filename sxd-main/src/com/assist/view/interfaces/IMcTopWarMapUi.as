package com.assist.view.interfaces
{
    import flash.geom.*;

    public interface IMcTopWarMapUi extends IContent
    {

        public function IMcTopWarMapUi();

        function set teamList(param1:Array) : void;

        function set otherTeamList(param1:Array) : void;

        function set onWar(param1:Function) : void;

        function set onOutFun(param1:Function) : void;

        function set onOpenDeploy(param1:Function) : void;

        function set onDeploy(param1:Function) : void;

        function deployList(param1:Array, param2:int) : void;

        function set openChangeRolePanel(param1:Function) : void;

        function set myRoleList(param1:Array) : void;

        function set changeRole(param1:Function) : void;

        function set onShowPlayerInfoView(param1:Function) : void;

        function set uiState(param1:int) : void;

        function set onCloseWindow(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function set onOtherTeam(param1:Function) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

        function clear() : void;

    }
}
