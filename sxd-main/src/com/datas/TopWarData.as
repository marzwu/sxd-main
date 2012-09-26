package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.haloer.data.*;
    import com.protocols.*;

    public class TopWarData extends Base
    {
        public var notifyValue:int;
        public var myTeamList:Array;
        public var leaderId:int = 0;
        public var roleList:Array;
        public var changeRoleResult:int = 0;
        public var deployList:Array;
        public var firstAttack:int = 0;
        public var changeDeployResult:int;
        public var otherTeamList:Array;
        public var warData:Object;
        public var warCoin:int = 0;
        public var warFame:int = 0;
        public var awardScore:int = 0;
        public var awardWinScore:int = 0;
        public var playerIdList:Array;
        public var equitData:Object;
        public var isWin:Boolean;
        public var exitResult:int = 0;
        public var getTopWarState:Array;
        private var _openAry:Array;
        private var _createAry:Array;
        private var _joinAry:Array;
        private var _newTeamAry:Array;
        private var _dropTeamAry:Array;
        private var _updateTeamAry:Array;
        private var _scoreListAry:Array;

        public function TopWarData()
        {
            this.myTeamList = [];
            this.roleList = [];
            this.deployList = [];
            this.otherTeamList = [];
            this.warData = [];
            this.getTopWarState = [];
            return;
        }// end function

        public function notify(param1:Array) : void
        {
            this.notifyValue = param1[0];
            return;
        }// end function

        public function kicked_out_member(param1:Array) : void
        {
            return;
        }// end function

        public function get_player_team_info(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            while (this.myTeamList.length > 0)
            {
                
                this.myTeamList.pop();
            }
            this.leaderId = param1[0];
            var _loc_2:int = 0;
            while (_loc_2 < param1[1].length)
            {
                
                _loc_3 = param1[1][_loc_2];
                _loc_4 = 0;
                _loc_5 = new Object();
                _loc_5.isLeader = false;
                _loc_5.isMine = false;
                _loc_5.playerId = _loc_3[_loc_4++];
                if (_data.player.playerId == _loc_5.playerId)
                {
                    _loc_5.isMine = true;
                }
                _loc_5.myTeam = false;
                if (_data.player.playerId == this.leaderId)
                {
                    _loc_5.myTeam = true;
                }
                _loc_5.playerName = _loc_3[_loc_4++];
                _loc_5.lv = _loc_3[_loc_4++];
                _loc_5.playerSign = RoleType.getRoleSign(_loc_3[_loc_4++]);
                _loc_5.headUrl = URI.iconsMiniUrl + _loc_5.playerSign + ".png";
                _loc_5.roleId = _loc_3[_loc_4++];
                _loc_5.roleName = RoleType.getRoleName(_loc_5.roleId);
                _loc_5.eqId = _loc_3[_loc_4++];
                _loc_5.sign = _loc_5.playerSign + ItemType.getItemSuffix(_loc_5.eqId);
                if (this.leaderId == _loc_5.playerId)
                {
                    this.myTeamList.unshift(_loc_5);
                    _loc_5.isLeader = true;
                }
                else
                {
                    this.myTeamList.push(_loc_5);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function getPlayerNameById(param1:int) : String
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.myTeamList.length)
            {
                
                if (this.myTeamList[_loc_2].playerId == param1)
                {
                    return this.myTeamList[_loc_2].playerName;
                }
                _loc_2++;
            }
            return "";
        }// end function

        public function helper_role_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            while (this.roleList.length > 0)
            {
                
                this.roleList.pop();
            }
            var _loc_2:int = 0;
            while (_loc_2 < param1[0].length)
            {
                
                _loc_3 = param1[0][_loc_2];
                _loc_4 = 0;
                _loc_5 = new Object();
                _loc_5.playerRoleId = _loc_3[_loc_4++];
                _loc_5.roleId = _loc_3[_loc_4++];
                _loc_5.name = RoleType.getRoleName(_loc_5.roleId);
                _loc_5.sign = RoleType.getRoleSign(_loc_5.roleId);
                _loc_5.headUrl = URI.iconsUrl + _loc_5.sign + ".png";
                _loc_5.jobId = RoleType.getJobIdByRoleId(_loc_5.roleId);
                _loc_5.lv = _loc_3[_loc_4++];
                _loc_5.inBody = _loc_3[_loc_4++] == Mod_TopWar_Base.DEPLOY;
                this.roleList.push(_loc_5);
                _loc_2++;
            }
            return;
        }// end function

        public function choose_helper_role(param1:Array) : void
        {
            this.changeRoleResult = param1[0];
            return;
        }// end function

        public function deploy_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_6:String = null;
            this.deployList.length = 0;
            this.firstAttack = param1[0];
            var _loc_2:int = 0;
            while (_loc_2 < param1[1].length)
            {
                
                _loc_3 = param1[1][_loc_2];
                _loc_4 = 0;
                _loc_5 = new Object();
                _loc_5.playerId = _loc_3[_loc_4++];
                _loc_5.playerRoleId = _loc_3[_loc_4++];
                _loc_5.roleId = _loc_3[_loc_4++];
                _loc_5.position = _loc_3[_loc_4++];
                _loc_6 = RoleType.getRoleSign(_loc_5.roleId);
                _loc_5.iconUrl = URI.iconsUrl + _loc_6 + ".png";
                if (RoleType.isMainRole(_loc_6))
                {
                    _loc_5.name = this.getPlayerNameById(_loc_5.playerId);
                }
                else
                {
                    _loc_5.name = this.getPlayerNameById(_loc_5.playerId) + "." + RoleType.getRoleName(_loc_5.roleId);
                }
                this.deployList.push(_loc_5);
                _loc_2++;
            }
            return;
        }// end function

        public function change_position(param1:Array) : void
        {
            this.changeDeployResult = param1[0];
            return;
        }// end function

        public function match(param1:Array) : void
        {
            return;
        }// end function

        public function get_war_result(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            this.playerIdList = [];
            while (this.otherTeamList.length > 0)
            {
                
                this.otherTeamList.pop();
            }
            this.isWin = param1[0] == 1;
            var _loc_2:int = 0;
            while (_loc_2 < param1[1].length)
            {
                
                _loc_3 = param1[1][_loc_2];
                _loc_4 = 0;
                _loc_5 = new Object();
                _loc_5.isMine = false;
                _loc_5.playerId = _loc_3[_loc_4++];
                if (_data.player.playerId == _loc_5.playerId)
                {
                    _loc_5.isMine = true;
                }
                _loc_5.playerName = _loc_3[_loc_4++];
                _loc_5.lv = _loc_3[_loc_4++];
                _loc_5.playerSign = RoleType.getRoleSign(_loc_3[_loc_4++]);
                _loc_5.headUrl = URI.iconsMiniUrl + _loc_5.playerSign + ".png";
                _loc_5.roleId = _loc_3[_loc_4++];
                _loc_5.roleName = RoleType.getRoleName(_loc_5.roleId);
                _loc_5.eqId = _loc_3[_loc_4++];
                _loc_5.sign = _loc_5.playerSign + ItemType.getItemSuffix(_loc_5.eqId);
                _loc_5.playerMainRoleId = _loc_3[_loc_4++];
                _loc_5.isLeader = _loc_3[_loc_4++] == 1;
                _loc_5.fullHeadUrl = URI.iconsUrl + _loc_5.playerSign + ".png";
                if (_loc_5.isLeader)
                {
                    this.leaderId = _loc_5.playerId;
                    this.otherTeamList.unshift(_loc_5);
                }
                else
                {
                    this.otherTeamList.push(_loc_5);
                }
                _loc_2++;
            }
            this.equitData = {};
            this.playerIdList = [];
            this.renderEquit(param1[1]);
            this.renderEquit(param1[2]);
            this.warData = param1[3][0];
            this.warCoin = param1[4];
            this.warFame = param1[5];
            this.awardScore = param1[6];
            this.awardWinScore = param1[7];
            return;
        }// end function

        private function renderEquit(param1:Array) : void
        {
            var _loc_4:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = {};
                _loc_4.playerId = param1[_loc_3][0];
                _loc_4.nickName = param1[_loc_3][1];
                _loc_4.level = param1[_loc_3][2];
                _loc_4.mainRoleId = param1[_loc_3][3];
                _loc_4.helpRoleId = param1[_loc_3][4];
                _loc_4.equitItemId = param1[_loc_3][5];
                _loc_4.playerMainRoleId = param1[_loc_3][6];
                this.equitData[_loc_4.playerMainRoleId] = _loc_4;
                this.playerIdList.push(_loc_4.playerId);
                _loc_3++;
            }
            return;
        }// end function

        public function exit_team(param1:Array) : void
        {
            this.exitResult = param1[0];
            return;
        }// end function

        public function get_top_war_state(param1:Array) : void
        {
            this.getTopWarState = param1;
            return;
        }// end function

        public function get myScore() : int
        {
            return this._openAry[0];
        }// end function

        public function get teamList() : Array
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            var _loc_1:* = new Array();
            for each (_loc_2 in this._openAry[1])
            {
                
                _loc_3 = this.teamInfo(_loc_2);
                _loc_1.push(_loc_3);
            }
            return _loc_1;
        }// end function

        public function get timesIsUse() : Boolean
        {
            var _loc_1:Boolean = false;
            if (this._openAry[2] == Mod_TopWar_Base.YES)
            {
                _loc_1 = true;
            }
            else if (this._openAry[2] == Mod_TopWar_Base.NO)
            {
                _loc_1 = false;
            }
            return _loc_1;
        }// end function

        public function get isCreate() : int
        {
            return this._createAry[0];
        }// end function

        public function get isJoin() : int
        {
            return this._joinAry[0];
        }// end function

        public function get newTeam() : Object
        {
            var _loc_1:* = this.teamInfo(this._newTeamAry);
            return _loc_1;
        }// end function

        public function get dropTeam() : int
        {
            return this._dropTeamAry[0];
        }// end function

        public function get updateTeam() : Object
        {
            var _loc_1:Object = {};
            _loc_1.team_id = this._updateTeamAry[0];
            _loc_1.member_number = this._updateTeamAry[1];
            return _loc_1;
        }// end function

        private function teamInfo(param1:Array) : Object
        {
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["team_id", "leader_main_role_id", "leader_nickname", "leader_level", "team_member_number", "team_max_memebr_number", "team_create_time"]);
            _loc_2.sign = RoleType.getRoleSign(_loc_2["leader_main_role_id"]);
            return _loc_2;
        }// end function

        public function get scoreListAry() : Array
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            var _loc_1:* = new Array();
            for each (_loc_2 in this._scoreListAry[0])
            {
                
                _loc_3 = {};
                oObject.list(_loc_2, _loc_3, ["now_rank", "nickname", "role_id", "score", "prev_rank", "player_id", "level"]);
                _loc_3.sex = RoleType.getRoleGender(_loc_3["role_id"]);
                if (_loc_3.now_rank < _loc_3.prev_rank)
                {
                    _loc_3.isUp = "up";
                }
                else if (_loc_3.now_rank == _loc_3.prev_rank)
                {
                    _loc_3.isUp = "normal";
                }
                else if (_loc_3.prev_rank != 0)
                {
                    _loc_3.isUp = "down";
                }
                else
                {
                    _loc_3.isUp = "up";
                }
                _loc_1.push(_loc_3);
            }
            return _loc_1;
        }// end function

        public function open_top_war(param1:Array) : void
        {
            this._openAry = param1;
            return;
        }// end function

        public function create_team(param1:Array) : void
        {
            this._createAry = param1;
            return;
        }// end function

        public function join_team(param1:Array) : void
        {
            this._joinAry = param1;
            return;
        }// end function

        public function score_rank(param1:Array) : void
        {
            this._scoreListAry = param1;
            return;
        }// end function

        public function notify_new_team(param1:Array) : void
        {
            this._newTeamAry = param1;
            return;
        }// end function

        public function notify_drop_team(param1:Array) : void
        {
            this._dropTeamAry = param1;
            return;
        }// end function

        public function notify_update_team(param1:Array) : void
        {
            this._updateTeamAry = param1;
            return;
        }// end function

    }
}
