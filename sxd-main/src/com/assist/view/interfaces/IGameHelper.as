package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IGameHelper
    {

        public function IGameHelper();

        function get content() : MovieClip;

        function set onCloseBtn(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set power(param1:int) : void;

        function set level(param1:int) : void;

        function set url(param1:String) : void;

        function set buttonEffect(param1:Sprite) : void;

        function set onCampSalaryBtn(param1:Function) : void;

        function set onDailyQuestBtn(param1:Function) : void;

        function set onFateFreeBtn(param1:Function) : void;

        function set onFateIngotBtn(param1:Function) : void;

        function set onGetPeachBtn(param1:Function) : void;

        function set onBuyPowerBtn(param1:Function) : void;

        function set onMissionBtn(param1:Function) : void;

        function set onRuneBtn(param1:Function) : void;

        function set onSportBtn(param1:Function) : void;

        function set onFactionBlessingBtn(param1:Function) : void;

        function set onStroyPlayBtn(param1:Function) : void;

        function set onTakeBibleBtn(param1:Function) : void;

        function set onSendFlowerBtn(param1:Function) : void;

        function set onFreeSealTrainingBtn(param1:Function) : void;

        function set onCoinTreeBtn(param1:Function) : void;

        function set onRollCakeBtn(param1:Function) : void;

        function set onWorshipMarsBtn(param1:Function) : void;

        function set onPetAnimalBtn(param1:Function) : void;

        function set onSealStoneBtn(param1:Function) : void;

        function set onBackBtn(param1:Function) : void;

        function set onAchievementBtn(param1:Function) : void;

        function set onGetBoxAward(param1:Function) : void;

        function render() : void;

        function renderGameHelper(param1:Object) : void;

        function clear() : void;

        function updateSuperSportTime(param1:int) : void;

        function updateTakeBibleTime(param1:int) : void;

        function renderBox(param1:Array) : void;

        function renderGetBoxAwardSuccess(param1:int) : void;

    }
}
