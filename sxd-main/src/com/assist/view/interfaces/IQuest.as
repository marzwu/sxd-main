package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IQuest
    {

        public function IQuest();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set hasTrace(param1:Boolean) : void;

        function set abortVisible(param1:Boolean) : void;

        function set onClose(param1:Function) : void;

        function set onTrace(param1:Function) : void;

        function set onAccepted(param1:Function) : void;

        function set onAcceptable(param1:Function) : void;

        function init() : void;

        function openAcceptedLabel() : void;

        function openAcceptableLabel() : void;

        function renderAccepted(param1:Array) : void;

        function renderAcceptable(param1:Array) : void;

        function renderDetail(param1:Object) : void;

        function set onDetail(param1:Function) : void;

        function set onAccept(param1:Function) : void;

        function set onComplete(param1:Function) : void;

        function set onAbort(param1:Function) : void;

        function set onWayFinding(param1:Function) : void;

        function clear() : void;

        function set acceptBtnVisible(param1:Boolean) : void;

    }
}
