package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class SealStoneView extends Base implements IView
    {
        private var _sealStone:ISealStone;
        private var _dialog:IAlert;

        public function SealStoneView()
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
            if (this._sealStone != null)
            {
                this._sealStone.clear();
            }
            if (this._dialog != null)
            {
                this._dialog.hide();
            }
            return;
        }// end function

        public function notifyGet() : void
        {
            if (FunctionType.isOpened(FunctionType.SealSoul))
            {
                this.notify_get();
            }
            return;
        }// end function

        public function getDayStone() : void
        {
            if (VIPType.check(VIPType.Level3))
            {
                this.show();
            }
            else
            {
                this.getDaySealStone(0);
            }
            return;
        }// end function

        private function loadData() : void
        {
            this.day_stone_count(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("SealStone", this.render, SealStoneViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._sealStone.content);
            _view.center(sign, this._sealStone.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._sealStone == null)
            {
                this._sealStone = _view.getAssetsObject("SealStone", "SealStone") as ISealStone;
            }
            this.init();
            this.dayStoneCountCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            if (this._dialog == null)
            {
                this._dialog = this._view.alert.iAlert;
            }
            this._sealStone.tip = this._view.tip.iTip;
            this._sealStone.drag = this._view.drag.iDrag;
            this._sealStone.onClose = this.close;
            this._sealStone.onGetDayStone = this.getDaySealStone;
            this._sealStone.init();
            return;
        }// end function

        private function getDaySealStone(param1:int) : void
        {
            var callBack:Function;
            var intType:* = param1;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    get_day_stone(intType);
                }
                if (_dialog.checked)
                {
                    if (intType == 1)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.GetSealStoneTwo, true);
                    }
                    if (intType == 2)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.GetSealStoneThree, true);
                    }
                }
                return;
            }// end function
            ;
            if (intType == 1 && !_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.GetSealStoneTwo))
            {
                this._dialog.yesLabel = SealStoneViewLang.DialogYes;
                this._dialog.cancelLabel = SealStoneViewLang.DialogNo;
                this._dialog.hasCheckbox = true;
                this._dialog.show(Lang.sprintf(SealStoneViewLang.GetStongByIngot, HtmlText.yellow("100" + SealStoneViewLang.Ingot), SealStoneViewLang.Two, this._ctrl.sealSoul.dayStoneCount["count"] * 2), AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            }
            else if (intType == 2 && !_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.GetSealStoneThree))
            {
                this._dialog.yesLabel = SealStoneViewLang.DialogYes;
                this._dialog.cancelLabel = SealStoneViewLang.DialogNo;
                this._dialog.hasCheckbox = true;
                this._dialog.show(Lang.sprintf(SealStoneViewLang.GetStongByIngot, HtmlText.yellow("200" + SealStoneViewLang.Ingot), SealStoneViewLang.Three, this._ctrl.sealSoul.dayStoneCount["count"] * 3), AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            }
            else
            {
                this.get_day_stone(intType);
            }
            return;
        }// end function

        private function get_day_stone(param1:int) : void
        {
            _data.call(Mod_SealSoul_Base.get_day_stone, this.getDayStoneCallBack, [param1]);
            return;
        }// end function

        private function getDayStoneCallBack() : void
        {
            var _loc_1:* = this._ctrl.sealSoul.getDayStone;
            if (_loc_1["state"] == 1)
            {
                this._view.showTip(Lang.sprintf(SealStoneViewLang.GetSuccess, _loc_1["stone_coun"]), null, TipType.Success);
                this._view.activities.removeActivity(FunctionType.SealSoul);
                if (this.inStage)
                {
                    this.close();
                }
            }
            else
            {
                this._view.showTip(this.message(_loc_1["state"]));
            }
            this._view.gameHelper.updateGameAssistant();
            this._view.liveness.updateInfo();
            return;
        }// end function

        private function notify_get() : void
        {
            _data.call(Mod_SealSoul_Base.notify_get, this.notifyGetCallBack, []);
            return;
        }// end function

        public function notifyGetCallBack() : void
        {
            var obj:* = this._ctrl.sealSoul.notifyGet;
            if (obj["state"] == 1)
            {
                this._view.activities.addActivity(FunctionType.SealSoul);
                if (!VIPType.check(VIPType.Level3))
                {
                    var callBack:* = function () : void
            {
                var _loc_1:* = _ctrl.sealSoul.dayStoneCount;
                var _loc_2:* = HtmlText.format(Lang.sprintf(SealStoneViewLang.CanGetStone, _loc_1["count"]), HtmlText.White, 14, "", true);
                _view.activities.activityTip(FunctionType.SealSoul, _loc_2);
                return;
            }// end function
            ;
                    this.day_stone_count(callBack);
                }
            }
            else
            {
                this._view.activities.removeActivity(FunctionType.SealSoul);
            }
            return;
        }// end function

        private function day_stone_count(param1:Function) : void
        {
            _data.call(Mod_SealSoul_Base.day_stone_count, param1, []);
            return;
        }// end function

        private function dayStoneCountCallBack() : void
        {
            var _loc_1:* = this._ctrl.sealSoul.dayStoneCount;
            this._sealStone.render(_loc_1);
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case 0:
                {
                    _loc_2 = SealStoneViewLang.Fail;
                    break;
                }
                case 1:
                {
                    _loc_2 = SealStoneViewLang.Success;
                    break;
                }
                case 2:
                {
                    _loc_2 = SealStoneViewLang.NoIngot;
                    break;
                }
                case 3:
                {
                    _loc_2 = SealStoneViewLang.NoVip;
                    break;
                }
                default:
                {
                    _loc_2 = SealStoneViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
