package com.datas
{
    import com.assist.server.*;
    import com.assist.view.pack.*;
    import com.haloer.data.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;
    import flash.utils.*;

    public class UpgradeData extends Base
    {
        private var _aryEquipUpgradeStat:Array;
        private var _aryUpgradeEquipment:Array;
        private var _aryClearUpgradeCdTime:Array;
        private var _aryOpenUpgradeOpportunity:Array;
        private var _aryEquipUpgradeStatList:Array;
        private var _aryGetEquipmentList:Array;
        private var _aryUpgradeEquip:Array;
        private var _objPermanentCleanItemUpdateCd:Object;
        private var _objGetPermanentCleanItemUpdateCd:Object;
        private var _timeId:int = 0;
        private var _reqList:Array;
        public var isEquipDataReturn:Boolean = true;

        public function UpgradeData()
        {
            this._aryEquipUpgradeStat = [];
            this._aryUpgradeEquipment = [];
            this._aryClearUpgradeCdTime = [];
            this._aryOpenUpgradeOpportunity = [];
            this._aryEquipUpgradeStatList = [];
            this._aryGetEquipmentList = [];
            this._aryUpgradeEquip = [];
            this._objPermanentCleanItemUpdateCd = {};
            this._objGetPermanentCleanItemUpdateCd = {};
            this._reqList = [];
            return;
        }// end function

        public function getEquipmentList() : Array
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            var _loc_1:Array = [];
            for each (_loc_3 in this._aryGetEquipmentList[1])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["player_item_id", "item_id", "player_role_id", "upgrade_level", "upgrade_price", "gold_oil_id"]);
                this.getItemInfo(_loc_2);
                if (_loc_2["type_id"] == ItemType.WuQi)
                {
                    _loc_2["sort"] = 1;
                }
                if (_loc_2["type_id"] == ItemType.HunQi)
                {
                    _loc_2["sort"] = 2;
                }
                if (_loc_2["type_id"] == ItemType.TouKui)
                {
                    _loc_2["sort"] = 3;
                }
                if (_loc_2["type_id"] == ItemType.YiFu)
                {
                    _loc_2["sort"] = 4;
                }
                if (_loc_2["type_id"] == ItemType.XieZi)
                {
                    _loc_2["sort"] = 5;
                }
                if (_loc_2["type_id"] == ItemType.HuFu)
                {
                    _loc_2["sort"] = 6;
                }
                _loc_1.push(_loc_2);
            }
            _loc_1.sortOn(["sort", "item_id"], Array.NUMERIC);
            return _loc_1;
        }// end function

        public function getEquipmentListRoleID() : Object
        {
            var _loc_1:Object = {player_role_id:this._aryGetEquipmentList[0]};
            return _loc_1;
        }// end function

        public function getUpgradeEquipResult() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._aryUpgradeEquip, _loc_1, ["result"]);
            return _loc_1;
        }// end function

        public function getUpgradeEquipInfo() : Object
        {
            if (this._aryUpgradeEquip[1][0] == undefined)
            {
                return null;
            }
            var _loc_1:Object = {};
            oObject.list(this._aryUpgradeEquip[1][0], _loc_1, ["player_item_id", "item_id", "player_role_id", "upgrade_level", "upgrade_price", "gold_oil_id"]);
            this.getItemInfo(_loc_1);
            return _loc_1;
        }// end function

        public function get getUpgradeProbability() : int
        {
            var _loc_1:* = this._aryEquipUpgradeStat[0];
            return _loc_1;
        }// end function

        public function get getUpgradeTyep() : int
        {
            var _loc_1:* = this._aryEquipUpgradeStat[1];
            return _loc_1;
        }// end function

        public function get getFullProbIngot() : int
        {
            var _loc_1:* = this._aryEquipUpgradeStat[2];
            return _loc_1;
        }// end function

        public function get clearUpgradeCdTime() : int
        {
            var _loc_1:* = this._aryClearUpgradeCdTime[0];
            return _loc_1;
        }// end function

        public function openUpgradeOpportunity() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._aryOpenUpgradeOpportunity, _loc_1, ["reslut", "upgrade_id", "cd_time"]);
            return _loc_1;
        }// end function

        public function getEquipUpgradeStatList() : Array
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            var _loc_1:Array = [];
            for each (_loc_3 in this._aryEquipUpgradeStatList[1])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["upgrade_id", "cd_time", "ingot"]);
                _loc_1.push(_loc_2);
            }
            _loc_1.sort(this.sortByCdTime);
            return _loc_1;
        }// end function

        public function openMoreIngot() : int
        {
            return this._aryEquipUpgradeStatList[0];
        }// end function

        public function permanentCleanItemUpdateCd() : Object
        {
            return this._objPermanentCleanItemUpdateCd;
        }// end function

        public function getPermanentCleanItemUpdateCd() : Object
        {
            return this._objGetPermanentCleanItemUpdateCd;
        }// end function

        private function getItemInfo(param1:Object) : void
        {
            param1["type_id"] = ItemType.getTypeId(param1["item_id"]);
            param1["upgrade_level_name"] = ItemType.getItemUpgrade(param1["upgrade_level"]);
            param1["description"] = ItemType.getDescription(param1["item_id"]);
            var _loc_2:* = ItemBasically.empty;
            _loc_2 = ItemBasically.getBasic(param1["item_id"]);
            param1["name"] = _loc_2.getItemName(param1["gold_oil_id"]);
            param1["color"] = _loc_2.getItemColor(param1["gold_oil_id"]);
            param1["health"] = _loc_2.getHealthValue(param1["upgrade_level"], param1["gold_oil_id"]);
            param1["attack"] = _loc_2.getPAttackValue(param1["upgrade_level"], param1["gold_oil_id"]);
            param1["defense"] = _loc_2.getPDefenseValue(param1["upgrade_level"], param1["gold_oil_id"]);
            param1["stunt_attack"] = _loc_2.getSAttackValue(param1["upgrade_level"], param1["gold_oil_id"]);
            param1["stunt_defense"] = _loc_2.getSDefenseValue(param1["upgrade_level"], param1["gold_oil_id"]);
            param1["magic_attack"] = _loc_2.getMAttackValue(param1["upgrade_level"], param1["gold_oil_id"]);
            param1["magic_defense"] = _loc_2.getMDefenseValue(param1["upgrade_level"], param1["gold_oil_id"]);
            param1["url"] = _loc_2.getImgUrl(param1["gold_oil_id"]);
            this.setAttrib(param1);
            return;
        }// end function

        private function setAttrib(param1:Object) : Object
        {
            var _loc_2:String = "";
            if (param1["health"] != 0)
            {
                if (_loc_2 != "")
                {
                    _loc_2 = _loc_2 + "\r";
                }
                _loc_2 = _loc_2 + (UpgradeDataLang.Health + param1["health"]);
            }
            if (param1["attack"] != 0)
            {
                if (_loc_2 != "")
                {
                    _loc_2 = _loc_2 + "\r";
                }
                _loc_2 = _loc_2 + (UpgradeDataLang.Attack + param1["attack"]);
            }
            if (param1["defense"] != 0)
            {
                if (_loc_2 != "")
                {
                    _loc_2 = _loc_2 + "\r";
                }
                _loc_2 = _loc_2 + (UpgradeDataLang.Defense + param1["defense"]);
            }
            if (param1["stunt_attack"] != 0)
            {
                if (_loc_2 != "")
                {
                    _loc_2 = _loc_2 + "\r";
                }
                _loc_2 = _loc_2 + (UpgradeDataLang.StuntAttack + param1["stunt_attack"]);
            }
            if (param1["stunt_defense"] != 0)
            {
                if (_loc_2 != "")
                {
                    _loc_2 = _loc_2 + "\r";
                }
                _loc_2 = _loc_2 + (UpgradeDataLang.StuntDefense + param1["stunt_defense"]);
            }
            if (param1["magic_attack"] != 0)
            {
                if (_loc_2 != "")
                {
                    _loc_2 = _loc_2 + "\r";
                }
                _loc_2 = _loc_2 + (UpgradeDataLang.MagicAttack + param1["magic_attack"]);
            }
            if (param1["magic_defense"] != 0)
            {
                if (_loc_2 != "")
                {
                    _loc_2 = _loc_2 + "\r";
                }
                _loc_2 = _loc_2 + (UpgradeDataLang.MagicDefense + param1["magic_defense"]);
            }
            param1.attrib = _loc_2;
            return param1;
        }// end function

        private function sortByCdTime(param1:Object, param2:Object) : int
        {
            var _loc_3:* = param1["cd_time"];
            var _loc_4:* = param2["cd_time"];
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

        public function get_equipment_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            this._aryGetEquipmentList = param1;
            if (this._aryGetEquipmentList.length > 0)
            {
                for each (_loc_2 in this._aryGetEquipmentList[1])
                {
                    
                    _loc_3 = _loc_2[1];
                    this.isEquipDataReturn = false;
                    this._reqList[_loc_3] = [_loc_3];
                    if (this._timeId == 0)
                    {
                        this._timeId = setTimeout(this.get_item_basical_infos, 20);
                    }
                }
            }
            return;
        }// end function

        private function get_item_basical_infos() : void
        {
            var _loc_2:Array = null;
            this._timeId = 0;
            var _loc_1:Array = [];
            for each (_loc_2 in this._reqList)
            {
                
                _loc_1.push(_loc_2);
            }
            _data.call(Mod_Item_Base.get_item_basical_infos, this.getItemBasicalInfosCallBack, [_loc_1]);
            return;
        }// end function

        private function getItemBasicalInfosCallBack() : void
        {
            this.isEquipDataReturn = true;
            return;
        }// end function

        public function upgrade_equip(param1:Array) : void
        {
            this._aryUpgradeEquip = param1;
            return;
        }// end function

        public function equip_upgrade_stat(param1:Array) : void
        {
            this._aryEquipUpgradeStat = param1;
            return;
        }// end function

        public function clear_upgrade_cd_time(param1:Array) : void
        {
            this._aryClearUpgradeCdTime = param1;
            return;
        }// end function

        public function open_upgrade_opportunity(param1:Array) : void
        {
            this._aryOpenUpgradeOpportunity = param1;
            return;
        }// end function

        public function equip_upgrade_stat_list(param1:Array) : void
        {
            this._aryEquipUpgradeStatList = param1;
            return;
        }// end function

        public function permanent_clean_item_update_cd(param1:Array) : void
        {
            this._objPermanentCleanItemUpdateCd = {result:param1[0]};
            return;
        }// end function

        public function get_permanent_clean_item_update_cd(param1:Array) : void
        {
            this._objGetPermanentCleanItemUpdateCd = {state:param1[0]};
            return;
        }// end function

    }
}
