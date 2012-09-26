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
    import flash.geom.*;

    public class SealSoulView extends Base implements IView
    {
        private var _isUser:Boolean = false;
        private var _isTenTimes:Boolean = false;
        private var _showRoleId:int = 0;
        private var _mainRoleId:int = 0;
        private var _isAuto:Boolean = false;
        private var _succinctNum:int = 0;
        private var _alert:IAlert;
        private var _sealSoul:ISealSoul;
        private var _aciviationId:int = 0;
        private var _playerSoulId:int = 0;
        private var _attributeId:int = 0;
        private var _buyId:int = 0;
        private var _salePrice:int = 0;
        private var _stoneNum:int = 0;
        private var _oldAId:int = 0;

        public function SealSoulView()
        {
            _inStageTipTitle = SealSoulViewLang.inStageTipTitle;
            _inStageTipContent = "";
            return;
        }// end function

        public function soul_info_by_location() : void
        {
            _data.call(Mod_SealSoul_Base.soul_info_by_location, this.soulInfoListCallBack, []);
            return;
        }// end function

        private function get_role_list() : void
        {
            _data.call(Mod_Role_Base.get_simple_role_list, this.getRoleListCallBack, [this._ctrl.player.playerId]);
            return;
        }// end function

        private function get_item_info_by_role_id(param1:int) : void
        {
            _data.call(Mod_SealSoul_Base.get_item_info_by_role_id, this.itemInfoByRoleIdCallBack, [param1]);
            return;
        }// end function

        private function swap_soul(param1:int, param2:int, param3:int, param4:int) : void
        {
            _data.call(Mod_SealSoul_Base.swap_soul, this.swapSoulCallBack, [param1, param2, param3, param4]);
            return;
        }// end function

        private function move_soul(param1:int, param2:int, param3:int, param4:int) : void
        {
            _data.call(Mod_SealSoul_Base.move_soul, this.moveSoulCallBack, [param1, param2, param3, param4]);
            return;
        }// end function

        private function open_player_soul_key(param1:int) : void
        {
            _data.call(Mod_SealSoul_Base.open_player_soul_key, this.openPlayerSoulKeyCallBack, [param1]);
            return;
        }// end function

        private function soul_attribute_reset(param1:int, param2:int, param3:int, param4:int) : void
        {
            this._isUser = true;
            _data.call(Mod_SealSoul_Base.soul_attribute_reset, this.soulAttributeResetCallBack, [param1, param2, param3, param4]);
            return;
        }// end function

        private function get_ten_times_reset_value(param1:int, param2:int, param3:int, param4:int) : void
        {
            this._isUser = true;
            this._isTenTimes = true;
            _data.call(Mod_SealSoul_Base.get_ten_times_reset_value, this.tenTimesResetCallBack, [param1, param2, param3, param4]);
            return;
        }// end function

        private function set_player_soul_value(param1:int) : void
        {
            _data.call(Mod_SealSoul_Base.set_player_soul_value, this.playerSoulValeCallBack, [param1]);
            return;
        }// end function

        public function get_tower_key() : void
        {
            _data.call(Mod_SealSoul_Base.get_tower_key, this.getTowerKeyCallBack, []);
            return;
        }// end function

        public function sell_player_soul(param1:int) : void
        {
            _data.call(Mod_SealSoul_Base.sell_player_soul, this.sellPlayerSoulCallBack, [param1]);
            return;
        }// end function

        public function get_reset_count() : void
        {
            _data.call(Mod_SealSoul_Base.get_reset_count, this.getResetCountCallBack, []);
            return;
        }// end function

        public function get_stone_count() : void
        {
            _data.call(Mod_SealSoul_Base.get_stone_count, this.getStoneCountCallBack, []);
            return;
        }// end function

        public function lock(param1:int) : void
        {
            _data.call(Mod_SealSoul_Base.lock, this.lockCallBack, [param1]);
            return;
        }// end function

        public function will_to_unlock(param1:int) : void
        {
            _data.call(Mod_SealSoul_Base.will_to_unlock, this.willToUnlockCallBack, [param1]);
            return;
        }// end function

        private function saveLock(param1:int, param2:int, param3:int, param4:int) : void
        {
            _data.call(Mod_SealSoul_Base.save_lock, this.saveLockCallBack, [param1, param2, param3, param4]);
            return;
        }// end function

        private function upBuff(param1:int) : void
        {
            return;
        }// end function

        private function getTowerKeyCallBack() : void
        {
            this.get_role_list();
            return;
        }// end function

        private function soulInfoListCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.soulInfoList;
            this._sealSoul.getWeaponList = _loc_1;
            var _loc_2:* = 16 - _loc_1.length;
            _view.tower.updateBagNum(_loc_2);
            return;
        }// end function

        private function getRoleListCallBack() : void
        {
            var _loc_1:Array = null;
            if (inStage)
            {
                _loc_1 = _ctrl.upgrade.getSimpleRoleList();
                this.extractionRole(_loc_1);
            }
            else
            {
                this.renderShow();
            }
            return;
        }// end function

        private function extractionRole(param1:Array) : void
        {
            var _loc_6:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_6 = param1[_loc_5];
                if (_loc_6.old_name == _ctrl.player.nickname)
                {
                    _loc_3 = _loc_6.roleId;
                    _loc_4 = _loc_6.id;
                }
                if (this._showRoleId == _loc_6.id)
                {
                    this.jobForWeapon(_loc_6.roleId);
                    this._sealSoul.getPlayerList(param1, this._showRoleId);
                    return;
                }
                _loc_5++;
            }
            this._showRoleId = _loc_4;
            this.jobForWeapon(_loc_3);
            this._sealSoul.getPlayerList(param1, this._showRoleId);
            return;
        }// end function

        private function itemInfoByRoleIdCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.itemInfo;
            if (inStage == false)
            {
                return;
            }
            this._sealSoul.getPlayerWeaponInfo = _loc_1;
            this._sealSoul.getSealSoulList = _loc_1.soulSealList;
            this.soul_info_by_location();
            return;
        }// end function

        private function jobForWeapon(param1:int) : void
        {
            var _loc_2:* = RoleType.getJobSignByRoleId(param1);
            this._sealSoul.getJobToSealSoul = _loc_2;
            this.get_item_info_by_role_id(this._showRoleId);
            return;
        }// end function

        private function soulAttributeResetCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.soulAtributeReset;
            if (_loc_1.msg == Mod_SealSoul_Base.SUCCEED)
            {
                this._sealSoul.getSuccinctNum = this._succinctNum + 1;
                this.get_reset_count();
                this.get_stone_count();
                this.get_item_info_by_role_id(this._showRoleId);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            this._isUser = false;
            return;
        }// end function

        private function tenTimesResetCallBack() : void
        {
            this._isUser = false;
            this._isTenTimes = false;
            var _loc_1:* = _ctrl.sealSoul.tenTimesReset;
            if (_loc_1.msg == Mod_SealSoul_Base.SUCCEED)
            {
                this._sealSoul.getSuccinctNum = this._succinctNum + 10;
                this.get_reset_count();
                this.get_stone_count();
                this._isAuto = true;
                this.set_player_soul_value(1);
                this._sealSoul.getbatchTrainingList = _loc_1.attributeList;
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function playerSoulValeCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.playerSoulValue;
            if (_loc_1.msg == Mod_SealSoul_Base.SUCCEED)
            {
                if (this._isAuto == false)
                {
                    _view.showTip(SealSoulViewLang.SaveSuccess, SealSoulViewLang.SoulVale, TipType.Success);
                }
                this.get_item_info_by_role_id(this._showRoleId);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function sellPlayerSoulCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.sellPlayerSoul;
            if (_loc_1.msg == Mod_SealSoul_Base.SUCCEED)
            {
                _view.showTip(SealSoulViewLang.SellPlayerSoul, Lang.sprintf(SealSoulViewLang.GetStoneSale, this._stoneNum, this._salePrice), TipType.Success);
                this.get_stone_count();
                this.get_item_info_by_role_id(this._showRoleId);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function openPlayerSoulKeyCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.openSoulKey;
            if (_loc_1.msg == Mod_SealSoul_Base.SUCCEED)
            {
                this.get_item_info_by_role_id(this._showRoleId);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function swapSoulCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.swapSoul;
            if (_loc_1.msg == Mod_SealSoul_Base.SUCCEED)
            {
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            this.get_item_info_by_role_id(this._showRoleId);
            return;
        }// end function

        private function getResetCountCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.getResetCount;
            this._succinctNum = _loc_1;
            this._sealSoul.getSuccinctNum = _loc_1;
            return;
        }// end function

        private function getStoneCountCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.getStoneCount;
            this._sealSoul.getStoneNum = _loc_1;
            return;
        }// end function

        private function moveSoulCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.moveSoul;
            if (_loc_1.msg == Mod_SealSoul_Base.SUCCEED)
            {
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            this.get_item_info_by_role_id(this._showRoleId);
            return;
        }// end function

        private function willToUnlockCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.getUnLockData;
            if (_loc_1.msg == Mod_SealSoul_Base.SUCCEED)
            {
                _view.showTip(SealSoulViewLang.WillToUnlock, SealSoulViewLang.SystemInfo, TipType.Success);
                this.get_item_info_by_role_id(this._showRoleId);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function lockCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.getLockData;
            if (_loc_1.msg == Mod_SealSoul_Base.SUCCEED)
            {
                _view.showTip(SealSoulViewLang.Lock, SealSoulViewLang.SystemInfo, TipType.Success);
                this.get_item_info_by_role_id(this._showRoleId);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function upBuffCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.upBuff;
            if (_loc_1 == Mod_SealSoul_Base.SUCCEED)
            {
                _view.showTip(SealSoulViewLang.UpBuff, null, TipType.Success);
                this.get_stone_count();
                this.get_item_info_by_role_id(this._showRoleId);
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_SealSoul_Base.FAILED:
                {
                    _view.showTip(SealSoulViewLang.Failed);
                    break;
                }
                case Mod_SealSoul_Base.NO_ENOUGH_INGOT:
                {
                    _view.showTip(SealSoulViewLang.NoEnoughIngot);
                    break;
                }
                case Mod_SealSoul_Base.NO_ENOUGH_COIN:
                {
                    _view.showTip(SealSoulViewLang.NoEnoughCoin);
                    break;
                }
                case Mod_SealSoul_Base.NO_RECORD:
                {
                    _view.showTip(SealSoulViewLang.NoRecord);
                    break;
                }
                case Mod_SealSoul_Base.PLAYER_ERROR:
                {
                    _view.showTip(SealSoulViewLang.PLAYER_ERROR);
                    break;
                }
                case Mod_SealSoul_Base.NOT_ENOUGH_NINE:
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

        public function set alert(param1:IAlert) : void
        {
            this._alert = param1;
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        public function refreshSoul() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this.get_item_info_by_role_id(this._showRoleId);
            this.get_reset_count();
            this.get_stone_count();
            return;
        }// end function

        private function saveLockCallBack() : void
        {
            var _loc_1:* = _ctrl.sealSoul.saveLock;
            if (_loc_1.msg == Mod_SealSoul_Base.SUCCEED)
            {
                ;
            }
            return;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.SealSoul) == false)
            {
                _view.showTip(SealSoulViewLang.UnOpen);
                return;
            }
            if (this.inStage)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.SealSoul))
            {
                this.get_tower_key();
            }
            else
            {
                _view.showTip(SealSoulViewLang.NoOpen);
            }
            return;
        }// end function

        public function renderShow() : void
        {
            loadAssets("SealSoul", this.render, SealSoulViewLang.LoadAssets);
            return;
        }// end function

        public function render() : void
        {
            this._sealSoul = _view.getAssetsObject("SealSoul", "SealSoul") as ISealSoul;
            _popup.addView(this, this._sealSoul.content);
            _view.center(sign, this._sealSoul.content);
            this.alert = _view.alert.iAlert;
            this._sealSoul.tip = _view.tip.iTip;
            this._sealSoul.drag = _view.drag.iDrag;
            this._sealSoul.getOpenNum = _ctrl.sealSoul.getTowerKey;
            this._sealSoul.onCheckPlayer = function (param1:Object) : void
            {
                _showRoleId = param1.id;
                jobForWeapon(param1.roleId);
                return;
            }// end function
            ;
            this._sealSoul.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._sealSoul.onShowChat = function (param1:Array) : void
            {
                _view.chat.showMsg(param1);
                return;
            }// end function
            ;
            this._sealSoul.showTip = function (param1:String, param2:Object = null) : void
            {
                showTip(param1, param2);
                return;
            }// end function
            ;
            this._sealSoul.onBuy = function (param1:Object, param2:int) : void
            {
                var callback:Function;
                var data:* = param1;
                var stoneNum:* = param2;
                _salePrice = data.salePrice;
                _stoneNum = stoneNum;
                _buyId = data.playerSoulId;
                if (!_view.getCookie("BuySealSoul"))
                {
                    dialog.yesLabel = SealSoulViewLang.Sure;
                    dialog.cancelLabel = SealSoulViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        _sealSoul.buyLoadData();
                        sell_player_soul(_buyId);
                    }
                    if (param1 == AlertButtonType.Cancel)
                    {
                        _sealSoul.resetLive();
                    }
                    if (dialog.checked)
                    {
                        _view.setCookie("BuySealSoul", true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(HtmlText.yellow(Lang.sprintf(SealSoulViewLang.BuySeal, HtmlText.format(data.soulName, data.color), stoneNum, data.salePrice)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    _sealSoul.buyLoadData();
                    sell_player_soul(_buyId);
                }
                return;
            }// end function
            ;
            this._sealSoul.onChange = function (param1:int, param2:int, param3:int, param4:int) : void
            {
                _sealSoul.LoadData();
                swap_soul(param1, param2, param3, param4);
                return;
            }// end function
            ;
            this._sealSoul.onMove = function (param1:int, param2:int, param3:int, param4:int) : void
            {
                _sealSoul.LoadData();
                move_soul(param1, param2, param3, param4);
                return;
            }// end function
            ;
            this._sealSoul.onCloseTraining = function () : void
            {
                _view.alert.showYesNoMsg(SealSoulViewLang.CloseTraining, SealSoulViewLang.Sure, SealSoulViewLang.Cancel, onCloseTraining);
                return;
            }// end function
            ;
            this._sealSoul.onSuccinct = function (param1:Array, param2:int, param3:int, param4:int, param5:String) : void
            {
                var data:Object;
                var callback:Function;
                var value:int;
                var money:int;
                var list:* = param1;
                var playerSoulId:* = param2;
                var openAttributeNum:* = param3;
                var noMoneyNum:* = param4;
                var tipStr:* = param5;
                if (_isUser)
                {
                    _view.showTip(SealSoulViewLang.UserWidth);
                    return;
                }
                var len:* = list.length;
                data = succinct(len, playerSoulId, list);
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.SoulSuccinct) && noMoneyNum <= 0)
                {
                    dialog.yesLabel = SealSoulViewLang.Sure;
                    dialog.cancelLabel = SealSoulViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        soul_attribute_reset(data.playerSoulId, list[0], list[1], list[2]);
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.SoulSuccinct, true);
                    }
                    return;
                }// end function
                ;
                    value = 10 + len * 10;
                    money = 10000 + len * 10000;
                    dialog.show(HtmlText.yellow(tipStr), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    soul_attribute_reset(data.playerSoulId, list[0], list[1], list[2]);
                }
                return;
            }// end function
            ;
            this._sealSoul.onActivation = function (param1:int) : void
            {
                _playerSoulId = param1;
                soulActivation(param1);
                return;
            }// end function
            ;
            this._sealSoul.onTraining = function (param1:Array, param2:int, param3:int, param4:String) : void
            {
                var data:Object;
                var callback:Function;
                var list:* = param1;
                var playerSoulId:* = param2;
                var openAttributeNum:* = param3;
                var tipStr:* = param4;
                if (_isUser)
                {
                    _view.showTip(SealSoulViewLang.UserWidth);
                    return;
                }
                var len:* = list.length;
                data = succinct(len, playerSoulId, list);
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.SoulTraining2))
                {
                    dialog.yesLabel = SealSoulViewLang.Sure;
                    dialog.cancelLabel = SealSoulViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        get_ten_times_reset_value(data.playerSoulId, list[0], list[1], list[2]);
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.SoulTraining2, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(HtmlText.yellow(tipStr), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    get_ten_times_reset_value(data.playerSoulId, list[0], list[1], list[2]);
                }
                return;
            }// end function
            ;
            this._sealSoul.onSave = function (param1:int) : void
            {
                _isAuto = false;
                set_player_soul_value(param1);
                return;
            }// end function
            ;
            this._sealSoul.onShowBatchTraining = function () : void
            {
                _view.closeEvent();
                return;
            }// end function
            ;
            this._sealSoul.onHideBatchTraining = function () : void
            {
                _view.openEvent();
                return;
            }// end function
            ;
            this._sealSoul.onLock = function (param1:Object) : void
            {
                var callback:Function;
                var data:* = param1;
                if (!_view.getCookie("sealSoulOnLock"))
                {
                    dialog.yesLabel = SealSoulViewLang.Sure;
                    dialog.cancelLabel = SealSoulViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        lock(data.playerSoulId);
                    }
                    if (dialog.checked)
                    {
                        _view.setCookie("sealSoulOnLock", true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(Lang.sprintf(HtmlText.white(SealSoulViewLang.LockSeal), HtmlText.format(data.soulName, data.color)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    lock(data.playerSoulId);
                }
                return;
            }// end function
            ;
            this._sealSoul.onUnLock = function (param1:Object) : void
            {
                var callback:Function;
                var data:* = param1;
                if (!_view.getCookie("sealSoulUnLock"))
                {
                    dialog.yesLabel = SealSoulViewLang.Sure;
                    dialog.cancelLabel = SealSoulViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        will_to_unlock(data.playerSoulId);
                    }
                    if (dialog.checked)
                    {
                        _view.setCookie("sealSoulUnLock", true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(Lang.sprintf(HtmlText.white(SealSoulViewLang.UnLockSeal), HtmlText.format(data.soulName, data.color)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    will_to_unlock(data.playerSoulId);
                }
                return;
            }// end function
            ;
            this._sealSoul.onOpenSoulShop = function () : void
            {
                _view.sealStoneShop.switchSelf();
                return;
            }// end function
            ;
            this._sealSoul.onSaveSoul = function (param1:int, param2:Array) : void
            {
                saveLock(param1, param2[0], param2[1], param2[2]);
                return;
            }// end function
            ;
            this._sealSoul.onBlessLevel = function (param1:int) : void
            {
                upBuff(param1);
                return;
            }// end function
            ;
            this._sealSoul.init();
            this._sealSoul.isLevel5 = VIPType.check(VIPType.Level5);
            this.get_reset_count();
            this.get_stone_count();
            this.getRoleListCallBack();
            this.reposition();
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
                this._sealSoul.reposition(_loc_2);
            }
            return;
        }// end function

        private function showTip(param1:String, param2:Object) : void
        {
            switch(param1)
            {
                case "noOpen":
                {
                    _view.showTip(SealSoulViewLang.noOpen);
                    break;
                }
                case "lockOn":
                {
                    _view.showTip(SealSoulViewLang.lockOn);
                    break;
                }
                case "isNull":
                {
                    _view.showTip(SealSoulViewLang.isNull);
                    break;
                }
                case "noPickWeapon":
                {
                    _view.showTip(SealSoulViewLang.noPickWeapon);
                    break;
                }
                case "soulError":
                {
                    this.get_item_info_by_role_id(this._showRoleId);
                    break;
                }
                case "showTraining":
                {
                    _view.showTip(SealSoulViewLang.showTraining);
                    break;
                }
                case "showSuccinct":
                {
                    _view.showTip(SealSoulViewLang.showSuccinct);
                    break;
                }
                case "IsTrainingShow":
                {
                    _view.showTip(SealSoulViewLang.IsTrainingShow);
                    break;
                }
                case "oldLockOn":
                {
                    this._attributeId = param2.AttributeId;
                    _view.alert.showYesNoMsg(SealSoulViewLang.oldLockOn, SealSoulViewLang.Sure, SealSoulViewLang.Cancel, this.onSave);
                    break;
                }
                case "emptySave":
                {
                    _view.showTip(SealSoulViewLang.emptySave);
                    break;
                }
                case "trainingQuality":
                {
                    this._attributeId = param2.attributeId;
                    this._oldAId = param2.oldAId;
                    if (param2.lockList.length < 2)
                    {
                        _view.alert.showYesNoMsg(Lang.sprintf(SealSoulViewLang.trainingQuality1, HtmlText.format(param2.name + "+" + param2.valueInfo, param2.color)), SealSoulViewLang.Sure, SealSoulViewLang.Cancel, this.onLockOn);
                    }
                    else
                    {
                        _view.alert.showYesNoMsg(Lang.sprintf(SealSoulViewLang.trainingQuality2, HtmlText.format(param2.name + "+" + param2.valueInfo, param2.color)), SealSoulViewLang.Sure, SealSoulViewLang.Cancel, this.onSave2);
                    }
                    break;
                }
                case "userBlessStone":
                {
                    _view.showTip(SealSoulViewLang.stoneNoNum);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._sealSoul.resetLive();
            return;
        }// end function

        private function succinct(param1:int, param2:int, param3:Array) : Object
        {
            var _loc_4:Object = {};
            {}.playerSoulId = param2;
            if (param1 <= 0)
            {
                _loc_4.l1id = 0;
                _loc_4.l2id = 0;
            }
            if (param1 == 1)
            {
                _loc_4.l1id = param3[0];
                _loc_4.l2id = 0;
            }
            if (param1 == 2)
            {
                _loc_4.l1id = param3[0];
                _loc_4.l2id = param3[1];
            }
            return _loc_4;
        }// end function

        private function soulActivation(param1:int) : void
        {
            var callback:Function;
            var playerSoulId:* = param1;
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.SoulActivation))
            {
                this.dialog.yesLabel = SealSoulViewLang.Sure;
                this.dialog.cancelLabel = SealSoulViewLang.Cancel;
                this.dialog.hasCheckbox = true;
                callback = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    open_player_soul_key(playerSoulId);
                }
                if (dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.SoulActivation, true);
                }
                return;
            }// end function
            ;
                this.dialog.show(HtmlText.yellow(SealSoulViewLang.SoulActivation), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
            }
            else
            {
                this.open_player_soul_key(playerSoulId);
            }
            return;
        }// end function

        private function onLockOn(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.set_player_soul_value(this._attributeId);
                    this._sealSoul.isSave = true;
                    this._sealSoul.isLockOn(this._oldAId, true);
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

        private function onSave(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this._isAuto = false;
                    this.set_player_soul_value(this._attributeId);
                    this._sealSoul.isSave = true;
                    break;
                }
                case AlertButtonType.No:
                {
                    this._sealSoul.isSave = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onSave2(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this._isAuto = false;
                    this.set_player_soul_value(this._attributeId);
                    this._sealSoul.isSave = true;
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

        private function onCloseTraining(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this._sealSoul.hideTraining();
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
            this._sealSoul.clear();
            return;
        }// end function

        public function close() : void
        {
            this._isUser = false;
            this._isTenTimes = false;
            this.clear();
            _popup.closeView(this);
            Helper.gc();
            return;
        }// end function

    }
}
