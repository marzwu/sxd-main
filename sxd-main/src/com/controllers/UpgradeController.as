package com.controllers
{
    import com.assist.server.*;

    public class UpgradeController extends Base
    {

        public function UpgradeController()
        {
            return;
        }// end function

        public function getEquipmentList() : Array
        {
            return this._data.upgrade.getEquipmentList();
        }// end function

        public function getEquipmentListRoleID() : Object
        {
            return this._data.upgrade.getEquipmentListRoleID();
        }// end function

        public function getUpgradeProbability() : int
        {
            return this._data.upgrade.getUpgradeProbability;
        }// end function

        public function getUpgradeTyep() : int
        {
            return this._data.upgrade.getUpgradeTyep;
        }// end function

        public function getFullProbIngot() : int
        {
            return this._data.upgrade.getFullProbIngot;
        }// end function

        public function upgradeEquipment() : Object
        {
            return this._data.upgrade.getUpgradeEquipResult();
        }// end function

        public function clearUpgradeCdTime() : int
        {
            return this._data.upgrade.clearUpgradeCdTime;
        }// end function

        public function upgradeEquipmentInfo() : Object
        {
            return this._data.upgrade.getUpgradeEquipInfo();
        }// end function

        public function openUpgradeOpportunity() : Object
        {
            return this._data.upgrade.openUpgradeOpportunity();
        }// end function

        public function getEquipUpgradeStatList() : Array
        {
            return this._data.upgrade.getEquipUpgradeStatList();
        }// end function

        public function openMoreIngot() : int
        {
            return this._data.upgrade.openMoreIngot();
        }// end function

        public function permanentCleanItemUpdateCd() : Object
        {
            return this._data.upgrade.permanentCleanItemUpdateCd();
        }// end function

        public function getPermanentCleanItemUpdateCd() : Object
        {
            return this._data.upgrade.getPermanentCleanItemUpdateCd();
        }// end function

        public function getSimpleRoleList() : Array
        {
            var _loc_1:Object = null;
            for each (_loc_1 in _data.rolemsg.simpleRoleList)
            {
                
                if (_loc_1["id"] == this._ctrl.player.mainPlayerRoleId)
                {
                    _loc_1["name"] = this._ctrl.player.removeNickNameSuffix(this._ctrl.player.nickname);
                    _loc_1["sign"] = RoleType.getRoleSign(_loc_1.roleId);
                    _loc_1["signSuffix"] = this._ctrl.player.playerInfo.signSuffix;
                }
                else
                {
                    _loc_1["name"] = RoleType.getRoleName(_loc_1["roleId"]);
                    _loc_1["sign"] = RoleType.getRoleSign(_loc_1.roleId);
                    _loc_1["signSuffix"] = "";
                }
                _loc_1["old_name"] = _loc_1["name"];
                _loc_1["name"] = this.changStringLength(_loc_1["name"]);
            }
            this._data.rolemsg.simpleRoleList.sort(this.roleSort);
            return this._data.rolemsg.simpleRoleList;
        }// end function

        private function roleSort(param1:Object, param2:Object) : int
        {
            if (param1["id"] == this._ctrl.player.mainPlayerRoleId)
            {
                return -1;
            }
            if (param2["id"] == this._ctrl.player.mainPlayerRoleId)
            {
                return 1;
            }
            if (param1["is_deploy"] < param2["is_deploy"])
            {
                return -1;
            }
            if (param1["is_deploy"] > param2["is_deploy"])
            {
                return 1;
            }
            if (param1["level"] > param2["level"])
            {
                return -1;
            }
            if (param1["level"] < param2["level"])
            {
                return 1;
            }
            return 0;
        }// end function

        public function get isEquipDataReturn() : Boolean
        {
            return this._data.upgrade.isEquipDataReturn;
        }// end function

        private function changStringLength(param1:String) : String
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param1.charCodeAt(_loc_3) > 127)
                {
                    _loc_2 = _loc_2 + 2;
                }
                else
                {
                    _loc_2 = _loc_2 + 1;
                }
                if (_loc_2 > 8)
                {
                    if (param1.charCodeAt((_loc_3 - 1)) > 127)
                    {
                        return param1.substr(0, (_loc_3 - 1)) + "...";
                    }
                    return param1.substr(0, _loc_3 - 2) + "...";
                }
                _loc_3++;
            }
            return param1;
        }// end function

    }
}
