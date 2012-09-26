package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class ChooseMissionView extends Base implements IView
    {
        private var _chooseMission:IMission;
        private var missionType:int = 0;
        private var _oldType:int = 99;
        private var _showTownId:int = 0;
        private var _alert:IAlert;
        private var _missionId:int = 0;
        private var _autoMissionId:int = 0;
        private var _autoMissionLock:int = 0;
        private var _autoMissionInfo:String = "";
        public var mainMissionInfo:String = "MainMissionInfo";
        private var _autoType:int = 0;

        public function ChooseMissionView() : void
        {
            _inStageTipTitle = ChooseMissionViewLang.MissionOpen;
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
            if (_view.multiMission.inStageWithTip)
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
            if (_view.getPeach.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            if (this._oldType == this.missionType && inStage)
            {
                return;
            }
            this._oldType = this.missionType;
            this._showTownId = _ctrl.player.mapId;
            this.close();
            _data.call(Mod_Mission_Base.get_sections, this.getSectionsCallback, [this._showTownId]);
            return;
        }// end function

        public function set showTownMission(param1:int) : void
        {
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.multiMission.inStageWithTip)
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
            this._showTownId = param1;
            _data.call(Mod_Mission_Base.get_sections, this.getSectionsCallback, [param1]);
            return;
        }// end function

        public function set alert(param1:IAlert) : void
        {
            this._alert = param1;
            return;
        }// end function

        public function checkCampAndLoad() : void
        {
            var _loc_1:String = null;
            var _loc_2:String = null;
            var _loc_3:String = null;
            if (_ctrl.player.inSelfTown)
            {
                _data.call(Mod_Mission_Base.get_sections, this.getSectionsCallback, [_ctrl.player.mapId]);
            }
            else
            {
                _loc_1 = FactionType.campName(_ctrl.player.campId);
                _loc_2 = TownType.getName(_ctrl.player.mapId);
                _loc_3 = Lang.sprintf(ChooseMissionViewLang.UnderTheRest, _loc_1, _loc_2);
                _view.alert.confirm(_loc_3);
            }
            return;
        }// end function

        private function getSectionsCallback() : void
        {
            loadAssets("ChooseMission", this.render, ChooseMissionViewLang.LoadAssets);
            return;
        }// end function

        private function render() : void
        {
            var mainMissionId:int;
            var mainMissionLock:int;
            this._chooseMission = _view.getAssetsObject("ChooseMission", "ChooseMission") as IMission;
            _popup.addView(this, this._chooseMission.content);
            _view.center(sign, this._chooseMission.content);
            this._chooseMission.tip = _view.tip.iTip;
            this._chooseMission.drag = _view.drag.iDrag;
            this.alert = _view.alert.iAlert;
            this._chooseMission.isOpenPractice = FunctionType.isOpened(FunctionType.MissionPractice);
            var townMainMission:* = _ctrl.mission.renderTownMission(this._showTownId);
            var openMainList:* = _ctrl.mission.openMission;
            this._chooseMission.mainMissionList = townMainMission;
            this._chooseMission.openMainMission = openMainList;
            this._chooseMission.openMissionType = this.missionType;
            if (this._autoMissionLock != 0)
            {
                this._chooseMission.autoMissionId(this._autoMissionLock, this._autoMissionInfo, this._autoType);
            }
            else
            {
                mainMissionId = _ctrl.quest.masterMissionId;
                if (mainMissionId != 0 && _ctrl.quest.mainQuestState == QuestType.Acceptable)
                {
                    mainMissionLock = MissionType.getMissionLock(mainMissionId);
                    this._chooseMission.autoMissionId(mainMissionLock, ChooseMissionViewLang.GetMainQuest, 3);
                }
            }
            this._chooseMission.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._chooseMission.onStartMission = function (param1:Object) : void
            {
                if (_view.missionPractice.inStage)
                {
                    _view.showTip(ChooseMissionViewLang.MissionPracticeOpen);
                }
                else
                {
                    if (param1 == null)
                    {
                        _view.quest.moveToNPC(_ctrl.quest.masterBeginTownId, _ctrl.quest.masterBeginNpcId);
                    }
                    else
                    {
                        _view.missionMap.gotoMissionAtId(param1.id);
                    }
                    close();
                }
                return;
            }// end function
            ;
            this._chooseMission.onStartPractice = function (param1:Object) : void
            {
                if (_view.missionPractice.inStage)
                {
                    _view.showTip(ChooseMissionViewLang.MissionPracticeStart);
                }
                else
                {
                    _view.missionPractice.isCheck = _autoMissionId == param1.id;
                    _view.missionPractice.missionId = param1.id;
                    _view.missionPractice.monsterLen = param1.monsterLen;
                    _view.missionPractice.switchSelf();
                }
                return;
            }// end function
            ;
            this._chooseMission.onFcousList = function (param1:Array) : void
            {
                return;
            }// end function
            ;
            this._chooseMission.onRefreshHeroMission = function (param1:Object) : void
            {
                _missionId = param1.id;
                return;
            }// end function
            ;
            return;
        }// end function

        public function autoMissionId(param1:int, param2:String = "MainMissionInfo") : void
        {
            this._autoMissionId = param1;
            if (param2 == this.mainMissionInfo)
            {
                this._autoMissionInfo = ChooseMissionViewLang.QuestMission;
                this._autoType = 0;
            }
            else
            {
                this._autoMissionInfo = param2;
                this._autoType = 1;
            }
            this._autoMissionLock = MissionType.getMissionLock(this._autoMissionId);
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
            if (this._chooseMission != null)
            {
                this._chooseMission.clear();
                this._autoMissionId = 0;
                this._autoMissionLock = 0;
                this._chooseMission = null;
            }
            return;
        }// end function

    }
}
