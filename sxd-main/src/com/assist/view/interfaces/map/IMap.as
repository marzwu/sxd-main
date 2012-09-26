package com.assist.view.interfaces.map
{
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import flash.display.*;
    import flash.events.*;

    public interface IMap extends IContent
    {

        public function IMap();

        function clear() : void;

        function initMapinfo(param1:MapInfo) : void;

        function set backSWF(param1:IMapSWF) : void;

        function set backMini(param1:DisplayObject) : void;

        function addPlayer(param1:PlayerInfo) : void;

        function removePlayer(param1:int) : void;

        function moveToPlayer(param1:int, param2:int, param3:int) : void;

        function movePlayer(param1:int, param2:int, param3:int) : void;

        function playerSay(param1:int, param2, param3:int) : void;

        function addMonster(param1:MonsterInfo) : void;

        function removeMonster(param1:int) : void;

        function addPortal(param1:PortalInfo) : void;

        function addNPC(param1:NPCInfo) : void;

        function updateNpcLoack(param1:int) : void;

        function addBuild(param1:BuildInfo) : void;

        function setBuildGetVisible(param1:int, param2:Boolean) : void;

        function stopRun(param1:Boolean) : void;

        function addOtherFlash(param1:String, param2:Sprite, param3:int, param4:int) : void;

        function removeOtherFlash(param1:String) : void;

        function passClick(event:MouseEvent) : void;

        function showQuestOk() : void;

        function showQuestAdd() : void;

        function showLevelUp() : void;

        function showEffort() : void;

        function updateBodyUrl(param1:int) : void;

        function getMapWarBG() : BitmapData;

        function showTextEffect(param1:String, param2:uint) : void;

        function showFollow(param1:int, param2:int) : void;

        function set onMoveTo(param1:Function) : void;

        function set onUpdateXY(param1:Function) : void;

        function updatePracticePanel() : void;

        function set onCancelPraceice(param1:Function) : void;

        function set onGoonPraceice(param1:Function) : void;

        function set onPracticeAction(param1:Function) : void;

        function get inMove() : Boolean;

        function updatePetLv(param1:int, param2:int) : void;

        function setAwardFollower() : void;

        function updateFollow(param1:int) : void;

        function updateCatFollow(param1:int) : void;

        function set scaleValue(param1:Number) : void;

    }
}
