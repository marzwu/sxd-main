package com.controllers
{

    public class NewTopWarController extends Base
    {

        public function NewTopWarController()
        {
            return;
        }// end function

        public function get result() : int
        {
            return _data.newTopWar.result;
        }// end function

        public function get myTeamObj() : Object
        {
            return _data.newTopWar.myTeamObj;
        }// end function

        public function get otherTeamObj() : Object
        {
            return _data.newTopWar.otherTeamObj;
        }// end function

        public function get requestList() : Array
        {
            return _data.newTopWar.requestList;
        }// end function

        public function get myRoleList() : Array
        {
            return _data.newTopWar.myRoleList;
        }// end function

        public function get deployList() : Array
        {
            return _data.newTopWar.deployList;
        }// end function

        public function get firstAttack() : int
        {
            return _data.newTopWar.firstAttack;
        }// end function

        public function get signState() : int
        {
            return _data.newTopWar.signState;
        }// end function

        public function get topWarStep() : int
        {
            return _data.newTopWar.topWarStep;
        }// end function

        public function get signList() : Array
        {
            return _data.newTopWar.signList;
        }// end function

        public function get otherTeamInfoObj() : Object
        {
            return _data.newTopWar.otherTeamInfoObj;
        }// end function

        public function set otherTeamInfoObj(param1:Object) : void
        {
            _data.newTopWar.otherTeamInfoObj = param1;
            return;
        }// end function

        public function get warList() : Array
        {
            return _data.newTopWar.warList;
        }// end function

        public function get rankList() : Array
        {
            return _data.newTopWar.rankList;
        }// end function

        public function get topThroneList() : Array
        {
            return _data.newTopWar.topThroneList;
        }// end function

        public function get searchTeamName() : String
        {
            return _data.newTopWar.searchTeamName;
        }// end function

        public function get searchLeaderName() : String
        {
            return _data.newTopWar.searchLeaderName;
        }// end function

    }
}
