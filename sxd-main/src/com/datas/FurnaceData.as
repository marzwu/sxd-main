package com.datas
{
    import com.assist.server.*;
    import com.assist.view.info.*;

    public class FurnaceData extends Base
    {
        public var furnaceInfo:FurnaceInfo;

        public function FurnaceData()
        {
            this.furnaceInfo = new FurnaceInfo();
            return;
        }// end function

        public function getRoles(param1:Array) : void
        {
            var _loc_7:String = null;
            var _loc_8:Array = null;
            var _loc_9:int = 0;
            var _loc_10:Object = null;
            var _loc_11:String = null;
            var _loc_12:Object = null;
            FurnaceType.clear();
            var _loc_2:* = param1[0];
            var _loc_3:* = FurnaceType.roleList.concat();
            var _loc_4:* = new Array();
            var _loc_5:* = _data.player.fame;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_3.length)
            {
                
                _loc_3[_loc_6].fame = RoleType.getRoleFame(_loc_3[_loc_6].roleId);
                if (_loc_3[_loc_6].fame >= _loc_5)
                {
                    _loc_3.splice(_loc_6, 1);
                    _loc_6 = _loc_6 - 1;
                }
                _loc_6++;
            }
            for (_loc_7 in _loc_2)
            {
                
                _loc_8 = _loc_2[_loc_7];
                _loc_9 = this.inList(_loc_3, _loc_8[0]);
                if (_loc_9 != -1)
                {
                    _loc_10 = _loc_3[_loc_9];
                }
                else
                {
                    _loc_10 = new Object();
                }
                _loc_10.roleId = _loc_8[0];
                _loc_10.sign = RoleType.getRoleSign(_loc_10.roleId);
                _loc_10.name = RoleType.getRoleName(_loc_10.roleId);
                _loc_10.have_amount = _loc_8[1];
                _loc_11 = FurnaceType.getChat(_loc_10.roleId, FurnaceType.COMMONFLAG);
                _loc_10.chatList = _loc_11.split("|");
                _loc_11 = FurnaceType.getChat(_loc_10.roleId, FurnaceType.LEVELFLAG);
                _loc_10.levelChat = _loc_11;
                _loc_10.inBody = _loc_8[2];
                _loc_10.isLvUp = _loc_8[3];
                _loc_10.wared = _loc_8[4] == 1;
                if (_loc_10.isLvUp == 1)
                {
                    _loc_10.canLevel = false;
                    _loc_12 = _loc_10.childObj;
                    _loc_12.itemId = _loc_10.itemId;
                    _loc_12.wared = _loc_10.wared;
                    _loc_4.push(_loc_12);
                }
                _loc_10.fame = RoleType.getRoleFame(_loc_10.roleId);
                if (_loc_9 == -1)
                {
                    _loc_3.push(_loc_10);
                }
            }
            this.furnaceInfo.curRoleList = _loc_3;
            this.furnaceInfo.curPurpleList = _loc_4;
            return;
        }// end function

        private function inList(param1:Array, param2:int) : int
        {
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param1[_loc_3].roleId == param2)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function makeFavorItem(param1:Array) : void
        {
            var _loc_5:String = null;
            var _loc_6:Array = null;
            var _loc_7:Object = null;
            var _loc_2:* = param1[0];
            this.furnaceInfo.result = _loc_2;
            var _loc_3:* = param1[1];
            var _loc_4:* = new Array();
            for (_loc_5 in _loc_3)
            {
                
                _loc_6 = _loc_3[_loc_5];
                _loc_7 = new Object();
                _loc_7.itemType = _loc_6[0];
                _loc_7.result_param = _loc_6[1];
                _loc_4.push(_loc_7);
            }
            this.furnaceInfo.makeResult = _loc_4;
            return;
        }// end function

        public function submitFavorItem(param1:Array) : void
        {
            this.furnaceInfo.result = param1[0];
            var _loc_2:* = param1[1];
            var _loc_3:* = param1[2];
            var _loc_4:* = FurnaceType.getRoleObjById(_loc_2);
            FurnaceType.getRoleObjById(_loc_2).have_amount = _loc_3;
            this.furnaceInfo.opRoleId = _loc_2;
            return;
        }// end function

        public function roleLevelUp(param1:Array) : void
        {
            var _loc_2:* = param1[0];
            this.furnaceInfo.opRoleId = param1[1];
            return;
        }// end function

        public function getlevelUpAward(param1:Array) : void
        {
            this.furnaceInfo.result = param1[0];
            this.furnaceInfo.opRoleId = param1[1];
            return;
        }// end function

    }
}
