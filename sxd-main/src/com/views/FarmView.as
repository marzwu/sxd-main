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
    import flash.utils.*;

    public class FarmView extends Base implements IView
    {
        private var _farm:IFarm;
        private var _dialog:IAlert = null;
        private var _intNextRemainingIngot:int;
        private var _intNextFieldLevelUpIngot:int;
        private var _intRefreshIngot:int;
        private var _blnInHarvest:Boolean = false;
        private var _blnInTurbo:Boolean = false;
        private var _blnInRefreshHerbsSeed:Boolean = false;
        private var _blnInGetTopHerbsSeed:Boolean = false;
        private var _blnInPlantHerbs:Boolean = false;
        private var _blnInClearFarmlandCd:Boolean = false;
        private var _blnInReclamation:Boolean = false;
        private var _blnInUpFarmlandLevel:Boolean = false;
        private var _blnInIngotForFarmland:Boolean = false;
        private var _blnInBuyCoinTreeCount:Boolean = false;
        private var _intCoinTreeCd:int;

        public function FarmView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.factionWarMap.isFactionWarStart == true)
            {
                return;
            }
            RoleType.loadJobLevelData(new Function());
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
            this._view.removeFromTimerProcessList(this.sign);
            this._data.cancelPatch(Mod_Farm_Base.coin_tree_count_notify);
            this._dialog.hide();
            this._farm.clear();
            Helper.gc();
            return;
        }// end function

        public function getFarmState() : void
        {
            this.get_simple_farmlandinfo();
            return;
        }// end function

        public function getFarmlandinfoList() : void
        {
            if (this.inStage)
            {
                this.get_farmlandinfo_list();
            }
            return;
        }// end function

        private function loadData() : void
        {
            this._data.call(Mod_Farm_Base.get_farmlandinfo_list, this.loadDataCallBack, [], false);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            if (!this._ctrl.farm.getIsImgComplete)
            {
                setTimeout(this.loadDataCallBack, 20);
                return;
            }
            var callBack:* = function () : void
            {
                render();
                getFarmlandinfoListCallBack();
                showUI();
                return;
            }// end function
            ;
            loadAssets("Farm", callBack, FarmViewLang.LoadInfo);
            return;
        }// end function

        private function render() : void
        {
            if (this._farm == null)
            {
                this._farm = _view.getAssetsObject("Farm", "Farm") as IFarm;
            }
            this.init();
            this._farm.render();
            if (FunctionType.isOpened(FunctionType.CoinTree))
            {
                this.buy_coin_tree_count_info();
                this.coin_tree_count_notify();
            }
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._farm.content);
            _view.center(sign, this._farm.content);
            return;
        }// end function

        private function init() : void
        {
            this._blnInRefreshHerbsSeed = false;
            this._blnInHarvest = false;
            this._blnInPlantHerbs = false;
            this._blnInTurbo = false;
            this._blnInClearFarmlandCd = false;
            this._blnInReclamation = false;
            this._blnInUpFarmlandLevel = false;
            this._blnInIngotForFarmland = false;
            this._blnInBuyCoinTreeCount = false;
            this._intCoinTreeCd = -1;
            this._blnInGetTopHerbsSeed = false;
            this._farm.cropIconUrl = URI.farmIconUrl;
            this._dialog = this._view.alert.iAlert;
            this._farm.tip = this._view.tip.iTip;
            this._farm.drag = this._view.drag.iDrag;
            this._farm.myIngot = this._ctrl.player.ingot;
            this._farm.myLevel = this._ctrl.player.level;
            this._farm.herbsTypeCoin = Mod_Farm_Base.COIN_HERBS;
            this._farm.herbsTypeExp = Mod_Farm_Base.EXP_HERBS;
            this._farm.onCloseBtn = this.close;
            this._farm.onCanPlantCrop = this.get_herbs_seed;
            this._farm.onFullStar = this.get_top_herbs_seed;
            this._farm.onOpenField = this.reclamation;
            this._farm.onPlantCrop = this.check_role_state;
            this._farm.onFarmData = this.get_farmlandinfo_list;
            this._farm.onPlantRole = this.get_player_roleinfo_list;
            this._farm.onRefreshCrop = this.refresh_herbs_seed;
            this._farm.onHarvest = this.harvest;
            this._farm.onBuyCoinTreeBtn = this.buyCoinTreeCount;
            this._farm.onFieldCdBtn = this.clearFarmlandCD;
            this._farm.onIngotForFarmland = this.ingot_for_farmland;
            this._farm.onFieldLevelUp = this.upFarmlandLevel;
            this._farm.onBatPlant = this.batPlantDialog;
            this._farm.onShowTip = this.showTip;
            this._farm.onIsChristmas = this.isChristmas;
            this._farm.onIsTreePlantingDay = this.isTreePlantingDay;
            return;
        }// end function

        private function updateCdTime() : void
        {
            this._farm.updateFieldCd();
            if (this._intCoinTreeCd >= 0)
            {
                this._farm.updateCoinTreeCd(this._intCoinTreeCd);
                var _loc_1:String = this;
                var _loc_2:* = this._intCoinTreeCd - 1;
                _loc_1._intCoinTreeCd = _loc_2;
            }
            return;
        }// end function

        private function clearFarmlandCD(param1:int, param2:int) : void
        {
            var callBack:Function;
            var intFieldID:* = param1;
            var intFieldTime:* = param2;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    clear_farmland_cd(intFieldID);
                }
                if (_dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.FarmClearFarmlandCD, true);
                }
                return;
            }// end function
            ;
            var intIngot:* = Math.ceil(intFieldTime / (15 * 60)) * 5;
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.FarmClearFarmlandCD))
            {
                this._dialog.yesLabel = FarmViewLang.DialogYes;
                this._dialog.cancelLabel = FarmViewLang.DialogNo;
                this._dialog.hasCheckbox = true;
                this._dialog.show(Lang.sprintf(FarmViewLang.ClearCd, HtmlText.yellow(intIngot + FarmViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            }
            else
            {
                this.clear_farmland_cd(intFieldID);
            }
            return;
        }// end function

        private function showTip(param1:String) : void
        {
            this._view.showTip(param1);
            return;
        }// end function

        private function buyCoinTreeCount() : void
        {
            var obj:Object;
            if (this._blnInBuyCoinTreeCount)
            {
                return;
            }
            this._blnInBuyCoinTreeCount = true;
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.BuyCoinTreeCount))
            {
                var callBack:* = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    buy_coin_tree_count();
                }
                else
                {
                    _blnInBuyCoinTreeCount = false;
                }
                if (_dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.BuyCoinTreeCount, true);
                }
                return;
            }// end function
            ;
                this._dialog.yesLabel = FarmViewLang.DialogYes;
                this._dialog.noLabel = FarmViewLang.DialogNo;
                this._dialog.hasCheckbox = true;
                obj = this._ctrl.farm.buyCoinTreeCountInfo;
                this._dialog.show(Lang.sprintf(FarmViewLang.BuyCoinTree, HtmlText.yellow(obj["ingot"] + FarmViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.No, callBack);
            }
            else
            {
                this.buy_coin_tree_count();
            }
            return;
        }// end function

        private function upFarmlandLevel(param1:int) : void
        {
            var callBack:Function;
            var obj:Object;
            var strMessage:String;
            var intFieldId:* = param1;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    up_farmland_level(intFieldId);
                }
                else
                {
                    _blnInUpFarmlandLevel = false;
                }
                if (_dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.FarmFieldLevelUp, true);
                }
                return;
            }// end function
            ;
            if (this._blnInUpFarmlandLevel)
            {
                return;
            }
            if (!_view.ingotEnough(this._intNextFieldLevelUpIngot))
            {
                return;
            }
            this._blnInUpFarmlandLevel = true;
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.FarmFieldLevelUp))
            {
                obj = this._ctrl.farm.ingotForFarmland;
                strMessage;
                if (obj["field_level"] == 2)
                {
                    strMessage = Lang.sprintf(FarmViewLang.LevelUpRed, HtmlText.yellow(obj["ingot"] + FarmViewLang.Ingot), HtmlText.yellow(obj["field_sort"]), HtmlText.yellow("6"), HtmlText.yellow("20%"));
                }
                else
                {
                    strMessage = Lang.sprintf(FarmViewLang.LevelUpBlack, HtmlText.yellow(obj["ingot"] + FarmViewLang.Ingot), HtmlText.yellow(obj["field_sort"]), HtmlText.yellow("4"), HtmlText.yellow("40%"));
                }
                this._dialog.yesLabel = FarmViewLang.DialogYes;
                this._dialog.noLabel = FarmViewLang.DialogNo;
                this._dialog.hasCheckbox = true;
                this._dialog.show(strMessage, AlertButtonType.Yes | AlertButtonType.No, callBack);
            }
            else
            {
                this.up_farmland_level(intFieldId);
            }
            return;
        }// end function

        private function batPlantDialog(param1:Array, param2:int, param3:int, param4:String, param5:int) : void
        {
            var callBack:Function;
            var strDialog:String;
            var aryFieldId:* = param1;
            var intPlayRoleId:* = param2;
            var intType:* = param3;
            var strHerbsName:* = param4;
            var intBatIngot:* = param5;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    batPlant(aryFieldId, intPlayRoleId, intType);
                }
                else
                {
                    _blnInPlantHerbs = false;
                }
                if (_dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.FarmBatPlant, true);
                }
                return;
            }// end function
            ;
            if (this._blnInPlantHerbs)
            {
                return;
            }
            if (aryFieldId.length <= 0)
            {
                return;
            }
            if (!_view.ingotEnough(intBatIngot))
            {
                return;
            }
            this._blnInPlantHerbs = true;
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.FarmBatPlant))
            {
                this._dialog.yesLabel = FarmViewLang.DialogYes;
                this._dialog.cancelLabel = FarmViewLang.DialogNo;
                this._dialog.hasCheckbox = true;
                strDialog = Lang.sprintf(FarmViewLang.BatPlant, HtmlText.yellow(intBatIngot + FarmViewLang.Ingot), HtmlText.yellow(strHerbsName));
                this._dialog.show(strDialog, AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            }
            else
            {
                this.batPlant(aryFieldId, intPlayRoleId, intType);
            }
            return;
        }// end function

        private function isChristmas() : Boolean
        {
            var _loc_1:* = new Date(this._ctrl.player.serverTime * 1000);
            var _loc_2:* = _loc_1.month == 11 && (_loc_1.date >= 23 && _loc_1.date <= 25);
            return false;
        }// end function

        private function isTreePlantingDay() : Boolean
        {
            var _loc_1:* = new Date(this._ctrl.player.serverTime * 1000);
            var _loc_2:* = _loc_1.fullYear == 2012 && _loc_1.month == 2 && (_loc_1.date >= 10 && _loc_1.date <= 12);
            return _loc_2;
        }// end function

        private function get_herbs_seed(param1:int) : void
        {
            this._data.call(Mod_Farm_Base.get_herbs_seed, this.getHerbsSeedCallBack, [param1]);
            return;
        }// end function

        private function getHerbsSeedCallBack() : void
        {
            var _loc_1:* = this._ctrl.farm.getSingleHerbsSeed;
            var _loc_2:* = this._ctrl.farm.getGroupHerbsSeed;
            this._intRefreshIngot = _loc_1["refresh_ingot"];
            this._farm.renderCanPlantCrop(_loc_1, _loc_2);
            return;
        }// end function

        private function get_top_herbs_seed(param1:int) : void
        {
            var callBack:Function;
            var intType:* = param1;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    _data.call(Mod_Farm_Base.get_top_herbs_seed, getTopHerbsSeedCallBack, [intType]);
                }
                else
                {
                    _blnInGetTopHerbsSeed = false;
                }
                if (_dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.FarmGetTopHerbsSeed, true);
                }
                return;
            }// end function
            ;
            if (this._blnInGetTopHerbsSeed)
            {
                return;
            }
            if (!_view.ingotEnough(100))
            {
                return;
            }
            this._blnInGetTopHerbsSeed = true;
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.FarmGetTopHerbsSeed))
            {
                this._dialog.yesLabel = FarmViewLang.DialogYes;
                this._dialog.cancelLabel = FarmViewLang.DialogNo;
                this._dialog.hasCheckbox = true;
                this._dialog.show(Lang.sprintf(FarmViewLang.GetTopSeed, HtmlText.yellow("100" + FarmViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            }
            else
            {
                this._data.call(Mod_Farm_Base.get_top_herbs_seed, this.getTopHerbsSeedCallBack, [intType]);
            }
            return;
        }// end function

        private function getTopHerbsSeedCallBack() : void
        {
            var _loc_1:* = this._ctrl.farm.getTopHerbsSeed;
            if (_loc_1["result"] == Mod_Farm_Base.SUCCESS)
            {
                this._farm.renderFullStar(_loc_1);
            }
            else
            {
                _view.showTip(this.message(_loc_1.result));
            }
            this._blnInGetTopHerbsSeed = false;
            return;
        }// end function

        private function reclamation() : void
        {
            var callBack:Function;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    _data.call(Mod_Farm_Base.reclamation, reclamationCallBack, []);
                }
                else
                {
                    _blnInReclamation = false;
                }
                return;
            }// end function
            ;
            if (this._blnInReclamation)
            {
                return;
            }
            if (!_view.vipEnabled)
            {
                return;
            }
            if (!_view.ingotEnough(this._intNextRemainingIngot))
            {
                return;
            }
            this._blnInReclamation = true;
            var intMyIngot:* = this._ctrl.player.ingot;
            this._dialog.yesLabel = FarmViewLang.DialogYes;
            this._dialog.noLabel = FarmViewLang.DialogNo;
            if (intMyIngot < this._intNextRemainingIngot)
            {
                this._dialog.yesEnabled = false;
                this._dialog.show(FarmViewLang.EnoughtIngot, AlertButtonType.Yes | AlertButtonType.No, callBack);
                this._dialog.yesEnabled = true;
            }
            else
            {
                this._dialog.show(Lang.sprintf(FarmViewLang.Reclamation, HtmlText.yellow(this._intNextRemainingIngot + FarmViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.No, callBack);
            }
            return;
        }// end function

        private function reclamationCallBack() : void
        {
            var _loc_1:* = this._ctrl.farm.openFarmland;
            if (_loc_1["result"] == Mod_Farm_Base.SUCCESS)
            {
                this._intNextFieldLevelUpIngot = _loc_1["remaining_ingot"];
                this.get_farmlandinfo_list(true);
            }
            else
            {
                this._blnInReclamation = false;
                _view.showTip(this.message(_loc_1.result));
            }
            return;
        }// end function

        private function check_role_state(param1:int, param2:int, param3:int) : void
        {
            var callBack:Function;
            var intFieldId:* = param1;
            var intRoleId:* = param2;
            var intType:* = param3;
            callBack = function () : void
            {
                checkRoleStateCallBack(intFieldId, intRoleId, intType);
                return;
            }// end function
            ;
            if (this._blnInPlantHerbs)
            {
                return;
            }
            this._blnInPlantHerbs = true;
            if (intType == Mod_Farm_Base.EXP_HERBS)
            {
                this._data.call(Mod_Farm_Base.check_role_state, callBack, [this._farm.roleID, intType]);
            }
            else
            {
                this.plant_herbs(intFieldId, intRoleId, intType);
            }
            return;
        }// end function

        private function checkRoleStateCallBack(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = this._ctrl.farm.checkRoleState;
            if (this._ctrl.farm.checkRoleState["result"] == Mod_Farm_Base.PASS)
            {
                this.plant_herbs(param1, param2, param3);
            }
            else
            {
                _view.showTip(this.message(_loc_4.result));
                this._blnInPlantHerbs = false;
            }
            return;
        }// end function

        private function plant_herbs(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:Array = [param1, param2, param3];
            this._data.call(Mod_Farm_Base.plant_herbs, this.plantHerbsCallBack, _loc_4);
            return;
        }// end function

        private function plantHerbsCallBack() : void
        {
            var _loc_1:* = this._ctrl.farm.plantHerbs;
            if (_loc_1["result"] == Mod_Farm_Base.SUCCESS)
            {
                this._farm.renderPlantCrop([_loc_1]);
                this.get_simple_farmlandinfo();
                if (FunctionType.isOpened(FunctionType.CoinTree))
                {
                    this.buy_coin_tree_count_info();
                }
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            this._blnInPlantHerbs = false;
            return;
        }// end function

        private function get_farmlandinfo_list(param1:Boolean = false) : void
        {
            this._data.call(Mod_Farm_Base.get_farmlandinfo_list, this.getFarmlandinfoListCallBack, [], param1);
            return;
        }// end function

        private function getFarmlandinfoListCallBack() : void
        {
            var _loc_1:* = this._ctrl.farm.getFarmlandinfoList;
            this._farm.myIngot = this._ctrl.player.ingot;
            this._farm.renderFarmData(_loc_1);
            this._view.addToTimerProcessList(this.sign, this.updateCdTime);
            if (this._blnInReclamation)
            {
                this._blnInReclamation = false;
            }
            if (this._blnInUpFarmlandLevel)
            {
                this._blnInUpFarmlandLevel = false;
            }
            return;
        }// end function

        private function get_player_roleinfo_list() : void
        {
            this._data.call(Mod_Farm_Base.get_player_roleinfo_list, this.getPlayerRoleinfoListCallBack, []);
            return;
        }// end function

        private function getPlayerRoleinfoListCallBack() : void
        {
            var _loc_1:* = this._ctrl.farm.getPlayerRoleInfoList;
            this._farm.renderPlantRole(_loc_1);
            if (_loc_1.length <= 0)
            {
                this._view.showTip(FarmViewLang.EnoughtRole, FarmViewLang.NeedMoreRole);
            }
            return;
        }// end function

        private function refresh_herbs_seed(param1:int) : void
        {
            var callBack:Function;
            var intType:* = param1;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    _data.call(Mod_Farm_Base.refresh_herbs_seed, refreshHerbsSeedCallBack, [intType]);
                }
                else
                {
                    _blnInRefreshHerbsSeed = false;
                }
                if (_dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.FarmRefreshHerbsSeed, true);
                }
                return;
            }// end function
            ;
            if (this._blnInRefreshHerbsSeed)
            {
                return;
            }
            if (!_view.vipEnabled)
            {
                return;
            }
            if (!_view.ingotEnough(this._intRefreshIngot))
            {
                return;
            }
            this._blnInRefreshHerbsSeed = true;
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.FarmRefreshHerbsSeed))
            {
                this._dialog.yesLabel = FarmViewLang.DialogYes;
                this._dialog.cancelLabel = FarmViewLang.DialogNo;
                this._dialog.hasCheckbox = true;
                this._dialog.show(Lang.sprintf(FarmViewLang.RefreshSeed, HtmlText.yellow(this._intRefreshIngot + FarmViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            }
            else
            {
                this._data.call(Mod_Farm_Base.refresh_herbs_seed, this.refreshHerbsSeedCallBack, [intType]);
            }
            return;
        }// end function

        private function refreshHerbsSeedCallBack() : void
        {
            var _loc_1:* = this._ctrl.farm.refreshHerbsSeed;
            this._intRefreshIngot = _loc_1["refresh_ingot"];
            if (_loc_1["result"] == Mod_Farm_Base.SUCCESS)
            {
                this._farm.renderRefreshCrop(_loc_1);
            }
            else
            {
                _view.showTip(this.message(_loc_1.result));
            }
            this._blnInRefreshHerbsSeed = false;
            return;
        }// end function

        private function harvest(param1:int, param2:int) : void
        {
            var callBack:Function;
            var intfarmlandId:* = param1;
            var intHerbsId:* = param2;
            callBack = function () : void
            {
                harvestCallBack(intfarmlandId, intHerbsId);
                return;
            }// end function
            ;
            if (this._blnInHarvest)
            {
                return;
            }
            this._blnInHarvest = true;
            this._data.call(Mod_Farm_Base.harvest, callBack, [intfarmlandId]);
            return;
        }// end function

        private function harvestCallBack(param1:int, param2:int) : void
        {
            var _loc_4:String = null;
            var _loc_5:Object = null;
            var _loc_3:* = this._ctrl.farm.harvestHerbs;
            if (_loc_3["result"] != Mod_Farm_Base.SUCCESS)
            {
                _view.showTip(this.message(_loc_3["result"]));
                return;
            }
            _loc_3["farmland_id"] = param1;
            _loc_3["herbs_id"] = param2;
            _loc_3["herbs_star_level"] = HerbsType.getStarLevel(param2);
            if (_loc_3["herbs_type"] == Mod_Farm_Base.EXP_HERBS)
            {
                if (_loc_3["level"] > 0)
                {
                    _loc_4 = Lang.sprintf(FarmViewLang.LevelUp, _loc_3["role_name"], _loc_3["level"]);
                }
                else
                {
                    _loc_4 = Lang.sprintf(FarmViewLang.GetExp, _loc_3["role_name"], _loc_3["experience"]);
                }
            }
            else
            {
                _loc_4 = Lang.sprintf(FarmViewLang.GetCoin, _loc_3["coin"]);
                if (this.isChristmas() || this.isTreePlantingDay())
                {
                    _loc_5 = {1:100, 2:150, 3:200, 4:250, 5:300};
                    _loc_4 = _loc_4 + ("\r" + Lang.sprintf(FarmViewLang.GetFame, _loc_5[_loc_3["herbs_star_level"]]));
                }
            }
            this._farm.renderHarvest(_loc_3, HtmlText.green(_loc_4));
            this.get_simple_farmlandinfo();
            this._blnInHarvest = false;
            return;
        }// end function

        private function clear_farmland_cd(param1:int) : void
        {
            var callBack:Function;
            var intFieldID:* = param1;
            callBack = function () : void
            {
                clearFarmlandCdCallBack(intFieldID);
                return;
            }// end function
            ;
            if (this._blnInClearFarmlandCd)
            {
                return;
            }
            this._blnInClearFarmlandCd = true;
            this._data.call(Mod_Farm_Base.clear_farmland_cd, callBack, [intFieldID]);
            return;
        }// end function

        private function clearFarmlandCdCallBack(param1:int) : void
        {
            var _loc_2:* = this._ctrl.farm.clearFarmlandCd;
            if (_loc_2["result"] == Mod_Farm_Base.SUCCESS)
            {
                this._farm.renderClearFarmlandCd(param1);
            }
            else
            {
                _view.showTip(this.message(_loc_2["result"]));
            }
            this._blnInClearFarmlandCd = false;
            return;
        }// end function

        private function get_simple_farmlandinfo() : void
        {
            this._data.call(Mod_Farm_Base.get_simple_farmlandinfo, this.getSimpleFarmlandinfoCallBack, []);
            return;
        }// end function

        public function getSimpleFarmlandinfoCallBack() : void
        {
            var _loc_1:* = _ctrl.farm.getSimpleFarmlandinfo;
            _view.toolbar.setFarmLink(_loc_1["plant_count"], _loc_1["farmland_count"]);
            _view.toolbar.setFunctionLinkPoint();
            _view.activities.addActivity(FunctionType.Farm);
            return;
        }// end function

        private function buy_coin_tree_count_info() : void
        {
            this._data.call(Mod_Farm_Base.buy_coin_tree_count_info, this.buyCoinTreeCountInfoCallBack, []);
            return;
        }// end function

        private function buyCoinTreeCountInfoCallBack() : void
        {
            var _loc_1:* = this._ctrl.farm.buyCoinTreeCountInfo;
            if (_loc_1["coin_tree_count"] < 8)
            {
                this._intCoinTreeCd = _loc_1["recorve_cd"];
            }
            else
            {
                this._intCoinTreeCd = 0;
            }
            this._farm.renderCoinTreeCountInfo(_loc_1);
            this._blnInBuyCoinTreeCount = false;
            return;
        }// end function

        private function buy_coin_tree_count() : void
        {
            this._data.call(Mod_Farm_Base.buy_coin_tree_count, this.buyCoinTreeCountCallBack, []);
            return;
        }// end function

        private function buyCoinTreeCountCallBack() : void
        {
            var _loc_1:* = this._ctrl.farm.buyCoinTreeCount;
            if (_loc_1["result"] == Mod_Farm_Base.SUCCESS)
            {
                this._view.gameHelper.loader_first_info();
                if (FunctionType.isOpened(FunctionType.CoinTree))
                {
                    this.buy_coin_tree_count_info();
                }
            }
            else
            {
                _view.showTip(this.message(_loc_1["result"]));
                this._blnInBuyCoinTreeCount = false;
            }
            return;
        }// end function

        private function coin_tree_count_notify() : void
        {
            this._data.patch(Mod_Farm_Base.coin_tree_count_notify, this.coinTreeCountNotifyCallBack);
            return;
        }// end function

        private function coinTreeCountNotifyCallBack() : void
        {
            var _loc_1:* = this._ctrl.farm.coinTreeCountNotify["coin_tree_counts"];
            this._farm.updateCoinTreeCount(_loc_1);
            if (_loc_1 >= 8)
            {
                this._intCoinTreeCd = 0;
            }
            else
            {
                this.buy_coin_tree_count_info();
            }
            return;
        }// end function

        private function ingot_for_farmland(param1:int, param2:int) : void
        {
            var delay:Function;
            var callBack:Function;
            var intFieldLevel:* = param1;
            var intFieldSort:* = param2;
            delay = function () : void
            {
                ingot_for_farmland(intFieldLevel, intFieldSort);
                return;
            }// end function
            ;
            callBack = function () : void
            {
                ingotForFarmlandCallBack(intFieldLevel, intFieldSort);
                return;
            }// end function
            ;
            if (this._blnInIngotForFarmland)
            {
                setTimeout(delay, 100);
                return;
            }
            this._blnInIngotForFarmland = true;
            this._data.call(Mod_Farm_Base.ingot_for_farmland, callBack, [intFieldLevel]);
            return;
        }// end function

        private function ingotForFarmlandCallBack(param1:int, param2:int) : void
        {
            var _loc_3:* = this._ctrl.farm.ingotForFarmland;
            if (param1 == 1)
            {
                this._intNextRemainingIngot = _loc_3["ingot"];
            }
            else
            {
                this._intNextFieldLevelUpIngot = _loc_3["ingot"];
            }
            _loc_3["field_level"] = param1;
            _loc_3["field_sort"] = param2;
            this._farm.renderIngotForFarmland(_loc_3);
            this._blnInIngotForFarmland = false;
            return;
        }// end function

        private function up_farmland_level(param1:int) : void
        {
            var callBack:Function;
            var intFieldId:* = param1;
            callBack = function () : void
            {
                upFarmlandLevelCallBack(intFieldId);
                return;
            }// end function
            ;
            this._data.call(Mod_Farm_Base.up_farmland_level, callBack, [intFieldId]);
            return;
        }// end function

        private function upFarmlandLevelCallBack(param1:int) : void
        {
            var _loc_2:* = this._ctrl.farm.upFarmlandLevel;
            if (_loc_2["result"] == Mod_Farm_Base.SUCCESS)
            {
                this._farm.renderFieldLevelUp(param1);
                this.get_farmlandinfo_list(true);
            }
            else
            {
                this._blnInUpFarmlandLevel = false;
                _view.showTip(this.message(_loc_2["result"]));
            }
            return;
        }// end function

        private function batPlant(param1:Array, param2:int, param3:int) : void
        {
            var intIndex:int;
            var getHerbsInfoCallBack:Function;
            var plant:Function;
            var plantCallBack:Function;
            var aryFieldId:* = param1;
            var intPlayRoleId:* = param2;
            var intType:* = param3;
            var getHerbsInfo:* = function () : void
            {
                _data.call(Mod_Farm_Base.get_herbs_seed, getHerbsInfoCallBack, [intType]);
                return;
            }// end function
            ;
            getHerbsInfoCallBack = function () : void
            {
                var _loc_1:* = _ctrl.farm.getSingleHerbsSeed;
                if (_loc_1["herbs_star_level"] < 5)
                {
                    _data.call(Mod_Farm_Base.get_top_herbs_seed, plant, [intType]);
                }
                else
                {
                    plant();
                }
                return;
            }// end function
            ;
            plant = function () : void
            {
                _data.call(Mod_Farm_Base.plant_herbs, plantCallBack, [aryFieldId[intIndex], intPlayRoleId, intType]);
                return;
            }// end function
            ;
            plantCallBack = function () : void
            {
                var _loc_1:* = _ctrl.farm.plantHerbs;
                if (_loc_1["result"] == Mod_Farm_Base.SUCCESS)
                {
                    renderPlantCrop(_loc_1);
                    if (intIndex < (aryFieldId.length - 1))
                    {
                        var _loc_3:* = intIndex + 1;
                        intIndex = _loc_3;
                        getHerbsInfo();
                    }
                    else
                    {
                        get_simple_farmlandinfo();
                        if (FunctionType.isOpened(FunctionType.CoinTree))
                        {
                            buy_coin_tree_count_info();
                        }
                        _blnInPlantHerbs = false;
                    }
                }
                else
                {
                    _view.showTip(message(_loc_1["result"]));
                    _blnInPlantHerbs = false;
                }
                return;
            }// end function
            ;
            var renderPlantCrop:* = function (param1:Object) : void
            {
                var delay:Function;
                var obj:* = param1;
                delay = function () : void
                {
                    renderPlantCrop(obj);
                    return;
                }// end function
                ;
                if (_farm.isInPlanting)
                {
                    setTimeout(delay, 50);
                }
                else if (inStage)
                {
                    _farm.renderPlantCrop([obj]);
                }
                return;
            }// end function
            ;
            intIndex;
            this.getHerbsInfo();
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Farm_Base.PLANT:
                {
                    _loc_2 = FarmViewLang.Plant;
                    break;
                }
                case Mod_Farm_Base.NO_PLANT:
                {
                    _loc_2 = FarmViewLang.NoPlant;
                    break;
                }
                case Mod_Farm_Base.SUCCESS:
                {
                    _loc_2 = FarmViewLang.Success;
                    break;
                }
                case Mod_Farm_Base.NOT_ENOUGH_INGOT:
                case Mod_Farm_Base.NO_INGOT:
                {
                    _loc_2 = FarmViewLang.NotEnoughIngot;
                    break;
                }
                case Mod_Farm_Base.REACH_MAX_LAND_COUNT:
                {
                    _loc_2 = FarmViewLang.ReachMaxLandCount;
                    break;
                }
                case Mod_Farm_Base.NOT_PLAYER_ROLE:
                {
                    _loc_2 = FarmViewLang.NotPlayerRole;
                    break;
                }
                case Mod_Farm_Base.IS_MAIN_ROLE:
                {
                    _loc_2 = FarmViewLang.IsMainRole;
                    break;
                }
                case Mod_Farm_Base.ROLE_LEVEL:
                {
                    _loc_2 = FarmViewLang.RoleLevel;
                    break;
                }
                case Mod_Farm_Base.NO_ENOUGHT_COIN_TREE_COUNT:
                {
                    _loc_2 = FarmViewLang.NoEnoughtCoinTreeCount;
                    break;
                }
                case Mod_Farm_Base.NO_VIP:
                {
                    _loc_2 = FarmViewLang.NoVip;
                    break;
                }
                case Mod_Farm_Base.IS_PLANT:
                {
                    _loc_2 = FarmViewLang.IsPlant;
                    break;
                }
                case Mod_Farm_Base.CAN_NOT_UP:
                {
                    _loc_2 = FarmViewLang.CanNotUp;
                    break;
                }
                default:
                {
                    _loc_2 = FarmViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
