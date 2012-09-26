package com.controllers
{
    import com.assist.view.info.*;

    public class WorldFactionWarController extends Base
    {

        public function WorldFactionWarController()
        {
            return;
        }// end function

        public function get info() : WorldFactionWarInfo
        {
            return _data.worldFactionWar.info;
        }// end function

        public function get signUpType() : int
        {
            return _data.worldFactionWar.signUpType;
        }// end function

        public function get signUpList() : Array
        {
            return _data.worldFactionWar.signUpList;
        }// end function

        public function get result() : int
        {
            return _data.worldFactionWar.result;
        }// end function

        public function get myRank() : int
        {
            return _data.worldFactionWar.myRank;
        }// end function

        public function get dieOutTip() : String
        {
            return _data.worldFactionWar.dieOutTip;
        }// end function

        public function get dieOutWarList() : Array
        {
            return _data.worldFactionWar.dieOutWarList;
        }// end function

        public function get memberList() : Array
        {
            return _data.worldFactionWar.memberList;
        }// end function

        public function get betRank() : Array
        {
            return _data.worldFactionWar.betRank;
        }// end function

        public function get seeRecordList() : Array
        {
            return _data.worldFactionWar.seeRecordList;
        }// end function

        public function get recordList() : Array
        {
            return _data.worldFactionWar.recordList;
        }// end function

        public function get recordTip() : String
        {
            return _data.worldFactionWar.recordTip;
        }// end function

        public function get awardInfo() : Object
        {
            return _data.worldFactionWar.info.awardInfo;
        }// end function

        public function get receiveAwardInfo() : Object
        {
            return _data.worldFactionWar.info.receiveAwardInfo;
        }// end function

        public function get warData() : Array
        {
            return _data.worldFactionWar.warData;
        }// end function

    }
}
