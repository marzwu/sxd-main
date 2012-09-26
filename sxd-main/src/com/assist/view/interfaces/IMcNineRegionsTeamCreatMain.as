package com.assist.view.interfaces
{

    public interface IMcNineRegionsTeamCreatMain extends IContent, IDragTitleBar
    {

        public function IMcNineRegionsTeamCreatMain();

        function setMyJieLv(param1:int, param2:int) : void;

        function initTeamList(param1:Array) : void;

        function addTeam(param1:Object) : void;

        function clearTeamById(param1:int) : void;

        function set onCreatTeam(param1:Function) : void;

        function set onAddTeam(param1:Function) : void;

        function set onCloseWindow(param1:Function) : void;

        function updateMember(param1:int, param2:int) : void;

    }
}
