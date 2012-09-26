package com.assist.server
{
    import com.assist.data.mission.*;
    import com.haloer.net.*;

    public class ServerType extends Object
    {
        private var _list:Array;

        public function ServerType()
        {
            this._list = [AchievementType, ActivityType, AssistantAwardType, BeelzeBubTrialsBossType, ConsumeAlertSetType, DelayNotifyType, DeployType, DreamSectionType, DuJieType, FactionMonsterType, FactionType, FameLevel, FateType, FunctionType, FurnaceType, GoldOilType, HaloRoleType, HerbsType, ItemType, MarsType, MissionFailedTipsType, MissionType, MonsterType, MultipleMissionType, NPCType, NineRegionsType, PeachFailedTipsType, PeachType, PetType, PlayerType, ProcessTipsType, QuestType, ResearchType, RoleStunt, RoleType, RollCakeType, , SoulType, SpecialPartnerType, StudyStuntType, TowerFailedTipsType, TowerType, TownNPCType, TownType, VIPType, WarAttributeType, WarCdTimeType, WorldBossType, ZodiacType, 0];
            return;
        }// end function

        public static function format(param1:File) : void
        {
            var file:* = param1;
            var format:* = function (param1:Class, param2:String, param3:Array) : void
            {
                var _loc_7:String = null;
                var _loc_4:* = file.getClassByName("com.assist.server.source." + param2);
                var _loc_5:* = param3.length;
                var _loc_6:int = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_7 = param3[_loc_6];
                    if (_loc_4.hasOwnProperty(_loc_7) == false)
                    {
                        throw new Error(param2 + "不存在" + _loc_7);
                    }
                    param1[_loc_7] = _loc_4[_loc_7];
                    _loc_6++;
                }
                return;
            }// end function
            ;
            ServerType.format(FateType, "FateTypeData", ["Fates", "FateLevel"]);
            ServerType.format(FunctionType, "FunctionTypeData", ["List"]);
            ServerType.format(ItemType, "ItemTypeData", ["Types", "Items", "Qualitys", "EquipJob", "AvatarItemMonster", "ItemUpgrade"]);
            ServerType.format(MissionType, "MissionTypeData", ["Sections", "Missions", "MissionItems"]);
            ServerType.format(MonsterType, "MonsterTypeData", ["Monsters", "Same"]);
            ServerType.format(QuestType, "QuestTypeData", ["Quests"]);
            ServerType.format(RoleStunt, "RoleStuntData", ["Stunts", "RoleWithStunt"]);
            ServerType.format(SoulType, "SoulTypeData", ["Soul"]);
            ServerType.format(TowerType, "TowerTypeData", ["Layer", "LayerSoul"]);
            ServerType.format(TownType, "TownTypeData", ["Towns"]);
            WarData.getItemSuffix = ItemType.getItemSuffix;
            return;
        }// end function

    }
}
