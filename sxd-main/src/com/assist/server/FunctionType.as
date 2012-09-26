package com.assist.server
{

    public class FunctionType extends Object
    {
        private static var _List:Object = null;
        public static const Upgrade:String = "Upgrade";
        public static const Training:String = "Training";
        public static const Deploy:String = "Deploy";
        public static const World:String = "World";
        public static const Achievement:String = "Achievement";
        public static const Medical:String = "Medical";
        public static const Research:String = "Research";
        public static const Mounts:String = "Mounts";
        public static const Friend:String = "Friend";
        public static const HorseRaces:String = "HorseRaces";
        public static const Faction:String = "Faction";
        public static const DailyQuest:String = "DailyQuest";
        public static const Farm:String = "Farm";
        public static const Sport:String = "Sport";
        public static const OfflineExp:String = "OfflineExp";
        public static const Partners:String = "Partners";
        public static const Warehouse:String = "Warehouse";
        public static const MultiMission:String = "MultiMission";
        public static const HeroMission:String = "HeroMission";
        public static const Fate:String = "Fate";
        public static const Rune:String = "Rune";
        public static const Stunt:String = "Stunt";
        public static const PK:String = "PK";
        public static const ExtraPower:String = "ExtraPower";
        public static const OnlineGift:String = "OnlineGift";
        public static const CampSalary:String = "CampSalary";
        public static const TravelEvent:String = "TravelEvent";
        public static const Practice:String = "Practice";
        public static const EquipUpgradeQueue:String = "EquipUpgradeQueue";
        public static const CampWar:String = "CampWar";
        public static const MissionPractice:String = "MissionPractice";
        public static const WorldBoss:String = "WorldBoss";
        public static const BuyPower:String = "BuyPower";
        public static const SuperSport:String = "SuperSport";
        public static const LuckyShop:String = "LuckyShop";
        public static const CoinTree:String = "CoinTree";
        public static const TakeBible:String = "TakeBible";
        public static const SendFlower:String = "SendFlower";
        public static const Tower:String = "Tower";
        public static const Inherit:String = "Inherit";
        public static const SealSoul:String = "SealSoul";
        public static const WarAttribute:String = "WarAttribute";
        public static const Robot:String = "Robot";
        public static const HeroMissionPractice:String = "HeroMissionPractice";
        public static const FirstAttcak:String = "FirstAttcak";
        public static const DuJie:String = "DuJie";
        public static const RollCake:String = "RollCake";
        public static const WorshipMars:String = "WorshipMars";
        public static const GetPeach:String = "GetPeach";
        public static const HeroesWar:String = "HeroesWar";
        public static const Zodiac:String = "Zodiac";
        public static const StudyStunt:String = "StudyStunt";
        public static const PetAnimal:String = "PetAnimal";
        public static const FunctionHall:String = "FunctionHall";
        public static const DreamSection:String = "DreamSection";
        public static const CatHunt:String = "CatHunt";
        public static const DailyBox:String = "DailyBox";
        public static const HaloRole:String = "HaloRole";
        public static const WeeklyRank:String = "WeeklyRank";
        public static const Furnace:String = "Furnace";
        public static const BeelzebubTrials:String = "BeelzebubTrials";
        public static const SpecialPartner:String = "SpecialPartner";
        public static const FindImmortal:String = "FindImmortal";
        public static const Body:String = "Body";
        public static const Pack:String = "Pack";
        public static const Quest:String = "Quest";
        public static const DefaultList:Array = [Body, Pack];
        public static const FullList:Array = [Body, Pack, Upgrade, Deploy, Research, Fate, SealSoul, StudyStunt, Achievement, Friend, Faction, Practice];
        private static var _openedList:Object = {};
        private static var _playedList:Object = {};

        public function FunctionType()
        {
            return;
        }// end function

        public static function get List() : Object
        {
            if (_List == null)
            {
                throw new Error("还未赋值！");
            }
            return _List;
        }// end function

        public static function set List(param1:Object) : void
        {
            if (_List != null)
            {
                throw new Error("非法赋值");
            }
            _List = param1;
            return;
        }// end function

        public static function functionIndex(param1:String) : int
        {
            var _loc_2:int = -1;
            var _loc_3:* = FullList.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (FullList[_loc_4] == param1)
                {
                    _loc_2 = _loc_4;
                    break;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public static function sign(param1:int) : String
        {
            if (List[param1] == null)
            {
                return "";
            }
            return List[param1][0];
        }// end function

        public static function isOpened(param1:String) : Boolean
        {
            return _openedList[param1] != null;
        }// end function

        public static function isPlayed(param1:String) : Boolean
        {
            return _playedList[param1] != null;
        }// end function

        public static function isIgnoreTip(param1:String) : Boolean
        {
            return Partners == param1 || OnlineGift == param1 || ExtraPower == param1 || World == param1;
        }// end function

        public static function updateOpenedList(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            var _loc_4:String = null;
            for (_loc_2 in param1)
            {
                
                _loc_3 = param1[_loc_2]["id"];
                if (List[_loc_3] == null)
                {
                    continue;
                }
                _loc_4 = List[_loc_3][0];
                _openedList[_loc_4] = _loc_3;
                if (param1[_loc_2]["isPlayed"] == 1)
                {
                    _playedList[_loc_4] = _loc_3;
                }
            }
            return;
        }// end function

    }
}
