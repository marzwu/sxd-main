package com.controllers
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.datas.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class MultiMissionController extends Base
    {
        public var ownData:MultiMissionData;
        private var _colorObj:Object;
        private var _limitData:Object;
        public var teamId:int = 0;
        public var createLimitLen:int = 0;
        public var playerTeamInfo:Object;
        private var _maxTeamSize:int = 3;
        private var _notifyObject:Object;
        private var _dropTeam:Array;
        private var _updateMemberNumber:Array;

        public function MultiMissionController() : void
        {
            this._colorObj = {1:16777215, 2:2272312, 3:44783, 4:16711935, 5:16773376};
            this._limitData = {};
            this.playerTeamInfo = {};
            this._limitData[Mod_MultipleMission_Base.NOT_LIMIT] = MultiMissionControllerLang.NotLimit;
            this._limitData[Mod_MultipleMission_Base.SAME_CANO] = MultiMissionControllerLang.SameCano;
            this._limitData[Mod_MultipleMission_Base.SAME_GANG] = MultiMissionControllerLang.SameGaon;
            return;
        }// end function

        public function get openTeam() : Array
        {
            var _loc_1:Array = [];
            var _loc_2:* = this._data.multiMission.openMission;
            _loc_1 = this.renderTeam(_loc_2[0]);
            return _loc_1;
        }// end function

        public function get limitCondition() : Object
        {
            var _loc_1:Object = {};
            var _loc_2:* = this._data.multiMission.openMission;
            _loc_1.createLimit = this.renderLimit(_loc_2[1]);
            _loc_1.joinLimit = this.renderLimit(_loc_2[2], true);
            this.createLimitLen = _loc_1.createLimit.length;
            return _loc_1;
        }// end function

        public function get getTeamList() : Array
        {
            var _loc_1:Array = [];
            var _loc_2:* = this._data.multiMission.getTeamList;
            _loc_1 = this.renderTeam(_loc_2[0]);
            return _loc_1;
        }// end function

        public function get getTeamInfo() : Object
        {
            var _loc_1:* = this._data.multiMission.getTeamInfo;
            var _loc_2:Object = {};
            if (_loc_1[1].length <= 0)
            {
                _loc_2.isTeam = false;
                _loc_2.isTeamLeader = false;
                _loc_2.teamId = 0;
                this.playerTeamInfo.isPlayerTeam = 0;
            }
            else
            {
                _loc_2.isTeam = true;
                _loc_2.teamId = _loc_1[0];
                this.playerTeamInfo.isPlayerTeam = 1;
                this.playerTeamInfo.maxTeamSize = this._maxTeamSize;
                this.playerTeamInfo.teamMemberNumber = _loc_1[1].length;
                this.renderPlayerTeam(this.playerTeamInfo);
                if (_loc_1[0] == _data.player.playerId)
                {
                    this.playerTeamInfo.isLeader = true;
                    _loc_2.isTeamLeader = true;
                }
                else
                {
                    this.playerTeamInfo.isLieader = false;
                }
                _loc_2.teamMemberInfo = this.renderTeamInfo(_loc_1[1], _loc_1[0]);
            }
            return _loc_2;
        }// end function

        private function renderTeamInfo(param1:Array, param2:int) : Array
        {
            var _loc_6:Object = null;
            var _loc_7:Array = null;
            var _loc_3:* = param1.length;
            var _loc_4:Array = [];
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = {};
                _loc_7 = param1[_loc_5];
                _loc_6.id = _loc_7[0];
                if (_loc_5 == (_loc_3 - 1))
                {
                    _loc_6.isLastNum = true;
                }
                else
                {
                    _loc_6.isLastNum = false;
                }
                _loc_6.teamNum = _loc_5;
                _loc_6.sign = _loc_7[2];
                _loc_6.level = _loc_7[3];
                _loc_6.url = URI.getRoleIconUrl(_loc_6.sign);
                if (param2 == _loc_6.id)
                {
                    _loc_6.name = _ctrl.player.removeNickNameSuffix(_loc_7[1]) + " " + _loc_6.level + MultiMissionControllerLang.Ji + "[" + MultiMissionControllerLang.Leader + "]";
                    _loc_6.isLeader = true;
                }
                else
                {
                    _loc_6.name = _ctrl.player.removeNickNameSuffix(_loc_7[1]) + " " + _loc_6.level + MultiMissionControllerLang.Ji;
                    _loc_6.isLeader = false;
                }
                _loc_4.push(_loc_6);
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public function get createTeam() : int
        {
            var _loc_1:* = this._data.multiMission.createTeam;
            return _loc_1;
        }// end function

        public function get dissolveTeam() : Array
        {
            var _loc_1:Array = [];
            return _loc_1;
        }// end function

        public function get joinTeam() : int
        {
            var _loc_1:* = this._data.multiMission.joinTeam;
            return _loc_1;
        }// end function

        public function get exitTeam() : Array
        {
            var _loc_1:Array = [];
            return _loc_1;
        }// end function

        public function get scotTeam() : String
        {
            var _loc_1:* = this._data.multiMission.sortTeam;
            return _loc_1;
        }// end function

        public function get startWar() : int
        {
            var _loc_1:* = this.ownData.startWar;
            var _loc_2:* = _loc_1[0];
            return _loc_2;
        }// end function

        public function get notify() : Object
        {
            this._notifyObject = this._data.multiMission.notifyHash;
            return this._notifyObject;
        }// end function

        public function removeNotify(param1:int) : void
        {
            delete this._notifyObject[param1];
            return;
        }// end function

        public function get status() : Object
        {
            var _loc_5:Array = null;
            var _loc_1:* = this._data.multiMission.getStatus;
            var _loc_2:Object = {};
            _loc_2.status = parseInt(_loc_1[0]);
            _loc_2.isRemainMission = _loc_1[2];
            _loc_2.timer = [];
            var _loc_3:* = _loc_1[1].length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_1[1][_loc_4];
                _loc_2.timer[_loc_4] = {};
                _loc_2.timer[_loc_4].startTime = _loc_5[0];
                _loc_2.timer[_loc_4].endTime = _loc_5[1];
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get newTeam() : Object
        {
            var _loc_1:* = _data.multiMission.newTeam;
            var _loc_2:* = this.renderTeam([_loc_1]);
            var _loc_3:* = _loc_2[0];
            return _loc_3;
        }// end function

        public function get dropTeam() : int
        {
            var _loc_1:* = _data.multiMission.dropTeam;
            var _loc_2:* = _loc_1[0];
            return _loc_2;
        }// end function

        public function get updateMemberNumber() : Object
        {
            var _loc_1:* = _data.multiMission.updateMemberNumber;
            var _loc_2:Object = {};
            _loc_2.teamId = _loc_1[0];
            _loc_2.memberNum = _loc_1[1];
            return _loc_2;
        }// end function

        public function get randomJoin() : int
        {
            var _loc_1:* = _data.multiMission.RandomJoin;
            var _loc_2:* = _loc_1[0];
            return _loc_2;
        }// end function

        private function renderTeam(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_7:int = 0;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1[_loc_4];
                _loc_6 = {};
                _loc_6.teamId = _loc_5[0];
                _loc_6.multiMissionId = _loc_5[1];
                _loc_6.leaderName = _loc_5[2];
                _loc_6.masterName = MultiMissionControllerLang.Leader + " " + _ctrl.player.removeNickNameSuffix(_loc_6.leaderName);
                _loc_6.teamMemberNumber = _loc_5[3];
                _loc_6.maxTeamSize = this._maxTeamSize;
                _loc_6.missionName = MultipleMissionType.getMissionName(_loc_6.multiMissionId);
                _loc_6.awardExperience = MultipleMissionType.getAwardExp(_loc_6.multiMissionId);
                _loc_6.awardSkill = MultipleMissionType.getAwardSkill(_loc_6.multiMissionId);
                _loc_7 = MultipleMissionType.getAwardItemId(_loc_6.multiMissionId);
                _loc_6.fram = _loc_7;
                _loc_6.awardInfo = "<font color=\"#666666\">" + MultiMissionControllerLang.Drop + "</font>" + "<font color=\"#FF9900\"> " + MultiMissionControllerLang.Farm + _loc_6.fram + "</font>" + "<font color=\"#FF9900\"> " + MultiMissionControllerLang.Skill + "</font>" + "<font color=\"#FF9900\">" + _loc_6.awardSkill + "</font>";
                _loc_6.personNumber = MultiMissionControllerLang.PersonNum + _loc_6.teamMemberNumber + "/" + _loc_6.maxTeamSize;
                _loc_6.limitCondition = this._limitData[_loc_5[4]];
                _loc_6.conditionName = _loc_5[5];
                if (_loc_6.conditionName != "")
                {
                    _loc_6.missionInfo = _loc_6.missionName + "【 " + MultiMissionControllerLang.Camp + _loc_6.conditionName + "】";
                }
                else
                {
                    _loc_6.missionInfo = _loc_6.missionName;
                }
                _loc_6.isCanJoin = _loc_5[6];
                _loc_6.playerCamp = this._ctrl.player.campId;
                _loc_6.leaderCamp = _loc_5[7];
                _loc_6.factionName = _loc_5[8];
                _loc_6.createTime = _loc_5[9];
                _loc_2.push(_loc_6);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function renderPlayerTeam(param1:Object) : void
        {
            if (param1.teamMemberNumber >= param1.maxTeamSize)
            {
                param1.txtColor = 16777215;
                param1.isStart = true;
            }
            else
            {
                param1.txtColor = 3407616;
                param1.isStart = false;
            }
            param1.info = "<font color=\"#" + param1.txtColor.toString(16) + "\">" + "<u>" + MultiMissionControllerLang.TeamNum + "(</u>" + "</font>" + "<font color=\"#" + param1.txtColor.toString(16) + "\">" + "<u>" + param1.teamMemberNumber + "/" + param1.maxTeamSize + ")" + "</u>" + "</font>";
            return;
        }// end function

        private function colorRender(param1:uint) : uint
        {
            var _loc_2:* = this._colorObj[param1];
            return _loc_2;
        }// end function

        private function renderLimit(param1:Array, param2:Boolean = false) : Array
        {
            var _loc_6:Array = null;
            var _loc_7:Object = null;
            var _loc_3:Array = [];
            if (param2)
            {
                _loc_3 = [{id:0, name:MultiMissionControllerLang.ShowAll}];
            }
            if (param1.length <= 0)
            {
                return _loc_3;
            }
            var _loc_4:* = param1.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = param1[_loc_5];
                _loc_7 = {};
                _loc_7.id = _loc_6[0];
                _loc_7.name = _loc_6[1];
                _loc_3.push(_loc_7);
                _loc_5++;
            }
            return _loc_3;
        }// end function

        public function get checkIsCanChallenge() : Object
        {
            var _loc_1:* = _data.multiMission.checkIsCanChallenge;
            var _loc_2:Object = {};
            _loc_2.isCanChallenge = _loc_1[0];
            return _loc_2;
        }// end function

        public function get multiWarData() : MultiWarData
        {
            return this.ownData.multiWarData;
        }// end function

        public function get playerCdTime() : int
        {
            var _loc_1:* = _data.multiMission.playerCdTime;
            var _loc_2:* = _loc_1[0];
            return _loc_2;
        }// end function

    }
}
