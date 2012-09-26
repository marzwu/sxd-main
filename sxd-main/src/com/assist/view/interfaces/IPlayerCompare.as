package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IPlayerCompare
    {

        public function IPlayerCompare();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function init(param1:String, param2:String) : void;

        function renderResearchCompare(param1:Array, param2:Array) : void;

        function renderFirstAttack(param1:Object, param2:Object) : void;

        function renderAttrib(param1:Object, param2:Object) : void;

        function renderFate(param1:Object, param2:Object) : void;

        function renderRoleList(param1:Array, param2:Array) : void;

        function renderPet(param1:Object, param2:Object) : void;

        function set onResearchCompare(param1:Function) : void;

        function set onFirstAttackCompare(param1:Function) : void;

        function set onAttribCompare(param1:Function) : void;

        function set onFateCompare(param1:Function) : void;

        function set onPetCompare(param1:Function) : void;

    }
}
