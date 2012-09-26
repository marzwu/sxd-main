package com.controllers
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.datas.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class FateController extends Base
    {
        public var ownData:FateData;
        public var FateScrapNumber:int = 0;
        private var _mainPlayerList:Array;
        public var _addFateNpcId:int = 0;
        public var summerNpcId:int = 0;
        private var _mergeData:Array;
        private var _mergeAllInBag:Array;
        private var colorObj:Object;

        public function FateController()
        {
            this.colorObj = {1:10066329, 2:2272312, 3:44783, 4:16711935, 5:16773376, 6:16711680, 7:16773376, 8:16773376};
            return;
        }// end function

        public function get fateNpc() : Object
        {
            var _loc_1:* = this.ownData.fateNpc;
            var _loc_2:Object = {};
            _loc_2.freeAppointTimes = _loc_1[0];
            var _loc_3:* = this.renderFateNpc(_loc_1[1]);
            sortFateNpc(_loc_3);
            _loc_2.fateNpcList = _loc_3;
            return _loc_2;
        }// end function

        private function renderFateNpc(param1:Array) : Array
        {
            var _loc_7:Object = null;
            var _loc_2:Array = [];
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:* = param1.length;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = {};
                _loc_7.fateNpcId = param1[_loc_6][0];
                _loc_7.status = param1[_loc_6][1];
                _loc_7.url = URI.getRoleIconUrl("Npc" + _loc_7.fateNpcId);
                _loc_7.canBuyTimer = param1[_loc_6][2];
                _loc_7.maxBuyTimes = param1[_loc_6][3];
                _loc_7.buyPrice = param1[_loc_6][4];
                if (_loc_7.status == 1)
                {
                    if (_loc_3 <= _loc_7.fateNpcId)
                    {
                        _loc_3 = _loc_7.fateNpcId;
                        if (_loc_2.length > 0)
                        {
                            _loc_2[_loc_4].isShowChat = false;
                        }
                        _loc_4 = _loc_6;
                        _loc_7.isShowChat = true;
                    }
                }
                if (_loc_7.fateNpcId == 4)
                {
                    _loc_7.isBuy = true;
                }
                else
                {
                    _loc_7.isBuy = false;
                }
                _loc_7.isVip5 = VIPType.check(VIPType.Level1);
                _loc_7.npcName = FateType.getNPCName(_loc_7.fateNpcId);
                _loc_7.coins = FateType.getNPCFee(_loc_7.fateNpcId);
                _loc_2.push(_loc_7);
                _loc_6++;
            }
            return _loc_2;
        }// end function

        public function get tempFate() : Array
        {
            var _loc_1:* = this.ownData.tempFate;
            return this.renderTempFate(_loc_1[0]);
        }// end function

        private function renderTempFate(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.tempFateId = param1[_loc_4][0];
                _loc_5.fateId = param1[_loc_4][1];
                _loc_5.quality = FateType.getFateQuality(_loc_5.fateId);
                if (_loc_5.quality <= 0)
                {
                    _loc_5.fateLevel = 0;
                }
                else
                {
                    _loc_5.fateLevel = 1;
                }
                this.renderFateDate(_loc_5);
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            _loc_2.sortOn("tempFateId");
            return _loc_2;
        }// end function

        public function get pickupFate() : Object
        {
            var _loc_1:* = this.ownData.pickupFate;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.gridList = _loc_1[1];
            return _loc_2;
        }// end function

        public function get saleTempFate() : Object
        {
            var _loc_1:* = this.ownData.saleTempFate;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get bagList() : Array
        {
            var _loc_1:* = this.ownData.bagList;
            var _loc_2:* = this.renderBagList(_loc_1[0], _loc_1[1]);
            this.FateScrapNumber = _loc_1[2];
            return _loc_2;
        }// end function

        private function renderBagList(param1:Array, param2:int) : Array
        {
            var _loc_8:Object = null;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            this.sortPosition(param1);
            var _loc_5:int = 0;
            var _loc_6:* = param1.length;
            var _loc_7:int = 0;
            while (_loc_7 < 20)
            {
                
                _loc_8 = {};
                _loc_8.roleId = 0;
                _loc_8.playerName = "";
                _loc_8.playerRoleId = 0;
                _loc_8.playerColor = 16777215;
                _loc_8.playerLevel = 0;
                _loc_8.buyGrid = 0;
                _loc_9 = _loc_7 + 1;
                if (_loc_6 > _loc_4 && _loc_9 == param1[_loc_4][8])
                {
                    _loc_8.playerFateId = param1[_loc_4][0];
                    _loc_8.fateId = param1[_loc_4][1];
                    _loc_8.fateLevel = param1[_loc_4][2];
                    _loc_8.fateExp = param1[_loc_4][3];
                    _loc_8.upDataExp = param1[_loc_4][4];
                    _loc_8.needActived = param1[_loc_4][5];
                    _loc_8.wearLevel = param1[_loc_4][6];
                    _loc_8.activedFate = this.renderActivedFate(param1[_loc_4][7]);
                    _loc_8.activedFateList = this.renderActivedFateList(param1[_loc_4][7]);
                    _loc_8.grid = param1[_loc_4][8];
                    _loc_8.lockOn = true;
                    _loc_8.isEmpty = false;
                    this.renderFateDate(_loc_8);
                    _loc_4++;
                }
                else
                {
                    _loc_8.playerFateId = 0;
                    _loc_8.fateId = 0;
                    _loc_8.fateLevel = 0;
                    _loc_8.fateExp = 0;
                    _loc_8.upDataExp = 0;
                    _loc_8.isEmpty = true;
                    _loc_8.needActived = 0;
                    if (_loc_7 < param2)
                    {
                        _loc_8.grid = _loc_9;
                        _loc_8.lockOn = true;
                    }
                    else
                    {
                        _loc_8.grid = _loc_9;
                        _loc_8.lockOn = false;
                        _loc_10 = _loc_7 - 4;
                        if (_loc_7 >= 5)
                        {
                            _loc_5 = _loc_5 + 10 * _loc_10;
                        }
                        _loc_8.price = _loc_5;
                    }
                }
                _loc_3.push(_loc_8);
                _loc_7++;
            }
            return _loc_3;
        }// end function

        public function get buyBagGrid() : Object
        {
            var _loc_1:* = this.ownData.buyBagGrid;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get roleFateData() : Object
        {
            var _loc_1:* = this.ownData.roleFateList;
            var _loc_2:Object = {};
            _loc_2.fateList = this.renderRoleFateList(_loc_1[0], _loc_1[2]);
            _loc_2.fatePower = _loc_1[1];
            _loc_2.canWearNumber = _loc_1[2];
            return _loc_2;
        }// end function

        private function renderRoleFateList(param1:Array, param2:int) : Array
        {
            var _loc_7:Object = null;
            var _loc_8:int = 0;
            var _loc_3:Array = [];
            this.sortPosition(param1);
            var _loc_4:* = param1.length;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            while (_loc_6 < 8)
            {
                
                _loc_7 = {};
                _loc_7.grid = 0;
                _loc_8 = _loc_6 + 1;
                if (_loc_4 > _loc_5 && _loc_8 == param1[_loc_5][8])
                {
                    _loc_7.playerFateId = param1[_loc_5][0];
                    _loc_7.fateId = param1[_loc_5][1];
                    _loc_7.fateLevel = param1[_loc_5][2];
                    _loc_7.fateExp = param1[_loc_5][3];
                    _loc_7.upDataExp = param1[_loc_5][4];
                    _loc_7.needActived = param1[_loc_5][5];
                    _loc_7.wearLevel = param1[_loc_5][6];
                    _loc_7.activedFate = this.renderActivedFate(param1[_loc_5][7]);
                    _loc_7.activedFateList = this.renderActivedFateList(param1[_loc_5][7]);
                    _loc_7.position = param1[_loc_5][8];
                    _loc_7.lockOn = true;
                    this.renderFateDate(_loc_7);
                    _loc_7.isEmpty = false;
                    _loc_5++;
                }
                else
                {
                    _loc_7.playerFateId = 0;
                    _loc_7.grid = 0;
                    _loc_7.fateId = 0;
                    _loc_7.fateLevel = 0;
                    _loc_7.fateExp = 0;
                    _loc_7.upDataExp = 0;
                    _loc_7.isEmpty = true;
                    _loc_7.needActived = 0;
                    if (_loc_6 < param2)
                    {
                        _loc_7.position = _loc_8;
                        _loc_7.lockOn = true;
                    }
                    else
                    {
                        _loc_7.position = 0;
                        _loc_7.lockOn = false;
                    }
                }
                _loc_3.push(_loc_7);
                _loc_6++;
            }
            return _loc_3;
        }// end function

        private function renderActivedFate(param1:Array) : Object
        {
            var _loc_5:int = 0;
            var _loc_2:* = param1.length;
            var _loc_3:Object = {};
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = param1[_loc_4][0];
                _loc_3[_loc_5] = _loc_5;
                _loc_4++;
            }
            return _loc_3;
        }// end function

        private function renderActivedFateList(param1:Array) : Array
        {
            var _loc_5:int = 0;
            var _loc_2:* = param1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = param1[_loc_4][0];
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        private function sortPosition(param1:Array) : void
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
                    
                    if (param1[_loc_4][8] > param1[(_loc_4 + 1)][8])
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

        public function get wearOn() : Object
        {
            var _loc_1:* = this.ownData.wearOn;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            if (_loc_1[1] != 0)
            {
                _loc_2.fateId = _loc_1[1];
                this.renderFateDate(_loc_2);
            }
            return _loc_2;
        }// end function

        public function get discardFate() : Object
        {
            var _loc_1:* = this.ownData.discardFate;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get appointFateNpc() : Object
        {
            var _loc_3:String = null;
            var _loc_4:Array = null;
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_8:int = 0;
            var _loc_9:uint = 0;
            var _loc_1:* = this.ownData.appointFateNpc;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.fateId = _loc_1[1];
            _loc_2.fateNpcId = _loc_1[2];
            _loc_2.tempFateId = _loc_1[3];
            _loc_2.npcName = "";
            _loc_2.info = "";
            _loc_2.quality = FateType.getFateQuality(_loc_2.fateId);
            if (_loc_2.quality <= 0)
            {
                _loc_2.fateLevel = 0;
            }
            else
            {
                _loc_2.fateLevel = 1;
            }
            if (_loc_2.msg == Mod_Fate_Base.SUCCESS)
            {
                if (_loc_2.fateId != 0)
                {
                    this.renderFateDate(_loc_2);
                    _loc_2.type = "success";
                    _loc_3 = "";
                    _loc_4 = [];
                    _loc_4.push(_loc_2.fateName);
                    if (this.summerNpcId != 0)
                    {
                        _loc_6 = 44;
                        _loc_7 = FateType.getFateName(_loc_6);
                        _loc_8 = FateType.getFateQuality(_loc_6);
                        _loc_9 = this.colorRender(_loc_8);
                        _loc_3 = HtmlText.format(_loc_7, _loc_9);
                        _loc_4.push(_loc_3);
                    }
                    _loc_5 = _loc_4.splice("，");
                    if (_loc_2.fateNpcId != 0)
                    {
                        _loc_2.npcName = FateType.getNPCName(_loc_2.fateNpcId);
                        _loc_2.mainInfo = "<font color=\"#33ff00\">" + FateControllerLang.Get + "“ </font>" + "<font color=\"#" + _loc_2.color.toString(16) + "\">" + _loc_5 + "</font>" + "<font color=\"#33ff00\"> ”，" + FateControllerLang.Encounter + "</font>" + "<font color=\"#33ff00\">" + _loc_2.npcName + "</font>";
                    }
                    else
                    {
                        _loc_2.fateNpcId = 1;
                        _loc_2.mainInfo = "<font color=\"#33ff00\">" + FateControllerLang.Get + "“</font>" + "<font color=\"#" + _loc_2.color.toString(16) + "\">" + _loc_5 + "</font>" + "<font color=\"#33ff00\"> ”</font>";
                    }
                    this._addFateNpcId = _loc_2.fateNpcId;
                }
                else
                {
                    _loc_2.type = "fail";
                    _loc_2.info = FateControllerLang.NoGetFate;
                }
            }
            return _loc_2;
        }// end function

        public function get wearOffFate() : Object
        {
            var _loc_1:* = this.ownData.wearOffFate;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get changeFateGrid() : Object
        {
            var _loc_1:* = this.ownData.changeFateGrid;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get changePosition() : Object
        {
            var _loc_1:* = this.ownData.changePosition;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get getFatePower() : Object
        {
            var _loc_1:* = this.ownData.getFatePower;
            var _loc_2:Object = {};
            _loc_2.fate_power = _loc_1[0];
            return _loc_2;
        }// end function

        public function get merge() : Object
        {
            var _loc_1:* = this.ownData.merge;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            if (_loc_1[1] != 0)
            {
                _loc_2.fateId = _loc_1[1];
                this.renderFateDate(_loc_2);
            }
            return _loc_2;
        }// end function

        public function get mergeData() : Object
        {
            var _loc_1:* = this.ownData.mergeData;
            var _loc_2:Object = {};
            _loc_2.newLevel = _loc_1[0];
            return _loc_2;
        }// end function

        public function get mergeAllInBag() : Array
        {
            return this._mergeAllInBag;
        }// end function

        public function get ExchangeFate() : Object
        {
            var _loc_1:* = this.ownData.ExchangeFate;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get getScrapAmount() : int
        {
            var _loc_1:* = this.ownData.getScrapAmount;
            var _loc_2:* = _loc_1[0];
            this.FateScrapNumber = _loc_2;
            return _loc_2;
        }// end function

        private function bagData(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.roleId = 0;
            _loc_2.playerName = "";
            _loc_2.playerRoleId = 0;
            _loc_2.playerColor = 16777215;
            _loc_2.playerLevel = 0;
            _loc_2.playerFateId = param1[0];
            _loc_2.fateId = param1[1];
            _loc_2.fateLevel = param1[2];
            _loc_2.fateExp = param1[3];
            _loc_2.upDataExp = param1[4];
            _loc_2.grid = param1[5];
            _loc_2.lockOn = true;
            this.renderFateDate(_loc_2);
            return _loc_2;
        }// end function

        private function renderFateDate(param1:Object) : void
        {
            param1.quality = FateType.getFateQuality(param1.fateId);
            param1.fateName = FateType.getFateName(param1.fateId);
            param1.color = this.colorRender(param1.quality);
            param1.info = FateType.getFateDescription(param1.fateId);
            param1.sell = FateType.getSalePriceByFateId(param1.fateId);
            param1.addValue = FateType.getFateAddonValue(param1.fateId, param1.fateLevel);
            param1.maxLevel = FateType.getMaxFateLevel(param1.fateId);
            param1.baseExp = FateType.getExperienceByQualityId(param1.quality);
            param1.warType = FateType.getWarAttributeType(param1.fateId);
            if (param1.warType == FateType.Hit || param1.warType == FateType.Block || param1.warType == FateType.Dodge || param1.warType == FateType.Critical || param1.warType == FateType.BreakBlock || param1.warType == FateType.BreakCritical || param1.warType == FateType.Kill)
            {
                param1.addValue = param1.addValue * 10;
            }
            param1.fateLevelInfo = "";
            if (param1.fateLevel >= param1.maxLevel && param1.quality != 0)
            {
                param1.fateLevelInfo = FateControllerLang.MaxLevel;
            }
            if (param1.quality == 1)
            {
                param1.sign = "ZaWu";
            }
            else if (param1.quality == 6)
            {
                param1.sign = FateType.getFateSign(param1.fateId);
                param1.quality = 0;
                param1.maxLevel = 10;
            }
            else
            {
                param1.sign = FateType.getFateSign(param1.fateId);
            }
            param1.url = URI.fateUrl + param1.sign + ".swf";
            return;
        }// end function

        public function renderAddValue(param1:Object, param2:int) : int
        {
            var _loc_6:int = 0;
            var _loc_3:* = FateType.getActivedList(param1.fateId);
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = _loc_3[_loc_5];
                if (_loc_6 == param2)
                {
                    return _loc_5;
                }
                _loc_5++;
            }
            return 0;
        }// end function

        public function renderFateAddValue(param1:int, param2:int, param3:int, param4:int) : String
        {
            var _loc_5:* = FateType.getWarAttributeType(param1);
            var _loc_6:* = FateType.getFateDescription(param1);
            var _loc_7:int = 0;
            if (param4 == 0)
            {
                _loc_7 = FateType.getFateAddonValue(param2, param3);
            }
            else
            {
                _loc_7 = FateType.getFateAddonValue2(param2, param3);
            }
            if (_loc_5 == FateType.Hit || _loc_5 == FateType.Block || _loc_5 == FateType.Dodge || _loc_5 == FateType.Critical || _loc_5 == FateType.BreakBlock || _loc_5 == FateType.BreakCritical || _loc_5 == FateType.Kill)
            {
                _loc_7 = _loc_7 * 10;
            }
            var _loc_8:* = _loc_6 + _loc_7;
            return _loc_6 + _loc_7;
        }// end function

        public function get buyFateNpc() : Object
        {
            var _loc_1:* = _data.fate.buyFateNpc;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        private function colorRender(param1:uint) : uint
        {
            var _loc_2:* = this.colorObj[param1];
            return _loc_2;
        }// end function

        public function mergeAllNormalInBag() : Array
        {
            return [];
        }// end function

        private static function sortFateNpc(param1:Array) : void
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
                    
                    if (param1[_loc_4].fateNpcId > param1[(_loc_4 + 1)].fateNpcId)
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

    }
}
