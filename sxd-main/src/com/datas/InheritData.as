package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.pack.*;
    import com.haloer.data.*;

    public class InheritData extends Base
    {
        private var _aryRoleList:Array;
        private var _objRoleAttribute:Object = null;
        private var _aryAttributeAfterInherit:Array;
        private var _objInherit:Object;
        private var _objType:Object;
        private var _objAttribute:Object;

        public function InheritData()
        {
            this._aryRoleList = [];
            this._aryAttributeAfterInherit = [];
            this._objInherit = {};
            this._objType = {1:"base_", 2:"training_", 3:"drug_"};
            this._objAttribute = {0:"strength", 1:"agile", 2:"intellect"};
            return;
        }// end function

        public function get roleList() : Array
        {
            return this._aryRoleList;
        }// end function

        public function get roleAttribute() : Object
        {
            return this._objRoleAttribute;
        }// end function

        public function get attributeAfterInherit() : Array
        {
            return this._aryAttributeAfterInherit;
        }// end function

        public function get roleInherit() : Object
        {
            return this._objInherit;
        }// end function

        private function sortByLevel(param1:Object, param2:Object) : int
        {
            var _loc_3:* = param1["level"];
            var _loc_4:* = param2["level"];
            if (_loc_3 < _loc_4)
            {
                return 1;
            }
            if (_loc_3 > _loc_4)
            {
                return -1;
            }
            return 0;
        }// end function

        public function role_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            this._aryRoleList = [];
            var _loc_2:Object = {};
            for each (_loc_3 in param1[0])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["player_role_id", "role_id", "role_name", "level", "role_job_id"]);
                _loc_2["role_job_name"] = RoleType.getJobName(_loc_2["role_job_id"]);
                _loc_2["url"] = URI.iconsUrl + RoleType.getRoleSign(_loc_2["role_id"]) + ".png";
                this._aryRoleList.push(_loc_2);
            }
            this._aryRoleList.sort(this.sortByLevel);
            return;
        }// end function

        public function role_attribute(param1:Array) : void
        {
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            this._objRoleAttribute = {};
            oObject.list(param1, this._objRoleAttribute, ["state_id", "state_level"]);
            this._objRoleAttribute["state_name"] = DuJieType.getSpiritName(this._objRoleAttribute["state_id"]) + DuJieType.getSpiritLevelInfo(this._objRoleAttribute["state_level"]);
            this._objRoleAttribute["state_color"] = DuJieType.getSpiritColor(this._objRoleAttribute["state_id"]);
            var _loc_2:* = param1[(param1.length - 1)] as Array;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                _loc_5 = _loc_4[0];
                _loc_6 = 1;
                while (_loc_6 < _loc_4.length)
                {
                    
                    this._objRoleAttribute[this._objType[_loc_6] + this._objAttribute[_loc_5]] = _loc_4[_loc_6];
                    _loc_7 = this._objRoleAttribute["total_" + this._objAttribute[_loc_5]] as int;
                    _loc_7 = _loc_7 + _loc_4[_loc_6];
                    this._objRoleAttribute["total_" + this._objAttribute[_loc_5]] = _loc_7;
                    _loc_6++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function attribute_after_inherit(param1:Array) : void
        {
            var _loc_5:Object = null;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:Array = null;
            var _loc_9:Array = null;
            var _loc_10:Array = null;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            var _loc_15:Array = null;
            var _loc_16:int = 0;
            this._aryAttributeAfterInherit = [];
            var _loc_2:Array = [];
            var _loc_3:Object = {};
            var _loc_4:Object = {};
            for each (_loc_2 in param1[0])
            {
                
                _loc_3 = {};
                oObject.list(_loc_2, _loc_3, ["inherit_type", "level", "state_id", "state_level", "ingot", "skill", "coin"]);
                _loc_3["state_name"] = DuJieType.getSpiritName(_loc_3["state_id"]) + DuJieType.getSpiritLevelInfo(_loc_3["state_level"]);
                _loc_3["state_color"] = DuJieType.getSpiritColor(_loc_3["state_id"]);
                _loc_5 = {};
                _loc_6 = _loc_2[_loc_2.length - 2] as Array;
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    _loc_10 = _loc_6[_loc_7];
                    _loc_11 = _loc_10[0];
                    _loc_12 = 1;
                    while (_loc_12 < _loc_10.length)
                    {
                        
                        _loc_5[this._objType[_loc_12] + this._objAttribute[_loc_11]] = _loc_10[_loc_12];
                        _loc_13 = _loc_5["total_" + this._objAttribute[_loc_11]] as int;
                        _loc_13 = _loc_13 + _loc_10[_loc_12];
                        _loc_5["total_" + this._objAttribute[_loc_11]] = _loc_13;
                        _loc_12++;
                    }
                    _loc_7++;
                }
                _loc_3["after_inherit_attrib_info"] = _loc_5;
                _loc_8 = [];
                _loc_8[ItemType.WuLiDan] = [];
                _loc_8[ItemType.JueJiDan] = [];
                _loc_8[ItemType.FaShuDan] = [];
                for each (_loc_9 in _loc_2[(_loc_2.length - 1)])
                {
                    
                    _loc_4 = {};
                    oObject.list(_loc_9, _loc_4, ["itemId", "typeId", "a", "c", "oldTimes"]);
                    _loc_4["gid"] = 0;
                    _loc_4["num"] = 0;
                    _loc_4["ingot"] = 0;
                    _loc_4["lv"] = ItemBasically.getBasic(_loc_9[0]).require;
                    _loc_4["url"] = ItemBasically.getBasic(_loc_9[0]).getImgUrl(0);
                    _loc_14 = _loc_4["c"] - _loc_4["oldTimes"];
                    _loc_15 = [];
                    _loc_16 = 1;
                    while (_loc_16 <= _loc_4["a"] / 5)
                    {
                        
                        if (_loc_16 <= _loc_4["oldTimes"])
                        {
                            _loc_15.push(0);
                        }
                        else if (_loc_16 <= _loc_4["c"])
                        {
                            _loc_15.push(1);
                        }
                        else
                        {
                            _loc_15.push(0);
                        }
                        _loc_16++;
                    }
                    _loc_4["effectList"] = _loc_15;
                    _loc_8[_loc_4["typeId"]].push(_loc_4);
                }
                _loc_8[ItemType.WuLiDan].sortOn("a", Array.NUMERIC);
                _loc_8[ItemType.JueJiDan].sortOn("a", Array.NUMERIC);
                _loc_8[ItemType.FaShuDan].sortOn("a", Array.NUMERIC);
                _loc_3["after_inherit_drug_info"] = _loc_8;
                this._aryAttributeAfterInherit.push(_loc_3);
            }
            return;
        }// end function

        public function inherit(param1:Array) : void
        {
            this._objInherit = {result:param1[0]};
            return;
        }// end function

    }
}
