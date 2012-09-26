package com.datas
{
    import com.assist.data.mission.*;

    public class MultiMissionData extends Base
    {
        private var _openMission:Array;
        private var _getTeamList:Array;
        private var _getTeamInfo:Array;
        private var _createTeam:int;
        private var _dissolveTeam:Array;
        private var _joinTeam:int;
        private var _exitTeam:Array;
        private var _sortTeam:String;
        private var _kickedOutMember:int;
        private var _closeMission:Object;
        private var _startWar:Array;
        public var notifyHash:Object;
        private var _multiWarData:MultiWarData;
        private var _getStatus:Array;
        private var _newTeam:Array;
        private var _dropTeam:Array;
        private var _updateMemberNumber:Array;
        private var _checkIsCanChallenge:Array;
        private var _playerCdTime:Array;
        public var RandomJoin:Array;

        public function MultiMissionData()
        {
            this.notifyHash = {};
            this.RandomJoin = [];
            return;
        }// end function

        public function get openMission() : Array
        {
            return this._openMission;
        }// end function

        public function get getTeamList() : Array
        {
            return this._getTeamList;
        }// end function

        public function get getTeamInfo() : Array
        {
            return this._getTeamInfo;
        }// end function

        public function get createTeam() : int
        {
            return this._createTeam;
        }// end function

        public function get dissolveTeam() : Array
        {
            return this._dissolveTeam;
        }// end function

        public function get joinTeam() : int
        {
            return this._joinTeam;
        }// end function

        public function get exitTeam() : Array
        {
            return this._exitTeam;
        }// end function

        public function get sortTeam() : String
        {
            return this._sortTeam;
        }// end function

        public function get kickedOutMember() : int
        {
            return this._kickedOutMember;
        }// end function

        public function get closeMission() : Object
        {
            return this._closeMission;
        }// end function

        public function get startWar() : Array
        {
            return this._startWar;
        }// end function

        public function get multiWarData() : MultiWarData
        {
            return this._multiWarData;
        }// end function

        public function get getStatus() : Array
        {
            return this._getStatus;
        }// end function

        public function get newTeam() : Array
        {
            return this._newTeam;
        }// end function

        public function get dropTeam() : Array
        {
            return this._dropTeam;
        }// end function

        public function get updateMemberNumber() : Array
        {
            return this._updateMemberNumber;
        }// end function

        public function get checkIsCanChallenge() : Array
        {
            return this._checkIsCanChallenge;
        }// end function

        public function get playerCdTime() : Array
        {
            return this._playerCdTime;
        }// end function

        public function open_multiple_mission(param1:Array) : void
        {
            this._openMission = param1;
            return;
        }// end function

        public function get_multiple_mission_team_list(param1:Array) : void
        {
            this._getTeamList = param1;
            return;
        }// end function

        public function get_player_team_info(param1:Array) : void
        {
            this._getTeamInfo = param1;
            return;
        }// end function

        public function create_multiple_mission_team(param1:int) : void
        {
            this._createTeam = param1;
            return;
        }// end function

        public function dissolve_multiple_mission_team(param1:Array) : void
        {
            this._dissolveTeam = param1;
            return;
        }// end function

        public function join_multiple_mission_team(param1:int) : void
        {
            this._joinTeam = param1;
            return;
        }// end function

        public function exit_multiple_mission_team(param1:Array) : void
        {
            this._exitTeam = param1;
            return;
        }// end function

        public function kicked_out_member(param1:int) : void
        {
            this._kickedOutMember = param1;
            return;
        }// end function

        public function sort_multiple_mission_team(param1:String) : void
        {
            this._sortTeam = param1;
            return;
        }// end function

        public function close_multiple_mission(param1:Object) : void
        {
            this._closeMission = param1;
            return;
        }// end function

        public function fight_multiple_mission(param1:Array) : void
        {
            this._startWar = param1;
            return;
        }// end function

        public function get_war_result(param1:Array) : void
        {
            this._multiWarData = new MultiWarData();
            this._multiWarData.format(param1);
            return;
        }// end function

        public function notify(param1:Array) : void
        {
            var _loc_2:* = param1[0].length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.notifyHash[param1[0][_loc_3]] = 1;
                _loc_3++;
            }
            return;
        }// end function

        public function get_multiple_mission_status(param1:Array) : void
        {
            this._getStatus = param1;
            return;
        }// end function

        public function notify_new_team(param1:Array) : void
        {
            this._newTeam = param1;
            return;
        }// end function

        public function notify_drop_team(param1:Array) : void
        {
            this._dropTeam = param1;
            return;
        }// end function

        public function notify_update_member_number(param1:Array) : void
        {
            this._updateMemberNumber = param1;
            return;
        }// end function

        public function check_is_can_challenge(param1:Array) : void
        {
            this._checkIsCanChallenge = param1;
            return;
        }// end function

        public function get_player_cd_time(param1:Array) : void
        {
            this._playerCdTime = param1;
            return;
        }// end function

        public function random_join(param1:Array) : void
        {
            this.RandomJoin = param1;
            return;
        }// end function

    }
}
