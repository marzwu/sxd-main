package com.assist.view.interfaces.factionWar
{

    public interface IFactionWarSignUpList extends IContent, IDragTitleBar
    {

        public function IFactionWarSignUpList();

        function set onClose(param1:Function) : void;

        function initRank(param1:String, param2:Array) : void;

    }
}
