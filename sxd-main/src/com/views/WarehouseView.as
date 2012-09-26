package com.views
{
    import com.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.item.*;
    import com.assist.view.pack.*;
    import com.controllers.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class WarehouseView extends Base implements IView
    {
        public var npcId:int = 0;
        private var _target:IPack;
        private var _boxlist:Array;

        public function WarehouseView()
        {
            this._boxlist = [];
            return;
        }// end function

        public function show() : void
        {
            if (this.inStage)
            {
                return;
            }
            this.get_player_warehouse_grids(this.npcId);
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            _view.pack.changeWareHouse(false);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function get item() : ItemController
        {
            return _ctrl.item;
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
                this._target = _view.getAssetsObject("Pack", "Warehouse") as IPack;
                this._target.onClose = this.close;
                this._target.onBtn3 = this.openBox;
                this._target.onBtn2 = this.player_classify_warehouse;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
                _loc_3 = this._target.boxList;
                _loc_2 = 0;
                while (_loc_2 < 54)
                {
                    
                    _loc_1 = new BoxGrid(BoxGrid.idWareHouse + _loc_2, BoxGrid.typeWareHouse, _loc_3[_loc_2]);
                    _loc_1.onClick = this.boxClick;
                    _loc_1.onDoubleClick = this.boxDoubleClick;
                    _loc_1.onDrag = this.boxDrag;
                    _loc_1.onDragView = this.boxDragView;
                    _loc_1.onRemove = this.boxRemove;
                    this._boxlist[_loc_1.id] = _loc_1;
                    _loc_2++;
                }
            }
            if (this.inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            _view.pack.changeWareHouse(true);
            _loc_3 = this.item.gridsWarehouse;
            for each (_loc_1 in this._boxlist)
            {
                
                _loc_1.item = _loc_3[_loc_1.id] as ItemInfo;
            }
            this._target.updateBoxCount(54);
            return;
        }// end function

        private function openBox(param1:BoxGrid = null) : void
        {
            var openToGrid:int;
            var openIngot:int;
            var list:Array;
            var ingot:int;
            var box:* = param1;
            var i:* = BoxGrid.idWareHouse + 18;
            var max:* = BoxGrid.idWareHouse + 54;
            openToGrid;
            openIngot;
            list;
            if (box == null)
            {
                while (i < max)
                {
                    
                    box = this._boxlist[i];
                    if (box.isLock)
                    {
                        openIngot = this.item.ingot_warehouse;
                        openToGrid = box.id;
                        box.lockLight = true;
                        list.push(box);
                        break;
                    }
                    i = (i + 1);
                }
            }
            else
            {
                ingot = this.item.ingot_warehouse;
                openIngot;
                openToGrid = box.id;
                i = box.id;
                while (i > 0)
                {
                    
                    box = this._boxlist[i];
                    if (box.isLock)
                    {
                        list.push(box);
                        box.lockLight = true;
                        openIngot = openIngot + ingot;
                        if (ingot == 1)
                        {
                            ingot;
                        }
                        else
                        {
                            ingot = ingot + 2;
                        }
                    }
                    else
                    {
                        break;
                    }
                    i = (i - 1);
                }
            }
            _view.alert.showYesNoMsg(Lang.sprintf(WarehouseViewLang.AskOpenBox, HtmlText.yellow(openIngot + WarehouseViewLang.Ingot), list.length), WarehouseViewLang.Yes, WarehouseViewLang.No, function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes && _view.ingotEnough(openIngot))
                {
                    add_warehouse_grid(openToGrid);
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

        private function boxDrag(param1:BoxGrid, param2:BoxGrid) : void
        {
            if (param2.isPackBox)
            {
                this.move_warehouse_grid_item_to_pack(param1, param2);
            }
            else if (param2.isWareHouseBox)
            {
                this.change_warehouse_item_grid(param1, param2);
            }
            return;
        }// end function

        private function boxDragView(param1:BoxGrid, param2) : void
        {
            if (param2 === _view.pack.target)
            {
                this.move_warehouse_grid_item_to_pack(param1, null);
            }
            return;
        }// end function

        private function boxRemove(param1:BoxGrid) : void
        {
            var box1:* = param1;
            if (box1.item.basic.isQuest)
            {
                _view.showTip(WarehouseViewLang.DeleteErrorTask);
            }
            else if (box1.item.basic.isPackage)
            {
                _view.showTip(WarehouseViewLang.DeleteErrorPage);
            }
            else
            {
                box1.addFilters();
                _view.alert.showYesNoMsg(WarehouseViewLang.AskDelete, WarehouseViewLang.Yes, WarehouseViewLang.No, function (param1:uint) : void
            {
                box1.removeFilters();
                if (param1 == AlertButtonType.Yes)
                {
                    drop_warehouse_grid_item(box1);
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function boxClick(param1:BoxGrid) : void
        {
            if (param1.isLock)
            {
                this.openBox(param1);
            }
            return;
        }// end function

        private function boxDoubleClick(param1:BoxGrid) : void
        {
            this.move_warehouse_grid_item_to_pack(param1, null);
            if (_view.pack.inStage == false)
            {
                _view.pack.show();
            }
            return;
        }// end function

        public function updateGrids() : void
        {
            var _loc_2:BoxGrid = null;
            if (this.inStage == false)
            {
                return;
            }
            var _loc_1:* = this.item.gridsWarehouse;
            for each (_loc_2 in this._boxlist)
            {
                
                _loc_2.item = _loc_1[_loc_2.id] as ItemInfo;
            }
            this._target.updateBoxCount(54);
            return;
        }// end function

        private function hideBox(param1:BoxGrid) : void
        {
            if (param1 && param1.itemId != 0)
            {
                this.item.pushWareHouse(param1.id);
                param1.hideItem();
            }
            return;
        }// end function

        private function get_player_warehouse_grids(param1:int) : void
        {
            _data.call(Mod_Item_Base.get_player_warehouse_grids, this.get_player_warehouse_grids_back, [param1], false);
            return;
        }// end function

        private function get_player_warehouse_grids_back() : void
        {
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                loadAssets("Pack", this.loadComplete, WarehouseViewLang.LaodingWareHouseTip);
            }
            else
            {
                this.close();
            }
            return;
        }// end function

        private function add_warehouse_grid(param1:int) : void
        {
            _data.call(Mod_Item_Base.add_warehouse_grid, this.add_warehouse_grid_back, [param1]);
            return;
        }// end function

        private function add_warehouse_grid_back() : void
        {
            this.updateGrids();
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _view.showTip(WarehouseViewLang.OpenSuccess, "", TipType.Success);
            }
            else if (this.item.result == Mod_Item_Base.INSUFFICIENT_INGOT)
            {
                _view.showTip(WarehouseViewLang.IngotLack);
            }
            return;
        }// end function

        private function player_classify_warehouse() : void
        {
            var _loc_1:* = this.item.autoGrids(this.item.gridsWarehouse, BoxGrid.idWareHouse);
            this.item.gridsWarehouseAuto = _loc_1[0];
            _data.call(Mod_Item_Base.classify_warehouse, this.classify_warehouse_back, [_loc_1[0].concat(_loc_1[1])]);
            return;
        }// end function

        private function classify_warehouse_back() : void
        {
            var _loc_1:Array = null;
            var _loc_2:BoxGrid = null;
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _loc_1 = this.item.gridsWarehouse;
                for each (_loc_2 in this._boxlist)
                {
                    
                    _loc_2.item = _loc_1[_loc_2.id] as ItemInfo;
                }
                this._target.updateBoxCount(54);
            }
            else
            {
                _view.showTip(WarehouseViewLang.FinishingFails);
            }
            return;
        }// end function

        private function drop_warehouse_grid_item(param1:BoxGrid) : void
        {
            _data.call(Mod_Item_Base.drop_warehouse_grid_item, this.drop_warehouse_grid_item_back, [param1.id]);
            this.hideBox(param1);
            return;
        }// end function

        private function drop_warehouse_grid_item_back() : void
        {
            this.updateGrids();
            if (this.item.result == Mod_Item_Base.HAVE_SOUL)
            {
                _view.showTip(WarehouseViewLang.DeleteErrorSoul);
            }
            return;
        }// end function

        private function move_warehouse_grid_item_to_pack(param1:BoxGrid, param2:BoxGrid) : void
        {
            _data.call(Mod_Item_Base.move_warehouse_grid_item_to_pack, this.move_warehouse_grid_item_to_pack_back, [param1.id, param2 == null ? (0) : (param2.id)]);
            this.hideBox(param1);
            return;
        }// end function

        private function move_warehouse_grid_item_to_pack_back() : void
        {
            this.updateGrids();
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _view.pack.updateGrids();
            }
            else if (this.item.result == Mod_Item_Base.PACK_FULL)
            {
                _view.showTip(WarehouseViewLang.PageFull);
            }
            else if (this.item.result == Mod_Item_Base.WAREHOUSE_FULL)
            {
                _view.showTip(WarehouseViewLang.WarehouseFull);
            }
            return;
        }// end function

        private function change_warehouse_item_grid(param1:BoxGrid, param2:BoxGrid) : void
        {
            _data.call(Mod_Item_Base.change_warehouse_item_grid, this.change_warehouse_item_grid_back, [param1.id, param2 == null ? (0) : (param2.id)]);
            this.hideBox(param1);
            return;
        }// end function

        private function change_warehouse_item_grid_back() : void
        {
            this.updateGrids();
            return;
        }// end function

    }
}
