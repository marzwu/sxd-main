package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.item.*;
    import com.assist.view.pack.*;
    import com.assist.view.sound.*;
    import com.assist.view.toolbar.*;
    import com.controllers.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class PackView extends Base implements IView
    {
        private var _target:IPack;
        private var _boxlist:Array;
        private var _clickBox:BoxGrid;
        private var _addmsg:String;
        private var _updateList:Array;
        private var useItemId:int = 0;
        private var _useBox:BoxGrid;

        public function PackView()
        {
            this._boxlist = [];
            this._updateList = [];
            return;
        }// end function

        public function show() : void
        {
            if (this.inStage)
            {
                return;
            }
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            if (_view.factionWarMap.isFactionWarStart == true)
            {
                return;
            }
            this.get_player_pack_item_list();
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            if (_view.shop.inStage)
            {
                _view.shop.close();
            }
            if (_view.warehouse.inStage)
            {
                _view.warehouse.close();
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function get content() : Sprite
        {
            return this._target.content;
        }// end function

        private function get item() : ItemController
        {
            return _ctrl.item;
        }// end function

        private function get player() : PlayerController
        {
            return _ctrl.player;
        }// end function

        public function get target() : IPack
        {
            return this._target;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._target && this._target.content.stage != null;
        }// end function

        private function loadComplete() : void
        {
            var _loc_1:BoxGrid = null;
            var _loc_2:int = 0;
            var _loc_3:Array = null;
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("Pack", "Pack") as IPack;
                this._target.onClose = this.close;
                this._target.onBtn1 = this.btn1Click;
                this._target.onBtn2 = this.player_classify_pack;
                this._target.onBtn3 = this.btn3Click;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
                _loc_3 = this._target.boxList;
                _loc_2 = 0;
                while (_loc_2 < 36)
                {
                    
                    _loc_1 = new BoxGrid(BoxGrid.idPack + _loc_2, BoxGrid.typePack, _loc_3[_loc_2]);
                    _loc_1.onDoubleClick = this.boxDoubleClick;
                    _loc_1.onClick = this.boxClick;
                    _loc_1.onDrag = this.boxDrag;
                    _loc_1.onDown = this.boxDown;
                    _loc_1.onUp = this.boxUp;
                    _loc_1.onRemove = this.boxRemove;
                    _loc_1.onDragView = this.boxDragView;
                    this._boxlist[_loc_1.id] = _loc_1;
                    _loc_2++;
                }
            }
            if (this.inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            _loc_3 = this.item.gridsPack;
            for each (_loc_1 in this._boxlist)
            {
                
                _loc_1.item = _loc_3[_loc_1.id] as ItemInfo;
            }
            this._target.updateBoxCount(36);
            var _loc_4:* = FunctionType.isOpened(FunctionType.Warehouse);
            this._target.Btn3.visible = FunctionType.isOpened(FunctionType.Warehouse);
            this._target.Btn1.visible = _loc_4;
            return;
        }// end function

        private function btn1Click() : void
        {
            if (_view.shop.inStage == true)
            {
                _view.shop.close();
            }
            else
            {
                _view.shop.shopNpcId = 0;
                _view.shop.show();
            }
            return;
        }// end function

        private function btn3Click() : void
        {
            if (_view.warehouse.inStage == true)
            {
                _view.warehouse.close();
            }
            else
            {
                _view.warehouse.npcId = 0;
                _view.warehouse.show();
            }
            return;
        }// end function

        private function boxDrag(param1:BoxGrid, param2:BoxGrid) : void
        {
            if (param2.isPackBox)
            {
                this.change_pack_item_grid(param1, param2);
            }
            else if (param2.isRoleBox)
            {
                this.equip_player_role_item(param1, param2);
            }
            else if (param2.isShopBox)
            {
                this.player_sell_item(param1);
            }
            else if (param2.isWareHouseBox)
            {
                this.pack_grid_moveto_warehouse(param1, param2);
            }
            else if (param2.isFurnace)
            {
                if (!_view.refiningFurnace.bDragErrItem(param1))
                {
                    _data.call(Mod_Item_Base.drag_furnace_item, this.dragToFurnace, [Mod_Item_Base.DRAG_TO_FURNACE, param1.id]);
                }
            }
            return;
        }// end function

        private function boxDragView(param1:BoxGrid, param2) : void
        {
            if (param2 is IPack && param2 != this._target)
            {
                this.pack_grid_moveto_warehouse(param1, null);
            }
            else if (param2 is IRoleMsg)
            {
                this.equip_player_role_item(param1, null);
            }
            else if (param2 is IShopUI)
            {
                this.player_sell_item(param1);
            }
            return;
        }// end function

        private function dragToFurnace() : void
        {
            _view.refiningFurnace.updateBox();
            this.updateGrids();
            return;
        }// end function

        private function boxDown(param1:BoxGrid) : void
        {
            if (param1.item.basic.isEquip)
            {
                _view.roleMsg.equipLock(param1.itemId);
            }
            return;
        }// end function

        private function boxUp(param1:BoxGrid) : void
        {
            _view.roleMsg.releaseLock();
            return;
        }// end function

        private function boxClick(param1:BoxGrid) : void
        {
            var _loc_2:Array = null;
            if (param1.isLock)
            {
                this.openBox(param1);
            }
            else if (param1.itemId != 0)
            {
                _loc_2 = getClickTip(param1.boxType, param1.item);
                this.showClickTip(param1, _loc_2);
            }
            return;
        }// end function

        private function openBox(param1:BoxGrid) : void
        {
            var openToGrid:int;
            var openIngot:int;
            var list:Array;
            var box:* = param1;
            var i:* = box.id;
            openToGrid = box.id;
            openIngot;
            var ingot:* = this.item.ingot_pack;
            list;
            while (i > 0)
            {
                
                box = this._boxlist[i];
                if (box.isLock)
                {
                    list.push(box);
                    box.lockLight = true;
                    openIngot = openIngot + ingot;
                    ingot = ingot + 2;
                }
                else
                {
                    break;
                }
                i = (i - 1);
            }
            _view.alert.showYesNoMsg(Lang.sprintf(PackViewLang.AskOpenBox, HtmlText.yellow(openIngot + PackViewLang.Ingot), list.length), PackViewLang.Yes, PackViewLang.No, function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes && _view.ingotEnough(openIngot))
                {
                    add_pack_grid(openToGrid);
                }
                for each (box in list)
                {
                    
                    box.lockLight = false;
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function boxRemove(param1:BoxGrid) : void
        {
            var box1:* = param1;
            if (box1.item.basic.isQuest)
            {
                _view.showTip(PackViewLang.DeleteErrorTask);
            }
            else if (box1.item.useing)
            {
                _view.showTip(PackViewLang.DeleteErrorUseing);
            }
            else if (box1.item.basic.isPackage)
            {
                _view.showTip(PackViewLang.DeleteErrorPage);
            }
            else
            {
                box1.addFilters();
                _view.alert.showYesNoMsg(PackViewLang.AskDelete, PackViewLang.Yes, PackViewLang.No, function (param1:uint) : void
            {
                box1.removeFilters();
                if (param1 == AlertButtonType.Yes)
                {
                    drop_pack_grid_item(box1);
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function boxDoubleClick(param1:BoxGrid) : void
        {
            var _loc_2:* = param1.item.basic;
            if (_view.shop.inStage)
            {
                this.player_sell_item(param1);
            }
            else if (_view.warehouse.inStage)
            {
                this.pack_grid_moveto_warehouse(param1, null);
            }
            else if (_view.refiningFurnace.inStage)
            {
                if (!_view.refiningFurnace.bDragErrItem(param1))
                {
                    _data.call(Mod_Item_Base.drag_furnace_item, this.dragToFurnace, [Mod_Item_Base.DRAG_TO_FURNACE, param1.id]);
                }
            }
            else if (_loc_2.isEquip == false)
            {
                this.useingItem(param1);
            }
            else if (_loc_2.isEquip == true)
            {
                this.equip_player_role_item(param1, null);
            }
            return;
        }// end function

        private function useingItem(param1:BoxGrid) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_2:* = param1.item.basic;
            if (!_loc_2.isCanUseing)
            {
                if (param1.item.basic.type_id == 10006)
                {
                    _loc_3 = TownType.getTownIdByLock(this._ctrl.player.townKey);
                    _loc_3 = ItemType.getTownIdByYuPai(param1.item.basic.item_id, _loc_3);
                    _loc_4 = TownType.getTownNPCIdByFunc(_loc_3, NPCType.CardBuyNPC);
                    _view.townMap.moveToNPCByTownIdAndNpcId(_loc_3, _loc_4);
                }
                return;
            }
            if (_loc_2.isDanYao)
            {
                this.get_player_role_elixir_data(param1);
            }
            else if (_loc_2.isJuanZhou)
            {
                _view.refine.initdata(param1.itemId, param1.playerItemId, 0, 0);
                _view.refine.show();
            }
            else if (_loc_2.isGoldOil)
            {
                _view.armsGold.goldId = param1.itemId;
                _view.armsGold.playerItemId = param1.playerItemId;
                _view.armsGold.show();
            }
            else if (_loc_2.isChangeAttack)
            {
                _view.armsRecast.playerItemId = param1.playerItemId;
                _view.armsRecast.show();
            }
            else
            {
                this.player_use_grid_item(param1);
            }
            return;
        }// end function

        private function showClickTip(param1:BoxGrid, param2:Array) : void
        {
            if (param2.length == 0)
            {
                return;
            }
            this._clickBox = param1;
            this._clickBox.lockLight = true;
            var _loc_3:* = new ClickTipList(param2, param2, this.onTextClick);
            _loc_3.onRemoveStage = this.tipRemoveStageHandler;
            _view.tip.iTip.clickToOpen(_loc_3);
            return;
        }// end function

        private function onTextClick(param1:String) : void
        {
            if (param1 == PackViewLang.Sell)
            {
                this.player_sell_item(this._clickBox);
            }
            else if (param1 == PackViewLang.Open || param1 == PackViewLang.Useing)
            {
                this.useingItem(this._clickBox);
            }
            else if (param1 == PackViewLang.Fusion)
            {
                _view.refine.initdata(this._clickBox.item.itemId, this._clickBox.item.playerItemId, 0, 0);
                _view.refine.autoMerge();
            }
            else if (param1 == PackViewLang.Equip)
            {
                this.equip_player_role_item(this._clickBox, null);
            }
            else if (param1 == PackViewLang.Delete)
            {
                this.boxRemove(this._clickBox);
            }
            else if (param1 == PackViewLang.Eat)
            {
                this.get_player_role_elixir_data(this._clickBox);
            }
            else if (param1 == PackViewLang.Show)
            {
                _view.chat.showMsg([ChatMsgType.Item, this._clickBox.itemId, this._clickBox.item.upgradeLevel, this._clickBox.playerItemId, this._clickBox.item.goldId, _ctrl.player.nickname]);
            }
            return;
        }// end function

        private function tipRemoveStageHandler() : void
        {
            this._clickBox.lockLight = false;
            return;
        }// end function

        public function updateGrids() : void
        {
            var _loc_2:BoxGrid = null;
            if (this.inStage == false)
            {
                return;
            }
            var _loc_1:* = this.item.gridsPack;
            for each (_loc_2 in this._boxlist)
            {
                
                _loc_2.item = _loc_1[_loc_2.id] as ItemInfo;
            }
            this._target.updateBoxCount(36);
            return;
        }// end function

        public function resetPack() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this.get_player_pack_item_list();
            return;
        }// end function

        public function updateGridsTips(param1:Array = null) : void
        {
            var _loc_3:BoxGrid = null;
            if (this.inStage == false)
            {
                return;
            }
            param1 = param1 || [];
            var _loc_2:* = param1.length;
            for each (_loc_3 in this._boxlist)
            {
                
                if (_loc_3.itemId == 0)
                {
                    continue;
                }
                if (_loc_2 == 0 || param1.indexOf(_loc_3.itemType) != -1)
                {
                    _loc_3.updateTips();
                }
            }
            return;
        }// end function

        public function changeShop(param1:Boolean) : void
        {
            var _loc_2:Boolean = false;
            BoxGrid.isOpenWareHouse = false;
            var _loc_2:* = _loc_2;
            BoxGrid.isOpenRole = _loc_2;
            BoxGrid.isOpenRecycle = _loc_2;
            BoxGrid.isOpenShop = param1;
            this.updateGridsTips();
            this.autoOpen(param1);
            return;
        }// end function

        public function changeWareHouse(param1:Boolean) : void
        {
            var _loc_2:Boolean = false;
            BoxGrid.isOpenShop = false;
            var _loc_2:* = _loc_2;
            BoxGrid.isOpenRole = _loc_2;
            BoxGrid.isOpenRecycle = _loc_2;
            BoxGrid.isOpenWareHouse = param1;
            this.updateGridsTips();
            this.autoOpen(param1);
            return;
        }// end function

        public function changeRole(param1:Boolean) : void
        {
            var _loc_2:Boolean = false;
            BoxGrid.isOpenWareHouse = false;
            var _loc_2:* = _loc_2;
            BoxGrid.isOpenShop = _loc_2;
            BoxGrid.isOpenRecycle = _loc_2;
            BoxGrid.isOpenRole = param1;
            this.updateGridsTips([1, 2, 3, 4, 5, 6]);
            return;
        }// end function

        public function changeRecycle(param1:Boolean) : void
        {
            var _loc_2:Boolean = false;
            BoxGrid.isOpenWareHouse = false;
            var _loc_2:* = _loc_2;
            BoxGrid.isOpenShop = _loc_2;
            BoxGrid.isOpenRole = _loc_2;
            BoxGrid.isOpenRecycle = param1;
            return;
        }// end function

        private function autoOpen(param1:Boolean) : void
        {
            if (param1 && this.inStage == false)
            {
                this.show();
            }
            return;
        }// end function

        private function addtoolbarMsg(param1:String) : void
        {
            _view.chat.addSystemMessage(param1);
            return;
        }// end function

        private function hideBox(param1:BoxGrid) : void
        {
            if (param1 && param1.itemId != 0)
            {
                this.item.pushPack(param1.id);
                param1.hideItem();
            }
            return;
        }// end function

        public function getBestEQ(param1:int, param2:int, param3:int) : ItemInfo
        {
            var _loc_4:ItemInfo = null;
            var _loc_5:ItemInfo = null;
            var _loc_6:* = this.item.gridsPack;
            for each (_loc_5 in _loc_6)
            {
                
                if (_loc_5 && _loc_5.itemId != 0 && _loc_5.typeId == param1 && _loc_5.basic.require <= param2 && _loc_5.basic.jobArr[param3] == 1)
                {
                    _loc_4 = _loc_4 || _loc_5;
                    if (_loc_5.addSum > _loc_4.addSum)
                    {
                        _loc_4 = _loc_5;
                    }
                }
            }
            if (_loc_4 != null)
            {
                return _loc_4.clone();
            }
            return null;
        }// end function

        public function autoEQAtPlayerItemId(param1:int, param2:int) : void
        {
            var _loc_3:BoxGrid = null;
            var _loc_4:ItemInfo = null;
            for each (_loc_3 in this._boxlist)
            {
                
                if (_loc_3.playerItemId == param1)
                {
                    this.equip_player_role_item(_loc_3, null);
                    return;
                }
            }
            for each (_loc_4 in this.item.gridsPack)
            {
                
                if (_loc_4.playerItemId == param1)
                {
                    _data.call(Mod_Item_Base.equip_player_role_item, this.equip_player_role_item_back, [_loc_4.gridId, param2, 0]);
                    return;
                }
            }
            _view.showTip(PackViewLang.CanNoFindEQ);
            return;
        }// end function

        private function get_player_pack_item_list() : void
        {
            _data.call(Mod_Item_Base.get_player_pack_item_list, this.get_player_pack_item_list_back, [], false);
            return;
        }// end function

        private function get_player_pack_item_list_back() : void
        {
            loadAssets("Pack", null, PackViewLang.LaodingPageTip, false, false, this.loadComplete);
            return;
        }// end function

        private function change_pack_item_grid(param1:BoxGrid, param2:BoxGrid) : void
        {
            _data.call(Mod_Item_Base.change_pack_item_grid, this.change_pack_item_grid_back, [param1.id, param2.id]);
            return;
        }// end function

        private function change_pack_item_grid_back() : void
        {
            this.updateGrids();
            return;
        }// end function

        private function drop_pack_grid_item(param1:BoxGrid) : void
        {
            _data.call(Mod_Item_Base.drop_pack_grid_item, this.drop_pack_grid_item_back, [param1.id]);
            this.hideBox(param1);
            return;
        }// end function

        private function drop_pack_grid_item_back() : void
        {
            this.updateGrids();
            if (this.item.result == Mod_Item_Base.HAVE_SOUL)
            {
                _view.showTip(PackViewLang.DeleteErrorSoul);
            }
            return;
        }// end function

        private function equip_player_role_item(param1:BoxGrid, param2:BoxGrid) : void
        {
            if (param1.item.basic.isEquip == false)
            {
                return;
            }
            _data.call(Mod_Item_Base.equip_player_role_item, this.equip_player_role_item_back, [param1.id, _view.roleMsg.playerRoleId, param2 == null ? (0) : (param2.id)]);
            this._updateList.push(param1.itemType);
            _view.roleMsg.show();
            this.hideBox(param1);
            return;
        }// end function

        private function equip_player_role_item_back() : void
        {
            this.updateGrids();
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _view.roleMsg.updateEquipList();
                if (_view.roleMsg.playerRoleId == 0)
                {
                    this._view.toolbar.roleEquipChangeBack(this._ctrl.player.mainPlayerRoleId);
                }
                else
                {
                    this._view.toolbar.roleEquipChangeBack(_view.roleMsg.playerRoleId);
                }
                SoundEffect.play(SoundEffect.Equip);
            }
            else if (this.item.result == Mod_Item_Base.NO_SUITE_ROLE_LEVEL)
            {
                _view.showTip(PackViewLang.EquipErrorLV);
            }
            else if (this.item.result == Mod_Item_Base.NO_SUITE_ROLE_JOB)
            {
                _view.showTip(PackViewLang.EquipErrorJob);
            }
            this.updateGridsTips(this._updateList);
            this._updateList = [];
            return;
        }// end function

        private function player_sell_item(param1:BoxGrid) : void
        {
            if (param1.item.basic.isQuest)
            {
                _view.showTip(PackViewLang.SellErrorTask);
            }
            else if (param1.item.useing)
            {
                _view.showTip(PackViewLang.SellErrorUseing);
            }
            else if (param1.item.basic.isBrand)
            {
                _view.showTip(PackViewLang.SellErrorYuPai);
            }
            else if (param1.item.basic.isPackage)
            {
                _view.showTip(PackViewLang.SellErrorPage);
            }
            else if (param1.item.basic.ingot > 0 || param1.item.basic.price == 0)
            {
                _view.showTip(PackViewLang.SellError);
            }
            else
            {
                _data.call(Mod_Item_Base.player_sell_item, this.player_sell_item_back, [param1.id]);
                this._addmsg = Lang.sprintf(PackViewLang.SellTip, param1.itemName, param1.item.totalprice);
                this.hideBox(param1);
            }
            return;
        }// end function

        private function player_sell_item_back() : void
        {
            this.updateGrids();
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                this.addtoolbarMsg(this._addmsg);
                _view.shop.updateRecycleGrids();
                _view.shop.changeTab(2);
                SoundEffect.play(SoundEffect.SellItem);
            }
            else if (this.item.result == Mod_Item_Base.HAVE_SOUL)
            {
                _view.showTip(PackViewLang.SellErrorSoul);
            }
            else
            {
                _view.showTip(PackViewLang.SellError);
            }
            return;
        }// end function

        private function player_classify_pack() : void
        {
            var _loc_1:* = this.item.autoGrids(this.item.gridsPack, BoxGrid.idPack);
            this.item.gridsPackAuto = _loc_1[0];
            _data.call(Mod_Item_Base.classify_pack, this.player_classify_pack_back, [_loc_1[0].concat(_loc_1[1])]);
            return;
        }// end function

        private function player_classify_pack_back() : void
        {
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                this.updateGrids();
            }
            else
            {
                _view.showTip(PackViewLang.FinishingFails);
            }
            return;
        }// end function

        private function player_use_grid_item(param1:BoxGrid) : void
        {
            this.useItemId = param1.itemId;
            _data.call(Mod_Item_Base.player_use_grid_item, this.player_use_grid_item_back, [param1.id]);
            if (this.useItemId == 1482 && (_ctrl.player.playerInfo.signSuffix == "F0" || _ctrl.player.playerInfo.signSuffix == "F1"))
            {
                _data.call(Mod_Item_Base.take_off_clothes, null, []);
                _view.toolbar.factionClothes();
            }
            else if ((this.useItemId == 1403 || this.useItemId == 1404) && _ctrl.player.mounts == 1482)
            {
                _data.call(Mod_Item_Base.dismount_transport, null, []);
                _view.toolbar.removeBuff = BufferType.Mounts;
            }
            return;
        }// end function

        private function player_use_grid_item_back() : void
        {
            this.updateGrids();
            switch(this.item.result)
            {
                case Mod_Item_Base.ACTION_SUCCESS:
                {
                    if (this.useItemId == 1152)
                    {
                        _view.showTip(PackViewLang.Skill6000, null, TipType.Success);
                    }
                    else if (this.useItemId == 1153)
                    {
                        _view.showTip(PackViewLang.Skill25000, null, TipType.Success);
                    }
                    else if (this.useItemId == 1444)
                    {
                        _view.showTip(PackViewLang.Skill144, null, TipType.Success);
                    }
                    else if (this.useItemId == 1446)
                    {
                        _view.showTip(PackViewLang.Skill146, null, TipType.Success);
                    }
                    else if (this.useItemId == 1488)
                    {
                        _view.showTip(PackViewLang.Skill188, null, TipType.Success);
                    }
                    else if (this.useItemId == this._ctrl.player.giftItemId)
                    {
                        this._ctrl.player.giftItemId = 0;
                    }
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_GRID:
                {
                    _view.showTip(PackViewLang.PageBoxLack);
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_LEVEL:
                {
                    _view.showTip(PackViewLang.LvLack);
                    break;
                }
                case Mod_Item_Base.JOB_NOT_MATCH:
                {
                    _view.showTip(PackViewLang.JobNotMatch);
                    break;
                }
                case Mod_Item_Base.IN_CAMP_WAR:
                {
                    _view.showTip(PackViewLang.InCampWar);
                    break;
                }
                case Mod_Item_Base.IN_FACTION_WAR:
                {
                    _view.showTip(PackViewLang.InFactionWar);
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_FATE_GRID:
                {
                    _view.showTip(PackViewLang.PageFateFull);
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_SOUL_GRID:
                {
                    _view.showTip(PackViewLang.PageSoulFull);
                    break;
                }
                case Mod_Item_Base.END_TIME:
                {
                    _view.showTip(PackViewLang.EndTime);
                    break;
                }
                default:
                {
                    _view.showTip(PackViewLang.UseError);
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function get_player_role_elixir_data(param1:BoxGrid) : void
        {
            this._useBox = param1;
            _data.call(Mod_Item_Base.get_player_role_elixir_data, this.get_player_role_elixir_data_back, [_view.roleMsg.playerRoleId, param1.itemId]);
            return;
        }// end function

        private function get_player_role_elixir_data_back() : void
        {
            var n1:String;
            var n2:String;
            var name:* = _view.roleMsg.roleName;
            var str:String;
            var count:* = this.item.elixirCount;
            var add:* = this.item.elixirValue;
            if (name == "")
            {
                name = this.player.nickname;
            }
            if (add <= 0)
            {
                str = HtmlText.format(name, 16764006, 13);
                str = HtmlText.format(Lang.sprintf(PackViewLang.ImmortalityTip, str), 41193, 13);
                _view.showTip(str);
            }
            else
            {
                n1 = this._useBox.itemName;
                n2 = PackViewLang.WuLi;
                switch(this._useBox.itemType)
                {
                    case ItemType.WuLiDan:
                    {
                        n2 = PackViewLang.WuLi;
                        break;
                    }
                    case ItemType.JueJiDan:
                    {
                        n2 = PackViewLang.JueJi;
                        break;
                    }
                    case ItemType.FaShuDan:
                    {
                        n2 = PackViewLang.FaShu;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                str = Lang.sprintf(PackViewLang.ImmortalityEatTip, HtmlText.yellow(name), HtmlText.yellow(count + ""), HtmlText.yellow(n1), n2 + HtmlText.yellow("+" + add));
                str = HtmlText.white(str);
                _view.alert.showYesNoMsg(str, PackViewLang.Eat, PackViewLang.UnEat, function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    player_use_grid_elixir(_useBox);
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function player_use_grid_elixir(param1:BoxGrid) : void
        {
            _data.call(Mod_Item_Base.player_use_grid_elixir, this.player_use_grid_elixir_back, [param1.id, _view.roleMsg.playerRoleId]);
            return;
        }// end function

        private function player_use_grid_elixir_back() : void
        {
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _view.showTip(PackViewLang.ImmortalitySuccess, "", TipType.Success);
                _view.roleMsg.updateSimpe();
                _view.roleMsg.show();
            }
            this.updateGrids();
            return;
        }// end function

        private function add_pack_grid(param1:int) : void
        {
            _data.call(Mod_Item_Base.add_pack_grid, this.add_pack_grid_back, [param1]);
            return;
        }// end function

        private function add_pack_grid_back() : void
        {
            this.updateGrids();
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _view.showTip(PackViewLang.OpenSuccess, "", TipType.Success);
            }
            else if (this.item.result == Mod_Item_Base.INSUFFICIENT_INGOT)
            {
                _view.showTip(PackViewLang.IngotLack);
            }
            return;
        }// end function

        private function pack_grid_moveto_warehouse(param1:BoxGrid, param2:BoxGrid) : void
        {
            if (param1.item.useing)
            {
                _view.showTip(PackViewLang.MoveToWarehouseError);
            }
            else
            {
                _data.call(Mod_Item_Base.move_pack_grid_item_to_warehouse, this.pack_grid_moveto_warehouse_back, [param1.id, param2 == null ? (0) : (param2.id)]);
                this.hideBox(param1);
            }
            return;
        }// end function

        private function pack_grid_moveto_warehouse_back() : void
        {
            this.updateGrids();
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _view.warehouse.updateGrids();
            }
            else if (this.item.result == Mod_Item_Base.WAREHOUSE_FULL)
            {
                _view.showTip(PackViewLang.WarehouseFull);
            }
            else if (this.item.result == Mod_Item_Base.PACK_FULL)
            {
                _view.showTip(PackViewLang.PageFull);
            }
            return;
        }// end function

        public function get emptyBox() : int
        {
            var _loc_1:String = null;
            var _loc_2:BoxGrid = null;
            for (_loc_1 in this._boxlist)
            {
                
                _loc_2 = this._boxlist[_loc_1];
                if (_loc_2.itemId == 0)
                {
                    return _loc_2.id;
                }
            }
            return -1;
        }// end function

        public static function getClickTip(param1:int, param2:ItemInfo) : Array
        {
            var _loc_3:int = 0;
            var _loc_4:Array = [];
            var _loc_5:* = BoxGrid.isOpenShop || BoxGrid.isOpenRecycle;
            var _loc_6:* = PackViewLang.Sell;
            switch(param2.basic.type_id)
            {
                case ItemType.TouKui:
                case ItemType.WuQi:
                case ItemType.HunQi:
                case ItemType.YiFu:
                case ItemType.HuFu:
                case ItemType.XieZi:
                {
                    _loc_4 = [PackViewLang.Equip, PackViewLang.Show, PackViewLang.Delete];
                    if (_loc_5)
                    {
                        _loc_4.splice(1, 0, _loc_6);
                        ;
                    }
                    break;
                }
                case ItemType.ZuoJi:
                case ItemType.HongYao:
                case ItemType.BianShen:
                case ItemType.skill:
                {
                    _loc_4 = [PackViewLang.Useing, PackViewLang.Delete];
                    if (param2.itemId != 1482)
                    {
                        if (_loc_5)
                        {
                            _loc_4.splice(1, 0, _loc_6);
                            ;
                        }
                    }
                    break;
                }
                case ItemType.WuLiDan:
                case ItemType.JueJiDan:
                case ItemType.FaShuDan:
                {
                    _loc_4 = [PackViewLang.Eat, PackViewLang.Show, PackViewLang.Delete];
                    break;
                }
                case ItemType.LianDanJuanZhou:
                case ItemType.LianQiJuanZhou:
                {
                    _loc_4 = [PackViewLang.Open, PackViewLang.Fusion, PackViewLang.Show, PackViewLang.Delete];
                    if (_loc_5)
                    {
                        _loc_4.splice(1, 0, _loc_6);
                        ;
                    }
                    break;
                }
                case ItemType.ZaWu:
                {
                    _loc_4 = [PackViewLang.Delete];
                    if (_loc_5)
                    {
                        _loc_4.splice(0, 0, _loc_6);
                        ;
                    }
                    break;
                }
                case ItemType.ChengZhangLiBao:
                case ItemType.SuperLiBao:
                case ItemType.HuoDongLiBao:
                {
                    _loc_4 = [PackViewLang.Open];
                    break;
                }
                case ItemType.YuPai:
                {
                    _loc_4 = [PackViewLang.Delete];
                    break;
                }
                case ItemType.Clothes:
                {
                    _loc_4 = [PackViewLang.Useing, PackViewLang.Delete];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_4;
        }// end function

    }
}
