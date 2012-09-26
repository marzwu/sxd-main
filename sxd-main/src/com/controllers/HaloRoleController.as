package com.controllers
{
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.protocols.*;

    public class HaloRoleController extends Base
    {

        public function HaloRoleController()
        {
            return;
        }// end function

        public function get getChallengeInfo() : Object
        {
            var _loc_1:* = _data.haloRole.getChallengeInfo;
            var _loc_2:Object = {};
            _loc_2.isOpen = _loc_1[0];
            _loc_2.roleId = _loc_1[1];
            _loc_2.openTime = _loc_1[2];
            var _loc_4:* = HaloRoleType.getLockByRoleId(_loc_2.roleId);
            _loc_2.buttleLock = HaloRoleType.getLockByRoleId(_loc_2.roleId);
            _loc_2.buttleType = _loc_4;
            _loc_2.rank = HaloRoleType.getRankByLock(_loc_2.buttleLock);
            var _loc_3:int = 0;
            switch(_loc_2.isOpen)
            {
                case Mod_HaloRole_Base.CLOSE:
                {
                    _loc_3 = 0;
                    break;
                }
                case Mod_HaloRole_Base.OPEN:
                {
                    _loc_3 = 1;
                    break;
                }
                case Mod_HaloRole_Base.COMPLETE_CHALLENGED:
                {
                    _loc_3 = 2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2.buttleType = _loc_3;
            return _loc_2;
        }// end function

        public function get warStatus() : int
        {
            return _data.haloRole.warStatus;
        }// end function

        public function get warData() : WarData
        {
            return _data.haloRole.warData;
        }// end function

        public function get isFirstChallenge() : Boolean
        {
            return _data.haloRole.isFirstChallenge;
        }// end function

        public function get aura() : uint
        {
            return _data.haloRole.aura;
        }// end function

    }
}
