package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IRedEnvelopes
    {

        public function IRedEnvelopes();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onClose(param1:Function) : void;

        function clear() : void;

        function set onTip(param1:Function) : void;

        function set onGetEnvelope(param1:Function) : void;

        function getPackedList(param1:Array) : void;

        function set lostTimeInfo(param1:String) : void;

    }
}
