package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class SealStoneShopView extends Base implements IView
    {
        private var _sealStoneShop:ISealShop;

        public function SealStoneShopView()
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
            this._sealStoneShop.clear();
            return;
        }// end function

        private function loadData() : void
        {
            var callBack:Function;
            callBack = function () : void
            {
                get_tower_info(loadDataCallBack);
                return;
            }// end function
            ;
            this.get_stone_count(callBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("SealStoneShop", this.render, SealStoneShopViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._sealStoneShop.content);
            _view.center(sign, this._sealStoneShop.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._sealStoneShop == null)
            {
                this._sealStoneShop = _view.getAssetsObject("SealStoneShop", "SealStoneShop") as ISealShop;
            }
            this.init();
            this.getTowerInfoCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._sealStoneShop.tip = this._view.tip.iTip;
            this._sealStoneShop.drag = this._view.drag.iDrag;
            this._sealStoneShop.onClose = this.close;
            this._sealStoneShop.onConvert = this.swap_seal_soul;
            this._sealStoneShop.init();
            return;
        }// end function

        private function getStoneInfo(param1:Object) : void
        {
            param1["soul_name"] = SoulType.getSoulName(param1["soul_id"]);
            param1["color"] = HtmlText.Purple;
            param1["type_id"] = SoulType.getSoulTypeIdByAllTypeId(SoulType.getSoulSubTypeId(param1["soul_id"]));
            param1["type_name"] = SoulType.getTypeName(param1["type_id"]);
            param1["url"] = URI.getSoulsIconUrl(param1["soul_id"]);
            return;
        }// end function

        private function get_stone_count(param1:Function) : void
        {
            _data.call(Mod_SealSoul_Base.get_stone_count, param1, []);
            return;
        }// end function

        private function get_tower_info(param1:Function) : void
        {
            _data.call(Mod_Tower_Base.get_tower_info, param1, []);
            return;
        }// end function

        private function getTowerInfoCallBack() : void
        {
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_1:* = this._ctrl.tower.towerInfo;
            var _loc_2:Array = [];
            var _loc_3:int = 1;
            while (_loc_3 <= _loc_1["layer"])
            {
                
                _loc_4 = {};
                switch(_loc_3 - 1)
                {
                    case 1:
                    {
                        _loc_4["soul_id"] = 2;
                        _loc_4["stone_num"] = 20;
                        break;
                    }
                    case 2:
                    {
                        _loc_4["soul_id"] = 5;
                        _loc_4["stone_num"] = 40;
                        break;
                    }
                    case 3:
                    {
                        _loc_4["soul_id"] = 8;
                        _loc_4["stone_num"] = 60;
                        break;
                    }
                    case 4:
                    {
                        _loc_4["soul_id"] = 47;
                        _loc_4["stone_num"] = 80;
                        break;
                    }
                    case 5:
                    {
                        _loc_4["soul_id"] = 62;
                        _loc_4["stone_num"] = 100;
                        break;
                    }
                    default:
                    {
                        _loc_4["soul_id"] = 0;
                        break;
                    }
                }
                if (_loc_4["soul_id"] != 0)
                {
                    this.getStoneInfo(_loc_4);
                    _loc_2.push(_loc_4);
                }
                _loc_3++;
            }
            if (_loc_1["layer"] == 6 && _loc_1["sequenceMax_"] == 25)
            {
                _loc_5 = {};
                _loc_5["soul_id"] = 77;
                _loc_5["stone_num"] = 120;
                this.getStoneInfo(_loc_5);
                _loc_2.push(_loc_5);
            }
            this._sealStoneShop.renderSealShop(_loc_2);
            this._sealStoneShop.renderJadeInfo(this._ctrl.sealSoul.getStoneCount);
            return;
        }// end function

        private function swap_seal_soul(param1:int) : void
        {
            _data.call(Mod_SealSoul_Base.swap_seal_soul, this.getSoulCallBack, [param1]);
            return;
        }// end function

        private function getSoulCallBack() : void
        {
            var callBack:Function;
            callBack = function () : void
            {
                get_tower_info(getTowerInfoCallBack);
                _view.sealSoul.refreshSoul();
                return;
            }// end function
            ;
            var obj:* = this._ctrl.sealSoul.swapSealSoul;
            if (obj["state"] == 1)
            {
                this._view.showTip(this.message(obj["state"]), null, TipType.Success);
                this.get_stone_count(callBack);
            }
            else
            {
                this._view.showTip(this.message(obj["state"]));
            }
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case 0:
                {
                    _loc_2 = SealStoneShopViewLang.Fail;
                    break;
                }
                case 1:
                {
                    _loc_2 = SealStoneShopViewLang.Success;
                    break;
                }
                case 2:
                {
                    _loc_2 = SealStoneShopViewLang.NoStone;
                    break;
                }
                case 3:
                {
                    _loc_2 = SealStoneShopViewLang.NoLayer;
                    break;
                }
                case 4:
                {
                    _loc_2 = SealStoneShopViewLang.NotGrid;
                    break;
                }
                default:
                {
                    _loc_2 = SealStoneShopViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
