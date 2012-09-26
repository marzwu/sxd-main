package com
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.map.*;
    import com.assist.view.pack.*;
    import com.assist.view.sound.*;
    import com.haloer.net.*;
    import com.lang.client.com.*;
    import com.protocols.*;
    import com.views.*;
    import com.views.map.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;

    public class View extends ViewBase
    {
        private var _cookie:Cookie;
        public var time1:Number;
        public var time2:Number;
        private var _fcount:int;
        private var _hasEvent:Boolean = true;
        private var _hasKeyDown:Boolean = false;
        private var _delayList:Object;
        private var _info:TextField;

        public function View(param1:Stage)
        {
            this._delayList = {};
            super(param1);
            this.initAddAssets();
            this.initContextMenu();
            this.initFrameTime();
            this.initJSHandler();
            return;
        }// end function

        public function initAddAssets() : void
        {
            addAssets("Furnace", "furnace.swf");
            addAssets("Activities", "activities.swf");
            addAssets("ActivitiesShow", "activities_show.swf");
            addAssets("ArmsRecast", "arms_recast.swf");
            addAssets("ArmsGold", "arms_gold.swf");
            addAssets("ActivationKeys", "activation_keys.swf");
            addAssets("ActivityWindow", "activity_window.swf");
            addAssets("Alert", "alert.swf");
            addAssets("Audience", "audience.swf");
            addAssets("CampWar", "camp_war.swf");
            addAssets("HeroesWar", "heroes_war.swf");
            addAssets("Chat", "chat.swf");
            addAssets("DuJie", "dujie.swf");
            addAssets("ChooseCamp", "choose_camp.swf");
            addAssets("ChooseMission", "choose_mission.swf");
            addAssets("ChooseRoles", "choose_roles.swf");
            addAssets("DailyQuest", "daily_quest.swf");
            addAssets("Deploy", "deploy.swf");
            addAssets("Farm", "farm.swf");
            addAssets("Fate", "fate.swf");
            addAssets("FriendChatBox", "friend_chat.swf");
            addAssets("FriendList", "friend_list.swf");
            addAssets("FactionTrophy", "faction_trophy.swf");
            addAssets("FactionTable", "faction_war_table.swf");
            addAssets("FactionWarSignUp", "faction_war_sign_up.swf");
            addAssets("FactionWarSignUpList", "faction_war_sign_up_list.swf");
            addAssets("FactionBossSelect", "faction_boss_select.swf");
            addAssets("FactionBlessing", "faction_blessing.swf");
            addAssets("FactionWindow", "faction_window.swf");
            addAssets("FriendMessage", "friend_message.swf");
            addAssets("FactionSeal", "faction_seal.swf");
            addAssets("GameHelper", "game_helper.swf");
            addAssets("GameMaster", "game_master.swf");
            addAssets("HeroMission", "hero_mission.swf");
            addAssets("HeroPractice", "hero_practice.swf");
            addAssets("DreamSection", "dream_section.swf");
            addAssets("ImmortalityMsg", "immortality_msg.swf");
            addAssets("InitLoading", "init_loading.swf");
            addAssets("InitLoadingBaidu", "init_loading_baidu.swf");
            addAssets("InitLoadingMangguo", "init_loading_mangguo.swf");
            addAssets("JoinFaction", "join_faction.swf");
            addAssets("Lodge", "lodge.swf");
            addAssets("LuckyShop", "lucky_shop.swf");
            addAssets("Map", "map.swf");
            addAssets("MiniFactionWar", "mini_faction_war.swf");
            addAssets("MissionFailedTips", "mission_failed_tips.swf");
            addAssets("MissionPractice", "mission_practice.swf");
            addAssets("MissionRank", "mission_rank.swf");
            addAssets("MultiMission", "multi_mission.swf");
            addAssets("MultiWar", "multi_war.swf");
            addAssets("MyFaction", "my_faction.swf");
            addAssets("NPCDialog", "npc_dialog.swf");
            addAssets("DelayMessage", "delay_message.swf");
            addAssets("DramaPlayBack", "drama_playback.swf");
            addAssets("OtherHead", "other_head.swf");
            addAssets("Pack", "pack.swf");
            addAssets("PanelLoading", "panel_loading.swf");
            addAssets("Partners", "partners.swf");
            addAssets("Pet", "pet.swf");
            addAssets("PreventIndulge", "prevent_indulge.swf");
            addAssets("ProcessTips", "process_tips.swf");
            addAssets("Quest", "quest.swf");
            addAssets("Ranking", "ranking.swf");
            addAssets("Refine", "refine.swf");
            addAssets("Research", "research.swf");
            addAssets("RoleMsg", "role_msg.swf");
            addAssets("RoleMsgSee", "role_msg_see.swf");
            addAssets("Rune", "rune.swf");
            addAssets("RollCake", "roll_cake.swf");
            addAssets("Setting", "setting.swf");
            addAssets("Shop", "shop.swf");
            addAssets("StandaloneChat", "standalone_chat.swf");
            addAssets("Strategy", "strategy.swf");
            addAssets("Subline", "subline.swf");
            addAssets("SuperSport", "super_sport.swf");
            addAssets("ServerWarSignUp", "serverwar_signup.swf");
            addAssets("ServerWarRecord", "serverwar_record.swf");
            addAssets("ServerWarCup", "serverwar_cup.swf");
            addAssets("ServerFactionWarSignUp", "server_faction_war_signup.swf");
            addAssets("ServerFactionWarRecord", "server_faction_war_record.swf");
            addAssets("ServerFactionWarCup", "server_faction_war_cup.swf");
            addAssets("Templet", "templet.swf");
            addAssets("Tip2", "addons/tip2.swf");
            addAssets("Toolbar", "toolbar.swf");
            addAssets("ToolbarFooter", "toolbar_footer.swf");
            addAssets("Training", "training.swf");
            addAssets("RoleDetailInfo", "role_detail_info.swf");
            addAssets("TravelEvent", "travel_event.swf");
            addAssets("TriggerFunction", "trigger_function.swf");
            addAssets("TakeBibleRoad", "take_bible_road.swf");
            addAssets("TakeBibleReady", "take_bible_ready.swf");
            addAssets("TakeBibleRuLai", "take_bible_rulai.swf");
            addAssets("Tower", "tower.swf");
            addAssets("Upgrade", "upgrade.swf");
            addAssets("Vip", "vip.swf");
            addAssets("War", "war.swf");
            addAssets("WarPage", "war_page.swf");
            addAssets("WarResources", "war_resources.swf");
            addAssets("WhatsNew", "whats_new.swf");
            addAssets("WinEffect", "win_effect.swf");
            addAssets("World", "world.swf");
            addAssets("NewWorld", "new_world.swf");
            addAssets("WorldFactionwarSignup", "world_factionwar_signup.swf");
            addAssets("WorldFactionwarSignupList", "world_factionwar_signup_list.swf");
            addAssets("WorldFactionwarRecord", "world_factionwar_record.swf");
            addAssets("WorldFactionwarCup", "world_factionwar_cup.swf");
            addAssets("WorldNotice", "notice.swf");
            addAssets("ProgressBar", "progress_bar.swf");
            addAssets("SendFlower", "send_flower.swf");
            addAssets("FlowerWeekRanking", "flower_week_ranking.swf");
            addAssets("SealSoul", "seal_soul.swf");
            addAssets("Inherit", "inherit.swf");
            addAssets("ConsumeAlertSetting", "consume_alert_setting.swf");
            addAssets("Achievement", "achievement.swf");
            addAssets("AchievementComplete", "achievement_complete.swf");
            addAssets("WorshipMars", "worship_mars.swf");
            addAssets("GetPeach", "get_peach.swf");
            addAssets("RedEnvelopes", "red_envelopes.swf");
            addAssets("FactionRollCake", "faction_roll_cake.swf");
            addAssets("PlayerCompare", "player_compare.swf");
            addAssets("SealShop", "seal_shop.swf");
            addAssets("GoldOilShop", "gold_oil_shop.swf");
            addAssets("Zodiac", "zodiac.swf");
            addAssets("SuperDeploy", "super_deploy.swf");
            addAssets("SealStone", "seal_stone.swf");
            addAssets("SealStoneShop", "seal_stone_shop.swf");
            addAssets("StudyStunt", "study_stunt.swf");
            addAssets("CatHunt", "cat_hunt.swf");
            addAssets("HaloRole", "halo_role.swf");
            addAssets("CheckFaction", "check_faction.swf");
            addAssets("PartnersNew", "partners_new.swf");
            addAssets("HaloButtle", "halo_buttle.swf");
            addAssets("WeekRanking", "week_ranking.swf");
            addAssets("FateInfo", "fate_info.swf");
            addAssets("BeelzebubTrials", "beelzebubtrials.swf");
            addAssets("NineRegions", "nine_regions.swf");
            addAssets("McNineRegionsTeamCreat", "nine_regions_team_creat.swf");
            addAssets("BuildSendItem", "build_dialog.swf");
            addAssets("DuanWuWorship", "duanwu_worship.swf");
            addAssets("FingerGuess", "finger_guess.swf");
            addAssets("ActivityDuanWu", "activity_duan_wu.swf");
            addAssets("TopWarCreate", "top_war_create.swf");
            addAssets("NewTopWarCreate", "new_top_war.swf");
            addAssets("SpecialPartner", "special_partner.swf");
            addAssets("FindImmortal", "find_immortal.swf");
            addAssets("OtherTeamInfo", "new_top_war_team_info.swf");
            addAssets("TopThrone", "top_throne.swf");
            addAssets("Liveness", "liveness.swf");
            addAssets("LuckyWheel", "lucky_wheel.swf");
            addAssets("PartnersInfo", "partners_info.swf");
            return;
        }// end function

        public function get activities() : ActivitiesView
        {
            return createObject(ActivitiesView) as ActivitiesView;
        }// end function

        public function get activitiesShow() : ActivitiesShowView
        {
            return createObject(ActivitiesShowView) as ActivitiesShowView;
        }// end function

        public function get activityWindow() : ActivityWindowView
        {
            return createObject(ActivityWindowView) as ActivityWindowView;
        }// end function

        public function get activationKeys() : ActivationKeysView
        {
            return createObject(ActivationKeysView) as ActivationKeysView;
        }// end function

        public function get alert() : AlertView
        {
            return this.createObject(AlertView) as AlertView;
        }// end function

        public function get audience() : AudienceView
        {
            return createObject(AudienceView) as AudienceView;
        }// end function

        public function get campWar() : CampWarView
        {
            return createObject(CampWarView) as CampWarView;
        }// end function

        public function get heroesWar() : HeroesWarView
        {
            return createObject(HeroesWarView) as HeroesWarView;
        }// end function

        public function get chat() : ChatView
        {
            return createObject(ChatView) as ChatView;
        }// end function

        public function get chooseCamp() : ChooseCampView
        {
            return createObject(ChooseCampView) as ChooseCampView;
        }// end function

        public function get chooseMission() : ChooseMissionView
        {
            return createObject(ChooseMissionView) as ChooseMissionView;
        }// end function

        public function get chooseRoles() : ChooseRolesView
        {
            return this.createObject(ChooseRolesView) as ChooseRolesView;
        }// end function

        public function get dramaPlayBack() : DramaPlayBackView
        {
            return createObject(DramaPlayBackView) as DramaPlayBackView;
        }// end function

        public function get dailyQuest() : DailyQuestView
        {
            return this.createObject(DailyQuestView) as DailyQuestView;
        }// end function

        public function get deploy() : DeployView
        {
            return createObject(DeployView) as DeployView;
        }// end function

        public function get dujie() : DuJieView
        {
            return createObject(DuJieView) as DuJieView;
        }// end function

        public function get dujieWar() : DuJieWarView
        {
            return createObject(DuJieWarView) as DuJieWarView;
        }// end function

        public function get drag() : DragView
        {
            return this.createObject(DragView) as DragView;
        }// end function

        public function get drama() : DramaView
        {
            return createObject(DramaView) as DramaView;
        }// end function

        public function get dramaWar() : DramaWarView
        {
            return createObject(DramaWarView) as DramaWarView;
        }// end function

        public function get dreamSection() : DreamSectionView
        {
            return createObject(DreamSectionView) as DreamSectionView;
        }// end function

        public function get dreamSectionWar() : DreamSectionWarView
        {
            return createObject(DreamSectionWarView) as DreamSectionWarView;
        }// end function

        public function get farm() : FarmView
        {
            return this.createObject(FarmView) as FarmView;
        }// end function

        public function get fate() : FateView
        {
            return createObject(FateView) as FateView;
        }// end function

        public function get friendChat() : FriendChatView
        {
            return createObject(FriendChatView) as FriendChatView;
        }// end function

        public function get friendList() : FriendListView
        {
            return createObject(FriendListView) as FriendListView;
        }// end function

        public function get friendMessage() : FriendMessageView
        {
            return createObject(FriendMessageView) as FriendMessageView;
        }// end function

        public function get factionBlessing() : FactionBlessingView
        {
            return createObject(FactionBlessingView) as FactionBlessingView;
        }// end function

        public function get factionSeal() : FactionSealView
        {
            return createObject(FactionSealView) as FactionSealView;
        }// end function

        public function get factionEat() : FactionEatView
        {
            return createObject(FactionEatView) as FactionEatView;
        }// end function

        public function get factionWar() : FactionWarView
        {
            return createObject(FactionWarView) as FactionWarView;
        }// end function

        public function get factionWarMap() : FactionWarMapView
        {
            return createObject(FactionWarMapView) as FactionWarMapView;
        }// end function

        public function get factionTrophy() : FactionTrophyView
        {
            return createObject(FactionTrophyView) as FactionTrophyView;
        }// end function

        public function get factionBossSelect() : FactionBossSelectView
        {
            return createObject(FactionBossSelectView) as FactionBossSelectView;
        }// end function

        public function get factionWarSignUp() : FactionWarSignUpView
        {
            return createObject(FactionWarSignUpView) as FactionWarSignUpView;
        }// end function

        public function get factionWarSignUpList() : FactionWarSignUpListView
        {
            return createObject(FactionWarSignUpListView) as FactionWarSignUpListView;
        }// end function

        public function get factionTable() : FactionTableView
        {
            return createObject(FactionTableView) as FactionTableView;
        }// end function

        public function get factionWindow() : FactionWindowView
        {
            return createObject(FactionWindowView) as FactionWindowView;
        }// end function

        public function get furnaceMap() : FurnaceMapView
        {
            return createObject(FurnaceMapView) as FurnaceMapView;
        }// end function

        public function get furnaceRoleDialog() : FurnaceRoleDialogView
        {
            return createObject(FurnaceRoleDialogView) as FurnaceRoleDialogView;
        }// end function

        public function get refiningFurnace() : RefiningFurnaceView
        {
            return createObject(RefiningFurnaceView) as RefiningFurnaceView;
        }// end function

        public function get gameHelper() : GameHelperView
        {
            return this.createObject(GameHelperView) as GameHelperView;
        }// end function

        public function get gameMaster() : GameMasterView
        {
            return createObject(GameMasterView) as GameMasterView;
        }// end function

        public function get getPeachWar() : GetPeachWarView
        {
            return createObject(GetPeachWarView) as GetPeachWarView;
        }// end function

        public function get guide() : GuideView
        {
            return createObject(GuideView) as GuideView;
        }// end function

        public function get heroMission() : HeroMissionView
        {
            return createObject(HeroMissionView) as HeroMissionView;
        }// end function

        public function get heroPractice() : HeroPracticeView
        {
            return createObject(HeroPracticeView) as HeroPracticeView;
        }// end function

        public function get immortalityMsg() : ImmortalityMsgView
        {
            return createObject(ImmortalityMsgView) as ImmortalityMsgView;
        }// end function

        public function get inCampWar() : InCampWarView
        {
            return createObject(InCampWarView) as InCampWarView;
        }// end function

        public function get initLoading() : InitLoadingView
        {
            return this.createObject(InitLoadingView) as InitLoadingView;
        }// end function

        public function get joinFaction() : JoinFactionView
        {
            return createObject(JoinFactionView) as JoinFactionView;
        }// end function

        public function get load() : LoadView
        {
            return createObject(LoadView) as LoadView;
        }// end function

        public function get login() : LoginView
        {
            return createObject(LoginView) as LoginView;
        }// end function

        public function get lodge() : LodgeView
        {
            return createObject(LodgeView) as LodgeView;
        }// end function

        public function get miniFactionWar() : MiniFactionWarView
        {
            return createObject(MiniFactionWarView) as MiniFactionWarView;
        }// end function

        public function get missionFailedTips() : MissionFailedTipsView
        {
            return createObject(MissionFailedTipsView) as MissionFailedTipsView;
        }// end function

        public function get missionMap() : MissionMapView
        {
            return createObject(MissionMapView) as MissionMapView;
        }// end function

        public function get missionPractice() : MissionPracticeView
        {
            return createObject(MissionPracticeView) as MissionPracticeView;
        }// end function

        public function get missionRank() : MissionRankView
        {
            return createObject(MissionRankView) as MissionRankView;
        }// end function

        public function get multiMission() : MultiMissionView
        {
            return createObject(MultiMissionView) as MultiMissionView;
        }// end function

        public function get multiWar() : MultiWarView
        {
            return this.createObject(MultiWarView) as MultiWarView;
        }// end function

        public function get myFaction() : MyFactionView
        {
            return createObject(MyFactionView) as MyFactionView;
        }// end function

        public function get npcDialog() : NPCDialogView
        {
            return this.createObject(NPCDialogView) as NPCDialogView;
        }// end function

        public function get otherRoleMsg() : OtherRoleMsgView
        {
            return createObject(OtherRoleMsgView) as OtherRoleMsgView;
        }// end function

        public function get otherHead() : OtherHeadView
        {
            return createObject(OtherHeadView) as OtherHeadView;
        }// end function

        public function get pack() : PackView
        {
            return createObject(PackView) as PackView;
        }// end function

        public function get pet() : PetView
        {
            return createObject(PetView) as PetView;
        }// end function

        public function get panelLoading() : PanelLoadingView
        {
            return this.createObject(PanelLoadingView) as PanelLoadingView;
        }// end function

        public function get partners() : PartnersView
        {
            return this.createObject(PartnersView) as PartnersView;
        }// end function

        public function get pkWar() : PKWarView
        {
            return createObject(PKWarView) as PKWarView;
        }// end function

        public function get preventIndulge() : PreventIndulgeView
        {
            return createObject(PreventIndulgeView) as PreventIndulgeView;
        }// end function

        public function get processTip() : ProcessTipsView
        {
            return createObject(ProcessTipsView) as ProcessTipsView;
        }// end function

        public function get quest() : QuestView
        {
            return createObject(QuestView) as QuestView;
        }// end function

        public function get ranking() : RankingView
        {
            return this.createObject(RankingView) as RankingView;
        }// end function

        public function get refine() : RefineView
        {
            return createObject(RefineView) as RefineView;
        }// end function

        public function get research() : ResearchView
        {
            return this.createObject(ResearchView) as ResearchView;
        }// end function

        public function get roleMsg() : RoleMsgView
        {
            return createObject(RoleMsgView) as RoleMsgView;
        }// end function

        public function get rune() : RuneView
        {
            return createObject(RuneView) as RuneView;
        }// end function

        public function get rollCake() : RollCakeView
        {
            return createObject(RollCakeView) as RollCakeView;
        }// end function

        public function get screen() : ScreenView
        {
            return createObject(ScreenView) as ScreenView;
        }// end function

        public function get shop() : ShopView
        {
            return createObject(ShopView) as ShopView;
        }// end function

        public function get setting() : SettingView
        {
            return createObject(SettingView) as SettingView;
        }// end function

        public function get sportWar() : SportWarView
        {
            return createObject(SportWarView) as SportWarView;
        }// end function

        public function get standaloneChat() : StandaloneChatView
        {
            return createObject(StandaloneChatView) as StandaloneChatView;
        }// end function

        public function get strategy() : StrategyView
        {
            return createObject(StrategyView) as StrategyView;
        }// end function

        public function get strategyWar() : StrategyWarView
        {
            return createObject(StrategyWarView) as StrategyWarView;
        }// end function

        public function get subline() : SublineView
        {
            return this.createObject(SublineView) as SublineView;
        }// end function

        public function get superSport() : SuperSportView
        {
            return createObject(SuperSportView) as SuperSportView;
        }// end function

        public function get superSportWar() : SuperSportWarView
        {
            return createObject(SuperSportWarView) as SuperSportWarView;
        }// end function

        public function get takeBibleWar() : TakeBibleWarView
        {
            return createObject(TakeBibleWarView) as TakeBibleWarView;
        }// end function

        public function get tip() : TipView
        {
            return this.createObject(TipView) as TipView;
        }// end function

        public function get tip2() : Tip2View
        {
            return this.createObject(Tip2View) as Tip2View;
        }// end function

        public function get toolbar() : ToolbarView
        {
            return createObject(ToolbarView) as ToolbarView;
        }// end function

        public function get towerWar() : TowerWarView
        {
            return createObject(TowerWarView) as TowerWarView;
        }// end function

        public function get townMap() : TownMapView
        {
            return createObject(TownMapView) as TownMapView;
        }// end function

        public function get training() : TrainingView
        {
            return createObject(TrainingView) as TrainingView;
        }// end function

        public function get tower() : TowerView
        {
            return createObject(TowerView) as TowerView;
        }// end function

        public function get takeBibleRoad() : TakeBibleRoadView
        {
            return createObject(TakeBibleRoadView) as TakeBibleRoadView;
        }// end function

        public function get takeBibleReady() : TakeBibleReadyView
        {
            return createObject(TakeBibleReadyView) as TakeBibleReadyView;
        }// end function

        public function get takeBibleRuLai() : TakeBibleRuLaiView
        {
            return createObject(TakeBibleRuLaiView) as TakeBibleRuLaiView;
        }// end function

        public function get travelEvent() : TravelEventView
        {
            return createObject(TravelEventView) as TravelEventView;
        }// end function

        public function get triggerFunction() : TriggerFunctionView
        {
            return createObject(TriggerFunctionView) as TriggerFunctionView;
        }// end function

        public function get upgrade() : UpgradeView
        {
            return this.createObject(UpgradeView) as UpgradeView;
        }// end function

        public function get vip() : VipView
        {
            return this.createObject(VipView) as VipView;
        }// end function

        public function get war() : WarView
        {
            return createObject(WarView) as WarView;
        }// end function

        public function get warehouse() : WarehouseView
        {
            return createObject(WarehouseView) as WarehouseView;
        }// end function

        public function get whatsNew() : WhatsNewView
        {
            return createObject(WhatsNewView) as WhatsNewView;
        }// end function

        public function get worldFactionWarCup() : WorldFactionWarCupView
        {
            return createObject(WorldFactionWarCupView) as WorldFactionWarCupView;
        }// end function

        public function get worldFactionWarRecord() : WorldFactionWarRecordView
        {
            return createObject(WorldFactionWarRecordView) as WorldFactionWarRecordView;
        }// end function

        public function get worldFactionWarSignUp() : WorldFactionWarSignUpView
        {
            return createObject(WorldFactionWarSignUpView) as WorldFactionWarSignUpView;
        }// end function

        public function get worldFactionWarSignUpList() : WorldFactionWarSignUpListView
        {
            return createObject(WorldFactionWarSignUpListView) as WorldFactionWarSignUpListView;
        }// end function

        public function get worldFactionWar() : WorldFactionWarView
        {
            return createObject(WorldFactionWarView) as WorldFactionWarView;
        }// end function

        public function get world() : WorldView
        {
            return createObject(WorldView) as WorldView;
        }// end function

        public function get newWorld() : NewWorldView
        {
            return createObject(NewWorldView) as NewWorldView;
        }// end function

        public function get worldBossMap() : WorldBossMapView
        {
            return createObject(WorldBossMapView) as WorldBossMapView;
        }// end function

        public function get worldBossWar() : WorldBossWarView
        {
            return createObject(WorldBossWarView) as WorldBossWarView;
        }// end function

        public function get worldNotice() : WorldNoticeView
        {
            return createObject(WorldNoticeView) as WorldNoticeView;
        }// end function

        public function get luckyShop() : LuckyShopView
        {
            return createObject(LuckyShopView) as LuckyShopView;
        }// end function

        public function get delayMessage() : DelayMessageView
        {
            return createObject(DelayMessageView) as DelayMessageView;
        }// end function

        public function get progressBar() : ProgressBarView
        {
            return createObject(ProgressBarView) as ProgressBarView;
        }// end function

        public function get sendFlower() : SendFlowerView
        {
            return createObject(SendFlowerView) as SendFlowerView;
        }// end function

        public function get myFlowerRecord() : MyFlowerRecordView
        {
            return createObject(MyFlowerRecordView) as MyFlowerRecordView;
        }// end function

        public function get flowerWeekRanking() : FlowerWeekRankingView
        {
            return createObject(FlowerWeekRankingView) as FlowerWeekRankingView;
        }// end function

        public function get sealSoul() : SealSoulView
        {
            return createObject(SealSoulView) as SealSoulView;
        }// end function

        public function get serverWarSignUp() : ServerWarSignUpView
        {
            return createObject(ServerWarSignUpView) as ServerWarSignUpView;
        }// end function

        public function get serverWarRecord() : ServerWarRecordView
        {
            return createObject(ServerWarRecordView) as ServerWarRecordView;
        }// end function

        public function get serverWarCup() : ServerWarCupView
        {
            return createObject(ServerWarCupView) as ServerWarCupView;
        }// end function

        public function get serverFactionWarSignUp() : ServerFactionWarSignUpView
        {
            return createObject(ServerFactionWarSignUpView) as ServerFactionWarSignUpView;
        }// end function

        public function get serverFactionWarRecord() : ServerFactionWarRecordView
        {
            return createObject(ServerFactionWarRecordView) as ServerFactionWarRecordView;
        }// end function

        public function get serverFactionWarCup() : ServerFactionWarCupView
        {
            return createObject(ServerFactionWarCupView) as ServerFactionWarCupView;
        }// end function

        public function get inherit() : InheritView
        {
            return createObject(InheritView) as InheritView;
        }// end function

        public function get roleDetailInfo() : RoleDetailInfoView
        {
            return createObject(RoleDetailInfoView) as RoleDetailInfoView;
        }// end function

        public function get consumeAlertSetting() : ConsumeAlertSettingView
        {
            return createObject(ConsumeAlertSettingView) as ConsumeAlertSettingView;
        }// end function

        public function get achievement() : AchievementView
        {
            return createObject(AchievementView) as AchievementView;
        }// end function

        public function get achievementComplete() : AchievementCompleteView
        {
            return createObject(AchievementCompleteView) as AchievementCompleteView;
        }// end function

        public function get armsRecast() : ArmsRecastView
        {
            return createObject(ArmsRecastView) as ArmsRecastView;
        }// end function

        public function get armsGold() : ArmsGoldView
        {
            return createObject(ArmsGoldView) as ArmsGoldView;
        }// end function

        public function get worshipMars() : WorshipMarsView
        {
            return createObject(WorshipMarsView) as WorshipMarsView;
        }// end function

        public function get getPeach() : GetPeachView
        {
            return createObject(GetPeachView) as GetPeachView;
        }// end function

        public function get redEnvelopes() : RedEnvelopesView
        {
            return createObject(RedEnvelopesView) as RedEnvelopesView;
        }// end function

        public function get factionRollCake() : FactionRollCakeView
        {
            return createObject(FactionRollCakeView) as FactionRollCakeView;
        }// end function

        public function get playerCompare() : PlayerCompareView
        {
            return createObject(PlayerCompareView) as PlayerCompareView;
        }// end function

        public function get sealShop() : SealShopView
        {
            return createObject(SealShopView) as SealShopView;
        }// end function

        public function get goldOilShop() : GoldOilShopView
        {
            return createObject(GoldOilShopView) as GoldOilShopView;
        }// end function

        public function get zodiac() : ZodiacView
        {
            return createObject(ZodiacView) as ZodiacView;
        }// end function

        public function get zodiacWar() : ZodiacWarView
        {
            return createObject(ZodiacWarView) as ZodiacWarView;
        }// end function

        public function get superDeploy() : SuperDeployView
        {
            return createObject(SuperDeployView) as SuperDeployView;
        }// end function

        public function get sealStone() : SealStoneView
        {
            return createObject(SealStoneView) as SealStoneView;
        }// end function

        public function get sealStoneShop() : SealStoneShopView
        {
            return createObject(SealStoneShopView) as SealStoneShopView;
        }// end function

        public function get studyStunt() : StudyStuntView
        {
            return createObject(StudyStuntView) as StudyStuntView;
        }// end function

        public function get catHunt() : CatHuntView
        {
            return createObject(CatHuntView) as CatHuntView;
        }// end function

        public function get haloRole() : HaloRoleView
        {
            return createObject(HaloRoleView) as HaloRoleView;
        }// end function

        public function get haloRoleWar() : HaloRoleWarView
        {
            return createObject(HaloRoleWarView) as HaloRoleWarView;
        }// end function

        public function get checkFaction() : CheckFactionView
        {
            return createObject(CheckFactionView) as CheckFactionView;
        }// end function

        public function get warPage() : WarPageView
        {
            return createObject(WarPageView) as WarPageView;
        }// end function

        public function get partnersNew() : PartnersNewView
        {
            return createObject(PartnersNewView) as PartnersNewView;
        }// end function

        public function get haloButtle() : HaloButtleView
        {
            return createObject(HaloButtleView) as HaloButtleView;
        }// end function

        public function get weekRanking() : WeekRankingView
        {
            return createObject(WeekRankingView) as WeekRankingView;
        }// end function

        public function get fateInfo() : FateInfoView
        {
            return createObject(FateInfoView) as FateInfoView;
        }// end function

        public function get beelzebubTrials() : BeelzebubTrialsView
        {
            return createObject(BeelzebubTrialsView) as BeelzebubTrialsView;
        }// end function

        public function get beelzebubTrialsMap() : BeelzebubTrialsMapView
        {
            return createObject(BeelzebubTrialsMapView) as BeelzebubTrialsMapView;
        }// end function

        public function get beelzebubTrialsWar() : BeelzebubTrialsWarView
        {
            return createObject(BeelzebubTrialsWarView) as BeelzebubTrialsWarView;
        }// end function

        public function get nineRegions() : NineRegionsView
        {
            return createObject(NineRegionsView) as NineRegionsView;
        }// end function

        public function get nineRegionsMap() : NineRegionsMapView
        {
            return createObject(NineRegionsMapView) as NineRegionsMapView;
        }// end function

        public function get nineRegionsDrama() : NineRegionsDramaView
        {
            return createObject(NineRegionsDramaView) as NineRegionsDramaView;
        }// end function

        public function get nineRegionsTeamCreat() : NineRegionsTeamCreatView
        {
            return createObject(NineRegionsTeamCreatView) as NineRegionsTeamCreatView;
        }// end function

        public function get nineRegionsWar() : NineRegionsWarView
        {
            return createObject(NineRegionsWarView) as NineRegionsWarView;
        }// end function

        public function get buildSendItem() : BuildSendItemView
        {
            return createObject(BuildSendItemView) as BuildSendItemView;
        }// end function

        public function get duanWuWorship() : DuanWuWorshipView
        {
            return createObject(DuanWuWorshipView) as DuanWuWorshipView;
        }// end function

        public function get fingerGuess() : FingerGuessView
        {
            return createObject(FingerGuessView) as FingerGuessView;
        }// end function

        public function get activityDuanWu() : ActivityDuanWuView
        {
            return createObject(ActivityDuanWuView) as ActivityDuanWuView;
        }// end function

        public function get topWarMap() : TopWarMapView
        {
            return createObject(TopWarMapView) as TopWarMapView;
        }// end function

        public function get topWarCreate() : TopWarCreateView
        {
            return createObject(TopWarCreateView) as TopWarCreateView;
        }// end function

        public function get newTopWar() : NewTopWarView
        {
            return createObject(NewTopWarView) as NewTopWarView;
        }// end function

        public function get topThrone() : TopThroneView
        {
            return createObject(TopThroneView) as TopThroneView;
        }// end function

        public function get nineRegionsHiddenWar() : NineRegionsHiddenWarView
        {
            return createObject(NineRegionsHiddenWarView) as NineRegionsHiddenWarView;
        }// end function

        public function get topWarWar() : TopWarWarView
        {
            return createObject(TopWarWarView) as TopWarWarView;
        }// end function

        public function get specialPartner() : SpecialPartnerView
        {
            return createObject(SpecialPartnerView) as SpecialPartnerView;
        }// end function

        public function get findImmortal() : FindImmortalView
        {
            return createObject(FindImmortalView) as FindImmortalView;
        }// end function

        public function get liveness() : LivenessView
        {
            return createObject(LivenessView) as LivenessView;
        }// end function

        public function get luckyWheel() : LuckyWheelView
        {
            return createObject(LuckyWheelView) as LuckyWheelView;
        }// end function

        public function get otherTeamInfo() : OtherTeamInfoView
        {
            return createObject(OtherTeamInfoView) as OtherTeamInfoView;
        }// end function

        public function get partnersInfo() : PartnersInfoView
        {
            return createObject(PartnersInfoView) as PartnersInfoView;
        }// end function

        public function get factionMonsterWar() : FactionMonsterWarView
        {
            return createObject(FactionMonsterWarView) as FactionMonsterWarView;
        }// end function

        public function hideLoadingText() : void
        {
            var _loc_1:* = stage.getChildAt(0);
            _loc_1.visible = false;
            return;
        }// end function

        public function formatServerData() : void
        {
            var _loc_1:String = "Templet";
            ServerType.format(getAssetsObj(_loc_1));
            removeResource(_loc_1);
            WarData.removeNickNameSuffix = _ctrl.player.removeNickNameSuffix;
            return;
        }// end function

        public function afterGetPlayerInfo() : void
        {
            this.initCookie();
            structure.drawMark();
            this.panelLoading.show();
            this.screen.show();
            _data.call(Mod_Player_Base.server_time, this.serverTimeCallBack, []);
            MouseCursor.init(structure.mouse, _stage);
            MapStatic.mapStage = _stage;
            MapStatic.effectLayder = structure.tip;
            MapStatic.FolderDrama = URI.dramaUrl;
            MapStatic.FolderRole = URI.roleUrl;
            MapStatic.FolderScreen = URI.screenUrl;
            MapStatic.FolderMap = URI.mapUrl;
            MapStatic.FolderItemIcon = URI.goodsIconUrl;
            MapStatic.FolderNPCIcon = URI.npcIconUrl;
            MapStatic.FolderEffects = URI.effectsUrl;
            MapStatic.getRoleName = RoleType.getRoleName;
            MapStatic.getRoleSign = RoleType.getRoleSign;
            MapStatic.removeNickNameSuffix = _data.player.removeNickNameSuffix;
            ItemTipSprite.iTip = this.tip.iTip;
            BoxGrid.itip = this.tip.iTip;
            BoxGrid.dragLayer = structure.tip;
            SoundEffect.url = URI.soundEffectUrl;
            SoundEffect.onVersion = URI.getVersion;
            SoundEffect.load();
            SoundManage.getVersion = URI.getVersion;
            this.initEvent();
            return;
        }// end function

        public function reposition() : void
        {
            this.webInfo();
            return;
        }// end function

        public function serverTimeCallBack() : void
        {
            this.activities.redEnvelopes();
            return;
        }// end function

        private function initCookie() : void
        {
            this._cookie = new Cookie("age_" + _data.player.playerId);
            return;
        }// end function

        public function setCookie(param1:String, param2:Object) : void
        {
            this._cookie.setCookie(param1, param2);
            return;
        }// end function

        public function getCookie(param1:String) : Object
        {
            return this._cookie.getCookie(param1);
        }// end function

        public function get superViews() : Array
        {
            return [ActivitiesView, CampWarView, HeroesWarView, ChooseRolesView, FactionWarView, GetPeachView, InCampWarView, LodgeView, MiniFactionWarView, MissionFailedTipsView, MultiWarView, MultiMissionView, PKWarView, PreventIndulgeView, SuperSportView, SuperSportWarView, SportWarView, StrategyWarView, StudyStuntView, WarView, WorldBossWarView, ZodiacView, ZodiacWarView, ActivitiesShowView, DreamSectionView, DreamSectionWarView, HaloRoleView, HaloRoleWarView, HaloButtleView, FingerGuessView, TopWarCreateView, NewTopWarView, FindImmortalView, TopThroneView];
        }// end function

        public function get coexistViews() : Array
        {
            return [[AudienceView, FriendChatView, FriendListView, OtherRoleMsgView, RoleMsgView], [OtherRoleMsgView, OtherTeamInfoView], [OtherRoleMsgView, RoleMsgView, ImmortalityMsgView], [RoleMsgView, MyFactionView, OtherRoleMsgView], [RoleMsgView, TrainingView, AchievementView], [RoleMsgView, MyFlowerRecordView], [RoleMsgView, ArmsGoldView], [PackView, ArmsGoldView], [RoleMsgView, OtherRoleMsgView, RoleDetailInfoView], [OtherRoleMsgView, PlayerCompareView], [PackView, WarehouseView], [PackView, ShopView], [RoleMsgView, PackView], [RoleMsgView, RefineView], [RoleMsgView, DuJieView], [OtherRoleMsgView, ServerWarRecordView], [FateView, RoleMsgView], [WorldView, TravelEventView], [NewWorldView, TravelEventView], [GameHelperView, RuneView], [GameHelperView, DailyQuestView], [FactionBlessingView, RoleMsgView, OtherRoleMsgView], [FactionWarSignUpView, FactionWarSignUpListView], [FactionWindowView, FactionBossSelectView], [ImmortalityMsgView, InheritView], [GoldOilShopView, ZodiacView], [SealSoulView, SealStoneShopView], [SealStoneShopView, TowerView], [SealStoneView, TowerView], [HaloRoleView, HaloRoleWarView], [RefiningFurnaceView, PackView], [FateInfoView, LodgeView], [FateInfoView, FateView], [WorldFactionWarSignUpListView, WorldFactionWarSignUpView, OtherRoleMsgView], [BeelzebubTrialsView, BeelzebubTrialsMapView], [RuneView, SealSoulView], [PartnersNewView, PartnersInfoView]];
        }// end function

        public function get exclusiveViews() : Array
        {
            return [{master:FactionWarView, black:[], white:[]}, {master:InitLoadingView, black:[], white:[]}, {master:MultiWarView, black:[], white:[]}, {master:PKWarView, black:[], white:[]}, {master:StrategyWarView, black:[], white:[]}, {master:TowerWarView, black:[], white:[]}, {master:WorldBossWarView, black:[], white:[]}, {master:SealSoulView, black:[], white:[RuneView, SealStoneShopView]}];
        }// end function

        public function get inTownViews() : Array
        {
            return [ChooseCampView, ChooseMissionView, SuperSportView, TowerView];
        }// end function

        public function get freeViews() : Array
        {
            return [ChatView, ChooseCampView, GameMasterView, MissionPracticeView, PanelLoadingView, RuneView, TakeBibleReadyView, TakeBibleRoadView, TravelEventView, WhatsNewView, TriggerFunctionView, FriendMessageView];
        }// end function

        private function initFrameTime() : void
        {
            var ftime:Number;
            var ftime1:Number;
            var ftime2:Number;
            var fcount:int;
            ftime = getTimer();
            ftime1;
            ftime2;
            fcount;
            this.addToFrameProcessList(sign, function () : void
            {
                var _loc_2:* = fcount + 1;
                fcount = _loc_2;
                ftime2 = getTimer() - ftime;
                ftime1 = ftime2 * 0.001;
                ftime = getTimer();
                time1 = ftime1;
                time2 = ftime2;
                _fcount = fcount;
                return;
            }// end function
            );
            return;
        }// end function

        private function initEvent() : void
        {
            _stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUpHandler);
            _stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownHandler);
            _stage.addEventListener(Event.ACTIVATE, this.stageActivateHandler);
            return;
        }// end function

        public function openEvent() : void
        {
            this._hasEvent = true;
            return;
        }// end function

        public function closeEvent() : void
        {
            this._hasEvent = false;
            return;
        }// end function

        private function onKeyUpHandler(event:KeyboardEvent) : void
        {
            if (this._hasKeyDown == false)
            {
                return;
            }
            if (this.isTextFieldInput(event.target))
            {
                return;
            }
            MapKey.keyUpHandler(event);
            return;
        }// end function

        private function onKeyDownHandler(event:KeyboardEvent) : void
        {
            this._hasKeyDown = true;
            if (event.keyCode == 107)
            {
            }
            if (event.ctrlKey && event.keyCode == 49)
            {
                this.resetHost();
                _stage.focus = null;
                return;
            }
            if (event.ctrlKey && event.keyCode == 50)
            {
                Helper.switchInteraction();
                _stage.focus = null;
                return;
            }
            if (Keyboard.TAB == event.keyCode)
            {
                _stage.focus = null;
                return;
            }
            if (this._hasEvent == false)
            {
                return;
            }
            if (this.drama.inStage == true)
            {
                return;
            }
            if (this.alert.iAlert.visible)
            {
                if (event.keyCode == Keyboard.ENTER)
                {
                    this.alert.iAlert.defaultCloseEvent();
                }
                return;
            }
            if (this.isTextFieldInput(event.target))
            {
                return;
            }
            if (event.keyCode == Keyboard.ESCAPE)
            {
                _structure.popup.closeAll();
            }
            else if (event.keyCode == Keyboard.ENTER)
            {
            }
            else if (event.keyCode == 192)
            {
            }
            else if (event.keyCode == 67)
            {
                SoundEffect.play(SoundEffect.Button);
                this.roleMsg.switchSelf();
            }
            else if (event.keyCode == 66)
            {
                SoundEffect.play(SoundEffect.Button);
                this.pack.switchSelf();
            }
            else if (event.keyCode == 70)
            {
                if (FunctionType.isOpened(FunctionType.Upgrade))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.upgrade.switchSelf();
                }
            }
            else if (event.keyCode == 69)
            {
                if (FunctionType.isOpened(FunctionType.Deploy))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.superDeploy.switchSelf();
                }
            }
            else if (event.keyCode == 84)
            {
                if (FunctionType.isOpened(FunctionType.Research))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.research.switchSelf();
                }
            }
            else if (event.keyCode == 88)
            {
                if (FunctionType.isOpened(FunctionType.Fate))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.fate.switchSelf();
                }
            }
            else if (event.keyCode == 89)
            {
                if (FunctionType.isOpened(FunctionType.SealSoul))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.sealSoul.switchSelf();
                }
            }
            else if (event.keyCode == 82)
            {
                if (FunctionType.isOpened(FunctionType.Farm))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.farm.switchSelf();
                }
            }
            else if (event.keyCode == 81)
            {
                SoundEffect.play(SoundEffect.Button);
                this.quest.switchSelf();
            }
            else if (event.keyCode == 86)
            {
                if (FunctionType.isOpened(FunctionType.Friend))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.friendList.switchSelf();
                }
            }
            else if (event.keyCode == 71)
            {
                if (FunctionType.isOpened(FunctionType.Faction))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.myFaction.switchSelf();
                }
            }
            else if (event.keyCode == 90)
            {
                if (FunctionType.isOpened(FunctionType.Practice))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.toolbar.switchPractice();
                }
            }
            else if (event.keyCode == 80)
            {
                if (FunctionType.isOpened(FunctionType.Achievement))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.achievement.switchSelf();
                }
            }
            else if (event.keyCode == 72)
            {
                if (FunctionType.isOpened(FunctionType.StudyStunt))
                {
                    SoundEffect.play(SoundEffect.Button);
                    this.studyStunt.switchSelf();
                }
            }
            else
            {
                if (event.keyCode == Keyboard.UP && Shortcut.moveUp())
                {
                    this._hasKeyDown = false;
                    return;
                }
                if (event.keyCode == Keyboard.DOWN && Shortcut.moveDown())
                {
                    this._hasKeyDown = false;
                    return;
                }
                if (event.keyCode == Keyboard.SPACE && Shortcut.execute())
                {
                    this._hasKeyDown = false;
                    return;
                }
                if (event.keyCode == Keyboard.HOME)
                {
                    this.missionFailedTips.showTower(6, 10);
                }
                else if (event.keyCode == 85)
                {
                }
                else if (event.keyCode == Keyboard.PAGE_UP)
                {
                }
                else if (event.keyCode == Keyboard.PAGE_DOWN)
                {
                }
                else if (event.keyCode == Keyboard.DELETE)
                {
                }
            }
            MapKey.keyDownHandler(event);
            return;
        }// end function

        private function stageActivateHandler(event:Event) : void
        {
            stage.focus = null;
            MapKey.reset();
            return;
        }// end function

        private function isTextFieldInput(param1:Object) : Boolean
        {
            return param1 is TextField && (param1 as TextField).type == "input";
        }// end function

        public function resetHost() : void
        {
            var callback:* = function (param1:String) : void
            {
                var host:* = param1;
                if (war.inStage)
                {
                    return;
                }
                alert.socketClosed(ViewLang.Connecting);
                structure.popup.closeAll();
                try
                {
                    townMap.clear();
                }
                catch (e)
                {
                    try
                    {
                    }
                    missionMap.clear();
                }
                catch (e)
                {
                    try
                    {
                    }
                    toolbar.close();
                }
                catch (e)
                {
                }
                destroyAllObject("alert");
                _data.onConnect = function () : void
                {
                    alert.close();
                    show();
                    return;
                }// end function
                ;
                _data.connect(host, URI.serverPort);
                return;
            }// end function
            ;
            URI.selectDomain(callback);
            return;
        }// end function

        private function initContextMenu() : void
        {
            var _loc_1:* = new ContextMenu();
            _loc_1.customItems.push(this.contextMenuItem(ViewLang.WebSite, URI.webSiteUrl));
            _loc_1.customItems.push(this.contextMenuItem(ViewLang.BBS, URI.bbsUrl));
            _loc_1.customItems.push(this.contextMenuItem(Lang.sprintf(ViewLang.Version, "1.0.1"), "", false));
            _loc_1.customItems.push(this.contextMenuItem(ViewLang.Company, "", false));
            var _loc_2:* = stage.getChildAt(0);
            _loc_2.contextMenu = _loc_1;
            return;
        }// end function

        private function contextMenuItem(param1:String, param2:String, param3:Boolean = true) : ContextMenuItem
        {
            var text:* = param1;
            var url:* = param2;
            var enabled:* = param3;
            var item:* = new ContextMenuItem(text);
            item.enabled = enabled;
            item.separatorBefore = true;
            var handler:* = function (event:ContextMenuEvent) : void
            {
                if (url)
                {
                    navigateToURL(new URLRequest(url));
                }
                return;
            }// end function
            ;
            item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, handler);
            return item;
        }// end function

        public function showTip(param1:String, param2:String = null, param3:int = 5) : void
        {
            var _loc_4:* = this.tipColor(param3);
            this.tip2.showTip(HtmlText.format(param1, _loc_4, 14, "", true), param2, param3);
            return;
        }// end function

        private function tipColor(param1:int) : uint
        {
            var _loc_2:uint = 2272312;
            switch(param1)
            {
                case TipType.Alert:
                {
                    _loc_2 = HtmlText.Yellow;
                    break;
                }
                case TipType.Failure:
                {
                    _loc_2 = HtmlText.Red;
                    break;
                }
                case TipType.Process:
                {
                    _loc_2 = HtmlText.White;
                    break;
                }
                case TipType.Question:
                {
                    _loc_2 = HtmlText.Blue2;
                    break;
                }
                case TipType.Success:
                {
                    _loc_2 = 3394611;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function hideTip() : void
        {
            this.tip2.hideTip();
            return;
        }// end function

        public function get vipEnabled() : Boolean
        {
            if (VIPType.enabled == false)
            {
                this.showTip(ViewLang.VipEnabled);
                return false;
            }
            return true;
        }// end function

        public function ingotEnough(param1:int) : Boolean
        {
            if (_data.player.ingot < param1)
            {
                this.showTip(ViewLang.IngotEnough);
                return false;
            }
            return true;
        }// end function

        public function coinEnough(param1:int) : Boolean
        {
            if (_data.player.coins < param1)
            {
                this.showTip(ViewLang.CoinEnough);
                return false;
            }
            return true;
        }// end function

        public function get inWar() : Boolean
        {
            return this.dreamSectionWar.opened || this.dujieWar.opened || this.getPeachWar.opened || this.haloRoleWar.opened || this.inCampWar.opened || this.multiWar.opened || this.superSportWar.opened || this.takeBibleWar.opened || this.towerWar.opened || this.war.opened || this.worldBossWar.opened || this.strategyWar.opened || this.zodiacWar.opened || this.beelzebubTrialsWar.opened || this.nineRegionsWar.opened || this.topWarWar.opened;
        }// end function

        public function set onWarClose(param1:Function) : void
        {
            this.dreamSectionWar.onWarClose = param1;
            this.dujieWar.onWarClose = param1;
            this.getPeachWar.onWarClose = param1;
            this.haloRoleWar.onWarClose = param1;
            this.inCampWar.onWarClose = param1;
            this.multiWar.onWarClose = param1;
            this.superSportWar.onWarClose = param1;
            this.takeBibleWar.onWarClose = param1;
            this.towerWar.onWarClose = param1;
            this.war.onWarClose = param1;
            this.worldBossWar.onWarClose = param1;
            this.strategyWar.onWarClose = param1;
            this.zodiacWar.onWarClose = param1;
            this.beelzebubTrialsWar.onWarClose = param1;
            this.nineRegionsWar.onWarClose = param1;
            return;
        }// end function

        public function hasDelayed(param1:String) : Boolean
        {
            return this._delayList[param1];
        }// end function

        public function delayExecute(param1:String, param2:Function, param3:int = 0) : void
        {
            this._delayList[param1] = [param2, param3];
            return;
        }// end function

        public function removeDelayed(param1:String) : void
        {
            delete this._delayList[param1];
            return;
        }// end function

        public function triggerDelayed(... args) : void
        {
            var _loc_4:String = null;
            args = args.length;
            var _loc_3:int = 0;
            while (_loc_3 < args)
            {
                
                _loc_4 = args[_loc_3];
                if (this._delayList[_loc_4])
                {
                    this.delayDone(_loc_4);
                }
                _loc_3++;
            }
            return;
        }// end function

        private function delayDone(param1:String) : void
        {
            var type:* = param1;
            var callback:* = this._delayList[type][0];
            var delay:* = this._delayList[type][1];
            delete this._delayList[type];
            if (!(callback is Function))
            {
                return;
            }
            if (delay > 0)
            {
                addToFrameProcessList(type, function () : void
            {
                if (--delay == 0)
                {
                    removeFromFrameProcessList(type);
                    callback();
                }
                return;
            }// end function
            );
            }
            else
            {
                this.callback();
            }
            return;
        }// end function

        public function show() : void
        {
            this.load.show();
            return;
        }// end function

        public function showLoading(param1:String, param2:int, param3:int = 1, param4:int = 1) : void
        {
            this.panelLoading.updatePanelLoading(param1, param2, param3, param4);
            return;
        }// end function

        public function hideLoading() : void
        {
            this.panelLoading.close();
            return;
        }// end function

        public function showViewProcess(param1:String, param2:int = 0) : void
        {
            return;
        }// end function

        public function hideViewProcess() : void
        {
            return;
        }// end function

        public function showDataProcess(param1:String) : void
        {
            return;
        }// end function

        public function hideDataProcess() : void
        {
            return;
        }// end function

        private function webInfo() : void
        {
            if (this._info == null)
            {
                this._info = new TextField();
                _stage.addChild(this._info);
                this._info.textColor = 10066329;
                this._info.selectable = false;
                this._info.multiline = true;
                this._info.autoSize = TextFieldAutoSize.LEFT;
                this._info.htmlText = URI.publish || "";
                this._info.setTextFormat(new TextFormat("", 13, null, null, null, null, null, null, "center"));
                this._info.addEventListener(TextEvent.LINK, this.infoHandler);
            }
            this._info.x = Math.floor((_stage.stageWidth - this._info.width) / 2);
            this._info.y = Math.floor(Structure.stageOffset.y + Structure.stageHeight + 10);
            return;
        }// end function

        private function infoHandler(event:TextEvent) : void
        {
            if (event.text == "Favorite")
            {
                this.addToFavorite();
            }
            return;
        }// end function

        private function initJSHandler() : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.addCallback("web_close", this.webClose);
            }
            return;
        }// end function

        public function webClose() : String
        {
            var _loc_1:* = _ctrl.player.getWebInfo;
            if (Config.EnableDomainSelector == true || _ctrl.player.level >= 60)
            {
                _loc_1 = "";
            }
            return _loc_1;
        }// end function

        public function firstLogin(param1:Boolean) : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("firstLogin", param1 || false);
            }
            return;
        }// end function

        public function switchToBaiDu() : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("switchToBaiDu");
            }
            return;
        }// end function

        public function addToFavorite() : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("addToFavorite");
            }
            return;
        }// end function

        public function switchWeiBoFriend(param1:Boolean) : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("switchWeiBoFriend", param1);
            }
            return;
        }// end function

        public function sendWeiBo(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String) : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("sendWeiBo", param1, param2, param3, param4, param5, param6, param7);
            }
            return;
        }// end function

        public function openWorld() : void
        {
            var _loc_1:* = _ctrl.player.townMapId;
            if (_loc_1 <= TownType.MaxOldMap)
            {
                this.world.show();
            }
            else
            {
                this.newWorld.show();
            }
            return;
        }// end function

        public function mapSwitched(param1:uint) : void
        {
            ItemInfo.playerlv = this.ctrl.player.level;
            this.initLoading.close();
            this.delayMessage.checkVisible();
            this.guide.checkVisible();
            this.processTip.checkVisible();
            this.toolbar.miniMap.content.visible = false;
            this.toolbar.world_war_top_login_back();
            this.activitiesShow.removeChildren();
            switch(param1)
            {
                case MapViewBase.Town:
                {
                    this.activities.activityVisible = true;
                    this.toolbar.miniMap.content.visible = true;
                    this.chat.visiblePost = true;
                    this.toolbar.playerDataVisible = true;
                    this.toolbar.functionLinkVisible = true;
                    this.toolbar.loadQuestTraceInTown();
                    this.toolbar.repositionInTown();
                    this.triggerDelayed(DelayType.WayFinding, DelayType.AutoEnterMission, DelayType.MoveToPortal, DelayType.OpenFunction, DelayType.PartnersCount, DelayType.Partners, DelayType.Research, DelayType.StudyStunt, DelayType.TianDiYuPai);
                    this.missionPractice.get_continue_practice_info();
                    if (FunctionType.isOpened(FunctionType.HeroMissionPractice))
                    {
                        this.heroPractice.get_continue_practice_info();
                    }
                    this.factionBlessing.checkIncense();
                    this.factionEat.checkFactionEat();
                    this.factionRollCake.showRollCake();
                    this.luckyWheel.enter();
                    this.takeBibleRoad.close();
                    this.takeBibleReady.close();
                    this.takeBibleRuLai.close();
                    this.toolbar.renderQuestTrace();
                    break;
                }
                case MapViewBase.Mission:
                {
                    this.activities.activityVisible = false;
                    this.toolbar.questTraceTipVisible = false;
                    this.guide.hideAlongGuide();
                    break;
                }
                case MapViewBase.WorldBoss:
                {
                    this.activities.activityVisible = false;
                    this.toolbar.questTraceVisible = false;
                    this.toolbar.reposition();
                    break;
                }
                case MapViewBase.FactionWar:
                {
                    this.activities.activityVisible = false;
                    this.chat.visiblePost = false;
                    this.chat.changeChannel(Mod_Chat_Base.ACTIVITY);
                    this.toolbar.questTraceVisible = false;
                    this.toolbar.playerDataVisible = false;
                    this.toolbar.functionLinkVisible = false;
                    this.toolbar.repositionInTown();
                    break;
                }
                case MapViewBase.HuZhongJie:
                {
                    this.activities.activityVisible = false;
                    this.toolbar.miniMap.content.visible = false;
                    this.toolbar.questTraceVisible = false;
                    this.toolbar.playerDataVisible = false;
                    this.toolbar.functionLinkVisible = false;
                    break;
                }
                case MapViewBase.BeelzebubTrials:
                {
                    this.activities.activityVisible = false;
                    this.toolbar.miniMap.content.visible = false;
                    this.toolbar.questTraceVisible = false;
                    this.toolbar.playerDataVisible = false;
                    this.toolbar.functionLinkVisible = false;
                    break;
                }
                case MapViewBase.NineRegions:
                {
                    this.activities.activityVisible = false;
                    this.toolbar.miniMap.content.visible = false;
                    this.toolbar.questTraceVisible = false;
                    this.toolbar.playerDataVisible = false;
                    this.toolbar.functionLinkVisible = false;
                    break;
                }
                case MapViewBase.DianFengDuiJue:
                {
                    this.activities.activityVisible = false;
                    this.toolbar.miniMap.content.visible = false;
                    this.toolbar.questTraceVisible = false;
                    this.toolbar.playerDataVisible = false;
                    this.toolbar.functionLinkVisible = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
