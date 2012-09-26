package com.controllers
{
    import com.assist.data.mission.*;

    public class DuJieController extends Base
    {

        public function DuJieController()
        {
            return;
        }// end function

        public function get dujieState() : int
        {
            return _data.dujie.dujieState;
        }// end function

        public function get pointState() : int
        {
            return _data.dujie.pointState;
        }// end function

        public function get playerRoleId() : int
        {
            return _data.dujie.playerRoleId;
        }// end function

        public function get playerRoleLv() : int
        {
            return _data.dujie.playerRoleLv;
        }// end function

        public function get dujieName() : String
        {
            return _data.dujie.dujieName;
        }// end function

        public function get result() : int
        {
            return _data.dujie.result;
        }// end function

        public function get resultTip() : String
        {
            return _data.dujie.resultTip;
        }// end function

        public function get nowStateLevel() : int
        {
            return _data.dujie.nowStateLevel;
        }// end function

        public function get addLife() : String
        {
            return _data.dujie.addLife;
        }// end function

        public function get pointTip() : String
        {
            return _data.dujie.pointTip;
        }// end function

        public function get dujieTip() : String
        {
            return _data.dujie.dujieTip;
        }// end function

        public function get warData() : WarData
        {
            return _data.dujie.warData;
        }// end function

        public function get addHealth() : int
        {
            return _data.dujie.addHealth;
        }// end function

        public function get roleId() : int
        {
            return _data.dujie.roleId;
        }// end function

        public function get spiritStateId() : int
        {
            return _data.dujie.spiritStateId;
        }// end function

        public function get spiritStateLevel() : int
        {
            return _data.dujie.spiritStateLevel;
        }// end function

        public function get awardAura() : int
        {
            return _data.dujie.awardAura;
        }// end function

    }
}
