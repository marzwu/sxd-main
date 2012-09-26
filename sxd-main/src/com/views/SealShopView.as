package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class SealShopView extends Base implements IView
    {
        private var _sealShop:ISealShop;
        public var npcId:int;
        public var bFirstFlag:Boolean = false;
        private static const intJadeId:int = 1197;

        public function SealShopView()
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
            this._sealShop.clear();
            return;
        }// end function

        private function loadData() : void
        {
            this.get_the_item_num(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("SealShop", this.render, SealShopViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._sealShop.content);
            _view.center(sign, this._sealShop.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._sealShop == null)
            {
                this._sealShop = _view.getAssetsObject("SealShop", "SealShop") as ISealShop;
            }
            this.init();
            this.getSealList();
            this.getTheItemNumCallBack();
            this.showUI();
            if (this.bFirstFlag)
            {
                setTimeout(this.onOpenRealm, 100);
            }
            this.bFirstFlag = false;
            return;
        }// end function

        private function init() : void
        {
            this._sealShop.tip = this._view.tip.iTip;
            this._sealShop.drag = this._view.drag.iDrag;
            this._sealShop.onClose = this.close;
            this._sealShop.onConvert = this.get_soul;
            this._sealShop.onChange = this.onChange;
            this._sealShop.init();
            this._sealShop.onOpenRealm = this.onOpenRealm;
            return;
        }// end function

        private function onOpenRealm() : void
        {
            _data.call(Mod_Item_Base.swap_card, this.onOpenRealmBack, []);
            return;
        }// end function

        private function onOpenRealmBack() : void
        {
            this._sealShop.setRealmInfo(_ctrl.item.statePoint, _ctrl.item.stateLv, false);
            return;
        }// end function

        private function onChange() : void
        {
            if (_ctrl.player.packNum <= 0)
            {
                _view.showTip(SealShopViewLang.PackFull);
                return;
            }
            if (_ctrl.item.statePoint < 20)
            {
                _view.showTip(SealShopViewLang.NotEnoughStatePoint);
                return;
            }
            _data.call(Mod_Item_Base.tian_di_yu_pai, this.onChangeBack, []);
            return;
        }// end function

        private function onChangeBack() : void
        {
            var _loc_1:ItemInfo = null;
            this._sealShop.setRealmInfo(_ctrl.item.statePoint, _ctrl.item.stateLv, true);
            this.getTheItemNum();
            switch(_ctrl.item.result)
            {
                case Mod_Item_Base.SUCCESS:
                {
                    _loc_1 = new ItemInfo();
                    _loc_1.parseSee(1197);
                    _view.toolbar.playGoodsEffect(_loc_1.iconUrl);
                    break;
                }
                case Mod_Item_Base.PACK_FULL:
                {
                    _view.showTip(SealShopViewLang.PackFull);
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_STATE_POINT:
                {
                    _view.showTip(SealShopViewLang.NotEnoughStatePoint);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getSealList() : void
        {
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            var _loc_1:* = TownNPCType.getNPCSoulIdList(this.npcId);
            var _loc_2:Array = [];
            for each (_loc_3 in _loc_1)
            {
                
                _loc_4 = {};
                _loc_4["soul_id"] = _loc_3;
                _loc_4["soul_name"] = SoulType.getSoulName(_loc_4["soul_id"]);
                _loc_4["color"] = HtmlText.Yellow;
                _loc_4["jade_num"] = SoulType.getItemNumBySoulId(_loc_4["soul_id"]);
                _loc_4["type_id"] = SoulType.getSoulTypeIdByAllTypeId(SoulType.getSoulSubTypeId(_loc_4["soul_id"]));
                _loc_4["type_name"] = SoulType.getTypeName(_loc_4["type_id"]);
                _loc_4["url"] = URI.getSoulsIconUrl(_loc_4["soul_id"]);
                _loc_2.push(_loc_4);
            }
            _loc_2.sortOn(["type_id", "soul_id"], Array.NUMERIC);
            this._sealShop.renderSealShop(_loc_2);
            return;
        }// end function

        private function getTheItemNum() : void
        {
            this.get_the_item_num(this.getTheItemNumCallBack);
            return;
        }// end function

        private function get_the_item_num(param1:Function) : void
        {
            _data.call(Mod_Item_Base.get_the_item_num, param1, [intJadeId]);
            return;
        }// end function

        private function getTheItemNumCallBack() : void
        {
            var _loc_1:* = this._ctrl.item.getTheItemNum;
            this._sealShop.renderJadeInfo(_loc_1["total_num"]);
            return;
        }// end function

        private function get_soul(param1:int) : void
        {
            _data.call(Mod_Item_Base.get_soul, this.getSoulCallBack, [this.npcId, param1]);
            return;
        }// end function

        private function getSoulCallBack() : void
        {
            var _loc_1:* = this._ctrl.item.getSoul;
            if (_loc_1["result"] == Mod_Item_Base.SUCCESS)
            {
                this._view.showTip(this.message(_loc_1["result"]), null, TipType.Success);
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            this.getTheItemNum();
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Item_Base.SUCCESS:
                {
                    _loc_2 = SealShopViewLang.Success;
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_ITEM:
                {
                    _loc_2 = SealShopViewLang.NotEnoughItem;
                    break;
                }
                case Mod_Item_Base.NOT_GRID:
                {
                    _loc_2 = SealShopViewLang.NotGrid;
                    break;
                }
                case Mod_Item_Base.TOWN_NPC_ERROR:
                {
                    _loc_2 = SealShopViewLang.TownNpcError;
                    break;
                }
                default:
                {
                    _loc_2 = SealShopViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
