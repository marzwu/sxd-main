package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.haloer.data.*;

    public class AchievementData extends Base
    {
        private var _aryGetPlayerAchievementList:Array;
        private var _aryNotifyCompleteAchievement:Array;
        public var inLoadAchievementTypeData:Boolean = false;
        public var catPlayerId:int = 0;

        public function AchievementData()
        {
            this._aryGetPlayerAchievementList = [];
            this._aryNotifyCompleteAchievement = [];
            return;
        }// end function

        public function get getPlayerAchievementList() : Array
        {
            return this._aryGetPlayerAchievementList;
        }// end function

        public function get notifyCompleteAchievement() : Array
        {
            var _loc_1:* = this._aryNotifyCompleteAchievement.slice();
            this._aryNotifyCompleteAchievement = [];
            return _loc_1;
        }// end function

        private function getAchievementAllData() : Array
        {
            var _loc_3:Object = null;
            var _loc_4:int = 0;
            var _loc_1:* = AchievementType.getAchievementIds();
            var _loc_2:Array = [];
            for each (_loc_4 in _loc_1)
            {
                
                _loc_3 = {};
                _loc_3["achievement_id"] = _loc_4;
                this.getAchievementInfo(_loc_3);
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        private function getAchievementInfo(param1:Object) : void
        {
            param1["tag_id"] = AchievementType.getAchievementTagId(param1["achievement_id"]);
            param1["tag_name"] = AchievementType.getAchievementTagName(param1["tag_id"]);
            param1["content"] = AchievementType.getContent(param1["achievement_id"]);
            param1["name"] = AchievementType.getName(param1["achievement_id"]);
            param1["point"] = AchievementType.getPoint(param1["achievement_id"]);
            param1["sign"] = AchievementType.getSign(param1["achievement_id"]);
            param1["sort_order"] = AchievementType.getSortOrder(param1["achievement_id"]);
            param1["complete_total"] = AchievementType.getTotal(param1["achievement_id"]);
            param1["special_award"] = AchievementType.getSpecialAward(param1["achievement_id"]);
            param1["completed_number"] = 0;
            param1["complete_date"] = 0;
            param1["url"] = URI.achievementUrl + param1["sign"] + ".png";
            return;
        }// end function

        public function get_player_achievement_list(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            this._aryGetPlayerAchievementList = this.getAchievementAllData();
            for each (_loc_3 in param1[0])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["achievement_id", "completed_number", "complete_date"]);
                for each (_loc_4 in this._aryGetPlayerAchievementList)
                {
                    
                    if (_loc_4["achievement_id"] != _loc_2["achievement_id"])
                    {
                        continue;
                    }
                    _loc_4["completed_number"] = _loc_2["completed_number"];
                    _loc_4["complete_date"] = _loc_2["complete_date"];
                    break;
                }
            }
            this._aryGetPlayerAchievementList.sortOn("sort_order", Array.NUMERIC);
            return;
        }// end function

        public function notify_complete_achievement(param1:Array) : void
        {
            var callBack:Function;
            var result:* = param1;
            callBack = function () : void
            {
                var _loc_1:Object = null;
                for each (_loc_1 in _aryNotifyCompleteAchievement)
                {
                    
                    getAchievementInfo(_loc_1);
                }
                inLoadAchievementTypeData = false;
                return;
            }// end function
            ;
            var objAchievement:Object;
            oObject.list(result, objAchievement, ["player_id", "player_nickname", "achievement_id"]);
            this._aryNotifyCompleteAchievement.push(objAchievement);
            if (this.inLoadAchievementTypeData)
            {
                return;
            }
            this.inLoadAchievementTypeData = true;
            AchievementType.loadData(callBack);
            return;
        }// end function

        public function fate_achievement_completed(param1:Array) : void
        {
            this.catPlayerId = param1[0];
            return;
        }// end function

    }
}
