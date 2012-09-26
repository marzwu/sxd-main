package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import com.lang.client.com.views.toolbar.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;

    public class TakeBibleRoadView extends Base implements IView
    {
        private var _playerId:int;
        private var _ruLaiType:int;
        private var _isSelf:Boolean = false;
        private var _isMainData:Object;
        public var _rulaiStartTimeList:Array;
        private var _takeBibleRoad:ITakeBibleRoad;
        private var _isClose:Boolean = false;
        private var _addFirst:Boolean = true;
        private var _robId:int = 0;
        private var _isProtect:Boolean = false;
        private var _speedUpNum:int = 0;
        private var _systemList:Array;
        private var _playerData:Object;
        private var _isShowBaiMa:Boolean = true;
        private var _reportId:int = 0;

        public function TakeBibleRoadView() : void
        {
            this._systemList = [];
            _inStageTipTitle = TakeBibleRoadViewLang.InStageTipTitle;
            _inStageTipContent = "";
            return;
        }// end function

        private function open_take_bible() : void
        {
            _data.call(Mod_TakeBible_Base.open_take_bible, this.openTakeBibleCallBack, []);
            return;
        }// end function

        private function close_take_bible() : void
        {
            _data.call(Mod_TakeBible_Base.close_take_bible, new Function(), []);
            return;
        }// end function

        private function notify() : void
        {
            _data.patch(Mod_TakeBible_Base.notify, this.notifyCallBack);
            return;
        }// end function

        private function get_player_take_bible(param1:int) : void
        {
            this._playerId = param1;
            _data.call(Mod_TakeBible_Base.get_player_take_bible, this.getPlayerTakeBibleCallBack, [param1]);
            return;
        }// end function

        private function quickly(param1:int) : void
        {
            _data.call(Mod_TakeBible_Base.quickly, this.quicklyCallBack, [param1]);
            return;
        }// end function

        private function rob(param1:int) : void
        {
            _view.takeBibleWar.opened = true;
            _data.call(Mod_TakeBible_Base.rob, this.robCallBack, [param1]);
            return;
        }// end function

        public function get_take_bible_updata_data() : void
        {
            _data.call(Mod_TakeBible_Base.get_take_bible_updata_data, this.takeBibleUpdataDataCallBack, []);
            return;
        }// end function

        public function get_rob_take_bible_cd_time() : void
        {
            _data.call(Mod_TakeBible_Base.get_rob_take_bible_cd_time, this.takeBibleCdTimeCallBack, []);
            return;
        }// end function

        public function clear_rob_take_bible_cd_time() : void
        {
            _data.call(Mod_TakeBible_Base.clear_rob_take_bible_cd_time, this.clearTakeBibleCdTimeCallBack, []);
            return;
        }// end function

        public function call_rulai() : void
        {
            return;
        }// end function

        public function get_rulai_open_time() : void
        {
            _data.call(Mod_TakeBible_Base.get_rulai_open_time, this.getRulaiOpenTimeCallBack, []);
            return;
        }// end function

        private function openTakeBibleCallBack() : void
        {
            var _loc_1:Object = null;
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Object = null;
            switch(_loc_1.type)
            {
                case Mod_TakeBible_Base.OPEN_FOR_CALL:
                {
                    break;
                }
                case Mod_TakeBible_Base.OPEN:
                {
                    break;
                }
                case Mod_TakeBible_Base.CLOSE:
                {
                    if (_loc_3 == 0)
                    {
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function updateRuLaiData() : void
        {
            this.open_take_bible();
            return;
        }// end function

        private function checkState(param1:Array) : Number
        {
            var _loc_5:Object = null;
            var _loc_2:Number = 0;
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1[_loc_4];
                if (_loc_5.isSelf)
                {
                    _loc_2 = _loc_2 + 0.2;
                }
                _loc_4++;
            }
            if (_loc_2 != 0)
            {
                return _loc_2;
            }
            return 0.1;
        }// end function

        private function getPlayerTakeBibleCallBack() : void
        {
            var _loc_4:Object = null;
            var _loc_1:* = _ctrl.TakeBible.playerTakeBible;
            if (this.inStage == false)
            {
                return;
            }
            var _loc_2:* = _loc_1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _loc_1[_loc_3];
                this._takeBibleRoad.playerData = _loc_4;
                _loc_3++;
            }
            return;
        }// end function

        private function takeBibleUpdataDataCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.takeBibleUpdataData;
            if (_ctrl.TakeBible.canTakeBibleTimes <= 0)
            {
                this._view.activities.visibleBtnEffect(FunctionType.TakeBible, keepAliveLang.CanCall, false);
                this._view.activities.visibleBtnEffect(FunctionType.TakeBible, keepAliveLang.RuLaiSpirit, false);
            }
            if (this.inStage == false)
            {
                return;
            }
            this._takeBibleRoad.returnTakeBibleRoadData(_loc_1);
            this._takeBibleRoad.callRuLaiState = _loc_1;
            return;
        }// end function

        private function notifyCallBack() : void
        {
            var _loc_1:Object = null;
            var _loc_2:Boolean = false;
            if (inStage == false)
            {
                return;
            }
            _loc_1 = _ctrl.TakeBible.notifyData;
            switch(_loc_1.type)
            {
                case Mod_TakeBible_Base.ROB:
                {
                    if (_loc_1.isMain)
                    {
                        this._isMainData = _loc_1;
                    }
                    else
                    {
                        this._takeBibleRoad.getSystemInfo = _loc_1;
                    }
                    break;
                }
                case Mod_TakeBible_Base.TAKE_BIBLE:
                {
                    this._takeBibleRoad.getSystemInfo = _loc_1;
                    break;
                }
                case Mod_TakeBible_Base.NEW_TAKE_BIBLE:
                {
                    if (this._isClose == false)
                    {
                        this._takeBibleRoad.getTakeBibleTeamData = _loc_1.classTakePlayer[0];
                    }
                    break;
                }
                case Mod_TakeBible_Base.QUICKLY:
                {
                    this._takeBibleRoad.changeTime = _loc_1;
                    break;
                }
                case Mod_TakeBible_Base.ARRIVAL:
                {
                    _loc_2 = _loc_1.playerId == _ctrl.player.playerId;
                    this._takeBibleRoad.clearTeam(_loc_1.playerId, _loc_2);
                    if (_loc_2)
                    {
                        this.isUserProtection = 0;
                        if (_view.takeBibleReady.inStage)
                        {
                            _view.takeBibleReady.get_take_bible_info();
                        }
                    }
                    break;
                }
                case Mod_TakeBible_Base.FRIEND_APPROVE_APPLY:
                {
                    _view.takeBibleReady.hasApplyFriend(true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function quicklyCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.quicklyData;
            if (_loc_1.msg == Mod_TakeBible_Base.SUCCESS)
            {
                this._takeBibleRoad.isUserSpeedUp();
                if (this._speedUpNum <= 600)
                {
                    this._takeBibleRoad.clearTeam(_ctrl.player.playerId, true);
                    _view.showTip(TakeBibleRoadViewLang.SuccessTakeBible, "", TipType.Success);
                }
                else
                {
                    _view.showTip(TakeBibleRoadViewLang.SuccessQuickly, "", TipType.Success);
                }
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function robCallBack() : void
        {
            var warData:WarData;
            var warInfo:String;
            var data:* = _ctrl.TakeBible.robData;
            this.get_player_take_bible(this._robId);
            this.get_rob_take_bible_cd_time();
            this.get_take_bible_updata_data();
            if (data.msg == Mod_TakeBible_Base.SUCCESS)
            {
                warData = new WarData();
                warData.format(data["warData"]);
                _view.takeBibleWar.warData = warData;
                _view.takeBibleWar.awardFame = _ctrl.TakeBible.robData["robFame"];
                _view.takeBibleWar.awardCoin = _ctrl.TakeBible.robData["robCoin"];
                warInfo;
                if (this._isProtect)
                {
                    warInfo = data.info + "\n";
                }
                if (data.bless > 1)
                {
                    warInfo = warInfo + data.blessInfo;
                }
                _view.takeBibleWar.detail = {defenderFriend:warInfo};
                _view.takeBibleWar.onClose = function (param1:Boolean) : void
            {
                _popup.addChildAt(_takeBibleRoad.content, 0);
                open_take_bible();
                if (_isMainData)
                {
                    _takeBibleRoad.isUserProtection = 0;
                    _takeBibleRoad.getSystemInfo = _isMainData;
                    _isMainData = null;
                }
                _isClose = false;
                _view.toolbar.renderTakeBibleBerobbed();
                _data.patch(Mod_TakeBible_Base.notify, notifyCallBack);
                return;
            }// end function
            ;
                _view.takeBibleWar.onAfterAdded = function () : void
            {
                _popup.removeChild(_takeBibleRoad.content);
                _isClose = true;
                _data.cancelPatch(Mod_TakeBible_Base.notify);
                return;
            }// end function
            ;
                _view.takeBibleWar.show();
            }
            else
            {
                _view.takeBibleWar.opened = false;
                if (data.msg == Mod_TakeBible_Base.TAKE_BIBLE_STATUS)
                {
                    _view.showTip(TakeBibleRoadViewLang.TakeBibleStatus);
                }
                else
                {
                    this.renderMsg(data);
                }
            }
            this._robId = 0;
            return;
        }// end function

        private function takeBibleCdTimeCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.takeBibleCdTime;
            this._takeBibleRoad.cdTime = _loc_1;
            return;
        }// end function

        private function clearTakeBibleCdTimeCallBack() : void
        {
            var _loc_2:Object = null;
            var _loc_1:* = _ctrl.TakeBible.clearTakeBibleCdTime;
            if (_loc_1.msg == Mod_TakeBible_Base.SUCCESS)
            {
                _loc_2 = {};
                _loc_2.cdTime = 0;
                _loc_2.cleanIngot = 0;
                this._takeBibleRoad.cdTime = _loc_2;
                if (this._robId != 0)
                {
                    this.robTakeBible();
                }
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function callRulaiCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.callRulai;
            if (_loc_1.msg == Mod_TakeBible_Base.SUCCESS)
            {
                if (_view.takeBibleRuLai.inStage)
                {
                    _view.takeBibleRuLai.close();
                }
                _view.showTip(TakeBibleRoadViewLang.CallRulaiSuccess, TakeBibleRoadViewLang.SystemInfo, TipType.Success);
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        public function getRulaiOpenTimeCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.getRulaiOpenTimeData;
            this._rulaiStartTimeList = _loc_1.timeList;
            switch(_loc_1.type)
            {
                case Mod_TakeBible_Base.OPEN_FOR_CALL:
                {
                    _view.toolbar.rulaiType(1);
                    break;
                }
                case Mod_TakeBible_Base.OPEN:
                {
                    _view.toolbar.rulaiType(2);
                    break;
                }
                case Mod_TakeBible_Base.CLOSE:
                {
                    _view.toolbar.rulaiType(3);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get getStartTime() : int
        {
            var _loc_4:Object = null;
            var _loc_1:* = _ctrl.player.serverTime;
            var _loc_2:* = this._rulaiStartTimeList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._rulaiStartTimeList[_loc_3];
                if (_loc_4.startTime > _loc_1)
                {
                    return _loc_4.startTime;
                }
                _loc_3++;
            }
            return 0;
        }// end function

        public function get getEndTime() : int
        {
            var _loc_4:Object = null;
            var _loc_1:* = _ctrl.player.serverTime;
            var _loc_2:* = this._rulaiStartTimeList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._rulaiStartTimeList[_loc_3];
                if (_loc_4.startTime > _loc_1)
                {
                    return _loc_4.endTime;
                }
                _loc_3++;
            }
            return 0;
        }// end function

        public function isSummer() : Boolean
        {
            var _loc_5:Object = null;
            var _loc_1:Boolean = false;
            var _loc_2:* = _ctrl.player.serverTime;
            var _loc_3:* = this._rulaiStartTimeList.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = this._rulaiStartTimeList[_loc_4];
                if (_loc_5.startTime < _loc_2 && _loc_2 < _loc_5.endTime)
                {
                    _loc_1 = true;
                }
                _loc_4++;
            }
            return _loc_1;
        }// end function

        private function renderMsg(param1:Object) : void
        {
            switch(param1.msg)
            {
                case Mod_TakeBible_Base.CANCEL_APPLY:
                {
                    _view.showTip(TakeBibleRoadViewLang.CancelApply);
                    break;
                }
                case Mod_TakeBible_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(TakeBibleRoadViewLang.NotEnoughIngot);
                    break;
                }
                case Mod_TakeBible_Base.REQUEST_VIP:
                {
                    _view.showTip(TakeBibleRoadViewLang.RequestVip);
                    break;
                }
                case Mod_TakeBible_Base.FULL_TAKE_BIBLE_TIMES:
                {
                    _view.showTip(TakeBibleRoadViewLang.FullTakeBibleTimes);
                    break;
                }
                case Mod_TakeBible_Base.TAKE_BIBLE_STATUS:
                {
                    _view.showTip(TakeBibleRoadViewLang.TakeBibleStatus);
                    break;
                }
                case Mod_TakeBible_Base.BE_ROB_ALL:
                {
                    _view.showTip(TakeBibleRoadViewLang.BeRobAll);
                    break;
                }
                case Mod_TakeBible_Base.REROB:
                {
                    _view.showTip(TakeBibleRoadViewLang.Rerob);
                    break;
                }
                case Mod_TakeBible_Base.FULL_ROB_TIMES:
                {
                    _view.showTip(TakeBibleRoadViewLang.FullRobTimes);
                    break;
                }
                case Mod_TakeBible_Base.INVALID_PLAYER_ID:
                {
                    _view.showTip(TakeBibleRoadViewLang.InvalidPlayerId);
                    break;
                }
                case Mod_TakeBible_Base.PROTECT_STATUS:
                {
                    _view.showTip(TakeBibleRoadViewLang.ProtectStatus);
                    break;
                }
                case Mod_TakeBible_Base.CANCEL_APPLY:
                {
                    _view.showTip(TakeBibleRoadViewLang.CancelApply);
                    break;
                }
                case Mod_TakeBible_Base.FULL_PROTECT_TIMES:
                {
                    _view.showTip(TakeBibleRoadViewLang.FullProtectTimes);
                    break;
                }
                case Mod_TakeBible_Base.HAVE_CD_TIME:
                {
                    _view.showTip(TakeBibleRoadViewLang.RobHandler);
                    break;
                }
                case Mod_TakeBible_Base.CLOSE:
                {
                    _view.showTip(TakeBibleRoadViewLang.RuLaiClose);
                    break;
                }
                case Mod_TakeBible_Base.CALLED:
                {
                    _view.showTip(TakeBibleRoadViewLang.RuLaiCalled);
                    break;
                }
                case Mod_TakeBible_Base.TIMEUSED:
                {
                    _view.showTip(TakeBibleRoadViewLang.RuLaiTimeused);
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
            _view.closeEvent();
            _view.screen.stopPlayerRun();
            loadAssets("TakeBibleRoad", this.render, TakeBibleRoadViewLang.LoadAssets);
            return;
        }// end function

        public function show() : void
        {
            if (_view.multiMission.inStageWithTip)
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
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            this.open_take_bible();
            return;
        }// end function

        public function render() : void
        {
            _popup.closeAll();
            this._takeBibleRoad = _view.getAssetsObject("TakeBibleRoad", "TakeBibleRoad") as ITakeBibleRoad;
            _popup.addView(this, this._takeBibleRoad.content);
            this._takeBibleRoad.tip = _view.tip.iTip;
            _view.delayMessage.checkVisible(true);
            this.renderRoad();
            return;
        }// end function

        private function renderRoad() : void
        {
            this._takeBibleRoad.vipLevel = _ctrl.player.vipLevel;
            this._takeBibleRoad.isShowBaiMa = this._isShowBaiMa;
            this.openTakeBibleCallBack();
            this.notify();
            this.get_rob_take_bible_cd_time();
            this._takeBibleRoad.renderIngot = _ctrl.player.ingot;
            this._takeBibleRoad.renderCoins = _ctrl.player.coins;
            this._takeBibleRoad.onPlayerData = function (param1:int) : void
            {
                get_player_take_bible(param1);
                return;
            }// end function
            ;
            this._takeBibleRoad.onRob = function (param1:Object, param2:int, param3:int, param4:int, param5:int, param6:Boolean, param7:Boolean) : void
            {
                _playerData = param1;
                _robId = param2;
                if (param7)
                {
                    _view.showTip(TakeBibleRoadViewLang.RobMainPlayer);
                    return;
                }
                if (param6)
                {
                    _view.showTip(TakeBibleRoadViewLang.RobProtectPlayer);
                    return;
                }
                if (param5 <= 0)
                {
                    _view.showTip(TakeBibleRoadViewLang.CanProtectTimesNum);
                    return;
                }
                if (param1 != null)
                {
                    if (param1.isRobbed == 1)
                    {
                        _view.showTip(TakeBibleRoadViewLang.IsRobbed);
                        return;
                    }
                    if (param1.beRobTimes >= param1.totalCanRobTimes)
                    {
                        _view.showTip(param1.nickname + TakeBibleRoadViewLang.BeRobTimes);
                        return;
                    }
                }
                get_rob_take_bible_cd_time();
                if (param3 > 0)
                {
                    clearIngot(param4);
                    return;
                }
                robTakeBible();
                return;
            }// end function
            ;
            this._takeBibleRoad.onSpeedUp = function (param1:String, param2:int) : void
            {
                var callback:Function;
                var info:* = param1;
                var num:* = param2;
                if (_view.vipEnabled == false)
                {
                    return;
                }
                _speedUpNum = num;
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.TakeBibleSpeedUp))
                {
                    dialog.yesLabel = TakeBibleRoadViewLang.Sure;
                    dialog.cancelLabel = TakeBibleRoadViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        quickly(0);
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.TakeBibleSpeedUp, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(info, AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    quickly(0);
                }
                return;
            }// end function
            ;
            this._takeBibleRoad.onMaxSpeedUp = function (param1:String) : void
            {
                var callback:Function;
                var info:* = param1;
                if (_view.vipEnabled == false)
                {
                    return;
                }
                _speedUpNum = 0;
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.TakeBibleMaxSpeedUp))
                {
                    dialog.yesLabel = TakeBibleRoadViewLang.Sure;
                    dialog.cancelLabel = TakeBibleRoadViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        quickly(1);
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.TakeBibleMaxSpeedUp, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(info, AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    quickly(1);
                }
                return;
            }// end function
            ;
            this._takeBibleRoad.onOpenReady = function () : void
            {
                _view.takeBibleReady.switchSelf();
                return;
            }// end function
            ;
            this._takeBibleRoad.onClose = function (param1:Array) : void
            {
                _systemList = param1;
                if (_view.takeBibleReady.inStage)
                {
                    _view.takeBibleReady.close();
                }
                if (_view.takeBibleRuLai.inStage)
                {
                    _view.takeBibleRuLai.close();
                }
                close();
                return;
            }// end function
            ;
            this.reposition();
            this._takeBibleRoad.onMoveEnd = function () : void
            {
                return;
            }// end function
            ;
            this._takeBibleRoad.onMouseOver = function () : void
            {
                MouseCursor.showMouseCursor(MouseCursor.Map2Cursor, _view.getAssetsObject("Map", "MCWarMouse") as Sprite);
                return;
            }// end function
            ;
            this._takeBibleRoad.onMouseOut = function () : void
            {
                MouseCursor.hideMouseCursor(MouseCursor.Map2Cursor);
                return;
            }// end function
            ;
            this._takeBibleRoad.onTextLink = function (event:TextEvent) : void
            {
                _view.toolbar.onTextLink(event);
                return;
            }// end function
            ;
            this._takeBibleRoad.onClearCdTime = function (param1:int) : void
            {
                clearIngot(param1);
                return;
            }// end function
            ;
            this._takeBibleRoad.onRefreshCdTime = function () : void
            {
                _robId = 0;
                get_rob_take_bible_cd_time();
                return;
            }// end function
            ;
            this._takeBibleRoad.onShowBaiMa = function (param1:Boolean) : void
            {
                _isShowBaiMa = param1;
                return;
            }// end function
            ;
            this.renderSystemList();
            this._takeBibleRoad.onRuLaiReady = function (param1:Boolean) : void
            {
                _view.takeBibleRuLai.switchSelf();
                return;
            }// end function
            ;
            return;
        }// end function

        private function robTakeBible() : void
        {
            var _loc_1:String = null;
            if (this._playerData == null)
            {
                _view.alert.showYesNoMsg(TakeBibleRoadViewLang.NoData, TakeBibleRoadViewLang.Sure, TakeBibleRoadViewLang.Cancel, this.onRobHandler);
                this._isProtect = false;
            }
            else
            {
                _loc_1 = Lang.sprintf(TakeBibleRoadViewLang.IsRobTakeBible, HtmlText.red("【" + this._playerData.showName + "】"), this._playerData.protectName);
                _view.alert.showYesNoMsg(_loc_1, TakeBibleRoadViewLang.Sure, TakeBibleRoadViewLang.Cancel, this.onRobHandler);
                this._isProtect = this._playerData.isProtect;
            }
            return;
        }// end function

        private function renderSystemList() : void
        {
            var _loc_1:* = this._systemList.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._takeBibleRoad.getSystemInfo = this._systemList[_loc_2];
                _loc_2++;
            }
            return;
        }// end function

        private function clearIngot(param1:int) : void
        {
            var callback:Function;
            var cdIngot:* = param1;
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.TakeBibleClearCd))
            {
                this.dialog.yesLabel = TakeBibleRoadViewLang.Sure;
                this.dialog.cancelLabel = TakeBibleRoadViewLang.Cancel;
                this.dialog.hasCheckbox = true;
                callback = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    clear_rob_take_bible_cd_time();
                }
                else
                {
                    _robId = 0;
                }
                if (dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.TakeBibleClearCd, true);
                }
                return;
            }// end function
            ;
                this.dialog.show(HtmlText.yellow(Lang.sprintf(TakeBibleRoadViewLang.TakeBibleClearCd, cdIngot)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
            }
            else
            {
                this.clear_rob_take_bible_cd_time();
            }
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        public function set getRuLaiData(param1:Object) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._takeBibleRoad.getRuLaiData = param1;
            return;
        }// end function

        public function set takeBibleStatus(param1:int) : void
        {
            this._takeBibleRoad.takeBibleStatus = param1;
            return;
        }// end function

        public function set renderIngot(param1:Number) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._takeBibleRoad.renderIngot = param1;
            return;
        }// end function

        public function set renderCoins(param1:Number) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._takeBibleRoad.renderCoins = param1;
            return;
        }// end function

        public function set isUserProtection(param1:int) : void
        {
            this._takeBibleRoad.isUserProtection = param1;
            return;
        }// end function

        public function set rulaiType(param1:int) : void
        {
            this._ruLaiType = param1;
            return;
        }// end function

        public function set beRob(param1:Object) : void
        {
            param1.info = param1.robberShowName + TakeBibleRoadViewLang.RobberShowName;
            this.robShow(param1);
            return;
        }// end function

        public function set protectRob(param1:Object) : void
        {
            param1.info = Lang.sprintf(TakeBibleRoadViewLang.ProtectRob, param1.robberShowName, param1.protectShowName);
            this.robShow(param1);
            return;
        }// end function

        private function robShow(param1:Object) : void
        {
            _view.alert.showYesNoMsg(param1.info, TakeBibleRoadViewLang.Sure, TakeBibleRoadViewLang.Cancel, this.onBeRob);
            this._reportId = param1.reportId;
            return;
        }// end function

        private function onBeRob(param1:uint) : void
        {
            var flags:* = param1;
            switch(flags)
            {
                case AlertButtonType.Yes:
                {
                    _view.strategyWar.warType = WarType.TakeBibleWar;
                    _view.strategyWar.reportId = this._reportId;
                    _view.strategyWar.show();
                    _view.chat.changePoint = 0;
                    _view.strategyWar.onClose = function () : void
            {
                if (_view.serverWarCup.inStage)
                {
                    _view.chat.changePoint = 1;
                }
                _view.toolbar.robShow();
                return;
            }// end function
            ;
                    break;
                }
                case AlertButtonType.No:
                {
                    _view.toolbar.robShow();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function onRobHandler(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    if (this._takeBibleRoad.isCdTime)
                    {
                        _view.showTip(TakeBibleRoadViewLang.RobHandler);
                    }
                    else
                    {
                        this.rob(this._robId);
                    }
                    break;
                }
                case AlertButtonType.No:
                {
                    this._isProtect = false;
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
            if (inStage == false || this._isClose)
            {
                return;
            }
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                this._takeBibleRoad.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

        public function clear() : void
        {
            if (this._takeBibleRoad == null)
            {
                return;
            }
            this._takeBibleRoad.clear();
            this._takeBibleRoad = null;
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _data.cancelPatch(Mod_TakeBible_Base.notify);
            this.close_take_bible();
            _popup.closeView(this);
            _view.openEvent();
            return;
        }// end function

    }
}
