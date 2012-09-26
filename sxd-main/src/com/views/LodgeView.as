package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class LodgeView extends Base implements IView
    {
        private var _isUser:Boolean = false;
        private var _tempFateIdData:Object;
        private var isErr:Boolean = false;
        private var _summerNpcId:int = 0;
        private var _isFrist:Boolean = true;
        private var _isTopNpc:Boolean = false;
        private var _lodge:ILodge;
        private var _newNpcId:int = 0;
        private var _grid:int = 0;
        private var _gridLen:int = 0;
        private var _sellType:String = "";
        private var _sellData:Object;
        private var _buyNpcData:Object;
        private var _isFastFate:Boolean = false;
        private var _isFunsionPickUp:Boolean = false;
        private var _isShowChat:Boolean = false;
        private var _oldFateInfo:Number = -1;

        public function LodgeView()
        {
            this._tempFateIdData = {};
            this._sellData = {};
            this._buyNpcData = {};
            return;
        }// end function

        private function get_fate_npc() : void
        {
            _data.call(Mod_Fate_Base.get_fate_npc, this.getFateNpcCallBack, []);
            return;
        }// end function

        private function get_temp_fate() : void
        {
            _data.call(Mod_Fate_Base.get_temp_fate, this.getTempFateCallBack, []);
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
            this.renderScrapAmount = _loc_1;
            return;
        }// end function

        private function pickup_fate(param1:Array) : void
        {
            var _loc_2:* = this.checkId(param1);
            if (_loc_2.length <= 0)
            {
                this.get_temp_fate();
                return;
            }
            this._isUser = true;
            _data.call(Mod_Fate_Base.pickup_fate, this.pickupFateCallBack, [param1]);
            return;
        }// end function

        private function sale_temp_fate(param1:Array) : void
        {
            var _loc_2:* = this.checkId(param1, true);
            if (_loc_2.length <= 0)
            {
                return;
            }
            this._isUser = true;
            _data.call(Mod_Fate_Base.sale_temp_fate, new Function(), [_loc_2]);
            this.saleTempFateCallBack();
            return;
        }// end function

        private function checkId(param1:Array, param2:Boolean = false) : Array
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_3:* = param1.length;
            var _loc_4:Array = [];
            this.isErr = false;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = param1[_loc_5][0];
                if (this._tempFateIdData[_loc_6] == null)
                {
                    _loc_4.push([_loc_6]);
                }
                else
                {
                    this.isErr = true;
                }
                _loc_5++;
            }
            if (this.isErr)
            {
                this.get_temp_fate();
                return [];
            }
            if (param2)
            {
                _loc_7 = _loc_4.Length;
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    _loc_8 = _loc_4[_loc_5];
                    this._tempFateIdData[_loc_6] = _loc_8;
                    _loc_5++;
                }
            }
            return _loc_4;
        }// end function

        private function saveCheckId(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1[_loc_3][0];
                if (this._tempFateIdData[_loc_4] == null)
                {
                    this._tempFateIdData[_loc_4] = _loc_4;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function appoint_fate_npc(param1:int) : void
        {
            this._newNpcId = param1;
            _data.call(Mod_Fate_Base.appoint_fate_npc, this.appointFateNpcCallBack, [param1]);
            return;
        }// end function

        private function buy_fate_npc(param1:int) : void
        {
            this._summerNpcId = param1;
            _ctrl.fate.summerNpcId = param1;
            _data.call(Mod_Fate_Base.buy_fate_npc, this.buyFateNpcCallBack, [param1]);
            return;
        }// end function

        private function getFateNpcCallBack() : void
        {
            if (this.inStage == false)
            {
                this.renderShow();
                return;
            }
            var _loc_1:* = this._ctrl.fate.fateNpc;
            this._lodge.fateNpcList = _loc_1.fateNpcList;
            this._lodge.freeAppointTimes = _loc_1.freeAppointTimes;
            return;
        }// end function

        private function getTempFateCallBack() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this.get_scrap_amount();
            var _loc_1:* = this._ctrl.fate.tempFate;
            this._lodge.lootFateList = _loc_1;
            _view.guide.trackFateLodge(2, this._lodge.lodgePlayer);
            this.resultTime();
            this.isErr = false;
            return;
        }// end function

        private function resultTime() : void
        {
            this._isUser = false;
            return;
        }// end function

        private function renderShow() : void
        {
            loadAssets("Lodge", this.render, LodgeViewLang.LoadAssets);
            return;
        }// end function

        private function appointFateNpcCallBack() : void
        {
            if (this.inStage == false || this._lodge == null)
            {
                return;
            }
            var _loc_1:* = this._ctrl.fate.appointFateNpc;
            if (_loc_1.msg == Mod_Fate_Base.SUCCESS)
            {
                if (this._isFastFate)
                {
                    if (_loc_1.fateNpcId != 5)
                    {
                        this.appoint_fate_npc(_loc_1.fateNpcId);
                    }
                    else
                    {
                        this._isFastFate = false;
                    }
                }
                else
                {
                    this.resultTime();
                }
                if (_loc_1.fateNpcId == 5)
                {
                    _view.showTip(LodgeViewLang.FoundJZY, LodgeViewLang.SystemGo, TipType.Success);
                }
                this.get_temp_fate();
                this._lodge.freeAppointTimes = 0;
                _ctrl.fate.summerNpcId = 0;
                if (_loc_1.type == "success")
                {
                    this._lodge.addDesignated = _loc_1;
                    if (_loc_1.fateNpcId == 1 && this._newNpcId > 1)
                    {
                        _loc_1.fateNpcId = this._newNpcId;
                    }
                    this._lodge.setTextAnimation(_loc_1.fateNpcId, _loc_1.mainInfo);
                }
                else
                {
                    _view.showTip(LodgeViewLang.Fail, _loc_1.info, TipType.Failure);
                }
                this.get_fate_npc();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            this._newNpcId = 0;
            return;
        }// end function

        private function pickupFateCallBack() : void
        {
            var _loc_2:Array = null;
            var _loc_1:* = this._ctrl.fate.pickupFate;
            if (this._isFunsionPickUp)
            {
                _view.fate.merge_all_normal_in_bag();
            }
            if (_loc_1.msg == Mod_Fate_Base.SUCCESS || _loc_1.msg == Mod_Fate_Base.BAG_FULL)
            {
                _loc_2 = [];
                this.sortList(_loc_1.gridList);
                this.saveCheckId(_loc_1.gridList);
                this._lodge.pickUpAllFate = _loc_1.gridList;
                if (_view.fate.inStage)
                {
                    _view.fate.refreshFate();
                }
                if (_loc_1.msg == Mod_Fate_Base.BAG_FULL)
                {
                    _view.showTip(LodgeViewLang.BagFull);
                }
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            this.get_temp_fate();
            this._grid = 0;
            return;
        }// end function

        private function sortList(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Array = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 1;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = 0;
                while (_loc_4 < (_loc_2 - 1))
                {
                    
                    if (param1[_loc_4][0] < param1[(_loc_4 + 1)][0])
                    {
                        _loc_5 = param1[_loc_4];
                        param1[_loc_4] = param1[(_loc_4 + 1)];
                        param1[(_loc_4 + 1)] = _loc_5;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function saleTempFateCallBack() : void
        {
            if (this._sellType == "all")
            {
                this._lodge.sellAllFate();
            }
            else
            {
                this._lodge.lootFateTempFateId(this._grid, "sell");
                this._lodge.clearDesignated = this._grid;
            }
            this.get_temp_fate();
            return;
        }// end function

        private function buyFateNpcCallBack() : void
        {
            var _loc_1:* = _ctrl.fate.buyFateNpc;
            if (_loc_1.msg == Mod_Fate_Base.SUCCESS)
            {
                this.appoint_fate_npc(this._summerNpcId);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_Fate_Base.INVALID_FATE_NPC_ID:
                {
                    break;
                }
                case Mod_Fate_Base.FULL_TEMP_BAG:
                {
                    _view.showTip(LodgeViewLang.FullTempBag);
                    this.get_temp_fate();
                    this.funsionPickUp();
                    break;
                }
                case Mod_Fate_Base.NOT_ENOUGH_COIN:
                {
                    _view.showTip(LodgeViewLang.NotEnoughCoin);
                    break;
                }
                case Mod_Fate_Base.BAG_FULL:
                {
                    _view.showTip(LodgeViewLang.BagFull);
                    this.get_temp_fate();
                    this.funsionPickUp();
                    break;
                }
                case Mod_Fate_Base.FATE_CAN_PICK_UP:
                {
                    _view.showTip(LodgeViewLang.FateCanPickUp);
                    break;
                }
                case Mod_Fate_Base.INVALID_GRID:
                {
                    _view.showTip(LodgeViewLang.InvalidGrid);
                    break;
                }
                case Mod_Fate_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(LodgeViewLang.NotEnoughIngot);
                    break;
                }
                case Mod_Fate_Base.FULL_BUY_TIMES:
                {
                    _view.showTip(LodgeViewLang.FullBuyTimes);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._isFastFate = false;
            this.resultTime();
            return;
        }// end function

        public function show() : void
        {
            if (FunctionType.isOpened(FunctionType.Fate) == false)
            {
                return;
            }
            if (_view.multiMission.isMinimumWithTip)
            {
                return;
            }
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            this.get_fate_npc();
            return;
        }// end function

        public function render() : void
        {
            this._lodge = _view.getAssetsObject("Lodge", "Lodge") as ILodge;
            _popup.addView(this, this._lodge.content);
            this._lodge.loadImage = _view.toolbar.getLoadEffectCircle;
            this._lodge.tip = _view.tip.iTip;
            this.renderLodge();
            _view.chat.changePoint = 2;
            _view.chat.updateDepth(this);
            return;
        }// end function

        private function renderLodge() : void
        {
            this._newNpcId = 0;
            this._grid = 0;
            this._isFrist = true;
            this._lodge.isUpLevel = _ctrl.player.level >= 60 || VIPType.check(VIPType.Level5);
            this.get_temp_fate();
            this.getFateNpcCallBack();
            this._lodge.renderIngot = this._ctrl.player.ingot;
            this._lodge.renderCoins = this._ctrl.player.coins;
            this._lodge.isVip4 = VIPType.check(VIPType.Level5) || this._ctrl.player.level >= 90;
            this._lodge.isVip5 = VIPType.check(VIPType.Level5) || this._ctrl.player.level >= 90;
            this._lodge.checkFunsionPickUp(this._isFunsionPickUp);
            this._lodge.onOpenFate = function () : void
            {
                _view.fate.switchSelf();
                _view.guide.stopFateLodgeGuide(_lodge.lodgePlayer);
                return;
            }// end function
            ;
            this._lodge.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._lodge.onStartFate = function (param1:int) : void
            {
                if (_newNpcId == 0)
                {
                    _isFastFate = false;
                    appoint_fate_npc(param1);
                }
                _view.guide.trackFateLodge(3, _lodge.fateMc);
                return;
            }// end function
            ;
            this._lodge.onFastFate = function (param1:int) : void
            {
                if (_isUser || _isFastFate)
                {
                    _view.showTip(LodgeViewLang.InUse);
                }
                else
                {
                    _isUser = true;
                    _isFastFate = true;
                    appoint_fate_npc(param1);
                }
                return;
            }// end function
            ;
            this._lodge.onAllSellFate = function (param1:Array) : void
            {
                if (_isUser || _isFastFate)
                {
                    _view.showTip(LodgeViewLang.InUse);
                }
                else
                {
                    _sellType = "all";
                    sale_temp_fate(param1);
                }
                return;
            }// end function
            ;
            this._lodge.onSellFate = function (param1:Object) : void
            {
                var _loc_2:String = null;
                if (_isUser || _isFastFate)
                {
                    _view.showTip(LodgeViewLang.InUse);
                }
                else
                {
                    _sellData = param1;
                    if (param1.quality > 4)
                    {
                        _loc_2 = "<font color=\"#ffffff\">" + LodgeViewLang.SellFate + "</font>" + "<font color=\"#" + param1.color.toString(16) + "\">" + param1.fateName + "</font>";
                        _view.alert.showYesNoMsg(_loc_2, LodgeViewLang.Sure, LodgeViewLang.Cancel, onOneSell);
                        return;
                    }
                    sellFate();
                }
                return;
            }// end function
            ;
            this._lodge.onPickUpFate = function (param1:Array) : void
            {
                if (_isUser || _isFastFate)
                {
                    _view.showTip(LodgeViewLang.InUse);
                }
                else
                {
                    pickup_fate(param1);
                    _view.guide.stopFateLodgeGuide(_lodge.lodgePlayer);
                }
                return;
            }// end function
            ;
            this._lodge.onBuyNpc = function (param1:Object) : void
            {
                var callback:Function;
                var data:* = param1;
                if (data.canBuyTimer <= 0)
                {
                    _view.showTip(LodgeViewLang.SummerEnd);
                    return;
                }
                _buyNpcData = data;
                if (_view.ingotEnough(data.buyPrice) == false)
                {
                    return;
                }
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.BuyFateNpc))
                {
                    dialog.yesLabel = LodgeViewLang.Sure;
                    dialog.cancelLabel = LodgeViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        buy_fate_npc(_buyNpcData.fateNpcId);
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.BuyFateNpc, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(Lang.sprintf(LodgeViewLang.SummerNpc, HtmlText.yellow(data.buyPrice + LodgeViewLang.Ingot), data.npcName), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    buy_fate_npc(_buyNpcData.fateNpcId);
                }
                return;
            }// end function
            ;
            this._lodge.onFunsionPickUp = function (param1:Array, param2:Boolean) : void
            {
                _isFunsionPickUp = param2;
                return;
            }// end function
            ;
            this._lodge.onFateInfo = function () : void
            {
                _view.fateInfo.switchSelf();
                return;
            }// end function
            ;
            this._lodge.onIsShowChat = function (param1:Boolean) : void
            {
                _isShowChat = param1;
                return;
            }// end function
            ;
            this._lodge.onOpenRune = function () : void
            {
                _view.rune.switchSelf();
                return;
            }// end function
            ;
            _view.closeEvent();
            this.get_scrap_amount();
            this.reposition();
            this.showChat();
            this._lodge.IsShowChat(this._isShowChat);
            this._lodge.showRune(_view.rune.Count > 0);
            return;
        }// end function

        public function showRune(param1:int) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._lodge.showRune(param1 > 0);
            return;
        }// end function

        private function showChat() : void
        {
            _view.chat.changePoint = 2;
            _view.chat.parentAsMc = this._lodge.MCChatBox;
            return;
        }// end function

        private function funsionPickUp() : void
        {
            var _loc_1:Array = null;
            var _loc_2:Array = null;
            if (this._isFunsionPickUp)
            {
                _loc_1 = this._lodge.checkPickUpFate;
                _loc_2 = this._lodge.checkSellAllFate;
                this.pickup_fate(_loc_1);
            }
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        private function sellFate() : void
        {
            var _loc_1:* = this._sellData.tempFateId;
            this._sellType = "one";
            this._grid = _loc_1;
            this.sale_temp_fate([[_loc_1]]);
            _view.guide.stopFateLodgeGuide(this._lodge.lodgePlayer);
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                this._lodge.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight);
            }
            return;
        }// end function

        public function onOneSell(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.sellFate();
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

        public function onBuyNpc(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.buy_fate_npc(this._buyNpcData.fateNpcId);
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

        public function set renderIngot(param1:Number) : void
        {
            if (this.inStage)
            {
                this._lodge.renderIngot = param1;
            }
            return;
        }// end function

        public function set renderCoins(param1:Number) : void
        {
            if (this.inStage)
            {
                this._lodge.renderCoins = param1;
            }
            return;
        }// end function

        public function set renderScrapAmount(param1:Number) : void
        {
            if (this._oldFateInfo == param1)
            {
                return;
            }
            if (this.inStage)
            {
                this._lodge.renderFateInfo = param1;
                this._oldFateInfo = param1;
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            _view.openEvent();
            this._oldFateInfo = -1;
            this._tempFateIdData = {};
            this._isFastFate = false;
            this._isUser = false;
            this._lodge.close();
            _popup.closeView(this);
            this._lodge = null;
            _view.chat.resetDepth();
            _view.chat.changePoint = 0;
            if (_view.superSport.inStage)
            {
                _view.chat.updateDepth(_view.superSport);
            }
            _view.guide.stopFateWearGuide();
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._lodge && this._lodge.content.parent;
        }// end function

        public function get content() : Sprite
        {
            if (this._lodge == null)
            {
                return null;
            }
            return this._lodge.content;
        }// end function

        public function get lodgePlayer() : Sprite
        {
            if (this._lodge == null)
            {
                return null;
            }
            return this._lodge.lodgePlayer;
        }// end function

    }
}
