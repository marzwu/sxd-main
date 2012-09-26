package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IDeploy
    {

        public function IDeploy();

        function get content() : MovieClip;

        function playerData(param1:Array) : void;

        function set isShowSequence(param1:Boolean) : void;

        function set onShowSequence(param1:Function) : void;

        function set deforeShowSequence(param1:Boolean) : void;

        function set isOpenResearch(param1:Boolean) : void;

        function set onClearCdTimer(param1:Function) : void;

        function set onUpLevelHandler(param1:Function) : void;

        function set downTimer(param1:int) : void;

        function deployInfo(param1:Array) : void;

        function openDeploy(param1:Array) : void;

        function set getFirstAttack(param1:int) : void;

        function set onUpDeploy(param1:Function) : void;

        function set onDownDeploy(param1:Function) : void;

        function set onDefault(param1:Function) : void;

        function set onDeploy(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function set onClose(param1:Function) : void;

    }
}
