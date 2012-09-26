package com.assist.view.interfaces
{
    import com.assist.view.interfaces.map.*;
    import flash.display.*;
    import flash.geom.*;

    public interface IToolbar extends IContent
    {

        public function IToolbar();

        function init() : void;

        function clear() : void;

        function set vipLevel(param1:int) : void;

        function set rechargeVisible(param1:Boolean) : void;

        function set onPlayerIcon(param1:Function) : void;

        function set nickName(param1:String) : void;

        function set powerVisible(param1:Boolean) : void;

        function health(param1:int, param2:int) : void;

        function set ingot(param1:int) : void;

        function set coins(param1:Number) : void;

        function set PlayerInfo(param1:String) : void;

        function set onPlayerIconOver(param1:Function) : void;

        function power(param1:int, param2:int) : void;

        function set onBuyPower(param1:Function) : void;

        function set powerInfo(param1:Object) : void;

        function set onAchievement(param1:Function) : void;

        function set level(param1:int) : void;

        function set onSoundControl(param1:Function) : void;

        function set onDoubleRemoveBuff(param1:Function) : void;

        function set removeBuff(param1:String) : void;

        function soundMute(param1:Boolean) : void;

        function set addBuff(param1:Object) : void;

        function set visibleBuff(param1:Boolean) : void;

        function updateExperience(param1:Number, param2:Number) : void;

        function set onRecharge(param1:Function) : void;

        function loadPlayerAvatar(param1:String) : void;

        function set onOpenRune(param1:Function) : void;

        function set runeVisible(param1:Boolean) : void;

        function renderFunctionLink(param1:Object) : void;

        function renderFunctionLinkBtnTip(param1:String, param2:String) : void;

        function renderFunctionTextTip(param1:String, param2:String) : void;

        function clearFunctionLink() : void;

        function removeFunctionLink(param1:String) : void;

        function setFunctionLinkPoint() : void;

        function set onLinkTextClick(param1:Function) : void;

        function set onLinkBtnClick(param1:Function) : void;

        function get miniMap() : IMiniMap;

        function set questTraceLink(param1:Function) : void;

        function set questTraceTipVisible(param1:Boolean) : void;

        function renderQuestTrace(param1:Object) : void;

        function get questTraceContent() : Sprite;

        function newFunctionBar(param1:Array, param2:Array) : void;

        function getFunctionPoint(param1:String) : Point;

        function set onEnd(param1:Function) : void;

        function set onBody(param1:Function) : void;

        function set onPack(param1:Function) : void;

        function set onUpgrade(param1:Function) : void;

        function set onDeploy(param1:Function) : void;

        function set onResearch(param1:Function) : void;

        function set onFate(param1:Function) : void;

        function set onSealSoul(param1:Function) : void;

        function set onQuest(param1:Function) : void;

        function set onFriend(param1:Function) : void;

        function set onFaction(param1:Function) : void;

        function set onStudyStunt(param1:Function) : void;

        function set onPetAnimal(param1:Function) : void;

        function set onPractice(param1:Function) : void;

        function addPackFull() : void;

        function removePackFull() : void;

        function updatePackMessageXY() : void;

        function switchBubble(param1:int) : void;

        function set functionBarParent(param1:Sprite) : void;

        function showExpFile(param1:Boolean) : void;

        function playFlowerRain(param1:String, param2:int, param3:int) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

        function set tip(param1:ITip) : void;

        function set alert(param1:IAlert) : void;

        function set goodsIconUrl(param1:String) : void;

        function set addonsUrl(param1:String) : void;

        function set playerDataVisible(param1:Boolean) : void;

        function get playerDataVisible() : Boolean;

        function set functionLinkVisible(param1:Boolean) : void;

        function get functionLinkVisible() : Boolean;

        function set questTraceVisible(param1:Boolean) : void;

        function get questTraceVisible() : Boolean;

        function set functionBarVisible(param1:Boolean) : void;

        function get functionBarVisible() : Boolean;

        function set onClickIgnore(param1:Function) : void;

    }
}
