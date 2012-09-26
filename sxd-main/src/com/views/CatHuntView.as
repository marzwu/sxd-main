package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class CatHuntView extends Base implements IView
    {
        private var _catHunt:ICatHunt;

        public function CatHuntView()
        {
            return;
        }// end function

        public function show() : void
        {
            this.auto_search_bonus();
            return;
        }// end function

        public function auto_search_bonus() : void
        {
            _data.call(Mod_CatHunt_Base.auto_search_bonus, this.autoSearchBonusCallBack, []);
            _data.patch(Mod_CatHunt_Base.auto_search_bonus, this.autoSearchBonusCallBack);
            return;
        }// end function

        public function use_map_search(param1:int) : void
        {
            _data.call(Mod_CatHunt_Base.use_map_search, this.useMapSearchCallBack, [param1]);
            return;
        }// end function

        private function showCatHunt() : void
        {
            return;
        }// end function

        private function autoSearchBonusCallBack() : void
        {
            var _loc_1:* = _ctrl.catHunt.autoSearchBonus;
            if (inStage)
            {
                this._catHunt.getAwardData(_loc_1, false);
            }
            else
            {
                loadAssets("CatHunt", this.render, CatHuntViewLang.loadAssets);
            }
            return;
        }// end function

        private function useMapSearchCallBack() : void
        {
            var _loc_1:* = _ctrl.catHunt.useMapSearch;
            if (_loc_1.result == Mod_CatHunt_Base.USE_SUCCESS)
            {
                this._catHunt.checkMapAwardState = 1;
                this._catHunt.checkMapAwardData = {};
                this._catHunt.getAwardData(_loc_1, true);
            }
            else
            {
                this._catHunt.checkMapAwardState = 0;
                this.result(_loc_1.failedReason);
            }
            return;
        }// end function

        private function result(param1:int) : void
        {
            switch(param1)
            {
                case Mod_CatHunt_Base.NOT_ENOUGH_COIN:
                {
                    _view.showTip(CatHuntViewLang.NOT_ENOUGH_COIN);
                    break;
                }
                case Mod_CatHunt_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(CatHuntViewLang.NOT_ENOUGH_INGOT);
                    break;
                }
                case Mod_CatHunt_Base.NOT_ENOUGH_VIPLEVEL:
                {
                    _view.showTip(CatHuntViewLang.NOT_ENOUGH_VIPLEVEL);
                    break;
                }
                case Mod_CatHunt_Base.NOT_ENOUGH_TIMES:
                {
                    _view.showTip(CatHuntViewLang.NOT_ENOUGH_TIMES);
                    break;
                }
                default:
                {
                    _view.showTip(CatHuntViewLang.Default);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function render() : void
        {
            this._catHunt = _view.getAssetsObject("CatHunt", "CatHunt") as ICatHunt;
            _popup.addView(this, this._catHunt.content);
            _view.center(sign, this._catHunt.content);
            this._catHunt.onMapCheck = function () : void
            {
                if (_ctrl.player.coins < 100000)
                {
                    result(Mod_CatHunt_Base.NOT_ENOUGH_COIN);
                    return;
                }
                _catHunt.mapCheckAward();
                use_map_search(Mod_CatHunt_Base.MT_NORMAL);
                return;
            }// end function
            ;
            this._catHunt.onMapIngotCheck = function () : void
            {
                if (VIPType.check(VIPType.Level4) == false)
                {
                    result(Mod_CatHunt_Base.NOT_ENOUGH_VIPLEVEL);
                    return;
                }
                if (_ctrl.player.ingot < 50)
                {
                    result(Mod_CatHunt_Base.NOT_ENOUGH_INGOT);
                    return;
                }
                _catHunt.mapCheckAward();
                use_map_search(Mod_CatHunt_Base.MT_ADVANCED);
                return;
            }// end function
            ;
            this._catHunt.onShowTip = function (param1:String) : void
            {
                showTip(param1);
                return;
            }// end function
            ;
            this._catHunt.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this.autoSearchBonusCallBack();
            return;
        }// end function

        private function showTip(param1:String) : void
        {
            switch(param1)
            {
                case "isCheck":
                {
                    _view.showTip(CatHuntViewLang.isCheck);
                    break;
                }
                case "useMapTime":
                {
                    this.result(Mod_CatHunt_Base.NOT_ENOUGH_TIMES);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            this._catHunt.clear();
            return;
        }// end function

        public function close() : void
        {
            _data.cancelPatch(Mod_CatHunt_Base.auto_search_bonus);
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

    }
}
