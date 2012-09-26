package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.controllers.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class FactionWindowView extends Base implements IView
    {
        private var _factionWindow:IFactionWindow;
        private var _size:int = 12;
        private var _activtiyList:Array;
        private var _mainShowType:String = "";
        private var _mainShowEffic:String = "";
        private var _intoActivity:Object;
        private var _noticeTime:int = 0;
        private var _popupInto:Boolean = false;

        public function FactionWindowView()
        {
            this._activtiyList = [];
            this._intoActivity = {};
            return;
        }// end function

        public function show() : void
        {
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            this.openFactionWindow();
            return;
        }// end function

        private function renderShow() : void
        {
            loadAssets("FactionWindow", this.render, FactionWindowViewLang.LoadAssets);
            return;
        }// end function

        public function render() : void
        {
            this._factionWindow = _view.getAssetsObject("FactionWindow", "FactionWindow") as IFactionWindow;
            _popup.addView(this, this._factionWindow.content);
            _view.center(sign, this._factionWindow.content);
            this._factionWindow.buttonEffect = _view.activities.buttonEffect;
            this._factionWindow.tip = _view.tip.iTip;
            this._factionWindow.drag = _view.drag.iDrag;
            this._factionWindow.activityUrl = URI.activityUrl;
            if (this._activtiyList.length > 0)
            {
                this._factionWindow.activityList = this._activtiyList;
            }
            this._factionWindow.onStartActivity = function (param1:String, param2:Object) : void
            {
                if (param1 != FunctionType.MultiMission && _view.multiMission.inStageWithTip)
                {
                    return;
                }
                switch(param1)
                {
                    case ActivityType.FactionRollCake:
                    {
                        _view.factionRollCake.gotoJiHueiSuo();
                        break;
                    }
                    case ActivityType.FactionBlessing:
                    {
                        _view.factionBlessing.gotoFactionBlessing();
                        break;
                    }
                    case ActivityType.FactionSeal:
                    {
                        if (_ctrl.faction.isCanJoinActivity["result"] == Mod_Faction_Base.YES)
                        {
                            _view.factionSeal.show();
                        }
                        break;
                    }
                    case ActivityType.FactionEat:
                    {
                        if (_ctrl.faction.isCanJoinActivity["result"] == Mod_Faction_Base.YES)
                        {
                            if (param2.state == 2)
                            {
                                _view.factionEat.callEat();
                            }
                            else if (param2.state == 1)
                            {
                                _view.factionEat.gotoEat();
                            }
                        }
                        break;
                    }
                    case ActivityType.BossDaoBaTu:
                    {
                        if (param2.btnInfo == FactionWindowViewLang.ParticipateIn)
                        {
                            _view.worldBossMap.gotoBossTown(param2.TownId);
                        }
                        else if (param2.btnInfo == FactionWindowViewLang.Setting)
                        {
                            _view.factionBossSelect.isSee = false;
                            _view.factionBossSelect.show();
                        }
                        else if (param2.btnInfo == FactionWindowViewLang.See)
                        {
                            _view.factionBossSelect.isSee = true;
                            _view.factionBossSelect.show();
                        }
                        break;
                    }
                    case ActivityType.FactionWar:
                    {
                        if (_ctrl.factionWarMap.signupState == 1 || _ctrl.factionWarMap.signupState == 2)
                        {
                            _view.factionWarSignUp.show();
                        }
                        else
                        {
                            _view.factionTable.show();
                        }
                        break;
                    }
                    case ActivityType.FactionMonster:
                    {
                        if (_ctrl.player.jihuisuoId == 0)
                        {
                            _view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
                        }
                        else
                        {
                            _view.showTip(FactionWindowViewLang.InJiHuiSuo);
                        }
                        break;
                    }
                    case ActivityType.LuckyWheel:
                    {
                        if (_ctrl.player.jihuisuoId == 0)
                        {
                            _view.luckyWheel.gotoJiHuiSuo();
                        }
                        else
                        {
                            _view.luckyWheel.isInJiHuiSuo = true;
                            _view.luckyWheel.enter();
                        }
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            ;
            this._factionWindow.onIsCheck = function (param1:String, param2:Object, param3:Boolean) : void
            {
                switch(param1)
                {
                    case ActivityType.FactionBlessing:
                    {
                        ;
                    }
                    case ActivityType.FactionSeal:
                    {
                        ;
                    }
                    case ActivityType.FactionEat:
                    {
                        ;
                    }
                    case ActivityType.BossDaoBaTu:
                    {
                        ;
                    }
                    default:
                    {
                        ;
                    }
                }
                return;
            }// end function
            ;
            this._factionWindow.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._factionWindow.defaultFction();
            return;
        }// end function

        private function openFactionWindow() : void
        {
            var _loc_1:Object = {};
            _loc_1.isStart = 0;
            var _loc_2:* = ActivityType.FactionLevel;
            if (ActivityType.getOpenLevelToSign(ActivityType.BossDaoBaTu) <= _loc_2)
            {
                this.get_world_boss_list();
            }
            else
            {
                _loc_1.sign = ActivityType.BossDaoBaTu;
                this.getActivityState(_loc_1);
            }
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionBlessing) <= _loc_2)
            {
                _view.factionBlessing.getFactionBlessingCount();
            }
            else
            {
                _loc_1.sign = ActivityType.FactionBlessing;
                this.getActivityState(_loc_1);
            }
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionSeal) <= _loc_2)
            {
                _view.factionSeal.seal_satan_info();
            }
            else
            {
                _loc_1.sign = ActivityType.FactionSeal;
                this.getActivityState(_loc_1);
            }
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionEat) <= _loc_2)
            {
                _view.factionEat.call_eat_info();
            }
            else
            {
                _loc_1.sign = ActivityType.FactionEat;
                this.getActivityState(_loc_1);
            }
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionRollCake) <= _loc_2)
            {
                _view.factionRollCake.faction_roll_cake_remain_times();
            }
            else
            {
                _loc_1.sign = ActivityType.FactionRollCake;
                this.getActivityState(_loc_1);
            }
            if (FunctionType.isOpened(FunctionType.Faction))
            {
                this.factionWarInit();
            }
            else
            {
                _loc_1.sign = ActivityType.FactionWar;
                this.getActivityState(_loc_1);
            }
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionMonster) <= _loc_2)
            {
                this.getFactionMonsterTime();
            }
            else
            {
                _loc_1.sign = ActivityType.FactionMonster;
                this.getActivityState(_loc_1);
            }
            if (ActivityType.getOpenLevelToSign(ActivityType.LuckyWheel) <= _loc_2)
            {
                this.getLuckyWheelData();
            }
            else
            {
                _loc_1.sign = ActivityType.LuckyWheel;
                this.getActivityState(_loc_1);
            }
            return;
        }// end function

        public function getLuckyWheelData() : void
        {
            _data.call(Mod_LuckyWheel_Base.open_lucky_wheel, this.getLuckyWheelDataBack, []);
            return;
        }// end function

        public function getLuckyWheelDataBack() : void
        {
            var _loc_1:Object = {};
            var _loc_2:* = _ctrl.luckyWheel.openInfo;
            _loc_1.btnInfo = FactionWindowViewLang.ParticipateIn;
            _loc_1.explain = FactionWindowViewLang.LuckyWheelTimes;
            _loc_1.sign = ActivityType.LuckyWheel;
            _loc_1.isStart = 1;
            _loc_1.btnType = 1;
            this.getActivityState(_loc_1);
            return;
        }// end function

        public function getFactionMonsterTime() : void
        {
            _data.call(Mod_FactionMonster_Base.get_status, this.getFactionMonsterStatus, []);
            return;
        }// end function

        public function getFactionMonsterStatus() : void
        {
            _view.toolbar.lastState = _ctrl.factionMonster.actityStatus;
            if (_ctrl.factionMonster.actityStatus == Mod_FactionMonster_Base.OPEN)
            {
                _view.townMap.getFactionMonsterInfo();
            }
            var _loc_1:* = _ctrl.factionMonster.openTime;
            var _loc_2:* = this.renderFactionMonsterTime(_loc_1.openTime);
            var _loc_3:* = TimeChange.timeFormat(_loc_2, true, true);
            _loc_2.isShowTimer = false;
            _loc_2.isShowEffic = false;
            if (_loc_2.openType == 0)
            {
                _loc_2.btnInfo = FactionWindowViewLang.WaitStart;
                _loc_2.explain = FactionWindowViewLang.OpenTims + " " + _loc_3.openTime;
            }
            if (_loc_2.openType == 1)
            {
                if (Mod_FactionMonster_Base.CLOSE == _loc_1.state || Mod_FactionMonster_Base.OVER == _loc_1.state)
                {
                    _loc_2.openType = 0;
                    _loc_2.btnInfo = FactionWindowViewLang.ThisOver;
                }
                else
                {
                    _loc_2.isShowTimer = true;
                    _loc_2.isShowEffic = true;
                    _loc_2.btnInfo = FactionWindowViewLang.AddRigntNow;
                }
                _loc_2.explain = FactionWindowViewLang.OpenTims + " " + _loc_3.openTime;
            }
            if (_loc_2.openType == 2)
            {
                _loc_2.btnInfo = FactionWindowViewLang.Over;
                _loc_2.explain = FactionWindowViewLang.TodayOver;
            }
            var _loc_4:Object = {sign:ActivityType.FactionMonster, textTile:FactionWindowViewLang.FactionMonsterName + "<font size=\'12\'>" + Lang.sprintf(FactionWindowViewLang.FactionMonsterTimes, _loc_2.curCount, _loc_2.maxCount) + "</font>", isStart:_loc_2.openType, isShowTimer:_loc_2.isShowTimer, explain:_loc_2.explain, isShowBtnEffic:_loc_2.isShowEffic, btnInfo:_loc_2.btnInfo, isShowActivityEffic:_loc_2.isShowEffic, btnType:1};
            this.getActivityState(_loc_4);
            return;
        }// end function

        private function renderFactionMonsterTime(param1:Array) : Object
        {
            var _loc_6:Object = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_2:* = param1.length;
            var _loc_3:* = this._ctrl.player.serverTime;
            var _loc_4:Object = {startTime:0, endTime:0, openType:0};
            {startTime:0, endTime:0, openType:0}.maxCount = _loc_2;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_6 = param1[_loc_5];
                _loc_7 = _loc_6.startTime;
                _loc_8 = _loc_6.endTime;
                _loc_4.startTime = _loc_7;
                _loc_4.endTime = _loc_8;
                if (_loc_3 < _loc_7)
                {
                    _loc_4.openType = 0;
                    _loc_4.curCount = _loc_5;
                    break;
                }
                if (_loc_3 >= _loc_7 && _loc_3 <= _loc_8)
                {
                    _loc_4.openType = 1;
                    if (_ctrl.factionMonster.actityStatus == Mod_FactionMonster_Base.OVER)
                    {
                        _loc_4.curCount = _loc_5 + 1;
                    }
                    else
                    {
                        _loc_4.curCount = _loc_5;
                    }
                    break;
                }
                if (_loc_5 >= (_loc_2 - 1))
                {
                    if (_loc_3 > _loc_8)
                    {
                        _loc_4.openType = 2;
                        _loc_4.curCount = _loc_2;
                        break;
                    }
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        private function closeFactionWindow() : void
        {
            _view.factionEat.closeEat();
            return;
        }// end function

        public function getActivityState(param1:Object) : void
        {
            this._intoActivity[param1.sign] = param1.sign;
            var _loc_2:* = this.isAllFactivity();
            if (_loc_2)
            {
                this.renderShow();
            }
            if (param1.sign != TownType.BossDaoBaTu)
            {
                param1.name = ActivityType.getNameToSign(param1.sign);
            }
            param1.isOpen = ActivityType.getOpenLevelToSign(param1.sign) <= ActivityType.FactionLevel;
            this.renderActivity(param1);
            return;
        }// end function

        private function isAllFactivity() : Boolean
        {
            var _loc_4:String = null;
            var _loc_1:* = ActivityType.factionWindowList;
            var _loc_2:* = ActivityType.factionWindowList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _loc_1[_loc_3];
                if (this._intoActivity[_loc_4] == null)
                {
                    return false;
                }
                _loc_3++;
            }
            return true;
        }// end function

        private function renderActivity(param1:Object) : void
        {
            if (param1.isOpen)
            {
                if (param1.isStart == 1)
                {
                    if (param1.isShowTimer)
                    {
                        _view.activities.showActivityTitle(ActivityType.FactionAll, param1.name);
                        this._mainShowType = param1.sign;
                    }
                    else
                    {
                        this.hideActivityTimer(param1);
                    }
                    if (param1.isShowActivityEffic)
                    {
                        _view.activities.visibleBtnEffect(ActivityType.FactionAll, param1.name, param1.isShowActivityEffic);
                        this._mainShowEffic = param1.sign;
                    }
                    else
                    {
                        this.visibleBtnEffect(param1);
                    }
                }
                else
                {
                    this.hideActivityTimer(param1);
                    this.visibleBtnEffect(param1);
                }
            }
            if (inStage)
            {
                this._factionWindow.activityList = [param1];
            }
            else
            {
                this.renderActivityList(param1);
            }
            return;
        }// end function

        private function hideActivityTimer(param1:Object) : void
        {
            if (this._mainShowType == param1.sign || this._mainShowType == "")
            {
                _view.activities.hideActivityTimer(ActivityType.FactionAll, param1.name);
            }
            return;
        }// end function

        private function visibleBtnEffect(param1:Object) : void
        {
            if (this._mainShowEffic == param1.sign || this._mainShowEffic == "")
            {
                _view.activities.visibleBtnEffect(ActivityType.FactionAll, param1.name, param1.isShowActivityEffic);
            }
            return;
        }// end function

        private function renderActivityList(param1:Object) : void
        {
            var _loc_4:Object = null;
            var _loc_2:* = this._activtiyList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._activtiyList[_loc_3];
                if (_loc_4.sign == param1.sign)
                {
                    this._activtiyList[_loc_3] = param1;
                    return;
                }
                _loc_3++;
            }
            this._activtiyList.push(param1);
            return;
        }// end function

        public function clear() : void
        {
            this._factionWindow.clear();
            return;
        }// end function

        public function close() : void
        {
            this._intoActivity = {};
            this._activtiyList = [];
            this.closeFactionWindow();
            Helper.gc();
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function get_world_boss_list() : void
        {
            if (FunctionType.isOpened(FunctionType.Faction))
            {
                _data.call(Mod_WorldBoss_Base.get_world_boss_list, this.get_world_boss_list_back, [1]);
            }
            return;
        }// end function

        private function get_world_boss_list_back() : void
        {
            var _loc_1:* = _ctrl.worldBossMap.bossList[BossInfo.BossDaoBaTu];
            if (_loc_1.state == -1)
            {
                return;
            }
            var _loc_2:Object = {};
            _loc_2.sign = ActivityType.BossDaoBaTu;
            _loc_2.name = _loc_1.name;
            _loc_2.textTile = _loc_1.htmlName;
            _loc_2.TownId = _loc_1.mapId;
            _loc_2.explain = _loc_1.infoMsg;
            if (_loc_1.state == 1 || _loc_1.state == 4)
            {
                _loc_2.isStart = 1;
                _loc_2.isShowTimer = true;
                _loc_2.isShowBtnEffic = true;
                _loc_2.isShowActivityEffic = true;
                _loc_2.btnInfo = FactionWindowViewLang.ParticipateIn;
                _loc_2.btnType = 1;
            }
            else if (_loc_1.canSet)
            {
                _loc_2.isStart = 1;
                _loc_2.isShowTimer = false;
                _loc_2.isShowBtnEffic = false;
                _loc_2.isShowActivityEffic = false;
                _loc_2.btnInfo = FactionWindowViewLang.Setting;
                _loc_2.btnType = 1;
            }
            else
            {
                _loc_2.isStart = 1;
                _loc_2.isShowTimer = false;
                _loc_2.isShowBtnEffic = false;
                _loc_2.isShowActivityEffic = false;
                _loc_2.btnInfo = FactionWindowViewLang.See;
                _loc_2.btnType = 1;
            }
            this.getActivityState(_loc_2);
            return;
        }// end function

        private function get factionWar() : FactionWarMapController
        {
            return this._ctrl.factionWarMap;
        }// end function

        public function factionWarInit() : void
        {
            this._data.patch(Mod_FactionWar_Base.notify_status, this.notify_status_back);
            this._data.patch(Mod_FactionWar_Base.notify_open_faction_war, this.notify_open_faction_war_back);
            this._data.patch(Mod_FactionWar_Base.notify_begin_faction_war, this.notify_begin_faction_war_back);
            this._data.patch(Mod_FactionWar_Base.notify_faction_war_gift, this.notify_faction_war_gift_back);
            this._data.call(Mod_FactionWar_Base.get_faction_war_list, null, []);
            this.notify_status_back();
            return;
        }// end function

        private function notify_faction_war_gift_back() : void
        {
            if (this._ctrl.factionWarMap.result == 1)
            {
                this._view.activities.addActivity(ActivityType.FactionWarGift);
                this._view.activities.showActivityTitle(ActivityType.FactionWarGift, FactionWindowViewLang.ClickAssign);
            }
            else
            {
                this._view.activities.removeActivity(ActivityType.FactionWarGift);
            }
            return;
        }// end function

        private function notify_status_back() : void
        {
            var _loc_3:int = 0;
            var _loc_1:Object = {};
            _loc_1.sign = ActivityType.FactionWar;
            _loc_1.explain = FactionWindowViewLang.FactionWarPlayerAdd;
            _loc_1.isStart = 1;
            _loc_1.btnType = 1;
            _loc_1.isShowTimer = false;
            _loc_1.isShowBtnEffic = false;
            _loc_1.isShowActivityEffic = false;
            var _loc_2:* = this.factionWar.intoTime;
            if (_loc_2 > 3)
            {
                this._popupInto = false;
                this._view.addToTimerProcessList("checkFactionWarInToTime", this.checkFactionWarInToTime);
                if (_loc_2 > 60 && this._noticeTime < getTimer())
                {
                    this._noticeTime = getTimer() + 10000;
                    _loc_3 = int(_loc_2 / 60);
                    setTimeout(this._view.worldNotice.showMessage, 3000, Lang.sprintf(FactionWindowViewLang.FactionWarTime, _loc_3));
                }
            }
            if (this.factionWar.signupState == 4)
            {
                _loc_1.btnInfo = FactionWindowViewLang.WarReady;
                _loc_1.isShowTimer = true;
                _loc_1.isShowBtnEffic = true;
                _loc_1.isShowActivityEffic = true;
            }
            else if (this.factionWar.signupState == 1)
            {
                _loc_1.btnInfo = FactionWindowViewLang.SignUp;
            }
            else
            {
                _loc_1.btnInfo = FactionWindowViewLang.See;
            }
            this.getActivityState(_loc_1);
            this._view.factionTable.update();
            return;
        }// end function

        private function notify_open_faction_war_back() : void
        {
            this._data.call(Mod_FactionWar_Base.get_my_faction_war, this.notify_status_back, []);
            return;
        }// end function

        private function checkFactionWarInToTime() : void
        {
            var _loc_1:* = getTimer();
            if (_loc_1 < 5000)
            {
                return;
            }
            _loc_1 = this.factionWar.intoTime;
            if (_loc_1 > 3 && _loc_1 < 30 && this.canPopupFactionWarAutoInto)
            {
                this._popupInto = true;
                this._view.alert.showYesNoMsg(Lang.sprintf(FactionWindowViewLang.AskFactionWarInto, _loc_1), FactionWindowViewLang.InTo, FactionWindowViewLang.Cancel, this.intoSelect);
            }
            if (_loc_1 < 3)
            {
                this._view.removeFromTimerProcessList("checkFactionWarInToTime");
                if (this._popupInto == true)
                {
                    this._popupInto = false;
                    this._view.factionWarMap.gotoFactionWar();
                    this._view.alert.hide();
                }
            }
            else if (this._popupInto == true)
            {
                this._view.alert.iAlert.yesLabel = FactionWindowViewLang.InTo;
                this._view.alert.iAlert.updateContent(Lang.sprintf(FactionWindowViewLang.AskFactionWarInto, _loc_1));
            }
            return;
        }// end function

        private function intoSelect(param1:int) : void
        {
            var _loc_2:Array = null;
            var _loc_3:IView = null;
            if (param1 == AlertButtonType.Yes && this._popupInto == true)
            {
                this._popup.closeAll();
                _loc_2 = [_view.takeBibleRoad, _view.serverWarCup, _view.missionPractice, _view.heroPractice, _view.tower, _view.getPeach, _view.zodiac];
                for each (_loc_3 in _loc_2)
                {
                    
                    if (_loc_3.inStage)
                    {
                        _loc_3.close();
                    }
                }
                this._view.factionWarMap.gotoFactionWar();
            }
            this._popupInto = false;
            this._view.removeFromTimerProcessList("checkFactionWarInToTime");
            return;
        }// end function

        private function get canPopupFactionWarAutoInto() : Boolean
        {
            if (this._popupInto == true)
            {
                return false;
            }
            if (this._view.factionWarMap.inStage == true)
            {
                return false;
            }
            if (this._view.inWar == true)
            {
                return false;
            }
            if (this._view.drama.inStage == true)
            {
                return false;
            }
            return true;
        }// end function

        private function notify_begin_faction_war_back() : void
        {
            var _loc_1:Object = {};
            _loc_1.sign = ActivityType.FactionWar;
            _loc_1.explain = FactionWindowViewLang.FactionWarPlayerAdd;
            _loc_1.isStart = 1;
            _loc_1.btnType = 1;
            _loc_1.isShowTimer = false;
            _loc_1.isShowBtnEffic = false;
            _loc_1.isShowActivityEffic = false;
            _loc_1.btnInfo = FactionWindowViewLang.See;
            this.getActivityState(_loc_1);
            this._view.factionWarMap.updateWarTipMsg();
            this._view.factionTable.update();
            return;
        }// end function

    }
}
