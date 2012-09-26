package com.assist.view.interfaces
{

    public interface IOtherTeamInfo extends IContent, IDragTitleBar
    {

        public function IOtherTeamInfo();

        function set teamInfo(param1:Object) : void;

        function set onSeePlayerInfo(param1:Function) : void;

        function set onClose(param1:Function) : void;

    }
}
