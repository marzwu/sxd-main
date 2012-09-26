package com.controllers
{
    import com.*;
    import com.assist.view.*;
    import com.assist.view.toolbar.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class TakeBibleController extends Base
    {
        public var rulaiState:int = 0;
        private var _openTakeBible:Array;
        public var callRuLaiPrice:int = 0;
        public var canCalruLaiTime:int = 0;
        private var _closeTakeBible:Array;
        private var _getTakeBibleInfo:Array;
        private var _cancelApplyFriend:Array;
        private var _buyProtection:Array;
        private var _playerTakeBible:Array;
        private var _rob:Array;
        private var _notify:Array;
        private var _notifyBeRob:Array;
        public var applyProtectList:Array;

        public function TakeBibleController()
        {
            this.applyProtectList = [];
            return;
        }// end function

        public function get openTakeBible() : Object
        {
            var _loc_2:Object = null;
            var _loc_1:* = _data.takeBible.openTakeBible;
            _loc_2 = {};
            _loc_2.protectPlayerId = _loc_1[1];
            _loc_2.classTakePlayer = this.renderClssTakePlayer(_loc_1[0]);
            _loc_2.canRobTimes = _loc_1[2];
            _loc_2.canProtectTimes = _loc_1[3];
            _loc_2.canTakeBibleTimes = _loc_1[4];
            _loc_2.quicklyTimes = _loc_1[5];
            _loc_2.bless = _loc_1[6];
            _loc_2.type = _loc_1[7];
            _loc_2.time = _loc_1[8];
            _loc_2.ruLaiPlayerAry = this.renderPlayerId(_loc_1[9]);
            _loc_2.diffTime = _ctrl.player.diffServerTime;
            _loc_2.callRuLaiPrice = _loc_1[10];
            this.callRuLaiPrice = _loc_1[10];
            _loc_2.canCalruLaiTime = _loc_1[11];
            this.canCalruLaiTime = _loc_2.canCalruLaiTime;
            _data.takeBible.canRobTimes = _loc_2.canRobTimes;
            _data.takeBible.canProtectTimes = _loc_2.canProtectTimes;
            _data.takeBible.canTakeBibleTimes = _loc_2.canTakeBibleTimes;
            _data.takeBible.quicklyTimes = _loc_2.quicklyTimes;
            return _loc_2;
        }// end function

        private function renderClssTakePlayer(param1:Array) : Array
        {
            var _loc_6:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:* = _ctrl.player.serverTime;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = {};
                _loc_6.protectPlayerId = param1[_loc_5][5];
                _loc_6.playerId = param1[_loc_5][0];
                _loc_6.isMainPlayer = _loc_6.playerId == _ctrl.player.playerId;
                _loc_6.isProtectPlayer = _loc_6.protectPlayerId == _ctrl.player.playerId;
                _loc_6.protection = param1[_loc_5][1];
                _loc_6.startTime = param1[_loc_5][2];
                _loc_6.mainTime = _loc_4;
                _loc_6.arrivalTime = param1[_loc_5][3];
                _loc_6.distance = param1[_loc_5][4];
                _loc_2.push(_loc_6);
                _loc_5++;
            }
            return _loc_2;
        }// end function

        private function renderPlayerId(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:* = new Array();
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.player_id = param1[_loc_4][0];
                _loc_5.nickname = param1[_loc_4][1];
                _loc_5.isSelf = _loc_5.player_id == _ctrl.player.playerId;
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get closeTakeBible() : Array
        {
            return this._closeTakeBible;
        }// end function

        public function get getTakeBibleInfo() : Object
        {
            var _loc_1:* = _data.takeBible.getTakeBibleInfo;
            var _loc_2:Object = {};
            _loc_2.protectionList = this.renderProtectionList(_loc_1[0]);
            _loc_2.protectPlayerList = this.renderProtectPlayerList(_loc_1[1]);
            _loc_2.takeBibleTimes = _loc_1[2];
            _loc_2.totalTakeBibleTimes = _loc_1[3];
            _loc_2.refreshPrice = _loc_1[4];
            _loc_2.takeBibleStatus = _loc_1[5];
            _loc_2.canProtection = _loc_1[6];
            _loc_2.protectPlayer = _ctrl.player.removeNickNameSuffix(_loc_1[7]);
            _loc_2.bless = _loc_1[8];
            return _loc_2;
        }// end function

        private function renderProtectionList(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.protection = param1[_loc_4][0];
                _loc_5.takeTime = param1[_loc_4][1];
                _loc_5.awardCoin = param1[_loc_4][2];
                _loc_5.awardFame = param1[_loc_4][3];
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function renderProtectPlayerList(param1:Array) : Array
        {
            var _loc_6:Object = null;
            var _loc_7:String = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_6 = {};
                _loc_6.playerId = param1[_loc_4][0];
                _loc_6.nickName = param1[_loc_4][1];
                _loc_6.showName = _ctrl.player.removeNickNameSuffix(_loc_6.nickName);
                _loc_6.remainProtectTimes = param1[_loc_4][2];
                _loc_6.totalProtectTimes = param1[_loc_4][3];
                _loc_6.protectStatus = param1[_loc_4][4];
                _loc_7 = Lang.sprintf(TakeBibleControllerLang.RemainProtectTimes, HtmlText.green(_loc_6.remainProtectTimes));
                if (_loc_6.remainProtectTimes <= 0)
                {
                    _loc_7 = TakeBibleControllerLang.ProtectTimesMax;
                }
                if (_loc_6.protectStatus == 1)
                {
                    _loc_7 = TakeBibleControllerLang.ProtectTimesMaxIng;
                }
                _loc_6.label = _loc_6.showName + " " + _loc_7;
                _loc_2.push(_loc_6);
                _loc_4++;
            }
            var _loc_5:Object = {};
            {}.playerId = 0;
            if (_loc_2.length <= 0)
            {
                _loc_5.label = TakeBibleControllerLang.NoFriendOnline;
            }
            else
            {
                _loc_5.label = TakeBibleControllerLang.Invitation;
            }
            _loc_2.unshift(_loc_5);
            return _loc_2;
        }// end function

        public function get applyFriend() : Object
        {
            var _loc_1:* = _data.takeBible.applyFriend;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get cancelApplyFriend() : Array
        {
            return this._cancelApplyFriend;
        }// end function

        public function get approveApply() : Object
        {
            var _loc_1:* = _data.takeBible.approveApply;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get rejectApply() : Object
        {
            var _loc_1:* = _data.takeBible.rejectApply;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get buyProtection() : Object
        {
            var _loc_1:* = _data.takeBible.buyProtection;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get refreshData() : Object
        {
            var _loc_1:* = _data.takeBible.refreshData;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.newProtection = _loc_1[1];
            _loc_2.nextPrice = _loc_1[2];
            return _loc_2;
        }// end function

        public function get playerTakeBible() : Array
        {
            var _loc_5:Object = null;
            var _loc_1:* = _data.takeBible.playerTakeBible;
            var _loc_2:Array = [];
            var _loc_3:* = _loc_1.length;
            var _loc_4:* = _loc_3 - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_5 = {};
                _loc_5.playerId = _loc_1[_loc_4][0];
                _loc_5.nickname = _loc_1[_loc_4][1];
                _loc_5.showName = _ctrl.player.removeNickNameSuffix(_loc_5.nickname);
                _loc_5.level = _loc_1[_loc_4][2];
                _loc_5.beRobTimes = _loc_1[_loc_4][3];
                _loc_5.totalCanRobTimes = _loc_1[_loc_4][4];
                _loc_5.protectNickname = _ctrl.player.removeNickNameSuffix(_loc_1[_loc_4][5]);
                _loc_5.robCoin = _loc_1[_loc_4][6];
                _loc_5.robFame = _loc_1[_loc_4][7];
                _loc_5.awardCoin = _loc_1[_loc_4][8];
                _loc_5.awardFame = _loc_1[_loc_4][9];
                _loc_5.isRobbed = _loc_1[_loc_4][10];
                _loc_5.factionName = _loc_1[_loc_4][11];
                if (_loc_5.factionName.length <= 0)
                {
                    _loc_5.factionName = TakeBibleControllerLang.Null;
                    _loc_5.isFaction = false;
                    _loc_5.factionColor = HtmlText.White;
                }
                else
                {
                    _loc_5.isFaction = _loc_5.factionName == _ctrl.player.factionName ? (true) : (false);
                    if (_loc_5.isFaction)
                    {
                        _loc_5.factionColor = _data.player.playerInfo.factionColor;
                    }
                    else
                    {
                        _loc_5.factionColor = HtmlText.White;
                    }
                }
                _loc_2.push(_loc_5);
                _data.takeBible.playerTakeBible.splice(_loc_4, 1);
                _loc_4 = _loc_4 - 1;
            }
            return _loc_2;
        }// end function

        public function get startTakeBible() : Object
        {
            var _loc_1:* = _data.takeBible.startTakeBible;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get robData() : Object
        {
            var _loc_1:* = _data.takeBible.robData;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.takeBiblePlayerId = _loc_1[1];
            _loc_2.takeBibleNickname = _loc_1[2];
            _loc_2.takeBibleShowname = _ctrl.player.removeNickNameSuffix(_loc_2.takeBibleNickname);
            _loc_2.robCoin = _loc_1[3];
            _loc_2.robFame = _loc_1[4];
            _loc_2.warReportId = _loc_1[5];
            _loc_2.warData = [0, 0, 0, [_loc_1[6][0]]];
            _loc_2.bless = _loc_1[7];
            _loc_2.blessInfo = HtmlText.green("+" + _loc_2.bless + TakeBibleControllerLang.PowerAndLife);
            _loc_2.info = "<font color=\"#ffcc99\">" + "<a href = \"event:" + TextLinkType.Player + "_" + _loc_2.takeBiblePlayerId + "_" + _loc_2.takeBibleNickname + "\">" + "<u>" + _loc_2.takeBibleShowname + "</u>" + "</a>" + "</font>" + "<font color=\"#ffffff\">" + TakeBibleControllerLang.GuardFriend + "</font>";
            return _loc_2;
        }// end function

        public function get notifyData() : Object
        {
            var _loc_6:int = 0;
            var _loc_7:Object = null;
            var _loc_8:Object = null;
            var _loc_1:* = _data.takeBible.notifyData;
            var _loc_2:Object = {};
            _loc_2.type = _loc_1[0];
            var _loc_3:* = _loc_1[1];
            var _loc_4:* = _loc_1[2];
            var _loc_5:* = _loc_1[4];
            switch(_loc_1[0])
            {
                case Mod_TakeBible_Base.ROB:
                {
                    if (_loc_3.length > 0)
                    {
                        _loc_2.robberPlayerId = _loc_3[0][0];
                        _loc_2.robberNickname = _loc_3[0][1];
                        _loc_2.robberShowname = _ctrl.player.removeNickNameSuffix(_loc_2.robberNickname);
                        _loc_2.beRobberPlayerId = _loc_3[0][2];
                        _loc_2.beRobberNickname = _loc_3[0][3];
                        _loc_2.beRobberShowname = _ctrl.player.removeNickNameSuffix(_loc_2.beRobberNickname);
                        _loc_2.protection = _loc_3[0][4];
                        _loc_2.robCoin = _loc_3[0][5];
                        _loc_2.robFame = _loc_3[0][6];
                        _loc_2.line = 2;
                        _loc_7 = this.protectionData(_loc_2.protection);
                        _loc_2.isMain = _loc_2.robberPlayerId == _ctrl.player.playerId;
                        _loc_2.info = "<font color=\"#ffcc99\">" + "<a href = \"event:" + TextLinkType.Player + "_" + _loc_2.robberPlayerId + "_" + _loc_2.robberNickname + "\">" + _loc_2.robberShowname + "</a>" + "</font>" + Lang.sprintf(HtmlText.white(TakeBibleControllerLang.SuccessRob), "<font color=\"#CC0000\">" + TakeBibleControllerLang.Rob + "</font>") + "<font color=\"#ffcc99\">" + "<a href = \"event:" + TextLinkType.Player + "_" + _loc_2.beRobberPlayerId + "_" + _loc_2.beRobberNickname + "\">" + _loc_2.beRobberShowname + "</a>" + "</font>" + Lang.sprintf(HtmlText.white(TakeBibleControllerLang.RobIng), "<font color=\"#" + _loc_7.color.toString(16) + "\">【" + _loc_7.name + "】</font>") + Lang.sprintf("<font color=\"#66ff00\">" + TakeBibleControllerLang.RobAward + "</font>" + "\n", _loc_2.robCoin, _loc_2.robFame);
                    }
                    break;
                }
                case Mod_TakeBible_Base.TAKE_BIBLE:
                {
                    if (_loc_4.length > 0)
                    {
                        _loc_2.playerId = _loc_4[0][0];
                        _loc_2.nickname = _loc_4[0][1];
                        _loc_2.showName = _ctrl.player.removeNickNameSuffix(_loc_2.nickname);
                        _loc_2.protection = _loc_4[0][2];
                        _loc_2.line = 1;
                        _loc_8 = this.protectionData(_loc_2.protection);
                        _loc_2.info = "<font color=\"#ffcc99\">" + "<a href = \"event:" + TextLinkType.Player + "_" + _loc_2.playerId + "_" + _loc_2.nickname + "\">" + "<u>" + _loc_2.showName + "</u>" + "</a>" + "</font>" + Lang.sprintf(HtmlText.white(TakeBibleControllerLang.TaleBible), "<font color=\"#" + _loc_8.color.toString(16) + "\">【" + _loc_8.name + "】</font>");
                    }
                    break;
                }
                case Mod_TakeBible_Base.NEW_TAKE_BIBLE:
                {
                    _loc_6 = _ctrl.player.serverTime;
                    _loc_2.classTakePlayer = this.renderClssTakePlayer(_loc_1[3]);
                    break;
                }
                case Mod_TakeBible_Base.QUICKLY:
                {
                    if (_loc_5.length > 0)
                    {
                        _loc_2.playerId = _loc_5[0][0];
                        _loc_2.arrivalTime = _loc_5[0][1];
                        _loc_2.mainTime = _ctrl.player.serverTime;
                    }
                    break;
                }
                case Mod_TakeBible_Base.ARRIVAL:
                {
                    _loc_2.playerId = _loc_1[5][0];
                    _loc_2.arrivalTime = _ctrl.player.serverTime;
                    _loc_2.mainTime = _ctrl.player.serverTime;
                    break;
                }
                case Mod_TakeBible_Base.FRIEND_APPROVE_APPLY:
                case Mod_TakeBible_Base.FRIEND_REJECT_APPLY:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function protectionData(param1:int) : Object
        {
            var _loc_2:Object = {};
            switch(param1)
            {
                case Mod_TakeBible_Base.TANG_SENG:
                {
                    _loc_2.name = TakeBibleControllerLang.TS;
                    _loc_2.color = HtmlText.Yellow;
                    _loc_2.minColor = "Y";
                    break;
                }
                case Mod_TakeBible_Base.SUN_WU_KONG:
                {
                    _loc_2.name = TakeBibleControllerLang.SWK;
                    _loc_2.color = 16711935;
                    _loc_2.minColor = "P";
                    break;
                }
                case Mod_TakeBible_Base.ZHU_BA_JIE:
                {
                    _loc_2.name = TakeBibleControllerLang.ZBJ;
                    _loc_2.color = HtmlText.Blue;
                    _loc_2.minColor = "B";
                    break;
                }
                case Mod_TakeBible_Base.SHA_WU_JING:
                {
                    _loc_2.name = TakeBibleControllerLang.SWJ;
                    _loc_2.color = HtmlText.Green;
                    _loc_2.minColor = "G";
                    break;
                }
                case Mod_TakeBible_Base.BAI_LONG_MA:
                {
                    _loc_2.name = TakeBibleControllerLang.BLM;
                    _loc_2.color = HtmlText.White;
                    _loc_2.minColor = "W";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function get notifyGlobal() : Object
        {
            var _loc_7:Object = null;
            var _loc_1:* = _data.takeBible.notifyGlobal;
            var _loc_2:Object = {};
            _loc_2.type = _loc_1[0];
            var _loc_3:* = _loc_1[1];
            var _loc_4:* = _loc_1[2];
            var _loc_5:* = _loc_1[3];
            var _loc_6:* = _loc_1[4];
            switch(_loc_2.type)
            {
                case Mod_TakeBible_Base.BEROB:
                {
                    if (_loc_3.length > 0)
                    {
                        _loc_2.robberNickname = _loc_3[0][0];
                        _loc_2.robberShowName = _ctrl.player.removeNickNameSuffix(_loc_2.robberNickname);
                        _loc_2.reportId = _loc_3[0][1];
                    }
                    break;
                }
                case Mod_TakeBible_Base.PROTECT_BEROB:
                {
                    if (_loc_4.length > 0)
                    {
                        _loc_2.robberNickname = _loc_4[0][0];
                        _loc_2.protectNickname = _loc_4[0][1];
                        _loc_2.robberShowName = _ctrl.player.removeNickNameSuffix(_loc_2.robberNickname);
                        _loc_2.protectShowName = _ctrl.player.removeNickNameSuffix(_loc_2.protectNickname);
                        _loc_2.reportId = _loc_4[0][2];
                    }
                    break;
                }
                case Mod_TakeBible_Base.APPLY_PROTECT:
                {
                    if (_loc_5.length > 0)
                    {
                        _loc_2.playerId = _loc_5[0][0];
                        _loc_2.playerNickname = _loc_5[0][1];
                        _loc_2.playerShowName = _ctrl.player.removeNickNameSuffix(_loc_2.playerNickname);
                        _loc_2.protectNpc = _loc_5[0][2];
                        _loc_2.protectAwardFame = _loc_5[0][3];
                        _loc_7 = this.protectionData(_loc_2.protectNpc);
                        _loc_2.protectName = "<" + _loc_7.name + "&" + _loc_7.minColor + ">";
                        this.applyProtectList.push(_loc_2);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function removeApplyProtect(param1:int) : void
        {
            var _loc_4:Object = null;
            var _loc_2:* = this.applyProtectList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this.applyProtectList[_loc_3];
                if (_loc_4.playerId == param1)
                {
                    this.applyProtectList.splice(_loc_3, 1);
                    return;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function get quicklyData() : Object
        {
            var _loc_1:* = _data.takeBible.quicklyData;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get takeBibleUpdataData() : Object
        {
            var _loc_1:* = _data.takeBible.takeBibleUpdataData;
            var _loc_2:Object = {};
            _loc_2.canRobTimes = _loc_1[0];
            _loc_2.canTakeBibleTimes = _loc_1[1];
            _loc_2.callRuLaiPrice = _loc_1[2];
            this.callRuLaiPrice = _loc_2.callRuLaiPrice;
            _loc_2.canCalruLaiTime = _loc_1[3];
            _data.takeBible.canRobTimes = _loc_2.canRobTimes;
            _data.takeBible.canTakeBibleTimes = _loc_2.canTakeBibleTimes;
            return _loc_2;
        }// end function

        public function get takeBibleCdTime() : Object
        {
            var _loc_1:* = _data.takeBible.takeBibleCdTime;
            var _loc_2:Object = {};
            _loc_2.cdTime = _loc_1[0];
            _loc_2.cleanIngot = _loc_1[1];
            return _loc_2;
        }// end function

        public function get clearTakeBibleCdTime() : Object
        {
            var _loc_1:* = _data.takeBible.clearTakeBibleCdTime;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get buyBless() : Object
        {
            var _loc_1:* = _data.takeBible.buyBless;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.newBless = _loc_1[1];
            return _loc_2;
        }// end function

        public function get callRulai() : int
        {
            return _data.takeBible.callRuLai[0];
        }// end function

        public function get getRulaiOpenTimeData() : Object
        {
            var _loc_7:Object = null;
            var _loc_1:* = _data.takeBible.getRulaiOpenTime;
            var _loc_2:* = _loc_1[1];
            var _loc_3:Object = {};
            _loc_3.type = _loc_1[0];
            this.rulaiState = _loc_3.type;
            _loc_3.timeList = [];
            var _loc_4:* = _loc_2.length;
            var _loc_5:Array = [];
            var _loc_6:int = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_7 = {};
                _loc_7.startTime = _loc_2[_loc_6][0];
                _loc_7.endTime = _loc_2[_loc_6][1];
                _loc_3.timeList.push(_loc_7);
                _loc_6++;
            }
            return _loc_3;
        }// end function

        public function get canRobTimes() : int
        {
            return _data.takeBible.canRobTimes;
        }// end function

        public function get canProtectTimes() : int
        {
            return _data.takeBible.canProtectTimes;
        }// end function

        public function get canTakeBibleTimes() : int
        {
            return _data.takeBible.canTakeBibleTimes;
        }// end function

        public function get quicklyTimes() : int
        {
            return _data.takeBible.quicklyTimes;
        }// end function

        public function get openCallRuLai() : Array
        {
            return _data.takeBible.openCallRuLai;
        }// end function

        public function get notifyCallRuLaiType() : int
        {
            return _data.takeBible.notifyCallRuLaiType;
        }// end function

        public function get notifyCallRuLai() : Array
        {
            return _data.takeBible.notifyCallRuLai;
        }// end function

        public function get callList() : Array
        {
            return _data.takeBible.callList;
        }// end function

    }
}
