package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IResearch
    {

        public function IResearch();

        function get content() : MovieClip;

        function set onCloseBtn(param1:Function) : void;

        function init() : void;

        function clear() : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set dialog(param1:IAlert) : void;

        function set onLevelUpBtn(param1:Function) : void;

        function set iconUrl(param1:String) : void;

        function get researchID() : int;

        function set onResearchData(param1:Function) : void;

        function set mySkill(param1:int) : void;

        function get mySkill() : int;

        function set myLevel(param1:int) : void;

        function renderGetResearchData(param1:Array) : void;

        function renderLevelUpBtnClick(param1:Object) : void;

    }
}
