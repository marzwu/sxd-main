package com.assist.server
{
    import com.lang.client.com.assist.server.*;

    public class ActivityType extends Object
    {
        private static var _factionLevel:int = 0;
        public static const FactionAll:String = "FactionAll";
        public static const FactionBlessing:String = "FactionBlessing";
        public static const FactionSeal:String = "FactionSeal";
        public static const FactionWar:String = "FactionWar";
        public static const FactionEat:String = "FactionEat";
        public static const FactionBoss:String = "FactionBoss";
        public static const BossDaoBaTu:String = "BossDaoBaTu";
        public static const FactionRollCake:String = "FactionRollCake";
        public static const FactionMonster:String = "FactionMonster";
        public static const LuckyWheel:String = "luckyWheel";
        public static const HeroesWar:String = "HeroesWar";
        public static const RedEnvelopes:String = "RedEnvelopes";
        public static const TopWar:String = "TopWar";
        public static const FameRank:String = "FameRank";
        public static const MissionRank:String = "MissionRank";
        public static const StatePointRank:String = "StatePointRank";
        public static const CoinRank:String = "CoinRank";
        public static const GameHelper:String = "GameHelper";
        public static const NineRegions:String = "NineRegions";
        private static const BossBaiZe:Object = {type:FunctionType.WorldBoss, name:ActivityTypeLang.BossName, textTile:ActivityTypeLang.BossBaiZeTextTile, info:ActivityTypeLang.BossBaiZeInfo, openTimer:"16:00", timer:16};
        private static const BossQingTianMu:Object = {type:FunctionType.WorldBoss, name:ActivityTypeLang.BossName, textTile:ActivityTypeLang.BossQingTianMuTile, info:ActivityTypeLang.BossQingTianMuInfo, openTimer:"16:00", timer:16};
        private static const BossChiYanShou:Object = {type:FunctionType.WorldBoss, name:ActivityTypeLang.BossName, textTile:ActivityTypeLang.BossChiYanShouTile, info:ActivityTypeLang.BossChiYanShouInfo, openTimer:"11:00", timer:11};
        private static const BossQingLong:Object = {type:FunctionType.WorldBoss, name:ActivityTypeLang.BossName, textTile:ActivityTypeLang.BossQingLongTile, info:ActivityTypeLang.BossQingLongInfo, openTimer:"23:00", timer:23};
        private static const CampWar:Object = {type:FunctionType.CampWar, name:ActivityTypeLang.CampWarTile, textTile:ActivityTypeLang.CampWarTile, info:ActivityTypeLang.CampWarInfo, openTimer:"", timer:0};
        private static const HeroesWarData:Object = {type:HeroesWar, name:ActivityTypeLang.HeroesWarTile, textTile:ActivityTypeLang.HeroesWarTile, info:ActivityTypeLang.HeroesWarInfo, openTimer:"", timer:0};
        private static const MultiMission:Object = {type:FunctionType.MultiMission, name:ActivityTypeLang.MultiMissionTile, textTile:ActivityTypeLang.MultiMissionTile, info:ActivityTypeLang.MultiMissionInfo, openTimer:"", timer:0};
        private static const BeelzebubTrials:Object = {type:FunctionType.BeelzebubTrials, name:ActivityTypeLang.BeelzebubTrialsName, textTile:ActivityTypeLang.BeelzebubTrialsTile, info:ActivityTypeLang.BeelzebubTrialsInfo, openTimer:"", timer:0};
        private static const TopWarObj:Object = {type:ActivityType.TopWar, name:ActivityTypeLang.TopWarTile, addName:ActivityTypeLang.TopWarAddName, textTile:ActivityTypeLang.TopWarName, info:ActivityTypeLang.TopWarInfo, openTimer:"21:00 - 22:00", timer:21};
        private static const FactionBlessingData:Object = {type:FactionBlessing, name:ActivityTypeLang.FactionBlessingTile, textTile:ActivityTypeLang.FactionBlessingTile, explain:ActivityTypeLang.FactionBlessingExplain, info:ActivityTypeLang.FactionBlessingInfo, factionInfo:ActivityTypeLang.FactionBlessingFactionInfo, awardType:ActivityTypeLang.FactionBlessingAwardType, openLevel:1};
        private static const FactionWarData:Object = {type:FactionWar, name:ActivityTypeLang.FactionWarTile, textTile:ActivityTypeLang.FactionWarTile, explain:ActivityTypeLang.FactionWarExplain, info:ActivityTypeLang.FactionWarInfo, factionInfo:ActivityTypeLang.FactionWarInfo, awardType:ActivityTypeLang.FactionWarExplain, openLevel:2};
        private static const FactionSealData:Object = {type:FactionSeal, name:ActivityTypeLang.FactionSealTile, textTile:ActivityTypeLang.FactionSealTile, explain:ActivityTypeLang.FactionSealExplain, info:ActivityTypeLang.FactionSealInfo, factionInfo:ActivityTypeLang.FactionSealFactionInfo, awardType:ActivityTypeLang.FactionSealAwardType, openLevel:3};
        private static const BossDaoBaTuData:Object = {type:BossDaoBaTu, name:ActivityTypeLang.BossDaoBaName, textTile:ActivityTypeLang.BossDaoBaTuTile, explain:ActivityTypeLang.BossDaoBaTuExplain, info:ActivityTypeLang.BossDaoBaTuInfo, factionInfo:ActivityTypeLang.BossDaoBaTuFactionInfo, awardType:ActivityTypeLang.BossDaoBaTuAwardType, openLevel:4};
        private static const FactionEatData:Object = {type:FactionEat, name:ActivityTypeLang.FactionEatName, textTile:ActivityTypeLang.FactionEatTile, explain:ActivityTypeLang.FactionEatExplain, info:ActivityTypeLang.FactionEatInfo, factionInfo:ActivityTypeLang.FactionEatFactionInfo, awardType:ActivityTypeLang.FactionEatAwardType, openLevel:5};
        private static const FactionRollCakeData:Object = {type:FactionRollCake, name:ActivityTypeLang.FactionRollCakeName, textTile:ActivityTypeLang.FactionRollCakeTile, explain:ActivityTypeLang.FactionRollCakeExplain, info:ActivityTypeLang.FactionRollCakeInfo, factionInfo:ActivityTypeLang.FactionRollCakeFactionInfo, awardType:ActivityTypeLang.FactionRollCakeAwardType, openLevel:5};
        private static const FactionMonsterData:Object = {type:FactionMonster, name:ActivityTypeLang.FactionMonsterName, textTile:ActivityTypeLang.FactionMonsterName + "<font size=\'12\'>" + ActivityTypeLang.FactionMonsterAddName + "</font>", explain:ActivityTypeLang.FactionMonsterTile, info:ActivityTypeLang.FactionMonsterInfo, factionInfo:ActivityTypeLang.FactionMonsterFactionInfo, awardType:ActivityTypeLang.FactionMonsterAwardType, openLevel:4};
        private static const LuckyWheelData:Object = {type:LuckyWheel, name:ActivityTypeLang.LuckyWheelName, textTile:ActivityTypeLang.LuckyWheelTile, explain:ActivityTypeLang.LuckyWheelExplain, info:ActivityTypeLang.LuckyWheelInfo, factionInfo:ActivityTypeLang.LuckyWheelFactionInfo, awardType:ActivityTypeLang.LuckyWheelInfo, openLevel:4};
        private static const activityData:Object = {BossBaiZe:BossBaiZe, BossQingTianMu:BossQingTianMu, BossChiYanShou:BossChiYanShou, BossQingLong:BossQingLong, CampWar:CampWar, HeroesWar:HeroesWarData, MultiMission:MultiMission, BeelzebubTrials:BeelzebubTrials, TopWar:TopWarObj, FactionMonster:FactionMonsterData, FactionBlessing:FactionBlessingData, FactionWar:FactionWarData, FactionSeal:FactionSealData, BossDaoBaTu:BossDaoBaTuData, FactionEat:FactionEatData, FactionRollCake:FactionRollCakeData, luckyWheel:LuckyWheelData};
        public static const factionActivityList:Array = ["FactionBlessing", "FactionWar", "FactionSeal", "BossDaoBaTu", "FactionMonster", "luckyWheel", "FactionEat", "FactionRollCake"];
        public static const factionWindowList:Array = [FactionMonster, LuckyWheel, FactionBlessing, FactionSeal, FactionWar, FactionEat, FactionRollCake, BossDaoBaTu];
        public static const Gift1:String = "GiftType1";
        public static const Gift2:String = "GiftType2";
        public static const Gift3:String = "GiftType3";
        public static const Gift4:String = "GiftType4";
        public static const Gift5:String = "GiftType5";
        public static const Gift6:String = "GiftType6";
        public static const Gift7:String = "GiftType7";
        public static const Gift8:String = "GiftType8";
        public static const Gift9:String = "GiftType9";
        public static const Gift10:String = "GiftType10";
        public static const Gift11:String = "GiftType11";
        public static const Gift12:String = "GiftType12";
        public static const Gift13:String = "GiftType13";
        public static const Gift14:String = "GiftType14";
        public static const Gift15:String = "GiftType15";
        public static const Gift16:String = "GiftType16";
        public static const Gift17:String = "GiftType17";
        public static const Gift18:String = "GiftType18";
        public static const Gift19:String = "GiftType19";
        public static const Gift20:String = "GiftType20";
        public static const Gift21:String = "GiftType21";
        public static const Gift22:String = "GiftType22";
        public static const Gift23:String = "GiftType23";
        public static const Gift24:String = "GiftType24";
        public static const Gift25:String = "GiftType25";
        public static const Gift26:String = "GiftType26";
        public static const Gift27:String = "GiftType27";
        public static const Gift28:String = "GiftType28";
        public static const Gift29:String = "GiftType29";
        public static const Gift30:String = "GiftType30";
        public static const GiftList:Array = [Gift1, Gift2, Gift3, Gift4, Gift5, Gift6, Gift7, Gift8, Gift9, Gift10, Gift11, Gift12, Gift13, Gift14, Gift15, Gift16, Gift17, Gift18, Gift19, Gift20, Gift21, Gift22, Gift23, Gift24, Gift25, Gift26, Gift27, Gift28, Gift29, Gift30];
        public static const FactionWarInto:String = "FactionWarInto";
        public static const FactionWarSignUp:String = "FactionWarSignUp";
        public static const FactionWarSee:String = "FactionWarSee";
        public static const FactionWarGift:String = "FactionWarGift";
        public static const ServerWar:String = "ServerWar";
        public static const WorldFactionWar:String = "WorldFactionWar";
        public static const ActivityDuanWu:String = "ActivityDuanWu";
        public static const ActivityFunction:String = "ActivityFunction";
        public static const ActivityAward:String = "ActivityAward";
        public static const ActivitysList:Array = [ActivityFunction, ActivityAward];
        private static const _activityBoxList:Array = [{sign:FunctionType.SuperSport, isDisappear:0, type:ActivityFunction}, {sign:FunctionType.Farm, isDisappear:0, type:ActivityFunction}, {sign:FunctionType.HeroMission, isDisappear:0, type:ActivityFunction}, {sign:FunctionType.TakeBible, isDisappear:0, type:ActivityFunction}, {sign:FunctionType.Tower, isDisappear:0, type:ActivityFunction}, {sign:FunctionType.Zodiac, isDisappear:0, type:ActivityFunction}, {sign:FunctionType.DailyQuest, isDisappear:1, type:ActivityFunction}, {sign:FunctionType.RollCake, isDisappear:1, type:ActivityFunction}, {sign:FunctionType.GetPeach, isDisappear:1, type:ActivityFunction}, {sign:FunctionType.WorshipMars, isDisappear:1, type:ActivityFunction}, {sign:FunctionType.CampSalary, isDisappear:1, type:ActivityAward}, {sign:Gift4, isDisappear:1, type:ActivityAward}, {sign:FunctionType.SealSoul, isDisappear:1, type:ActivityAward}, {sign:Gift10, isDisappear:1, type:ActivityAward}, {sign:Gift5, isDisappear:1, type:ActivityAward}, {sign:Gift6, isDisappear:1, type:ActivityAward}, {sign:Gift11, isDisappear:1, type:ActivityAward}, {sign:Gift12, isDisappear:1, type:ActivityAward}, {sign:Gift2, isDisappear:1, type:ActivityAward}, {sign:Gift3, isDisappear:1, type:ActivityAward}, {sign:Gift13, isDisappear:1, type:ActivityAward}, {sign:Gift14, isDisappear:1, type:ActivityAward}, {sign:Gift15, isDisappear:1, type:ActivityAward}, {sign:Gift16, isDisappear:1, type:ActivityAward}, {sign:Gift17, isDisappear:1, type:ActivityAward}, {sign:Gift18, isDisappear:1, type:ActivityAward}, {sign:Gift19, isDisappear:1, type:ActivityAward}, {sign:Gift20, isDisappear:1, type:ActivityAward}, {sign:Gift21, isDisappear:1, type:ActivityAward}, {sign:Gift22, isDisappear:1, type:ActivityAward}, {sign:Gift23, isDisappear:1, type:ActivityAward}, {sign:Gift24, isDisappear:1, type:ActivityAward}, {sign:Gift25, isDisappear:1, type:ActivityAward}];

        public function ActivityType()
        {
            return;
        }// end function

        public static function set FactionLevel(param1:int) : void
        {
            _factionLevel = param1;
            return;
        }// end function

        public static function get FactionLevel() : int
        {
            return _factionLevel;
        }// end function

        public static function getTypeToSign(param1:String) : String
        {
            return activityData[param1]["type"] || "";
        }// end function

        public static function getNameToSign(param1:String) : String
        {
            return activityData[param1]["name"] || "";
        }// end function

        public static function getNameToAddName(param1:String) : String
        {
            return activityData[param1]["addName"] || "";
        }// end function

        public static function getTextTileToSign(param1:String) : String
        {
            return activityData[param1]["textTile"] || "";
        }// end function

        public static function getInfoToSign(param1:String) : String
        {
            return activityData[param1]["info"] || "";
        }// end function

        public static function getOpenTimerToSign(param1:String) : String
        {
            return activityData[param1]["openTimer"] || "";
        }// end function

        public static function getTimerToSign(param1:String) : String
        {
            return activityData[param1]["timer"] || "";
        }// end function

        public static function getOpenLevelToSign(param1:String) : int
        {
            return activityData[param1]["openLevel"] || 0;
        }// end function

        public static function getExplainToSign(param1:String) : String
        {
            return activityData[param1]["explain"] || "";
        }// end function

        public static function getAwardTypeToSign(param1:String) : String
        {
            return activityData[param1]["awardType"] || "";
        }// end function

        public static function getFactionInfoToSign(param1:String) : String
        {
            return activityData[param1]["factionInfo"] || "";
        }// end function

        public static function getObj(param1:String) : Object
        {
            return activityData[param1];
        }// end function

        public static function getActivityListForType(param1:String) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = _activityBoxList.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _activityBoxList[_loc_4];
                if (_loc_5.type == param1)
                {
                    _loc_5.lock = _loc_4;
                    _loc_2.push(_loc_5);
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public static function getActivityDataForSign(param1:String) : Object
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = _activityBoxList.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _activityBoxList[_loc_4];
                if (_loc_5.sign == param1)
                {
                    _loc_5.lock = _loc_4;
                    return _loc_5;
                }
                _loc_4++;
            }
            return {};
        }// end function

        public static function checkIsActivityBoxForSign(param1:String) : Boolean
        {
            var _loc_4:Object = null;
            var _loc_2:* = _activityBoxList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _activityBoxList[_loc_3];
                if (_loc_4.sign == param1)
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

    }
}
