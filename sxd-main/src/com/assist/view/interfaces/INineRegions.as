package com.assist.view.interfaces
{

    public interface INineRegions extends IContent
    {

        public function INineRegions();

        function init() : void;

        function firstCatoon(param1:int) : void;

        function setJieLevel(param1:int, param2:int) : void;

        function set playerLv(param1:int) : void;

        function set onWar(param1:Function) : void;

        function set onCloseFun(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function bShowHidden(param1:Boolean, param2:String, param3:String) : void;

        function set onHiddenWar(param1:Function) : void;

    }
}
