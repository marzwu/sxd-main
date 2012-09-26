package com.assist.view.interfaces.map
{

    public interface IFrameSprite extends IContent
    {

        public function IFrameSprite();

        function pass(param1:int) : void;

        function initUrl(param1:String, param2:String, param3:Function = null) : void;

        function set dir(param1:int) : void;

        function get dir() : int;

        function set shadowVisible(param1:Boolean) : void;

        function set bodyFilters(param1:Array) : void;

        function set petLv(param1:int) : void;

        function set FName(param1:String) : void;

    }
}
