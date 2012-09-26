package com.controllers
{

    public class AchievementController extends Base
    {

        public function AchievementController()
        {
            return;
        }// end function

        public function get inLoadAchievementTypeData() : Boolean
        {
            return this._data.achievement.inLoadAchievementTypeData;
        }// end function

        public function get getPlayerAchievementList() : Array
        {
            return this._data.achievement.getPlayerAchievementList;
        }// end function

        public function get notifyCompleteAchievement() : Array
        {
            return this._data.achievement.notifyCompleteAchievement;
        }// end function

        public function get catPlayerId() : int
        {
            return this._data.achievement.catPlayerId;
        }// end function

    }
}
