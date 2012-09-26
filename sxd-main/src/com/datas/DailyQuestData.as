package com.datas
{
    import com.assist.server.*;
    import com.haloer.data.*;

    public class DailyQuestData extends Base
    {
        private var _aryDayQuestList:Array;
        private var _aryDayAcceptQuest:Array;
        private var _aryDayGiveupQuest:Array;
        private var _aryDayQuestRefresh:Array;
        private var _aryDayNowComplete:Array;
        private var _aryDayGetAward:Array;
        private var _aryDayQuestRefreshStar:Array;
        private var _objFinishAllDayQuest:Object;

        public function DailyQuestData()
        {
            this._aryDayQuestList = [];
            this._aryDayAcceptQuest = [];
            this._aryDayGiveupQuest = [];
            this._aryDayQuestRefresh = [];
            this._aryDayNowComplete = [];
            this._aryDayGetAward = [];
            this._aryDayQuestRefreshStar = [];
            this._objFinishAllDayQuest = {};
            return;
        }// end function

        public function getDayQuestList() : Object
        {
            var _loc_1:* = this.setDayQuestInfo(this._aryDayQuestList[0][0]);
            _loc_1["list"] = this.setDayQuestList(this._aryDayQuestList[0][0][4]);
            return _loc_1;
        }// end function

        public function acceptDayQuest() : Object
        {
            var _loc_1:* = this.setDayQuestInfo(this._aryDayAcceptQuest[1][0]);
            _loc_1["list"] = this.setDayQuestList(this._aryDayAcceptQuest[1][0][4]);
            _loc_1["result"] = this._aryDayAcceptQuest[0];
            return _loc_1;
        }// end function

        public function giveupDayQuest() : Object
        {
            var _loc_1:* = this.setDayQuestInfo(this._aryDayGiveupQuest[1][0]);
            _loc_1["list"] = this.setDayQuestList(this._aryDayGiveupQuest[1][0][4]);
            _loc_1["result"] = this._aryDayGiveupQuest[0];
            return _loc_1;
        }// end function

        public function refreshDayQuest() : Object
        {
            var _loc_1:* = this.setDayQuestInfo(this._aryDayQuestRefresh[1][0]);
            _loc_1["list"] = this.setDayQuestList(this._aryDayQuestRefresh[1][0][4]);
            _loc_1["result"] = this._aryDayQuestRefresh[0];
            return _loc_1;
        }// end function

        public function nowCompleteDay() : Object
        {
            var _loc_1:* = this.setDayQuestInfo(this._aryDayNowComplete[1][0]);
            _loc_1["list"] = this.setDayQuestList(this._aryDayNowComplete[1][0][4]);
            _loc_1["result"] = this._aryDayNowComplete[0];
            return _loc_1;
        }// end function

        public function getAwardDay() : Object
        {
            var _loc_1:* = this.setDayQuestInfo(this._aryDayGetAward[1][0]);
            _loc_1["list"] = this.setDayQuestList(this._aryDayGetAward[1][0][4]);
            _loc_1["result"] = this._aryDayGetAward[0];
            return _loc_1;
        }// end function

        public function refreshStarDayQuest() : Object
        {
            var _loc_1:* = this.setDayQuestInfo(this._aryDayQuestRefreshStar[1][0]);
            _loc_1["list"] = this.setDayQuestList(this._aryDayQuestRefreshStar[1][0][4]);
            _loc_1["result"] = this._aryDayQuestRefreshStar[0];
            return _loc_1;
        }// end function

        public function finishAllDayQuest() : Object
        {
            return this._objFinishAllDayQuest;
        }// end function

        private function setDayQuestInfo(param1:Array) : Object
        {
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["complete_quest_count", "star_count", "updata_button", "complete_button"]);
            return _loc_2;
        }// end function

        private function setDayQuestList(param1:Array) : Array
        {
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            var _loc_2:Array = [];
            for each (_loc_4 in param1)
            {
                
                _loc_3 = {};
                oObject.list(_loc_4, _loc_3, ["quest_id", "need_count", "complete_count", "star", "skill", "item_id", "item_count", "state", "is_talk_quest"]);
                _loc_3["title"] = QuestType.getTitle(_loc_3["quest_id"]);
                _loc_3["content"] = QuestType.getContent(_loc_3["quest_id"]);
                _loc_3["conditions"] = QuestType.getConditions(_loc_3["quest_id"]);
                if (_loc_3["item_id"] != 0)
                {
                    _loc_3["item_name"] = ItemType.getName(_loc_3["item_id"]);
                    _loc_3["color"] = ItemType.getItemColor(_loc_3["item_id"]);
                }
                _loc_2.push(_loc_3);
            }
            _loc_2.sortOn(["state", "quest_id"], Array.DESCENDING);
            return _loc_2;
        }// end function

        public function day_quest_list(param1:Array) : void
        {
            this._aryDayQuestList = param1;
            return;
        }// end function

        public function day_accept_quest(param1:Array) : void
        {
            this._aryDayAcceptQuest = param1;
            return;
        }// end function

        public function day_giveup_quest(param1:Array) : void
        {
            this._aryDayGiveupQuest = param1;
            return;
        }// end function

        public function day_quest_refresh(param1:Array) : void
        {
            this._aryDayQuestRefresh = param1;
            return;
        }// end function

        public function day_now_complete(param1:Array) : void
        {
            this._aryDayNowComplete = param1;
            return;
        }// end function

        public function day_get_award(param1:Array) : void
        {
            this._aryDayGetAward = param1;
            return;
        }// end function

        public function day_quest_refresh_star(param1:Array) : void
        {
            this._aryDayQuestRefreshStar = param1;
            return;
        }// end function

        public function finish_all_day_quest(param1:Array) : void
        {
            this._objFinishAllDayQuest = {};
            this._objFinishAllDayQuest["state"] = param1[0];
            return;
        }// end function

    }
}
