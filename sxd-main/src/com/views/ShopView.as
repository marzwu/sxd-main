package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.item.*;
    import com.assist.view.pack.*;
    import com.assist.view.sound.*;
    import com.controllers.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class ShopView extends Base implements IView
    {
        public var shopNpcId:int = 0;
        private var _target:IShopUI;
        private var _boxlist:Array;
        private var _buyMsg:String = "";
        private const _Money1:int = 36100;
        private const _Money2:int = 78500;
        private const _Money3:int = 285000;
        private const _Money4:int = 550000;
        private const _YueLi1:int = 6000;
        private const _YueLi2:int = 25000;
        private var _buyMsg1:String = "";
        private var _clickBox:BoxGrid;
        private static const TabBuySell:int = 1;
        private static const TabRecycling:int = 2;

        public function ShopView()
        {
            this._boxlist = [];
            return;
        }// end function

        public function show() : void
        {
            if (inStage)
            {
                return;
            }
            this.shop_npc_items();
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            _view.pack.changeShop(false);
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

        private function loadComplete() : void
        {
            var _loc_1:BoxGrid = null;
            var _loc_2:int = 0;
            var _loc_3:Array = null;
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("Shop", "ShopPanel") as IShopUI;
                this._target.onClose = this.close;
                this._target.onTabCilck = this.tabClick;
                this._target.onPageCilck = this.updatePageList;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
                _loc_3 = this._target.boxList;
                _loc_2 = 0;
                while (_loc_2 < 15)
                {
                    
                    _loc_1 = new BoxGrid(_loc_2, BoxGrid.typeShop, _loc_3[_loc_2]);
                    _loc_1.onClick = this.boxClick;
                    _loc_1.onDoubleClick = this.boxDoubleClick;
                    _loc_1.onDrag = this.boxDrag;
                    _loc_1.onDragView = this.boxDragView;
                    this._boxlist[_loc_1.id] = _loc_1;
                    _loc_2++;
                }
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            this.shopNpcId = this.item.shopNPCId;
            this._target.tab = TabBuySell;
            this.tabClick();
            return;
        }// end function

        public function changeTab(param1:int) : void
        {
            if (this._target.tab != param1)
            {
                this._target.tab = param1;
                this.tabClick();
            }
            return;
        }// end function

        private function tabClick(param1:int = 0) : void
        {
            if (this._target.tab == TabBuySell)
            {
                _view.pack.changeShop(true);
                this.updatePageList(1);
            }
            else
            {
                _view.pack.changeRecycle(true);
                this.get_npc_recycle_item_list();
            }
            return;
        }// end function

        private function boxDrag(param1:BoxGrid, param2:BoxGrid) : void
        {
            if (param2.isPackBox == false)
            {
                return;
            }
            if (this._target.tab == TabBuySell)
            {
                this.player_buy_npc_item(this.shopNpcId, param1.item, param2.id);
            }
            else if (this._target.tab == TabRecycling)
            {
                this.player_buy_back_item(param1.item, param2.id);
            }
            return;
        }// end function

        private function boxDragView(param1:BoxGrid, param2) : void
        {
            if (param2 === _view.pack.target)
            {
                if (this._target.tab == TabBuySell)
                {
                    this.player_buy_npc_item(this.shopNpcId, param1.item, 0);
                }
                else if (this._target.tab == TabRecycling)
                {
                    this.player_buy_back_item(param1.item, 0);
                }
            }
            return;
        }// end function

        private function boxDoubleClick(param1:BoxGrid) : void
        {
            if (this._target.tab == TabBuySell)
            {
                this.player_buy_npc_item(this.shopNpcId, param1.item, 0);
            }
            else if (this._target.tab == TabRecycling)
            {
                this.player_buy_back_item(param1.item, 0);
            }
            return;
        }// end function

        private function boxClick(param1:BoxGrid) : void
        {
            if (param1.itemId == 0)
            {
                return;
            }
            if (this._target.tab == TabBuySell)
            {
                this.showClickTip(param1, [ShopViewLang.Buy]);
            }
            else if (this._target.tab == TabRecycling)
            {
                this.showClickTip(param1, [ShopViewLang.Repurchase]);
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
            if (param1 == ShopViewLang.Buy)
            {
                this.player_buy_npc_item(this.shopNpcId, this._clickBox.item, 0);
            }
            else if (param1 == ShopViewLang.Repurchase)
            {
                this.player_buy_back_item(this._clickBox.item, 0);
            }
            return;
        }// end function

        private function tipRemoveStageHandler() : void
        {
            this._clickBox.lockLight = false;
            return;
        }// end function

        private function updatePageList(param1:int) : void
        {
            var _loc_2:Array = null;
            var _loc_5:BoxGrid = null;
            var _loc_3:* = (param1 - 1) * 15;
            if (this._target.tab == TabBuySell)
            {
                _loc_2 = this.item.gridsShop;
            }
            else if (this._target.tab == TabRecycling)
            {
                _loc_2 = this.item.gridsRecyle;
            }
            var _loc_4:* = _loc_2.length;
            if (_loc_2.length == 0)
            {
                _loc_4 = 1;
                ;
            }
            if (_loc_4 >= 135)
            {
                _loc_4 = 135;
                ;
            }
            this._target.initPage(Math.ceil(_loc_4 / 15), param1);
            for each (_loc_5 in this._boxlist)
            {
                
                _loc_5.item = _loc_2[_loc_3];
                _loc_3++;
            }
            return;
        }// end function

        public function updateRecycleGrids() : void
        {
            if (this._target.tab == TabRecycling)
            {
                this.updatePageList(1);
            }
            return;
        }// end function

        private function shop_npc_items() : void
        {
            _data.call(Mod_Item_Base.get_npc_item_list, this.shop_npc_items_back, [this.shopNpcId], false);
            return;
        }// end function

        private function shop_npc_items_back() : void
        {
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                loadAssets("Shop", this.loadComplete, ShopViewLang.LaodingShopTip, true);
            }
            else if (this.item.result == Mod_Item_Base.INSUFFICIENT_INGOT)
            {
                this.close();
                _view.showTip(ShopViewLang.IngotLack);
            }
            else
            {
                this.close();
            }
            return;
        }// end function

        private function player_buy_npc_item(param1:int, param2:ItemInfo, param3:int) : void
        {
            this._buyMsg1 = "";
            if (this.item.shopType == NPCType.CardBuyNPC)
            {
                if (param2.itemId == 1412)
                {
                    this._buyMsg = Lang.sprintf(ShopViewLang.BuyTipYuPai, this._Money1 + ShopViewLang.Money, param2.basic.card_name + param2.basic.card_num);
                    this._buyMsg1 = ShopViewLang.HuoDe + this._Money1 + ShopViewLang.Money;
                }
                else if (param2.itemId == 1413)
                {
                    this._buyMsg = Lang.sprintf(ShopViewLang.BuyTipYuPai, this._Money2 + ShopViewLang.Money, param2.basic.card_name + param2.basic.card_num);
                    this._buyMsg1 = ShopViewLang.HuoDe + this._Money2 + ShopViewLang.Money;
                }
                else if (param2.itemId == 1414)
                {
                    this._buyMsg = Lang.sprintf(ShopViewLang.BuyTipYuPai, this._Money3 + ShopViewLang.Money, param2.basic.card_name + param2.basic.card_num);
                    this._buyMsg1 = ShopViewLang.HuoDe + this._Money3 + ShopViewLang.Money;
                }
                else if (param2.itemId == 1415)
                {
                    this._buyMsg = Lang.sprintf(ShopViewLang.BuyTipYuPai, this._Money4 + ShopViewLang.Money, param2.basic.card_name + param2.basic.card_num);
                    this._buyMsg1 = ShopViewLang.HuoDe + this._Money4 + ShopViewLang.Money;
                }
                else if (param2.itemId == 1152)
                {
                    this._buyMsg = Lang.sprintf(ShopViewLang.BuyTipYuPai, this._YueLi1 + ShopViewLang.YueLi, param2.basic.card_name + param2.basic.card_num);
                    this._buyMsg1 = ShopViewLang.HuoDe + this._YueLi1 + ShopViewLang.YueLi;
                }
                else if (param2.itemId == 1153)
                {
                    this._buyMsg = Lang.sprintf(ShopViewLang.BuyTipYuPai, this._YueLi2 + ShopViewLang.YueLi, param2.basic.card_name + param2.basic.card_num);
                    this._buyMsg1 = ShopViewLang.HuoDe + this._YueLi2 + ShopViewLang.YueLi;
                }
                else
                {
                    this._buyMsg = Lang.sprintf(ShopViewLang.BuyTipYuPai, param2.name, param2.basic.card_name + param2.basic.card_num);
                }
            }
            else if (param2.basic.ingot > 0)
            {
                if (_view.ingotEnough(param2.basic.ingot) == false)
                {
                    return;
                }
                this._buyMsg = Lang.sprintf(ShopViewLang.BuyTipIngot, param2.name, param2.basic.ingot);
            }
            else
            {
                if (_view.coinEnough(param2.totalprice) == false)
                {
                    return;
                }
                this._buyMsg = Lang.sprintf(ShopViewLang.BuyTipCoin, param2.name, param2.totalprice);
            }
            _data.call(Mod_Item_Base.player_buy_npc_item, this.player_buy_npc_item_back, [param1, param2.itemId, param3]);
            return;
        }// end function

        private function player_buy_npc_item_back() : void
        {
            switch(this.item.result)
            {
                case Mod_Item_Base.ACTION_SUCCESS:
                {
                    if (this._buyMsg1 != "")
                    {
                        _view.showTip(this._buyMsg1, null, TipType.Success);
                    }
                    _view.chat.addSystemMessage(this._buyMsg);
                    _view.pack.updateGrids();
                    SoundEffect.play(SoundEffect.SellItem);
                    break;
                }
                case Mod_Item_Base.INSUFFICIENT_COIN:
                {
                    _view.showTip(ShopViewLang.CoinLack);
                    break;
                }
                case Mod_Item_Base.INSUFFICIENT_CARD:
                {
                    _view.showTip(ShopViewLang.YuPaiLack);
                    break;
                }
                case Mod_Item_Base.UN_AVALIABLE_GRID:
                {
                    _view.showTip(ShopViewLang.PageFull);
                    break;
                }
                case Mod_Item_Base.INSUFFICIENT_INGOT:
                {
                    _view.showTip(ShopViewLang.IngotLack);
                    break;
                }
                default:
                {
                    _view.showTip(ShopViewLang.BuyError);
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function get_npc_recycle_item_list() : void
        {
            _data.call(Mod_Item_Base.get_npc_recycle_item_list, this.get_npc_recycle_item_list_back, [], false);
            return;
        }// end function

        private function get_npc_recycle_item_list_back() : void
        {
            if (this._target.tab != TabRecycling)
            {
                return;
            }
            var _loc_1:* = this.item.gridsRecyle;
            this.updatePageList(1);
            return;
        }// end function

        private function player_buy_back_item(param1:ItemInfo, param2:int) : void
        {
            if (_view.coinEnough(param1.totalprice) == false)
            {
                return;
            }
            this._buyMsg = Lang.sprintf(ShopViewLang.BuyTipCoin, param1.name, param1.totalprice);
            _data.call(Mod_Item_Base.player_buy_back_item, this.player_buy_back_item_back, [param1.playerItemId, param2]);
            return;
        }// end function

        private function player_buy_back_item_back() : void
        {
            switch(this.item.result)
            {
                case Mod_Item_Base.ACTION_SUCCESS:
                {
                    _view.chat.addSystemMessage(this._buyMsg);
                    this.updatePageList(1);
                    _view.pack.updateGrids();
                    SoundEffect.play(SoundEffect.SellItem);
                    break;
                }
                case Mod_Item_Base.INSUFFICIENT_COIN:
                {
                    _view.showTip(ShopViewLang.CoinLack);
                    break;
                }
                case Mod_Item_Base.UN_AVALIABLE_GRID:
                {
                    _view.showTip(ShopViewLang.PageFull);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
