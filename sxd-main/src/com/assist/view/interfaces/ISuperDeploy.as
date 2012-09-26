package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ISuperDeploy
    {

        public function ISuperDeploy();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set playerLevel(param1:int) : void;

        function set playerSkill(param1:int) : void;

        function set isPlayLevelUpCartoon(param1:Boolean) : void;

        function set onLevelUp(param1:Function) : void;

        function set onUpDeploy(param1:Function) : void;

        function set onDownDeploy(param1:Function) : void;

        function set onSaveShowOrder(param1:Function) : void;

        function clear() : void;

        function init() : void;

        function renderDeploy(param1:Array, param2:Array, param3:Boolean) : void;

        function renderDeployResearch(param1:Object) : void;

        function clearRoleIcon() : void;

        function clearDeployGrid() : void;

    }
}
