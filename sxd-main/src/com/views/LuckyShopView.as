package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class LuckyShopView extends Base implements IView
    {
        private var _luckyShop:ILuckyShop;
        private var _intCdTime:int;
        private var _blnInBuyLuckyShopItem:Boolean = false;
        private var _dialog:IAlert = null;

        public function LuckyShopView()
        {
            return;
        }// end function

        public function show() : void
        {
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._luckyShop.clear();
            this._dialog.hide();
            this._intCdTime = 0;
            this._view.removeFromTimerProcessList(this.sign);
            this._data.cancelPatch(Mod_Notify_Base.update_lucky_shop_item);
            Helper.gc();
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._luckyShop.content);
            _view.center(sign, this._luckyShop.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._luckyShop == null)
            {
                this._luckyShop = _view.getAssetsObject("LuckyShop", "LuckyShop") as ILuckyShop;
            }
            this.init();
            this._luckyShop.render();
            this.update_lucky_shop_item();
            this.lucky_shop_record_list();
            this.luckyShopItemListCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._luckyShop.tip = this._view.tip.iTip;
            this._luckyShop.drag = this._view.drag.iDrag;
            this._dialog = this._view.alert.iAlert;
            this._luckyShop.onCloseBtn = this.close;
            this._luckyShop.onRefreshBtn = this.refreshLuckyShop;
            this._luckyShop.onBuyBtn = this.buy_lucky_shop_item;
            this._luckyShop.onTextLink = this._view.toolbar.onTextLink;
            return;
        }// end function

        private function timer() : void
        {
            if (this._intCdTime > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this._intCdTime - 1;
                _loc_1._intCdTime = _loc_2;
                this._luckyShop.updateCdTime(this._intCdTime);
            }
            return;
        }// end function

        private function refreshLuckyShop() : void
        {
            var callBack:Function;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    refresh_lucky_shop();
                }
                else
                {
                    _luckyShop.renderRefreshFail();
                }
                if (_dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.RefreshLuckyShop, true);
                }
                return;
            }// end function
            ;
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.RefreshLuckyShop))
            {
                this._dialog.yesLabel = LuckyShopViewLang.DialogYes;
                this._dialog.cancelLabel = LuckyShopViewLang.DialogNo;
                this._dialog.hasCheckbox = true;
                this._dialog.show(Lang.sprintf(LuckyShopViewLang.RefreshLuskShop, HtmlText.yellow(50 + LuckyShopViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            }
            else
            {
                this.refresh_lucky_shop();
            }
            return;
        }// end function

        private function loadData() : void
        {
            var _loc_1:* = this._ctrl.player.mapId;
            var _loc_2:* = TownType.getTownNPCIdByFunc(_loc_1, NPCType.LuckyShopNPC);
            _data.call(Mod_Item_Base.lucky_shop_item_list, this.loadDataCallBack, [_loc_2], false);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("LuckyShop", this.render, LuckyShopViewLang.LoadInfo);
            return;
        }// end function

        private function lucky_shop_item_list() : void
        {
            var _loc_1:* = this._ctrl.player.mapId;
            var _loc_2:* = TownType.getTownNPCIdByFunc(_loc_1, NPCType.LuckyShopNPC);
            _data.call(Mod_Item_Base.lucky_shop_item_list, this.luckyShopItemListCallBack, [_loc_2]);
            return;
        }// end function

        private function luckyShopItemListCallBack() : void
        {
            if (!this._ctrl.luckyShop.isItemDataReturn)
            {
                setTimeout(this.luckyShopItemListCallBack, 20);
                return;
            }
            var _loc_1:* = _ctrl.luckyShop.getLuckyShopItemList();
            this._luckyShop.renderItemList(_loc_1["item_list"]);
            this._luckyShop.renderRefreshInfo(_loc_1);
            this._intCdTime = _loc_1["refresh_seconds"];
            _view.addToTimerProcessList(sign, this.timer);
            return;
        }// end function

        private function lucky_shop_record_list() : void
        {
            _data.call(Mod_Item_Base.lucky_shop_record_list, this.luckyShopRecordListCallBack, []);
            return;
        }// end function

        private function luckyShopRecordListCallBack() : void
        {
            var _loc_1:* = this._ctrl.luckyShop.getLuckyShopRecordList();
            this._luckyShop.renderLuckyRecordList(_loc_1);
            return;
        }// end function

        private function buy_lucky_shop_item() : void
        {
            if (this._blnInBuyLuckyShopItem)
            {
                return;
            }
            this._blnInBuyLuckyShopItem = true;
            var _loc_1:* = this._ctrl.player.mapId;
            var _loc_2:* = TownType.getTownNPCIdByFunc(_loc_1, NPCType.LuckyShopNPC);
            _data.call(Mod_Item_Base.buy_lucky_shop_item, this.buyLuckyShopItemCallBack, [_loc_2, this._luckyShop.itemID]);
            return;
        }// end function

        private function buyLuckyShopItemCallBack() : void
        {
            var _loc_1:* = this._ctrl.luckyShop.buyLuckyShopItem();
            if (_loc_1["result"] == Mod_Item_Base.ACTION_SUCCESS)
            {
                _view.showTip(LuckyShopViewLang.BuySuccess, null, TipType.Success);
                this._luckyShop.renderBuyLuckyShopItem();
                this.lucky_shop_record_list();
                _view.toolbar.playGoodsEffect(URI.goodsIconUrl + this._luckyShop.itemID + ".png");
            }
            else
            {
                _view.showTip(this.message(_loc_1["result"]));
            }
            this._blnInBuyLuckyShopItem = false;
            return;
        }// end function

        private function refresh_lucky_shop() : void
        {
            if (!_view.ingotEnough(50))
            {
                this._luckyShop.renderRefreshFail();
            }
            else
            {
                _data.call(Mod_Item_Base.refresh_lucky_shop, this.refreshLuckyShopCallBack, []);
            }
            return;
        }// end function

        private function refreshLuckyShopCallBack() : void
        {
            if (!this._ctrl.luckyShop.isItemDataReturn)
            {
                setTimeout(this.refreshLuckyShopCallBack, 20);
                return;
            }
            var _loc_1:* = _ctrl.luckyShop.refreshLuckyShop();
            if (_loc_1["result"] == Mod_Item_Base.ACTION_SUCCESS)
            {
                this._luckyShop.renderItemList(_loc_1["item_list"]);
            }
            else
            {
                this._luckyShop.renderRefreshFail();
                _view.showTip(this.message(_loc_1["result"]));
            }
            return;
        }// end function

        private function update_lucky_shop_item() : void
        {
            this._data.patch(Mod_Notify_Base.update_lucky_shop_item, this.updateLuckyShopItemCallBack);
            return;
        }// end function

        private function updateLuckyShopItemCallBack() : void
        {
            this.lucky_shop_item_list();
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Item_Base.ACTION_SUCCESS:
                {
                    _loc_2 = LuckyShopViewLang.ActionSuccess;
                    break;
                }
                case Mod_Item_Base.NPC_ITEM_NO_EXIST:
                {
                    _loc_2 = LuckyShopViewLang.NpcItemNoExist;
                    break;
                }
                case Mod_Item_Base.UN_AVALIABLE_GRID:
                {
                    _loc_2 = LuckyShopViewLang.UnAvaliableGrid;
                    break;
                }
                case Mod_Item_Base.INSUFFICIENT_COIN:
                {
                    _loc_2 = LuckyShopViewLang.InsufficientCoin;
                    break;
                }
                case Mod_Item_Base.ITEM_LIST_REFRESHED:
                {
                    _loc_2 = LuckyShopViewLang.ItemListRefreshed;
                    break;
                }
                case Mod_Item_Base.INSUFFICIENT_INGOT:
                {
                    _loc_2 = LuckyShopViewLang.InsufficientIngot;
                    break;
                }
                case Mod_Item_Base.ACTION_FAILED:
                {
                    _loc_2 = LuckyShopViewLang.ActionFailed;
                    break;
                }
                default:
                {
                    _loc_2 = LuckyShopViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
