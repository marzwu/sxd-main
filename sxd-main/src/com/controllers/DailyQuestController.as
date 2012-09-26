package com.controllers
{

    public class DailyQuestController extends Base
    {

        public function DailyQuestController()
        {
            return;
        }// end function

        public function getDayQuestList() : Object
        {
            return this._data.dailyQuest.getDayQuestList();
        }// end function

        public function acceptDayQuest() : Object
        {
            return this._data.dailyQuest.acceptDayQuest();
        }// end function

        public function giveupDayQuest() : Object
        {
            return this._data.dailyQuest.giveupDayQuest();
        }// end function

        public function refreshDayQuest() : Object
        {
            return this._data.dailyQuest.refreshDayQuest();
        }// end function

        public function nowCompleteDay() : Object
        {
            return this._data.dailyQuest.nowCompleteDay();
        }// end function

        public function getAwardDay() : Object
        {
            return this._data.dailyQuest.getAwardDay();
        }// end function

        public function refreshStarDayQuest() : Object
        {
            return this._data.dailyQuest.refreshStarDayQuest();
        }// end function

        public function get finishAllDayQuest() : Object
        {
            return this._data.dailyQuest.finishAllDayQuest();
        }// end function

    }
}
