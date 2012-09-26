package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class GameHelperView extends Base implements IView
    {
        private var _gameHelper:IGameHelper;
        private var _intSuperSportTime:int;
        private var _intTakeBibleTime:int;
        private var _blnInGetAward:Boolean = false;
        private var _aryBoxInfo:Array;

        public function GameHelperView()
        {
            this._aryBoxInfo = [];
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
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
            return;
        }// end function

        public function clear() : void
        {
            this._gameHelper.clear();
            this._intSuperSportTime = 0;
            this._intTakeBibleTime = 0;
            this._view.removeFromTimerProcessList(this.sign);
            this.dialog.hide();
            return;
        }// end function

        public function updateGameAssistant() : void
        {
            if (this.inStage)
            {
                this._gameHelper.level = this._ctrl.player.level;
                this.get_game_assistant_info();
            }
            return;
        }// end function

        public function initBoxInfo() : void
        {
            return;
        }// end function

        public function completeNumberCallBack() : void
        {
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._gameHelper.content);
            _view.center(sign, this._gameHelper.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._gameHelper == null)
            {
                this._gameHelper = _view.getAssetsObject("GameHelper", "GameHelper") as IGameHelper;
            }
            this.init();
            this.getGameAssistantInfoCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._blnInGetAward = false;
            this._gameHelper.tip = this._view.tip.iTip;
            this._gameHelper.drag = this._view.drag.iDrag;
            this._gameHelper.onCloseBtn = this.close;
            this._gameHelper.onBuyPowerBtn = this.buyPower;
            this._gameHelper.onCampSalaryBtn = this.get_player_camp_salary;
            this._gameHelper.onDailyQuestBtn = this.showDailyQuest;
            this._gameHelper.onFateFreeBtn = this.gotoFateLodge;
            this._gameHelper.onFateIngotBtn = this.gotoFateLodge;
            this._gameHelper.onGetPeachBtn = this.showGetPeach;
            this._gameHelper.onRuneBtn = this.showRune;
            this._gameHelper.onSportBtn = this.showSport;
            this._gameHelper.onFactionBlessingBtn = this.gotoFactionBlessing;
            this._gameHelper.onStroyPlayBtn = this.storyPlay;
            this._gameHelper.onTakeBibleBtn = this.showTakeBibleRoad;
            this._gameHelper.onSendFlowerBtn = this.showFriendList;
            this._gameHelper.onFreeSealTrainingBtn = this.showSealSoul;
            this._gameHelper.onCoinTreeBtn = this.showFarm;
            this._gameHelper.onRollCakeBtn = this.showRollCake;
            this._gameHelper.onWorshipMarsBtn = this.showWorshipMars;
            this._gameHelper.onPetAnimalBtn = this.showPetAnimal;
            this._gameHelper.onBackBtn = this.backTimes;
            this._gameHelper.onAchievementBtn = this.showAchievement;
            this._gameHelper.onMissionBtn = this.showChooseMission;
            this._gameHelper.onSealStoneBtn = this.showSealStone;
            this._gameHelper.onGetBoxAward = this.get_award;
            this._gameHelper.buttonEffect = this._view.activities.buttonEffectObj();
            this._gameHelper.power = this._ctrl.player.power;
            this._gameHelper.level = this._ctrl.player.level;
            this._gameHelper.url = URI.gameHelperIconUrl;
            this._gameHelper.render();
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

        private function get_player_camp_salary() : void
        {
            this._view.activities.get_player_camp_salary();
            return;
        }// end function

        private function showRune() : void
        {
            if (!_view.vipEnabled)
            {
                return;
            }
            this._view.rune.show();
            return;
        }// end function

        private function showDailyQuest() : void
        {
            this._view.dailyQuest.show();
            return;
        }// end function

        private function gotoFactionBlessing() : void
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

        private function showSport() : void
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

        private function gotoFateLodge() : void
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

        private function showTakeBibleRoad() : void
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

        private function showFriendList() : void
        {
            if (FunctionType.isOpened(FunctionType.SendFlower))
            {
                this._view.friendList.show();
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

        private function showFarm() : void
        {
            if (FunctionType.isOpened(FunctionType.CoinTree))
            {
                this._view.farm.show();
            }
            return;
        }// end function

        private function showAchievement() : void
        {
            this._view.achievement.show();
            return;
        }// end function

        private function showRollCake() : void
        {
            if (FunctionType.isOpened(FunctionType.RollCake))
            {
                this._view.rollCake.show();
            }
            return;
        }// end function

        private function showWorshipMars() : void
        {
            if (FunctionType.isOpened(FunctionType.WorshipMars))
            {
                this._view.worshipMars.show();
            }
            return;
        }// end function

        private function showPetAnimal() : void
        {
            if (FunctionType.isOpened(FunctionType.PetAnimal))
            {
                this._view.pet.show();
            }
            return;
        }// end function

        private function showChooseMission() : void
        {
            if (FunctionType.isOpened(FunctionType.MissionPractice))
            {
                this._view.chooseMission.showTownMission = TownType.getMaxTownId();
            }
            return;
        }// end function

        private function showGetPeach() : void
        {
            if (FunctionType.isOpened(FunctionType.GetPeach))
            {
                this._view.getPeach.show();
            }
            return;
        }// end function

        private function showSealStone() : void
        {
            if (FunctionType.isOpened(FunctionType.SealSoul))
            {
                this._view.sealStone.getDayStone();
            }
            return;
        }// end function

        private function storyPlay() : void
        {
            _view.dramaPlayBack.show();
            return;
        }// end function

        private function timer() : void
        {
            if (this._intSuperSportTime > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this._intSuperSportTime - 1;
                _loc_1._intSuperSportTime = _loc_2;
                this._gameHelper.updateSuperSportTime(this._intSuperSportTime);
            }
            if (this._intTakeBibleTime > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this._intTakeBibleTime - 1;
                _loc_1._intTakeBibleTime = _loc_2;
                this._gameHelper.updateTakeBibleTime(this._intTakeBibleTime);
            }
            if (this._intSuperSportTime < 0 && this._intTakeBibleTime < 0)
            {
                this._view.removeFromTimerProcessList(this.sign);
            }
            return;
        }// end function

        private function backTimes(param1:int) : void
        {
            var intCookie:int;
            var intType:* = param1;
            var strMessage:String;
            var ingot:int;
            switch(intType)
            {
                case 1:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.DailyQuestBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackDailyQuest;
                    break;
                }
                case 2:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.FactionBlessingBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackFactionBlessing;
                    break;
                }
                case 3:
                {
                    ingot;
                    strMessage = Lang.sprintf(GameHelperViewLang.CampSalaryBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackCampSalary;
                    break;
                }
                case 4:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.FreeSealTrainingBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackFreeSealTraining;
                    break;
                }
                case 5:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.TakeBibleBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackTakeBible;
                    break;
                }
                case 6:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.FateFreeBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackFateFree;
                    break;
                }
                case 7:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.SendFlowerBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackSendFlower;
                    break;
                }
                case 8:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.CoinTreeBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackCoinTree;
                    break;
                }
                case 9:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.RollCakeBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackRollCake;
                    break;
                }
                case 10:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.WorshipMarsBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackWorshipMars;
                    break;
                }
                case 11:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.FateIngotBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackFateIngot;
                    break;
                }
                case 12:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.GetPeachBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackGetPeach;
                    break;
                }
                case 13:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.SealStoneBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
                    intCookie = ConsumeAlertSetType.BackSealStone;
                    break;
                }
                case 14:
                {
                    strMessage = Lang.sprintf(GameHelperViewLang.PetAnimalBackTimes, HtmlText.yellow(ingot + GameHelperViewLang.Ingto));
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
                _view.showTip(GameHelperViewLang.NoIngot);
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
                this.dialog.yesLabel = GameHelperViewLang.DialogYes;
                this.dialog.noLabel = GameHelperViewLang.DialogNo;
                this.dialog.hasCheckbox = true;
                this.dialog.show(strMessage, AlertButtonType.Yes | AlertButtonType.No, callBack);
            }
            else
            {
                this.back_times(intType);
            }
            return;
        }// end function

        private function loadData() : void
        {
            _data.call(Mod_Player_Base.get_game_assistant_info, this.loadDataCallBack, []);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("GameHelper", this.render, GameHelperViewLang.LoadInfo);
            return;
        }// end function

        private function info() : void
        {
            if (!FunctionType.isOpened(FunctionType.DailyBox))
            {
                return;
            }
            return;
        }// end function

        private function infoCallBack() : void
        {
            if (!this.inStage)
            {
                return;
            }
            this._aryBoxInfo = this._ctrl.assistant.getBoxInfo;
            this._gameHelper.renderBox(this._aryBoxInfo);
            this.initBoxInfoCallBack();
            this._blnInGetAward = false;
            return;
        }// end function

        public function loader_first_info() : void
        {
            _data.call(Mod_Player_Base.get_game_assistant_info, new Function(), [], false);
            return;
        }// end function

        private function get_game_assistant_info() : void
        {
            this._gameHelper.power = this._ctrl.player.power;
            _data.call(Mod_Player_Base.get_game_assistant_info, this.getGameAssistantInfoCallBack, []);
            return;
        }// end function

        private function getGameAssistantInfoCallBack() : void
        {
            var _loc_1:* = this._ctrl.player.getGameAssistantInfo;
            this._gameHelper.renderGameHelper(_loc_1);
            this._intSuperSportTime = _loc_1["super_sports_cd_time"];
            this._intTakeBibleTime = _loc_1["takebible_arrival_remain"];
            if (this._intSuperSportTime > 0 || this._intTakeBibleTime > 0)
            {
                this._view.addToTimerProcessList(this.sign, this.timer);
            }
            this.info();
            return;
        }// end function

        private function back_times(param1:int) : void
        {
            _data.call(Mod_Player_Base.back_times, this.backTimesCallBack, [param1]);
            return;
        }// end function

        private function backTimesCallBack() : void
        {
            var _loc_1:* = this._ctrl.player.backTimesResult;
            if (_loc_1["result"] == Mod_Player_Base.SUCCEED)
            {
                this.updateGameAssistant();
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

        private function get_award(param1:int) : void
        {
            var callBack:Function;
            var intBoxId:* = param1;
            callBack = function () : void
            {
                getAwardCallBack(intBoxId);
                return;
            }// end function
            ;
            if (this._blnInGetAward)
            {
                return;
            }
            this._blnInGetAward = true;
            _data.call(Mod_Assistant_Base.get_award, callBack, [intBoxId]);
            return;
        }// end function

        private function getAwardCallBack(param1:int) : void
        {
            var _loc_2:* = this._ctrl.assistant.getAward;
            if (_loc_2["result"] == Mod_Assistant_Base.SUCCESS)
            {
                this._gameHelper.renderGetBoxAwardSuccess(param1);
                this.info();
            }
            else
            {
                this._view.showTip(this.message(_loc_2["result"]));
                this._blnInGetAward = false;
            }
            return;
        }// end function

        private function initBoxInfoCallBack() : void
        {
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Player_Base.SUCCEED:
                {
                    _loc_2 = GameHelperViewLang.Succeed;
                    break;
                }
                case Mod_Player_Base.NO_INGOT:
                {
                    _loc_2 = GameHelperViewLang.NoIngot;
                    break;
                }
                case Mod_Player_Base.CAN_NOT_BACK_TIMES:
                {
                    _loc_2 = GameHelperViewLang.CanNotBackTimes;
                    break;
                }
                case Mod_Assistant_Base.NOT_ENOUGH_NUM:
                {
                    _loc_2 = GameHelperViewLang.NotEnoughNum;
                    break;
                }
                case Mod_Assistant_Base.NOT_ENOUGH_VIP:
                {
                    _loc_2 = GameHelperViewLang.NotEnoughVip;
                    break;
                }
                case Mod_Assistant_Base.PACK_FULL:
                {
                    _loc_2 = GameHelperViewLang.PackFull;
                    break;
                }
                case Mod_Assistant_Base.HAVE_DONE:
                {
                    _loc_2 = GameHelperViewLang.HaveDone;
                    break;
                }
                default:
                {
                    _loc_2 = GameHelperViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
