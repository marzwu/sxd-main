﻿package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.controllers.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class MultiMissionView extends Base implements IView
    {
        public var ownCtrl:MultiMissionController;
        private var _multiMission:IMultiMission;
        private var _openType:int = 0;
        private var _tempLimitData:Array;
        private var _isStart:Boolean = false;
        private var _missionId:int = 0;
        private var _limit:int = 5;
        private var _joinTeamBool:Boolean = true;
        private var _tempBool:Boolean = false;
        private var _showMission:int = 0;
        private var _joinTeamLimit:int = 5;
        private var _isPlayerTeam:int = 0;
        private var _isStartMission:Boolean = false;
        public var isAutoStart:Boolean = false;
        public var isMinimum:Boolean = false;
        private var _teamId:int = 0;
        private var _missionLimit:int = 0;
        private var _createLimit:int = 0;
        private var _systemTimerInfo:String = "";
        private var _alert:IAlert;
        private var _isClose:Boolean = false;

        public function MultiMissionView() : void
        {
            _inStageTipTitle = MultiMissionViewLang.inStageTipTitle;
            _inStageTipContent = "";
            return;
        }// end function

        private function get_player_cd_time() : void
        {
            _data.call(Mod_MultipleMission_Base.get_player_cd_time, this.playerCdTimeCallback, [], false);
            return;
        }// end function

        private function open_mission() : void
        {
            _data.call(Mod_MultipleMission_Base.open_multiple_mission, this.openMissionCallback, [], false);
            return;
        }// end function

        private function get_team_list(param1:int, param2:int) : void
        {
            _data.call(Mod_MultipleMission_Base.get_multiple_mission_team_list, this.getTeamListCallback, [param1, param2]);
            return;
        }// end function

        private function get_team_info() : void
        {
            _data.call(Mod_MultipleMission_Base.get_player_team_info, this.getTeamInfoCallback, []);
            return;
        }// end function

        private function create_team(param1:int, param2:int) : void
        {
            _data.call(Mod_MultipleMission_Base.create_multiple_mission_team, this.createTeamCallback, [param1, param2]);
            return;
        }// end function

        private function dissolve_team() : void
        {
            _data.call(Mod_MultipleMission_Base.dissolve_multiple_mission_team, new Function(), []);
            return;
        }// end function

        private function join_team(param1:int) : void
        {
            _data.call(Mod_MultipleMission_Base.join_multiple_mission_team, this.joinTeamCallback, [param1], false);
            return;
        }// end function

        private function exit_team() : void
        {
            _data.call(Mod_MultipleMission_Base.exit_multiple_mission_team, new Function(), []);
            return;
        }// end function

        private function close_mission() : void
        {
            _data.call(Mod_MultipleMission_Base.close_multiple_mission, new Function(), []);
            return;
        }// end function

        private function kickedOutMember(param1:int) : void
        {
            _data.call(Mod_MultipleMission_Base.kicked_out_member, new Function(), [param1]);
            return;
        }// end function

        private function sortTeam(param1:String) : void
        {
            _data.call(Mod_MultipleMission_Base.sort_multiple_mission_team, new Function(), [param1]);
            return;
        }// end function

        private function fight_multiple_mission() : void
        {
            _data.call(Mod_MultipleMission_Base.fight_multiple_mission, this.fightMultipleMissionCallback, []);
            return;
        }// end function

        private function random_join() : void
        {
            _data.call(Mod_MultipleMission_Base.random_join, this.randomJoinCallback, [], false);
            return;
        }// end function

        private function openMissionCallback() : void
        {
            loadAssets("MultiMission", this.render, MultiMissionViewLang.LoadAssets);
            return;
        }// end function

        private function playerCdTimeCallback() : void
        {
            var _loc_1:* = _ctrl.multiMission.playerCdTime;
            switch(this._openType)
            {
                case 1:
                {
                    break;
                }
                case 2:
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

        private function getTeamListCallback() : void
        {
            var _loc_1:* = this._ctrl.multiMission.getTeamList;
            if (this._isClose == false)
            {
                this._multiMission.getJoinTeamList = _loc_1;
            }
            return;
        }// end function

        private function getTeamInfoCallback() : void
        {
            var _loc_1:* = this._ctrl.multiMission.getTeamInfo;
            if (this._isClose == false)
            {
                this._multiMission.getTeamListData = _loc_1;
            }
            var _loc_2:* = this._ctrl.multiMission.playerTeamInfo;
            this.toolbarShow(_loc_2);
            return;
        }// end function

        private function createTeamCallback() : void
        {
            var _loc_1:* = this._ctrl.multiMission.createTeam;
            if (_loc_1 == Mod_MultipleMission_Base.SUCCESS)
            {
                this.get_team_info();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function newTeamCallBack() : void
        {
            var _loc_1:* = this._ctrl.multiMission.newTeam;
            this._multiMission.getJoinTeamData = _loc_1;
            return;
        }// end function

        private function dropTeamCallBack() : void
        {
            var _loc_1:* = this._ctrl.multiMission.dropTeam;
            this._multiMission.dropTeam = _loc_1;
            return;
        }// end function

        private function updateMemberNumberCallBack() : void
        {
            var _loc_1:* = this._ctrl.multiMission.updateMemberNumber;
            this._multiMission.getTeamMemberNum = _loc_1;
            return;
        }// end function

        private function joinTeamCallback() : void
        {
            var _loc_1:* = _ctrl.multiMission.joinTeam;
            if (_loc_1 == Mod_MultipleMission_Base.SUCCESS)
            {
                this.get_team_info();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function exitTeamCallback() : void
        {
            var _loc_1:* = _ctrl.multiMission.exitTeam;
            return;
        }// end function

        private function notifyCallBack() : void
        {
            var data:* = this.ownCtrl.notify;
            if (data[Mod_MultipleMission_Base.UPDATE_TEAM_INFO])
            {
                this.ownCtrl.removeNotify(Mod_MultipleMission_Base.UPDATE_TEAM_INFO);
                this.get_team_info();
            }
            if (data[Mod_MultipleMission_Base.STOP_MULTIPLE_MISSION])
            {
                this.ownCtrl.removeNotify(Mod_MultipleMission_Base.STOP_MULTIPLE_MISSION);
                _view.activities.stopMultiMission();
            }
            if (data[Mod_MultipleMission_Base.HAVE_WAR_RESULT])
            {
                this._isStart = true;
                this.ownCtrl.removeNotify(Mod_MultipleMission_Base.HAVE_WAR_RESULT);
                _view.multiWar.onClose = function () : void
            {
                _view.activities.refreshMissionStatus();
                if (_ctrl.multiMission.createLimitLen > 0)
                {
                    show();
                }
                return;
            }// end function
            ;
                _view.multiWar.show();
                this.close();
            }
            return;
        }// end function

        private function fightMultipleMissionCallback() : void
        {
            var _loc_1:* = this._ctrl.multiMission.startWar;
            this.renderMsg(_loc_1);
            return;
        }// end function

        private function randomJoinCallback() : void
        {
            var _loc_1:* = this._ctrl.multiMission.randomJoin;
            if (Mod_MultipleMission_Base.SUCCESS == _loc_1)
            {
                _view.showTip(MultiMissionViewLang.Join_Success, "", TipType.Success);
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_MultipleMission_Base.INVALID_MULTIPLE_MISSION_ID:
                {
                    _view.showTip(MultiMissionViewLang.InvalidMultipleId);
                    break;
                }
                case Mod_MultipleMission_Base.FULL_TEAM_NUMBER:
                {
                    _view.showTip(MultiMissionViewLang.FullTeamNumber);
                    break;
                }
                case Mod_MultipleMission_Base.INVALID_TEAM_ID:
                {
                    _view.showTip(MultiMissionViewLang.InvalidTeamId);
                    break;
                }
                case Mod_MultipleMission_Base.FULL_MEMBER:
                {
                    _view.showTip(MultiMissionViewLang.FullMember);
                    return;
                }
                case Mod_MultipleMission_Base.NOT_SAME_CANO:
                {
                    _view.showTip(MultiMissionViewLang.NotSameCano);
                    break;
                }
                case Mod_MultipleMission_Base.NOT_SAME_GANG:
                {
                    _view.showTip(MultiMissionViewLang.NotSameCang);
                    break;
                }
                case Mod_MultipleMission_Base.LIMIT_MEMBER_NUMBER:
                {
                    _view.showTip(MultiMissionViewLang.LimitMemberNumber);
                    break;
                }
                case Mod_MultipleMission_Base.NOT_SAME_GANG:
                {
                    _view.showTip(MultiMissionViewLang.NotSameGang);
                    break;
                }
                case Mod_MultipleMission_Base.NO_BODY:
                {
                    _view.showTip(MultiMissionViewLang.NO_BODY);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function show() : void
        {
            if (_view.tower.inStageWithTip)
            {
                return;
            }
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
            if (_view.getPeach.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            if (_view.worldBossMap.inStageWithTip)
            {
                return;
            }
            if (_view.missionMap.inStageWithTip)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.MultiMission) == false)
            {
                _view.alert.confirm(MultiMissionViewLang.IsOpen);
                return;
            }
            this.open_mission();
            return;
        }// end function

        private function render() : void
        {
            this._isClose = false;
            this._multiMission = _view.getAssetsObject("MultiMission", "MultiMission") as IMultiMission;
            _popup.addView(this, this._multiMission.content);
            _view.center(sign, this._multiMission.content);
            this._multiMission.tip = _view.tip.iTip;
            this._multiMission.drag = _view.drag.iDrag;
            this._multiMission.openFastJoin = FunctionType.isOpened(FunctionType.TravelEvent);
            var data:* = this._ctrl.multiMission.limitCondition;
            var list:* = this._ctrl.multiMission.openTeam;
            this._multiMission.getCreateLimit = data.createLimit;
            this._multiMission.getJoinTeamList = list;
            this._multiMission.getJoinLimit = data.joinLimit;
            if (data.createLimit <= 0)
            {
                _view.activities.hideActivityTimer(FunctionType.MultiMission, MultiMissionViewLang.MultiMission);
            }
            this.get_team_info();
            _data.patch(Mod_MultipleMission_Base.notify, this.notifyCallBack);
            _data.patch(Mod_MultipleMission_Base.notify_new_team, this.newTeamCallBack);
            _data.patch(Mod_MultipleMission_Base.notify_drop_team, this.dropTeamCallBack);
            _data.patch(Mod_MultipleMission_Base.notify_update_member_number, this.updateMemberNumberCallBack);
            this._multiMission.isAutoStart = this.isAutoStart;
            this._multiMission.onShowJoinTeamLimity = function (param1:int) : void
            {
                _joinTeamLimit = param1;
                get_team_list(_showMission, _joinTeamLimit);
                return;
            }// end function
            ;
            this._multiMission.onJoin = function (param1:int) : void
            {
                if (_isStart)
                {
                    return;
                }
                _openType = 1;
                _teamId = param1;
                get_player_cd_time();
                return;
            }// end function
            ;
            this._multiMission.onJoinTeamLimit = function (param1:Object) : void
            {
                _showMission = param1.id;
                get_team_list(_showMission, _joinTeamLimit);
                return;
            }// end function
            ;
            this._multiMission.onCreateTeam = function (param1:int, param2:int) : void
            {
                _openType = 2;
                _missionLimit = param1;
                _createLimit = param2;
                get_player_cd_time();
                return;
            }// end function
            ;
            this._multiMission.onAutoStart = function (param1:Boolean) : void
            {
                isAutoStart = param1;
                return;
            }// end function
            ;
            this._multiMission.onKickedOutMember = function (param1:int) : void
            {
                kickedOutMember(param1);
                return;
            }// end function
            ;
            this._multiMission.onTip = function (param1:String) : void
            {
                switch(param1)
                {
                    case "joinFastTeam":
                    {
                        _view.showTip(MultiMissionViewLang.JoinFastTeam);
                        ;
                    }
                    case "teamList":
                    {
                        _view.showTip(MultiMissionViewLang.TeamList);
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
            this._multiMission.onLeftTeam = function () : void
            {
                exit_team();
                return;
            }// end function
            ;
            this._multiMission.onStart = function () : void
            {
                fight_multiple_mission();
                return;
            }// end function
            ;
            this._multiMission.onTeamLabel = function (param1:String) : void
            {
                sortTeam(param1);
                return;
            }// end function
            ;
            this._multiMission.onMinTarget = function () : void
            {
                if (_isPlayerTeam == 1)
                {
                    clear();
                    isMinimum = true;
                }
                else
                {
                    close();
                }
                return;
            }// end function
            ;
            this._multiMission.onRandomJoin = function () : void
            {
                random_join();
                return;
            }// end function
            ;
            this._multiMission.onClear = function () : void
            {
                close();
                return;
            }// end function
            ;
            return;
        }// end function

        private function toolbarShow(param1:Object) : void
        {
            this._isPlayerTeam = param1.isPlayerTeam;
            if (param1.isPlayerTeam == 1)
            {
                if (param1.isStart && this.isAutoStart && param1.isLeader)
                {
                    this.fight_multiple_mission();
                }
                _view.toolbar.renderMultMissionLink(param1.info);
            }
            else
            {
                _view.toolbar.renderMultMissionLink("");
                if (this.isMinimum)
                {
                    this.close();
                }
            }
            return;
        }// end function

        public function get isMinimumWithTip() : Boolean
        {
            var handler:Function;
            if (this.isMinimum)
            {
                handler = function (param1:uint) : void
            {
                if (AlertButtonType.Yes == param1)
                {
                    close();
                }
                return;
            }// end function
            ;
                _view.alert.showYesNoMsg(MultiMissionViewLang.ShowYesNoMsg, MultiMissionViewLang.Yes, MultiMissionViewLang.No, handler);
                return true;
            }
            return false;
        }// end function

        override public function get inStageWithTip() : Boolean
        {
            if ((inStage || this.isMinimum) && _inStageTipTitle)
            {
                _view.showTip(_inStageTipTitle, _inStageTipContent);
            }
            return inStage || this.isMinimum;
        }// end function

        public function set systemTimerInfo(param1:String) : void
        {
            this._systemTimerInfo = param1;
            if (this.inStage)
            {
                this._multiMission.renderSystemInfo = this._systemTimerInfo;
            }
            return;
        }// end function

        public function set alert(param1:IAlert) : void
        {
            this._alert = param1;
            return;
        }// end function

        public function startMultiMission() : void
        {
            this.fight_multiple_mission();
            return;
        }// end function

        public function getTeamList() : void
        {
            this.get_team_list(0, Mod_MultipleMission_Base.ALL_RECORD);
            return;
        }// end function

        public function clear() : void
        {
            if (this._isClose)
            {
                return;
            }
            Helper.gc();
            this._isClose = true;
            this.allClose();
            _popup.closeView(this);
            _view.removeFromTimerProcessList(sign);
            _data.cancelPatch(Mod_MultipleMission_Base.notify_new_team);
            _data.cancelPatch(Mod_MultipleMission_Base.notify_drop_team);
            _data.cancelPatch(Mod_MultipleMission_Base.notify_update_member_number);
            return;
        }// end function

        public function close() : void
        {
            this._isStart = false;
            this.isMinimum = false;
            this.isAutoStart = false;
            _view.toolbar.renderMultMissionLink("");
            _data.cancelPatch(Mod_MultipleMission_Base.notify);
            _view.activities.openActivity(TownType.MultiMission);
            this.clear();
            this.close_mission();
            return;
        }// end function

        public function allClose() : void
        {
            this._multiMission.clear();
            return;
        }// end function

    }
}
