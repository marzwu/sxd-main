package com
{
    import com.controllers.*;

    public class Controller extends ControllerBase
    {

        public function Controller()
        {
            return;
        }// end function

        public function get sample() : SampleController
        {
            return createObject(SampleController) as SampleController;
        }// end function

        public function get player() : PlayerController
        {
            return createObject(PlayerController) as PlayerController;
        }// end function

        public function get pet() : PetAnimalController
        {
            return createObject(PetAnimalController) as PetAnimalController;
        }// end function

        public function get town() : TownController
        {
            return createObject(TownController) as TownController;
        }// end function

        public function get quest() : QuestController
        {
            return createObject(QuestController) as QuestController;
        }// end function

        public function get mission() : MissionController
        {
            return createObject(MissionController) as MissionController;
        }// end function

        public function get friend() : FriendController
        {
            return createObject(FriendController) as FriendController;
        }// end function

        public function get heroMission() : HeroMissionController
        {
            return createObject(HeroMissionController) as HeroMissionController;
        }// end function

        public function get deploy() : DeployController
        {
            return createObject(DeployController) as DeployController;
        }// end function

        public function get dujie() : DuJieController
        {
            return createObject(DuJieController) as DuJieController;
        }// end function

        public function get rolemsg() : RoleMsgController
        {
            return createObject(RoleMsgController) as RoleMsgController;
        }// end function

        public function get dreamSection() : DreamSectionController
        {
            return createObject(DreamSectionController) as DreamSectionController;
        }// end function

        public function get item() : ItemController
        {
            return createObject(ItemController) as ItemController;
        }// end function

        public function get research() : ResearchController
        {
            return createObject(ResearchController) as ResearchController;
        }// end function

        public function get upgrade() : UpgradeController
        {
            return createObject(UpgradeController) as UpgradeController;
        }// end function

        public function get chat() : ChatController
        {
            return createObject(ChatController) as ChatController;
        }// end function

        public function get partners() : PartnersController
        {
            return createObject(PartnersController) as PartnersController;
        }// end function

        public function get farm() : FarmController
        {
            return createObject(FarmController) as FarmController;
        }// end function

        public function get multiMission() : MultiMissionController
        {
            return createObject(MultiMissionController) as MultiMissionController;
        }// end function

        public function get dailyQuest() : DailyQuestController
        {
            return createObject(DailyQuestController) as DailyQuestController;
        }// end function

        public function get faction() : FactionController
        {
            return createObject(FactionController) as FactionController;
        }// end function

        public function get factionWarMap() : FactionWarMapController
        {
            return createObject(FactionWarMapController) as FactionWarMapController;
        }// end function

        public function get rune() : RuneController
        {
            return createObject(RuneController) as RuneController;
        }// end function

        public function get pkWar() : PKWarController
        {
            return createObject(PKWarController) as PKWarController;
        }// end function

        public function get notify() : NotifyController
        {
            return createObject(NotifyController) as NotifyController;
        }// end function

        public function get travelEvent() : TravelEventController
        {
            return createObject(TravelEventController) as TravelEventController;
        }// end function

        public function get fate() : FateController
        {
            return createObject(FateController) as FateController;
        }// end function

        public function get campWar() : CampWarController
        {
            return createObject(CampWarController) as CampWarController;
        }// end function

        public function get heroesWar() : HeroesWarController
        {
            return createObject(HeroesWarController) as HeroesWarController;
        }// end function

        public function get worldBossMap() : WorldBossMapController
        {
            return createObject(WorldBossMapController) as WorldBossMapController;
        }// end function

        public function get worldFactionWar() : WorldFactionWarController
        {
            return createObject(WorldFactionWarController) as WorldFactionWarController;
        }// end function

        public function get missionPractice() : MissionPracticeController
        {
            return createObject(MissionPracticeController) as MissionPracticeController;
        }// end function

        public function get vip() : VipController
        {
            return createObject(VipController) as VipController;
        }// end function

        public function get superSport() : SuperSportController
        {
            return createObject(SuperSportController) as SuperSportController;
        }// end function

        public function get luckyShop() : LuckyShopController
        {
            return createObject(LuckyShopController) as LuckyShopController;
        }// end function

        public function get TakeBible() : TakeBibleController
        {
            return createObject(TakeBibleController) as TakeBibleController;
        }// end function

        public function get tower() : TowerController
        {
            return createObject(TowerController) as TowerController;
        }// end function

        public function get sendFlower() : SendFlowerController
        {
            return createObject(SendFlowerController) as SendFlowerController;
        }// end function

        public function get sealSoul() : SealSoulController
        {
            return createObject(SealSoulController) as SealSoulController;
        }// end function

        public function get serverWar() : ServerWarController
        {
            return createObject(ServerWarController) as ServerWarController;
        }// end function

        public function get inherit() : InheritController
        {
            return createObject(InheritController) as InheritController;
        }// end function

        public function get achievement() : AchievementController
        {
            return createObject(AchievementController) as AchievementController;
        }// end function

        public function get rollCake() : RollCakeController
        {
            return createObject(RollCakeController) as RollCakeController;
        }// end function

        public function get getPeach() : GetPeachController
        {
            return createObject(GetPeachController) as GetPeachController;
        }// end function

        public function get worshipMars() : WorshipMarsController
        {
            return createObject(WorshipMarsController) as WorshipMarsController;
        }// end function

        public function get redEnvelopes() : RedEnvelopesController
        {
            return createObject(RedEnvelopesController) as RedEnvelopesController;
        }// end function

        public function get zodiac() : ZodiacController
        {
            return createObject(ZodiacController) as ZodiacController;
        }// end function

        public function get consumeAlertSetting() : ConsumeAlertSettingController
        {
            return createObject(ConsumeAlertSettingController) as ConsumeAlertSettingController;
        }// end function

        public function get practice() : PracticeController
        {
            return createObject(PracticeController) as PracticeController;
        }// end function

        public function get superDeploy() : SuperDeployController
        {
            return createObject(SuperDeployController) as SuperDeployController;
        }// end function

        public function get studyStunt() : StudyStuntController
        {
            return createObject(StudyStuntController) as StudyStuntController;
        }// end function

        public function get assistant() : AssistantController
        {
            return createObject(AssistantController) as AssistantController;
        }// end function

        public function get haloRole() : HaloRoleController
        {
            return createObject(HaloRoleController) as HaloRoleController;
        }// end function

        public function get catHunt() : CatHuntController
        {
            return createObject(CatHuntController) as CatHuntController;
        }// end function

        public function get warPage() : WarPageController
        {
            return createObject(WarPageController) as WarPageController;
        }// end function

        public function get furnaceMap() : FurnaceController
        {
            return createObject(FurnaceController) as FurnaceController;
        }// end function

        public function get weekRanking() : WeekRankingController
        {
            return createObject(WeekRankingController) as WeekRankingController;
        }// end function

        public function get beelzebubTrials() : BeelzebubTrialsController
        {
            return createObject(BeelzebubTrialsController) as BeelzebubTrialsController;
        }// end function

        public function get nineRegions() : NineRegionsController
        {
            return createObject(NineRegionsController) as NineRegionsController;
        }// end function

        public function get duanWu() : DuanWuController
        {
            return createObject(DuanWuController) as DuanWuController;
        }// end function

        public function get fingerGuess() : FingerGuessController
        {
            return createObject(FingerGuessController) as FingerGuessController;
        }// end function

        public function get topWar() : TopWarController
        {
            return createObject(TopWarController) as TopWarController;
        }// end function

        public function get newTopWar() : NewTopWarController
        {
            return createObject(NewTopWarController) as NewTopWarController;
        }// end function

        public function get specialPartner() : SpecialPartnerController
        {
            return createObject(SpecialPartnerController) as SpecialPartnerController;
        }// end function

        public function get findImmortal() : FindImmortalController
        {
            return createObject(FindImmortalController) as FindImmortalController;
        }// end function

        public function get serverFactionWar() : ServerFactionWarController
        {
            return createObject(ServerFactionWarController) as ServerFactionWarController;
        }// end function

        public function get factionMonster() : FactionMonsterController
        {
            return createObject(FactionMonsterController) as FactionMonsterController;
        }// end function

        public function get luckyWheel() : LuckyWheelController
        {
            return createObject(LuckyWheelController) as LuckyWheelController;
        }// end function

    }
}
