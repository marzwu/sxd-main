package com.views
{
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.pack.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.utils.*;

    public class RefiningFurnaceView extends Base implements IView
    {
        private var _refiningFurnace:IRefiningFurnace;
        private var _itemBox:BoxGrid;

        public function RefiningFurnaceView()
        {
            return;
        }// end function

        public function show() : void
        {
            loadAssets("Furnace", null, FurnaceMapViewLang.LoadRefiningFurnace, false, false, this.loadComplete);
            _data.patch(Mod_Item_Base.drag_furnace_item, this.updateBox);
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            _data.cancelPatch(Mod_Item_Base.drag_furnace_item);
            return;
        }// end function

        private function loadComplete() : void
        {
            if (!this._refiningFurnace)
            {
                this._refiningFurnace = _view.getAssetsObject("Furnace", "RefiningFurnace") as IRefiningFurnace;
                this._refiningFurnace.onClose(this.onClose);
                this._refiningFurnace.onRefining = this.onRefining;
                this._refiningFurnace.onTip = this.onTip;
                this._refiningFurnace.onSetCookie(this.onSetCookie);
                this._refiningFurnace.onGetCookie(this.onGetCookie);
                _view.drag.iDrag.addTarget(this._refiningFurnace.dragTitleBar, this._refiningFurnace.content);
                this._itemBox = new BoxGrid(0, BoxGrid.typeFurnace, this._refiningFurnace.getPageBox());
                this._itemBox.onDoubleClick = this.boxDoubleClick;
                this._itemBox.onDrag = this.boxDrag;
                this._itemBox.onDragView = this.boxDragView;
            }
            _popup.addView(this, this._refiningFurnace.content);
            _view.pack.show();
            this._refiningFurnace.playerLv = _ctrl.player.level;
            _data.call(Mod_Item_Base.open_furnace, this.updateBox, []);
            this._refiningFurnace.vipLevel = _ctrl.player.vipLevel;
            return;
        }// end function

        public function updateBox() : void
        {
            this._refiningFurnace.purpleRoleList = _ctrl.furnaceMap.curPurpleList;
            var _loc_1:* = new ItemInfo();
            this._refiningFurnace.boxItemId = _ctrl.furnaceMap.iInfoArr[1];
            _loc_1.parsePack(_ctrl.furnaceMap.iInfoArr);
            this._itemBox.item = _loc_1;
            _view.pack.updateGrids();
            return;
        }// end function

        private function boxDoubleClick(param1:BoxGrid) : void
        {
            if (_ctrl.player.packNum <= 0)
            {
                _view.showTip(FurnaceMapViewLang.BAG_FULL);
                return;
            }
            var _loc_2:* = _view.pack.emptyBox;
            if (_loc_2 != -1)
            {
                _data.call(Mod_Item_Base.drag_furnace_item, this.updateBox, [Mod_Item_Base.DRAG_TO_BAG, _loc_2]);
            }
            return;
        }// end function

        private function boxDrag(param1:BoxGrid, param2:BoxGrid) : void
        {
            _data.call(Mod_Item_Base.drag_furnace_item, this.updateBox, [Mod_Item_Base.DRAG_TO_BAG, param2.id]);
            return;
        }// end function

        public function bDragErrItem(param1:BoxGrid) : Boolean
        {
            var _loc_2:ItemInfo = null;
            var _loc_3:Array = null;
            var _loc_4:String = null;
            var _loc_5:int = 0;
            var _loc_6:ItemInfo = null;
            if (_ctrl.player.level <= FurnaceType.ItemLevel)
            {
                if (param1.itemId != FurnaceType.PurpleItemId)
                {
                    _loc_2 = new ItemInfo();
                    _loc_2.parseSee(FurnaceType.PurpleItemId);
                    _view.showTip(FurnaceMapViewLang.Drag_Err_Item + HtmlText.purple(_loc_2.name));
                    return true;
                }
            }
            if (_ctrl.player.level > FurnaceType.ItemLevel)
            {
                if (!this.canUserItem(param1.itemId))
                {
                    _loc_3 = FurnaceType.itemList;
                    _loc_4 = "";
                    _loc_5 = 0;
                    while (_loc_5 < _loc_3.length)
                    {
                        
                        if (_loc_5 != 0)
                        {
                            _loc_4 = _loc_4 + "、";
                        }
                        _loc_6 = new ItemInfo();
                        _loc_6.parseSee(_loc_3[_loc_5].srcItemId);
                        _loc_4 = _loc_4 + ("<font color=\'#" + _loc_6.color.toString(16) + "\'>" + _loc_6.name + "</font>");
                        _loc_5++;
                    }
                    _view.showTip(FurnaceMapViewLang.Drag_Err_Item + _loc_4);
                    return true;
                }
            }
            return false;
        }// end function

        private function canUserItem(param1:int) : Boolean
        {
            var _loc_2:* = FurnaceType.itemList;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3].srcItemId == param1)
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        private function boxDragView(param1:BoxGrid, param2) : void
        {
            return;
        }// end function

        private function onClose() : void
        {
            _popup.closeView(this);
            _data.cancelPatch(Mod_Item_Base.drag_furnace_item);
            return;
        }// end function

        private function onRefining(param1:int, param2:int) : void
        {
            var callback:Function;
            var itemId:* = param1;
            var useMoney:* = param2;
            if (_ctrl.player.packNum <= 0)
            {
                _view.showTip(FurnaceMapViewLang.BAG_FULL);
                this._refiningFurnace.produceItems = [];
                return;
            }
            if (useMoney == 0)
            {
                this.refiningToServer(itemId, useMoney);
                return;
            }
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.ThreeFurnace))
            {
                this.dialog.yesLabel = FurnaceMapViewLang.Btn_Yes;
                this.dialog.cancelLabel = FurnaceMapViewLang.Btn_No;
                this.dialog.hasCheckbox = true;
                callback = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    refiningToServer(itemId, useMoney);
                }
                else
                {
                    _refiningFurnace.produceItems = [];
                }
                if (dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.ThreeFurnace, true);
                }
                return;
            }// end function
            ;
                this.dialog.show(FurnaceMapViewLang.ConsumerTips, AlertButtonType.Yes | AlertButtonType.Cancel, callback);
            }
            else
            {
                this.refiningToServer(itemId, useMoney);
            }
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        private function refiningToServer(param1:int, param2:int) : void
        {
            _data.call(Mod_Furnace_Base.make_favor_item, this.refiningBack, [param1, param2]);
            return;
        }// end function

        private function refiningBack() : void
        {
            var _loc_2:Array = null;
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_6:Object = null;
            var _loc_7:ItemInfo = null;
            var _loc_1:* = _ctrl.furnaceMap.result;
            if (_loc_1 == Mod_Furnace_Base.MAKE_SUCCESS)
            {
                _loc_2 = new Array();
                _loc_3 = _ctrl.furnaceMap.makeResult;
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    _loc_5 = "";
                    _loc_6 = _loc_3[_loc_4];
                    if (_loc_6.itemType == Mod_Furnace_Base.MRT_SCRAP)
                    {
                        _loc_5 = FurnaceMapViewLang.MRT_SCRAP + "+" + _loc_6.result_param;
                        _loc_2.push(0);
                        setTimeout(this.colorText, _loc_4 * 350, _loc_5, HtmlText.Purple);
                    }
                    else if (_loc_6.itemType == Mod_Furnace_Base.MRT_STONE)
                    {
                        _loc_5 = FurnaceMapViewLang.MRT_STONE + "+" + _loc_6.result_param;
                        setTimeout(this.colorText, _loc_4 * 350, _loc_5, HtmlText.Green);
                    }
                    else if (_loc_6.itemType == Mod_Furnace_Base.MRT_ITEM)
                    {
                        _loc_7 = new ItemInfo();
                        _loc_7.parseSee(_loc_6.result_param);
                        _loc_5 = _loc_5 + (_loc_7.name + "+1");
                        _loc_2.push(_loc_6.result_param);
                        _view.toolbar.playGoodsEffect(_loc_7.iconUrl);
                        setTimeout(this.colorText, _loc_4 * 350, _loc_5, HtmlText.Yellow);
                    }
                    _loc_4++;
                }
                this._refiningFurnace.produceItems = _loc_2;
            }
            else if (_loc_1 == Mod_Furnace_Base.NOT_ENOUGH_INGOT)
            {
                _view.showTip(FurnaceMapViewLang.NotEnoughIngot);
                this._refiningFurnace.produceItems = [];
            }
            else if (_loc_1 == Mod_Furnace_Base.NOT_ENOUGH_COIN)
            {
                _view.showTip(FurnaceMapViewLang.NOT_ENOUGH_COIN);
                this._refiningFurnace.produceItems = [];
            }
            else if (_loc_1 == Mod_Furnace_Base.BAG_FULL)
            {
                _view.showTip(FurnaceMapViewLang.BAG_FULL);
                this._refiningFurnace.produceItems = [];
            }
            return;
        }// end function

        private function colorText(param1:String, param2:uint) : void
        {
            var _loc_3:* = new TextAnimation();
            _loc_3.color = param2;
            _loc_3.size = 14;
            _loc_3.speed = -1;
            _loc_3.bold = true;
            _loc_3.point(150, 320);
            _loc_3.startAlphaNum = 60;
            _loc_3.alphaNum = 1;
            _loc_3.textInfo = param1;
            _loc_3.target = this._refiningFurnace.content;
            _loc_3.start();
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2 = null) : void
        {
            var _loc_3:Sprite = null;
            if (param2 == "" || param2 == null)
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
                _loc_3 = param1 as Sprite;
            }
            return;
        }// end function

        private function onSetCookie(param1:Object) : void
        {
            _view.setCookie("RefiningFurnaceView", param1);
            return;
        }// end function

        private function onGetCookie() : Object
        {
            return _view.getCookie("RefiningFurnaceView");
        }// end function

    }
}
