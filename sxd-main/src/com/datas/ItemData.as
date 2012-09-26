package com.datas
{
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.assist.view.pack.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;

    public class ItemData extends Base
    {
        public var result:int = 0;
        public var shopType:int = 0;
        public var shopNPCId:int = 0;
        public var gridsPack:Array;
        public var gridsPackAuto:Array;
        public var gridsWarehouse:Array;
        public var gridsWarehouseAuto:Array;
        public var gridsRole:Array;
        public var gridsRoleOther:Array;
        public var gridsShop:Array;
        public var gridsRecyle:Array;
        public var ingot_pack:int = 0;
        public var ingot_warehouse:int = 0;
        public var elixirCount:int = 0;
        public var elixirValue:int = 0;
        public var reelOutItemId:int;
        public var reelData:Array;
        public var playerRoleId:int = 0;
        public var danyaoList:Array;
        public var hasReelList:Array;
        public var hasGoldList:Array;
        public var giftUseMsg:String = "";
        public var recastList:Array;
        public var cangoldList:Array;
        public var getSoul:Object;
        public var getTheItemNum:Object;
        public var getGoldOil:Object;
        public var stateLv:int = 0;
        public var statePoint:int = 0;

        public function ItemData() : void
        {
            this.gridsPack = [];
            this.gridsWarehouse = [];
            this.gridsRole = [];
            this.gridsRoleOther = [];
            this.gridsShop = [];
            this.gridsRecyle = [];
            this.danyaoList = [];
            this.hasReelList = [];
            this.hasGoldList = [];
            this.recastList = [];
            this.cangoldList = [];
            this.getSoul = {};
            this.getTheItemNum = {total_num:0};
            this.getGoldOil = {};
            ItemTipSprite.ed.addEventListener("Item_Req", this.reqJuanZhouHandler);
            ItemTipSprite.ed.addEventListener("ItemSoul_Req", this.reqSoulHandler);
            return;
        }// end function

        private function reqJuanZhouHandler(event:JuanZhouEvent) : void
        {
            _data.call(Mod_Item_Base.get_facture_reel_data, null, [event.id]);
            return;
        }// end function

        private function reqSoulHandler(event:JuanZhouEvent) : void
        {
            _data.call(Mod_SealSoul_Base.get_item_info_by_player_item_id, null, [event.id]);
            return;
        }// end function

        public function dismount_transport(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function avatar_card_off(param1:Array) : void
        {
            return;
        }// end function

        public function add_pack_grid(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            var _loc_2:* = param1[1];
            while (_loc_2 <= param1[2])
            {
                
                this.pushPack(_loc_2);
                _loc_2++;
            }
            this.ingot_pack = param1[3];
            return;
        }// end function

        public function add_warehouse_grid(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            var _loc_2:* = param1[1];
            while (_loc_2 <= param1[2])
            {
                
                this.pushWareHouse(_loc_2);
                _loc_2++;
            }
            this.ingot_warehouse = param1[3];
            return;
        }// end function

        public function get_empty_grid_number(param1:Array) : void
        {
            return;
        }// end function

        public function classify_pack(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:Array = null;
            this.result = param1[0];
            if (this.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _loc_2 = this.gridsPack.length - BoxGrid.idPack;
                this.resetGrids(BoxGrid.idPack, _loc_2, this.gridsPack);
                for each (_loc_3 in this.gridsPackAuto)
                {
                    
                    this.updatePackGrids(_loc_3);
                }
            }
            this.gridsPackAuto = [];
            return;
        }// end function

        public function classify_warehouse(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:Array = null;
            this.result = param1[0];
            if (this.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _loc_2 = this.gridsWarehouse.length - BoxGrid.idWareHouse;
                this.resetGrids(BoxGrid.idWareHouse, _loc_2, this.gridsWarehouse);
                for each (_loc_3 in this.gridsWarehouseAuto)
                {
                    
                    this.updateWarehouseGrids(_loc_3);
                }
            }
            this.gridsWarehouseAuto = [];
            return;
        }// end function

        public function get_player_pack_item_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.resetGrids(BoxGrid.idPack, param1[0], this.gridsPack);
            this.ingot_pack = param1[1];
            for each (_loc_2 in param1[2])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function get_player_warehouse_grids(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            this.resetGrids(BoxGrid.idWareHouse, param1[1], this.gridsWarehouse);
            this.ingot_warehouse = param1[2];
            for each (_loc_2 in param1[3])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function get_role_equip_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            this.resetGrids(BoxGrid.idRole, 6, this.gridsRole);
            var _loc_2:int = 0;
            while (_loc_2 < 6)
            {
                
                this.pushRole(_loc_2 + BoxGrid.idRole);
                _loc_2++;
            }
            for each (_loc_3 in param1[0])
            {
                
                this.updateGrids(_loc_3);
            }
            return;
        }// end function

        public function get_npc_item_list(param1:Array) : void
        {
            var _loc_4:ItemInfo = null;
            var _loc_6:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            this.shopNPCId = param1[1];
            var _loc_2:* = TownType.getNPCSignByTownNPCId(this.shopNPCId);
            this.shopType = NPCType.getFunctionBySign(_loc_2);
            this.resetGrids(0, param1[2].length, this.gridsShop);
            var _loc_3:int = 0;
            var _loc_5:* = this.shopType == NPCType.CardBuyNPC;
            for each (_loc_6 in param1[2])
            {
                
                _loc_4 = this.gridsShop[_loc_3];
                _loc_4.parseShop(_loc_6[0], 1, _loc_5);
                _loc_3++;
            }
            this.gridsShop.sortOn(["ingot", "typeId", "quality", "upgradeLevel", "itemId"], [Array.NUMERIC, Array.NUMERIC, Array.NUMERIC | Array.DESCENDING, Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
            return;
        }// end function

        public function get_npc_recycle_item_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:ItemInfo = null;
            var _loc_2:* = param1[0].length;
            this.resetGrids(0, _loc_2, this.gridsRecyle);
            while (_loc_2 > 0)
            {
                
                _loc_2 = _loc_2 - 1;
                _loc_3 = param1[0][_loc_2];
                _loc_4 = this.gridsRecyle[_loc_2];
                _loc_4.parseRecycle(_loc_3);
            }
            this.gridsShop.sortOn(["ingot", "typeId", "quality", "upgradeLevel", "itemId"], [Array.NUMERIC, Array.NUMERIC, Array.NUMERIC | Array.DESCENDING, Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
            return;
        }// end function

        public function get_player_role_equip_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:ItemInfo = null;
            this.resetGrids(BoxGrid.idRole, 6, this.gridsRoleOther);
            for each (_loc_2 in param1[0])
            {
                
                _loc_3 = _loc_2[2];
                _loc_4 = this.gridsRoleOther[_loc_3] as ItemInfo;
                _loc_4.parsePack(_loc_2);
            }
            return;
        }// end function

        public function player_buy_npc_item(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function player_sell_item(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            this.updateGrids(param1[1][0]);
            var _loc_2:* = new ItemInfo();
            _loc_2.parseRecycle(param1[2][0]);
            this.gridsRecyle.unshift(_loc_2);
            return;
        }// end function

        public function player_buy_back_item(param1:Array) : void
        {
            var _loc_4:ItemInfo = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            this.updateGrids(param1[1][0]);
            var _loc_2:* = param1[2][0][0];
            var _loc_3:* = this.gridsRecyle.length;
            while (_loc_3 > 0)
            {
                
                _loc_3 = _loc_3 - 1;
                _loc_4 = this.gridsRecyle[_loc_3];
                if (_loc_4.playerItemId == _loc_2)
                {
                    this.gridsRecyle.splice(_loc_3, 1);
                }
            }
            return;
        }// end function

        public function change_pack_item_grid(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function change_warehouse_item_grid(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function move_pack_grid_item_to_warehouse(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function move_warehouse_grid_item_to_pack(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function drop_pack_grid_item(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function drop_warehouse_grid_item(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function remove_player_role_equipment(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function equip_player_role_item(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function player_use_grid_item(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function get_player_role_elixir_data(param1:Array) : void
        {
            this.elixirCount = param1[0] + 1;
            this.elixirValue = param1[1];
            return;
        }// end function

        public function player_use_grid_elixir(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function player_use_grid_reel(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            this.reelOutItemId = param1[1];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[3])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function get_facture_reel_data(param1:Array) : void
        {
            this.reelData = param1;
            ItemTipSprite.ed.dispatchEvent(new JuanZhouEvent(param1, param1[0], "Item_" + param1[0]));
            return;
        }// end function

        public function get_player_role_elixir_record(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            this.playerRoleId = param1[0];
            this.danyaoList[ItemType.WuLiDan] = [];
            this.danyaoList[ItemType.JueJiDan] = [];
            this.danyaoList[ItemType.FaShuDan] = [];
            for each (_loc_2 in param1[1])
            {
                
                _loc_3 = {};
                _loc_3.a = _loc_2[2];
                _loc_3.c = _loc_2[3];
                _loc_3.gid = _loc_2[4];
                _loc_3.num = _loc_2[5];
                _loc_3.url = ItemBasically.getBasic(_loc_2[0]).getImgUrl(0);
                _loc_3.itemId = _loc_2[0];
                _loc_3.ingot = _loc_2[6];
                _loc_3.lv = ItemBasically.getBasic(_loc_2[0]).require;
                this.danyaoList[_loc_2[1]].push(_loc_3);
            }
            this.danyaoList[ItemType.WuLiDan].sortOn("a", Array.NUMERIC);
            this.danyaoList[ItemType.JueJiDan].sortOn("a", Array.NUMERIC);
            this.danyaoList[ItemType.FaShuDan].sortOn("a", Array.NUMERIC);
            return;
        }// end function

        public function player_use_ingot_elixir(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function get_item_basical_infos(param1:Array) : void
        {
            return;
        }// end function

        public function get_item_info_by_player_item_id(param1:Array) : void
        {
            var _loc_5:Object = null;
            var _loc_11:Array = null;
            var _loc_12:Boolean = false;
            var _loc_14:int = 0;
            var _loc_15:Object = null;
            var _loc_16:Array = null;
            var _loc_2:Array = [];
            var _loc_3:Array = [];
            var _loc_4:Array = [];
            var _loc_6:int = 0;
            var _loc_7:* = param1[1];
            var _loc_8:int = 0;
            var _loc_9:* = new Object();
            var _loc_10:int = 0;
            while (_loc_10 <= 20)
            {
                
                _loc_9[_loc_10] = 0;
                _loc_10++;
            }
            for each (_loc_11 in param1[2])
            {
                
                _loc_14 = _loc_11[1];
                if (_loc_11[2] != 0)
                {
                    _loc_6 = SoulType.getWarAttributeTypeId(_loc_11[2]);
                    var _loc_19:* = _loc_3[_loc_6] || {};
                    _loc_5 = _loc_3[_loc_6] || {};
                    _loc_3[_loc_6] = _loc_19;
                    _loc_5.id = _loc_6;
                    _loc_5.value = _loc_11[3] + int(_loc_5.value);
                    _loc_5.quality = SoulType.getSoulQualityId(_loc_14);
                    _loc_15 = SoulType.getDataColor(_loc_5.id, _loc_5.quality, _loc_11[3] / 1000);
                    if (_loc_15.colorQuelity >= 3)
                    {
                        var _loc_19:* = _loc_9;
                        var _loc_20:* = _loc_6;
                        var _loc_21:* = _loc_9[_loc_6] + 1;
                        _loc_19[_loc_20] = _loc_21;
                    }
                    _loc_4.push(_loc_5);
                }
                if (_loc_11[4] != 0)
                {
                    _loc_6 = SoulType.getWarAttributeTypeId(_loc_11[4]);
                    var _loc_19:* = _loc_3[_loc_6] || {};
                    _loc_5 = _loc_3[_loc_6] || {};
                    _loc_3[_loc_6] = _loc_19;
                    _loc_5.id = _loc_6;
                    _loc_5.value = _loc_11[5] + int(_loc_5.value);
                    _loc_5.quality = SoulType.getSoulQualityId(_loc_14);
                    _loc_15 = SoulType.getDataColor(_loc_5.id, _loc_5.quality, _loc_11[5] / 1000);
                    if (_loc_15.colorQuelity >= 3)
                    {
                        var _loc_19:* = _loc_9;
                        var _loc_20:* = _loc_6;
                        var _loc_21:* = _loc_9[_loc_6] + 1;
                        _loc_19[_loc_20] = _loc_21;
                    }
                    _loc_4.push(_loc_5);
                }
                if (_loc_11[6] != 0)
                {
                    _loc_6 = SoulType.getWarAttributeTypeId(_loc_11[6]);
                    var _loc_19:* = _loc_3[_loc_6] || {};
                    _loc_5 = _loc_3[_loc_6] || {};
                    _loc_3[_loc_6] = _loc_19;
                    _loc_5.id = _loc_6;
                    _loc_5.value = _loc_11[7] + int(_loc_5.value);
                    _loc_5.quality = SoulType.getSoulQualityId(_loc_14);
                    _loc_15 = SoulType.getDataColor(_loc_5.id, _loc_5.quality, _loc_11[7] / 1000);
                    if (_loc_15.colorQuelity >= 3)
                    {
                        var _loc_19:* = _loc_9;
                        var _loc_20:* = _loc_6;
                        var _loc_21:* = _loc_9[_loc_6] + 1;
                        _loc_19[_loc_20] = _loc_21;
                    }
                    _loc_4.push(_loc_5);
                }
            }
            _loc_12 = SoulType.isItemYellow(_loc_4);
            _loc_8 = _loc_12 ? (_loc_8) : (0);
            var _loc_13:* = _loc_7;
            for each (_loc_5 in _loc_3)
            {
                
                _loc_16 = NineRegionsType.getSoulAdd(_loc_5.id, _loc_9[_loc_5.id], _loc_13);
                _loc_2.push(this.renderLocationList(_loc_5.id, _loc_5.quality, _loc_5.value, _loc_8, _loc_16));
            }
            _loc_2.sortOn("id", Array.NUMERIC);
            ItemTipSprite.ed.dispatchEvent(new JuanZhouEvent(_loc_2, param1[0], "ItemSoul_" + param1[0]));
            return;
        }// end function

        public function has_level_gift_item(param1:Array) : void
        {
            _data.player.giftItemId = param1[0];
            return;
        }// end function

        public function player_get_super_gift(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function player_reel_need_item(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            this.hasReelList = [];
            for each (_loc_2 in param1[0])
            {
                
                _loc_3 = {};
                _loc_3.player_item_id = _loc_2[0];
                _loc_3.item_id = _loc_2[1];
                _loc_3.need_lv = ItemType.getRequireLevel(_loc_2[4]);
                this.hasReelList[_loc_2[3]] = _loc_3;
            }
            this.hasGoldList = [];
            for each (_loc_2 in param1[1])
            {
                
                _loc_3 = {};
                _loc_3.player_item_id = _loc_2[0];
                _loc_3.item_id = _loc_2[1];
                _loc_3.pro_item_id = GoldOilType.getPrevOilItemId(_loc_2[1]);
                _loc_3.require = GoldOilType.getItemLevel(_loc_2[1]);
                this.hasGoldList[_loc_3.pro_item_id] = _loc_3;
            }
            return;
        }// end function

        public function player_equip_use_reel(param1:Array) : void
        {
            this.player_use_grid_reel(param1);
            return;
        }// end function

        public function get_player_item_facture_reel_data(param1:Array) : void
        {
            this.get_facture_reel_data(param1);
            return;
        }// end function

        private function strCoin(param1:int) : String
        {
            if (param1 >= 100000)
            {
                return int(param1 / 10000) + ItemDataLang.Wan;
            }
            return param1.toString();
        }// end function

        public function notify_super_gift_items(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:Array = null;
            var _loc_8:Array = null;
            var _loc_2:String = "";
            var _loc_3:Array = [];
            if (param1[0] > 0)
            {
                _loc_3.push(HtmlText.yellow(this.strCoin(param1[0])) + ItemDataLang.Coin);
            }
            if (param1[1] > 0)
            {
                _loc_3.push(HtmlText.yellow(param1[1]) + ItemDataLang.Fame);
            }
            if (param1[2] > 0)
            {
                _loc_3.push(HtmlText.yellow(param1[2]) + ItemDataLang.Ingot);
            }
            if (param1[3] > 0)
            {
                _loc_3.push(HtmlText.yellow(param1[3]) + ItemDataLang.Stone);
            }
            if (param1[4] > 0)
            {
                _loc_3.push(HtmlText.yellow(param1[4]) + ItemDataLang.StatePoint);
            }
            for each (_loc_7 in param1[5])
            {
                
                _loc_4 = ItemType.getItemColor(_loc_7[0]);
                _loc_5 = ItemType.getName(_loc_7[0]);
                if (_loc_7[1] > 0)
                {
                    _loc_5 = _loc_5 + _loc_7[1] + ItemDataLang.Ge;
                }
                _loc_3.push(HtmlText.format(_loc_5, _loc_4));
            }
            _loc_8 = [0, 10066329, 2272312, 44783, 16711935, 16773376, 16711680];
            for each (_loc_6 in param1[4])
            {
                
                _loc_4 = _loc_8[FateType.getFateQuality(_loc_6)];
                _loc_5 = FateType.getFateName(_loc_6);
                _loc_3.push(HtmlText.format(_loc_5, _loc_4));
            }
            for each (_loc_6 in param1[5])
            {
                
                _loc_4 = SoulType.getSoulQualityColor(_loc_6);
                _loc_5 = SoulType.getSoulName(_loc_6);
                _loc_3.push(HtmlText.format(_loc_5, _loc_4));
            }
            this.giftUseMsg = ItemDataLang.GetItem + " " + _loc_3.join(" ");
            if (param1[6] == 1 && param1[1] == 70000)
            {
                this.giftUseMsg = this.giftUseMsg + " " + HtmlText.yellow2(ItemDataLang.Star) + " " + HtmlText.yellow2(ItemDataLang.WorldFirst);
            }
            return;
        }// end function

        public function change_attack_info(param1:Array) : void
        {
            this.recastList = param1[0];
            return;
        }// end function

        public function change_attack_item(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            for each (_loc_2 in param1[1])
            {
                
                this.updatePackGrids(_loc_2);
            }
            return;
        }// end function

        public function can_change_list(param1:Array) : void
        {
            this.recastList = param1[0];
            return;
        }// end function

        public function can_use_gold_info(param1:Array) : void
        {
            this.cangoldList = param1[0];
            return;
        }// end function

        public function use_gold_oil(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result == Mod_Item_Base.SUCCESS)
            {
                for each (_loc_2 in param1[1])
                {
                    
                    this.updateGrids(_loc_2);
                }
            }
            return;
        }// end function

        public function get_soul(param1:Array) : void
        {
            this.getSoul["result"] = param1[0];
            return;
        }// end function

        public function get_the_item_num(param1:Array) : void
        {
            this.getTheItemNum["total_num"] = param1[0];
            return;
        }// end function

        public function get_gold_oil(param1:Array) : void
        {
            this.getGoldOil["result"] = param1[0];
            return;
        }// end function

        public function take_off_clothes(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.result = param1[0];
            if (this.result != Mod_Item_Base.ACTION_SUCCESS)
            {
                return;
            }
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function pushPack(param1:int) : void
        {
            if (param1 == 0)
            {
                return;
            }
            var _loc_3:* = this.gridsPack[param1] || new ItemInfo();
            this.gridsPack[param1] = this.gridsPack[param1] || new ItemInfo();
            var _loc_2:* = _loc_3;
            _loc_2.gridId = param1;
            return;
        }// end function

        public function pushWareHouse(param1:int) : void
        {
            if (param1 == 0)
            {
                return;
            }
            var _loc_3:* = this.gridsWarehouse[param1] || new ItemInfo();
            this.gridsWarehouse[param1] = this.gridsWarehouse[param1] || new ItemInfo();
            var _loc_2:* = _loc_3;
            _loc_2.gridId = param1;
            return;
        }// end function

        public function pushRole(param1:int) : void
        {
            if (param1 == 0)
            {
                return;
            }
            var _loc_3:* = this.gridsRole[param1] || new ItemInfo();
            this.gridsRole[param1] = this.gridsRole[param1] || new ItemInfo();
            var _loc_2:* = _loc_3;
            _loc_2.gridId = param1;
            return;
        }// end function

        private function resetGrids(param1:int, param2:int, param3:Array) : void
        {
            var _loc_4:ItemInfo = null;
            while (param3.length > param2)
            {
                
                param3.pop();
            }
            while (param2 > 0)
            {
                
                var _loc_5:* = param3[param1] || new ItemInfo();
                param3[param1] = param3[param1] || new ItemInfo();
                _loc_4 = _loc_5;
                _loc_4.reset();
                _loc_4.gridId = param1;
                param1++;
                param2 = param2 - 1;
            }
            return;
        }// end function

        public function updateGrids(param1:Array) : void
        {
            var _loc_2:* = param1[2];
            if (_loc_2 == 210)
            {
                _data.furnaceMap.furnaceInfo.iInfoArr = param1;
            }
            else if (_loc_2 >= BoxGrid.idRole)
            {
                this.updateRoleGrids(param1);
            }
            else if (_loc_2 >= BoxGrid.idWareHouse)
            {
                this.updateWarehouseGrids(param1);
            }
            else if (_loc_2 >= BoxGrid.idPack)
            {
                this.updatePackGrids(param1);
            }
            return;
        }// end function

        private function updatePackGrids(param1:Array) : void
        {
            var _loc_2:* = param1[2];
            var _loc_4:* = this.gridsPack[_loc_2] || new ItemInfo();
            this.gridsPack[_loc_2] = this.gridsPack[_loc_2] || new ItemInfo();
            var _loc_3:* = _loc_4;
            _loc_3.parsePack(param1);
            this.pushPack(_loc_2);
            return;
        }// end function

        private function updateWarehouseGrids(param1:Array) : void
        {
            var _loc_2:* = param1[2];
            var _loc_4:* = this.gridsWarehouse[_loc_2] || new ItemInfo();
            this.gridsWarehouse[_loc_2] = this.gridsWarehouse[_loc_2] || new ItemInfo();
            var _loc_3:* = _loc_4;
            _loc_3.parsePack(param1);
            this.pushWareHouse(_loc_2);
            return;
        }// end function

        private function updateRoleGrids(param1:Array) : void
        {
            var _loc_2:* = param1[2];
            var _loc_4:* = this.gridsRole[_loc_2] || new ItemInfo();
            this.gridsRole[_loc_2] = this.gridsRole[_loc_2] || new ItemInfo();
            var _loc_3:* = _loc_4;
            _loc_3.parsePack(param1);
            this.pushRole(_loc_2);
            return;
        }// end function

        public function renderLocationList(param1:int, param2:int, param3:Number, param4:int, param5:Array) : Object
        {
            var _loc_10:Object = null;
            var _loc_11:Number = NaN;
            var _loc_6:* = param3 / 1000;
            var _loc_7:* = SoulType.warAttributeIdToName(param1);
            if (param2 > 0)
            {
                _loc_10 = SoulType.getDataColor(param1, param2, _loc_6);
                _loc_11 = 0;
                if (param1 != 15)
                {
                    _loc_11 = param3 * param4 / 100 / 1000;
                }
                _loc_6 = _loc_6 + _loc_11;
            }
            var _loc_8:* = SoulType.warValueChange(param1, _loc_6);
            var _loc_9:Boolean = false;
            if (param5[1] != 0)
            {
                _loc_8 = _loc_8 + HtmlText.green(" (" + param5[0] + " +" + param5[1] + ")");
                _loc_9 = true;
            }
            return {name:_loc_7, info:_loc_7 + " +" + _loc_8, id:param1, isActive:_loc_9, blessId:param5[2]};
        }// end function

        public function openFurnace(param1:Array) : void
        {
            var _loc_2:Array = null;
            for each (_loc_2 in param1[0])
            {
                
                _data.furnaceMap.furnaceInfo.iInfoArr = _loc_2;
            }
            return;
        }// end function

        public function dragFurnaceItem(param1:Array) : void
        {
            var _loc_2:Array = null;
            for each (_loc_2 in param1[1])
            {
                
                this.updateGrids(_loc_2);
            }
            return;
        }// end function

        public function swap_card(param1:Array) : void
        {
            this.stateLv = param1[0];
            this.statePoint = param1[1];
            return;
        }// end function

        public function tian_di_yu_pai(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result == Mod_Item_Base.SUCCESS)
            {
                this.statePoint = this.statePoint - 20;
            }
            return;
        }// end function

    }
}
