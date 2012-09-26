package com.assist.view.interfaces
{
    import flash.display.*;

    public interface INPCDialog
    {

        public function INPCDialog();

        function get content() : Sprite;

        function set iconUrl(param1:String) : void;

        function set data(param1:Array) : void;

        function set npcId(param1:int) : void;

        function get npcId() : int;

        function set npcSign(param1:String) : void;

        function set npcName(param1:String) : void;

        function set npcMessage(param1:String) : void;

        function set npcFeature(param1:String) : void;

        function set npcSlaveFeature(param1:String) : void;

        function set featureNPCTalk(param1:Array) : void;

        function set slaveFeatureNPCTalk(param1:Array) : void;

        function set onClose(param1:Function) : void;

        function set onFeature(param1:Function) : void;

        function set onSlaveFeature(param1:Function) : void;

        function set onAccept(param1:Function) : void;

        function set onComplete(param1:Function) : void;

        function set onAcceptNextForGuide(param1:Function) : void;

        function set onAcceptLastForGuide(param1:Function) : void;

        function show() : void;

        function clear() : void;

    }
}
