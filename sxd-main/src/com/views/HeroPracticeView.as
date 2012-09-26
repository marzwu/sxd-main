package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.events.*;

    public class HeroPracticeView extends Base implements IView
    {
        public var onSaoDanStart:Function;
        public var showTownId:int = 0;
        public var monsterLen:int = 0;
        private var _heroPracticeList:Array;
        private var _practiceInfo:Object;
        private var _heroPractice:IHeroPractice;
        private var _quicklyTime:int = 0;
        private var _isBatton:Boolean = false;
        private var _inStage:Boolean = false;
        private var _battleTimer:int = 0;
        private var _isQuickly:Boolean = false;
        private var _isAutoPower:int = 0;
        private var _autoNum:int = 0;
        private var _lostPowerNum:int = 0;
        private var _isContinue:Boolean = false;
        private var _practiceTime:int = 0;

        public function HeroPracticeView()
        {
            this.onSaoDanStart = new Function();
            _inStageTipTitle = HeroPracticeViewLang.inStageTipTitle;
            _inStageTipContent = "";
            return;
        }// end function

        public function set getHeroPracticeList(param1:Array) : void
        {
            this._heroPracticeList = param1;
            this.show();
            return;
        }// end function

        public function start_practice() : void
        {
            _data.call(Mod_HeroMission_Base.start_practice, this.startPracticeCallBack, [this.showTownId, this._autoNum]);
            return;
        }// end function

        public function stop_practice() : void
        {
            _data.call(Mod_HeroMission_Base.stop_practice, new Function(), []);
            return;
        }// end function

        public function notify() : void
        {
            _data.patch(Mod_HeroMission_Base.notify, this.notifyCallBack);
            return;
        }// end function

        public function quickly() : void
        {
            _data.call(Mod_HeroMission_Base.quickly, this.quicklyCallBack, []);
            return;
        }// end function

        public function pricticeInfoCallBack() : void
        {
            this._practiceInfo = this._ctrl.missionPractice.practiceInfo;
            this._practiceInfo.monsterLen = this.monsterLen;
            if (this.inStage)
            {
                this._heroPractice.packNum = _view.ctrl.player.packNum;
            }
            else
            {
                this.renderShow();
            }
            return;
        }// end function

        public function startPracticeCallBack() : void
        {
            var _loc_1:* = this._ctrl.heroMission.startPractice;
            if (_loc_1.msg == Mod_HeroMission_Base.SUCCESS)
            {
                this.onSaoDanStart();
                this._heroPractice.getPracticeInfoDownTimer = _loc_1.practiceTime;
                this.quickly();
                this._heroPractice.newBattleStart();
                this._isBatton = true;
                if (_view.heroMission.inStage)
                {
                    _view.heroMission.close();
                }
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            this._heroPractice.packNum = _view.ctrl.player.packNum;
            this._heroPractice.cdTimer = 0;
            return;
        }// end function

        public function quicklyCallBack() : void
        {
            var _loc_1:* = this._ctrl.heroMission.getQuickly;
            if (_loc_1.msg == Mod_HeroMission_Base.SUCCESS)
            {
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        public function notifyCallBack() : void
        {
            var _loc_1:* = this._ctrl.heroMission.notify;
            switch(_loc_1.type)
            {
                case Mod_HeroMission_Base.NEW_WAR_REPORT:
                {
                    if (this._ctrl.player.power <= 150 && this._isAutoPower && _view.toolbar.isBuy == false && _view.toolbar.isCanBuy == true)
                    {
                        _view.toolbar.buy_power();
                    }
                    this._heroPractice.getBattleInfoList = _loc_1.newWarReport;
                    this._heroPractice.getBattleInfoList = _loc_1.rankReport;
                    _view.pack.resetPack();
                    this._heroPractice.packNum = _loc_1.emptyBagNumber;
                    break;
                }
                case Mod_HeroMission_Base.BAG_FULL:
                {
                    this.renderMsg(Mod_HeroMission_Base.BAG_FULL);
                    this.stopPractice();
                    break;
                }
                case Mod_HeroMission_Base.NOT_ENOUGH_POWER:
                {
                    this.renderMsg(Mod_HeroMission_Base.NOT_ENOUGH_POWER);
                    this.stopPractice();
                    break;
                }
                case Mod_HeroMission_Base.FINISH:
                {
                    this.stopPractice();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_HeroMission_Base.NOT_ENOUGH_POWER:
                {
                    _view.showTip(HeroPracticeViewLang.NotEnoughPower);
                    break;
                }
                case Mod_HeroMission_Base.BAG_FULL:
                {
                    _view.alert.confirm(HeroPracticeViewLang.BagFull);
                    break;
                }
                case Mod_HeroMission_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(HeroPracticeViewLang.NotEnoughIngot);
                    return;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function show() : void
        {
            if (_view.tower.inStage)
            {
                _view.showTip(HeroPracticeViewLang.Quit);
                return;
            }
            this.renderShow();
            _inStageTipContent = HeroPracticeViewLang.InStageTipContent;
            return;
        }// end function

        private function renderShow() : void
        {
            loadAssets("HeroPractice", this.render, HeroPracticeViewLang.LoadAssets);
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        public function render() : void
        {
            this._inStage = true;
            this._heroPractice = _view.getAssetsObject("HeroPractice", "HeroPractice") as IHeroPractice;
            _popup.addChild(this._heroPractice.content);
            _view.center(sign, this._heroPractice.content);
            this._heroPractice.tip = _view.tip.iTip;
            this._heroPractice.drag = _view.drag.iDrag;
            this._heroPractice.getPracticeInfoList = this._heroPracticeList;
            this._heroPractice.getPracticeInfoDownTimer = 0;
            if (this._practiceTime > 0)
            {
                this._heroPractice.getPracticeInfoDownTimer = this._practiceTime;
                this._heroPractice.newBattleStart();
            }
            var townName:* = TownType.getName(this.showTownId);
            this._heroPractice.titleName = townName;
            this._heroPractice.packNum = _view.ctrl.player.packNum;
            this.upDataPower = _ctrl.player.power;
            this._heroPractice.isShowCheck = VIPType.check(VIPType.Level7);
            this.notify();
            this._heroPractice.onStartPractice = function (param1:int) : void
            {
                if (_view.ctrl.player.packNum <= 0)
                {
                    _view.showTip(HeroPracticeViewLang.BagFull);
                    return;
                }
                if (_view.ctrl.player.packNum <= 3)
                {
                    _view.alert.showYesNoMsg(HeroPracticeViewLang.BagLost, HeroPracticeViewLang.Sure, HeroPracticeViewLang.Cancel, onClosePractice);
                    return;
                }
                if (_ctrl.player.playerInfo.practice == Mod_Town_Base.ON_PRACTICE)
                {
                    _view.alert.showYesNoMsg(HeroPracticeViewLang.OnPractice, HeroPracticeViewLang.Sure, HeroPracticeViewLang.Cancel, onClosePractice);
                    return;
                }
                start_practice();
                return;
            }// end function
            ;
            this._heroPractice.onQuickly = function (param1:int) : void
            {
                var callback:Function;
                var time:* = param1;
                if (_view.vipEnabled == false)
                {
                    return;
                }
                _quicklyTime = 30;
                var packStr:String;
                if (_view.ctrl.player.packNum <= 3)
                {
                    packStr = HeroPracticeViewLang.BagNum;
                }
                var value:* = Math.ceil(time / 60);
                var str:* = packStr + Lang.sprintf(HeroPracticeViewLang.QuicklyEnd, HtmlText.yellow(value + HeroPracticeViewLang.Ingot));
                if (_view.ingotEnough(value) == false)
                {
                    return;
                }
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.HeroPracticeQuickly))
                {
                    dialog.yesLabel = HeroPracticeViewLang.Sure;
                    dialog.cancelLabel = HeroPracticeViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        quickly();
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.HeroPracticeQuickly, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(str, AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    quickly();
                }
                return;
            }// end function
            ;
            this._heroPractice.onQuitPractice = function () : void
            {
                stop_practice();
                stopPractice();
                return;
            }// end function
            ;
            this._heroPractice.onIsQuickly = function (param1:Boolean) : void
            {
                _isQuickly = param1;
                return;
            }// end function
            ;
            this._heroPractice.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._heroPractice.onStop = function () : void
            {
                _isBatton = false;
                upDataPower = _ctrl.player.power;
                return;
            }// end function
            ;
            this._heroPractice.onTextLink = function (event:TextEvent) : void
            {
                _view.toolbar.onTextLink(event);
                return;
            }// end function
            ;
            this._heroPractice.onPowerTip = function () : void
            {
                _view.showTip(HeroPracticeViewLang.NoPowerUser);
                return;
            }// end function
            ;
            this._heroPractice.onShowTip = function (param1:String) : void
            {
                switch(param1)
                {
                    case "noMission":
                    {
                        _view.showTip(HeroPracticeViewLang.NoMission);
                        ;
                    }
                    case "noPower":
                    {
                        _view.showTip(HeroPracticeViewLang.NoPower);
                        ;
                    }
                    case "InsufficientPower":
                    {
                        _view.alert.showYesNoMsg(HeroPracticeViewLang.InsufficientPower, HeroPracticeViewLang.Sure, HeroPracticeViewLang.Cancel, onClosePractice);
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
            this._heroPractice.onContinuePractice = function () : void
            {
                close();
                _view.heroMission.show();
                return;
            }// end function
            ;
            this._heroPractice.onAutoBuyPower = function (param1:Boolean) : void
            {
                _isAutoPower = param1 == true ? (1) : (0);
                return;
            }// end function
            ;
            this._heroPractice.onAutoBuyAward = function (param1:Boolean) : void
            {
                if (_isBatton == false)
                {
                    _autoNum = param1 == true ? (1) : (0);
                }
                else
                {
                    _view.showTip(MissionPracticeViewLang.InButtle);
                }
                _heroPractice.autoBuyAwardState = _autoNum == 1;
                return;
            }// end function
            ;
            if (this._isContinue)
            {
                this.continue_practice();
            }
            this._heroPractice.getLostPowerNum = this._lostPowerNum;
            this._heroPractice.autoBuyAwardState = this._autoNum == 1;
            this._heroPractice.autoBuyPowerState = this._isAutoPower == 1;
            return;
        }// end function

        public function set getLostPowerNum(param1:int) : void
        {
            this._lostPowerNum = param1;
            if (this.inStage)
            {
                this._heroPractice.getLostPowerNum = param1;
            }
            return;
        }// end function

        private function stopPractice() : void
        {
            this.upDataPower = _ctrl.player.power;
            this._heroPractice.getPracticeInfoDownTimer = 0;
            this._isBatton = false;
            return;
        }// end function

        public function set upDataPower(param1:int) : void
        {
            var _loc_2:int = 0;
            if (this._ctrl.player.extraPower > 0)
            {
                _loc_2 = this._ctrl.player.extraPower;
            }
            if (this._inStage)
            {
                this._heroPractice.getCurrentPower = param1 + _loc_2;
            }
            return;
        }// end function

        public function set pickNum(param1:int) : void
        {
            if (this._inStage)
            {
                this._heroPractice.packNum = param1;
            }
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._inStage;
        }// end function

        public function get isBatton() : Boolean
        {
            return this._isBatton;
        }// end function

        public function onQuicklyMission(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.quickly();
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

        public function onClosePractice(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    _view.toolbar.closePractice();
                    this.start_practice();
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

        public function get_continue_practice_info() : void
        {
            this._practiceTime = 0;
            _data.call(Mod_HeroMission_Base.get_continue_practice_info, this.continuePracticeCallBack, []);
            return;
        }// end function

        private function continue_practice() : void
        {
            _data.call(Mod_HeroMission_Base.continue_practice, new Function(), []);
            this.quickly();
            return;
        }// end function

        private function continuePracticeCallBack() : void
        {
            var _loc_1:* = this._ctrl.heroMission.continuePracticeInfo;
            if (_loc_1.isHeroPractice == 1)
            {
                this._isContinue = true;
                this._isBatton = true;
                this.showTownId = _loc_1.townId;
                this.getHeroPracticeList = _loc_1.missionList;
                this._practiceTime = _loc_1.practiceTime;
            }
            return;
        }// end function

        public function clear() : void
        {
            this._heroPractice.clear();
            return;
        }// end function

        public function close() : void
        {
            if (this._isQuickly)
            {
                _view.showTip(HeroPracticeViewLang.InQuickly);
                return;
            }
            this._practiceTime = 0;
            this.stop_practice();
            this.stopPractice();
            this._isContinue = false;
            this.clear();
            this._inStage = false;
            _data.cancelPatch(Mod_HeroMission_Base.notify);
            _popup.removeChild(this._heroPractice.content);
            return;
        }// end function

    }
}
