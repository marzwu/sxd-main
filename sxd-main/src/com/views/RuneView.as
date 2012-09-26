package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class RuneView extends Base implements IView
    {
        private var _isUser:Boolean = false;
        private var _isRuneUser:Boolean = false;
        private var _userIngot:int = 0;
        private var _userbatchRuneIngot:int = 0;
        private var _oldAutoData:Object;
        public var Count:int = 0;
        private var _alert:IAlert;
        private var _rune:IRune;

        public function RuneView()
        {
            return;
        }// end function

        public function rune_list() : void
        {
            if (VIPType.enabled == false)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.Rune))
            {
                _data.call(Mod_Rune_Base.rune_list, this.runeListCallback, []);
            }
            return;
        }// end function

        private function rune_use() : void
        {
            _data.call(Mod_Rune_Base.rune_use, this.runeUseCallback, []);
            return;
        }// end function

        public function batch_rune_list() : void
        {
            this._isUser = true;
            _data.call(Mod_Rune_Base.batch_rune_list, this.batchRuneListCallback, []);
            return;
        }// end function

        public function batch_rune_use() : void
        {
            this._rune.sureBtnShow = false;
            _data.call(Mod_Rune_Base.batch_rune_use, this.batchRuneUseCallback, []);
            return;
        }// end function

        public function auto_rune_info() : void
        {
            _data.call(Mod_Rune_Base.auto_rune_info, this.autoRuneInfoCallback, []);
            return;
        }// end function

        public function set_auto_rune(param1:int, param2:int) : void
        {
            _data.call(Mod_Rune_Base.set_auto_rune, this.setAutoRuneCallback, [param1, param2]);
            return;
        }// end function

        private function runeListCallback() : void
        {
            var _loc_1:* = this._ctrl.rune.runeList;
            this.isBtnUser(_loc_1, false);
            this._userIngot = _loc_1.ingot;
            return;
        }// end function

        private function runeUseCallback() : void
        {
            var _loc_1:* = this._ctrl.rune.runeUse;
            if (_loc_1.msg == Mod_Rune_Base.SUCCEED)
            {
                this._rune.upGrade = _loc_1.coins;
                _view.chat.addSystemMessage(Lang.sprintf(RuneViewLang.UserIngot, _loc_1.coins));
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            this.renderMsg(_loc_1.msg);
            this.isBtnUser(_loc_1);
            this._userIngot = _loc_1.ingot;
            return;
        }// end function

        public function batchRuneListCallback() : void
        {
            this._isUser = false;
            var _loc_1:* = _ctrl.rune.batchRuneData;
            this._rune.batchRuneData = _loc_1;
            this.isBtnUser(_loc_1, false, false);
            this._userbatchRuneIngot = _loc_1.ingot;
            this.batchRune(_loc_1);
            return;
        }// end function

        public function batchRuneUseCallback() : void
        {
            var _loc_1:* = _ctrl.rune.batchRuneUse;
            if (_loc_1.msg == Mod_Rune_Base.SUCCEED)
            {
                this._rune.batchRuneData = _loc_1;
                this._rune.upGrade = _loc_1.newCoins;
                _view.chat.addSystemMessage(Lang.sprintf(RuneViewLang.UserIngot, _loc_1.newCoins));
                this.isBtnUser(_loc_1, true, false);
                this.rune_list();
                this._userbatchRuneIngot = _loc_1.ingot;
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        public function autoRuneInfoCallback() : void
        {
            var _loc_1:* = _ctrl.rune.autoRuneInfo;
            this._rune.autoRuneInfo = _loc_1;
            this._oldAutoData = _loc_1;
            return;
        }// end function

        public function setAutoRuneCallback() : void
        {
            var _loc_1:* = _ctrl.rune.setAutoRune;
            return;
        }// end function

        public function isBtnUser(param1:Object, param2:Boolean = true, param3:Boolean = true) : void
        {
            _view.gameHelper.updateGameAssistant();
            _view.liveness.updateInfo();
            _view.toolbar.runeVisible = param1.count > 0;
            _view.lodge.showRune(param1.count);
            _view.furnaceMap.showRune(param1.count);
            this.Count = param1.count;
            if (param1.count > 0)
            {
                _view.activities.openActivity(FunctionType.Rune);
                _view.activities.activityRuneNum = param1.count;
                if (inStage)
                {
                    if (param2 && _ctrl.player.ingot >= param1.ingot)
                    {
                        this._rune.sureBtnShow = true;
                    }
                    if (param3)
                    {
                        this._rune.runeInfo = Lang.sprintf(RuneViewLang.GetCoins, param1.ingot, param1.coins);
                    }
                }
            }
            else
            {
                _view.activities.removeActivity(FunctionType.Rune);
                if (inStage)
                {
                    this.close();
                }
            }
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_Rune_Base.FAILED:
                {
                    this.alertInfo(RuneViewLang.Fail);
                    break;
                }
                case Mod_Rune_Base.NOENOUGHINGOT:
                {
                    _view.showTip(RuneViewLang.InsufficientIngot);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function alertInfo(param1:String) : void
        {
            var _loc_2:uint = 0;
            this._alert.yesLabel = RuneViewLang.Sure;
            _loc_2 = AlertButtonType.Yes;
            this._alert.show(param1, _loc_2);
            return;
        }// end function

        public function set alert(param1:IAlert) : void
        {
            this._alert = param1;
            return;
        }// end function

        public function show() : void
        {
            loadAssets("Rune", this.render, RuneViewLang.LoadAssets);
            return;
        }// end function

        public function render() : void
        {
            this._rune = _view.getAssetsObject("Rune", "Rune") as IRune;
            _popup.addView(this, this._rune.content);
            _view.center(sign, this._rune.content);
            this.alert = _view.alert.iAlert;
            this._rune.tip = _view.tip.iTip;
            this._rune.drag = _view.drag.iDrag;
            this.rune_list();
            var isVip6:* = VIPType.check(VIPType.Level6);
            this._rune.isVip6 = isVip6;
            var isVip7:* = VIPType.check(VIPType.Level7);
            this._rune.isVip10 = isVip7;
            if (isVip7)
            {
                this.auto_rune_info();
            }
            this._rune.onRuneSure = function () : void
            {
                if (_ctrl.player.ingot >= _userIngot)
                {
                    rune_use();
                    _rune.sureBtnShow = false;
                }
                else
                {
                    _view.showTip(RuneViewLang.InsufficientIngot);
                }
                return;
            }// end function
            ;
            this._rune.onSetAutoRune = function (param1:int, param2:Object) : void
            {
                set_auto_rune(param1, param2.key);
                return;
            }// end function
            ;
            this._rune.onBatchRune = function (param1:Object) : void
            {
                if (_isUser == false)
                {
                    batch_rune_list();
                }
                return;
            }// end function
            ;
            this._rune.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        private function batchRune(param1:Object) : void
        {
            var callback:Function;
            var data:* = param1;
            if (this._userbatchRuneIngot == 0 || this._userbatchRuneIngot > _ctrl.player.ingot)
            {
                _view.showTip(RuneViewLang.InsufficientIngot);
            }
            else if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.BatchRune))
            {
                this.dialog.yesLabel = RuneViewLang.Sure;
                this.dialog.cancelLabel = RuneViewLang.Cancel;
                this.dialog.hasCheckbox = true;
                callback = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    batch_rune_use();
                }
                if (dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.BatchRune, true);
                }
                return;
            }// end function
            ;
                this.dialog.show(data.info, AlertButtonType.Yes | AlertButtonType.Cancel, callback);
            }
            else
            {
                this.batch_rune_use();
            }
            return;
        }// end function

        public function onBatchRune(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.batch_rune_use();
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
            this._rune.close();
            return;
        }// end function

        public function close() : void
        {
            this._isUser = false;
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

    }
}
