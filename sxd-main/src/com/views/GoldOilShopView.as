package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class GoldOilShopView extends Base implements IView
    {
        private var _goldOilShop:IGoldOilShop;

        public function GoldOilShopView()
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
            this._goldOilShop.clear();
            return;
        }// end function

        public function updateStatePoint() : void
        {
            if (this.inStage)
            {
                this._goldOilShop.renderMyStatePoint(this._ctrl.player.statePoint, this._ctrl.zodiac.zodiacInfo["now_zodiac_level"]);
            }
            return;
        }// end function

        private function loadData() : void
        {
            this.zodiac_info(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("GoldOilShop", this.render, GoldOilShopViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._goldOilShop.content);
            _view.center(sign, this._goldOilShop.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._goldOilShop == null)
            {
                this._goldOilShop = _view.getAssetsObject("GoldOilShop", "GoldOilShop") as IGoldOilShop;
            }
            this.init();
            this.getGoldOilList();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._goldOilShop.tip = this._view.tip.iTip;
            this._goldOilShop.drag = this._view.drag.iDrag;
            this._goldOilShop.onClose = this.close;
            this._goldOilShop.onConvert = this.get_soul;
            this._goldOilShop.init();
            return;
        }// end function

        private function getGoldOilList() : void
        {
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            var _loc_1:* = GoldOilType.getAllOilItemIds();
            var _loc_2:Array = [];
            for each (_loc_3 in _loc_1)
            {
                
                _loc_4 = {};
                _loc_4["zodiac_level"] = GoldOilType.getOilLevel(_loc_3);
                if (_loc_4["zodiac_level"] > (this._ctrl.zodiac.zodiacInfo["heaven"] - 1))
                {
                    continue;
                }
                _loc_4["gold_oil_id"] = _loc_3;
                _loc_4["url"] = URI.goodsIconUrl + _loc_3 + ".png";
                _loc_4["gold_oil_name"] = ItemType.getName(_loc_3);
                _loc_4["gold_oil_level"] = GoldOilType.getItemLevel(_loc_3);
                _loc_4["zodiac_level"] = GoldOilType.getOilLevel(_loc_3);
                _loc_4["gold_oil_state_point"] = GoldOilType.getExchangeStatePoint(_loc_3);
                _loc_4["description"] = ItemType.getDescription(_loc_4["gold_oil_id"]);
                _loc_2.push(_loc_4);
            }
            this._goldOilShop.renderGoldOilShop(_loc_2);
            this._goldOilShop.renderMyStatePoint(this._ctrl.player.statePoint, this._ctrl.zodiac.zodiacInfo["heaven"]);
            return;
        }// end function

        private function zodiac_info(param1:Function) : void
        {
            _data.call(Mod_Zodiac_Base.zodiac_info, param1, []);
            return;
        }// end function

        private function get_soul(param1:int) : void
        {
            _data.call(Mod_Item_Base.get_gold_oil, this.getGoldOilCallBack, [param1]);
            return;
        }// end function

        private function getGoldOilCallBack() : void
        {
            var _loc_1:* = this._ctrl.item.getGoldOil;
            if (_loc_1["result"] == Mod_Item_Base.SUCCESS)
            {
                this._view.showTip(this.message(_loc_1["result"]), null, TipType.Success);
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Item_Base.SUCCESS:
                {
                    _loc_2 = GoldOilShopViewLang.Success;
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_STATE_POINT:
                {
                    _loc_2 = GoldOilShopViewLang.NotEnoughStatePoint;
                    break;
                }
                case Mod_Item_Base.NOT_GRID:
                {
                    _loc_2 = GoldOilShopViewLang.NotGrid;
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_DAY_COUNT:
                {
                    _loc_2 = GoldOilShopViewLang.NotEnoughDayCount;
                    break;
                }
                default:
                {
                    _loc_2 = GoldOilShopViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
