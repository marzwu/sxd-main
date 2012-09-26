package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IGameMaster
    {

        public function IGameMaster();

        function get content() : Sprite;

        function set nickName(param1:String) : void;

        function set bbsUrl(param1:String) : void;

        function set remainSubmitTimes(param1:int) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set alert(param1:IAlert) : void;

        function set onClose(param1:Function) : void;

        function init(param1:int) : void;

        function clear() : void;

        function set onSubmit(param1:Function) : void;

        function set renderSubmitBug(param1:Array) : void;

        function set onGetBugList(param1:Function) : void;

        function set onSubmitAssess(param1:Function) : void;

        function renderSubmitAssessComplete(param1:int) : void;

        function set renderBugList(param1:Array) : void;

    }
}
