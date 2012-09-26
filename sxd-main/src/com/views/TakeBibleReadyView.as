package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.geom.*;

    public class TakeBibleReadyView extends Base implements IView
    {
        private var _takeBibleReady:ITakeBibleReady;
        private var _inspireNum:int;
        private var _awardState:Number = 0;

        public function TakeBibleReadyView()
        {
            return;
        }// end function

        public function get_take_bible_info() : void
        {
            _data.call(Mod_TakeBible_Base.get_take_bible_info, this.getTakeBibleInfoCallBack, []);
            return;
        }// end function

        private function buy_protection() : void
        {
            _data.call(Mod_TakeBible_Base.buy_protection, this.buyProtectionInfoCallBack, []);
            return;
        }// end function

        private function start_take_bible() : void
        {
            _data.call(Mod_TakeBible_Base.start_take_bible, this.startTakeBibleCallBack, []);
            return;
        }// end function

        private function refresh() : void
        {
            _data.call(Mod_TakeBible_Base.refresh, this.refreshCallBack, []);
            return;
        }// end function

        private function apply_friend(param1:int) : void
        {
            _data.call(Mod_TakeBible_Base.apply_friend, this.applyFriendCallBack, [param1]);
            return;
        }// end function

        private function cancel_apply_friend() : void
        {
            _data.call(Mod_TakeBible_Base.cancel_apply_friend, new Function(), []);
            return;
        }// end function

        public function approve_apply(param1:int) : void
        {
            _data.call(Mod_TakeBible_Base.approve_apply, this.approveApplyCallBack, [param1]);
            return;
        }// end function

        public function reject_apply(param1:int) : void
        {
            _data.call(Mod_TakeBible_Base.reject_apply, this.rejectApplyCallBack, [param1]);
            return;
        }// end function

        public function buy_bless() : void
        {
            _data.call(Mod_TakeBible_Base.buy_bless, this.buyBlessCallBack, []);
            return;
        }// end function

        private function getTakeBibleInfoCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.getTakeBibleInfo;
            if (inStage)
            {
                this._takeBibleReady.awardState = this._awardState;
                this._takeBibleReady.getEscortData = _loc_1;
            }
            else
            {
                this.renderShow();
            }
            return;
        }// end function

        private function buyProtectionInfoCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.buyProtection;
            if (_loc_1.msg == Mod_TakeBible_Base.SUCCESS)
            {
                this.get_take_bible_info();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function refreshCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.refreshData;
            if (_loc_1.msg == Mod_TakeBible_Base.SUCCESS)
            {
                this.get_take_bible_info();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function applyFriendCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.applyFriend;
            if (_loc_1.msg == Mod_TakeBible_Base.SUCCESS)
            {
                _view.showTip(TakeBibleReadyViewLang.SuccessApplyFriend, null, TipType.Success);
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function approveApplyCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.approveApply;
            if (_loc_1.msg == Mod_TakeBible_Base.SUCCESS)
            {
                _view.showTip(TakeBibleReadyViewLang.SuccessApproveApply, null, TipType.Success);
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function rejectApplyCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.approveApply;
            if (_loc_1.msg == Mod_TakeBible_Base.SUCCESS)
            {
                _view.showTip(TakeBibleReadyViewLang.SuccessRejectApply, null, TipType.Success);
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function startTakeBibleCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.startTakeBible;
            if (_loc_1.msg == Mod_TakeBible_Base.SUCCESS)
            {
                _view.gameHelper.loader_first_info();
                _view.showTip(TakeBibleReadyViewLang.StartTakeBable, null, TipType.Success);
                _view.takeBibleRoad.get_take_bible_updata_data();
                this.close();
            }
            else
            {
                this.renderMsg(_loc_1);
                this._takeBibleReady.escortStata = 0;
                _view.takeBibleRoad.takeBibleStatus = 0;
            }
            return;
        }// end function

        private function buyBlessCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.buyBless;
            if (_loc_1.msg == Mod_TakeBible_Base.SUCCESS)
            {
                this._takeBibleReady.inspireInfo = _loc_1.newBless;
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function renderMsg(param1:Object) : void
        {
            switch(param1.msg)
            {
                case Mod_TakeBible_Base.FULL_PROTECT_TIMES:
                {
                    _view.showTip(TakeBibleReadyViewLang.FullProtectTimes);
                    break;
                }
                case Mod_TakeBible_Base.CANCEL_APPLY:
                {
                    _view.showTip(TakeBibleReadyViewLang.CancelApply);
                    break;
                }
                case Mod_TakeBible_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(TakeBibleReadyViewLang.NotEnoughIngot);
                    break;
                }
                case Mod_TakeBible_Base.REQUEST_VIP:
                {
                    _view.showTip(TakeBibleReadyViewLang.RequestVip);
                    break;
                }
                case Mod_TakeBible_Base.FULL_TAKE_BIBLE_TIMES:
                {
                    _view.showTip(TakeBibleReadyViewLang.FullTakeBibleTimes);
                    break;
                }
                case Mod_TakeBible_Base.TAKE_BIBLE_STATUS:
                {
                    _view.showTip(TakeBibleReadyViewLang.TakeBibleStatus);
                    break;
                }
                case Mod_TakeBible_Base.INVALID_PLAYER_ID:
                {
                    _view.showTip(TakeBibleReadyViewLang.InvalidPlayerId);
                    break;
                }
                case Mod_TakeBible_Base.FULL_PROTECT_TIMES:
                {
                    _view.showTip(TakeBibleReadyViewLang.FullProtectTimes);
                    break;
                }
                case Mod_TakeBible_Base.NOT_ONLINE:
                {
                    _view.showTip(TakeBibleReadyViewLang.NotOnline);
                    break;
                }
                case Mod_TakeBible_Base.TAKE_BIBLE_STATUS:
                {
                    _view.showTip(TakeBibleReadyViewLang.TakeBibleStatus);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function renderShow() : void
        {
            loadAssets("TakeBibleReady", this.render, TakeBibleReadyViewLang.LoadAssets);
            return;
        }// end function

        public function show() : void
        {
            this.get_take_bible_info();
            return;
        }// end function

        public function render() : void
        {
            this._takeBibleReady = _view.getAssetsObject("TakeBibleReady", "TakeBibleReady") as ITakeBibleReady;
            _popup.addView(this, this._takeBibleReady.content);
            _view.center(sign, this._takeBibleReady.content);
            this._takeBibleReady.tip = _view.tip.iTip;
            this._takeBibleReady.drag = _view.drag.iDrag;
            this.renderReady();
            return;
        }// end function

        private function renderReady() : void
        {
            this._takeBibleReady.init();
            this.getTakeBibleInfoCallBack();
            this._takeBibleReady.vipLevel = _ctrl.player.vipLevel;
            this._takeBibleReady.onRefreshAngel = function (param1:int) : void
            {
                var callback:Function;
                var value:* = param1;
                if (_view.vipEnabled == false || _view.ingotEnough(value) == false)
                {
                    return;
                }
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.TakeBibleRefreshAngel))
                {
                    dialog.yesLabel = TakeBibleReadyViewLang.Sure;
                    dialog.cancelLabel = TakeBibleReadyViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        refresh();
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.TakeBibleRefreshAngel, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(Lang.sprintf(TakeBibleReadyViewLang.RefreshAngel, HtmlText.yellow(value + TakeBibleReadyViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    refresh();
                }
                return;
            }// end function
            ;
            this._takeBibleReady.onStartEscort = function (param1:Boolean, param2:int) : void
            {
                _inspireNum = param2;
                if (param1)
                {
                    _view.alert.showYesNoMsg(TakeBibleReadyViewLang.StartEscort, TakeBibleReadyViewLang.Sure, TakeBibleReadyViewLang.Cancel, onStartEscort);
                }
                else
                {
                    startTakeBible();
                }
                return;
            }// end function
            ;
            this._takeBibleReady.onInspire = function () : void
            {
                var callback:Function;
                if (_view.vipEnabled == false || _view.ingotEnough(15) == false)
                {
                    return;
                }
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.TakeBibleInspire))
                {
                    dialog.yesLabel = TakeBibleReadyViewLang.Sure;
                    dialog.cancelLabel = TakeBibleReadyViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        buy_bless();
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.TakeBibleInspire, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(Lang.sprintf(TakeBibleReadyViewLang.InspireInfo, HtmlText.yellow("15" + TakeBibleReadyViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    buy_bless();
                }
                return;
            }// end function
            ;
            this._takeBibleReady.onSummon = function () : void
            {
                var callback:Function;
                if (_view.ingotEnough(200) == false)
                {
                    return;
                }
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.SummerTS))
                {
                    dialog.yesLabel = TakeBibleReadyViewLang.Sure;
                    dialog.cancelLabel = TakeBibleReadyViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        buy_protection();
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.SummerTS, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(Lang.sprintf(TakeBibleReadyViewLang.SummonTS, HtmlText.yellow("200" + TakeBibleReadyViewLang.Ingot), HtmlText.yellow("40%" + TakeBibleReadyViewLang.LifeAndPower)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    buy_protection();
                }
                return;
            }// end function
            ;
            this._takeBibleReady.onTip = function (param1:String) : void
            {
                switch(param1)
                {
                    case "isApplyFriend":
                    {
                        _view.showTip(TakeBibleReadyViewLang.isApplyFriend);
                        ;
                    }
                    case "remainProtectTimes":
                    {
                        _view.showTip(TakeBibleReadyViewLang.remainProtectTimes);
                        ;
                    }
                    case "protectStatus":
                    {
                        _view.showTip(TakeBibleReadyViewLang.protectStatus);
                        ;
                    }
                    default:
                    {
                        ;
                    }
                }
                return;
            }// end function
            ;
            this._takeBibleReady.onSure = function (param1:Object) : void
            {
                apply_friend(param1.playerId);
                return;
            }// end function
            ;
            this._takeBibleReady.onCancel = function () : void
            {
                cancel_apply_friend();
                return;
            }// end function
            ;
            this._takeBibleReady.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this.reposition();
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        private function startTakeBible() : void
        {
            this._takeBibleReady.escortStata = 1;
            _view.takeBibleRoad.takeBibleStatus = 1;
            _view.takeBibleRoad.isUserProtection = this._inspireNum;
            _view.takeBibleRoad.get_take_bible_updata_data();
            this.start_take_bible();
            return;
        }// end function

        public function hasApplyFriend(param1:Boolean) : void
        {
            if (inStage)
            {
                this._takeBibleReady.hasApplyFriend(param1);
            }
            return;
        }// end function

        public function set awardState(param1:Number) : void
        {
            this._awardState = param1;
            return;
        }// end function

        public function set isUserProtection(param1:int) : void
        {
            this._takeBibleReady.isUserProtection = param1;
            return;
        }// end function

        private function onStartEscort(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.startTakeBible();
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

        private function onSummonHandler(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.buy_protection();
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

        private function onSummonTS(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.buy_protection();
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

        public function set escortStata(param1:int) : void
        {
            if (this.inStage)
            {
                this._takeBibleReady.escortStata = param1;
            }
            return;
        }// end function

        private function onBuyFateGridHandler(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
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

        public function reposition(param1:Boolean = true) : void
        {
            if (inStage == false)
            {
                return;
            }
            var _loc_2:* = Structure.stageOffset;
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                this._takeBibleReady.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

        public function clear() : void
        {
            if (this._takeBibleReady == null)
            {
                return;
            }
            this._takeBibleReady.clear();
            this._takeBibleReady = null;
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

    }
}
