package com
{
    import com.assist.*;
    import com.datas.*;
    import com.protocols.*;
    import flash.utils.*;

    public class Data extends DataBase implements IData
    {
        private var _callbackList:Object;
        private var _ignoreList:Object;

        public function Data() : void
        {
            this._callbackList = {};
            this._ignoreList = {};
            return;
        }// end function

        public function get sample() : SampleData
        {
            return createObject(SampleData) as SampleData;
        }// end function

        public function get player() : PlayerData
        {
            return createObject(PlayerData) as PlayerData;
        }// end function

        public function get town() : TownData
        {
            return createObject(TownData) as TownData;
        }// end function

        public function get quest() : QuestData
        {
            return createObject(QuestData) as QuestData;
        }// end function

        public function get mission() : MissionData
        {
            return createObject(MissionData) as MissionData;
        }// end function

        public function get friend() : FriendData
        {
            return createObject(FriendData) as FriendData;
        }// end function

        public function get deploy() : DeployData
        {
            return createObject(DeployData) as DeployData;
        }// end function

        public function get dujie() : DuJieData
        {
            return createObject(DuJieData) as DuJieData;
        }// end function

        public function get heroMission() : HeroMissionData
        {
            return createObject(HeroMissionData) as HeroMissionData;
        }// end function

        public function get dreamSection() : DreamSectionData
        {
            return createObject(DreamSectionData) as DreamSectionData;
        }// end function

        public function get item() : ItemData
        {
            return createObject(ItemData) as ItemData;
        }// end function

        public function get rolemsg() : RoleMsgData
        {
            return createObject(RoleMsgData) as RoleMsgData;
        }// end function

        public function get rollCake() : RollCakeData
        {
            return createObject(RollCakeData) as RollCakeData;
        }// end function

        public function get research() : ResearchData
        {
            return createObject(ResearchData) as ResearchData;
        }// end function

        public function get upgrade() : UpgradeData
        {
            return createObject(UpgradeData) as UpgradeData;
        }// end function

        public function get chat() : ChatData
        {
            return createObject(ChatData) as ChatData;
        }// end function

        public function get partners() : PartnersData
        {
            return createObject(PartnersData) as PartnersData;
        }// end function

        public function get pet() : PetAnimalData
        {
            return createObject(PetAnimalData) as PetAnimalData;
        }// end function

        public function get multiMission() : MultiMissionData
        {
            return createObject(MultiMissionData) as MultiMissionData;
        }// end function

        public function get farm() : FarmData
        {
            return createObject(FarmData) as FarmData;
        }// end function

        public function get dailyQuest() : DailyQuestData
        {
            return createObject(DailyQuestData) as DailyQuestData;
        }// end function

        public function get faction() : FactionData
        {
            return createObject(FactionData) as FactionData;
        }// end function

        public function get factionWarMap() : FactionWarMapData
        {
            return createObject(FactionWarMapData) as FactionWarMapData;
        }// end function

        public function get rune() : RuneData
        {
            return createObject(RuneData) as RuneData;
        }// end function

        public function get pkWar() : PKWarData
        {
            return createObject(PKWarData) as PKWarData;
        }// end function

        public function get notify() : NotifyData
        {
            return createObject(NotifyData) as NotifyData;
        }// end function

        public function get travelEvent() : TravelEventData
        {
            return createObject(TravelEventData) as TravelEventData;
        }// end function

        public function get worldBoss() : WorldBossData
        {
            return createObject(WorldBossData) as WorldBossData;
        }// end function

        public function get fate() : FateData
        {
            return createObject(FateData) as FateData;
        }// end function

        public function get campWar() : CampWarData
        {
            return createObject(CampWarData) as CampWarData;
        }// end function

        public function get heroesWar() : HeroesWarData
        {
            return createObject(HeroesWarData) as HeroesWarData;
        }// end function

        public function get missionPractice() : MissionPracticeData
        {
            return createObject(MissionPracticeData) as MissionPracticeData;
        }// end function

        public function get vip() : VipData
        {
            return createObject(VipData) as VipData;
        }// end function

        public function get SuperSport() : SuperSportData
        {
            return createObject(SuperSportData) as SuperSportData;
        }// end function

        public function get luckyShop() : LuckyShopData
        {
            return createObject(LuckyShopData) as LuckyShopData;
        }// end function

        public function get takeBible() : TakeBibleData
        {
            return createObject(TakeBibleData) as TakeBibleData;
        }// end function

        public function get sendFlower() : SendFlowerData
        {
            return createObject(SendFlowerData) as SendFlowerData;
        }// end function

        public function get sealSoul() : SealSoulData
        {
            return createObject(SealSoulData) as SealSoulData;
        }// end function

        public function get tower() : TowerData
        {
            return createObject(TowerData) as TowerData;
        }// end function

        public function get inherit() : InheritData
        {
            return createObject(InheritData) as InheritData;
        }// end function

        public function get serverWar() : ServerWarData
        {
            return createObject(ServerWarData) as ServerWarData;
        }// end function

        public function get achievement() : AchievementData
        {
            return createObject(AchievementData) as AchievementData;
        }// end function

        public function get getPeach() : GetPeachData
        {
            return createObject(GetPeachData) as GetPeachData;
        }// end function

        public function get worshipMars() : WorshipMarsData
        {
            return createObject(WorshipMarsData) as WorshipMarsData;
        }// end function

        public function get redEnvelopes() : RedEnvelopesData
        {
            return createObject(RedEnvelopesData) as RedEnvelopesData;
        }// end function

        public function get zodiac() : ZodiacData
        {
            return createObject(ZodiacData) as ZodiacData;
        }// end function

        public function get consumeAlertSetting() : ConsumeAlertSettingData
        {
            return createObject(ConsumeAlertSettingData) as ConsumeAlertSettingData;
        }// end function

        public function get practice() : PracticeData
        {
            return createObject(PracticeData) as PracticeData;
        }// end function

        public function get superDeploy() : SuperDeployData
        {
            return createObject(SuperDeployData) as SuperDeployData;
        }// end function

        public function get studyStunt() : StudyStuntData
        {
            return createObject(StudyStuntData) as StudyStuntData;
        }// end function

        public function get worldFactionWar() : WorldFactionWarData
        {
            return createObject(WorldFactionWarData) as WorldFactionWarData;
        }// end function

        public function get assistant() : AssistantData
        {
            return createObject(AssistantData) as AssistantData;
        }// end function

        public function get haloRole() : HaloRoleData
        {
            return createObject(HaloRoleData) as HaloRoleData;
        }// end function

        public function get catHunt() : CatHuntData
        {
            return createObject(CatHuntData) as CatHuntData;
        }// end function

        public function get warPage() : WarPageData
        {
            return createObject(WarPageData) as WarPageData;
        }// end function

        public function get furnaceMap() : FurnaceData
        {
            return createObject(FurnaceData) as FurnaceData;
        }// end function

        public function get weekRanking() : WeekRankingData
        {
            return createObject(WeekRankingData) as WeekRankingData;
        }// end function

        public function get beelzebubtrials() : BeelzebubTrialsData
        {
            return createObject(BeelzebubTrialsData) as BeelzebubTrialsData;
        }// end function

        public function get nineRegions() : NineRegionsData
        {
            return createObject(NineRegionsData) as NineRegionsData;
        }// end function

        public function get duanWu() : DuanWuData
        {
            return createObject(DuanWuData) as DuanWuData;
        }// end function

        public function get fingerGuess() : FingerGuessData
        {
            return createObject(FingerGuessData) as FingerGuessData;
        }// end function

        public function get topWar() : TopWarData
        {
            return createObject(TopWarData) as TopWarData;
        }// end function

        public function get newTopWar() : NewTopWarData
        {
            return createObject(NewTopWarData) as NewTopWarData;
        }// end function

        public function get specialPartner() : SpecialPartnerData
        {
            return createObject(SpecialPartnerData) as SpecialPartnerData;
        }// end function

        public function get findImmortal() : FindImmortalData
        {
            return createObject(FindImmortalData) as FindImmortalData;
        }// end function

        public function get serverFactionWar() : ServerFactionWarData
        {
            return createObject(ServerFactionWarData) as ServerFactionWarData;
        }// end function

        public function get factionMonster() : FactionMonsterData
        {
            return createObject(FactionMonsterData) as FactionMonsterData;
        }// end function

        public function get luckyWheel() : LuckyWheelData
        {
            return createObject(LuckyWheelData) as LuckyWheelData;
        }// end function

        override public function init(param1:View, param2:Controller) : void
        {
            super.init(param1, param2);
            Mod_Item.register(this);
            Mod_Mission.register(this);
            Mod_Player.register(this);
            Mod_Quest.register(this);
            Mod_Town.register(this);
            Mod_Role.register(this);
            Mod_Research.register(this);
            Mod_Chat.register(this);
            Mod_Partners.register(this);
            Mod_Friend.register(this);
            Mod_Deploy.register(this);
            Mod_Faction.register(this);
            Mod_Farm.register(this);
            Mod_MultiMission.register(this);
            Mod_Rune.register(this);
            Mod_PK.register(this);
            Mod_Notify.register(this);
            Mod_TravelEvent.register(this);
            Mod_Fate.register(this);
            Mod_CampWar.register(this);
            Mod_HeroesWar.register(this);
            Mod_WorldBoss.register(this);
            Mod_MissionPractice.register(this);
            Mod_WarReport.register(this);
            Mod_Vip.register(this);
            Mod_SuperSport.register(this);
            Mod_FactionWar.register(this);
            Mod_TakeBible.register(this);
            Mod_SendFlower.register(this);
            Mod_SealSoul.register(this);
            Mod_Tower.register(this);
            Mod_Inherit.register(this);
            Mod_HeroMission.register(this);
            Mod_ServerWar.register(this);
            Mod_ServerFactionWar.register(this);
            Mod_DuJie.register(this);
            Mod_RollCake.register(this);
            Mod_Achievement.register(this);
            Mod_GetPeach.register(this);
            Mod_WorshipMars.register(this);
            Mod_RedEnvelopes.register(this);
            Mod_Zodiac.register(this);
            Mod_Practice.register(this);
            Mod_SuperDeploy.register(this);
            Mod_PetAnimal.register(this);
            Mod_StudyStunt.register(this);
            Mod_DreamSection.register(this);
            Mod_WorldFactionWar.register(this);
            Mod_Assistant.register(this);
            Mod_HaloRole.register(this);
            Mod_CatHunt.register(this);
            Mod_Furnace.register(this);
            Mod_WeekRanking.register(this);
            Mod_BeelzebubTrials.register(this);
            Mod_NineRegions.register(this);
            Mod_DuanWu.register(this);
            Mod_FingerGuess.register(this);
            Mod_TopWar.register(this);
            Mod_NewTopWar.register(this);
            Mod_SpecialPartner.register(this);
            Mod_FindImmortal.register(this);
            Mod_FactionMonster.register(this);
            Mod_LuckyWheel.register(this);
            Helper.backtrace("connecting", URI.ip, URI.port);
            this.connect(URI.ip, URI.port);
            return;
        }// end function

        override protected function parseSocketData(param1:ByteArray) : void
        {
            var modId:uint;
            var funId:uint;
            var id:String;
            var p:Object;
            var p1:Object;
            var buffer:* = param1;
            modId = buffer.readUnsignedByte();
            funId = buffer.readUnsignedByte();
            if (modId == 120 && funId == 156)
            {
                buffer.position = 0;
                buffer.uncompress();
                modId = buffer.readUnsignedByte();
                funId = buffer.readUnsignedByte();
            }
            var term:* = Protocol.concat(modId, funId);
            var callback:* = this._callbackList[term];
            if (this._ignoreList[term])
            {
                Helper.recordInteraction(Helper.RESPONSE, modId, funId, [buffer]);
                this.callback(buffer);
                dispatch(modId, funId);
                return;
            }
            var result:Array;
            var _loc_3:int = 0;
            var _loc_4:* = Mod.Modules;
            do
            {
                
                id = _loc_4[_loc_3];
                if (parseInt(id) == modId)
                {
                    try
                    {
                        result = this.analyze(Mod.Modules[id], modId, funId, buffer);
                    }
                    catch (e)
                    {
                        _view.alert.confirm("[ModId:" + modId + ",FunId" + funId + "]" + e);
                        p = Protocol.lookupProtocol(modId, funId);
                        Helper.error("[response]接口不匹配：", Protocol.getProtocolDescription(p["request"]), "\n", e);
                        return;
                    }
                }
            }while (_loc_4 in _loc_3)
            Helper.recordInteraction(Helper.RESPONSE, modId, funId, result);
            if (callback is Function)
            {
                this.callback(result);
            }
            else
            {
                p1 = Protocol.lookupProtocol(modId, funId);
                throw new Error("\n\t" + "没有注册接口回调方法：" + Protocol.getProtocolDescription(p1["request"]) + "\n\t------");
            }
            dispatch(modId, funId);
            removeNotAllow(modId, funId);
            return;
        }// end function

        public function registerDataCallback(param1:Object, param2:Function, param3:Boolean = false) : void
        {
            var _loc_4:* = param1["module"];
            var _loc_5:* = param1["action"];
            var _loc_6:* = Protocol.concat(_loc_4, _loc_5);
            if (this._callbackList[_loc_6])
            {
                throw new Error("指定的协议重复注册回调方法！");
            }
            this._callbackList[_loc_6] = param2;
            if (param3)
            {
                this._ignoreList[_loc_6] = param3;
            }
            return;
        }// end function

        private function analyze(param1:Class, param2:uint, param3:uint, param4:ByteArray) : Array
        {
            var _loc_9:Object = null;
            var _loc_5:Array = [];
            var _loc_6:* = param1["Actions"];
            var _loc_7:* = param1["Actions"].length;
            var _loc_8:int = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_9 = param1[_loc_6[_loc_8]];
                if (_loc_9["action"] == param3)
                {
                    _loc_5 = Protocol.analyze(param4, _loc_9["response"]);
                    break;
                }
                _loc_8++;
            }
            return _loc_5;
        }// end function

    }
}
