package com.assist.view.interfaces.map
{
    import flash.display.*;

    public interface IFurnaceMap extends ITownMap
    {

        public function IFurnaceMap();

        function addAvatar(param1:Object) : void;

        function set onRoleSpeak(param1:Function) : void;

        function getInfoByRoleId(param1:int) : Object;

        function updateRole(param1:Object, param2:int) : void;

        function levelRole(param1:Object, param2:int) : void;

        function setMcLevel(param1:MovieClip) : void;

        function get curDeployRoleIdList() : Array;

    }
}
