package com.controllers
{
    import com.assist.data.mission.*;

    public class TopWarController extends Base
    {

        public function TopWarController()
        {
            return;
        }// end function

        public function get notifyValue() : int
        {
            return _data.topWar.notifyValue;
        }// end function

        public function get myTeamList() : Array
        {
            return _data.topWar.myTeamList;
        }// end function

        public function get otherTeamList() : Array
        {
            return _data.topWar.otherTeamList;
        }// end function

        public function get warData() : WarData
        {
            var _loc_1:* = new WarData();
            _loc_1.format([0, 0, 0, [_data.topWar.warData]]);
            return _loc_1;
        }// end function

        public function get equitData() : Object
        {
            return _data.topWar.equitData;
        }// end function

        public function get playerIdList() : Array
        {
            return _data.topWar.playerIdList;
        }// end function

        public function get leaderId() : int
        {
            return _data.topWar.leaderId;
        }// end function

        public function get warCoin() : int
        {
            return _data.topWar.warCoin;
        }// end function

        public function get warFame() : int
        {
            return _data.topWar.warFame;
        }// end function

        public function get awardScore() : int
        {
            return _data.topWar.awardScore;
        }// end function

        public function get awardWinScore() : int
        {
            return _data.topWar.awardWinScore;
        }// end function

        public function get canWar() : Boolean
        {
            return this.myTeamList.length == 3;
        }// end function

        public function get myRoleList() : Array
        {
            return _data.topWar.roleList;
        }// end function

        public function get changeRoleResult() : int
        {
            return _data.topWar.changeRoleResult;
        }// end function

        public function get firstAttack() : int
        {
            return _data.topWar.firstAttack;
        }// end function

        public function get deployList() : Array
        {
            return _data.topWar.deployList;
        }// end function

        public function get changeDeployResult() : int
        {
            return _data.topWar.changeDeployResult;
        }// end function

        public function get exitResult() : int
        {
            return _data.topWar.exitResult;
        }// end function

        public function get myScore() : int
        {
            return _data.topWar.myScore;
        }// end function

        public function get teamList() : Array
        {
            return _data.topWar.teamList;
        }// end function

        public function get timesIsUse() : Boolean
        {
            return _data.topWar.timesIsUse;
        }// end function

        public function get isCreate() : int
        {
            return _data.topWar.isCreate;
        }// end function

        public function get isJoin() : int
        {
            return _data.topWar.isJoin;
        }// end function

        public function get newTeam() : Object
        {
            return _data.topWar.newTeam;
        }// end function

        public function get dropTeam() : int
        {
            return _data.topWar.dropTeam;
        }// end function

        public function get updateTeam() : Object
        {
            return _data.topWar.updateTeam;
        }// end function

        public function get scoreList() : Array
        {
            return _data.topWar.scoreListAry;
        }// end function

        public function getTopWarState() : int
        {
            var _loc_1:* = _data.topWar.getTopWarState;
            return _loc_1[0];
        }// end function

    }
}
