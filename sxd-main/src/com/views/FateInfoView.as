package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class FateInfoView extends Base implements IView
    {
        private var _fateInfo:IFateInfo;
        private var _changeData:Object;
        private var _isChange:Boolean = false;

        public function FateInfoView()
        {
            return;
        }// end function

        public function exchange_fate(param1:int) : void
        {
            _data.call(Mod_Fate_Base.exchange_fate, this.exchangeFateCallBack, [param1]);
            return;
        }// end function

        public function get_scrap_amount() : void
        {
            _data.call(Mod_Fate_Base.get_scrap_amount, this.getScrapAmountCallBack, []);
            return;
        }// end function

        public function getScrapAmountCallBack() : void
        {
            var _loc_1:* = _ctrl.fate.getScrapAmount;
            if (_view.lodge.inStage)
            {
                _view.lodge.renderScrapAmount = _loc_1;
            }
            if (inStage)
            {
                this._fateInfo.getFragmentNum = _ctrl.fate.getScrapAmount;
            }
            else
            {
                loadAssets("FateInfo", this.render, FateViewLang.LoadAssets);
            }
            return;
        }// end function

        private function exchangeFateCallBack() : void
        {
            var _loc_2:String = null;
            var _loc_3:int = 0;
            var _loc_1:* = this._ctrl.fate.ExchangeFate;
            if (_loc_1.msg == Mod_Fate_Base.SUCCESS)
            {
                _loc_2 = FateType.getFateName(this._changeData.fateId);
                _loc_3 = FateType.getFateQuality(this._changeData.fateId);
                _view.showTip(HtmlText.white(FateViewLang.ExchangeSuccess) + HtmlText.format("【" + _loc_2 + "】", this._changeData.color), "", TipType.Success);
                if (_view.fate.inStage)
                {
                    _view.fate.get_bag_list();
                    _view.fate.get_role_fate_list();
                }
                this.get_scrap_amount();
            }
            else
            {
                _view.fate.renderMsg(_loc_1);
            }
            this._isChange = false;
            return;
        }// end function

        public function show() : void
        {
            this.get_scrap_amount();
            return;
        }// end function

        public function render() : void
        {
            if (this._fateInfo == null)
            {
                this._fateInfo = _view.getAssetsObject("FateInfo", "FateInfo") as IFateInfo;
            }
            _popup.addView(this, this._fateInfo.content);
            this._fateInfo.tip = _view.tip.iTip;
            this._fateInfo.drag = _view.drag.iDrag;
            this._fateInfo.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._fateInfo.onExchange = function (param1:Object) : void
            {
                if (_isChange)
                {
                    return;
                }
                if (param1.isLevel == false)
                {
                    _view.fate.renderMsg({msg:Mod_Fate_Base.NOT_ENOUGH_LEVEL});
                    return;
                }
                if (_ctrl.fate.FateScrapNumber < param1.userFragmentNum)
                {
                    _view.fate.renderMsg({msg:Mod_Fate_Base.NOT_ENOUGH_COUNT});
                    return;
                }
                _changeData = param1;
                _view.alert.showYesNoMsg(Lang.sprintf(FateViewLang.exchange, param1.userFragmentNum) + HtmlText.format(param1.fateName, param1.color), FateViewLang.Sure, FateViewLang.Cancel, onExchangeHandler);
                return;
            }// end function
            ;
            this._fateInfo.init();
            this._fateInfo.getPlayerLevel(_ctrl.player.level, VIPType.check(VIPType.Level5));
            this.getScrapAmountCallBack();
            return;
        }// end function

        public function onExchangeHandler(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this._isChange = true;
                    this.exchange_fate(this._changeData.fateId);
                    break;
                }
                case AlertButtonType.No:
                {
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
            this._fateInfo.clear();
            return;
        }// end function

        public function close() : void
        {
            this._isChange = false;
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

    }
}
