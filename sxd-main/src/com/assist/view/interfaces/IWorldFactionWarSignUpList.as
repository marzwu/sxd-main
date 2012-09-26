package com.assist.view.interfaces
{

    public interface IWorldFactionWarSignUpList extends IContent, IDragTitleBar
    {

        public function IWorldFactionWarSignUpList();

        function set onClose(param1:Function) : void;

        function set onLink(param1:Function) : void;

        function set myRank(param1:int) : void;

        function initRank(param1:Array) : void;

        function set bBaoMingTime(param1:Boolean) : void;

    }
}
