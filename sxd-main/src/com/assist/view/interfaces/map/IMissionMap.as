package com.assist.view.interfaces.map
{
    import flash.text.*;

    public interface IMissionMap extends IMap
    {

        public function IMissionMap();

        function set onWar(param1:Function) : void;

        function set onCancel(param1:Function) : void;

        function set onGongLue(param1:Function) : void;

        function set onSound(param1:Function) : void;

        function set soundState(param1:int) : void;

        function addMonsters(param1:Array) : void;

        function warClose(param1:Boolean) : void;

        function gotoNearMonster() : void;

        function get tfName() : TextField;

        function showWarSoul(param1:int, param2:Class, param3:Class) : void;

        function setRandomItem(param1:Object) : void;

        function set onRandomItem(param1:Function) : void;

        function clearRandomItem(param1:int) : void;

    }
}
