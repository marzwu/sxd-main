package com.controllers
{
    import com.assist.server.*;

    public class FurnaceController extends Base
    {

        public function FurnaceController()
        {
            return;
        }// end function

        public function get curRoleList() : Array
        {
            return _data.furnaceMap.furnaceInfo.curRoleList;
        }// end function

        public function get makeResult() : Array
        {
            return _data.furnaceMap.furnaceInfo.makeResult;
        }// end function

        public function get exp() : int
        {
            return _data.furnaceMap.furnaceInfo.exp;
        }// end function

        public function get opRoleId() : int
        {
            return _data.furnaceMap.furnaceInfo.opRoleId;
        }// end function

        public function get result() : int
        {
            return _data.furnaceMap.furnaceInfo.result;
        }// end function

        public function get iInfoArr() : Array
        {
            return _data.furnaceMap.furnaceInfo.iInfoArr;
        }// end function

        public function levelRole(param1:int) : Object
        {
            return _data.furnaceMap.furnaceInfo.levelRole(param1);
        }// end function

        public function getInfoByRoleId(param1:int) : Object
        {
            return _data.furnaceMap.furnaceInfo.getInfoByRoleId(param1);
        }// end function

        public function get curPurpleList() : Array
        {
            return _data.furnaceMap.furnaceInfo.curPurpleList;
        }// end function

        public function isCanShow(param1:int) : Boolean
        {
            if (RoleType.getRoleType(param1) == 0)
            {
                return true;
            }
            var _loc_2:int = 0;
            while (_loc_2 < this.curPurpleList.length)
            {
                
                if (this.curPurpleList[_loc_2].roleId == param1)
                {
                    return true;
                }
                _loc_2++;
            }
            return false;
        }// end function

    }
}
