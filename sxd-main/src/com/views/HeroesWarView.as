package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.haloer.data.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class HeroesWarView extends Base implements IView
    {
        private var _heroesWar:IHeroesWar;
        private var _intEndTime:int;
        private var _intWarCdTime:int;
        private var _intCanOpenUI:int = 10;
        private var _intSeverCount:int = 3;
        private var _aryWarReport:Array;
        private var _aryPlayerWarReport:Array;
        private var _aryShuShanPlayerList:Array;
        private var _aryKunLunPlayerList:Array;
        private var _dialog:IAlert = null;
        public var _blnIsInWar:Boolean = false;
        private var _blnInBuyBuff:Boolean = false;
        private var _blnCanJoin:Boolean = false;
        private var _aryCachePlayer:Array;
        private var _aryCacheWarReport:Array;
        private var _intRenderRecordCount:int = 0;

        public function HeroesWarView()
        {
            this._aryWarReport = [];
            this._aryPlayerWarReport = [];
            this._aryShuShanPlayerList = [];
            this._aryKunLunPlayerList = [];
            this._aryCachePlayer = [];
            this._aryCacheWarReport = [];
            _inStageTipTitle = HeroesWarViewLang.InHeroesWar;
            _inStageTipContent = "";
            return;
        }// end function

        public function show() : void
        {
            if (_view.multiMission.isMinimumWithTip)
            {
                return;
            }
            if (_view.getPeach.inStageWithTip)
            {
                return;
            }
            if (_view.rollCake.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _view.toolbar.unblockHealthInCampWar();
            _popup.closeView(this);
            this._heroesWar = null;
            _view.inCampWar.opened = false;
            return;
        }// end function

        public function clear() : void
        {
            this._view.removeFromTimerProcessList(this.sign);
            this._heroesWar.clear();
            this._data.cancelPatch(Mod_HeroesWar_Base.notify_report);
            this._ctrl.heroesWar.getPlayerStatusData();
            this._ctrl.heroesWar.getWarReport();
            this._aryCachePlayer = [];
            this._aryCacheWarReport = [];
            this.close_heroes_war();
            _view.townMap.otherCount = 999;
            return;
        }// end function

        public function updateSkill(param1:int) : void
        {
            if (this.inStage || this._heroesWar != null)
            {
                this._heroesWar.updateSkill(param1);
            }
            return;
        }// end function

        public function getBuff() : void
        {
            this.get_buff();
            return;
        }// end function

        private function loadData() : void
        {
            _data.call(Mod_HeroesWar_Base.get_heroes_open_time, this.loadDataCallBack, []);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            var callBack:* = function () : void
            {
                var _loc_1:* = _ctrl.heroesWar.getCurrentHeroesOpenTime();
                var _loc_2:* = _ctrl.heroesWar.getIsOpenHeroesWar();
                _view.activities.activityShowHeroesWar(_loc_2, _loc_1["start_time"], _loc_1["end_time"]);
                if (_loc_2 == 0 || _loc_2 == 2)
                {
                    _view.showTip(HeroesWarViewLang.HeroesWar, HeroesWarViewLang.NoToOpenTime);
                    return;
                }
                render();
                _intEndTime = _loc_1["end_time"];
                open_heroes_war();
                getHeroesPlayerByShuShan();
                notify_report();
                get_buff();
                timer();
                _view.addToTimerProcessList(sign, timer);
                return;
            }// end function
            ;
            loadAssets("HeroesWar", callBack, HeroesWarViewLang.LoadInfo);
            return;
        }// end function

        private function render() : void
        {
            this._heroesWar = _view.getAssetsObject("HeroesWar", "HeroesWar") as IHeroesWar;
            this.init();
            this._heroesWar.render();
            this._heroesWar.updateSkill(this._ctrl.player.skill);
            if (this._aryWarReport.length > 0)
            {
                this._heroesWar.renderWarReportList(this._aryWarReport, this._aryPlayerWarReport);
            }
            return;
        }// end function

        private function showUI() : void
        {
            if (this._heroesWar == null)
            {
                return;
            }
            _popup.addView(this, this._heroesWar.content);
            _view.center(sign, this._heroesWar.content);
            return;
        }// end function

        private function hideUI() : void
        {
            _popup.closeView(this);
            return;
        }// end function

        private function init() : void
        {
            this._intCanOpenUI = 0;
            this._blnIsInWar = false;
            this._blnCanJoin = false;
            this._blnInBuyBuff = false;
            this._heroesWar.loadBtnCartoon([URI.addonsUrl + "button_effect.swf"]);
            this._heroesWar.drag = this._view.drag.iDrag;
            this._heroesWar.tip = _view.tip.iTip;
            if (this._dialog == null)
            {
                this._dialog = _view.alert.iAlert;
            }
            this._heroesWar.playerLevel = this._ctrl.player.level;
            this._heroesWar.playerID = this._ctrl.player.playerId;
            this._heroesWar.onClose = this.close;
            this._heroesWar.onJoinWar = this.joinHeroesWar;
            this._heroesWar.onExitWar = this.exit_heroes_war;
            this._heroesWar.onIngotInspire = this.buyBuff;
            this._heroesWar.onSkillInspire = this.buyBuff;
            this._heroesWar.onTextLink = this._view.toolbar.onTextLink;
            _view.townMap.otherCount = 0;
            return;
        }// end function

        private function timer() : void
        {
            if (this._intEndTime > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this._intEndTime - 1;
                _loc_1._intEndTime = _loc_2;
                this._heroesWar.renderHeroesWarEndTime(DateTime.formatFromSecond(this._intEndTime));
                if (this._intEndTime % 600 == 0 || this._intEndTime == 60)
                {
                    this.syncEndTime();
                }
            }
            this.renderPlayerAndWarReport();
            return;
        }// end function

        private function renderPlayerAndWarReport() : void
        {
            if (this._blnIsInWar)
            {
                return;
            }
            if (this._aryCachePlayer.length > this._intRenderRecordCount)
            {
                this.updatePlayerStatus(this._aryCachePlayer.splice(0, 20));
            }
            else if (this._ctrl.heroesWar.getPlayerStatusDataLength > 0)
            {
                this._aryCachePlayer = this._ctrl.heroesWar.getPlayerStatusData();
            }
            if (this._aryCacheWarReport.length > this._intRenderRecordCount)
            {
                this.updateWarReport(this._aryCacheWarReport.splice(0, 15));
            }
            else if (this._ctrl.heroesWar.getWarReportLength > 0)
            {
                this._aryCacheWarReport = this._ctrl.heroesWar.getWarReport();
            }
            return;
        }// end function

        private function toatlPlayerCount(param1:Array) : Object
        {
            var _loc_3:Object = null;
            var _loc_2:Object = {};
            for each (_loc_3 in param1)
            {
                
                if (_loc_2.hasOwnProperty(_loc_3["min_level"]))
                {
                    (_loc_2[_loc_3["min_level"]] + 1);
                    continue;
                }
                _loc_2[_loc_3["min_level"]] = 1;
            }
            return _loc_2;
        }// end function

        private function isShowUI() : void
        {
            var _loc_1:String = this;
            var _loc_2:* = this._intCanOpenUI + 1;
            _loc_1._intCanOpenUI = _loc_2;
            if (this._intCanOpenUI == this._intSeverCount)
            {
                this._structure.popup.closeAll();
                this.showUI();
            }
            return;
        }// end function

        private function buyBuff(param1:int) : void
        {
            var callBack:Function;
            var intType:* = param1;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    buy_buff(intType);
                }
                if (_dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.CampWarIngotBuyBuff, true);
                }
                return;
            }// end function
            ;
            if (intType == Mod_HeroesWar_Base.PAY_INGOT && !_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.CampWarIngotBuyBuff))
            {
                this._dialog.yesLabel = HeroesWarViewLang.DialogYes;
                this._dialog.cancelLabel = HeroesWarViewLang.DialogCancel;
                this._dialog.hasCheckbox = true;
                this._dialog.show(Lang.sprintf(HeroesWarViewLang.BuyBuff, HtmlText.yellow(HeroesWarViewLang.BuyBuffIngot)), AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            }
            else
            {
                this.buy_buff(intType);
            }
            return;
        }// end function

        private function joinHeroesWar() : void
        {
            this._view.toolbar.checkWarCdTime(this.join_heroes_war, WarCdTimeType.HeroesWar);
            return;
        }// end function

        private function updatePlayerStatus(param1:Array) : void
        {
            var _loc_4:Object = null;
            var _loc_2:Boolean = false;
            var _loc_3:Boolean = false;
            for each (_loc_4 in param1)
            {
                
                if (_loc_4["team_id"] == FactionType.campId(FactionType.ShuShanCheng))
                {
                    this.updateShuShanPlayerStatus(_loc_4);
                    _loc_2 = true;
                    continue;
                }
                this.updateKunLunPlayerStatus(_loc_4);
                _loc_3 = true;
            }
            if (_loc_2)
            {
                this._heroesWar.setShuShanPlayerList();
                this._heroesWar.renderShuShanInfo(this.toatlPlayerCount(this._aryShuShanPlayerList));
            }
            if (_loc_3)
            {
                this._heroesWar.setKunLunPlayerList();
                this._heroesWar.renderKunLunInfo(this.toatlPlayerCount(this._aryKunLunPlayerList));
            }
            return;
        }// end function

        private function updateShuShanPlayerStatus(param1:Object) : void
        {
            var _loc_3:int = 0;
            var _loc_2:Object = {};
            if (param1["status"] == Mod_HeroesWar_Base.PLAYER_JOIN_HEROES_WAR)
            {
                for each (_loc_2 in this._aryShuShanPlayerList)
                {
                    
                    if (param1["player_id"] == _loc_2["player_id"])
                    {
                        return;
                    }
                }
                this._aryShuShanPlayerList.push(param1);
            }
            else if (param1["status"] == Mod_HeroesWar_Base.PLAYER_EXIT_HEROES_WAR)
            {
                _loc_3 = this._aryShuShanPlayerList.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    _loc_2 = this._aryShuShanPlayerList[_loc_3] as Object;
                    if (param1["player_id"] == _loc_2["player_id"])
                    {
                        this._aryShuShanPlayerList.splice(_loc_3, 1);
                        break;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            else
            {
                for each (_loc_2 in this._aryShuShanPlayerList)
                {
                    
                    if (param1["player_id"] == _loc_2["player_id"])
                    {
                        _loc_2["status"] = param1["status"];
                        param1["player_nick_name"] = _loc_2["player_nick_name"];
                        break;
                    }
                }
            }
            this._heroesWar.renderPlayer(param1, FactionType.ShuShanCheng);
            return;
        }// end function

        private function updateKunLunPlayerStatus(param1:Object) : void
        {
            var _loc_3:int = 0;
            var _loc_2:Object = {};
            if (param1["status"] == Mod_HeroesWar_Base.PLAYER_JOIN_HEROES_WAR)
            {
                for each (_loc_2 in this._aryKunLunPlayerList)
                {
                    
                    if (param1["player_id"] == _loc_2["player_id"])
                    {
                        return;
                    }
                }
                this._aryKunLunPlayerList.push(param1);
            }
            else if (param1["status"] == Mod_HeroesWar_Base.PLAYER_EXIT_HEROES_WAR)
            {
                _loc_3 = this._aryKunLunPlayerList.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    _loc_2 = this._aryKunLunPlayerList[_loc_3] as Object;
                    if (param1["player_id"] == _loc_2["player_id"])
                    {
                        this._aryKunLunPlayerList.splice(_loc_3, 1);
                        break;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            else
            {
                for each (_loc_2 in this._aryKunLunPlayerList)
                {
                    
                    if (param1["player_id"] == _loc_2["player_id"])
                    {
                        _loc_2["status"] = param1["status"];
                        param1["player_nick_name"] = _loc_2["player_nick_name"];
                        break;
                    }
                }
            }
            this._heroesWar.renderPlayer(param1, FactionType.KunLunCheng);
            return;
        }// end function

        private function updateWarReport(param1:Array) : void
        {
            var _loc_2:Object = null;
            for each (_loc_2 in param1)
            {
                
                this._aryWarReport.push(_loc_2);
                if (_loc_2["winner_player_id"] == this._ctrl.player.playerId || _loc_2["loser_player_id"] == this._ctrl.player.playerId)
                {
                    this._aryPlayerWarReport.push(_loc_2);
                }
            }
            if (this._aryPlayerWarReport.length > 20)
            {
                this._aryPlayerWarReport.splice(0, this._aryPlayerWarReport.length - 15);
                if (this._heroesWar.WarReportType == 1)
                {
                    this._heroesWar.renderWarReportList(this._aryWarReport, this._aryPlayerWarReport);
                }
            }
            else if (this._heroesWar.WarReportType == 1)
            {
                this._heroesWar.renderWarReport(this._aryWarReport, this._aryPlayerWarReport, param1);
            }
            if (this._aryWarReport.length > 30)
            {
                this._aryWarReport.splice(0, this._aryWarReport.length - 15);
                if (this._heroesWar.WarReportType == 0)
                {
                    this._heroesWar.renderWarReportList(this._aryWarReport, this._aryPlayerWarReport);
                }
            }
            else if (this._heroesWar.WarReportType == 0)
            {
                this._heroesWar.renderWarReport(this._aryWarReport, this._aryPlayerWarReport, param1);
            }
            return;
        }// end function

        private function renderAutoJoin() : void
        {
            if (this._blnCanJoin && !this._blnIsInWar)
            {
                this._heroesWar.renderAutoJoin();
                this._blnCanJoin = false;
            }
            return;
        }// end function

        public function get_heroes_open_time() : void
        {
            this._data.call(Mod_HeroesWar_Base.get_heroes_open_time, this.getHeroesOpenTimeCallBack, []);
            return;
        }// end function

        private function getHeroesOpenTimeCallBack() : void
        {
            var _loc_1:* = this._ctrl.heroesWar.getCurrentHeroesOpenTime();
            var _loc_2:* = this._ctrl.heroesWar.getIsOpenHeroesWar();
            this._view.activities.get_robot_status_heroes();
            return;
        }// end function

        private function open_heroes_war() : void
        {
            this._data.call(Mod_HeroesWar_Base.open_heroes_war, this.openHeroesWarCallBack, []);
            return;
        }// end function

        private function openHeroesWarCallBack() : void
        {
            this.isShowUI();
            var _loc_1:* = this._ctrl.heroesWar.openHeroesWar();
            this._heroesWar.renderWinningList(_loc_1["top_player_list"]);
            this._heroesWar.renderIntegral(_loc_1);
            this._heroesWar.renderPlayerHeroesWarInfo(_loc_1);
            return;
        }// end function

        private function close_heroes_war() : void
        {
            this._data.call(Mod_HeroesWar_Base.close_heroes_war, null, []);
            return;
        }// end function

        private function getHeroesPlayerByShuShan() : void
        {
            this._data.call(Mod_HeroesWar_Base.get_heroes_player, this.getHeroesPlayerByShuShanCallBack, [FactionType.campId(FactionType.ShuShanCheng)]);
            return;
        }// end function

        private function getHeroesPlayerByShuShanCallBack() : void
        {
            this.isShowUI();
            var _loc_1:* = this._ctrl.heroesWar.getHeroesLevelArea();
            this._heroesWar.renderHeroesLevelArea(_loc_1);
            this._aryShuShanPlayerList = this._ctrl.heroesWar.getHeroesPlayer();
            this._heroesWar.renderPlayerList(this._aryShuShanPlayerList, FactionType.ShuShanCheng);
            this.getHeroesPlayerByKunLun();
            return;
        }// end function

        private function getHeroesPlayerByKunLun() : void
        {
            this._data.call(Mod_HeroesWar_Base.get_heroes_player, this.getHeroesPlayerByKunLunCallBack, [FactionType.campId(FactionType.KunLunCheng)]);
            return;
        }// end function

        private function getHeroesPlayerByKunLunCallBack() : void
        {
            this.isShowUI();
            var _loc_1:* = this._ctrl.heroesWar.getHeroesLevelArea();
            this._heroesWar.renderHeroesLevelArea(_loc_1);
            this._aryKunLunPlayerList = this._ctrl.heroesWar.getHeroesPlayer();
            this._heroesWar.renderPlayerList(this._aryKunLunPlayerList, FactionType.KunLunCheng);
            return;
        }// end function

        private function join_heroes_war(param1:Boolean) : void
        {
            if (param1)
            {
                this._heroesWar.renderJoinWar(-1);
            }
            else
            {
                _view.toolbar.blockHealthInCampWar();
                _view.inCampWar.opened = true;
                this._data.call(Mod_HeroesWar_Base.join_heroes_war, this.joinHeroesWarCallBack, []);
            }
            return;
        }// end function

        private function joinHeroesWarCallBack() : void
        {
            var _loc_1:* = this._ctrl.heroesWar.getJoinHeroesWar();
            if (_loc_1["result"] == Mod_HeroesWar_Base.SUCCESS)
            {
                this._heroesWar.renderJoinWar(_loc_1["result"]);
                this._view.showTip(HeroesWarViewLang.JoinHeroesWar, HeroesWarViewLang.JoinBlessing, TipType.Success);
            }
            else
            {
                _view.inCampWar.opened = false;
                this._view.showTip(this.message(_loc_1["result"]));
            }
            this._heroesWar.renderJoinWar(_loc_1["result"]);
            return;
        }// end function

        private function exit_heroes_war() : void
        {
            this._data.call(Mod_HeroesWar_Base.exit_heroes_war, null, []);
            return;
        }// end function

        public function notifyCallBack(param1:Object) : void
        {
            var objPlayerHeroesInfo:Object;
            var obj:* = param1;
            switch(obj["notify_type"])
            {
                case Mod_HeroesWar_Base.OPEN_HEROES_WAR:
                {
                    break;
                }
                case Mod_HeroesWar_Base.END_HEROES_WAR:
                {
                    if (this._heroesWar != null)
                    {
                        this._dialog.yesLabel = HeroesWarViewLang.DialogYes;
                        this._dialog.show(HeroesWarViewLang.HeroesWarFinish, AlertButtonType.Yes, null);
                        this._aryWarReport = [];
                        this._aryPlayerWarReport = [];
                        this.close();
                    }
                    this.get_heroes_open_time();
                    this._view.toolbar.updateCampWarInspire(0);
                    break;
                }
                case Mod_HeroesWar_Base.UPDATE_TOP_WINNER:
                {
                    if (this._heroesWar != null)
                    {
                        this._heroesWar.renderWinningList(this._ctrl.heroesWar.getNotifyTopWinner());
                    }
                    break;
                }
                case Mod_HeroesWar_Base.UPDATE_PLAYER_HEROES_WAR_INFO:
                {
                    if (this._heroesWar != null)
                    {
                        objPlayerHeroesInfo = this._ctrl.heroesWar.getNotifyPlayerHeroesInfo();
                        this._heroesWar.renderPlayerHeroesWarInfo(objPlayerHeroesInfo);
                    }
                    break;
                }
                case Mod_HeroesWar_Base.START_WAR:
                {
                    if (this._heroesWar != null)
                    {
                        _view.inCampWar.auto = this._heroesWar.autoJoin;
                        _view.inCampWar.onClose = function (param1:Boolean) : void
            {
                finish_war();
                showUI();
                renderAutoJoin();
                _view.inCampWar.opened = param1;
                return;
            }// end function
            ;
                        _view.inCampWar.show();
                        this._blnIsInWar = true;
                        this.hideUI();
                    }
                    break;
                }
                case Mod_HeroesWar_Base.CAN_JOIN_HEROES_WAR:
                {
                    if (this._heroesWar != null)
                    {
                        this._heroesWar.renderCanJoinWar();
                        this._blnCanJoin = true;
                        this.renderAutoJoin();
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

        private function notify_report() : void
        {
            this._data.patch(Mod_HeroesWar_Base.notify_report, this.notifyReportCallBack);
            return;
        }// end function

        private function notifyReportCallBack() : void
        {
            return;
        }// end function

        public function finish_war() : void
        {
            this._blnIsInWar = false;
            this._data.call(Mod_HeroesWar_Base.finish_war, null, []);
            return;
        }// end function

        private function buy_buff(param1:int) : void
        {
            if (this._blnInBuyBuff)
            {
                return;
            }
            this._blnInBuyBuff = true;
            this._data.call(Mod_HeroesWar_Base.buy_buff, this.buyBuffCallBack, [param1]);
            return;
        }// end function

        private function buyBuffCallBack() : void
        {
            if (this._heroesWar == null)
            {
                this._blnInBuyBuff = false;
                return;
            }
            var _loc_1:* = this._ctrl.heroesWar.buyBuff();
            if (_loc_1["result"] == Mod_HeroesWar_Base.SUCCESS)
            {
                if (_loc_1["add_buff_value"] == 0)
                {
                    this._heroesWar.renderBuyBuffFail(HeroesWarViewLang.InspireFial);
                }
                else
                {
                    this._heroesWar.renderBuyBuffSuccess(Lang.sprintf(HeroesWarViewLang.InspireSuccess, _loc_1["add_buff_value"]));
                    this._heroesWar.renderBuff(_loc_1);
                    this._view.toolbar.updateCampWarInspire(_loc_1["buff_value"]);
                }
            }
            else if (_loc_1["result"] == Mod_HeroesWar_Base.NOT_ENOUGH_INGOT)
            {
                _view.showTip(this.message(_loc_1.result));
            }
            else
            {
                this._heroesWar.renderBuyBuffFail(this.message(_loc_1["result"]));
            }
            this._blnInBuyBuff = false;
            return;
        }// end function

        private function get_buff() : void
        {
            this._data.call(Mod_HeroesWar_Base.get_buff, this.getBuffCallBack, []);
            return;
        }// end function

        private function getBuffCallBack() : void
        {
            var _loc_1:* = this._ctrl.heroesWar.getBuff();
            this._view.toolbar.updateCampWarInspire(_loc_1["buff_value"]);
            if (this._heroesWar != null)
            {
                this._heroesWar.renderBuff(_loc_1);
            }
            return;
        }// end function

        private function syncEndTime() : void
        {
            this._data.call(Mod_HeroesWar_Base.get_heroes_open_time, this.syncEndTimeCallBack, []);
            return;
        }// end function

        private function syncEndTimeCallBack() : void
        {
            var _loc_1:* = this._ctrl.heroesWar.getCurrentHeroesOpenTime();
            this._intEndTime = _loc_1["end_time"];
            return;
        }// end function

        public function set_robot(param1:Boolean) : void
        {
            this._data.call(Mod_HeroesWar_Base.set_robot, this.setRobotCallBack, [param1 == true ? (Mod_HeroesWar_Base.ON) : (Mod_HeroesWar_Base.OFF)]);
            return;
        }// end function

        private function setRobotCallBack() : void
        {
            var _loc_1:* = this._ctrl.heroesWar.setRobot();
            if (_loc_1["result"] != Mod_HeroesWar_Base.SUCCESS)
            {
                this.message(_loc_1["result"]);
            }
            this._view.activities.get_robot_status_heroes();
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_HeroesWar_Base.SUCCESS:
                {
                    _loc_2 = HeroesWarViewLang.Success;
                    break;
                }
                case Mod_HeroesWar_Base.CD_TIME:
                {
                    _loc_2 = HeroesWarViewLang.CdTime;
                    break;
                }
                case Mod_HeroesWar_Base.NOT_ENOUGH_INGOT:
                {
                    _loc_2 = HeroesWarViewLang.NotEnoughIngot;
                    break;
                }
                case Mod_HeroesWar_Base.NOT_ENOUGH_SKILL:
                {
                    _loc_2 = HeroesWarViewLang.NotEnoughSkill;
                    break;
                }
                case Mod_HeroesWar_Base.MAX_BUFF:
                {
                    _loc_2 = HeroesWarViewLang.MaxBuff;
                    break;
                }
                case Mod_HeroesWar_Base.REQUEST_VIP_LEVEL:
                {
                    _loc_2 = HeroesWarViewLang.RequestVipLevel;
                    break;
                }
                case Mod_HeroesWar_Base.IN_ACTION:
                {
                    _loc_2 = HeroesWarViewLang.InAction;
                    break;
                }
                default:
                {
                    _loc_2 = HeroesWarViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
