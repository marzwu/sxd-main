package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class LivenessView extends Base implements IView
    {
        private var _liveness:ILiveness;
        private var _isCalled:Boolean;
        private var _intSuperSportTime:int;
        private var _intTakeBibleTime:int;
        private var _factionId:int;
        private var isCalled:Boolean;
        private var _isChangeNum:Boolean;
        private var _changeData:Object;

        public function LivenessView()
        {
            this._changeData = {1:1, 2:1, 3:1, 4:6, 5:11, 6:2, 7:10, 8:3, 9:13, 10:4, 11:7, 12:5, 13:1, 14:1, 15:8, 16:14, 17:12, 18:9, 19:1, 20:1, 21:1, 22:1, 23:1, 24:1, 25:1, 26:1, 27:1, 28:1};
            return;
        }// end function

        public function show() : void
        {
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            _view.cancelCenter(sign);
            return;
        }// end function

        public function clear() : void
        {
            this._isChangeNum = false;
            this._isCalled = false;
            this._liveness.clear();
            this._view.removeFromTimerProcessList(this.sign);
            return;
        }// end function

        private function loadData() : void
        {
            _data.call(Mod_Player_Base.get_game_assistant_info, this.loadDataCallBack, []);
            return;
        }// end function

        private function get_liveness_info() : void
        {
            _data.call(Mod_Player_Base.get_game_assistant_info, this.getLivenessInfoCallBack, []);
            return;
        }// end function

        public function getBoxInfo() : void
        {
            if (this._isCalled == false)
            {
                this._isCalled = true;
                _data.call(Mod_Assistant_Base.info, this.getBoxInfoCallBack, []);
            }
            return;
        }// end function

        private function back_times(param1:int) : void
        {
            _data.call(Mod_Player_Base.back_times, this.backTimesCallBack, [param1]);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("Liveness", this.render, LivenessViewLang.Open);
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        private function getHeroesStatus() : void
        {
            _data.call(Mod_HeroesWar_Base.get_heroes_open_time, this.getHeroesStatusCallBack, []);
            return;
        }// end function

        private function getWorldBossStatus() : void
        {
            _data.call(Mod_WorldBoss_Base.get_world_boss_list, this.getWorldBossStatusCallBack, [0]);
            return;
        }// end function

        private function getTopWarStatus() : void
        {
            _data.call(Mod_TopWar_Base.get_top_war_state, this.getTopWarStatusCallBack, []);
            return;
        }// end function

        private function render() : void
        {
            if (this._liveness == null)
            {
                this._liveness = _view.getAssetsObject("Liveness", "Liveness") as ILiveness;
            }
            this._liveness.tip = _view.tip.iTip;
            this._liveness.drag = _view.drag.iDrag;
            this._liveness.onClose = this.close;
            this._liveness.vipLevel = _ctrl.player.vipLevel;
            this._liveness.playerLevel = _ctrl.player.level;
            this._liveness.power = _ctrl.player.power;
            this._liveness.factionId = this._factionId;
            this._liveness.factionLevel = ActivityType.FactionLevel;
            this._liveness.onUpdateInfo = this.updateInfo;
            this._liveness.buttonEffect = this._view.activities.buttonEffectObj();
            this._liveness.onShowBtnEffect = this.showBtnEffect;
            this._liveness.url = URI.gameHelperIconUrl;
            this.getBoxInfo();
            this.getHeroesStatus();
            this.getWorldBossStatus();
            this.getTopWarStatus();
            this._liveness.monsterStatus = _ctrl.factionMonster.actityStatus == Mod_FactionMonster_Base.OPEN;
            this._liveness.onMissionBtn = this.missionBtn;
            this._liveness.onBuyPower = this.buyPower;
            this._liveness.onRune = this.rune;
            this._liveness.onFateFree = this.gotoFate;
            this._liveness.onFateIngot = this.gotoFate;
            this._liveness.onFactionBlessing = this.factionBlessing;
            this._liveness.onWorship = this.worShip;
            this._liveness.onCampSalary = this.campSalary;
            this._liveness.onSealStone = this.sealStone;
            this._liveness.onShowSealSoul = this.showSealSoul;
            this._liveness.onSendFlower = this.showFriendList;
            this._liveness.onTakeBible = this.takeBible;
            this._liveness.onTakeBibleFriend = this.takeBible;
            this._liveness.onFarm = this.farm;
            this._liveness.onPetAnimal = this.petAnimal;
            this._liveness.onGetPeach = this.peach;
            this._liveness.onRollCake = this.rollCake;
            this._liveness.onSuperSport = this.superSport;
            this._liveness.onMultimission = this.multimission;
            this._liveness.onFactionSeal = this.factionSeal;
            this._liveness.onWorldBoss = this.worldBoss;
            this._liveness.onCampWar = this.campWar;
            this._liveness.onTopWar = this.topWar;
            this._liveness.onFactionRollCake = this.factionRollCake;
            this._liveness.onRosefinch = this.roseFinch;
            this._liveness.onFactionMonster = this.factionMonster;
            this._liveness.onGetBack = this.getBack;
            this._liveness.onGetAward = this.getAward;
            this._liveness.render();
            var _loc_1:* = _ctrl.player.getGameAssistantInfo;
            this.checkTime(_loc_1);
            this._liveness.infoData = this.addBackId(_loc_1);
            _popup.addView(this, this._liveness.content);
            _view.center(sign, this._liveness.content);
            return;
        }// end function

        private function checkTime(param1:Object) : void
        {
            this._intSuperSportTime = param1["super_sports_cd_time"];
            this._intTakeBibleTime = param1["takebible_arrival_remain"];
            if (this._intSuperSportTime > 0 || this._intTakeBibleTime > 0)
            {
                _view.addToTimerProcessList(sign, this.timer);
            }
            return;
        }// end function

        private function timer() : void
        {
            if (this._intSuperSportTime > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this._intSuperSportTime - 1;
                _loc_1._intSuperSportTime = _loc_2;
                this._liveness.updateSuperSportTime(this._intSuperSportTime);
            }
            if (this._intTakeBibleTime > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this._intTakeBibleTime - 1;
                _loc_1._intTakeBibleTime = _loc_2;
                this._liveness.updateTakeBibleTime(this._intTakeBibleTime);
            }
            if (this._intSuperSportTime < 0 && this._intTakeBibleTime < 0)
            {
                _view.removeFromTimerProcessList(sign);
            }
            return;
        }// end function

        public function updateInfo() : void
        {
            if (this.inStage)
            {
                this._liveness.vipLevel = this._ctrl.player.vipLevel;
                this._liveness.power = _ctrl.player.power;
                this.get_liveness_info();
                this.getBoxInfo();
            }
            return;
        }// end function

        private function backTimesCallBack() : void
        {
            var _loc_1:* = this._ctrl.player.backTimesResult;
            if (_loc_1["result"] == Mod_Player_Base.SUCCEED)
            {
                this.updateInfo();
                if (_loc_1["back_times_type"] == 1)
                {
                    this._view.activities.addActivity(FunctionType.DailyQuest);
                }
                if (_loc_1["back_times_type"] == 9)
                {
                    this._view.activities.addActivity(FunctionType.RollCake);
                }
                if (_loc_1["back_times_type"] == 10)
                {
                    this._view.activities.addActivity(FunctionType.WorshipMars);
                }
                if (_loc_1["back_times_type"] == 12)
                {
                    this._view.activities.addActivity(FunctionType.GetPeach);
                }
                if (_loc_1["back_times_type"] == 13)
                {
                    this._view.activities.addActivity(FunctionType.SealSoul);
                }
                if (_loc_1["back_times_type"] == 14)
                {
                    this._view.activities.addActivity(FunctionType.PetAnimal);
                }
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            return;
        }// end function

        private function getLivenessInfoCallBack() : void
        {
            var _loc_1:Object = null;
            if (inStage)
            {
                _loc_1 = _ctrl.player.getGameAssistantInfo;
                this._liveness.infoData = this.addBackId(_loc_1);
                this.checkTime(_loc_1);
            }
            return;
        }// end function

        private function getBoxInfoCallBack() : void
        {
            var _loc_1:* = _ctrl.assistant.boxInfo;
            var _loc_2:* = _ctrl.assistant.liveNum;
            if (inStage)
            {
                this._liveness.liveNum = _loc_2;
                this._liveness.awardInfo = _loc_1;
                this._liveness.renderGetAward(true);
            }
            this._isCalled = false;
            this.initBoxInfoCallBack();
            return;
        }// end function

        private function getAwardCallBack() : void
        {
            var _loc_1:Object = null;
            if (inStage)
            {
                _loc_1 = _ctrl.assistant.getAward;
                if (_loc_1.result == Mod_Assistant_Base.SUCCESS)
                {
                    this.getBoxInfo();
                }
                else
                {
                    this._liveness.renderGetAward(false);
                    this.showTip(_loc_1.result);
                }
                this.isCalled = false;
            }
            return;
        }// end function

        private function getHeroesStatusCallBack() : void
        {
            var _loc_1:int = 0;
            if (inStage)
            {
                _loc_1 = _ctrl.heroesWar.getIsOpenHeroesWar();
                this._liveness.heroesWarStatus = _loc_1 == 1;
                this.updateInfo();
            }
            return;
        }// end function

        private function getWorldBossStatusCallBack() : void
        {
            var _loc_1:Array = null;
            var _loc_2:BossInfo = null;
            if (inStage)
            {
                _loc_1 = _ctrl.worldBossMap.bossList;
                for each (_loc_2 in _loc_1)
                {
                    
                    if (_loc_2.state == 1 || _loc_2.state == 4)
                    {
                        this._liveness.worldBossStatus = true;
                        break;
                    }
                }
                this._liveness.worldBossStatus = false;
                this.updateInfo();
            }
            return;
        }// end function

        private function getTopWarStatusCallBack() : void
        {
            var _loc_1:int = 0;
            if (inStage)
            {
                _loc_1 = _ctrl.topWar.getTopWarState();
                this._liveness.topWarStatus = _loc_1 == Mod_TopWar_Base.OPEN;
                this.updateInfo();
            }
            return;
        }// end function

        public function set factionId(param1:int) : void
        {
            this._factionId = param1;
            if (inStage)
            {
                this._liveness.factionId = param1;
            }
            return;
        }// end function

        private function missionBtn() : void
        {
            if (FunctionType.isOpened(FunctionType.MissionPractice))
            {
                this._view.chooseMission.showTownMission = TownType.getMaxTownId();
            }
            return;
        }// end function

        private function buyPower() : void
        {
            if (!_view.vipEnabled)
            {
                return;
            }
            var _loc_1:* = this._ctrl.player.getGameAssistantInfo;
            if (!_view.ingotEnough(_loc_1["buy_power_ingot"]))
            {
                return;
            }
            this._view.toolbar.buy_power();
            return;
        }// end function

        private function rune() : void
        {
            if (!_view.vipEnabled)
            {
                return;
            }
            this._view.rune.show();
            return;
        }// end function

        private function gotoFate() : void
        {
            if (this._view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (this._view.heroPractice.inStageWithTip)
            {
                return;
            }
            this._view.lodge.show();
            return;
        }// end function

        private function factionBlessing() : void
        {
            if (this._view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (this._view.heroPractice.inStageWithTip)
            {
                return;
            }
            this._view.factionBlessing.gotoFactionBlessing();
            return;
        }// end function

        private function worShip() : void
        {
            this._view.worshipMars.show();
            return;
        }// end function

        private function campSalary() : void
        {
            this._view.activities.get_player_camp_salary();
            return;
        }// end function

        private function sealStone() : void
        {
            if (FunctionType.isOpened(FunctionType.SealSoul))
            {
                this._view.sealStone.getDayStone();
            }
            return;
        }// end function

        private function showSealSoul() : void
        {
            if (FunctionType.isOpened(FunctionType.SealSoul))
            {
                this._view.sealSoul.show();
            }
            return;
        }// end function

        private function showFriendList() : void
        {
            if (FunctionType.isOpened(FunctionType.SendFlower))
            {
                this._view.friendList.show();
            }
            return;
        }// end function

        private function takeBible() : void
        {
            if (this._view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (this._view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (this._view.tower.inStageWithTip)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.TakeBible))
            {
                this._view.takeBibleRoad.show();
            }
            return;
        }// end function

        private function farm() : void
        {
            if (FunctionType.isOpened(FunctionType.CoinTree))
            {
                this._view.farm.show();
            }
            return;
        }// end function

        private function petAnimal() : void
        {
            if (FunctionType.isOpened(FunctionType.PetAnimal))
            {
                this._view.pet.show();
            }
            return;
        }// end function

        private function peach() : void
        {
            if (FunctionType.isOpened(FunctionType.GetPeach))
            {
                this._view.getPeach.show();
            }
            return;
        }// end function

        private function rollCake() : void
        {
            if (FunctionType.isOpened(FunctionType.RollCake))
            {
                this._view.rollCake.show();
            }
            return;
        }// end function

        private function superSport() : void
        {
            if (this._view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (this._view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (this._view.tower.inStageWithTip)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.SuperSport))
            {
                this._view.superSport.show();
            }
            return;
        }// end function

        private function multimission() : void
        {
            if (FunctionType.isOpened(FunctionType.MultiMission))
            {
                this._view.multiMission.show();
            }
            return;
        }// end function

        private function factionSeal() : void
        {
            if (FunctionType.isOpened(FunctionType.Faction))
            {
                this._view.factionSeal.show();
            }
            return;
        }// end function

        private function worldBoss() : void
        {
            this._view.activityWindow.show();
            return;
        }// end function

        private function campWar() : void
        {
            this._view.activityWindow.show();
            return;
        }// end function

        private function topWar() : void
        {
            this._view.activityWindow.show();
            return;
        }// end function

        private function factionRollCake() : void
        {
            var _loc_1:String = null;
            if (FunctionType.isOpened(FunctionType.Faction))
            {
                _loc_1 = TownType.getSign(_ctrl.player.mapId);
                if (_loc_1 != TownType.JiHuiSuo)
                {
                    _view.factionRollCake.gotoJiHueiSuo();
                }
                else
                {
                    _view.factionRollCake.show();
                }
            }
            return;
        }// end function

        private function roseFinch() : void
        {
            var _loc_1:* = TownType.getTownNPCIdByFunc(TownType.getId(TownType.JiHuiSuo), NPCType.FactionMangerNPC);
            _view.townMap.moveJiHuiSuoNpc(_loc_1);
            return;
        }// end function

        private function factionMonster() : void
        {
            if (_ctrl.player.jihuisuoId == 0)
            {
                _view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
            }
            return;
        }// end function

        private function getAward(param1:int) : void
        {
            if (this.isCalled)
            {
                return;
            }
            this.isCalled = true;
            _data.call(Mod_Assistant_Base.get_award, this.getAwardCallBack, [param1]);
            return;
        }// end function

        private function getBack(param1:int) : void
        {
            var intCookie:int;
            var intType:* = param1;
            var strMessage:String;
            var ingot:int;
            switch(intType)
            {
                case 1:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.DailyQuestBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackDailyQuest;
                    break;
                }
                case 2:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.FactionBlessingBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackFactionBlessing;
                    break;
                }
                case 3:
                {
                    ingot;
                    strMessage = Lang.sprintf(LivenessViewLang.CampSalaryBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackCampSalary;
                    break;
                }
                case 4:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.FreeSealTrainingBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackFreeSealTraining;
                    break;
                }
                case 5:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.TakeBibleBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackTakeBible;
                    break;
                }
                case 6:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.FateFreeBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackFateFree;
                    break;
                }
                case 7:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.SendFlowerBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackSendFlower;
                    break;
                }
                case 8:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.CoinTreeBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackCoinTree;
                    break;
                }
                case 9:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.RollCakeBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackRollCake;
                    break;
                }
                case 10:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.WorshipMarsBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackWorshipMars;
                    break;
                }
                case 11:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.FateIngotBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackFateIngot;
                    break;
                }
                case 12:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.GetPeachBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackGetPeach;
                    break;
                }
                case 13:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.SealStoneBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackSealStone;
                    break;
                }
                case 14:
                {
                    strMessage = Lang.sprintf(LivenessViewLang.PetAnimalBackTimes, HtmlText.yellow(ingot + LivenessViewLang.Ingot));
                    intCookie = ConsumeAlertSetType.BackPetAnimal;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (ingot > _ctrl.player.ingot)
            {
                _view.showTip(LivenessViewLang.NoIngot);
                return;
            }
            if (!_view.consumeAlertSetting.isAlert(intCookie))
            {
                var callBack:* = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    back_times(intType);
                }
                if (dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(intCookie, true);
                }
                return;
            }// end function
            ;
                this.dialog.yesLabel = LivenessViewLang.DialogYes;
                this.dialog.noLabel = LivenessViewLang.DialogNo;
                this.dialog.hasCheckbox = true;
                this.dialog.show(strMessage, AlertButtonType.Yes | AlertButtonType.No, callBack);
            }
            else
            {
                this.back_times(intType);
            }
            return;
        }// end function

        private function showBtnEffect(param1:Boolean) : void
        {
            if (param1)
            {
                _view.activities.showActivityTitle(ActivityType.GameHelper, LivenessViewLang.CanGetAward);
                _view.activities.visibleBtnEffect(ActivityType.GameHelper, ActivityType.GameHelper, true);
            }
            else
            {
                _view.activities.hideActivityTimer(ActivityType.GameHelper, LivenessViewLang.CanGetAward);
                _view.activities.visibleBtnEffect(ActivityType.GameHelper, ActivityType.GameHelper, false);
            }
            return;
        }// end function

        private function initBoxInfoCallBack() : void
        {
            var _loc_8:Object = null;
            var _loc_1:* = _ctrl.assistant.boxInfo;
            var _loc_2:* = _ctrl.assistant.liveNum;
            var _loc_3:* = _loc_1.length;
            var _loc_4:* = _ctrl.player.vipLevel;
            var _loc_5:int = -1;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_3)
            {
                
                _loc_8 = _loc_1[_loc_6];
                if (_loc_8.type == 0 && _loc_2 >= _loc_8.targetNum)
                {
                    _loc_5 = _loc_6;
                    break;
                }
                _loc_6++;
            }
            var _loc_7:* = _loc_4 >= 10 ? (9) : (_loc_4 >= 6 ? (6) : (3));
            if (_loc_5 != -1 && _loc_5 < _loc_7)
            {
                this.showBtnEffect(true);
            }
            else
            {
                this.showBtnEffect(false);
            }
            this.changeNum();
            return;
        }// end function

        public function set isChangeNum(param1:Boolean) : void
        {
            this._isChangeNum = param1;
            return;
        }// end function

        private function changeNum() : void
        {
            var _loc_1:int = 0;
            var _loc_2:String = null;
            if (this._isChangeNum == true)
            {
                _loc_1 = _ctrl.assistant.liveNum;
                _loc_2 = LivenessViewLang.ChangeNum + _loc_1;
                _view.chat.receive(_loc_2, true);
                this._isChangeNum = false;
            }
            return;
        }// end function

        private function addBackId(param1:Object) : Object
        {
            var _loc_6:Object = null;
            var _loc_2:* = param1.active_degree_list;
            var _loc_3:* = _loc_2.length;
            var _loc_4:Array = [];
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = _loc_2[_loc_5];
                _loc_6.backId = this.changeType(_loc_6.active_degree_type);
                _loc_4.push(_loc_6);
                _loc_5++;
            }
            param1.active_degree_list = _loc_4;
            return param1;
        }// end function

        private function changeType(param1:int) : int
        {
            return this._changeData[param1];
        }// end function

        private function showTip(param1:int) : void
        {
            var _loc_2:* = this.message(param1);
            _view.showTip(_loc_2);
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Player_Base.ALREADY_GET:
                {
                    _loc_2 = LivenessViewLang.AlreadyGet;
                    break;
                }
                case Mod_Assistant_Base.NOT_ENOUGH_VIP:
                {
                    _loc_2 = LivenessViewLang.NotEnoughVIP;
                    break;
                }
                case Mod_Assistant_Base.NOT_ENOUGH_NUM:
                {
                    _loc_2 = LivenessViewLang.NotEnoughtNum;
                    break;
                }
                case Mod_Assistant_Base.PACK_FULL:
                {
                    _loc_2 = LivenessViewLang.PackFull;
                    break;
                }
                case Mod_Assistant_Base.HAVE_DONE:
                {
                    _loc_2 = LivenessViewLang.AlreadyGet;
                    break;
                }
                case Mod_Player_Base.CAN_NOT_BACK_TIMES:
                {
                    _loc_2 = LivenessViewLang.NotBackTime;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
