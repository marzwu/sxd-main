package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.haloer.data.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;

    public class BeelzebubTrialsData extends Base
    {
        public var btBossInfo:BeelzebubTrialsBossInfo;
        public var bossList:Array;
        public var myTeamList:Array;
        public var roleList:Array;
        public var leaderId:int = 0;
        public var warData:Array;
        public var awardFame:int;
        public var awardFlag:int;
        public var awardCoin:int;
        public var warResult:int;
        public var equitData:Object;
        public var playerIdList:Array;
        public var exitFlag:int = 0;
        private var _beelzebubtrialsopentime:Array;
        private var _openbeelzebubtrials:Array;
        private var _beelzebubtrialsteamlist:Array;
        private var _playerteaminfo:Array;
        private var _createbeelzebubtrialsteam:Array;
        private var _dissolvebeelzebubtrialsteam:Array;
        private var _joinbeelzebubtrialsteam:Array;
        private var _exitteam:Array;
        private var _choosehelperrole:Array;
        private var _sortteam:Array;
        private var _kickedoutmember:Array;
        private var _closebeelzebubtrials:Array;
        private var _fightbeelzebubtrials:Array;
        private var _notify:Array;
        public var notifyHash:Object;
        private var _leavewar:Array;
        private var _notifynewteam:Array;
        private var _notifydropteam:Array;
        private var _notifyupdatemembernumber:Array;
        private var _checkiscanchallenge:Array;
        private var _getplayercdtime:Array;
        private var _moveto:Array;
        private var _canChallengeList:Array;
        public var notifyValue:int = 0;

        public function BeelzebubTrialsData()
        {
            var _loc_2:String = null;
            var _loc_3:Array = null;
            this.btBossInfo = new BeelzebubTrialsBossInfo();
            this.bossList = [];
            this.myTeamList = [];
            this.roleList = [];
            this.notifyHash = {};
            var _loc_1:* = BeelzeBubTrialsBossType.Bosses;
            for (_loc_2 in _loc_1)
            {
                
                _loc_3 = _loc_1[_loc_2];
                this.bossList[_loc_2] = new BeelzebubTrialsBossInfo();
                this.bossList[_loc_2].x = 995;
                this.bossList[_loc_2].y = 445;
                this.bossList[_loc_2].bossId = int(_loc_2);
                this.bossList[_loc_2].name = _loc_3[0];
                this.bossList[_loc_2].sign = _loc_3[1];
            }
            return;
        }// end function

        public function getPlayerTeamInfo(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Array = null;
            var _loc_6:Object = null;
            var _loc_7:Array = null;
            var _loc_8:Array = null;
            while (this.myTeamList.length > 0)
            {
                
                this.myTeamList.pop();
            }
            this.leaderId = param1[0];
            var _loc_2:* = param1[1];
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = 0;
                _loc_5 = _loc_2[_loc_3];
                _loc_6 = new Object();
                _loc_6.isMine = false;
                _loc_6.playerId = _loc_5[_loc_4++];
                if (_data.player.playerId == _loc_6.playerId)
                {
                    _loc_6.isMine = true;
                }
                _loc_6.myTeam = false;
                if (_data.player.playerId == this.leaderId)
                {
                    _loc_6.myTeam = true;
                }
                _loc_6.playerName = _loc_5[_loc_4++];
                _loc_6.playerSign = _loc_5[_loc_4++];
                _loc_6.headUrl = URI.iconsMiniUrl + _loc_6.playerSign + ".png";
                _loc_6.lv = _loc_5[_loc_4++];
                _loc_6.petLv = _loc_5[_loc_4++];
                _loc_6.petStage = _loc_5[_loc_4++];
                if (_loc_6.petLv == 0)
                {
                    _loc_6.petInfo = "";
                }
                else
                {
                    _loc_7 = ["", BeelzebubTrialsDataLang.Jie1, BeelzebubTrialsDataLang.Jie2, BeelzebubTrialsDataLang.Jie3, BeelzebubTrialsDataLang.Jie4, BeelzebubTrialsDataLang.Jie5, BeelzebubTrialsDataLang.Jie6, BeelzebubTrialsDataLang.Jie7, BeelzebubTrialsDataLang.Jie8, BeelzebubTrialsDataLang.Jie9, BeelzebubTrialsDataLang.Jie10];
                    _loc_8 = ["", BeelzebubTrialsDataLang.Bian1, BeelzebubTrialsDataLang.Bian2, BeelzebubTrialsDataLang.Bian3, BeelzebubTrialsDataLang.Bian4, BeelzebubTrialsDataLang.Bian5, BeelzebubTrialsDataLang.Bian6, BeelzebubTrialsDataLang.Bian7, BeelzebubTrialsDataLang.Bian8, BeelzebubTrialsDataLang.Bian9];
                    if (_loc_6.petLv == 1)
                    {
                        _loc_6.petInfo = "<font color=\'#" + PetType.getColor(_loc_6.petLv).toString(16) + "\'>" + _loc_7[_loc_6.petStage] + PetType.getName(_loc_6.petLv) + "</font>";
                    }
                    else
                    {
                        _loc_6.petInfo = "<font color=\'#" + PetType.getColor(_loc_6.petLv).toString(16) + "\'>" + _loc_7[_loc_6.petStage] + PetType.getName(_loc_6.petLv) + " (" + _loc_8[(_loc_6.petLv - 1)] + ")</font>";
                    }
                }
                _loc_6.roleId = _loc_5[_loc_4++];
                _loc_6.roleName = _loc_5[_loc_4++];
                _loc_6.isLeader = false;
                if (_loc_6.playerId == this.leaderId)
                {
                    _loc_6.isLeader = true;
                    this.myTeamList.unshift(_loc_6);
                }
                else
                {
                    this.myTeamList.push(_loc_6);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function getHelperRoleList(param1:Array) : void
        {
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            while (this.roleList.length > 0)
            {
                
                this.roleList.pop();
            }
            var _loc_2:* = param1[0];
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                _loc_5 = 0;
                _loc_6 = new Object();
                _loc_6.roleId = _loc_4[_loc_5++];
                _loc_6.name = _loc_4[_loc_5++];
                _loc_6.lv = _loc_4[_loc_5++];
                _loc_6.jobId = _loc_4[_loc_5++];
                _loc_6.sign = RoleType.getRoleSign(_loc_6.roleId);
                _loc_6.headUrl = URI.iconsUrl + _loc_6.sign + ".png";
                _loc_6.inBody = _loc_4[_loc_5++] == Mod_BeelzebubTrials_Base.DEPLOY;
                this.roleList.push(_loc_6);
                _loc_3++;
            }
            return;
        }// end function

        public function exitTeam(param1:Array) : void
        {
            this.exitFlag = param1[0];
            return;
        }// end function

        public function kicked_out_member(param1:Array) : void
        {
            return;
        }// end function

        public function chooseelperRole(param1:Array) : void
        {
            return;
        }// end function

        public function sortBeelzebubTrialsTeam(param1:Array) : void
        {
            return;
        }// end function

        public function fightBeelzebubTrials(param1:Array) : void
        {
            this.warResult = param1[0];
            return;
        }// end function

        public function get openTime() : Object
        {
            var _loc_1:Object = {};
            _loc_1.state = this._beelzebubtrialsopentime[0];
            _loc_1.openTime = this.renderOpenTime(this._beelzebubtrialsopentime[1]);
            return _loc_1;
        }// end function

        private function renderOpenTime(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = {};
                _loc_5.startTime = param1[_loc_4][0];
                _loc_5.endTime = param1[_loc_4][1];
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function get teamList() : Array
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            var _loc_1:* = new Array();
            if (this._openbeelzebubtrials[0] != null)
            {
                for each (_loc_2 in this._openbeelzebubtrials[0])
                {
                    
                    if (_loc_2.length != 0)
                    {
                        _loc_3 = this.addObject(_loc_2);
                        _loc_1.push(_loc_3);
                    }
                }
            }
            else
            {
                return null;
            }
            return _loc_1;
        }// end function

        private function addObject(param1:Array) : Object
        {
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["team_id", "multiple_mission_id", "leader_nickname", "team_member_number", "limit_condition", "condition_name", "is_can_join", "leader_camp_id", "leader_faction_name", "team_create_time", "leader_faction_id"]);
            _loc_2["team_member_number"] = parseInt(_loc_2["team_member_number"]);
            _loc_2["is_can_join"] = parseInt(_loc_2["is_can_join"]);
            _loc_2["leader_camp_id"] = parseInt(_loc_2["leader_camp_id"]);
            _loc_2["mission_name"] = BeelzeBubTrialsBossType.Bosses[_loc_2["multiple_mission_id"]][0];
            _loc_2["member_num"] = BeelzebubTrialsDataLang.Person + " " + _loc_2["team_member_number"] + "/3";
            _loc_2["leadername"] = BeelzebubTrialsDataLang.Leader + " " + _loc_2["leader_nickname"];
            return _loc_2;
        }// end function

        public function get createBeelzebubList() : Array
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            var _loc_1:* = new Array();
            if (this._openbeelzebubtrials[1].length > 0)
            {
                for each (_loc_2 in this._openbeelzebubtrials[1])
                {
                    
                    _loc_3 = {};
                    oObject.list(_loc_2, _loc_3, ["beelzebub_trials_id", "beelzebub_trials_name"]);
                    _loc_3.level = BeelzeBubTrialsBossType.getBossLvById(_loc_3["beelzebub_trials_id"]) + BeelzebubTrialsDataLang.Level;
                    _loc_1.push(_loc_3);
                }
            }
            else
            {
                return null;
            }
            return _loc_1;
        }// end function

        public function get joinBeelzebubList() : Array
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            var _loc_4:Object = null;
            var _loc_1:* = new Array();
            if (this._openbeelzebubtrials[2].length > 0)
            {
                for each (_loc_2 in this._openbeelzebubtrials[2])
                {
                    
                    _loc_4 = {};
                    oObject.list(_loc_2, _loc_4, ["beelzebub_trials_id", "beelzebub_trials_name"]);
                    _loc_4.level = BeelzeBubTrialsBossType.getBossLvById(_loc_4["beelzebub_trials_id"]) + BeelzebubTrialsDataLang.Level;
                    _loc_1.push(_loc_4);
                }
                _loc_3 = {beelzebub_trials_id:0, beelzebub_trials_name:BeelzebubTrialsDataLang.ShowAll, level:""};
                _loc_1.unshift(_loc_3);
            }
            else
            {
                return null;
            }
            return _loc_1;
        }// end function

        public function get leaderFactionId() : int
        {
            return this._openbeelzebubtrials[3];
        }// end function

        public function get getteamList() : Array
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            var _loc_1:* = new Array();
            if (this._beelzebubtrialsteamlist[0].length > 0)
            {
                for each (_loc_2 in this._beelzebubtrialsteamlist[0])
                {
                    
                    _loc_3 = this.addObject(_loc_2);
                    _loc_1.push(_loc_3);
                }
            }
            else
            {
                return null;
            }
            return _loc_1;
        }// end function

        public function get chanchallengetimes() : Object
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_1:* = new Array();
            var _loc_2:Object = {};
            for each (_loc_3 in this._openbeelzebubtrials[4])
            {
                
                _loc_4 = _loc_3[0];
                _loc_5 = _loc_3[1];
                _loc_2[_loc_4] = _loc_5;
            }
            return _loc_2;
        }// end function

        public function get teaminfo() : Array
        {
            var _loc_3:Array = null;
            var _loc_1:* = new Array();
            var _loc_2:Object = {team_leader_player_id:this._playerteaminfo[0]};
            for each (_loc_3 in this._playerteaminfo[1])
            {
                
                oObject.list(_loc_3, _loc_2, ["player_id", "player_nick_name", "main_role_sign", "main_role_level", "pet_level", "pet_stage", "help_role_id", "help_role_name"]);
                _loc_1.push(_loc_2);
            }
            return _loc_1;
        }// end function

        public function get createteamResult() : int
        {
            return int(this._createbeelzebubtrialsteam[0]);
        }// end function

        public function get joinTeamResult() : int
        {
            return int(this._joinbeelzebubtrialsteam[0]);
        }// end function

        public function get fight() : int
        {
            return int(this._fightbeelzebubtrials[0]);
        }// end function

        public function get notifynewteam() : Array
        {
            if (this._notifynewteam == null)
            {
                return null;
            }
            var _loc_1:* = this.addObject(this._notifynewteam);
            var _loc_2:* = new Array();
            _loc_2.push(_loc_1);
            return _loc_2;
        }// end function

        public function get notifydropteam() : int
        {
            return int(this._notifydropteam[0]);
        }// end function

        public function get updatemembernumber() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.team_id = this._notifyupdatemembernumber[0];
            _loc_1.member_number = this._notifyupdatemembernumber[1];
            return _loc_1;
        }// end function

        public function get checkiscanchallenge() : int
        {
            return int(this._checkiscanchallenge[0]);
        }// end function

        public function get getplayercdtime() : int
        {
            return int(this._getplayercdtime[0]);
        }// end function

        public function get moveto() : Object
        {
            var _loc_1:* = new Object();
            oObject.list(this._moveto, _loc_1, ["player_id", "from_x", "from_y", "to_x", "to_y"]);
            return _loc_1;
        }// end function

        public function get canChallengeList() : Array
        {
            return this._canChallengeList;
        }// end function

        public function get_beelzebub_trials_open_time(param1:Array) : void
        {
            this._beelzebubtrialsopentime = param1;
            return;
        }// end function

        public function open_beelzebub_trials(param1:Array) : void
        {
            this._openbeelzebubtrials = param1;
            return;
        }// end function

        public function get_beelzebub_trials_team_list(param1:Array) : void
        {
            this._beelzebubtrialsteamlist = param1;
            return;
        }// end function

        public function get_player_team_info(param1:Array) : void
        {
            this._playerteaminfo = param1;
            return;
        }// end function

        public function create_beelzebub_trials_team(param1:Array) : void
        {
            this._createbeelzebubtrialsteam = param1;
            return;
        }// end function

        public function join_beelzebub_trials_team(param1:Array) : void
        {
            this._joinbeelzebubtrialsteam = param1;
            return;
        }// end function

        public function choose_helper_role(param1:Array) : void
        {
            this._choosehelperrole = param1;
            return;
        }// end function

        public function fight_beelzebub_trials(param1:Array) : void
        {
            this._fightbeelzebubtrials = param1;
            return;
        }// end function

        public function get_war_result(param1:Array) : void
        {
            this.warResult = param1[0];
            this.warData = param1[3][0];
            this.awardFlag = param1[4];
            this.awardFame = param1[5];
            this.awardCoin = param1[6];
            var _loc_2:* = param1[7];
            var _loc_3:Object = {};
            this.equitData = this.renderEquitList(param1[7]);
            return;
        }// end function

        private function renderEquitList(param1:Array) : Object
        {
            var _loc_5:Object = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:String = null;
            var _loc_2:Object = {};
            this.playerIdList = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_6 = param1[_loc_4][0];
                _loc_7 = param1[_loc_4][1];
                _loc_8 = param1[_loc_4][2];
                _loc_9 = param1[_loc_4][3] || "";
                _loc_5.equitItemId = _loc_8;
                _loc_5.nickName = _loc_9;
                _loc_2[_loc_7] = _loc_5;
                this.playerIdList.push(_loc_6);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function notify(param1:Array) : void
        {
            this.notifyValue = param1[0];
            return;
        }// end function

        public function notify_new_team(param1:Array) : void
        {
            this._notifynewteam = param1;
            return;
        }// end function

        public function notify_drop_team(param1:Array) : void
        {
            this._notifydropteam = param1;
            return;
        }// end function

        public function notify_update_member_number(param1:Array) : void
        {
            this._notifyupdatemembernumber = param1;
            return;
        }// end function

        public function check_is_can_challenge(param1:Array) : void
        {
            this._checkiscanchallenge = param1;
            return;
        }// end function

        public function get_player_cd_time(param1:Array) : void
        {
            this._getplayercdtime = param1;
            return;
        }// end function

        public function get_player_can_challenge_list(param1:Array) : void
        {
            this._canChallengeList = param1[0] as Array;
            return;
        }// end function

    }
}
