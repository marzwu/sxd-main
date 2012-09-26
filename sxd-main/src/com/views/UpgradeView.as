package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class UpgradeView extends Base implements IView
    {
        private var _upgrade:IUpgrade;
        private var _aryUpgradeList:Array;
        private var _intPreviousEquipID:int;
        private var _pageSize:int = 15;
        private var _blnFirstOpenUI:Boolean = true;
        private var _blnInUpgrade:Boolean = false;
        private var _nextCoin:Number;

        public function UpgradeView()
        {
            this._aryUpgradeList = [];
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            if (_view.factionWarMap.isFactionWarStart == true)
            {
                return;
            }
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            this._intPreviousEquipID = this._upgrade.previousEquipID;
            _popup.closeView(this);
            this._view.guide.trackUpgrade(4, _view.toolbar.questTraceContent);
            return;
        }// end function

        public function clear() : void
        {
            this._upgrade.clear();
            this.dialog.hide();
            Helper.gc();
            return;
        }// end function

        public function set updateCoins(param1:Number) : void
        {
            if (inStage)
            {
                this._upgrade.myCoins = param1;
                this._upgrade.updateCoins();
            }
            return;
        }// end function

        private function loadData() : void
        {
            _data.call(Mod_Role_Base.get_simple_role_list, this.loadDataCallBack, [this._ctrl.player.playerId], false);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("Upgrade", this.render, UpgradeViewLang.LoadInfo);
            return;
        }// end function

        private function render() : void
        {
            if (this._upgrade == null)
            {
                this._upgrade = _view.getAssetsObject("Upgrade", "Upgrade") as IUpgrade;
            }
            this.init();
            this.get_equipment_list();
            this.getSimpleRoleListCallBack();
            return;
        }// end function

        private function init() : void
        {
            this._blnFirstOpenUI = true;
            this._upgrade.myLevel = this._ctrl.player.level;
            this._upgrade.myCoins = this._ctrl.player.coins;
            this._upgrade.tip = _view.tip.iTip;
            this._upgrade.drag = _view.drag.iDrag;
            this._upgrade.onCloseBtn = this.close;
            this._upgrade.onEquipmentData = this.get_equipment_list;
            this._upgrade.onLevelUpBtn = this.upgrade_equip;
            this._upgrade.onShowInsufficientCoins = this.showInsufficientCoins;
            this._upgrade.pageCurrent = 1;
            this._upgrade.init(this._intPreviousEquipID, 0);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._upgrade.content);
            _view.center(sign, this._upgrade.content);
            return;
        }// end function

        private function getPageCount(param1:Array) : int
        {
            return Math.ceil(param1.length / this._pageSize);
        }// end function

        private function setCurrentPage(param1:Array) : int
        {
            var _loc_5:Object = null;
            var _loc_2:* = this._upgrade.pageCurrent;
            if (this._intPreviousEquipID == 0)
            {
                return _loc_2;
            }
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1[_loc_4];
                if (this._intPreviousEquipID == _loc_5["player_item_id"])
                {
                    _loc_2 = Math.ceil((_loc_4 + 1) / this._pageSize);
                    break;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function showInsufficientCoins(param1:Number) : void
        {
            this._nextCoin = param1;
            this.lostCoin();
            return;
        }// end function

        private function lostCoin() : void
        {
            if (_ctrl.player.coins >= this._nextCoin)
            {
                return;
            }
            if (this._view.rune.Count > 0 && this.inStage && !this._view.rune.inStage)
            {
                this._view.processTip.openCoinsInsufficient();
            }
            return;
        }// end function

        private function get_simple_role_list() : void
        {
            this._data.call(Mod_Role_Base.get_simple_role_list, this.getSimpleRoleListCallBack, [this._ctrl.player.playerId], false);
            return;
        }// end function

        private function getSimpleRoleListCallBack() : void
        {
            var _loc_1:* = this._ctrl.upgrade.getSimpleRoleList();
            this._upgrade.renderRoleList(_loc_1);
            return;
        }// end function

        private function get_equipment_list() : void
        {
            this._upgrade.myLevel = this._ctrl.player.level;
            this._upgrade.myCoins = this._ctrl.player.coins;
            var _loc_1:Array = [];
            if (this._blnFirstOpenUI)
            {
                _loc_1 = [this._intPreviousEquipID, this._ctrl.player.mainPlayerRoleId];
            }
            else
            {
                _loc_1 = [0, this._upgrade.currentRoleID];
            }
            this._data.call(Mod_Item_Base.get_equipment_list, this.getEquipmentListTimeOut, _loc_1);
            return;
        }// end function

        private function getEquipmentListTimeOut() : void
        {
            if (this._ctrl.upgrade.isEquipDataReturn)
            {
                this.equipmentListCallBack();
            }
            else
            {
                setTimeout(this.getEquipmentListTimeOut, 20);
            }
            return;
        }// end function

        private function equipmentListCallBack() : void
        {
            var _loc_1:* = this._ctrl.upgrade.getEquipmentListRoleID();
            this._upgrade.currentRoleID = _loc_1["player_role_id"];
            var _loc_2:* = this._ctrl.upgrade.getEquipmentList();
            this._upgrade.pageCount = this.getPageCount(_loc_2);
            this._upgrade.pageCurrent = this.setCurrentPage(_loc_2);
            this._intPreviousEquipID = 0;
            _loc_2 = _loc_2.slice((this._upgrade.pageCurrent - 1) * this._pageSize, this._upgrade.pageCurrent * this._pageSize);
            this._upgrade.renderEquipmentList(_loc_2);
            if (this._blnFirstOpenUI)
            {
                this.showUI();
                this._blnFirstOpenUI = false;
            }
            _view.guide.trackUpgrade(2, this._upgrade.content);
            if (_loc_2.length == 0)
            {
                _view.guide.trackUpgrade(3, this._upgrade.content);
            }
            return;
        }// end function

        private function upgrade_equip() : void
        {
            if (this._blnInUpgrade)
            {
                return;
            }
            this._blnInUpgrade = true;
            var _loc_1:Array = [this._upgrade.equipmentID, 100, 0];
            this._data.call(Mod_Item_Base.upgrade_equip, this.upgradeEquipmentCallBacek, _loc_1);
            return;
        }// end function

        private function upgradeEquipmentCallBacek() : void
        {
            var _loc_1:* = this._ctrl.upgrade.upgradeEquipment();
            var _loc_2:* = this._ctrl.upgrade.upgradeEquipmentInfo();
            if (_loc_1["result"] == Mod_Item_Base.ACTION_SUCCESS)
            {
                this._upgrade.renderUpgradeSuccess(_loc_2);
                this._upgrade.showUpgrageMessage(this.upgradeMessage(_loc_1["result"]), 16773632);
                this._view.toolbar.upgradeEquipBack(_loc_2["player_item_id"], _loc_2["upgrade_level"], _loc_2["upgrade_price"]);
            }
            else if (_loc_1["result"] == Mod_Item_Base.LOW_SUCCESS_RATE)
            {
                this._upgrade.renderUpgradeUnSucess();
                this._upgrade.showUpgrageMessage(Lang.sprintf(UpgradeViewLang.UpgradeReturn, this.upgradeMessage(_loc_1["result"]), Math.floor(_loc_2["upgrade_price"] / 2)), 15073811);
            }
            else
            {
                _view.showTip(this.upgradeMessage(_loc_1["result"]));
            }
            this._blnInUpgrade = false;
            this._view.guide.trackUpgrade(3, this._upgrade.content);
            return;
        }// end function

        private function upgradeMessage(param1:int) : String
        {
            var _loc_2:String = null;
            switch(param1)
            {
                case Mod_Item_Base.ACTION_SUCCESS:
                {
                    _loc_2 = UpgradeViewLang.ActionSuccess;
                    break;
                }
                case Mod_Item_Base.PLAYER_ITEM_NO_EXIST:
                {
                    _loc_2 = UpgradeViewLang.PlayerItemNoExist;
                    break;
                }
                case Mod_Item_Base.LEVEL_LIMIT:
                {
                    _loc_2 = UpgradeViewLang.LevelLimit;
                    break;
                }
                case Mod_Item_Base.INSUFFICIENT_COINS:
                case Mod_Item_Base.INSUFFICIENT_COIN:
                {
                    _loc_2 = UpgradeViewLang.InsufficientCoin;
                    break;
                }
                case Mod_Item_Base.PROBABILITY_CHANGE:
                {
                    _loc_2 = UpgradeViewLang.ProbabilityChange;
                    break;
                }
                case Mod_Item_Base.COOLDOWN_TIME:
                {
                    _loc_2 = UpgradeViewLang.CoolDownTime;
                    break;
                }
                case Mod_Item_Base.LOW_SUCCESS_RATE:
                {
                    _loc_2 = UpgradeViewLang.LowSuccessRate;
                    break;
                }
                case Mod_Item_Base.INSUFFICIENT_INGOT:
                {
                    _loc_2 = UpgradeViewLang.InsufficientIngot;
                    break;
                }
                case Mod_Item_Base.ZERO_CD_TIME:
                {
                    _loc_2 = UpgradeViewLang.ZeroCdTime;
                    break;
                }
                case Mod_Item_Base.ALREADY_HAVE:
                {
                    _loc_2 = UpgradeViewLang.AlreadyHave;
                    break;
                }
                case Mod_Item_Base.NOSUITEROLELEVEL:
                {
                    _loc_2 = UpgradeViewLang.NoSuiteroLelevel;
                    break;
                }
                case Mod_Item_Base.NOVIPLEVEL:
                {
                    _loc_2 = UpgradeViewLang.NoVipLevel;
                    break;
                }
                case Mod_Item_Base.NOUPGRADEQUEUE:
                {
                    _loc_2 = UpgradeViewLang.NoUpgradeQueue;
                    break;
                }
                default:
                {
                    _loc_2 = UpgradeViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
