package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.toolbar.*;
    import com.assist.view.war.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;

    public class SuperSportView extends Base implements IView
    {
        public var topRank:int = 1;
        private var _myRank:int = 0;
        private var _isStartWar:Boolean = false;
        private var _isUpDataRank:Boolean = false;
        private var _newSportWrReport:Object;
        private var openData:Object;
        private var _battleData:Object;
        private var _challengePersonData:Object;
        public var startChallenge:Boolean = false;
        private var _isBatton:Boolean = false;
        private var _isLoaded:Boolean = false;
        private var _playerSign:String;
        private var _sportPlayerList:Array;
        private var _superSport:ISuperSport;
        private var _playerData:Object;
        private var _loader:Loader;
        private var _playerList:Array;

        public function SuperSportView() : void
        {
            this.openData = {};
            this._battleData = {};
            this._playerList = [{sign:RoleType.JianLing + RoleType.Nan, x:0, y:0}, {sign:RoleType.JianLing + RoleType.Nv, x:0, y:0}, {sign:RoleType.FeiYu + RoleType.Nan, x:0, y:0}, {sign:RoleType.FeiYu + RoleType.Nv, x:0, y:0}, {sign:RoleType.WuSheng + RoleType.Nan, x:0, y:0}, {sign:RoleType.WuSheng + RoleType.Nv, x:0, y:0}];
            _inStageTipTitle = SuperSportViewLang.InStageTipTitle;
            _inStageTipContent = "";
            return;
        }// end function

        private function open_super_sport() : void
        {
            _data.call(Mod_SuperSport_Base.open_super_sport, this.openSuperSportCallBack, []);
            return;
        }// end function

        public function get_challenge_list() : void
        {
            _data.call(Mod_SuperSport_Base.get_challenge_list, this.getChallengeListCallBack, []);
            return;
        }// end function

        public function start_challenge(param1:int) : void
        {
            _view.superSportWar.opened = true;
            this.startChallenge = true;
            this.topRank = Math.min(this._myRank, param1);
            _data.call(Mod_SuperSport_Base.start_challenge, this.startChallengeCallBack, [param1]);
            return;
        }// end function

        public function clear_cd_time() : void
        {
            _data.call(Mod_SuperSport_Base.clear_cd_time, this.clearCdTimeCallBack, []);
            return;
        }// end function

        public function buy_challenge_times() : void
        {
            _data.call(Mod_SuperSport_Base.buy_challenge_times, this.buyChallengeTimesCallBack, []);
            return;
        }// end function

        public function notify_new_sport_war_report() : void
        {
            _data.patch(Mod_SuperSport_Base.notify_new_sport_war_report, this.newSportWarReportTimesCallBack);
            return;
        }// end function

        public function notify() : void
        {
            _data.patch(Mod_SuperSport_Base.notify, this.notifyCallBack);
            return;
        }// end function

        public function close_super_sport() : void
        {
            _data.call(Mod_SuperSport_Base.close_super_sport, new Function(), []);
            return;
        }// end function

        public function get_ranking_top() : void
        {
            _data.call(Mod_SuperSport_Base.get_ranking_top, this.getRankingTopCallBack, []);
            return;
        }// end function

        public function notify_update_win_top() : void
        {
            _data.patch(Mod_SuperSport_Base.notify_update_win_top, this.updateWinTopCallBack);
            return;
        }// end function

        public function notify_global() : void
        {
            _view.toolbar.cancelPatchNotifyGlobal();
            _data.call(Mod_SuperSport_Base.notify_global, this.globalCallBack, []);
            return;
        }// end function

        private function get_cd_time() : void
        {
            _data.call(Mod_SuperSport_Base.get_cd_time, this.getCdTimeCallBack, []);
            return;
        }// end function

        public function get_challenge_times() : void
        {
            if (!FunctionType.isOpened(FunctionType.SuperSport))
            {
                return;
            }
            _data.call(Mod_SuperSport_Base.get_challenge_times, this.getChallengeTimesCallBack, []);
            return;
        }// end function

        private function openSuperSportCallBack() : void
        {
            this.openData = _ctrl.superSport.openSuperSport;
            this._myRank = this.openData.mainData.myRank;
            this.topRank = this._myRank;
            loadAssets("SuperSport", this.renderShow, SuperSportViewLang.LoadAssets);
            return;
        }// end function

        public function getChallengeListCallBack() : void
        {
            var _loc_1:* = _ctrl.superSport.challengeList;
            this._superSport.getChallengePersonList = _loc_1;
            return;
        }// end function

        public function startChallengeCallBack() : void
        {
            var warData:WarData;
            var data:* = _ctrl.superSport.startChallenge;
            if (data.result == Mod_SuperSport_Base.SUCCESS)
            {
                this._superSport.getClearTimer = data.cdTimer;
                this._superSport.getChallengeNum = data.remain;
                _view.superSportWar.detail = {attackerLevel:this._ctrl.player.level, attackerRank:this._myRank, defenderLevel:this._challengePersonData.level, defenderRank:this._challengePersonData.rank};
                _view.superSportWar.awardCoin = data["awardCoin"];
                _view.superSportWar.awardFame = data["awardFame"];
                warData = new WarData();
                warData.format(data["warData"]);
                _view.superSportWar.warData = warData;
                _view.superSportWar.reportId = data["reportId"];
                this._isStartWar = true;
                _view.superSportWar.onClose = function (param1:Boolean) : void
            {
                _isStartWar = false;
                startChallenge = false;
                _view.toolbar.saveNotifyGlobal();
                if (_isUpDataRank)
                {
                    get_challenge_list();
                }
                if (param1 == false)
                {
                    _view.missionFailedTips.showSport();
                }
                _superSport.getNewSportWarReport = _newSportWrReport;
                return;
            }// end function
            ;
                _view.superSportWar.show();
                this._view.toolbar.superSportChallengeCount = data["remain"];
                this._view.toolbar.superSportCdTime = data["cdTimer"];
                this._view.toolbar.renderSuperSportTip(Math.ceil(data["cdTimer"] / 60));
                _view.gameHelper.loader_first_info();
            }
            else
            {
                _view.superSportWar.opened = false;
                this.startChallenge = false;
                this.showResult(data);
            }
            return;
        }// end function

        public function clearCdTimeCallBack() : void
        {
            var _loc_1:* = _ctrl.superSport.clearCdTime;
            if (_loc_1.result == Mod_SuperSport_Base.SUCCESS)
            {
                if (this._superSport != null)
                {
                    this._superSport.getClearTimer = 0;
                    if (this._battleData.isBattle)
                    {
                        this.start_challenge(this._battleData.rank);
                        this._battleData.isBattle = false;
                    }
                }
                this.get_challenge_times();
            }
            else
            {
                this.showResult(_loc_1);
            }
            return;
        }// end function

        public function buyChallengeTimesCallBack() : void
        {
            var _loc_1:* = _ctrl.superSport.buyChallengeTimes;
            if (_loc_1.result == Mod_SuperSport_Base.SUCCESS)
            {
                this._superSport.getBuyChallengeData = _loc_1;
                _view.gameHelper.loader_first_info();
                this._view.toolbar.superSportChallengeCount = _loc_1["remainChallengeTimes"];
            }
            else
            {
                this.showResult(_loc_1);
            }
            return;
        }// end function

        public function newSportWarReportTimesCallBack() : void
        {
            this._newSportWrReport = _ctrl.superSport.newSportWarReport;
            this._isUpDataRank = this._myRank != this._newSportWrReport.myRank;
            if (!this._isStartWar)
            {
                if (this._myRank != this._newSportWrReport.myRank)
                {
                    this.get_challenge_list();
                }
                this._superSport.getNewSportWarReport = this._newSportWrReport;
            }
            this._myRank = this._newSportWrReport.myRank;
            this.topRank = this._myRank;
            return;
        }// end function

        public function notifyCallBack() : void
        {
            var _loc_1:* = _ctrl.superSport.getNotify;
            if (_loc_1.msg == 0)
            {
                _view.showTip(SuperSportViewLang.StartAward);
                this._superSport.getAwardTimer(_loc_1.getAwardTime, _loc_1.msg);
            }
            else
            {
                _view.showTip(SuperSportViewLang.StartAward);
                this._superSport.isShowGetAwardBtn = true;
                this._superSport.getAwardTimer(_loc_1.awardTime, _loc_1.msg);
            }
            return;
        }// end function

        public function getPlayerWarReportCallBack() : void
        {
            return;
        }// end function

        public function updateWinTopCallBack() : void
        {
            var _loc_1:* = _ctrl.superSport.updateWinTop;
            return;
        }// end function

        public function getRankingTopCallBack() : void
        {
            var _loc_1:* = _ctrl.superSport.rankingTop;
            this._superSport.getHeroBoxList = _loc_1;
            return;
        }// end function

        public function globalCallBack() : void
        {
            var _loc_1:* = _ctrl.superSport.notifyGlobal;
            if (_loc_1.type != Mod_SuperSport_Base.AWARD_TOP)
            {
                if (_loc_1.type == Mod_SuperSport_Base.WIN_TOP)
                {
                    if (_loc_1.winTimesTop >= 5)
                    {
                        this.changeNotife(_loc_1.info);
                    }
                }
                else if (_loc_1.type == Mod_SuperSport_Base.KILL_WIN_TOP)
                {
                    if (_loc_1.timesTop >= 5)
                    {
                        this.changeNotife(_loc_1.info);
                    }
                }
                else
                {
                    this.changeNotife(_loc_1.info);
                }
            }
            _view.toolbar.patchNotifyGlobal();
            return;
        }// end function

        public function changeNotife(param1:String) : void
        {
            if (this.inStage)
            {
                this._superSport.getWinCountData = param1;
            }
            return;
        }// end function

        private function showResult(param1:Object) : void
        {
            switch(param1.result)
            {
                case Mod_SuperSport_Base.INVALID_RANKING:
                {
                    this.get_challenge_list();
                    _view.showTip(SuperSportViewLang.InvalidRanking);
                    break;
                }
                case Mod_SuperSport_Base.NOT_ENOUGH_CHALLENGE_TIMES:
                {
                    _view.showTip(SuperSportViewLang.NotEnoughChallengeTimes);
                    break;
                }
                case Mod_SuperSport_Base.HAVE_CD_TIME:
                {
                    _view.showTip(SuperSportViewLang.HaveCdTime);
                    break;
                }
                case Mod_SuperSport_Base.NOT_IN_CHALLENGE_TIME:
                {
                    _view.showTip(SuperSportViewLang.NotInChallengeTime);
                    break;
                }
                case Mod_SuperSport_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(SuperSportViewLang.NotEnoughIngot);
                    break;
                }
                case Mod_SuperSport_Base.FULL_BUY_TIMES:
                {
                    _view.showTip(SuperSportViewLang.FullBuyTimes);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getCdTimeCallBack() : void
        {
            var _loc_1:* = this._ctrl.superSport.getCdTime;
            this._view.toolbar.superSportCdTime = _loc_1["cd_time"];
            this._view.toolbar.renderSuperSport(this._view.toolbar.superSportCdTime);
            this._view.toolbar.renderSuperSportTip(Math.ceil(this._view.toolbar.superSportCdTime / 60));
            return;
        }// end function

        private function getChallengeTimesCallBack() : void
        {
            var _loc_1:* = this._ctrl.superSport.getChallengeTimes;
            this._view.toolbar.superSportChallengeCount = _loc_1["left_times"];
            this.get_cd_time();
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        public function show() : void
        {
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.multiMission.inStageWithTip)
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
            if (_view.worldBossMap.inStageWithTip)
            {
                return;
            }
            if (_view.missionMap.inStageWithTip)
            {
                return;
            }
            _view.closeEvent();
            _view.screen.stopPlayerRun();
            this.open_super_sport();
            return;
        }// end function

        public function render(param1:Array) : void
        {
            var list:* = param1;
            this._superSport = _view.getAssetsObject("SuperSport", "SuperSport") as ISuperSport;
            _popup.addView(this, this._superSport.content);
            this._superSport.tip = _view.tip.iTip;
            this._superSport.drag = _view.drag.iDrag;
            this.notify_global();
            this._superSport.loaderMap = this.renderUrl(list);
            this._superSport.isVip4 = VIPType.check(VIPType.Level1);
            this._superSport.getPlayerData = this.openData.mainData;
            this._superSport.getChallengePersonList = this.openData.challengePersonList;
            this._superSport.getSportReportList = this.openData.sportReportList;
            this._superSport.getBuyChallengeData = this.openData.ChallengeNum;
            this._superSport.getNoticeData = this.openData.awardInfo;
            this._superSport.getClearTimer = this.openData.cdTimer;
            this._superSport.getAwardTimer(this.openData.openTimer, 0);
            this._superSport.renderIngot = _ctrl.player.ingot;
            this._superSport.renderCoins = _ctrl.player.coins;
            this._superSport.isOpenFate = FunctionType.isOpened(FunctionType.Fate);
            this._superSport.isOpenSealSoul = FunctionType.isOpened(FunctionType.SealSoul);
            this.notify_new_sport_war_report();
            this.notify();
            this.notify_update_win_top();
            this._superSport.onAddChallenge = function (param1:int, param2:int) : void
            {
                var callback:Function;
                var value:* = param1;
                var remainBuyTimes:* = param2;
                if (_view.vipEnabled == false)
                {
                    return;
                }
                if (_view.ingotEnough(value) == false)
                {
                    return;
                }
                if (remainBuyTimes > 0)
                {
                    if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.AddChallenge))
                    {
                        dialog.yesLabel = SuperSportViewLang.Sure;
                        dialog.cancelLabel = SuperSportViewLang.Cancel;
                        dialog.hasCheckbox = true;
                        callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        buy_challenge_times();
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.AddChallenge, true);
                    }
                    return;
                }// end function
                ;
                        dialog.show(Lang.sprintf(SuperSportViewLang.AddChallenge, HtmlText.yellow(value + SuperSportViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                    }
                    else
                    {
                        buy_challenge_times();
                    }
                }
                else
                {
                    _view.showTip(SuperSportViewLang.CantAddChallenge);
                }
                return;
            }// end function
            ;
            this._superSport.onClearCdTimer = this.clearCdTimer;
            this._superSport.onChallengePerson = function (param1:Object, param2:int, param3:int) : void
            {
                var callback:Function;
                var data:* = param1;
                var cdTimer:* = param2;
                var remainBuyTimes:* = param3;
                _challengePersonData = data;
                if (remainBuyTimes <= 0)
                {
                    _view.showTip(SuperSportViewLang.RemainBuyTimes);
                    return;
                }
                if (_view.vipEnabled == false && cdTimer > 0)
                {
                    _view.showTip(SuperSportViewLang.ButtleCd);
                    return;
                }
                if (cdTimer > 0)
                {
                    if (_view.ingotEnough(cdTimer) == false)
                    {
                        return;
                    }
                    if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.SportClearCd))
                    {
                        dialog.yesLabel = SuperSportViewLang.Sure;
                        dialog.cancelLabel = SuperSportViewLang.Cancel;
                        dialog.hasCheckbox = true;
                        callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        clear_cd_time();
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.SportClearCd, true);
                    }
                    return;
                }// end function
                ;
                        dialog.show(Lang.sprintf(SuperSportViewLang.ClearCdTimer, HtmlText.yellow(cdTimer + SuperSportViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                    }
                    else
                    {
                        clear_cd_time();
                    }
                    _battleData.isBattle = true;
                    _battleData.rank = data.rank;
                    return;
                }
                start_challenge(data.rank);
                return;
            }// end function
            ;
            this._superSport.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._superSport.onGetAwardClick = function () : void
            {
                _superSport.isShowGetAwardBtn = false;
                _view.activities.onStartActivity({type:ActivityType.Gift4});
                return;
            }// end function
            ;
            this._superSport.onCharacter = _view.roleMsg.switchSelf;
            this._superSport.onPack = _view.pack.switchSelf;
            this._superSport.onUpgrade = _view.upgrade.switchSelf;
            this._superSport.onResearch = _view.research.switchSelf;
            this._superSport.onDeploy = _view.superDeploy.switchSelf;
            this._superSport.onFate = _view.fate.switchSelf;
            this._superSport.onSealSoul = _view.sealSoul.switchSelf;
            this._superSport.onTextLink = function (event:TextEvent) : void
            {
                var list:Array;
                var e:* = event;
                list = e.text.split("&_");
                switch(list[0])
                {
                    case TextLinkType.ViewReport:
                    {
                        if (_isBatton)
                        {
                            return;
                        }
                        _isBatton = true;
                        _view.strategyWar.warType = WarType.SuperSportWar;
                        _view.strategyWar.reportId = list[1];
                        _view.strategyWar.nickName = list[2];
                        _view.strategyWar.version = list[3];
                        _view.strategyWar.onSendChat = function (param1:String, param2:String) : void
                {
                    var _loc_4:int = 0;
                    var _loc_3:* = _view.strategyWar.reportArgs;
                    if (_loc_3.length > 0)
                    {
                        _loc_3.unshift(ChatMsgType.WarReport, param1, param2);
                        _loc_4 = list[4];
                        _loc_3.push(_loc_4);
                        _view.chat.showMsg(_loc_3);
                    }
                    return;
                }// end function
                ;
                        _view.strategyWar.onClose = function () : void
                {
                    _isBatton = false;
                    return;
                }// end function
                ;
                        _view.strategyWar.show();
                        break;
                    }
                    case TextLinkType.CopyReport:
                    {
                        _view.strategyWar.warType = WarType.SuperSportWar;
                        _view.strategyWar.reportId = list[1];
                        _view.strategyWar.nickName = list[2];
                        _view.strategyWar.version = list[3];
                        Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, _view.strategyWar.reportUrl);
                        break;
                    }
                    default:
                    {
                        _view.toolbar.onTextLink(e);
                        break;
                    }
                }
                return;
            }// end function
            ;
            this._superSport.onAwardCount = function () : void
            {
                get_ranking_top();
                return;
            }// end function
            ;
            this._superSport.onSendFlower = function (param1:Object) : void
            {
                _view.sendFlower.sendPlayerID = param1.id;
                _view.sendFlower.show();
                return;
            }// end function
            ;
            this._superSport.onCheckHero = function (param1:Object) : void
            {
                if (param1.id == _ctrl.player.playerId)
                {
                    return;
                }
                _view.otherRoleMsg.init(param1.id, param1.name);
                _view.otherRoleMsg.show();
                return;
            }// end function
            ;
            this._superSport.onAddFriend = function (param1:Object) : void
            {
                if (param1.id == _ctrl.player.playerId)
                {
                    return;
                }
                _view.friendList.addFriend(param1.name);
                return;
            }// end function
            ;
            this.reposition();
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (inStage == false)
            {
                return;
            }
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                this._superSport.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

        public function onClearCdTimer(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.clear_cd_time();
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

        public function onAddChallenge(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.buy_challenge_times();
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
            if (inStage)
            {
                this._superSport.renderIngot = param1;
            }
            return;
        }// end function

        public function set renderCoins(param1:Number) : void
        {
            if (inStage)
            {
                this._superSport.renderCoins = param1;
            }
            return;
        }// end function

        public function clear() : void
        {
            this._superSport.clear();
            this._superSport = null;
            this.startChallenge = false;
            return;
        }// end function

        public function close() : void
        {
            this._isBatton = false;
            this.clear();
            this.close_super_sport();
            _data.cancelPatch(Mod_SuperSport_Base.notify_new_sport_war_report);
            _data.cancelPatch(Mod_SuperSport_Base.notify);
            _data.cancelPatch(Mod_SuperSport_Base.notify_update_win_top);
            _popup.closeView(this);
            _view.openEvent();
            return;
        }// end function

        public function clearCdTimer(param1:int) : void
        {
            var callback:Function;
            var value:* = param1;
            if (_view.vipEnabled == false || _view.ingotEnough(value) == false)
            {
                return;
            }
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.SportClearCd))
            {
                this.dialog.yesLabel = SuperSportViewLang.Sure;
                this.dialog.cancelLabel = SuperSportViewLang.Cancel;
                this.dialog.hasCheckbox = true;
                callback = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    clear_cd_time();
                }
                if (dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.SportClearCd, true);
                }
                return;
            }// end function
            ;
                this.dialog.show(Lang.sprintf(SuperSportViewLang.ClearCdTimer, HtmlText.yellow(value + SuperSportViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
            }
            else
            {
                this.clear_cd_time();
            }
            this._battleData.isBattle = false;
            return;
        }// end function

        private function renderShow() : void
        {
            if (this._isLoaded)
            {
                this.render([]);
            }
            else
            {
                this.getPlayerUrl();
                this.loadSportPlayer();
            }
            this._isLoaded = true;
            return;
        }// end function

        private function loadSportPlayer() : void
        {
            File.loadList(this._sportPlayerList, this.render);
            return;
        }// end function

        private function getPlayerUrl() : void
        {
            this._sportPlayerList = [];
            var _loc_1:* = _view.ctrl.player.mainRoleId;
            this._playerSign = RoleType.getRoleSign(_loc_1);
            var _loc_2:* = URI.sportIconUrl + this._playerSign + ".swf";
            this._sportPlayerList.push(_loc_2);
            return;
        }// end function

        private function renderUrl(param1:Array) : Object
        {
            var _loc_4:Object = null;
            this._playerData = {};
            var _loc_2:* = this._playerList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._playerList[_loc_3];
                if (_loc_4.sign == this._playerSign)
                {
                    this._playerData = _loc_4;
                    if (param1.length <= 0)
                    {
                        this._playerData.loader = this._loader;
                    }
                    else
                    {
                        this._loader = param1[0].loader;
                        this._playerData.loader = param1[0].loader;
                    }
                    return this._playerData;
                }
                _loc_3++;
            }
            return {};
        }// end function

    }
}
