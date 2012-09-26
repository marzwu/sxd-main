package com.datas
{

    public class HeroMissionData extends Base
    {
        private var _heroMissionList:Array;
        private var _buyHeroChallenge:Array;
        public var startPractice:Array;
        public var stopPractice:Array;
        public var getNotify:Array;
        public var getContinuePracticeInfo:Array;
        public var continuePractice:Array;
        public var getQuickly:Array;

        public function HeroMissionData()
        {
            return;
        }// end function

        public function get getHeroMissionList() : Array
        {
            return this._heroMissionList;
        }// end function

        public function get buyHeroChallenge() : Array
        {
            return this._buyHeroChallenge;
        }// end function

        public function get_hero_mission_list(param1:Array) : void
        {
            this._heroMissionList = param1;
            return;
        }// end function

        public function buy_hero_challenge(param1:Array) : void
        {
            this._buyHeroChallenge = param1;
            return;
        }// end function

        public function start_practice(param1:Array) : void
        {
            this.startPractice = param1;
            return;
        }// end function

        public function stop_practice(param1:Array) : void
        {
            this.stopPractice = param1;
            return;
        }// end function

        public function notify(param1:Array) : void
        {
            this.getNotify = param1;
            return;
        }// end function

        public function get_continue_practice_info(param1:Array) : void
        {
            this.getContinuePracticeInfo = param1;
            return;
        }// end function

        public function continue_practice(param1:Array) : void
        {
            this.continuePractice = param1;
            return;
        }// end function

        public function quickly(param1:Array) : void
        {
            this.getQuickly = param1;
            return;
        }// end function

    }
}
