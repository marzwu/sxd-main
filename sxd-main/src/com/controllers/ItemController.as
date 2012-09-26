package com.controllers
{
    import com.assist.view.info.*;

    public class ItemController extends Base
    {

        public function ItemController()
        {
            return;
        }// end function

        public function get gridsRole() : Array
        {
            return _data.item.gridsRole;
        }// end function

        public function get gridsRoleOther() : Array
        {
            return _data.item.gridsRoleOther;
        }// end function

        public function get gridsPack() : Array
        {
            return _data.item.gridsPack;
        }// end function

        public function set gridsPackAuto(param1:Array) : void
        {
            _data.item.gridsPackAuto = param1;
            return;
        }// end function

        public function set gridsWarehouseAuto(param1:Array) : void
        {
            _data.item.gridsWarehouseAuto = param1;
            return;
        }// end function

        public function pushPack(param1:int) : void
        {
            _data.item.pushPack(param1);
            return;
        }// end function

        public function pushWareHouse(param1:int) : void
        {
            _data.item.pushWareHouse(param1);
            return;
        }// end function

        public function pushRole(param1:int) : void
        {
            _data.item.pushRole(param1);
            return;
        }// end function

        public function get ingot_pack() : int
        {
            return _data.item.ingot_pack;
        }// end function

        public function get gridsWarehouse() : Array
        {
            return _data.item.gridsWarehouse;
        }// end function

        public function get ingot_warehouse() : int
        {
            return _data.item.ingot_warehouse;
        }// end function

        public function get gridsShop() : Array
        {
            return _data.item.gridsShop;
        }// end function

        public function get gridsRecyle() : Array
        {
            return _data.item.gridsRecyle;
        }// end function

        public function get shopNPCId() : int
        {
            return _data.item.shopNPCId;
        }// end function

        public function get shopType() : int
        {
            return _data.item.shopType;
        }// end function

        public function get recastList() : Array
        {
            return _data.item.recastList;
        }// end function

        public function get cangoldList() : Array
        {
            return _data.item.cangoldList;
        }// end function

        public function get elixirCount() : int
        {
            return _data.item.elixirCount;
        }// end function

        public function get elixirValue() : int
        {
            return _data.item.elixirValue;
        }// end function

        public function get reelOutItemId() : int
        {
            return _data.item.reelOutItemId;
        }// end function

        public function get reelData() : Array
        {
            return _data.item.reelData;
        }// end function

        public function get playerRoleId() : int
        {
            return _data.item.playerRoleId;
        }// end function

        public function get danyaoList() : Array
        {
            return _data.item.danyaoList;
        }// end function

        public function get result() : int
        {
            return _data.item.result;
        }// end function

        public function get hasReelList() : Array
        {
            return _data.item.hasReelList;
        }// end function

        public function get hasGoldList() : Array
        {
            return _data.item.hasGoldList;
        }// end function

        public function get giftUseMsg() : String
        {
            return _data.item.giftUseMsg;
        }// end function

        public function get getSoul() : Object
        {
            return _data.item.getSoul;
        }// end function

        public function get getTheItemNum() : Object
        {
            return _data.item.getTheItemNum;
        }// end function

        public function get getGoldOil() : Object
        {
            return _data.item.getGoldOil;
        }// end function

        public function get stateLv() : int
        {
            return _data.item.stateLv;
        }// end function

        public function get statePoint() : int
        {
            return _data.item.statePoint;
        }// end function

        public function autoGrids(param1:Array, param2:int) : Array
        {
            var _loc_4:ItemInfo = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:Array = null;
            var _loc_8:Array = null;
            var _loc_9:Array = null;
            var _loc_10:int = 0;
            var _loc_11:Array = null;
            var _loc_12:Object = null;
            var _loc_3:Array = [];
            for each (_loc_4 in param1)
            {
                
                if (_loc_4.itemId == 0)
                {
                    continue;
                }
                _loc_3[_loc_4.itemId] = _loc_3[_loc_4.itemId] || [];
                _loc_3[_loc_4.itemId].push(_loc_4);
            }
            _loc_7 = [];
            _loc_8 = [];
            _loc_10 = _loc_3.length;
            while (_loc_10 > 0)
            {
                
                _loc_9 = _loc_3.pop();
                _loc_10 = _loc_10 - 1;
                if (_loc_9 == null)
                {
                    continue;
                }
                _loc_4 = _loc_9[0];
                _loc_6 = _loc_4.basic.max;
                _loc_5 = 0;
                if (_loc_6 <= 1)
                {
                    for each (_loc_4 in _loc_9)
                    {
                        
                        _loc_11 = [_loc_4.playerItemId, _loc_4.itemId, 0, _loc_4.upgradeLevel, _loc_4.price, _loc_4.num, _loc_4.useing, _loc_4.goldId, _loc_4.endTime];
                        _loc_7.push({arr:_loc_11, typeId:_loc_4.basic.type_id, quality:_loc_4.basic.quality, itemid:_loc_4.itemId});
                    }
                    continue;
                }
                for each (_loc_4 in _loc_9)
                {
                    
                    _loc_5 = _loc_5 + _loc_4.num;
                }
                for each (_loc_4 in _loc_9)
                {
                    
                    _loc_11 = [_loc_4.playerItemId, _loc_4.itemId, 0, _loc_4.upgradeLevel, _loc_4.price, _loc_4.num, _loc_4.useing, _loc_4.goldId, _loc_4.endTime];
                    if (_loc_5 > 0)
                    {
                        if (_loc_5 >= _loc_6)
                        {
                            _loc_11[5] = _loc_6;
                            _loc_7.push({arr:_loc_11, typeId:_loc_4.basic.type_id, quality:_loc_4.basic.quality, itemid:_loc_4.itemId});
                        }
                        else
                        {
                            _loc_11[5] = _loc_5;
                            _loc_7.push({arr:_loc_11, typeId:_loc_4.basic.type_id, quality:_loc_4.basic.quality, itemid:_loc_4.itemId});
                        }
                        _loc_5 = _loc_5 - _loc_6;
                        continue;
                    }
                    _loc_8.push([_loc_4.playerItemId, 0, 0, 0, 0, 0, 0, 0, 0]);
                }
            }
            _loc_7.sortOn(["typeId", "quality", "itemid"], [Array.NUMERIC, Array.NUMERIC, Array.NUMERIC]);
            _loc_3 = [];
            for each (_loc_12 in _loc_7)
            {
                
                _loc_9 = _loc_12.arr;
                _loc_9[2] = param2;
                param2++;
                _loc_3.push(_loc_9);
            }
            return [_loc_3, _loc_8];
        }// end function

    }
}
