package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface ITopWarCreate
    {

        public function ITopWarCreate();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set onClose(param1:Function) : void;

        function clear() : void;

        function set openType(param1:int) : void;

        function set timesIsUse(param1:Boolean) : void;

        function render() : void;

        function set onCreate(param1:Function) : void;

        function set onJoin(param1:Function) : void;

        function set onFastJoin(param1:Function) : void;

        function set score(param1:int) : void;

        function set onScoreBoard(param1:Function) : void;

        function set teamList(param1:Array) : void;

        function set scoreList(param1:Array) : void;

        function addNewTeam(param1:Object) : void;

        function dropTeam(param1:int) : void;

        function updateTeam(param1:Object) : void;

        function set showMessage(param1:Function) : void;

        function set teamId(param1:int) : void;

        function set onBody(param1:Function) : void;

        function set onPack(param1:Function) : void;

        function set onUpgrade(param1:Function) : void;

        function set onResearch(param1:Function) : void;

        function set onDeploy(param1:Function) : void;

        function set onFate(param1:Function) : void;

        function set onSealSoul(param1:Function) : void;

        function set onCheckHero(param1:Function) : void;

        function set onAddFriend(param1:Function) : void;

        function set onSendFlower(param1:Function) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

    }
}
