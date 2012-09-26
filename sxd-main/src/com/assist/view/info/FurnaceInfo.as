package com.assist.view.info
{
    import com.assist.server.*;

    public class FurnaceInfo extends Object
    {
        private var _curRoleList:Array;
        private var _curPurpleList:Array;
        private var _stoveObj:Object;
        private var _makeResult:Array;
        public var opRoleId:int;
        public var exp:int;
        public var result:int;
        public var iInfoArr:Array;

        public function FurnaceInfo()
        {
            this.iInfoArr = new Array();
            return;
        }// end function

        public function set curRoleList(param1:Array) : void
        {
            this._curRoleList = param1;
            return;
        }// end function

        public function get curRoleList() : Array
        {
            if (this._curRoleList)
            {
                return this._curRoleList;
            }
            return new Array();
        }// end function

        public function set curPurpleList(param1:Array) : void
        {
            this._curPurpleList = param1;
            return;
        }// end function

        public function get curPurpleList() : Array
        {
            if (this._curPurpleList)
            {
                return this._curPurpleList;
            }
            return new Array();
        }// end function

        public function set stoveObj(param1:Object) : void
        {
            this._stoveObj = param1;
            return;
        }// end function

        public function get stoveObj() : Object
        {
            if (this.stoveObj)
            {
                return this.stoveObj;
            }
            return {itemId:0, itemAmount:0};
        }// end function

        public function set makeResult(param1:Array) : void
        {
            this._makeResult = param1;
            return;
        }// end function

        public function get makeResult() : Array
        {
            if (this._makeResult)
            {
                return this._makeResult;
            }
            return new Array();
        }// end function

        public function levelRole(param1:int) : Object
        {
            var _loc_3:Object = null;
            var _loc_2:int = 0;
            while (_loc_2 < this.curRoleList.length)
            {
                
                _loc_3 = this.curRoleList[_loc_2];
                if (_loc_3.roleId == param1 && _loc_3.childObj)
                {
                    this._curRoleList[_loc_2] = _loc_3.childObj;
                    return this._curRoleList[_loc_2];
                }
                _loc_2++;
            }
            return new Object();
        }// end function

        public function getInfoByRoleId(param1:int) : Object
        {
            var _loc_2:Array = [];
            var _loc_3:int = 0;
            while (_loc_3 < this.curRoleList.length)
            {
                
                if (this.curRoleList[_loc_3].roleId == param1)
                {
                    _loc_2.push(this.curRoleList[_loc_3]);
                }
                _loc_3++;
            }
            if (_loc_2.length == 1)
            {
                return _loc_2[0];
            }
            if (_loc_2.length > 0)
            {
                if (_loc_2[0].canLevel)
                {
                    return _loc_2[0];
                }
                return _loc_2[1];
            }
            var _loc_4:* = new Object();
            new Object().roleId = param1;
            _loc_4.sign = RoleType.getRoleSign(_loc_4.roleId);
            _loc_4.name = RoleType.getRoleName(_loc_4.roleId);
            _loc_4.have_amount = 0;
            var _loc_5:* = FurnaceType.getChat(_loc_4.roleId, FurnaceType.COMMONFLAG);
            _loc_4.chatList = _loc_5.split("|");
            _loc_5 = FurnaceType.getChat(_loc_4.roleId, FurnaceType.LEVELFLAG);
            _loc_4.levelChat = _loc_5;
            _loc_4.inBody = true;
            _loc_4.isLvUp = false;
            _loc_4.canLevel = false;
            _loc_4.fame = RoleType.getRoleFame(_loc_4.roleId);
            this.curRoleList.push(_loc_4);
            return _loc_4;
        }// end function

    }
}
