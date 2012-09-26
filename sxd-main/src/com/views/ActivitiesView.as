package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.haloer.data.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.lang.client.com.views.activities.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class ActivitiesView extends Base implements IView
    {
        private var _activities:IActivities;
        private var _buttonEffect:Class;
        private var _buttonEffectCircle:Class;
        private var _runeNum:Number = 0;
        private var _giftMsg:String = "";
        private var _giftType:String = "";
        private var _activityVisible:Boolean = true;
        private var _addActivityList:Array;
        private var _addActivityEffaceList:Array;
        private var _activityFunctionList:Array;
        private var _removeActivityFunctionList:Array;
        private var _isOpen:Boolean = false;
        private var _isStartMultiMission:Boolean = false;
        private var _multiList:Array;
        private var _isRemainMission:Boolean = false;
        private var _isPlayMultiMission:Boolean = false;
        private var _multiMissionStartTimer:String = "";
        private var _multiMissionTimerList:Array;
        private var _lastMissionData:Object;
        private var _isMissionEnd:Boolean = false;
        private var _multiDownTimer:int = 0;
        private var _multiTimerList:Array;
        private var _lostTimerHoust:String = "";
        private var _multiTimer:int = 0;
        private var _winEffect:MovieClip;
        private var _winEffectLoading:Boolean = false;
        private var _objCampWarRobotStatus:Object;
        private var _objHeroesWarRobotStatus:Object;
        private var _notice:int = 0;

        public function ActivitiesView()
        {
            this._addActivityList = [];
            this._addActivityEffaceList = [];
            this._activityFunctionList = [];
            this._multiMissionTimerList = [];
            this._objCampWarRobotStatus = {};
            this._objHeroesWarRobotStatus = {};
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._activities;
        }// end function

        public function get buttonEffect() : Class
        {
            return this._buttonEffect;
        }// end function

        public function buttonEffectObj() : Sprite
        {
            return new this._buttonEffect();
        }// end function

        public function get buttonEffectCircle() : Class
        {
            return this._buttonEffectCircle;
        }// end function

        public function show() : void
        {
            this.activityVisible = true;
            var _loc_1:Array = [_view.getAssetsUrl("Activities"), URI.addonsUrl + "button_effect.swf", URI.addonsUrl + "button_effect_circle.swf"];
            File.loadList(_loc_1, this.render);
            return;
        }// end function

        private function render(param1:Array) : void
        {
            var list:* = param1;
            this._activities = (list[0] as File).getClassObject("Activities") as IActivities;
            this._buttonEffect = (list[1] as File).getClassByName("ButtonEffect") as Class;
            this._buttonEffectCircle = (list[2] as File).getClassByName("ButtonEffectCircle") as Class;
            _view.toolbar.content.addChild(this._activities.content);
            this._activities.diffTime = _ctrl.player.diffServerTime;
            this._activities.buttonEffect = this._buttonEffectCircle;
            this._activities.tip = _view.tip.iTip;
            this._activities.activityVisible = this._activityVisible;
            this._activities.onActivityStart = function (param1:Object) : void
            {
                var _loc_2:* = param1.mc.parent.localToGlobal(new Point(param1.mc.x, param1.mc.y));
                param1.point = _loc_2;
                onStartActivity(param1);
                return;
            }// end function
            ;
            this._activities.onActivityTimerClick = this.onActivityTimerClick;
            this._activities.onMinute = this.minuteHandler;
            this._activities.functionOpenPlayEnd = function (param1:Object) : void
            {
                return;
            }// end function
            ;
            this.renderActivity();
            this.renderEffaceActivity();
            this._activities.activityRuneNum = this._runeNum;
            this.reposition(false);
            return;
        }// end function

        public function set activityRuneNum(param1:Number) : void
        {
            if (this._activities)
            {
                this._activities.activityRuneNum = param1;
            }
            else
            {
                this._runeNum = param1;
            }
            return;
        }// end function

        public function onStartActivity(param1:Object) : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            var _loc_2:* = param1.type;
            switch(_loc_2)
            {
                case TownType.MultiMission:
                {
                    if (this.isStartMultiMission)
                    {
                        _data.cancelPatch(Mod_MultipleMission_Base.notify);
                        _view.multiMission.switchSelf();
                    }
                    else
                    {
                        _view.showTip(ActivitiesViewLang.MultiMissionNoOpen);
                    }
                    break;
                }
                case FunctionType.DailyQuest:
                {
                    _view.dailyQuest.switchSelf();
                    break;
                }
                case FunctionType.WorshipMars:
                {
                    _view.worshipMars.switchSelf();
                    break;
                }
                case FunctionType.SealSoul:
                {
                    _view.sealStone.getDayStone();
                    break;
                }
                case FunctionType.Zodiac:
                {
                    _view.zodiac.switchSelf();
                    break;
                }
                case FunctionType.SuperSport:
                {
                    _view.screen.stopPlayerRun();
                    if (FunctionType.isOpened(FunctionType.SuperSport))
                    {
                        _view.superSport.show();
                    }
                    break;
                }
                case TownType.PreventIndulge:
                {
                    if (URI.preventUrl)
                    {
                        _view.preventIndulge.openPreventUrl(0);
                    }
                    else
                    {
                        _view.preventIndulge.switchSelf();
                    }
                    break;
                }
                case TownType.OnlineGift:
                {
                    this.player_get_online_gift();
                    break;
                }
                case TownType.CampSalary:
                {
                    this.getPlayerCampSalary();
                    break;
                }
                case TownType.All:
                {
                    _view.activityWindow.switchSelf();
                    break;
                }
                case FunctionType.Rune:
                {
                    _view.rune.switchSelf();
                    break;
                }
                case ActivityType.FactionWarGift:
                {
                    _view.factionTrophy.show();
                    break;
                }
                case FunctionType.TakeBible:
                {
                    if (FunctionType.isOpened(FunctionType.TakeBible))
                    {
                        _view.takeBibleRoad.switchSelf();
                    }
                    else
                    {
                        _view.showTip(ActivitiesViewLang.TakeBibleRoadNoOpen);
                    }
                    break;
                }
                case ActivityType.FactionAll:
                {
                    _view.factionWindow.switchSelf();
                    break;
                }
                case FunctionType.Tower:
                {
                    _view.tower.switchSelf();
                    break;
                }
                case FunctionType.RollCake:
                {
                    _view.rollCake.switchSelf();
                    break;
                }
                case FunctionType.GetPeach:
                {
                    _view.getPeach.switchSelf();
                    break;
                }
                case ActivityType.RedEnvelopes:
                {
                    _view.redEnvelopes.switchSelf();
                    break;
                }
                case FunctionType.StudyStunt:
                {
                    _view.studyStunt.switchSelf();
                    break;
                }
                case ActivityType.ServerWar:
                {
                    switch(_ctrl.serverWar.info.stateServer)
                    {
                        case Mod_ServerWar_Base.SERVER_WAR_PREPARE:
                        case Mod_ServerWar_Base.SERVER_WAR_APPLY:
                        case Mod_ServerWar_Base.SERVER_WAR_APPLY_COMPLETE:
                        {
                            _view.serverWarSignUp.switchSelf();
                            break;
                        }
                        case Mod_ServerWar_Base.SERVER_WAR_TIANBANG:
                        case Mod_ServerWar_Base.SERVER_WAR_DIBANG:
                        {
                            _view.serverWarRecord.switchSelf();
                            break;
                        }
                        default:
                        {
                            _view.serverWarCup.show();
                            break;
                            break;
                        }
                    }
                    break;
                }
                case FunctionType.PetAnimal:
                {
                    _view.pet.show();
                    break;
                }
                case FunctionType.Farm:
                {
                    _view.farm.switchSelf();
                    break;
                }
                case ActivityType.ActivityAward:
                case ActivityType.ActivityFunction:
                {
                    this._view.activitiesShow.openFunctionPanel(param1.point, _loc_2);
                    this._view.activitiesShow.show();
                    break;
                }
                case FunctionType.HeroMission:
                {
                    this._view.heroMission.switchSelf();
                    break;
                }
                case ActivityType.GameHelper:
                {
                    this._view.liveness.switchSelf();
                    break;
                }
                case ActivityType.WorldFactionWar:
                {
                    switch(_ctrl.serverFactionWar.info.stateServer)
                    {
                        case Mod_ServerFactionWar_Base.SERVER_WAR_PREPARE:
                        case Mod_ServerFactionWar_Base.SERVER_WAR_APPLY:
                        case Mod_ServerFactionWar_Base.SERVER_WAR_APPLY_COMPLETE:
                        {
                            _view.serverFactionWarSignUp.switchSelf();
                            break;
                        }
                        case Mod_ServerFactionWar_Base.SERVER_WAR_TIANBANG:
                        case Mod_ServerFactionWar_Base.SERVER_WAR_DIBANG:
                        {
                            _view.serverFactionWarRecord.switchSelf();
                            break;
                        }
                        case Mod_ServerFactionWar_Base.RACE_TYPE_CLOSE:
                        case Mod_ServerFactionWar_Base.CLOSE:
                        {
                            break;
                        }
                        default:
                        {
                            _view.serverFactionWarCup.show();
                            break;
                            break;
                        }
                    }
                    switch(_ctrl.worldFactionWar.info.stateServer)
                    {
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_SIGN_UP:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_SIGN_UP_COMPLETE:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_PREPARE:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_APPLY:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_APPLY_COMPLETE:
                        {
                            this._view.worldFactionWarSignUp.switchSelf();
                            break;
                        }
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_TIANBANG:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG:
                        {
                            this._view.worldFactionWarRecord.switchSelf();
                            break;
                        }
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG_COMPLETE:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4_COMPLETE:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2_COMPLETE:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1:
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1_COMPLETE:
                        {
                            this._view.worldFactionWarCup.switchSelf();
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case FunctionType.DreamSection:
                {
                    _view.dreamSection.show();
                    break;
                }
                case FunctionType.Furnace:
                {
                    _view.furnaceMap.show();
                    break;
                }
                case FunctionType.HaloRole:
                {
                    _view.haloRole.show();
                    break;
                }
                case FunctionType.CatHunt:
                {
                    _view.catHunt.switchSelf();
                    break;
                }
                case ActivityType.FameRank:
                case ActivityType.MissionRank:
                case ActivityType.StatePointRank:
                case ActivityType.CoinRank:
                {
                    _view.weekRanking.switchSelf();
                    break;
                }
                case ActivityType.NineRegions:
                {
                    _view.nineRegions.show();
                    break;
                }
                case ActivityType.ActivityDuanWu:
                {
                    _view.activityDuanWu.switchSelf();
                    break;
                }
                case FunctionType.SpecialPartner:
                {
                    _view.specialPartner.switchSelf();
                    break;
                }
                case FunctionType.FindImmortal:
                {
                    _view.findImmortal.switchSelf();
                    break;
                }
                case ActivityType.TopWar:
                {
                    if (_ctrl.newTopWar.topWarStep == Mod_NewTopWar_Base.WORLD_4_END)
                    {
                        _view.topThrone.show();
                    }
                    else
                    {
                        _view.newTopWar.show();
                    }
                    break;
                }
                default:
                {
                    if (ActivityType.GiftList.indexOf(_loc_2) != -1)
                    {
                        this.removeActivity(_loc_2);
                        this.getSuperGift(_loc_2);
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function minuteHandler(param1:String, param2:Number) : void
        {
            switch(param1)
            {
                case FunctionType.TakeBible:
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

        private function getSuperGift(param1:String) : void
        {
            var _loc_2:* = _ctrl.notify.giftList[param1];
            this._giftMsg = _loc_2.message;
            this._giftType = param1;
            _data.call(Mod_Item_Base.player_get_super_gift, this.player_get_super_gift_back, [_loc_2.player_gift_id]);
            return;
        }// end function

        private function player_get_super_gift_back() : void
        {
            _data.call(Mod_Notify_Base.update_player_super_gift, null, []);
            if (_ctrl.item.result == Mod_Item_Base.PACK_FULL)
            {
                _view.showTip(ActivitiesViewLang.PackFull);
            }
            else
            {
                this.showWinEffect();
                _view.pack.updateGrids();
                if (this._giftType == ActivityType.Gift1)
                {
                    _view.alert.confirm(this._giftMsg, function (param1:int) : void
            {
                _view.vip.sendIngotReceiveShowVip();
                return;
            }// end function
            );
                }
                else
                {
                    _view.alert.confirm(this._giftMsg, null);
                }
            }
            return;
        }// end function

        private function onActivityTimerClick(param1:String) : void
        {
            if (TownType.OnlineGift == param1)
            {
                this.player_get_online_gift();
            }
            return;
        }// end function

        public function showActivityTitle(param1:String, param2:String = "", param3:int = 0) : void
        {
            var _loc_4:Object = {timer:param3, showBtn:true, startTimerColor:16777215, endTimerColor:16777215, endTimerStr:param2, sendType:param1};
            this.activityTimer(param1, _loc_4);
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                this._activities.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

        public function addActivity(param1:String) : void
        {
            var _loc_2:* = this.functionBoxCheck(param1);
            if (_loc_2)
            {
                return;
            }
            this.pushActivity(param1);
            return;
        }// end function

        public function playOpenFunctionMc() : void
        {
            if (this._activities && this._isOpen)
            {
                this._activities.autoActivityClick(ActivityType.ActivityFunction);
                this._isOpen = false;
                return;
            }
            if (FunctionType.isOpened(FunctionType.Achievement) == false || this._removeActivityFunctionList == null || this._removeActivityFunctionList.length <= 0)
            {
                return;
            }
            this._removeActivityFunctionList = [FunctionType.Farm, FunctionType.SuperSport, FunctionType.DailyQuest];
            this._activities.playOpenFunctionMc(this._removeActivityFunctionList);
            this._removeActivityFunctionList = [];
            return;
        }// end function

        private function functionBoxCheck(param1:String) : Boolean
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:String = null;
            var _loc_9:Boolean = false;
            var _loc_10:int = 0;
            var _loc_11:String = null;
            var _loc_2:Boolean = false;
            var _loc_3:* = ActivityType.checkIsActivityBoxForSign(param1);
            var _loc_4:* = ActivityType.getActivityDataForSign(param1);
            var _loc_5:* = FunctionType.isOpened(FunctionType.FunctionHall);
            if (_loc_3)
            {
                if (_loc_4.type == ActivityType.ActivityFunction)
                {
                    return false;
                }
                this._view.activitiesShow.addActivity(param1, true);
                _loc_2 = true;
            }
            return _loc_2;
        }// end function

        private function pushActivity(param1:String) : void
        {
            var _loc_2:Object = null;
            if (this.inStage)
            {
                this._activities.addActivity(param1);
            }
            else
            {
                _loc_2 = {};
                _loc_2.action = "add";
                _loc_2.type = param1;
                this._addActivityList.push(_loc_2);
            }
            return;
        }// end function

        public function removeActivity(param1:String) : void
        {
            var _loc_2:* = ActivityType.checkIsActivityBoxForSign(param1);
            var _loc_3:* = ActivityType.getActivityDataForSign(param1);
            var _loc_4:* = _loc_3.type;
            var _loc_5:* = FunctionType.isOpened(FunctionType.FunctionHall);
            if (_loc_4 == ActivityType.ActivityAward)
            {
                this._view.activitiesShow.addActivity(param1, false);
                return;
            }
            this.splitActivity(param1);
            return;
        }// end function

        private function splitActivity(param1:String) : void
        {
            var _loc_2:Object = null;
            if (this._activities != null)
            {
                this._activities.removeActivity(param1);
            }
            else
            {
                _loc_2 = {};
                _loc_2.action = "remove";
                _loc_2.type = param1;
                this._addActivityList.push(_loc_2);
            }
            return;
        }// end function

        public function activityTimer(param1:String, param2:Object) : void
        {
            var _loc_3:Object = null;
            if (this.inStage)
            {
                this._activities.activityTimer(param1, param2);
            }
            else
            {
                _loc_3 = {};
                _loc_3.action = "time";
                _loc_3.type = param1;
                _loc_3.data = param2;
                this._addActivityEffaceList.push(_loc_3);
            }
            return;
        }// end function

        public function hideActivityTimer(param1:String, param2:String) : void
        {
            var _loc_3:Object = null;
            if (this.inStage)
            {
                this._activities.hideActivityTimer(param1, param2);
            }
            else
            {
                _loc_3 = {};
                _loc_3.action = "hidTime";
                _loc_3.type = param1;
                _loc_3.name = param2;
                this._addActivityEffaceList.push(_loc_3);
            }
            return;
        }// end function

        public function activityTip(param1:String, param2:String) : void
        {
            var _loc_3:Object = null;
            if (this.inStage)
            {
                this._activities.activityTip(param1, param2);
            }
            else
            {
                _loc_3 = {};
                _loc_3.action = "tip";
                _loc_3.type = param1;
                _loc_3.info = param2;
                this._addActivityEffaceList.push(_loc_3);
            }
            return;
        }// end function

        public function visibleBtnEffect(param1:String, param2:String, param3:Boolean) : void
        {
            var _loc_4:Object = null;
            if (this.inStage == false)
            {
                _loc_4 = {};
                _loc_4.action = "visibleBtnEffect";
                _loc_4.type = param1;
                _loc_4.sign = param2;
                _loc_4.bool = param3;
                this._addActivityEffaceList.push(_loc_4);
                return;
            }
            this._activities.visibleBtnEffect(param1, param2, param3);
            return;
        }// end function

        private function renderActivity() : void
        {
            var _loc_3:Object = null;
            var _loc_1:* = this._addActivityList.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._addActivityList[_loc_2];
                switch(_loc_3.action)
                {
                    case "add":
                    {
                        this._activities.addActivity(_loc_3.type);
                        break;
                    }
                    case "remove":
                    {
                        this._activities.removeActivity(_loc_3.type);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        private function renderEffaceActivity() : void
        {
            var _loc_3:Object = null;
            var _loc_1:* = this._addActivityEffaceList.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._addActivityEffaceList[_loc_2];
                switch(_loc_3.action)
                {
                    case "time":
                    {
                        this._activities.activityTimer(_loc_3.type, _loc_3.data);
                        break;
                    }
                    case "hidTime":
                    {
                        this._activities.hideActivityTimer(_loc_3.type, _loc_3.name);
                        break;
                    }
                    case "tip":
                    {
                        this._activities.activityTip(_loc_3.type, _loc_3.info);
                        break;
                    }
                    case "visibleBtnEffect":
                    {
                        this._activities.visibleBtnEffect(_loc_3.type, _loc_3.sign, _loc_3.bool);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function set activityVisible(param1:Boolean) : void
        {
            if (this.inStage)
            {
                this._activities.activityVisible = param1;
            }
            this._activityVisible = param1;
            return;
        }// end function

        public function getActivityPoint(param1:String) : Point
        {
            var _loc_2:* = new Point(0, 0);
            if (this.inStage)
            {
                _loc_2 = this._activities.getActivityPoint(param1);
                _loc_2 = this._activities.content.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            }
            return _loc_2;
        }// end function

        public function isLoaderActivitie(param1:String) : Boolean
        {
            if (this.inStage == false)
            {
                return false;
            }
            return this._activities.isLoaderActivitie(param1);
        }// end function

        public function set visibleActivites(param1:Boolean) : void
        {
            if (!this._activities || this._activities.content == null)
            {
                return;
            }
            this._activities.content.visible = param1;
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function activityInfo() : void
        {
            this.preventIndulge();
            this.serverInit();
            this.serverFactionInit();
            this.worldFactionWarInit();
            this._view.toolbar.update_player_super_gift_back();
            return;
        }// end function

        public function openActivity(param1:String) : void
        {
            switch(param1)
            {
                case TownType.MultiMission:
                {
                    this.multiMissionActivity();
                    break;
                }
                case FunctionType.DailyQuest:
                {
                    break;
                }
                case TownType.Sport:
                {
                    this.addActivity(param1);
                    break;
                }
                case TownType.PreventIndulge:
                {
                    this.addActivity(param1);
                    break;
                }
                case TownType.OnlineGift:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.CampWar:
                {
                    this.heroesWarActivity();
                    break;
                }
                case TownType.SendIngot:
                {
                    this.addActivity(param1);
                    break;
                }
                case TownType.CampSalary:
                {
                    this.addActivity(param1);
                    break;
                }
                case TownType.All:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.Rune:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.SuperSport:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.TakeBible:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.RollCake:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.GetPeach:
                {
                    this.addActivity(param1);
                    break;
                }
                case ActivityType.RedEnvelopes:
                {
                    this.addActivity(param1);
                    break;
                }
                case ActivityType.FactionAll:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.WorshipMars:
                {
                    this._view.worshipMars.getRemainIncenseTimes();
                    break;
                }
                case FunctionType.Zodiac:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.PetAnimal:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.StudyStunt:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.DreamSection:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.Furnace:
                {
                    this.addActivity(param1);
                    break;
                }
                case FunctionType.BeelzebubTrials:
                {
                    this.beelzebubTrialsActivity();
                    break;
                }
                case ActivityType.TopWar:
                {
                    this.topWarInit();
                    break;
                }
                case FunctionType.SpecialPartner:
                {
                    this.addActivity(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get isStartMultiMission() : Boolean
        {
            return this._isStartMultiMission;
        }// end function

        public function multiMissionActivity() : void
        {
            _data.patch(Mod_MultipleMission_Base.notify, this.notifyCallBack);
            this.refreshMissionStatus();
            _data.call(Mod_MultipleMission_Base.get_multiple_mission_status, this.getStatusCallback, []);
            return;
        }// end function

        public function refreshMissionStatus() : void
        {
            _data.call(Mod_MultipleMission_Base.check_is_can_challenge, this.isCanChallengeCallback, []);
            return;
        }// end function

        public function stopMultiMission() : void
        {
            _view.multiMission.close();
            this.endMultiMission();
            _data.patch(Mod_MultipleMission_Base.notify, this.notifyCallBack);
            _view.alert.confirm(multiMissionLang.MissionClose);
            return;
        }// end function

        private function isCanChallengeCallback() : void
        {
            var _loc_1:* = _ctrl.multiMission.checkIsCanChallenge;
            this._isRemainMission = _loc_1.isCanChallenge != 0;
            var _loc_2:String = "";
            if (_loc_1.isCanChallenge > 0)
            {
                _loc_2 = htmlFormat(multiMissionLang.CanMultMission, 12, HtmlText.Green, false, true);
            }
            this._view.toolbar.renderCanMultMissionLink(_loc_2);
            return;
        }// end function

        private function notifyCallBack() : void
        {
            var _loc_1:* = _ctrl.multiMission.notify;
            if (_loc_1[Mod_MultipleMission_Base.START_MULTIPLE_MISSION])
            {
                _view.worldNotice.showMessage(multiMissionLang.MissionStart);
                this.startMultiMission();
                _ctrl.multiMission.removeNotify(Mod_MultipleMission_Base.START_MULTIPLE_MISSION);
            }
            if (_loc_1[Mod_MultipleMission_Base.STOP_MULTIPLE_MISSION])
            {
                this.endMultiMission();
                _ctrl.multiMission.removeNotify(Mod_MultipleMission_Base.STOP_MULTIPLE_MISSION);
            }
            if (_loc_1[Mod_MultipleMission_Base.HAVE_WAR_RESULT])
            {
                _ctrl.multiMission.removeNotify(Mod_MultipleMission_Base.HAVE_WAR_RESULT);
                _view.toolbar.renderMultMissionLink("");
                _view.multiMission.isAutoStart = false;
                _view.multiMission.isMinimum = false;
                _view.multiWar.show();
            }
            return;
        }// end function

        private function getStatusCallback() : void
        {
            var _loc_1:* = _ctrl.multiMission.status;
            this._multiList = _loc_1.timer;
            _view.addToTimerProcessList(sign, this.multiMissionRadio);
            this._isStartMultiMission = this.multiMissionTimer(_loc_1.timer);
            if (_loc_1.status == 0 || this._isStartMultiMission == false)
            {
                this.endMultiMission();
            }
            else
            {
                this.startMultiMission();
            }
            return;
        }// end function

        private function multiMissionRadio() : void
        {
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_1:* = _view.ctrl.player.serverTime;
            var _loc_2:* = this._multiList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (_loc_1 >= this._multiList[_loc_3].startTime - 600 && this._multiList[_loc_3].startTime > _loc_1 && this._isPlayMultiMission == false)
                {
                    _loc_4 = (this._multiList[_loc_3].startTime - _loc_1) / 60;
                    if (_loc_4 <= 0)
                    {
                        _view.worldNotice.showMessage(multiMissionLang.RightOff);
                        _loc_5 = "<font color=\"#fff200\">[" + multiMissionLang.Tg + "]</font>" + "<font color=\"#fff200\">" + multiMissionLang.RightOff + "</font>";
                    }
                    else
                    {
                        _view.worldNotice.showMessage(Lang.sprintf(multiMissionLang.NextTimeStart, _loc_4));
                        _loc_5 = "<font color=\"#fff200\">[" + multiMissionLang.Tg + "]</font>" + "<font color=\"#fff200\">" + Lang.sprintf(multiMissionLang.NextTimeStart, _loc_4) + "</font>";
                    }
                    this._isPlayMultiMission = true;
                    return;
                }
                _loc_3++;
            }
            this.multiMissionTimer(this._multiTimerList);
            return;
        }// end function

        private function startMultiMission() : void
        {
            this._isStartMultiMission = true;
            this.multiMisstionTimerList(this._multiList);
            if (this._lastMissionData)
            {
                this.multiMissionStartTimer(this._lastMissionData);
            }
            return;
        }// end function

        private function multiMissionStartTimer(param1:Object) : void
        {
            _view.multiMission.systemTimerInfo = "";
            this._multiMissionStartTimer = param1.timerStr;
            var _loc_2:int = 0;
            if (this._isStartMultiMission)
            {
                _loc_2 = 1;
            }
            else if (this._isMissionEnd)
            {
                _loc_2 = 2;
            }
            else
            {
                _loc_2 = 0;
            }
            this.activityShowMultiMission(_loc_2, param1);
            return;
        }// end function

        private function activityShowMultiMission(param1:int, param2:Object) : void
        {
            var _loc_3:Object = {sign:FunctionType.MultiMission, isStart:param1, level:"", isShowTimer:false, isTimerChange:true, startTime:param2.startTime, endTime:param2.endTime};
            _view.activityWindow.getActivityState(_loc_3, _loc_3.isStart == 1);
            return;
        }// end function

        private function endMultiMission() : void
        {
            this._isPlayMultiMission = false;
            this._isStartMultiMission = false;
            this.multiMisstionTimerList(this._multiList);
            if (this._lastMissionData)
            {
                this.multiMissionStartTimer(this._lastMissionData);
            }
            return;
        }// end function

        public function refreshMultiMission() : void
        {
            if (this._lastMissionData)
            {
                this.multiMissionStartTimer(this._lastMissionData);
            }
            return;
        }// end function

        private function multiMisstionTimerList(param1:Array) : void
        {
            var _loc_6:Object = null;
            var _loc_7:String = null;
            var _loc_8:Object = null;
            var _loc_9:Object = null;
            if (param1 == null)
            {
                return;
            }
            this._multiTimerList = param1;
            this._lastMissionData = {};
            var _loc_2:* = param1.length;
            var _loc_3:* = _view.ctrl.player.serverTime;
            var _loc_4:Boolean = false;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_6 = param1[_loc_5];
                _loc_7 = "";
                _loc_8 = TimeChange.timeFormat(_loc_6);
                _loc_9 = {};
                _loc_9.startTime = _loc_6.startTime;
                _loc_9.endTime = _loc_6.endTime;
                _loc_9.timer = _loc_8.time;
                this._multiMissionTimerList.push(_loc_9);
                if (_loc_6.endTime > _loc_3 && _loc_4 == false)
                {
                    this._lastMissionData = _loc_9;
                    this._isMissionEnd = false;
                    _loc_4 = true;
                }
                _loc_5++;
            }
            if (_loc_4 == false && this._multiMissionTimerList.length > 0)
            {
                this._lastMissionData = this._multiMissionTimerList[0];
                this._isMissionEnd = true;
            }
            return;
        }// end function

        private function multiMissionTimer(param1:Array) : Boolean
        {
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:* = _ctrl.player.serverTime;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = param1[_loc_4];
                if (_loc_5.startTime < _loc_3 && _loc_3 < _loc_5.endTime)
                {
                    this._multiDownTimer = _loc_5.endTime - _loc_3;
                    return true;
                }
                _loc_4++;
            }
            return false;
        }// end function

        public function onlineGiftActivity() : void
        {
            var _loc_1:int = 0;
            if (_ctrl.player.isGetOnlineGift == 0)
            {
                this.openActivity(TownType.OnlineGift);
                _loc_1 = _ctrl.player.onlineGiftTime;
                this.showActivityTitle(TownType.OnlineGift, onlineGiftLang.ImmeGet, _loc_1);
                this.get_player_current_online_gift();
            }
            else if (_ctrl.player.isGetOnlineGift == 1)
            {
                this.openActivity(TownType.OnlineGift);
                this.showActivityTitle(TownType.OnlineGift, onlineGiftLang.ImmeGet, 0);
                this.get_player_current_online_gift();
            }
            else if (_ctrl.player.isGetOnlineGift == -1)
            {
                this.removeActivity(TownType.OnlineGift);
            }
            return;
        }// end function

        private function player_get_online_gift() : void
        {
            this._data.call(Mod_Player_Base.player_get_online_gift, this.getOnlineGiftCallBack, []);
            return;
        }// end function

        private function getOnlineGiftCallBack() : void
        {
            var _loc_2:String = null;
            var _loc_3:Object = null;
            var _loc_4:int = 0;
            var _loc_1:* = this._ctrl.player.onlineGift;
            switch(_loc_1["result"])
            {
                case Mod_Player_Base.ACTION_FAILED:
                {
                    this._view.showTip(onlineGiftLang.NotToTime, onlineGiftLang.WaitGet);
                    break;
                }
                case Mod_Player_Base.PACK_FULL:
                {
                    this._view.showTip("", onlineGiftLang.NoBagGrid);
                    break;
                }
                case Mod_Player_Base.ACTION_SUCCESS:
                {
                    _loc_2 = "";
                    for each (_loc_3 in _loc_1["online_gift_list"])
                    {
                        
                        if (_loc_2 != "")
                        {
                            _loc_2 = _loc_2 + HtmlText.white(onlineGiftLang.Comma);
                        }
                        _loc_2 = _loc_2 + this.itemMessage(_loc_3);
                    }
                    if (_loc_1["next_time_stamp"] != 0)
                    {
                        _loc_4 = _loc_1["next_time_stamp"];
                        _loc_2 = _loc_2 + HtmlText.white(Lang.sprintf(onlineGiftLang.Next, HtmlText.yellow(DateTime.formatFromSecond1(_loc_4))));
                        this.showActivityTitle(TownType.OnlineGift, onlineGiftLang.ImmeGet, _loc_4);
                    }
                    else
                    {
                        this.removeActivity(TownType.OnlineGift);
                    }
                    _loc_2 = HtmlText.white(onlineGiftLang.Get) + _loc_2;
                    _view.alert.confirm(_loc_2);
                    _view.chat.addSystemMessage(_loc_2);
                    this.showWinEffect();
                    this.get_player_current_online_gift();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function get_player_current_online_gift() : void
        {
            this._data.call(Mod_Player_Base.get_player_current_online_gift, this.getPlayerCurrentOnlineGiftCallBack, []);
            return;
        }// end function

        private function getPlayerCurrentOnlineGiftCallBack() : void
        {
            var _loc_2:String = null;
            var _loc_3:Object = null;
            var _loc_1:* = this._ctrl.player.nextOnlineGift;
            if (_loc_1["time_stamp"] != 0)
            {
                _loc_2 = htmlFormat(onlineGiftLang.NextGet + "\r", 14, 16777215, true);
                for each (_loc_3 in _loc_1["online_gift_list"])
                {
                    
                    _loc_2 = _loc_2 + this.tipMessage(_loc_3);
                }
                this.activityTip(TownType.OnlineGift, _loc_2);
            }
            return;
        }// end function

        private function tipMessage(param1:Object) : String
        {
            var _loc_3:String = null;
            var _loc_4:Object = null;
            var _loc_5:uint = 0;
            var _loc_2:* = param1["type"];
            switch(_loc_2)
            {
                case 0:
                {
                    _loc_3 = onlineGiftLang.Coin;
                    break;
                }
                case 1:
                {
                    _loc_3 = onlineGiftLang.Ingot;
                    break;
                }
                case 2:
                {
                    _loc_3 = onlineGiftLang.Power1;
                    break;
                }
                case 3:
                {
                    _loc_3 = onlineGiftLang.Skill;
                    break;
                }
                case 4:
                {
                    _loc_3 = onlineGiftLang.Exp;
                    break;
                }
                case 5:
                {
                    _loc_4 = param1["item_info"];
                    if (ItemType.isEquip(_loc_4["type_id"]))
                    {
                        _loc_5 = _loc_4["color"];
                        _loc_3 = HtmlText.white(onlineGiftLang.Equip) + htmlFormat(_loc_4["name"] + "\r", 12, _loc_5);
                    }
                    else
                    {
                        _loc_3 = HtmlText.white(Lang.sprintf(onlineGiftLang.Item, _loc_4["name"] + param1["value"]) + "\r");
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 != 5)
            {
                _loc_3 = htmlFormat(_loc_3 + " " + param1["value"] + "\r", 12, 16777215);
            }
            return _loc_3;
        }// end function

        private function itemMessage(param1:Object) : String
        {
            var _loc_3:Object = null;
            var _loc_2:String = "";
            switch(param1["type"])
            {
                case 0:
                {
                    _loc_2 = HtmlText.yellow(param1["value"] + onlineGiftLang.Coin);
                    break;
                }
                case 1:
                {
                    _loc_2 = HtmlText.yellow(param1["value"] + onlineGiftLang.Ingot);
                    break;
                }
                case 2:
                {
                    _loc_2 = HtmlText.yellow(param1["value"] + onlineGiftLang.Power2);
                    break;
                }
                case 3:
                {
                    _loc_2 = HtmlText.yellow(param1["value"] + onlineGiftLang.Skill);
                    break;
                }
                case 4:
                {
                    _loc_2 = HtmlText.yellow(param1["value"] + onlineGiftLang.Exp);
                    break;
                }
                case 5:
                {
                    _loc_3 = param1["item_info"];
                    if (ItemType.isEquip(_loc_3["type_id"]))
                    {
                        _loc_2 = htmlFormat(_loc_3["name"], 12, _loc_3["color"]);
                        _view.toolbar.playGoodsEffect(_loc_3["id"]);
                    }
                    else
                    {
                        _loc_2 = HtmlText.yellow(param1["value"] + onlineGiftLang.Quantifier + _loc_3["name"]);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function showWinEffect() : void
        {
            var file:File;
            var show:* = function (param1:File) : void
            {
                var handler:Function;
                var file:* = param1;
                if (file != null)
                {
                    _winEffect = file.getClassObject("WinEffect") as MovieClip;
                    _winEffect.mouseChildren = false;
                    _winEffect.mouseEnabled = false;
                    handler = function (event:Event) : void
                {
                    if (_winEffect.parent)
                    {
                        _winEffect.parent.removeChild(_winEffect);
                    }
                    return;
                }// end function
                ;
                    _winEffect.addEventListener("finish", handler);
                }
                _view.stage.addChild(_winEffect);
                _winEffect.x = _view.stage.stageWidth / 2;
                _winEffect.y = _view.stage.stageHeight / 2;
                _winEffect.gotoAndPlay(1);
                return;
            }// end function
            ;
            if (this._winEffect == null && this._winEffectLoading == false)
            {
                this._winEffectLoading = true;
                file = new File();
                file.onComplete = function () : void
            {
                show(this);
                return;
            }// end function
            ;
                file.load(URI.addonsUrl + "win_effect.swf");
            }
            else if (this._winEffect)
            {
                this.show(null);
            }
            return;
        }// end function

        private function campWarActivity() : void
        {
            this.get_robot_status();
            this._data.call(Mod_CampWar_Base.get_camp_open_time, this.getCampOpenTimeCallBack, []);
            return;
        }// end function

        private function getCampOpenTimeCallBack() : void
        {
            var _loc_1:* = _ctrl.campWar.getIsOpenCampWar();
            var _loc_2:* = _ctrl.campWar.getCurrentCampOpenTime();
            if (_loc_1 == 1)
            {
                _view.campWar.getBuff();
            }
            this.activityShowCampWar(_loc_1, _loc_2["start_time"], _loc_2["end_time"]);
            return;
        }// end function

        public function activityShowCampWar(param1:int, param2:int, param3:int) : void
        {
            _view.activityWindow.deleteActivity(ActivityType.HeroesWar);
            var _loc_4:* = this._objCampWarRobotStatus["result"] == Mod_CampWar_Base.ON;
            var _loc_5:* = this._objCampWarRobotStatus["last_award_coin"];
            var _loc_6:* = this._objCampWarRobotStatus["last_award_fame"];
            var _loc_7:* = Lang.sprintf(campWarLang.OfflineJoin, HtmlText.yellow(campWarLang.Ingot));
            if (_loc_5 != 0 || _loc_6 != 0)
            {
                _loc_7 = _loc_7 + ("\r" + Lang.sprintf(campWarLang.ReplaceGet, HtmlText.yellow(_loc_5 + campWarLang.Coin), HtmlText.yellow(_loc_6 + campWarLang.Fame)));
            }
            var _loc_8:Object = {sign:FunctionType.CampWar, isStart:param1, level:"", isTimerChange:true, isShowTimer:true, startTime:param2 + _ctrl.player.serverTime, endTime:param3 + _ctrl.player.serverTime, isShowCheckBtn:VIPType.check(VIPType.Level5) && FunctionType.isOpened(FunctionType.Robot) && param1 != 1, isCheck:_loc_4, checkFile:campWarLang.ReplaceDoll, btnInfo:param1 == 1 && _loc_4 ? (HtmlText.yellow(campWarLang.InJoining)) : (campWarLang.Join), btnType:1, checkTipInfo:_loc_7};
            _view.activityWindow.getActivityState(_loc_8, param1 == 1 && !_loc_4);
            return;
        }// end function

        public function refreshCampWarState() : void
        {
            if (FunctionType.isOpened(FunctionType.CampWar))
            {
                this.get_robot_status();
                setTimeout(_view.campWar.get_camp_open_time, 500);
            }
            return;
        }// end function

        public function get_robot_status() : void
        {
            this._data.call(Mod_CampWar_Base.get_robot_status, this.getRobotStatusCallBack, []);
            return;
        }// end function

        private function getRobotStatusCallBack() : void
        {
            this._objCampWarRobotStatus = this._ctrl.campWar.getRobotStatus();
            this.getCampOpenTimeCallBack();
            return;
        }// end function

        private function heroesWarActivity() : void
        {
            this.get_robot_status_heroes();
            this._data.call(Mod_HeroesWar_Base.get_heroes_open_time, this.getHeroesOpenTimeCallBack, []);
            return;
        }// end function

        private function getHeroesOpenTimeCallBack() : void
        {
            var _loc_1:* = _ctrl.heroesWar.getIsOpenHeroesWar();
            var _loc_2:* = _ctrl.heroesWar.getCurrentHeroesOpenTime();
            if (_loc_1 == 1)
            {
                _view.heroesWar.getBuff();
            }
            this.activityShowHeroesWar(_loc_1, _loc_2["start_time"], _loc_2["end_time"]);
            return;
        }// end function

        public function activityShowHeroesWar(param1:int, param2:int, param3:int) : void
        {
            _view.activityWindow.deleteActivity(FunctionType.CampWar);
            var _loc_4:* = this._objHeroesWarRobotStatus["result"] == Mod_HeroesWar_Base.ON;
            var _loc_5:* = this._objHeroesWarRobotStatus["last_award_coin"];
            var _loc_6:* = this._objHeroesWarRobotStatus["last_award_fame"];
            var _loc_7:* = Lang.sprintf(heroesWarLang.OfflineJoin, HtmlText.yellow(heroesWarLang.Ingot));
            if (_loc_5 != 0 || _loc_6 != 0)
            {
                _loc_7 = _loc_7 + ("\r" + Lang.sprintf(heroesWarLang.ReplaceGet, HtmlText.yellow(_loc_5 + heroesWarLang.Coin), HtmlText.yellow(_loc_6 + heroesWarLang.Fame)));
            }
            var _loc_8:Object = {sign:ActivityType.HeroesWar, isStart:param1, level:"", isTimerChange:true, isShowTimer:true, startTime:param2 + _ctrl.player.serverTime, endTime:param3 + _ctrl.player.serverTime, isShowCheckBtn:VIPType.check(VIPType.Level5) && FunctionType.isOpened(FunctionType.Robot) && param1 != 1, isCheck:_loc_4, checkFile:heroesWarLang.ReplaceDoll, btnInfo:param1 == 1 && _loc_4 ? (HtmlText.yellow(heroesWarLang.InJoining)) : (heroesWarLang.Join), btnType:1, checkTipInfo:_loc_7};
            _view.activityWindow.getActivityState(_loc_8, param1 == 1 && !_loc_4);
            return;
        }// end function

        public function refreshHeroesWarState() : void
        {
            if (FunctionType.isOpened(FunctionType.CampWar))
            {
                this.get_robot_status_heroes();
                setTimeout(_view.heroesWar.get_heroes_open_time, 500);
            }
            return;
        }// end function

        public function get_robot_status_heroes() : void
        {
            this._data.call(Mod_HeroesWar_Base.get_robot_status, this.getRobotStatusHeroesCallBack, []);
            return;
        }// end function

        private function getRobotStatusHeroesCallBack() : void
        {
            this._objHeroesWarRobotStatus = this._ctrl.heroesWar.getRobotStatus();
            this.getHeroesOpenTimeCallBack();
            return;
        }// end function

        public function preventIndulge() : void
        {
            var cookie:Cookie;
            var intLastTime:int;
            if (URI.nonKid)
            {
                return;
            }
            if (URI.idCard == "")
            {
                cookie = new Cookie("PreventIndulge");
                intLastTime = cookie.getCookie("MustExit") as int;
                if (intLastTime > 0 && this._ctrl.player.serverTime - intLastTime < 18000)
                {
                    var callBack:* = function () : void
            {
                var _loc_1:* = new Sprite();
                _loc_1.graphics.beginFill(0);
                _loc_1.graphics.drawRect(0, 0, _view.stage.width, _view.stage.height);
                _loc_1.graphics.endFill();
                var _loc_2:* = new TextField();
                _loc_2.autoSize = TextFieldAutoSize.LEFT;
                _loc_2.htmlText = HtmlText.format(preventIndulgeLang.MustRest, HtmlText.White, 18, "", true);
                _loc_2.x = (_view.toolbar.width - _loc_2.width) / 2;
                _loc_2.y = (_view.toolbar.height - _loc_2.height) / 2 - 25;
                _loc_1.addChild(_loc_2);
                _popup.addChild(_loc_1);
                _view.closeEvent();
                _view.screen.stopPlayerRun();
                return;
            }// end function
            ;
                    this._view.alert.confirm(preventIndulgeLang.MustExit, callBack);
                    return;
                }
                this.against_wallows_info();
            }
            else
            {
                this.against_wallows_notify();
                this.is_weichengnian();
            }
            return;
        }// end function

        private function offLine() : void
        {
            var delay:Function;
            delay = function () : void
            {
                if (!_view.preventIndulge.inStage)
                {
                    offLine();
                }
                return;
            }// end function
            ;
            _view.closeEvent();
            _view.screen.stopPlayerRun();
            if (_view.preventIndulge.inStage)
            {
                this._popup.closeView(_view.preventIndulge);
            }
            _view.preventIndulge.blackScreen = true;
            _view.preventIndulge.switchSelf();
            setTimeout(delay, 100);
            return;
        }// end function

        public function removePreventIndulge() : void
        {
            this.removeActivity(TownType.PreventIndulge);
            return;
        }// end function

        public function preventIndulgeClose() : void
        {
            if (_ctrl.player.againstWallowsNotify == Mod_Player_Base.TIMEUP)
            {
                _view.alert.confirm(preventIndulgeLang.MustExit);
            }
            return;
        }// end function

        private function is_weichengnian() : void
        {
            _data.call(Mod_Player_Base.is_weichengnian, this.isWeiChengNianCallBack, []);
            return;
        }// end function

        private function isWeiChengNianCallBack() : void
        {
            if (_ctrl.player.isWeiChengNianOffLine)
            {
                this.offLine();
            }
            else
            {
                this.openActivity(TownType.PreventIndulge);
            }
            return;
        }// end function

        private function against_wallows_info() : void
        {
            _data.call(Mod_Player_Base.against_wallows_info, this.againstWallowsInfoCallBack, []);
            return;
        }// end function

        private function againstWallowsInfoCallBack() : void
        {
            var callback:Function;
            if (_ctrl.player.againstWallowsInfo == Mod_Player_Base.AGAINST_WALLOWS)
            {
                callback = function (param1:uint) : void
            {
                _view.closeEvent();
                _view.preventIndulge.blackScreen = true;
                _view.preventIndulge.switchSelf();
                return;
            }// end function
            ;
                _view.alert.confirm(preventIndulgeLang.FiveHours, URI.preventUrl ? (_view.preventIndulge.openPreventUrl) : (callback));
            }
            if (_ctrl.player.isMinorAccount == Mod_Player_Base.YES)
            {
                this.against_wallows_notify();
                this.openActivity(TownType.PreventIndulge);
            }
            return;
        }// end function

        private function against_wallows_notify() : void
        {
            this._data.patch(Mod_Player_Base.against_wallows_notify, this.againstWallowsNotifyCallBack);
            return;
        }// end function

        private function againstWallowsNotifyCallBack() : void
        {
            var _loc_1:Cookie = null;
            switch(_ctrl.player.againstWallowsNotify)
            {
                case Mod_Player_Base.ONE_WARNING:
                {
                    _view.alert.confirm(preventIndulgeLang.OneHours);
                    break;
                }
                case Mod_Player_Base.TWO_WARNING:
                {
                    _view.alert.confirm(preventIndulgeLang.TwoHours);
                    break;
                }
                case Mod_Player_Base.WARNING:
                {
                    _view.alert.confirm(preventIndulgeLang.FiveMinutes);
                    break;
                }
                case Mod_Player_Base.TIMEUP:
                {
                    this.offLine();
                    _loc_1 = new Cookie("PreventIndulge");
                    _loc_1.setCookie("MustExit", this._ctrl.player.serverTime);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function addCampSalaryActivityTip() : void
        {
            var _loc_1:* = htmlFormat(campSalaryLang.GetSalary, 14, 16777215, true) + htmlFormat(campSalaryLang.Coin + _ctrl.player.campSalaryCoin, 12, 16777215);
            _view.activities.activityTip(TownType.CampSalary, _loc_1);
            return;
        }// end function

        private function getPlayerCampSalary() : void
        {
            this.get_player_camp_salary();
            return;
        }// end function

        public function get_player_camp_salary() : void
        {
            _data.call(Mod_Player_Base.get_player_camp_salary, this.getPlayerCampSalarycallback, []);
            return;
        }// end function

        private function getPlayerCampSalarycallback() : void
        {
            switch(_ctrl.player.campSalaryStatus)
            {
                case Mod_Player_Base.ACTION_SUCCESS:
                {
                    this.showCampSalaryMessage();
                    this.showWinEffect();
                    _view.chat.addSystemMessage(campSalaryLang.GetCampSalary + _ctrl.player.getPlayerCampSalary + campSalaryLang.Coin);
                    _view.gameHelper.updateGameAssistant();
                    _view.liveness.updateInfo();
                    break;
                }
                case Mod_Player_Base.NOT_JOIN_CAMP:
                {
                    _view.showTip(campSalaryLang.NotJoinCamp);
                    break;
                }
                case Mod_Player_Base.ALREADY_GET:
                {
                    _view.showTip(campSalaryLang.AlreadyGet);
                    break;
                }
                default:
                {
                    _view.showTip(campSalaryLang.Error + _ctrl.player.campSalaryStatus);
                    break;
                }
            }
            return;
        }// end function

        private function showCampSalaryMessage() : void
        {
            var _loc_1:* = Lang.sprintf(campSalaryLang.GetCampSalaryInfo, HtmlText.yellow(_ctrl.player.level + campSalaryLang.Level), HtmlText.yellow(_ctrl.player.getPlayerCampSalary + campSalaryLang.Coin));
            _view.alert.confirm(_loc_1);
            return;
        }// end function

        public function redEnvelopes() : void
        {
            var _loc_1:* = new Date(2012, 0, 9).time / 1000;
            var _loc_2:* = this._ctrl.player.serverTime;
            if (this._ctrl.player.serverTime >= _loc_1)
            {
                this._view.redEnvelopes.getDate();
            }
            return;
        }// end function

        public function beelzebubTrialsActivity() : void
        {
            this._data.call(Mod_BeelzebubTrials_Base.get_beelzebub_trials_open_time, this.getOpenTimeCallBack, []);
            return;
        }// end function

        private function getOpenTimeCallBack() : void
        {
            var _loc_1:* = this._ctrl.beelzebubTrials.openTime;
            var _loc_2:* = this.renderBeelzebubTrialsTime(_loc_1.openTime);
            if (_loc_1.state == 1)
            {
                this._ctrl.beelzebubTrials.bActiveTime = true;
                _loc_2.openType = 1;
            }
            if (_loc_1.state == 0)
            {
                if (_loc_2.openType == 1)
                {
                    _loc_2.openType = 0;
                }
            }
            var _loc_3:Object = {sign:FunctionType.BeelzebubTrials, isStart:_loc_2.openType, level:"", isShowTimer:_loc_2.openType == 1, isTimerChange:true, startTime:_loc_2.startTime, endTime:_loc_2.endTime};
            this._view.activityWindow.getActivityState(_loc_3, _loc_2.openType == 1);
            return;
        }// end function

        private function renderBeelzebubTrialsTime(param1:Array) : Object
        {
            var _loc_6:Object = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_2:* = param1.length;
            var _loc_3:* = this._ctrl.player.serverTime;
            var _loc_4:Object = {startTime:0, endTime:0, openType:0};
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
                    break;
                }
                if (_loc_3 >= _loc_7 && _loc_3 <= _loc_8)
                {
                    _loc_4.openType = 1;
                    break;
                }
                if (_loc_5 >= (_loc_2 - 1))
                {
                    if (_loc_3 > _loc_8)
                    {
                        _loc_4.openType = 2;
                        break;
                    }
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        private function startBeelzebubTrial() : void
        {
            var _loc_1:Object = {sign:FunctionType.BeelzebubTrials, isStart:1, level:"", isShowTimer:true, isTimerChange:true, startTime:"19", endTime:0};
            this._view.activityWindow.getActivityState(_loc_1, true);
            return;
        }// end function

        private function endBeelzebubTrial() : void
        {
            var _loc_1:Object = {sign:FunctionType.BeelzebubTrials, isStart:0, level:"", isShowTimer:false, isTimerChange:false, startTime:0, endTime:0};
            this._view.activityWindow.getActivityState(_loc_1);
            return;
        }// end function

        public function topWarInit() : void
        {
            this._data.call(Mod_TopWar_Base.get_top_war_state, this.getTopWarStateCallBack, []);
            return;
        }// end function

        private function getTopWarStateCallBack() : void
        {
            var _loc_1:* = this._ctrl.topWar.getTopWarState();
            switch(_loc_1)
            {
                case Mod_TopWar_Base.OPEN:
                {
                    this.startTopWar();
                    break;
                }
                case Mod_TopWar_Base.CLOSE:
                {
                    this.endTopWar();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function startTopWar() : void
        {
            if (this._ctrl.player.level < 70)
            {
                return;
            }
            var _loc_1:Object = {sign:ActivityType.TopWar, isStart:1, level:"", isShowTimer:true, isTimerChange:false, startTime:0, endTime:0};
            this._view.topWarCreate.isOpenTopWar = true;
            this._view.activityWindow.getActivityState(_loc_1, true);
            return;
        }// end function

        public function endTopWar() : void
        {
            if (this._ctrl.player.level < 70)
            {
                return;
            }
            var _loc_1:Object = {sign:ActivityType.TopWar, isStart:0, level:"", isShowTimer:false, isTimerChange:false, startTime:0, endTime:0};
            this._view.topWarCreate.isOpenTopWar = false;
            this._view.activityWindow.getActivityState(_loc_1);
            return;
        }// end function

        public function serverInit() : void
        {
            if (this._ctrl.player.level < 30)
            {
                return;
            }
            this._data.call(Mod_ServerWar_Base.get_race_step, this.get_race_step_back, []);
            this._data.patch(Mod_Notify_Base.update_server_war_step, this.update_server_war_step_back);
            this._data.patch(Mod_Notify_Base.have_new_server_war_report, this.have_new_server_war_report_back);
            return;
        }// end function

        private function update_server_war_step_back() : void
        {
            this.serverInit();
            var _loc_1:String = "";
            var _loc_2:* = this._ctrl.serverWar.info.isThisService;
            switch(this._ctrl.serverWar.info.stateServer)
            {
                case Mod_ServerWar_Base.SERVER_WAR_APPLY_COMPLETE:
                {
                    if (_loc_2)
                    {
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.WarReadyNotice;
                    }
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_TIANBANG:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.WarTianBanNotice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.WarTianBanNotice2;
                    }
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_DIBANG:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.WarDiBanNotice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.WarDiBanNotice2;
                    }
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_16:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.War16Notice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.War16Notice2;
                    }
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_8:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.War8Notice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.War8Notice2;
                    }
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_4:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.War4Notice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.War4Notice2;
                    }
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_2:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.War2Notice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.War2Notice2;
                    }
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_1:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.War1Notice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.War1Notice2;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_1 != "")
            {
                this._view.worldNotice.showMessage(htmlFormat(_loc_1, 22, 16773632, true));
            }
            return;
        }// end function

        private function have_new_server_war_report_back() : void
        {
            this.serverInit();
            return;
        }// end function

        private function get_race_step_back() : void
        {
            this.removeActivity(ActivityType.ServerWar);
            if (Mod_ServerWar_Base.CLOSE == this._ctrl.serverWar.info.stateServer || this._ctrl.serverWar.info.warType == Mod_ServerWar_Base.RACE_TYPE_CLOSE)
            {
                return;
            }
            this.addActivity(ActivityType.ServerWar);
            switch(this._ctrl.serverWar.info.stateServer)
            {
                case Mod_ServerWar_Base.SERVER_WAR_APPLY:
                {
                    this.showActivityTitle(ActivityType.ServerWar, activityInfoLang.SignUp);
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_APPLY_COMPLETE:
                {
                    if (this._ctrl.serverWar.info.isThisService)
                    {
                        this.showActivityTitle(ActivityType.ServerWar, activityInfoLang.SignUpStop);
                    }
                    else
                    {
                        this.showActivityTitle(ActivityType.ServerWar, activityInfoLang.Ready);
                    }
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_TIANBANG:
                case Mod_ServerWar_Base.SERVER_WAR_DIBANG:
                {
                    this.showActivityTitle(ActivityType.ServerWar, activityInfoLang.Knockout);
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_DIBANG_COMPLETE:
                case Mod_ServerWar_Base.SERVER_WAR_16:
                {
                    this.showActivityTitle(ActivityType.ServerWar, activityInfoLang.War16);
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_16_COMPLETE:
                case Mod_ServerWar_Base.SERVER_WAR_8:
                {
                    this.showActivityTitle(ActivityType.ServerWar, activityInfoLang.War8);
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_8_COMPLETE:
                case Mod_ServerWar_Base.SERVER_WAR_4:
                {
                    this.showActivityTitle(ActivityType.ServerWar, activityInfoLang.War4);
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_4_COMPLETE:
                case Mod_ServerWar_Base.SERVER_WAR_2:
                {
                    this.showActivityTitle(ActivityType.ServerWar, activityInfoLang.War2);
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_2_COMPLETE:
                case Mod_ServerWar_Base.SERVER_WAR_1:
                {
                    this.showActivityTitle(ActivityType.ServerWar, activityInfoLang.War1);
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_1_COMPLETE:
                {
                    this.showActivityTitle(ActivityType.ServerWar, activityInfoLang.SeeRecord);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._view.serverWarCup.update();
            this._view.serverWarSignUp.update();
            this._view.serverWarRecord.update();
            return;
        }// end function

        public function serverFactionInit() : void
        {
            if (this._ctrl.player.level < 30)
            {
                return;
            }
            this._data.call(Mod_ServerFactionWar_Base.get_race_step, this.get_race_step_back_serverFactionWar, []);
            this._data.patch(Mod_Notify_Base.update_server_faction_war_step, this.update_server_faction_war_step_back);
            this._data.patch(Mod_Notify_Base.have_new_server_faction_war_report, this.have_new_server_faction_war_report_back);
            return;
        }// end function

        private function update_server_faction_war_step_back() : void
        {
            this.serverFactionInit();
            var _loc_1:String = "";
            var _loc_2:* = this._ctrl.serverFactionWar.info.isThisService;
            switch(this._ctrl.serverFactionWar.info.stateServer)
            {
                case Mod_ServerFactionWar_Base.SERVER_WAR_APPLY_COMPLETE:
                {
                    if (_loc_2)
                    {
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.WarReadyNotice;
                    }
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_TIANBANG:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.ServerFactionWarTianBanNotice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.WarTianBanNotice2;
                    }
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_DIBANG:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.ServerFactionWarDiBanNotice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.WarDiBanNotice2;
                    }
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_16:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.ServerFactionWar16Notice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.War16Notice2;
                    }
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_8:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.ServerFactionWar8Notice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.War8Notice2;
                    }
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_4:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.ServerFactionWar4Notice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.War4Notice2;
                    }
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_2:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.ServerFactionWar2Notice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.War2Notice2;
                    }
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_1:
                {
                    if (_loc_2)
                    {
                        _loc_1 = activityInfoLang.ServerFactionWar1Notice1;
                    }
                    else
                    {
                        _loc_1 = activityInfoLang.War1Notice2;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_1 != "")
            {
                this._view.worldNotice.showMessage(htmlFormat(_loc_1, 22, 16773632, true));
            }
            return;
        }// end function

        private function have_new_server_faction_war_report_back() : void
        {
            this.serverFactionInit();
            return;
        }// end function

        private function get_race_step_back_serverFactionWar() : void
        {
            this.removeActivity(ActivityType.WorldFactionWar);
            if (Mod_ServerFactionWar_Base.CLOSE == this._ctrl.serverFactionWar.info.stateServer || this._ctrl.serverFactionWar.info.warType == Mod_ServerFactionWar_Base.RACE_TYPE_CLOSE)
            {
                return;
            }
            this.addActivity(ActivityType.WorldFactionWar);
            switch(this._ctrl.serverFactionWar.info.stateServer)
            {
                case Mod_ServerFactionWar_Base.SERVER_WAR_APPLY:
                {
                    this.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.SignUp);
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_APPLY_COMPLETE:
                {
                    if (this._ctrl.serverFactionWar.info.isThisService)
                    {
                        this.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.SignUpStop);
                    }
                    else
                    {
                        this.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.Ready);
                    }
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_TIANBANG:
                case Mod_ServerFactionWar_Base.SERVER_WAR_DIBANG:
                {
                    this.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.Knockout);
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_DIBANG_COMPLETE:
                case Mod_ServerFactionWar_Base.SERVER_WAR_16:
                {
                    this.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.War16);
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_16_COMPLETE:
                case Mod_ServerFactionWar_Base.SERVER_WAR_8:
                {
                    this.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.War8);
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_8_COMPLETE:
                case Mod_ServerFactionWar_Base.SERVER_WAR_4:
                {
                    this.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.War4);
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_4_COMPLETE:
                case Mod_ServerFactionWar_Base.SERVER_WAR_2:
                {
                    this.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.War2);
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_2_COMPLETE:
                case Mod_ServerFactionWar_Base.SERVER_WAR_1:
                {
                    this.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.War1);
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_1_COMPLETE:
                {
                    this.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.SeeRecord);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._view.serverFactionWarCup.update();
            this._view.serverFactionWarSignUp.update();
            this._view.serverFactionWarRecord.update();
            return;
        }// end function

        public function getWarModeCallBack() : void
        {
            return;
        }// end function

        private function worldFactionWarInit() : void
        {
            if (this._ctrl.player.level < 30)
            {
                return;
            }
            this._data.call(Mod_WorldFactionWar_Base.get_race_step, this.get_race_step_back_world, []);
            this._data.patch(Mod_Notify_Base.update_world_faction_war_step, this.update_world_faction_war_step_back);
            this._data.patch(Mod_Notify_Base.update_world_faction_war_team, this.update_world_faction_war_team_back);
            this._data.patch(Mod_Notify_Base.have_new_world_faction_war_report, this.have_new_world_faction_war_report_back);
            this._data.patch(Mod_Notify_Base.world_faction_war_winner, this.world_faction_war_winner_back);
            return;
        }// end function

        public function updtaeWorldFactionWar() : void
        {
            this._data.call(Mod_WorldFactionWar_Base.get_race_step, this.get_race_step_back_world, []);
            return;
        }// end function

        private function get_race_step_back_world() : void
        {
            this._view.activities.addActivity(ActivityType.WorldFactionWar);
            var _loc_1:* = this._ctrl.worldFactionWar.info;
            switch(_loc_1.stateServer)
            {
                case Mod_WorldFactionWar_Base.CLOSE:
                {
                    if (Mod_ServerFactionWar_Base.CLOSE == this._ctrl.serverFactionWar.info.stateServer || this._ctrl.serverFactionWar.info.warType == Mod_ServerFactionWar_Base.RACE_TYPE_CLOSE)
                    {
                        this._view.activities.removeActivity(ActivityType.WorldFactionWar);
                    }
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_SIGN_UP:
                {
                    if (this._ctrl.worldFactionWar.signUpType == 2)
                    {
                        this._view.activities.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.IsSignUp);
                    }
                    else
                    {
                        this._view.activities.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.SignUp);
                    }
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_SIGN_UP_COMPLETE:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_PREPARE:
                {
                    this._view.activities.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.Ready);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_APPLY:
                {
                    this._view.activities.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.Ready);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_APPLY_COMPLETE:
                {
                    this._view.activities.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.Ready);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_TIANBANG:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG:
                {
                    this._view.activities.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.Knockout);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG_COMPLETE:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4:
                {
                    this._view.activities.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.War4);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4_COMPLETE:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2:
                {
                    this._view.activities.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.War2);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2_COMPLETE:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1:
                {
                    this._view.activities.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.War1);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1_COMPLETE:
                {
                    this._view.activities.showActivityTitle(ActivityType.WorldFactionWar, activityInfoLang.SeeRecord);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._view.worldFactionWarSignUp.inStage)
            {
                this._view.worldFactionWarSignUp.update();
            }
            if (this._view.worldFactionWarRecord.inStage)
            {
                this._view.worldFactionWarRecord.update();
            }
            if (this._view.worldFactionWarCup.inStage)
            {
                this._view.worldFactionWarCup.update();
            }
            return;
        }// end function

        private function update_world_faction_war_step_back() : void
        {
            this._data.call(Mod_WorldFactionWar_Base.get_race_step, this.get_race_step_back_world, []);
            var _loc_1:* = this._ctrl.worldFactionWar.info;
            switch(_loc_1.stateServer)
            {
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_APPLY_COMPLETE:
                {
                    this.showWorldFactionWarNotice(activityInfoLang.WorldFactionWarTaoTaiSai);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_TIANBANG:
                {
                    this.showWorldFactionWarNotice(activityInfoLang.WorldFactionWarTaoTaiSai);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG_COMPLETE:
                {
                    this.showWorldFactionWarNotice(activityInfoLang.WorldFactionWar41);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4:
                {
                    if (_loc_1.stateTeam == 1)
                    {
                        this.showWorldFactionWarNotice(activityInfoLang.WorldFactionWar42);
                    }
                    else if (_loc_1.stateTeam == 2)
                    {
                        this.showWorldFactionWarNotice(activityInfoLang.WorldFactionWar43);
                    }
                    else if (_loc_1.stateTeam == 3)
                    {
                        this.showWorldFactionWarNotice(activityInfoLang.WorldFactionWar44);
                    }
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4_COMPLETE:
                {
                    this.showWorldFactionWarNotice(activityInfoLang.WorldFactionWar21);
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2:
                {
                    if (_loc_1.stateTeam == 1)
                    {
                        this.showWorldFactionWarNotice(activityInfoLang.WorldFactionWar22);
                    }
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2_COMPLETE:
                {
                    this.showWorldFactionWarNotice(activityInfoLang.WorldFactionWar11);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function showWorldFactionWarNotice(param1:String) : void
        {
            if (this._notice > getTimer())
            {
                return;
            }
            this._notice = getTimer() + 3000;
            this._view.worldNotice.showMessage(HtmlText.format(param1, 16773632, 24));
            return;
        }// end function

        private function update_world_faction_war_team_back() : void
        {
            this._data.call(Mod_WorldFactionWar_Base.get_race_step, this.get_race_step_back_world, []);
            return;
        }// end function

        private function have_new_world_faction_war_report_back() : void
        {
            this._data.call(Mod_WorldFactionWar_Base.get_race_step, this.get_race_step_back_world, []);
            return;
        }// end function

        private function world_faction_war_winner_back() : void
        {
            this._view.worldNotice.showMessage(this._ctrl.notify.worldfactionWinner);
            return;
        }// end function

    }
}
