package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IHaloButtle
    {

        public function IHaloButtle();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set getButtleRoleId(param1:int) : void;

        function clear() : void;

        function init() : void;

        function langInit() : void;

        function set getCid(param1:int) : void;

        function clientUrl(param1:String) : void;

        function getVersion(param1:String) : void;

    }
}
