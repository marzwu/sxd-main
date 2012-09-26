package com.controllers
{
    import com.assist.data.mission.*;
    import com.assist.server.*;

    public class NineRegionsController extends Base
    {
        public var bOpenNineRegions:Boolean = false;

        public function NineRegionsController()
        {
            return;
        }// end function

        public function get isFrist() : Boolean
        {
            return _data.nineRegions.nineRegionsInfo.isFrist;
        }// end function

        public function get curJie() : int
        {
            return _data.nineRegions.nineRegionsInfo.curJie;
        }// end function

        public function get curLevel() : int
        {
            return _data.nineRegions.nineRegionsInfo.curLevel;
        }// end function

        public function get warObj() : Object
        {
            return _data.nineRegions.warObj;
        }// end function

        public function get warData() : WarData
        {
            var _loc_1:* = new WarData();
            _loc_1.format([0, 0, 0, [_data.nineRegions.warData]]);
            return _loc_1;
        }// end function

        public function get equitData() : Object
        {
            return _data.nineRegions.equitData;
        }// end function

        public function get warResult() : int
        {
            return _data.nineRegions.warResult;
        }// end function

        public function get result() : int
        {
            return _data.nineRegions.result;
        }// end function

        public function get teamList() : Array
        {
            return _data.nineRegions.teamList;
        }// end function

        public function get playerIdList() : Array
        {
            return _data.nineRegions.playerIdList;
        }// end function

        public function get delTeamId() : int
        {
            return _data.nineRegions.delTeamId;
        }// end function

        public function get changeMemberObj() : Object
        {
            return _data.nineRegions.changeMemberObj;
        }// end function

        public function get newTeam() : Object
        {
            return _data.nineRegions.newTeam;
        }// end function

        public function get myTeamList() : Array
        {
            return _data.nineRegions.myTeamList;
        }// end function

        public function get myRoleList() : Array
        {
            return _data.nineRegions.roleList;
        }// end function

        public function get leaderId() : int
        {
            return _data.nineRegions.leaderId;
        }// end function

        public function get notifyValue() : int
        {
            return _data.nineRegions.notifyValue;
        }// end function

        public function get canWar() : Boolean
        {
            return this.myTeamList.length == 3;
        }// end function

        public function get exitFlag() : int
        {
            return _data.nineRegions.exitFlag;
        }// end function

        public function get myTeamId() : int
        {
            return _data.nineRegions.myTeamId;
        }// end function

        public function isCanJoin(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = this.curJie;
            var _loc_4:* = this.curLevel;
            if (this.curLevel == NineRegionsType.MaxLevel)
            {
                _loc_3++;
                _loc_4 = 0;
            }
            if (_loc_3 == 0)
            {
                _loc_3 = 1;
                _loc_4 = 0;
            }
            _loc_4++;
            if (_loc_3 * 10 + _loc_4 < param1 * 10 + param2)
            {
                return false;
            }
            return true;
        }// end function

        public function get hiddenLevel() : int
        {
            return _data.nineRegions.hiddenLevel;
        }// end function

        public function get hiddenWarResult() : int
        {
            return _data.nineRegions.hiddenWarResult;
        }// end function

        public function get hiddenWarData() : WarData
        {
            var _loc_1:* = new WarData();
            _loc_1.format([0, 0, 0, [_data.nineRegions.hiddenWarData]]);
            return _loc_1;
        }// end function

    }
}
