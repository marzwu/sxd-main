package com.assist.server
{

    public class QuestType extends Object
    {
        public static const FavoriteQuestId:int = 263;
        public static const PartnersQuestId:int = 21;
        public static const PartnersQuestId2:int = 224;
        public static const BeginnerQuestId:int = 1;
        public static const BeginnerItemId:int = 2;
        public static const BeginnerAutoWayId:int = 2;
        public static const BeginnerUpgradeId:int = 2;
        public static const BeginnerTrainingId:int = 15;
        public static const BeginnerFateIdByShuShan:int = 70;
        public static const BeginnerFateIdByKunLun:int = 71;
        public static const SlaveQuestLock:uint = 2900;
        public static const EliteQuestLock:uint = 5300;
        private static var _Types:Object = {1:"主线", 2:"支线", 3:"每日", 4:"精英"};
        private static var _Quests:Object = null;
        public static const Master:int = 1;
        public static const Slave:int = 2;
        public static const Daily:int = 3;
        public static const Elite:int = 4;
        public static const LevelLimit:int = -1;
        public static const Acceptable:int = 0;
        public static const Accepted:int = 1;
        public static const Completed:int = 2;

        public function QuestType()
        {
            return;
        }// end function

        public static function get Quests() : Object
        {
            if (_Quests == null)
            {
                throw new Error("还未赋值！");
            }
            return _Quests;
        }// end function

        public static function set Quests(param1:Object) : void
        {
            if (_Quests != null)
            {
                throw new Error("非法赋值");
            }
            _Quests = param1;
            return;
        }// end function

        public static function getTypeName(param1:int) : String
        {
            return _Types[param1] || "";
        }// end function

        public static function getType(param1:int) : int
        {
            return Quests[param1] ? (Quests[param1][0]) : (0);
        }// end function

        public static function getLock(param1:int) : int
        {
            return Quests[param1] ? (Quests[param1][1]) : (0);
        }// end function

        public static function getLevel(param1:int) : int
        {
            return Quests[param1] ? (Quests[param1][2]) : (0);
        }// end function

        public static function getTitle(param1:int) : String
        {
            return Quests[param1] ? (Quests[param1][3]) : ("");
        }// end function

        public static function getContent(param1:int) : String
        {
            return Quests[param1] ? (Quests[param1][4]) : ("");
        }// end function

        public static function getConditions(param1:int) : String
        {
            return Quests[param1] ? (Quests[param1][5]) : ("");
        }// end function

        public static function getTownText(param1:int) : String
        {
            return Quests[param1] ? (Quests[param1][6]) : ("");
        }// end function

        public static function getBeginNPCId(param1:int) : int
        {
            return Quests[param1] ? (Quests[param1][7]) : (0);
        }// end function

        public static function getEndNPCId(param1:int) : int
        {
            return Quests[param1] ? (Quests[param1][8]) : (0);
        }// end function

        public static function getAwardExperience(param1:int) : int
        {
            return Quests[param1] ? (Quests[param1][9]) : (0);
        }// end function

        public static function getAwardCoins(param1:int) : int
        {
            return Quests[param1] ? (Quests[param1][10]) : (0);
        }// end function

        public static function getAwardItemId(param1:int) : int
        {
            return Quests[param1] ? (Quests[param1][11]) : (0);
        }// end function

        public static function getIsTalkQuest(param1:int) : Boolean
        {
            return Quests[param1] ? (Quests[param1][12]) : (false);
        }// end function

        public static function getAcceptTalk(param1:int) : String
        {
            return Quests[param1] ? (Quests[param1][13]) : ("");
        }// end function

        public static function getAcceptedTalk(param1:int) : String
        {
            return Quests[param1] ? (Quests[param1][14]) : ("");
        }// end function

        public static function getCompletedTalk(param1:int) : String
        {
            return Quests[param1] ? (Quests[param1][15]) : ("");
        }// end function

        public static function getMissionId(param1:int) : int
        {
            return Quests[param1] ? (Quests[param1][16]) : (0);
        }// end function

        public static function getAwardItemCount(param1:int) : int
        {
            return Quests[param1] ? (Quests[param1][17]) : (0);
        }// end function

        public static function getAwardItemIdByRoleId(param1:int, param2:int) : int
        {
            var _loc_4:String = null;
            var _loc_3:int = 0;
            if (param1 == 17)
            {
                _loc_4 = RoleType.getJobSignByRoleId(param2);
                if (RoleType.FeiYu == _loc_4)
                {
                    _loc_3 = 367;
                }
                else if (RoleType.JianLing == _loc_4)
                {
                    _loc_3 = 366;
                }
                else if (RoleType.WuSheng == _loc_4)
                {
                    _loc_3 = 365;
                }
            }
            else
            {
                _loc_3 = getAwardItemId(param1);
            }
            return _loc_3;
        }// end function

    }
}
