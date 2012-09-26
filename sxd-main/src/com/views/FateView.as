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

    public class FateView extends Base implements IView
    {
        private var _showRoleId:int = 0;
        private var _bagList:Array;
        private var _bagEmptyData:Object;
        private var _roleFateList:Array;
        private var _roleEmptyData:Object;
        private var _fate:IFate;
        private var _fateData:Object;
        private var _isUser:Boolean = false;
        private var _changeData:Object;
        private var _mainFateData:Object;
        private var _minFateData:Object;
        private var _fateInfo:String;
        private var addValue:String = "";

        public function FateView()
        {
            this._bagEmptyData = {buyGrid:0, fateExp:0, fateId:0, grid:0, isEmpty:true, lockOn:true, PlayerColor:16777215, playerFateId:0, playerLevel:0, PlayerName:"", playerRoleId:0, roleId:0, upDataExp:0};
            this._roleEmptyData = {fateExp:0, fateId:0, fateLevel:0, grid:0, isEmpty:true, lockOn:true, playerFateId:0, position:1, upDataExp:0};
            return;
        }// end function

        public function get_bag_list() : void
        {
            _data.call(Mod_Fate_Base.get_bag_list, this.getBagListCallBack, []);
            return;
        }// end function

        public function get_role_fate_list() : void
        {
            _data.call(Mod_Fate_Base.get_role_fate_list, this.roleFateListCallBack, [this._showRoleId]);
            return;
        }// end function

        private function wear_on(param1:int, param2:int, param3:int) : void
        {
            _data.call(Mod_Fate_Base.wear_on, this.wearOnCallBack, [param1, param2, param3]);
            return;
        }// end function

        private function wear_off_fate(param1:int, param2:int) : void
        {
            _data.call(Mod_Fate_Base.wear_off_fate, this.wearOffFateCallBack, [param1, param2]);
            return;
        }// end function

        private function change_position(param1:int, param2:int) : void
        {
            _data.call(Mod_Fate_Base.change_position, this.changePositionCallBack, [param1, param2]);
            return;
        }// end function

        private function change_fate_grid(param1:int, param2:int) : void
        {
            _data.call(Mod_Fate_Base.change_fate_grid, this.changeFateCallBack, [param1, param2]);
            return;
        }// end function

        private function discard_fate(param1:int) : void
        {
            _data.call(Mod_Fate_Base.discard_fate, new Function(), [param1]);
            this.get_bag_list();
            this.get_role_fate_list();
            return;
        }// end function

        private function buy_bag_grid() : void
        {
            _data.call(Mod_Fate_Base.buy_bag_grid, this.buyBagGridCallBack, [this._fateData.grid]);
            return;
        }// end function

        private function get_role_list() : void
        {
            _data.call(Mod_Role_Base.get_simple_role_list, this.getRoleListCallBack, [this._ctrl.player.playerId], false);
            return;
        }// end function

        private function merge(param1:int, param2:int, param3:int) : void
        {
            _data.call(Mod_Fate_Base.merge, this.mergeCallBack, [param1, param2, param3]);
            return;
        }// end function

        public function get_player_role_fate_power() : void
        {
            _data.call(Mod_Fate_Base.get_player_role_fate_power, this.fatePowerCallBack, [this._showRoleId]);
            return;
        }// end function

        public function get_merge_data(param1:int, param2:int, param3:int, param4:int) : void
        {
            _data.call(Mod_Fate_Base.get_merge_data, this.mergeDataCallBack, [param1, param2, param3, param4]);
            return;
        }// end function

        public function merge_all_in_bag() : void
        {
            _data.call(Mod_Fate_Base.merge_all_in_bag, new Function(), []);
            this.get_bag_list();
            return;
        }// end function

        public function merge_all_normal_in_bag() : void
        {
            _data.call(Mod_Fate_Base.merge_all_normal_in_bag, new Function(), []);
            this.get_bag_list();
            return;
        }// end function

        public function exchange_fate(param1:int) : void
        {
            _data.call(Mod_Fate_Base.exchange_fate, this.exchangeFateCallBack, [param1]);
            return;
        }// end function

        private function getRoleListCallBack() : void
        {
            var _loc_1:* = _ctrl.upgrade.getSimpleRoleList();
            if (inStage)
            {
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
                    this._fate.getPlayerList(param1, this._showRoleId);
                    return;
                }
                _loc_5++;
            }
            this._showRoleId = _loc_4;
            this._fate.getPlayerList(param1, this._showRoleId);
            return;
        }// end function

        public function set showRoleId(param1:int) : void
        {
            this._showRoleId = param1;
            return;
        }// end function

        private function getBagListCallBack() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            var _loc_1:* = this._ctrl.fate.bagList;
            this._fate.getFateGridList = _loc_1;
            this._fate.FragmentNum(_ctrl.fate.FateScrapNumber);
            this._bagList = _loc_1;
            return;
        }// end function

        private function roleFateListCallBack() : void
        {
            var _loc_1:* = this._ctrl.fate.roleFateData;
            if (inStage == false)
            {
                return;
            }
            this._fate.fatePower = _loc_1.fatePower;
            this._fate.getPlayerFate = _loc_1.fateList;
            this._roleFateList = _loc_1.fateList;
            _view.roleMsg.updateFate();
            _view.guide.trackFateWear(2, this._fate.content);
            return;
        }// end function

        private function wearOnCallBack() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            var _loc_1:* = this._ctrl.fate.wearOn;
            if (_loc_1.msg == Mod_Fate_Base.SUCCESS)
            {
                this.get_bag_list();
                this.get_role_fate_list();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            _view.guide.trackFateWear(3, this._fate.content);
            return;
        }// end function

        private function wearOffFateCallBack() : void
        {
            var _loc_1:* = this._ctrl.fate.wearOffFate;
            if (_loc_1.msg == Mod_Fate_Base.SUCCESS)
            {
                this.get_role_fate_list();
                this.get_bag_list();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function buyBagGridCallBack() : void
        {
            var _loc_1:* = this._ctrl.fate.buyBagGrid;
            if (_loc_1.msg == Mod_Fate_Base.SUCCESS)
            {
                this.get_bag_list();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function changePositionCallBack() : void
        {
            var _loc_1:* = this._ctrl.fate.changePosition;
            if (_loc_1.msg == Mod_Fate_Base.SUCCESS)
            {
                this.get_role_fate_list();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function changeFateCallBack() : void
        {
            var _loc_1:* = this._ctrl.fate.changeFateGrid;
            if (_loc_1.msg == Mod_Fate_Base.SUCCESS)
            {
                this.get_bag_list();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function fatePowerCallBack() : void
        {
            var _loc_1:* = this._ctrl.fate.getFatePower;
            this._fate.fatePower = _loc_1.fatePower;
            return;
        }// end function

        private function mergeCallBack() : void
        {
            var _loc_1:* = this._ctrl.fate.merge;
            if (_loc_1.msg == Mod_Fate_Base.SUCCESS)
            {
                this.get_bag_list();
                this.get_role_fate_list();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function mergeDataCallBack() : void
        {
            var _loc_1:* = this._ctrl.fate.mergeData;
            if (this._mainFateData.fateLevel < _loc_1.newLevel)
            {
                this._fateInfo = this._fateInfo + ("<font color=\"#ffffff\">" + Lang.sprintf(FateViewLang.UpLevelNum, _loc_1.newLevel) + "</font>");
            }
            _view.alert.showYesNoMsg(this._fateInfo, FateViewLang.Sure, FateViewLang.Cancel, this.onFusionHandler);
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
                this.get_bag_list();
                this.get_role_fate_list();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            this._isUser = false;
            return;
        }// end function

        public function renderMsg(param1:Object) : void
        {
            switch(param1.msg)
            {
                case Mod_Fate_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(FateViewLang.NotEnoughIngot);
                    break;
                }
                case Mod_Fate_Base.BAG_FULL:
                {
                    _view.showTip(FateViewLang.BagFull);
                    break;
                }
                case Mod_Fate_Base.MAX_BAG_NUMBER:
                {
                    _view.showTip(FateViewLang.MaxBagNumber);
                    return;
                }
                case Mod_Fate_Base.MAX_LEVEL:
                {
                    _view.showTip(FateViewLang.MaxLevel);
                    break;
                }
                case Mod_Fate_Base.INVALID_POSITION:
                {
                    break;
                }
                case Mod_Fate_Base.INVALID_GRID:
                {
                    break;
                }
                case Mod_Fate_Base.HAVE_SAME_TYPE_FATE:
                {
                    _view.showTip(FateViewLang.HaveSameTypeFate, FateViewLang.SameFateInfo + " <font color=\"#" + param1.color.toString(16) + "\">" + param1.fateName + "</font>", TipType.Question);
                    break;
                }
                case Mod_Fate_Base.HAVE_WEAR_ON:
                {
                    _view.showTip(FateViewLang.HaveWearOn);
                    break;
                }
                case Mod_Fate_Base.FATE_CAN_EXCHANGE:
                {
                    _view.showTip(FateViewLang.FateCanExchange);
                    break;
                }
                case Mod_Fate_Base.NOT_ENOUGH_LEVEL:
                {
                    _view.showTip(FateViewLang.NotEnoughLevel);
                    break;
                }
                case Mod_Fate_Base.NOT_ENOUGH_COUNT:
                {
                    _view.showTip(FateViewLang.NotEnoughCount);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.get_bag_list();
            this.get_role_fate_list();
            return;
        }// end function

        private function renderShow() : void
        {
            loadAssets("Fate", this.render, FateViewLang.LoadAssets);
            return;
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
            if (FunctionType.isOpened(FunctionType.Fate) == false)
            {
                _view.showTip(FateViewLang.UnOpen);
                return;
            }
            this.get_role_list();
            return;
        }// end function

        public function render() : void
        {
            if (this._fate == null)
            {
                this._fate = _view.getAssetsObject("Fate", "Fate") as IFate;
                this._fate.tip = _view.tip.iTip;
                this._fate.drag = _view.drag.iDrag;
            }
            _popup.addView(this, this._fate.content);
            _view.center(sign, this._fate.content);
            this.renderLodge();
            return;
        }// end function

        private function renderLodge() : void
        {
            this._fate.loadImage = _view.toolbar.getLoadEffectCircle;
            this.getRoleListCallBack();
            this.get_bag_list();
            this.get_role_fate_list();
            this._fate.onSendType = function (param1:Object, param2:Boolean = false) : void
            {
                if (param1.hitMc == null)
                {
                    return;
                }
                if (param1.hitMc.isEmpty == false && param2)
                {
                    _view.showTip(FateViewLang.NoEmptyBack);
                    return;
                }
                _fateData = param1;
                fusion(param1);
                return;
            }// end function
            ;
            this._fate.onBuyFateGrid = function (param1:Object) : void
            {
                if (_view.vipEnabled == false)
                {
                    return;
                }
                if (_ctrl.player.ingot < param1.price)
                {
                    _view.showTip(FateViewLang.NotEnoughIngot);
                    _fate.hideShive();
                    return;
                }
                _fateData = param1;
                _view.alert.showYesNoMsg(FateViewLang.BuyBackNeed + HtmlText.yellow(param1.price + FateViewLang.Ingot), FateViewLang.Sure, FateViewLang.Cancel, onBuyFateGridHandler);
                return;
            }// end function
            ;
            this._fate.onClose = function () : void
            {
                close();
                _view.guide.trackFateWear(4, _view.lodge.lodgePlayer);
                return;
            }// end function
            ;
            this._fate.onCheckPlayer = function (param1:Object) : void
            {
                _showRoleId = param1.id;
                get_role_fate_list();
                return;
            }// end function
            ;
            this._fate.onMergeAll = function (param1:Boolean) : void
            {
                if (param1)
                {
                    _view.alert.showYesNoMsg(FateViewLang.IsTianFate, FateViewLang.Sure, FateViewLang.Cancel, onIsTianFate);
                }
                else
                {
                    autoMergeAl();
                }
                return;
            }// end function
            ;
            this._fate.onOpenLodge = function () : void
            {
                if (_view.lodge.inStage)
                {
                    close();
                }
                else
                {
                    _view.lodge.switchSelf();
                }
                return;
            }// end function
            ;
            this._fate.onFateInfo = function () : void
            {
                _view.fateInfo.switchSelf();
                return;
            }// end function
            ;
            this.reposition();
            this._fate.isShowExchange = _ctrl.player.level > 60 || VIPType.check(VIPType.Level5);
            return;
        }// end function

        public function autoMergeAl() : void
        {
            _view.alert.showYesNoMsg(FateViewLang.AutoMergeAl, FateViewLang.Sure, FateViewLang.Cancel, this.onMergeAllHandler);
            return;
        }// end function

        public function onIsTianFate(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.merge_all_in_bag();
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

        public function onBuyFateGridHandler(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this._fate.hideShive();
                    this.buy_bag_grid();
                    break;
                }
                case AlertButtonType.No:
                {
                    this._fate.hideShive();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function onMergeAllHandler(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.merge_all_in_bag();
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

        public function onExchangeHandler(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.exchange_fate(this._changeData.fateId);
                    this._isUser = true;
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

        private function fusion(param1:Object) : void
        {
            var _loc_2:Boolean = false;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:int = 0;
            if (param1.mainMc == null)
            {
                return;
            }
            if (param1.type == "delete")
            {
                _view.alert.showYesNoMsg(FateViewLang.Fusion, FateViewLang.Sure, FateViewLang.Cancel, this.onFusionHandler);
                return;
            }
            if (param1.mainMc.playerFateId != 0 && param1.hitMc.playerFateId != 0)
            {
                _loc_2 = this.renderActived(param1);
                if (param1.mainMc.fateLevel >= param1.mainMc.maxLevel || param1.hitMc.fateLevel >= param1.hitMc.maxLevel)
                {
                    if (param1.mainMc.fateLevel >= param1.mainMc.maxLevel && param1.hitMc.quality <= param1.mainMc.quality && _loc_2)
                    {
                        _view.showTip(FateViewLang.MergeMaxLevel);
                        this._fate.upPlayerLive();
                        return;
                    }
                    if (param1.hitMc.fateLevel >= param1.hitMc.maxLevel && param1.mainMc.quality <= param1.hitMc.quality && _loc_2)
                    {
                        _view.showTip(FateViewLang.MergeMaxLevel);
                        this._fate.upPlayerLive();
                        return;
                    }
                }
                if (param1.mainMc.quality == 8 && param1.hitMc.quality == 8)
                {
                    _view.showTip(FateViewLang.NotTianMing);
                    this._fate.upPlayerLive();
                    return;
                }
                _loc_3 = param1.mainMc.baseExp + param1.mainMc.fateExp;
                _loc_4 = param1.hitMc.baseExp + param1.hitMc.fateExp;
                _loc_5 = 0;
                _loc_6 = _loc_2 == false ? (Lang.sprintf(FateViewLang.ActivedInfo, this.addValue)) : ("");
                _loc_7 = "[<font color=\"#" + param1.mainMc.color.toString(16) + "\">" + param1.mainMc.fateName + "</font>]" + " " + FateViewLang.InMerge + " " + "[<font color=\"#" + param1.hitMc.color.toString(16) + "\">" + param1.hitMc.fateName + "</font>]" + _loc_6 + "<font color=\"#ffffff\">\n" + Lang.sprintf(FateViewLang.GetExp, _loc_4) + "</font>";
                _loc_8 = "[<font color=\"#" + param1.hitMc.color.toString(16) + "\">" + param1.hitMc.fateName + "</font>]" + " " + FateViewLang.InMerge + " " + "[<font color=\"#" + param1.mainMc.color.toString(16) + "\">" + param1.mainMc.fateName + "</font>]" + _loc_6 + "<font color=\"#ffffff\">\n" + Lang.sprintf(FateViewLang.GetExp, _loc_3) + "</font>";
                this._fateInfo = _loc_7;
                this._mainFateData = param1.mainMc;
                this._minFateData = param1.hitMc;
                if (param1.mainMc.fateLevel < param1.hitMc.fateLevel)
                {
                    this._mainFateData = param1.hitMc;
                    this._minFateData = param1.mainMc;
                    this._fateInfo = _loc_8;
                }
                if (param1.mainMc.quality < param1.hitMc.quality)
                {
                    this._mainFateData = param1.hitMc;
                    this._minFateData = param1.mainMc;
                    this._fateInfo = _loc_8;
                }
                if (param1.mainMc.quality > param1.hitMc.quality)
                {
                    this._mainFateData = param1.mainMc;
                    this._minFateData = param1.hitMc;
                    this._fateInfo = _loc_7;
                }
                _loc_9 = this._mainFateData.fateExp + this._minFateData.baseExp + this._minFateData.fateExp;
                this.get_merge_data(this._mainFateData.quality, this._mainFateData.fateLevel, this._mainFateData.fateExp, _loc_9);
            }
            else
            {
                this.sendType(param1);
            }
            return;
        }// end function

        private function renderActived(param1:Object) : Boolean
        {
            var _loc_2:Boolean = true;
            this.addValue = "";
            if (param1.mainMc.quality == 8 || param1.hitMc.quality == 8)
            {
                if (param1.mainMc.quality == 8)
                {
                    this.addValue = FateType.getFateDescription(param1.hitMc.fateId);
                    _loc_2 = param1.mainMc.actived[param1.hitMc.fateId] == null;
                }
                else
                {
                    this.addValue = FateType.getFateDescription(param1.mainMc.fateId);
                    _loc_2 = param1.hitMc.actived[param1.mainMc.fateId] == null;
                }
                this.addValue = this.addValue.replace(/增加""增加/g, "");
            }
            return _loc_2;
        }// end function

        public function onFusionHandler(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.sendType(this._fateData);
                    break;
                }
                case AlertButtonType.No:
                {
                    this._fate.upPlayerLive();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function sendType(param1:Object) : void
        {
            if (param1.hitMc.playerFateId == null)
            {
                this.get_bag_list();
                this.get_role_fate_list();
                this._fate.upPlayerLive();
                return;
            }
            switch(param1.type)
            {
                case "PlayerChange":
                {
                    if (param1.hitMc.playerFateId > 0)
                    {
                        this.loaderPlayer(1, param1);
                        this.merge(param1.mainMc.playerFateId, param1.hitMc.playerFateId, Mod_Fate_Base.ON_ROLE);
                    }
                    else
                    {
                        this.loaderPlayer(2, param1);
                        this.change_position(param1.mainMc.playerFateId, param1.hitMc.position);
                    }
                    break;
                }
                case "FateChange":
                {
                    if (param1.hitMc.playerFateId > 0)
                    {
                        this.loaderFate(1, param1);
                        this.merge(param1.mainMc.playerFateId, param1.hitMc.playerFateId, Mod_Fate_Base.IN_BAG);
                    }
                    else
                    {
                        this.loaderFate(2, param1);
                        this.change_fate_grid(param1.mainMc.playerFateId, param1.hitMc.grid);
                    }
                    break;
                }
                case "SwearOn":
                {
                    if (param1.hitMc.playerFateId > 0)
                    {
                        this.loaderSwearOn(1, param1);
                        this.merge(param1.mainMc.playerFateId, param1.hitMc.playerFateId, Mod_Fate_Base.BAG_TO_ROLE);
                    }
                    else
                    {
                        this.loaderSwearOn(2, param1);
                        this.wear_on(this._showRoleId, param1.mainMc.playerFateId, param1.hitMc.position);
                    }
                    break;
                }
                case "WearOffFate":
                {
                    if (param1.hitMc.playerFateId > 0)
                    {
                        this.loaderWearOffFate(1, param1);
                        this.merge(param1.mainMc.playerFateId, param1.hitMc.playerFateId, Mod_Fate_Base.ROLE_TO_BAG);
                    }
                    else
                    {
                        this.loaderWearOffFate(2, param1);
                        this.wear_off_fate(param1.mainMc.playerFateId, param1.hitMc.grid);
                    }
                    break;
                }
                case "delete":
                {
                    this.discard_fate(param1.mainMc.playerFateId);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._fate.upPlayerLive();
            return;
        }// end function

        private function loaderFate(param1:int, param2:Object) : void
        {
            var _loc_3:* = this._bagList.length;
            var _loc_4:* = param2.mainMc.grid;
            var _loc_5:* = param2.hitMc.grid;
            var _loc_6:Object = {};
            if (param1 == 1)
            {
                if (this._minFateData.grid == _loc_5)
                {
                    param2.mainMc.grid = _loc_5;
                    this._bagList[(_loc_5 - 1)] = param2.mainMc;
                }
            }
            else
            {
                param2.mainMc.grid = _loc_5;
                this._bagList[(_loc_5 - 1)] = param2.mainMc;
            }
            this._bagEmptyData.grid = _loc_4;
            this._bagList[(_loc_4 - 1)] = this._bagEmptyData;
            this._fate.getFateGridList = this._bagList;
            return;
        }// end function

        private function loaderPlayer(param1:int, param2:Object) : void
        {
            var _loc_3:* = this._bagList.length;
            var _loc_4:* = param2.mainMc.position;
            var _loc_5:* = param2.hitMc.position;
            var _loc_6:Object = {};
            if (param1 == 1)
            {
                if (this._minFateData.position == _loc_5)
                {
                    param2.mainMc.position = _loc_5;
                    this._roleFateList[(_loc_5 - 1)] = param2.mainMc;
                }
            }
            else
            {
                param2.mainMc.position = _loc_5;
                this._roleFateList[(_loc_5 - 1)] = param2.mainMc;
            }
            this._roleEmptyData.position = _loc_4;
            this._roleFateList[(_loc_4 - 1)] = this._roleEmptyData;
            this._fate.getPlayerFate = this._roleFateList;
            return;
        }// end function

        private function loaderSwearOn(param1:int, param2:Object) : void
        {
            var _loc_3:* = this._bagList.length;
            var _loc_4:* = param2.mainMc.grid;
            var _loc_5:* = param2.hitMc.position;
            var _loc_6:Object = {};
            if (param1 == 1)
            {
                if (this._minFateData.position == _loc_5)
                {
                    param2.mainMc.position = _loc_5;
                    this._roleFateList[(_loc_5 - 1)] = param2.mainMc;
                }
            }
            else
            {
                param2.mainMc.position = _loc_5;
                this._roleFateList[(_loc_5 - 1)] = param2.mainMc;
            }
            this._bagEmptyData.grid = _loc_4;
            this._bagList[(_loc_4 - 1)] = this._bagEmptyData;
            this._fate.getPlayerFate = this._roleFateList;
            this._fate.getFateGridList = this._bagList;
            return;
        }// end function

        private function loaderWearOffFate(param1:int, param2:Object) : void
        {
            var _loc_3:* = this._bagList.length;
            var _loc_4:* = param2.mainMc.position;
            var _loc_5:* = param2.hitMc.grid;
            var _loc_6:Object = {};
            if (param1 == 1)
            {
                if (this._minFateData.grid == _loc_5)
                {
                    param2.mainMc.grid = _loc_5;
                    this._bagList[(_loc_5 - 1)] = param2.mainMc;
                }
            }
            else
            {
                param2.mainMc.grid = _loc_5;
                this._bagList[(_loc_5 - 1)] = param2.mainMc;
            }
            this._roleEmptyData.position = _loc_4;
            this._roleFateList[(_loc_4 - 1)] = this._roleEmptyData;
            this._fate.getPlayerFate = this._roleFateList;
            this._fate.getFateGridList = this._bagList;
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
                this._fate.reposition(_loc_2);
            }
            return;
        }// end function

        public function refreshFate() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this.get_bag_list();
            this.get_role_fate_list();
            return;
        }// end function

        public function clear() : void
        {
            this._fateData = null;
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
