package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ILiveness
    {

        public function ILiveness();

        function get content() : MovieClip;

        function set drag(param1:IDrag) : void;

        function set tip(param1:ITip) : void;

        function clear() : void;

        function set onClose(param1:Function) : void;

        function render() : void;

        function set playerLevel(param1:int) : void;

        function set vipLevel(param1:int) : void;

        function set power(param1:int) : void;

        function set factionId(param1:int) : void;

        function set factionLevel(param1:int) : void;

        function set infoData(param1:Object) : void;

        function set onGetBack(param1:Function) : void;

        function set onGetAward(param1:Function) : void;

        function set awardInfo(param1:Array) : void;

        function set liveNum(param1:int) : void;

        function set onUpdateInfo(param1:Function) : void;

        function renderGetAward(param1:Boolean) : void;

        function set url(param1:String) : void;

        function set buttonEffect(param1:Sprite) : void;

        function set onShowBtnEffect(param1:Function) : void;

        function set heroesWarStatus(param1:Boolean) : void;

        function set worldBossStatus(param1:Boolean) : void;

        function set topWarStatus(param1:Boolean) : void;

        function set monsterStatus(param1:Boolean) : void;

        function set onMissionBtn(param1:Function) : void;

        function set onBuyPower(param1:Function) : void;

        function set onRune(param1:Function) : void;

        function set onFateFree(param1:Function) : void;

        function set onFateIngot(param1:Function) : void;

        function set onFactionBlessing(param1:Function) : void;

        function set onWorship(param1:Function) : void;

        function set onCampSalary(param1:Function) : void;

        function set onSealStone(param1:Function) : void;

        function set onShowSealSoul(param1:Function) : void;

        function set onSendFlower(param1:Function) : void;

        function set onTakeBible(param1:Function) : void;

        function set onTakeBibleFriend(param1:Function) : void;

        function set onFarm(param1:Function) : void;

        function set onPetAnimal(param1:Function) : void;

        function set onGetPeach(param1:Function) : void;

        function set onRollCake(param1:Function) : void;

        function set onSuperSport(param1:Function) : void;

        function set onMultimission(param1:Function) : void;

        function set onFactionSeal(param1:Function) : void;

        function set onWorldBoss(param1:Function) : void;

        function set onCampWar(param1:Function) : void;

        function set onTopWar(param1:Function) : void;

        function set onFactionRollCake(param1:Function) : void;

        function set onRosefinch(param1:Function) : void;

        function set onFactionMonster(param1:Function) : void;

        function updateSuperSportTime(param1:int) : void;

        function updateTakeBibleTime(param1:int) : void;

    }
}
