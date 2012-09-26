package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.controllers.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class ActivityWindowView extends Base implements IView
    {
        private var _activityWindow:IActivityWindow;
        private var _size:int = 12;
        private var _activtiyList:Array;
        private var _mainShowType:String = "";
        private var _getFactionTime:int = 0;

        public function ActivityWindowView()
        {
            this._activtiyList = [];
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
            loadAssets("ActivityWindow", this.render, ActivityWindowViewLang.AddActivityWindow);
            return;
        }// end function

        public function render() : void
        {
            this._activityWindow = _view.getAssetsObject("ActivityWindow", "ActivityWindow") as IActivityWindow;
            _popup.addView(this, this._activityWindow.content);
            _view.center(sign, this._activityWindow.content);
            this._activityWindow.buttonEffect = _view.activities.buttonEffect;
            this._activityWindow.tip = _view.tip.iTip;
            this._activityWindow.drag = _view.drag.iDrag;
            this._activityWindow.activityUrl = URI.activityUrl;
            this._activityWindow.activityList = this._activtiyList;
            this._activityWindow.onStartActivity = function (param1:String, param2:Object) : void
            {
                if (param1 != FunctionType.MultiMission && _view.multiMission.inStageWithTip)
                {
                    return;
                }
                switch(param1)
                {
                    case TownType.BossQingTianMu:
                    case TownType.BossChiYanShou:
                    {
                        _view.worldBossMap.gotoBossTown(param2.townId);
                        break;
                    }
                    case FunctionType.CampWar:
                    {
                        _view.campWar.switchSelf();
                        break;
                    }
                    case ActivityType.HeroesWar:
                    {
                        _view.heroesWar.switchSelf();
                        break;
                    }
                    case FunctionType.MultiMission:
                    {
                        _view.multiMission.switchSelf();
                        break;
                    }
                    case FunctionType.BeelzebubTrials:
                    {
                        _view.beelzebubTrials.switchSelf();
                        break;
                    }
                    case ActivityType.TopWar:
                    {
                        _view.topWarCreate.switchSelf();
                        break;
                    }
                    case ActivityType.FactionMonster:
                    {
                        if (_ctrl.player.jihuisuoId == 0)
                        {
                            _view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            ;
            this._activityWindow.onIsCheck = function (param1:String, param2:Object, param3:Boolean) : void
            {
                checkHandler(param1, param2, param3);
                return;
            }// end function
            ;
            this._activityWindow.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this.refreshActivity();
            return;
        }// end function

        public function moveFileInfo(param1:String, param2:String) : void
        {
            if (!this.inStage)
            {
                return;
            }
            this._activityWindow.moveFileInfo(param1, param2);
            return;
        }// end function

        private function checkHandler(param1:String, param2:Object, param3:Boolean) : void
        {
            switch(param1)
            {
                case TownType.BossQingTianMu:
                case TownType.BossChiYanShou:
                {
                    if (param2.isStart == 1)
                    {
                        _view.showTip(ActivityWindowViewLang.InWorldBoss);
                    }
                    else
                    {
                        this.set_robot(param2.bossId, param3 == true ? (1) : (0));
                    }
                    break;
                }
                case FunctionType.CampWar:
                {
                    if (param2.isStart == 1)
                    {
                        _view.showTip(ActivityWindowViewLang.InCampWar);
                    }
                    else
                    {
                        _view.campWar.set_robot(param3);
                    }
                    break;
                }
                case ActivityType.HeroesWar:
                {
                    if (param2.isStart == 1)
                    {
                        _view.showTip(ActivityWindowViewLang.InHeroesWar);
                    }
                    else
                    {
                        _view.heroesWar.set_robot(param3);
                    }
                    break;
                }
                case FunctionType.BeelzebubTrials:
                case ActivityType.TopWar:
                case FunctionType.MultiMission:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getActivityState(param1:Object, param2:Boolean = false) : void
        {
            var _loc_4:Object = null;
            if (param1.isStart == 1 && param1.isShowTimer)
            {
                _view.activities.visibleBtnEffect(TownType.All, param1.sign, true);
            }
            else
            {
                _view.activities.visibleBtnEffect(TownType.All, param1.sign, false);
            }
            if (param1.isTimerChange)
            {
                _loc_4 = TimeChange.timeFormat(param1, true, true);
                param1.openTime = _loc_4.openTime;
                param1.timer = _loc_4.time;
            }
            else
            {
                param1.openTime = ActivityType.getOpenTimerToSign(param1.sign);
                param1.timer = ActivityType.getTimerToSign(param1.sign);
            }
            var _loc_3:* = ActivityType.getTypeToSign(param1.sign);
            param1.isOpen = FunctionType.isOpened(_loc_3);
            param1.name = ActivityType.getNameToSign(param1.sign);
            param1.isBtn = param2;
            if (param1.sign != TownType.BossChiYanShou && param1.sign != TownType.BossQingTianMu)
            {
                param1.textTile = HtmlText.format(ActivityType.getTextTileToSign(param1.sign), HtmlText.Orange, 14, "", true) + HtmlText.format(ActivityType.getNameToAddName(param1.sign), HtmlText.Orange, 12, "", false);
                param1.textInfo = HtmlText.white(ActivityWindowViewLang.OpenTime + param1.openTime) + "\n" + HtmlText.format(ActivityType.getInfoToSign(param1.sign), 10315052);
            }
            if (param1.sign == ActivityType.HeroesWar || param1.sign == ActivityType.TopWar || param1.sign == ActivityType.FactionMonster)
            {
                param1.isOpen = true;
            }
            this.renderActivity(param1);
            return;
        }// end function

        private function renderActivity(param1:Object) : void
        {
            if (param1.isOpen)
            {
                if (param1.isStart == 1 && param1.isShowTimer)
                {
                    _view.activities.showActivityTitle(TownType.All, param1.name);
                    this._mainShowType = param1.sign;
                }
                else if (this._mainShowType == param1.sign || this._mainShowType == "")
                {
                    _view.activities.hideActivityTimer(TownType.All, param1.name);
                }
                this.renderActivityList(param1);
                if (inStage)
                {
                    this._activityWindow.activityList = this._activtiyList;
                }
            }
            return;
        }// end function

        private function renderActivityList(param1:Object) : void
        {
            var _loc_8:Object = null;
            var _loc_2:* = this._activtiyList.length;
            var _loc_3:* = _view.ctrl.player.serverTime;
            var _loc_4:* = new Date(_loc_3 * 1000);
            var _loc_5:* = TimeChange.hoursFormat(_loc_4.minutes);
            var _loc_6:* = Number(_loc_4.hours + "." + _loc_5);
            var _loc_7:int = 0;
            while (_loc_7 < _loc_2)
            {
                
                _loc_8 = this._activtiyList[_loc_7];
                if (_loc_8.sign == param1.sign)
                {
                    param1.diffServerTimer = _loc_6;
                    this._activtiyList[_loc_7] = param1;
                    return;
                }
                _loc_7++;
            }
            param1.diffServerTimer = _loc_6;
            this._activtiyList.push(param1);
            return;
        }// end function

        public function deleteActivity(param1:String) : void
        {
            var _loc_4:Object = null;
            var _loc_2:* = this._activtiyList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._activtiyList[_loc_3];
                if (_loc_4.sign == param1)
                {
                    this._activtiyList.splice(_loc_3, 1);
                    this._activityWindow.activityList = this._activtiyList;
                    return;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function refreshActivity() : void
        {
            _view.activities.refreshMultiMission();
            if (this._ctrl.heroesWar.getWarMode["mode"] == 0)
            {
                _view.activities.refreshCampWarState();
            }
            else
            {
                _view.activities.refreshHeroesWarState();
            }
            this.get_world_boss_list();
            return;
        }// end function

        public function clear() : void
        {
            this._activityWindow.clear();
            return;
        }// end function

        public function close() : void
        {
            Helper.gc();
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function get_world_boss_list(param1:Boolean = true) : void
        {
            if (FunctionType.isOpened(FunctionType.WorldBoss))
            {
                _data.call(Mod_WorldBoss_Base.get_world_boss_list, this.get_world_boss_list_back, [0]);
            }
            if (param1 == true && this._getFactionTime < getTimer())
            {
                this._getFactionTime = getTimer() + 3000;
                setTimeout(_view.factionWindow.get_world_boss_list, 2000);
            }
            return;
        }// end function

        private function get_world_boss_list_back() : void
        {
            var _loc_5:BossInfo = null;
            var _loc_6:Object = null;
            var _loc_1:Array = [ActivityWindowViewLang.NoStart, ActivityWindowViewLang.ParticipateIn, ActivityWindowViewLang.TheEnd, ActivityWindowViewLang.KillToday, ActivityWindowViewLang.ParticipateIn];
            var _loc_2:* = _ctrl.worldBossMap;
            var _loc_3:* = _loc_2.bossList;
            var _loc_4:* = _ctrl.player.vipLevel >= 5 && FunctionType.isOpened(FunctionType.Robot);
            for each (_loc_5 in _loc_3)
            {
                
                if (_loc_5.sign == MonsterType.BossDaoBaTu)
                {
                    continue;
                }
                _loc_6 = {};
                _loc_6.sign = _loc_5.sign;
                _loc_6.level = _loc_5.lv;
                _loc_6.isShowTimer = true;
                _loc_6.isTimerChange = false;
                _loc_6.townId = _loc_5.mapId;
                _loc_6.bossId = _loc_5.bossId;
                _loc_6.btnInfo = _loc_1[_loc_5.state];
                _loc_6.btnType = 1;
                _loc_6.textTile = _loc_5.htmlName;
                _loc_6.textInfo = _loc_5.infoMsg;
                if (_loc_5.state == 1 || _loc_5.state == 4)
                {
                    _loc_6.isStart = 1;
                    _loc_6.isShowCheckBtn = false;
                    if (_loc_4 && _loc_5.auto == 1)
                    {
                        _loc_6.isStart = 0;
                        _loc_6.btnInfo = HtmlText.yellow(ActivityWindowViewLang.UserDoll);
                    }
                }
                else
                {
                    _loc_6.btnInfo = htmlFormat(_loc_6.btnInfo, 12, 10066329);
                    _loc_6.isStart = 0;
                    _loc_6.isShowCheckBtn = _loc_4;
                    _loc_6.isCheck = _loc_5.auto == 1;
                    _loc_6.checkFile = ActivityWindowViewLang.Doll;
                    _loc_6.checkTipInfo = _loc_5.robotTip;
                }
                this.getActivityState(_loc_6, true);
            }
            return;
        }// end function

        public function set_robot(param1:int, param2:int) : void
        {
            _data.call(Mod_WorldBoss_Base.set_robot, this.set_robot_back, [param1, param2]);
            return;
        }// end function

        private function set_robot_back() : void
        {
            if (_ctrl.worldBossMap.result == Mod_WorldBoss_Base.ACTION_SUCCESS)
            {
                this.get_world_boss_list(false);
            }
            return;
        }// end function

    }
}
