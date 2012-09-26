package com.controllers
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;

    public class SealSoulController extends Base
    {
        private var _lList:Array;
        private var _tenAttributeList:Array;
        private var _tenAttributeData:Object;

        public function SealSoulController()
        {
            this._lList = [];
            return;
        }// end function

        public function get soulInfoList() : Array
        {
            var _loc_1:* = _data.sealSoul.SoulInfoList;
            var _loc_2:Array = [];
            _loc_2 = this.renderSoul(_loc_1, true);
            return _loc_2;
        }// end function

        public function get itemInfo() : Object
        {
            var _loc_1:* = _data.sealSoul.itemInfo;
            var _loc_2:Object = {};
            _loc_2.playerItemId = _loc_1[0];
            _loc_2.itemId = _loc_1[1];
            _loc_2.itemLv = _loc_1[2];
            _loc_2.itemName = ItemType.getName(_loc_2.itemId);
            _loc_2.itemColor = ItemType.getItemColor(_loc_2.itemId);
            _loc_2.itemLvName = ItemType.getItemUpgrade(_loc_2.itemLv);
            _loc_2.jobList = ItemType.getEquipJob(_loc_2.itemId);
            _loc_2.jobSign = RoleType.getJobSign(_loc_2.jobList[0]);
            _loc_2.nineRegionsId = _loc_1[3];
            _loc_2.isCanUp = _loc_2.nineRegionsId < _ctrl.player.BlessLevel;
            _loc_2.blessLevel = _ctrl.player.BlessLevel;
            _loc_2.isMax = _loc_2.nineRegionsId >= 9;
            _loc_2.nineBlessName = NineRegionsType.getBlessNameByIdx(_loc_2.nineRegionsId);
            var _loc_3:* = _loc_2.nineRegionsId + 1;
            _loc_2.nextId = _loc_3;
            _loc_2.nextBlessName = NineRegionsType.getBlessNameByIdx(_loc_3);
            _loc_2.nextJie = NineRegionsType.getNameByIdx(_loc_3);
            if (_loc_2.playerItemId != 0)
            {
                _loc_2.soulSealList = this.renderSoul(_loc_1[4], false, _loc_2.nineRegionsId, _loc_2.nineAddValue);
            }
            else
            {
                _loc_2.soulSealList = [];
            }
            return _loc_2;
        }// end function

        public function get equipPlayerSoul() : Object
        {
            var _loc_1:* = _data.sealSoul.equipPlayerSoul;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get removePlayerSoul() : Object
        {
            var _loc_1:* = _data.sealSoul.removePlayerSoul;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get swapSoul() : Object
        {
            var _loc_1:* = _data.sealSoul.swapSoul;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get moveSoul() : Object
        {
            var _loc_1:* = _data.sealSoul.moveSoul;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get openSoulKey() : Object
        {
            var _loc_1:* = _data.sealSoul.openSoulKey;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get soulAtributeReset() : Object
        {
            var _loc_1:* = _data.sealSoul.soulAtributeReset;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get getTowerKey() : int
        {
            var _loc_1:* = _data.sealSoul.getTowerKey;
            var _loc_2:* = _loc_1[0];
            return _loc_2;
        }// end function

        public function get sellPlayerSoul() : Object
        {
            var _loc_1:* = _data.sealSoul.sellPlayerSoul;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        private function renderSoul(param1:Array, param2:Boolean = false, param3:int = 0, param4:int = 0) : Array
        {
            var _loc_8:Object = null;
            var _loc_9:Boolean = false;
            var _loc_5:Array = [];
            var _loc_6:* = param1.length;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_6)
            {
                
                if (param1[_loc_7][0] != 0)
                {
                    _loc_8 = {};
                    _loc_8.playerSoulId = param1[_loc_7][0];
                    _loc_8.addValue = param4;
                    _loc_8.soulId = param1[_loc_7][1];
                    _loc_8.soulName = SoulType.getSoulName(_loc_8.soulId);
                    _loc_8.quality = SoulType.getSoulQualityId(_loc_8.soulId);
                    _loc_8.color = SoulType.getQualityColor(_loc_8.quality);
                    _loc_8.sign = _loc_8.soulId;
                    _loc_8.url = URI.getSoulsIconUrl(_loc_8.soulId);
                    _loc_8.soulTypeId = SoulType.getSoulSubTypeId(_loc_8.soulId);
                    _loc_8.soulType = SoulType.getSubTypeNameByAllTypeId(_loc_8.soulTypeId);
                    _loc_8.jobId = SoulType.getSoulTypeIdByAllTypeId(_loc_8.soulTypeId);
                    _loc_8.jobName = SoulType.getJobNameToTypeId(_loc_8.jobId);
                    _loc_8.isEmpty = false;
                    _loc_8.salePrice = SoulType.getSoulSalePrice(_loc_8.soulId);
                    _loc_8.locationInfo = "";
                    _loc_8.locationList = [];
                    _loc_8.openKey = param1[_loc_7][9];
                    _loc_8.l1 = SoulType.getWarAttributeTypeId(param1[_loc_7][2]);
                    _loc_8.l2 = SoulType.getWarAttributeTypeId(param1[_loc_7][4]);
                    _loc_8.l3 = SoulType.getWarAttributeTypeId(param1[_loc_7][6]);
                    this._lList = [];
                    if (_loc_8.openKey >= 1)
                    {
                        this.saveData(_loc_8.l1, _loc_8.quality, param1[_loc_7][3]);
                    }
                    if (_loc_8.openKey >= 2)
                    {
                        this.saveData(_loc_8.l2, _loc_8.quality, param1[_loc_7][5]);
                    }
                    if (_loc_8.openKey >= 3)
                    {
                        this.saveData(_loc_8.l3, _loc_8.quality, param1[_loc_7][7]);
                    }
                    _loc_9 = false;
                    _loc_8.addValue = _loc_9 ? (param4) : (0);
                    if (_loc_9 && _loc_8.addValue > 0)
                    {
                        _loc_8.soulName = _loc_8.soulName + HtmlText.yellow("(+" + _loc_8.addValue + "%)");
                    }
                    _loc_8.nineRegionsId = param3;
                    _loc_8.isYellow = _loc_9 ? (1) : (0);
                    if (_loc_8.openKey >= 1)
                    {
                        _loc_8.locationList.push(this.renderLocationList(_loc_8.l1, _loc_8.quality, param1[_loc_7][3], _loc_8.addValue));
                    }
                    if (_loc_8.openKey >= 2)
                    {
                        _loc_8.locationList.push(this.renderLocationList(_loc_8.l2, _loc_8.quality, param1[_loc_7][5], _loc_8.addValue));
                    }
                    if (_loc_8.openKey >= 3)
                    {
                        _loc_8.locationList.push(this.renderLocationList(_loc_8.l3, _loc_8.quality, param1[_loc_7][7], _loc_8.addValue));
                    }
                    _loc_8.packLocation = param1[_loc_7][8];
                    _loc_8.lockState = param1[_loc_7][10];
                    _loc_8.unlockTime = param1[_loc_7][11];
                    _loc_8.diffTime = _ctrl.player.diffServerTime;
                    _loc_8.lock1 = param1[_loc_7][12];
                    _loc_8.lock2 = param1[_loc_7][13];
                    _loc_8.lock3 = param1[_loc_7][14];
                    _loc_5.push(_loc_8);
                }
                _loc_7++;
            }
            return _loc_5;
        }// end function

        private function saveData(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:Object = {id:param1, quality:param2, value:param3};
            this._lList.push(_loc_4);
            return;
        }// end function

        public function get tenTimesReset() : Object
        {
            var _loc_1:* = _data.sealSoul.tenTimesReset;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.attributeList = [];
            this._tenAttributeData = {};
            this._tenAttributeList = [];
            var _loc_3:* = _loc_1[1];
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_2.attributeList.push(this.renderAttribute(_loc_3[_loc_5]));
                _loc_5++;
            }
            this.attributeLock(_loc_2.attributeList);
            this.renderBaseAttribute();
            return _loc_2;
        }// end function

        private function attributeLock(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 1;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = 0;
                while (_loc_4 < (_loc_2 - 1))
                {
                    
                    if (param1[_loc_4].attributeId > param1[(_loc_4 + 1)].attributeId)
                    {
                        _loc_5 = param1[_loc_4];
                        param1[_loc_4] = param1[(_loc_4 + 1)];
                        param1[(_loc_4 + 1)] = _loc_5;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function renderAttribute(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.soulId = param1[0];
            _loc_2.attributeId = param1[1];
            _loc_2.quality = SoulType.getSoulQualityId(_loc_2.soulId);
            _loc_2.locationData = {};
            _loc_2.l1isGood = false;
            _loc_2.l2isGood = false;
            _loc_2.l3isGood = false;
            _loc_2.l1Value = param1[3];
            _loc_2.l2Value = param1[5];
            _loc_2.l3Value = param1[7];
            _loc_2.l1 = SoulType.getWarAttributeTypeId(param1[2]);
            if (_loc_2.l1 > 0)
            {
                if (this._tenAttributeData[_loc_2.l1] == null)
                {
                    this._tenAttributeData[_loc_2.l1] = [];
                    this._tenAttributeList.push(_loc_2.l1);
                }
                _loc_2.locationData[_loc_2.l1] = this.renderLocationList(_loc_2.l1, _loc_2.quality, _loc_2.l1Value);
                this._tenAttributeData[_loc_2.l1].push({value:_loc_2.l1Value, data:_loc_2, id:"L1", color:_loc_2.locationData[_loc_2.l1].color});
            }
            _loc_2.l2 = SoulType.getWarAttributeTypeId(param1[4]);
            if (_loc_2.l2 > 0)
            {
                if (this._tenAttributeData[_loc_2.l2] == null)
                {
                    this._tenAttributeData[_loc_2.l2] = [];
                    this._tenAttributeList.push(_loc_2.l2);
                }
                _loc_2.locationData[_loc_2.l2] = this.renderLocationList(_loc_2.l2, _loc_2.quality, _loc_2.l2Value);
                this._tenAttributeData[_loc_2.l2].push({value:_loc_2.l2Value, data:_loc_2, id:"L2", color:_loc_2.locationData[_loc_2.l2].color});
            }
            _loc_2.l3 = SoulType.getWarAttributeTypeId(param1[6]);
            if (_loc_2.l3 > 0)
            {
                if (this._tenAttributeData[_loc_2.l3] == null)
                {
                    this._tenAttributeData[_loc_2.l3] = [];
                    this._tenAttributeList.push(_loc_2.l3);
                }
                _loc_2.locationData[_loc_2.l3] = this.renderLocationList(_loc_2.l3, _loc_2.quality, _loc_2.l3Value);
                this._tenAttributeData[_loc_2.l3].push({value:_loc_2.l3Value, data:_loc_2, id:"L3", color:_loc_2.locationData[_loc_2.l3].color});
            }
            return _loc_2;
        }// end function

        private function renderBaseAttribute() : void
        {
            var _loc_3:int = 0;
            var _loc_4:Array = null;
            var _loc_5:Object = null;
            var _loc_1:* = this._tenAttributeList.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._tenAttributeList[_loc_2];
                _loc_4 = this._tenAttributeData[_loc_3];
                this.sortLock(_loc_4);
                _loc_5 = _loc_4[0];
                if (_loc_5.color != 2272312)
                {
                    if (_loc_5.id == "L1")
                    {
                        _loc_5.data.l1isGood = true;
                    }
                    if (_loc_5.id == "L2")
                    {
                        _loc_5.data.l2isGood = true;
                    }
                    if (_loc_5.id == "L3")
                    {
                        _loc_5.data.l3isGood = true;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        private function sortLock(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 1;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = 0;
                while (_loc_4 < (_loc_2 - 1))
                {
                    
                    if (param1[_loc_4].value < param1[(_loc_4 + 1)].value)
                    {
                        _loc_5 = param1[_loc_4];
                        param1[_loc_4] = param1[(_loc_4 + 1)];
                        param1[(_loc_4 + 1)] = _loc_5;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function get playerSoulValue() : Object
        {
            var _loc_1:* = _data.sealSoul.playerSoulValue;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get getResetCount() : int
        {
            var _loc_1:* = _data.sealSoul.getResetCount;
            var _loc_2:* = _loc_1[0];
            return _loc_2;
        }// end function

        public function get getStoneCount() : int
        {
            var _loc_1:* = _data.sealSoul.getStoneCount;
            var _loc_2:* = _loc_1[0];
            return _loc_2;
        }// end function

        public function get getLockData() : Object
        {
            var _loc_1:* = _data.sealSoul.LockData;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get getUnLockData() : Object
        {
            var _loc_1:* = _data.sealSoul.WillToUnlock;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get notifyGet() : Object
        {
            return _data.sealSoul.notifyGet;
        }// end function

        public function get getDayStone() : Object
        {
            return _data.sealSoul.getDayStone;
        }// end function

        public function get dayStoneCount() : Object
        {
            return _data.sealSoul.dayStoneCount;
        }// end function

        public function get swapSealSoul() : Object
        {
            return _data.sealSoul.swapSealSoul;
        }// end function

        public function get saveLock() : Object
        {
            var _loc_1:* = _data.sealSoul.SaveLock;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get upBuff() : int
        {
            var _loc_1:* = _data.sealSoul.UpBuff;
            return _loc_1[0];
        }// end function

        private function getIdForData(param1:int) : Object
        {
            var _loc_2:Object = {};
            _loc_2.soulName = SoulType.getSoulName(_loc_2.soulId);
            _loc_2.quality = SoulType.getSoulQualityId(_loc_2.soulId);
            _loc_2.color = SoulType.getQualityColor(_loc_2.quality);
            _loc_2.url = URI.getSoulsIconUrl(_loc_2.soulId);
            return _loc_2;
        }// end function

        public function renderLocationList(param1:int, param2:int, param3:Number, param4:int = 0) : Object
        {
            var _loc_5:* = param3 / 1000;
            var _loc_6:* = SoulType.warAttributeIdToName(param1);
            var _loc_7:* = SoulType.warAttributeIdToInfo(param1);
            var _loc_8:* = SoulType.getDataColor(param1, param2, _loc_5);
            var _loc_9:Number = 0;
            if (param1 != 15)
            {
                _loc_9 = param3 * param4 / 100 / 1000;
            }
            _loc_5 = _loc_5 + _loc_9;
            var _loc_10:* = _loc_8.color;
            var _loc_11:* = _loc_8.colorQuelity;
            var _loc_12:* = SoulType.warValueChange(param1, _loc_5);
            var _loc_13:* = SoulType.getDataRange(param1, param2, _loc_5);
            return {lid:param1, name:_loc_6, color:_loc_10, colorQuelity:_loc_11, valueInfo:_loc_12, range:_loc_13, oldValue:param3, info:_loc_7};
        }// end function

    }
}
