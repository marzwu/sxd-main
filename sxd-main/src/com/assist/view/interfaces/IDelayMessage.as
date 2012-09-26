package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IDelayMessage
    {

        public function IDelayMessage();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set dialog(param1:IAlert) : void;

        function set whenDelayMessageDialogShow(param1:Function) : void;

        function set specialDelayMessage(param1:Function) : void;

        function set removeNickNameSuffix(param1:Function) : void;

        function init() : void;

        function addMessage(param1:Object) : void;

        function addOverrideMessage(param1:int) : void;

        function addLimitMessage(param1:Array, param2:int) : void;

        function reposition(param1:Number, param2:Number) : void;

    }
}
