package com.controllers
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.toolbar.*;
    import com.datas.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class SuperSportController extends Base
    {
        public var ownData:SuperSportData;
        private var _numData:Object;
        private var winData:Object;
        private var winLastData:Object;

        public function SuperSportController()
        {
            this._numData = {0:SuperSportControllerLang.One, 1:SuperSportControllerLang.Two, 2:SuperSportControllerLang.Three, 3:SuperSportControllerLang.Four, 4:SuperSportControllerLang.Five};
            this.winData = {5:SuperSportControllerLang.WinInfo1, 6:SuperSportControllerLang.WinInfo1, 7:SuperSportControllerLang.WinInfo1, 8:SuperSportControllerLang.WinInfo2, 9:SuperSportControllerLang.WinInfo2, 10:SuperSportControllerLang.WinInfo2, 11:SuperSportControllerLang.WinInfo3, 12:SuperSportControllerLang.WinInfo3, 13:SuperSportControllerLang.WinInfo3, 14:SuperSportControllerLang.WinInfo4, 15:SuperSportControllerLang.WinInfo4, 16:SuperSportControllerLang.WinInfo4, 17:SuperSportControllerLang.WinInfo5, 18:SuperSportControllerLang.WinInfo5, 19:SuperSportControllerLang.WinInfo5, 20:SuperSportControllerLang.WinInfo6, 21:SuperSportControllerLang.WinInfo6, 22:SuperSportControllerLang.WinInfo6, 23:SuperSportControllerLang.WinInfo7, 24:SuperSportControllerLang.WinInfo7, 25:SuperSportControllerLang.WinInfo7, 26:SuperSportControllerLang.WinInfo8, 27:SuperSportControllerLang.WinInfo8, 28:SuperSportControllerLang.WinInfo8, 29:SuperSportControllerLang.WinInfo9, 30:SuperSportControllerLang.WinInfo9, 31:SuperSportControllerLang.WinInfo9};
            this.winLastData = {5:"", 6:"", 7:"", 8:"", 9:"", 10:"", 11:"", 12:"", 13:"", 14:"", 15:"", 16:"", 17:"", 18:"", 19:"", 20:"", 21:"", 22:"", 23:SuperSportControllerLang.WinLast1, 24:SuperSportControllerLang.WinLast1, 25:SuperSportControllerLang.WinLast1, 26:SuperSportControllerLang.WinLast2, 27:SuperSportControllerLang.WinLast2, 28:SuperSportControllerLang.WinLast2, 29:SuperSportControllerLang.WinLast3, 30:SuperSportControllerLang.WinLast3, 31:SuperSportControllerLang.WinLast3};
            return;
        }// end function

        public function get openSuperSport() : Object
        {
            var _loc_1:* = _data.player.playerId;
            var _loc_2:* = _data.SuperSport.openSuperSport;
            var _loc_3:Object = {};
            _loc_3.mainData = {};
            _loc_3.ChallengeNum = {};
            _loc_3.awardInfo = {};
            _loc_3.challengePersonList = [];
            _loc_3.sportReportList = [];
            _loc_3.winCountData = {};
            _loc_3.mainData.myRank = _loc_2[0];
            _loc_3.mainData.name = _data.player.nickname;
            _loc_3.mainData.winCount = _loc_2[1];
            _loc_3.mainData.fame = _loc_2[2];
            _loc_3.mainData.fameName = FameLevel.getFameName(_loc_2[3]);
            _loc_3.ChallengeNum.remainChallengeTimes = _loc_2[4];
            _loc_3.ChallengeNum.remainBuyTimes = _loc_2[5];
            _loc_3.ChallengeNum.nextBuyPrice = _loc_2[6];
            _loc_3.awardInfo.awardCoin = _loc_2[7];
            _loc_3.awardInfo.awardFame = _loc_2[8];
            var _loc_4:* = _ctrl.player.serverTime;
            _loc_3.awardInfo.awardTime = _loc_2[9] - _loc_4;
            _loc_3.openTimer = _loc_2[10] - _loc_4;
            _loc_3.cdTimer = _loc_2[11];
            _loc_3.challengePersonList = this.renderChallengePersonList(_loc_2[12]);
            _loc_3.sportReportList = this.renderSportReportList(_loc_2[13]);
            _loc_3.winCountData.winId = _loc_2[14];
            _loc_3.winCountData.winName = _loc_2[15];
            _loc_3.winCountData.winTimesTop = _loc_2[16];
            return _loc_3;
        }// end function

        private function renderChallengePersonList(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = {};
                _loc_5.rank = param1[_loc_4][0];
                _loc_5.playerId = param1[_loc_4][1];
                _loc_5.roleId = param1[_loc_4][2];
                _loc_5.sign = RoleType.getRoleSign(_loc_5.roleId);
                _loc_5.url = URI.getRoleIconUrl(_loc_5.sign);
                _loc_5.level = param1[_loc_4][3];
                _loc_5.name = param1[_loc_4][4];
                _loc_5.showName = _ctrl.player.removeNickNameSuffix(_loc_5.name);
                _loc_5.awardCoin = param1[_loc_4][5];
                _loc_5.awardFame = param1[_loc_4][6];
                _loc_5.liveX = 0;
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        private function renderSportReportList(param1:Array) : Array
        {
            var _loc_6:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:Array = [];
            var _loc_4:* = _ctrl.player.serverTime;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_6 = {};
                _loc_6.warReportId = param1[_loc_5][0];
                _loc_6.isRead = param1[_loc_5][1];
                _loc_6.attackPlayerId = param1[_loc_5][2];
                _loc_6.showAttackPlayerName = "";
                _loc_6.isYou = false;
                if (_loc_6.attackPlayerId == _data.player.playerId)
                {
                    _loc_6.isYou = true;
                    _loc_6.attackPlayerName = SuperSportControllerLang.You;
                }
                else
                {
                    _loc_6.attackPlayerName = param1[_loc_5][3];
                    _loc_6.showAttackPlayerName = _ctrl.player.removeNickNameSuffix(_loc_6.attackPlayerName);
                }
                _loc_6.defensePlayerId = param1[_loc_5][4];
                _loc_6.defensePlayerName = "";
                _loc_6.isDefenseYou = false;
                if (_loc_6.defensePlayerId == _data.player.playerId)
                {
                    _loc_6.isDefenseYou = true;
                    _loc_6.defensePlayerName = SuperSportControllerLang.You;
                }
                else
                {
                    _loc_6.defensePlayerName = param1[_loc_5][5];
                    _loc_6.showDefensePlayerName = _ctrl.player.removeNickNameSuffix(_loc_6.defensePlayerName);
                }
                _loc_6.winPlayerId = param1[_loc_5][6];
                _loc_6.oldRank = param1[_loc_5][7];
                _loc_6.newRank = param1[_loc_5][8];
                _loc_6.version = param1[_loc_5][9];
                _loc_6.reportTimer = TimeChange.timerInfo(param1[_loc_5][10], _loc_4, SuperSportControllerLang.Just);
                if (_loc_6.oldRank > _loc_6.newRank)
                {
                    _loc_6.isRunkUp = 0;
                }
                if (_loc_6.oldRank < _loc_6.newRank)
                {
                    _loc_6.isRunkUp = 1;
                }
                if (_loc_6.oldRank == _loc_6.newRank)
                {
                    _loc_6.isRunkUp = 2;
                }
                _loc_6.isWin = _loc_6.winPlayerId == _data.player.playerId;
                _loc_3.push(_loc_6);
                _loc_5++;
            }
            return _loc_3;
        }// end function

        public function get challengeList() : Array
        {
            var _loc_1:* = _data.SuperSport.challengeList;
            var _loc_2:* = this.renderChallengePersonList(_loc_1[0]);
            return _loc_2;
        }// end function

        public function get startChallenge() : Object
        {
            var _loc_3:Array = null;
            var _loc_1:* = _data.SuperSport.startChallenge;
            var _loc_2:Object = {};
            _loc_2.result = _loc_1[0];
            _loc_2.msg = _loc_1[0];
            _loc_2.remain = _loc_1[1];
            _loc_2.cdTimer = _loc_1[2];
            if (_loc_2.result == Mod_SuperSport_Base.SUCCESS)
            {
                _loc_3 = _loc_1[3][0];
                _loc_2.awardFame = _loc_3[0];
                _loc_2.awardCoin = _loc_3[1];
                _loc_2.reportId = _loc_3[2];
                _loc_2.warData = [0, 0, 0, [_loc_3[3][0]]];
            }
            return _loc_2;
        }// end function

        public function get clearCdTime() : Object
        {
            var _loc_1:* = _data.SuperSport.clearCdTime;
            var _loc_2:Object = {};
            _loc_2.result = _loc_1[0];
            return _loc_2;
        }// end function

        public function get buyChallengeTimes() : Object
        {
            var _loc_1:* = _data.SuperSport.buyChallengeTimes;
            var _loc_2:Object = {};
            _loc_2.result = _loc_1[0];
            _loc_2.remainBuyTimes = _loc_1[1];
            _loc_2.nextBuyPrice = _loc_1[2];
            _loc_2.remainChallengeTimes = _loc_1[3];
            return _loc_2;
        }// end function

        public function get newSportWarReport() : Object
        {
            var _loc_1:* = _data.SuperSport.newSportWarReport;
            var _loc_2:Object = {};
            _loc_2.myRank = _loc_1[0];
            _loc_2.awardCoin = _loc_1[1];
            _loc_2.awardFame = _loc_1[2];
            _loc_2.winCount = _loc_1[3];
            _loc_2.fame = _loc_1[4];
            _loc_2.fameLevel = _loc_1[5];
            _loc_2.fameName = FameLevel.getFameName(_loc_2.fameLevel);
            var _loc_3:Array = [];
            _loc_3 = _loc_1;
            _loc_3.shift();
            _loc_3.shift();
            _loc_3.shift();
            _loc_3.shift();
            _loc_3.shift();
            _loc_3.shift();
            var _loc_4:* = this.renderSportReportList([_loc_3]);
            _loc_2.sportReport = _loc_4[0];
            return _loc_2;
        }// end function

        public function get getNotify() : Object
        {
            var _loc_1:* = _data.SuperSport.getNotify;
            var _loc_2:Object = {};
            _loc_2.notifyType = _loc_1[0];
            if (_loc_2.notifyType == Mod_SuperSport_Base.START_AWARD)
            {
                _loc_2.msg = 0;
            }
            if (_loc_2.notifyType == Mod_SuperSport_Base.END_AWARD)
            {
                _loc_2.msg = 1;
            }
            var _loc_3:* = _ctrl.player.serverTime;
            _loc_2.awardTime = _loc_1[1] - _loc_3;
            _loc_2.getAwardTime = _loc_1[2] - _loc_3;
            return _loc_2;
        }// end function

        public function get closeSuperSport() : Array
        {
            return [];
        }// end function

        public function get playerWarReport() : Array
        {
            return [];
        }// end function

        public function get rankingTop() : Array
        {
            var _loc_5:Object = null;
            var _loc_1:* = _data.SuperSport.rankingTop;
            var _loc_2:Array = [];
            var _loc_3:* = _loc_1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.rank = _loc_1[_loc_4][0];
                _loc_5.lastRank = _loc_1[_loc_4][1];
                if (_loc_5.rank > _loc_5.lastRank)
                {
                    _loc_5.isUp = 0;
                }
                if (_loc_5.rank < _loc_5.lastRank)
                {
                    _loc_5.isUp = 1;
                }
                if (_loc_5.rank == _loc_5.lastRank)
                {
                    _loc_5.isUp = 2;
                }
                _loc_5.id = _loc_1[_loc_4][2];
                _loc_5.name = _loc_1[_loc_4][3];
                _loc_5.showName = _ctrl.player.removeNickNameSuffix(_loc_5.name);
                _loc_5.level = _loc_1[_loc_4][4];
                _loc_5.power = _loc_1[_loc_4][5];
                _loc_5.isOnline = _loc_1[_loc_4][6];
                _loc_5.sex = RoleType.getRoleGender(_loc_1[_loc_4][7]);
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get updateWinTop() : Object
        {
            var _loc_1:* = _data.SuperSport.updateWinTop;
            var _loc_2:Object = {};
            _loc_2.winId = _loc_1[0];
            _loc_2.winName = _loc_1[1];
            _loc_2.winTimesTop = _loc_1[2];
            return _loc_2;
        }// end function

        public function get notifyGlobal() : Object
        {
            var _loc_1:* = _data.SuperSport.notifyGlobal;
            var _loc_2:Object = {};
            _loc_2.type = _loc_1[0];
            switch(_loc_2.type)
            {
                case Mod_SuperSport_Base.WIN_TOP:
                {
                    _loc_2.winId = _loc_1[1][0][0];
                    _loc_2.winName = _loc_1[1][0][1];
                    _loc_2.showWinName = _ctrl.player.removeNickNameSuffix(_loc_2.winName);
                    _loc_2.winTimesTop = _loc_1[1][0][2];
                    this.getWinCountData(_loc_2);
                    break;
                }
                case Mod_SuperSport_Base.KILL_WIN_TOP:
                {
                    _loc_2.killPlayerId = _loc_1[2][0][0];
                    _loc_2.killNickname = _loc_1[2][0][1];
                    _loc_2.showKillNickname = _ctrl.player.removeNickNameSuffix(_loc_2.killNickname);
                    _loc_2.topPlayerId = _loc_1[2][0][2];
                    _loc_2.topNickName = _loc_1[2][0][3];
                    _loc_2.showTopNickName = _ctrl.player.removeNickNameSuffix(_loc_2.topNickName);
                    _loc_2.timesTop = _loc_1[2][0][4];
                    this.killWinTop(_loc_2);
                    break;
                }
                case Mod_SuperSport_Base.RANKING_TOP:
                {
                    _loc_2.playerId = _loc_1[3][0][0];
                    _loc_2.playerNickname = _loc_1[3][0][1];
                    _loc_2.oldPlayerId = _loc_1[3][0][2];
                    _loc_2.oldPlayerNickname = _loc_1[3][0][3];
                    this.rankInfTop(_loc_2);
                    break;
                }
                case Mod_SuperSport_Base.UPDATE_RANKING_TOP:
                {
                    _loc_2.playerId = _loc_1[4][0][0];
                    _loc_2.nickName = _loc_1[4][0][1];
                    _loc_2.updateRanking = _loc_1[4][0][2];
                    this.updateRankIngTop(_loc_2);
                    break;
                }
                case Mod_SuperSport_Base.AWARD_TOP:
                {
                    _loc_2.awardTop = this.renderAwardTop(_loc_1[5], _loc_2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function get getCdTime() : Object
        {
            var _loc_1:Object = {cd_time:_data.SuperSport.getCdTime[0]};
            return _loc_1;
        }// end function

        public function get getChallengeTimes() : Object
        {
            var _loc_1:Object = {left_times:_data.SuperSport.getChallengeTimes[0]};
            return _loc_1;
        }// end function

        private function renderAwardTop(param1:Array, param2:Object) : Array
        {
            var _loc_6:Object = null;
            var _loc_3:* = param1.length;
            var _loc_4:Array = [];
            param2.info = "<font color=\"#fff200\">" + SuperSportControllerLang.Notice + "</font>" + "<font color=\"#ffffff\">" + SuperSportControllerLang.AwardTop + "</font>";
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = {};
                _loc_6.ranking = param1[_loc_5][0];
                _loc_6.playerId = param1[_loc_5][1];
                _loc_6.nickName = param1[_loc_5][2];
                _loc_6.showName = _ctrl.player.removeNickNameSuffix(_loc_6.nickName);
                _loc_6.awardCoin = param1[_loc_5][3];
                _loc_6.awardFame = param1[_loc_5][4];
                param2.info = param2.info + ("\n" + "<font color=\"#ffffff\">" + Lang.sprintf(SuperSportControllerLang.Rank, this._numData[_loc_5]) + ":</font>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + _loc_6.playerId + "_" + _loc_6.nickName + "\">" + _loc_6.showName + "</a>" + "</u>" + "</font>" + "<font color=\"#ffffff\"> " + _loc_6.awardCoin + SuperSportControllerLang.Coin + "</font>" + "<font color=\"#ffffff\"> " + _loc_6.awardFame + SuperSportControllerLang.Fram + "</font>");
                _loc_4.push(_loc_6);
                _loc_5++;
            }
            return _loc_4;
        }// end function

        private function getWinCountData(param1:Object) : void
        {
            var _loc_2:* = param1.winTimesTop;
            var _loc_3:String = "";
            if (_loc_2 > 13)
            {
                _loc_2 = 13;
            }
            param1.info = "<b>" + "<font color=\"#fff200\"><u><a href=\"event:" + TextLinkType.Player + "_" + param1.winId + "_" + param1.winName + "\">" + param1.showWinName + "</a></u></font>" + "<font color=\"#ffffff\">" + Lang.sprintf(SuperSportControllerLang.WinCount1, this.winData[_loc_2], param1.winTimesTop, this.winLastData[_loc_2]) + "</font>" + "</b>";
            param1.worldInfo = "<font color=\"#fff200\"><b>" + Lang.sprintf(SuperSportControllerLang.WinCount2, param1.showWinName, this.winData[_loc_2], param1.winTimesTop, this.winLastData[_loc_2]) + "</b></font>";
            return;
        }// end function

        private function killWinTop(param1:Object) : void
        {
            param1.info = "<b>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + param1.killPlayerId + "_" + param1.killNickname + "\">" + param1.showKillNickname + "</a>" + "</u>" + "</font>" + "<font color=\"#ffffff\">" + SuperSportControllerLang.KillWin1 + "</font>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + param1.topPlayerId + "_" + param1.topNickName + "\">" + param1.showTopNickName + "</a>" + "</u>" + "</font>" + "<font color=\"#ffffff\">" + Lang.sprintf(SuperSportControllerLang.KillWin2, param1.timesTop) + "</font>" + "</b>";
            param1.worldInfo = "<font color=\"#fff200\"><b>" + Lang.sprintf(SuperSportControllerLang.KillWin3, param1.showKillNickname, param1.showTopNickName, param1.timesTop) + "</b></font>";
            return;
        }// end function

        private function rankInfTop(param1:Object) : void
        {
            if (param1.oldPlayerId == 0)
            {
                param1.info = "<b>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + param1.playerId + "_" + param1.playerNickname + "\">" + _ctrl.player.removeNickNameSuffix(param1.playerNickname) + "</a>" + "</u>" + "</font>" + "<font color=\"#ffffff\">" + SuperSportControllerLang.RankInfTop + "</font>" + "</b>";
                param1.worldInfo = "<font color=\"#fff200\"><b>" + "【" + _ctrl.player.removeNickNameSuffix(param1.playerNickname) + "】" + SuperSportControllerLang.RankInfTop + "</b></font>";
            }
            else
            {
                param1.info = "<b>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + param1.playerId + "_" + param1.playerNickname + "\">" + _ctrl.player.removeNickNameSuffix(param1.playerNickname) + "</a>" + "</u>" + "</font>" + "<font color=\"#ffffff\">" + SuperSportControllerLang.RankInfTop1 + "</font>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + param1.oldPlayerId + "_" + param1.oldPlayerNickname + "\">" + _ctrl.player.removeNickNameSuffix(param1.oldPlayerNickname) + "</a>" + "</u>" + "</font>" + "<font color=\"#ffffff\">，" + SuperSportControllerLang.RankInfTop + "</font>" + "</b>";
                param1.worldInfo = "<font color=\"#fff200\"><b>" + "【" + _ctrl.player.removeNickNameSuffix(param1.playerNickname) + "】" + SuperSportControllerLang.RankInfTop1 + "【" + _ctrl.player.removeNickNameSuffix(param1.oldPlayerNickname) + "】" + SuperSportControllerLang.RankInfTop + "</b></font>";
            }
            return;
        }// end function

        private function updateRankIngTop(param1:Object) : void
        {
            param1.info = "<b>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + param1.playerId + "_" + param1.nickName + "\">" + _ctrl.player.removeNickNameSuffix(param1.nickName) + "</a>" + "</u>" + "</font>" + "<font color=\"#ffffff\">" + Lang.sprintf(SuperSportControllerLang.updateRank, param1.updateRanking) + "</font>" + "</b>";
            param1.worldInfo = "<font color=\"#fff200\"><b>" + "【" + _ctrl.player.removeNickNameSuffix(param1.nickName) + "】" + Lang.sprintf(SuperSportControllerLang.updateRank, param1.updateRanking) + "</b></font>";
            return;
        }// end function

    }
}
