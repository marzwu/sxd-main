package com.controllers
{
    import com.assist.data.mission.*;
    import com.assist.view.info.*;

    public class TowerController extends Base
    {

        public function TowerController()
        {
            return;
        }// end function

        public function get towerInfo() : TowerInfo
        {
            return _data.tower.info;
        }// end function

        public function get warData() : WarData
        {
            return _data.tower.warData;
        }// end function

        public function get warSoulId() : int
        {
            return _data.tower.warSoulId;
        }// end function

        public function get warExp() : int
        {
            return _data.tower.warExp;
        }// end function

        public function get warFame() : int
        {
            return _data.tower.warFame;
        }// end function

        public function get warCoin() : int
        {
            return _data.tower.warCoin;
        }// end function

        public function get result() : int
        {
            return _data.tower.result;
        }// end function

        public function get isPass() : Boolean
        {
            return _data.tower.isPass;
        }// end function

        public function get warAura() : int
        {
            return _data.tower.warAura;
        }// end function

        public function get completeName() : String
        {
            return _data.tower.completeName;
        }// end function

    }
}
