package com.assist.view.interfaces.map
{
    import flash.display.*;

    public interface IWorldBossMapMsg extends IContent
    {

        public function IWorldBossMapMsg();

        function reset(param1:int, param2:int, param3:int, param4:String) : void;

        function set onSkill(param1:Function) : void;

        function set onReset(param1:Function) : void;

        function set onIngot(param1:Function) : void;

        function set onCancel(param1:Function) : void;

        function set onAuto(param1:Function) : void;

        function get btnSkill() : DisplayObject;

        function get btnReset() : DisplayObject;

        function get btnIngot() : DisplayObject;

        function set autoType(param1:int) : void;

        function get autoType() : int;

        function set killRank(param1:Array) : void;

        function set lift(param1:int) : void;

        function set liftMax(param1:int) : void;

        function addHurtList(param1:Array) : void;

        function set msgString(param1:String) : void;

        function set timeString(param1:String) : void;

        function set guwuString(param1:String) : void;

        function set cdString(param1:String) : void;

        function set cdShow(param1:Boolean) : void;

        function set onClearCd(param1:Function) : void;

        function set onTip(param1:Function) : void;

    }
}
