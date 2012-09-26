package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface ISuperSport
    {

        public function ISuperSport();

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

        function get content() : MovieClip;

        function clear() : void;

        function set onSealSoul(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set loaderMap(param1:Object) : void;

        function getAwardTimer(param1:int, param2:int) : void;

        function set onSendFlower(param1:Function) : void;

        function set isOpenFate(param1:Boolean) : void;

        function set isOpenSealSoul(param1:Boolean) : void;

        function set isVip4(param1:Boolean) : void;

        function set getWinCountData(param1:String) : void;

        function set getOpenTimer(param1:int) : void;

        function set isShowGetAwardBtn(param1:Boolean) : void;

        function set onGetAwardClick(param1:Function) : void;

        function set getPlayerData(param1:Object) : void;

        function set getNoticeData(param1:Object) : void;

        function set renderIngot(param1:int) : void;

        function set renderCoins(param1:Number) : void;

        function set onClose(param1:Function) : void;

        function set onCharacter(param1:Function) : void;

        function set onPack(param1:Function) : void;

        function set onUpgrade(param1:Function) : void;

        function set onResearch(param1:Function) : void;

        function set onDeploy(param1:Function) : void;

        function set onFate(param1:Function) : void;

        function set onAwardCount(param1:Function) : void;

        function set getChallengePersonList(param1:Array) : void;

        function set getBuyChallengeData(param1:Object) : void;

        function set onChallengePerson(param1:Function) : void;

        function set onClearCdTimer(param1:Function) : void;

        function set onAddChallenge(param1:Function) : void;

        function set getChallengeNum(param1:int) : void;

        function set getClearTimer(param1:int) : void;

        function set getNewSportWarReport(param1:Object) : void;

        function set getSportReportList(param1:Array) : void;

        function set onTextLink(param1:Function) : void;

        function set onAddFriend(param1:Function) : void;

        function set getHeroBoxList(param1:Array) : void;

        function set onCheckHero(param1:Function) : void;

    }
}
