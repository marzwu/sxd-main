package com.assist.view.interfaces
{

    public interface ITopThrone extends IContent
    {

        public function ITopThrone();

        function set onSeeTeamInfo(param1:Function) : void;

        function set teamList(param1:Array) : void;

        function set sigleTeamInfo(param1:Object) : void;

        function set onOpenTeam(param1:Function) : void;

        function set onCloseWindow(param1:Function) : void;

        function reposition(param1:int, param2:int) : void;

    }
}
