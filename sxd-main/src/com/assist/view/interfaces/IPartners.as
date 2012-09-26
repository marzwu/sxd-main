package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IPartners
    {

        public function IPartners();

        function get content() : MovieClip;

        function set onCloseBtn(param1:Function) : void;

        function clear() : void;

        function render() : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function get partnersJobType() : int;

        function set isOpenSport(param1:Boolean) : void;

        function set onPartnersData(param1:Function) : void;

        function set onPageBtn(param1:Function) : void;

        function set roleIconUrl(param1:String) : void;

        function set onPartnersItemBtn(param1:Function) : void;

        function set pageCount(param1:int) : void;

        function get pageCount() : int;

        function set pageCurrent(param1:int) : void;

        function get pageCurrent() : int;

        function get partnersID() : int;

        function renderPartnersList(param1:Array) : void;

        function renderRecruitCount(param1:Object) : void;

        function setDataBtn(param1:Array) : void;

        function setPlayerInfo(param1:Object) : void;

    }
}
