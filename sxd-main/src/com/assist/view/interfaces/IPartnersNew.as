package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IPartnersNew
    {

        public function IPartnersNew();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function init() : void;

        function clear() : void;

        function getPartnersList(param1:Array) : void;

        function set onInvitation(param1:Function) : void;

        function set onCheckInfo(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function getPlayerFameLevel(param1:int, param2:int) : void;

        function getTeamPesonNum(param1:int, param2:int) : void;

    }
}
