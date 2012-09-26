package com.assist.view.info
{
    import __AS3__.vec.*;
    import com.*;
    import com.assist.view.*;
    import com.lang.client.com.assist.view.info.*;

    public class ServerFactionWarInfo extends Object
    {
        public var removeNickNameSuffix:Function;
        public var warType:int = 0;
        public var stateServer:int = 0;
        public var statePlayer:int = 0;
        public var groupCup:int = 0;
        public var groupPlayer:int = 0;
        public var zoneName:String = "";
        private var _userList:Array;
        public var winList:Array;
        public var groupList:Array;
        public var cupRoundWar:Array;
        public var cupRecordCount:int = 0;
        public var cupRecord:Vector.<RecordClass>;
        public var cupRecordTip:String = "";
        public var cupRecordSee:RecordClass;
        public var cupGuessList:Vector.<GuessClass>;
        public var cupGuessTip:String = "";
        public var cupCanBetList:Array;
        public var cupBetRankList:Array;
        public var playerId:int = 0;
        public var playerName:String = "";
        public var roundTimeList:Array;
        public var roundTimeInterval:int = 0;
        public var serverNameList:Array;
        public var roundObj:Object;
        private var _date:Date;

        public function ServerFactionWarInfo(param1:int = 0)
        {
            this.removeNickNameSuffix = function (param1:String) : String
            {
                return param1;
            }// end function
            ;
            this._userList = [];
            this.winList = [];
            this.groupList = [];
            this.cupRoundWar = [];
            this.cupCanBetList = [];
            this.cupBetRankList = [];
            this.roundTimeList = [];
            this.serverNameList = [];
            this.roundObj = {curRound:-1, bComplete:false};
            this._date = new Date();
            var _loc_2:* = this.GROUP_NULL();
            this.groupPlayer = this.GROUP_NULL();
            this.groupCup = _loc_2;
            if (instance == null)
            {
                instance = this;
            }
            return;
        }// end function

        public function resetRecord() : void
        {
            this.cupRecordCount = 0;
            this.cupRecord = new Vector.<RecordClass>(16);
            this.cupRecord[16] = new RecordClass();
            this.cupRecord[8] = new RecordClass();
            this.cupRecord[4] = new RecordClass();
            this.cupRecord[2] = new RecordClass();
            this.cupRecord[1] = new RecordClass();
            this.cupRecordTip = HtmlText.red(ServerFactionWarInfoLang.YouOut);
            switch(this.stateServer)
            {
                case this.STEP_DIBANG_COMPLETE():
                case this.STEP_16():
                {
                    if (this.statePlayer == this.STEP_16())
                    {
                        this.cupRecordTip = HtmlText.yellow(Lang.sprintf(ServerFactionWarInfoLang.YouInTo32, this.getGroupName(this.groupPlayer)));
                    }
                    else if (this.statePlayer == this.STEP_8())
                    {
                        this.cupRecordTip = HtmlText.yellow(Lang.sprintf(ServerFactionWarInfoLang.YouInTo16, this.getGroupName(this.groupPlayer)));
                    }
                    break;
                }
                case this.STEP_16_COMPLETE():
                case this.STEP_8():
                {
                    if (this.statePlayer == this.STEP_8())
                    {
                        this.cupRecordTip = HtmlText.yellow(Lang.sprintf(ServerFactionWarInfoLang.YouInTo16, this.getGroupName(this.groupPlayer)));
                    }
                    else if (this.statePlayer == this.STEP_4())
                    {
                        this.cupRecordTip = HtmlText.yellow(Lang.sprintf(ServerFactionWarInfoLang.YouInTo8, this.getGroupName(this.groupPlayer)));
                    }
                    break;
                }
                case this.STEP_8_COMPLETE():
                case this.STEP_4():
                {
                    if (this.statePlayer == this.STEP_4())
                    {
                        this.cupRecordTip = HtmlText.yellow(Lang.sprintf(ServerFactionWarInfoLang.YouInTo8, this.getGroupName(this.groupPlayer)));
                    }
                    else if (this.statePlayer == this.STEP_2())
                    {
                        this.cupRecordTip = HtmlText.yellow(Lang.sprintf(ServerFactionWarInfoLang.YouInTo4, this.getGroupName(this.groupPlayer)));
                    }
                    break;
                }
                case this.STEP_4_COMPLETE():
                case this.STEP_2():
                {
                    if (this.statePlayer == this.STEP_2())
                    {
                        this.cupRecordTip = HtmlText.yellow(Lang.sprintf(ServerFactionWarInfoLang.YouInTo4, this.getGroupName(this.groupPlayer)));
                    }
                    else if (this.statePlayer == this.STEP_1())
                    {
                        this.cupRecordTip = HtmlText.yellow(Lang.sprintf(ServerFactionWarInfoLang.YouInTo2, this.getGroupName(this.groupPlayer)));
                    }
                    break;
                }
                case this.STEP_2_COMPLETE():
                case this.STEP_1():
                {
                    if (this.statePlayer == this.STEP_1() || this.statePlayer == this.STEP_1_COMPLETE())
                    {
                        this.cupRecordTip = HtmlText.yellow(Lang.sprintf(ServerFactionWarInfoLang.YouInTo2, this.getGroupName(this.groupPlayer)));
                    }
                    break;
                }
                case this.STEP_1_COMPLETE():
                {
                    if (this.statePlayer == this.STEP_1_COMPLETE())
                    {
                        this.cupRecordTip = HtmlText.yellow(Lang.sprintf(ServerFactionWarInfoLang.YouInTo1, this.getGroupName(this.groupPlayer)));
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

        public function pushRecord(param1:int, param2:int, param3:String, param4:int, param5:int, param6:String, param7:String) : void
        {
            var _loc_8:int = 0;
            var _loc_9:* = this.cupRecord[param1];
            if (param1 == 0)
            {
                _loc_9 = new RecordClass();
                this.cupRecord.push(_loc_9);
            }
            _loc_9.warIdx = param7;
            _loc_9.idA = this.playerId;
            _loc_9.nameA = this.playerName;
            _loc_9.idB = param2;
            _loc_9.nameB = param3;
            _loc_9.warList.push({win:param4, war_report_id:param5, report_version:param6});
            var _loc_10:String = this;
            var _loc_11:* = this.cupRecordCount + 1;
            _loc_10.cupRecordCount = _loc_11;
            return;
        }// end function

        public function pushRecordSee(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.cupRecordSee = new RecordClass();
            for each (_loc_2 in param1)
            {
                
                this.cupRecordSee.idA = _loc_2[0];
                this.cupRecordSee.nameA = this.getUserData(_loc_2[0]).name;
                this.cupRecordSee.idB = _loc_2[1];
                this.cupRecordSee.nameB = this.getUserData(_loc_2[1]).name;
                this.cupRecordSee.warList.push({win:_loc_2[2], name:this.getUserData(_loc_2[2]).name, war_report_id:_loc_2[3], report_version:_loc_2[4]});
            }
            return;
        }// end function

        public function getUserData(param1:int) : UserClass
        {
            var _loc_2:* = new UserClass();
            this._userList[param1] = new UserClass();
            return this._userList[param1] || _loc_2;
        }// end function

        public function setRoundWin(param1:Array, param2:Array, param3:Array, param4:Array, param5:Array, param6:Array) : void
        {
            this.winList = [];
            this.winList[16] = param6.length <= 16 ? (param6) : (param1);
            this.winList[8] = param6.length <= 8 ? (param6) : (param2);
            this.winList[4] = param6.length <= 4 ? (param6) : (param3);
            this.winList[2] = param6.length <= 2 ? (param6) : (param4);
            this.winList[1] = param5;
            return;
        }// end function

        public function get cupMsg() : String
        {
            var _loc_1:String = "";
            switch(this.stateServer)
            {
                case this.STEP_DIBANG_COMPLETE():
                {
                    _loc_1 = Lang.sprintf(ServerFactionWarInfoLang.WillGoon, this.getTime_MDHI_AtState(this.STEP_16()), this.getSerStateName(this.stateServer, this.groupCup));
                    break;
                }
                case this.STEP_16_COMPLETE():
                {
                    _loc_1 = Lang.sprintf(ServerFactionWarInfoLang.WillGoon, this.getTime_MDHI_AtState(this.STEP_8()), this.getSerStateName(this.stateServer, this.groupCup));
                    break;
                }
                case this.STEP_8_COMPLETE():
                {
                    _loc_1 = Lang.sprintf(ServerFactionWarInfoLang.WillGoon, this.getTime_MDHI_AtState(this.STEP_4()), this.getSerStateName(this.stateServer, this.groupCup));
                    break;
                }
                case this.STEP_4_COMPLETE():
                {
                    _loc_1 = Lang.sprintf(ServerFactionWarInfoLang.WillGoon, this.getTime_MDHI_AtState(this.STEP_2()), this.getSerStateName(this.stateServer, this.groupCup));
                    break;
                }
                case this.STEP_2_COMPLETE():
                {
                    _loc_1 = Lang.sprintf(ServerFactionWarInfoLang.WillGoon, this.getTime_MDHI_AtState(this.STEP_1()), this.getSerStateName(this.stateServer, this.groupCup));
                    break;
                }
                case this.STEP_16():
                case this.STEP_8():
                case this.STEP_4():
                case this.STEP_2():
                case this.STEP_1():
                {
                    _loc_1 = Lang.sprintf(ServerFactionWarInfoLang.InGoon, this.getGroupName(this.groupCup), this.getSerStateName(this.stateServer, 0));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        public function setCupRoundWar(param1:Array) : void
        {
            var _loc_5:Array = null;
            this.roundObj = {curRound:-1, bComplete:false};
            var _loc_8:String = "";
            this.cupRoundWar[4] = "";
            var _loc_8:* = _loc_8;
            this.cupRoundWar[3] = _loc_8;
            var _loc_8:* = _loc_8;
            this.cupRoundWar[2] = _loc_8;
            var _loc_8:* = _loc_8;
            this.cupRoundWar[1] = _loc_8;
            this.cupRoundWar[0] = _loc_8;
            if (this.stateServer == this.STEP_1_COMPLETE())
            {
                return;
            }
            var _loc_2:* = int(new Date().time / 1000);
            var _loc_3:Array = [ServerFactionWarInfoLang.Ju1, ServerFactionWarInfoLang.Ju2, ServerFactionWarInfoLang.Ju3, ServerFactionWarInfoLang.Ju4, ServerFactionWarInfoLang.Ju5];
            var _loc_4:Array = [this.getTime_HI_AtState(this.stateServer, 0), this.getTime_HI_AtState(this.stateServer, 1), this.getTime_HI_AtState(this.stateServer, 2), this.getTime_HI_AtState(this.stateServer, 3), this.getTime_HI_AtState(this.stateServer, 4)];
            switch(this.stateServer)
            {
                case this.STEP_16():
                case this.STEP_8():
                case this.STEP_4():
                case this.STEP_2():
                case this.STEP_1():
                {
                    if (_loc_2 >= this.getRoundTime(this.stateServer, 4))
                    {
                        _loc_3[4] = HtmlText.yellow2(_loc_3[4]);
                        _loc_4[4] = HtmlText.yellow2(_loc_4[4]);
                        this.roundObj.curRound = 4;
                    }
                    else if (_loc_2 >= this.getRoundTime(this.stateServer, 3))
                    {
                        _loc_3[3] = HtmlText.yellow2(_loc_3[3]);
                        _loc_4[3] = HtmlText.yellow2(_loc_4[3]);
                        this.roundObj.curRound = 3;
                    }
                    else if (_loc_2 >= this.getRoundTime(this.stateServer, 2))
                    {
                        _loc_3[2] = HtmlText.yellow2(_loc_3[2]);
                        _loc_4[2] = HtmlText.yellow2(_loc_4[2]);
                        this.roundObj.curRound = 2;
                    }
                    else if (_loc_2 >= this.getRoundTime(this.stateServer, 1))
                    {
                        _loc_3[1] = HtmlText.yellow2(_loc_3[1]);
                        _loc_4[1] = HtmlText.yellow2(_loc_4[1]);
                        this.roundObj.curRound = 1;
                    }
                    else if (_loc_2 >= this.getRoundTime(this.stateServer, 0))
                    {
                        _loc_3[0] = HtmlText.yellow2(_loc_3[0]);
                        _loc_4[0] = HtmlText.yellow2(_loc_4[0]);
                        this.roundObj.curRound = 0;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            for each (_loc_5 in param1)
            {
                
                _loc_3[_loc_6] = HtmlText.white(_loc_3[_loc_6]);
                if (_loc_5[0] == 1)
                {
                    _loc_7++;
                    _loc_4[_loc_6] = HtmlText.white(linkText(ServerFactionWarInfoLang.Win, ["war", _loc_5[1], _loc_5[2]]));
                }
                else if (_loc_5[0] == 2)
                {
                    _loc_4[_loc_6] = HtmlText.red(linkText(ServerFactionWarInfoLang.UnWin, ["war", _loc_5[1], _loc_5[2]]));
                    _loc_7 = _loc_7 - 1;
                }
                _loc_6++;
            }
            if (_loc_6 >= 3 && (_loc_7 >= 3 || _loc_7 <= -3))
            {
                while (_loc_6 < 5)
                {
                    
                    _loc_3[_loc_6] = HtmlText.white(_loc_3[_loc_6]);
                    _loc_4[_loc_6] = HtmlText.white(ServerFactionWarInfoLang.Over);
                    _loc_6++;
                }
            }
            this.cupRoundWar[0] = juString[0] + "\n\n" + _loc_4[0];
            this.cupRoundWar[1] = juString[1] + "\n\n" + _loc_4[1];
            this.cupRoundWar[2] = juString[2] + "\n\n" + _loc_4[2];
            this.cupRoundWar[3] = juString[3] + "\n\n" + _loc_4[3];
            this.cupRoundWar[4] = juString[4] + "\n\n" + _loc_4[4];
            return;
        }// end function

        private function getTime_MDHI_AtState(param1:int) : String
        {
            var _loc_2:* = this.getRoundTime(param1) * 1000;
            var _loc_3:* = this.getDateArray(_loc_2);
            var _loc_4:* = new Date();
            if (new Date().date == _loc_3[1])
            {
                return ServerFactionWarInfoLang.Today + _loc_3[2] + ":" + _loc_3[3];
            }
            _loc_4.time = _loc_4.time + 24 * 3600000;
            if (_loc_4.date == _loc_3[1])
            {
                return ServerFactionWarInfoLang.Tomorrow + _loc_3[2] + ":" + _loc_3[3];
            }
            return _loc_3[0] + ServerFactionWarInfoLang.Moth + _loc_3[1] + ServerFactionWarInfoLang.Day + " " + _loc_3[2] + ":" + _loc_3[3];
        }// end function

        private function getTime_HI_AtState(param1:int, param2:int) : String
        {
            var _loc_3:* = this.getRoundTime(param1, param2) * 1000;
            var _loc_4:* = this.getDateArray(_loc_3);
            return this.getDateArray(_loc_3)[2] + ":" + _loc_4[3];
        }// end function

        private function getDateArray(param1:Number) : Array
        {
            this._date.time = param1;
            var _loc_2:* = "" + this._date.hours;
            var _loc_3:* = "" + (this._date.minutes < 10 ? ("0" + this._date.minutes) : (this._date.minutes));
            var _loc_4:* = "" + (this._date.seconds < 10 ? ("0" + this._date.seconds) : (this._date.seconds));
            return [(this._date.month + 1), this._date.date, _loc_2, _loc_3, _loc_4, this._date.fullYear];
        }// end function

        public function getRoundTime(param1:int, param2:int = 0) : Number
        {
            var _loc_3:int = 0;
            switch(this.stateServer)
            {
                case this.STEP_DIBANG_COMPLETE():
                case this.STEP_16():
                {
                    _loc_3 = int(this.roundTimeList[this.STEP_16()]);
                    break;
                }
                case this.STEP_16_COMPLETE():
                case this.STEP_8():
                {
                    _loc_3 = int(this.roundTimeList[this.STEP_8()]);
                    break;
                }
                case this.STEP_8_COMPLETE():
                case this.STEP_4():
                {
                    _loc_3 = int(this.roundTimeList[this.STEP_4()]);
                    break;
                }
                case this.STEP_4_COMPLETE():
                case this.STEP_2():
                {
                    _loc_3 = int(this.roundTimeList[this.STEP_2()]);
                    break;
                }
                case this.STEP_2_COMPLETE():
                case this.STEP_1():
                {
                    _loc_3 = int(this.roundTimeList[this.STEP_1()]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_3 = int(this.roundTimeList[param1]) || _loc_3;
            _loc_3 = _loc_3 + param2 * this.roundTimeInterval;
            return _loc_3;
        }// end function

        public function get showTianBang() : Boolean
        {
            if (this.groupCup == this.GROUP_TIAN_BANG())
            {
                return true;
            }
            return false;
        }// end function

        public function get showDiBang() : Boolean
        {
            if (this.groupCup == this.GROUP_DI_BANG())
            {
                return true;
            }
            return false;
        }// end function

        public function getSerStateName(param1:int, param2:int) : String
        {
            var _loc_3:String = "";
            switch(param1)
            {
                case this.STEP_TIANBANG():
                {
                    _loc_3 = ServerFactionWarInfoLang.TianBangKnockout;
                    break;
                }
                case this.STEP_DIBANG():
                {
                    _loc_3 = ServerFactionWarInfoLang.DiBangKnockout;
                    break;
                }
                case this.STEP_DIBANG_COMPLETE():
                case this.STEP_16():
                {
                    _loc_3 = this.getGroupName(param2) + ServerFactionWarInfoLang.War16;
                    break;
                }
                case this.STEP_16_COMPLETE():
                case this.STEP_8():
                {
                    _loc_3 = this.getGroupName(param2) + ServerFactionWarInfoLang.War8;
                    break;
                }
                case this.STEP_8_COMPLETE():
                case this.STEP_4():
                {
                    _loc_3 = this.getGroupName(param2) + ServerFactionWarInfoLang.War4;
                    break;
                }
                case this.STEP_4_COMPLETE():
                case this.STEP_2():
                {
                    _loc_3 = this.getGroupName(param2) + ServerFactionWarInfoLang.War2;
                    break;
                }
                case this.STEP_2_COMPLETE():
                case this.STEP_1():
                {
                    _loc_3 = this.getGroupName(param2) + ServerFactionWarInfoLang.War1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function getGroupName(param1:int) : String
        {
            if (param1 == this.GROUP_TIAN_BANG())
            {
                return "";
            }
            if (param1 == this.GROUP_DI_BANG())
            {
                return "";
            }
            return "";
        }// end function

        public function setCupCanBet(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.cupCanBetList = [];
            for each (_loc_2 in param1)
            {
                
                this.cupCanBetList.push({label:int(_loc_2[0] / 10000) + ServerFactionWarInfoLang.Wang, num:int(_loc_2[0])});
            }
            return;
        }// end function

        public function setCupGuessList(param1:Array) : void
        {
            var _loc_4:GuessClass = null;
            var _loc_5:Array = null;
            var _loc_6:String = null;
            var _loc_7:String = null;
            this.cupGuessTip = "";
            this.cupGuessList = new Vector.<GuessClass>;
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            for each (_loc_5 in param1)
            {
                
                var _loc_10:* = new GuessClass();
                _loc_4 = new GuessClass();
                this.cupGuessList.push(_loc_10);
                _loc_4.race_step = _loc_5[0];
                _loc_4.group_type = _loc_5[6];
                _loc_4.roundTip = this.getSerStateName(_loc_5[0], _loc_5[6]);
                _loc_4.id = _loc_5[1];
                _loc_4.name = this.removeNickNameSuffix(_loc_5[2]);
                _loc_4.result = _loc_5[3];
                _loc_4.bet_coin = _loc_5[4];
                _loc_4.win_coin = _loc_5[5];
                _loc_2 = _loc_2 + _loc_4.bet_coin;
                if (_loc_4.result == 1)
                {
                    _loc_3 = _loc_3 + _loc_4.bet_coin;
                    continue;
                }
                if (_loc_4.result == 2)
                {
                    _loc_3 = _loc_3 - _loc_4.bet_coin / 2;
                }
            }
            _loc_6 = "";
            _loc_7 = "";
            if (_loc_2 != 0)
            {
                _loc_6 = _loc_2 / 10000 + ServerFactionWarInfoLang.Wang + ServerFactionWarInfoLang.Coin;
            }
            else
            {
                _loc_6 = _loc_2 / 10000 + ServerFactionWarInfoLang.Coin;
            }
            if (_loc_3 != 0)
            {
                _loc_7 = Math.abs(_loc_3 / 10000) + ServerFactionWarInfoLang.Wang + ServerFactionWarInfoLang.Coin;
            }
            else
            {
                _loc_7 = "0" + ServerFactionWarInfoLang.Coin;
            }
            _loc_6 = HtmlText.yellow2(_loc_6);
            _loc_7 = _loc_3 >= 0 ? (HtmlText.green(_loc_7)) : (HtmlText.red(_loc_7));
            if (_loc_3 > 0)
            {
                this.cupGuessTip = Lang.sprintf(ServerFactionWarInfoLang.GuessAllTip1, HtmlText.yellow(param1.length + ""), _loc_6, _loc_7);
            }
            else
            {
                this.cupGuessTip = Lang.sprintf(ServerFactionWarInfoLang.GuessAllTip2, HtmlText.yellow(param1.length + ""), _loc_6, _loc_7);
            }
            return;
        }// end function

        public function setBetRank(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_6:Number = NaN;
            var _loc_7:String = null;
            this.cupBetRankList = [];
            var _loc_2:int = 0;
            for each (_loc_3 in param1)
            {
                
                _loc_4 = this.removeNickNameSuffix(_loc_3[1]);
                _loc_4 = ++_loc_2 + " " + linkText(_loc_4, ["player", _loc_3[0], _loc_4]);
                _loc_5 = "0";
                _loc_6 = _loc_3[4];
                if (_loc_6 >= 1000000000)
                {
                    _loc_5 = int(_loc_6 / 100000000) + ServerFactionWarInfoLang.Yi;
                }
                else if (_loc_6 >= 10000)
                {
                    _loc_5 = int(_loc_6 / 10000) + ServerFactionWarInfoLang.Wang;
                }
                _loc_7 = "";
                if (this.isCrossService)
                {
                    _loc_7 = Lang.sprintf(ServerFactionWarInfoLang.From, _loc_3[2], _loc_3[3]);
                }
                this.cupBetRankList.push([_loc_4, _loc_5, _loc_7]);
            }
            return;
        }// end function

        public function hasBet(param1:int) : GuessClass
        {
            var _loc_2:GuessClass = null;
            for each (_loc_2 in this.cupGuessList)
            {
                
                if (_loc_2.race_step == this.betState && (_loc_2.id == param1 || param1 == 0))
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function get betState() : int
        {
            switch(this.stateServer)
            {
                case this.STEP_DIBANG_COMPLETE():
                {
                    return this.STEP_16();
                }
                case this.STEP_16_COMPLETE():
                {
                    return this.STEP_8();
                }
                case this.STEP_8_COMPLETE():
                {
                    return this.STEP_4();
                }
                case this.STEP_4_COMPLETE():
                {
                    return this.STEP_2();
                }
                case this.STEP_2_COMPLETE():
                {
                    return this.STEP_1();
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public function get nowStateLv() : int
        {
            switch(this.stateServer)
            {
                case this.STEP_DIBANG_COMPLETE():
                case this.STEP_16():
                {
                    return 16;
                }
                case this.STEP_16_COMPLETE():
                case this.STEP_8():
                {
                    return 8;
                }
                case this.STEP_8_COMPLETE():
                case this.STEP_4():
                {
                    return 4;
                }
                case this.STEP_4_COMPLETE():
                case this.STEP_2():
                {
                    return 2;
                }
                case this.STEP_2_COMPLETE():
                case this.STEP_1():
                case this.STEP_1_COMPLETE():
                {
                    return 1;
                }
                default:
                {
                    break;
                }
            }
            return 16;
        }// end function

        public function get worldZone() : String
        {
            return Lang.sprintf(ServerFactionWarInfoLang.ZoneName, this.zoneName);
        }// end function

        public function get worldZoneIdx() : int
        {
            return int(this.zoneName);
        }// end function

        public function get isCrossService() : Boolean
        {
            return this.warType == this.CrossService();
        }// end function

        public function get isThisService() : Boolean
        {
            return this.warType == this.ThisService();
        }// end function

    }
}

class GuessClass extends Object
{
    public var bet:int = 0;
    public var id:int = 0;
    public var name:String = "";
    public var betIdx:int = 0;
    public var betTip:String = "";

    function GuessClass()
    {
        return;
    }// end function

}


class RecordClass extends Object
{
    public var warIdx:String = "";
    public var idA:int;
    public var nameA:String;
    public var idB:int;
    public var nameB:String;
    public var warList:Array;
    private var _recordString:String;

    function RecordClass()
    {
        this.warList = [];
        return;
    }// end function

    public function get mineMarkString() : String
    {
        var _loc_2:Object = null;
        var _loc_1:int = 0;
        for each (_loc_2 in this.warList)
        {
            
            if (_loc_2.win == 1)
            {
                _loc_1++;
            }
        }
        return _loc_1 + ":" + (this.warList.length - _loc_1);
    }// end function

    public function get mineRecordString() : String
    {
        var _loc_1:int = 0;
        var _loc_2:Array = null;
        var _loc_3:Object = null;
        var _loc_4:String = null;
        if (this.warList.length == 0)
        {
            return ServerWarInfoLang.Waiting;
        }
        if (this._recordString == null || this._recordString == "")
        {
            this.warList.sortOn("war_report_id", Array.NUMERIC);
            _loc_1 = 0;
            _loc_2 = [];
            for each (_loc_3 in this.warList)
            {
                
                _loc_4 = linkText("（" + ++_loc_1 + "）", ["war", _loc_3.war_report_id, _loc_3.report_version]);
                if (_loc_3.win == 1)
                {
                    _loc_4 = "<font color=\'#FFFFFF\'>" + _loc_4 + "</font>";
                }
                else
                {
                    _loc_4 = "<font color=\'#FF0000\'>" + _loc_4 + "</font>";
                }
                _loc_2.push(_loc_4);
            }
            this._recordString = _loc_2.join(" ");
        }
        return this._recordString;
    }// end function

    public function get markAB() : String
    {
        var _loc_3:Object = null;
        if (this.warList.length == 0)
        {
            return ServerWarInfoLang.Waiting;
        }
        var _loc_1:int = 0;
        var _loc_2:int = 0;
        for each (_loc_3 in this.warList)
        {
            
            if (_loc_3.win == this.idA)
            {
                _loc_1++;
                continue;
            }
            _loc_2++;
        }
        if (_loc_1 > _loc_2)
        {
            return "<b>" + this.nameA + HtmlText.white(" " + _loc_1 + ":" + _loc_2 + " ") + this.nameB + "</b>";
        }
        return "<b>" + this.nameB + HtmlText.white(" " + _loc_2 + ":" + _loc_1 + " ") + this.nameA + "</b>";
    }// end function

    public function get seeList() : Array
    {
        var _loc_5:Object = null;
        var _loc_6:Object = null;
        var _loc_1:Array = [];
        var _loc_2:int = 0;
        var _loc_3:int = 0;
        var _loc_4:* = this.warList.length;
        for each (_loc_5 in this.warList)
        {
            
            _loc_6 = {};
            _loc_6.win = juString[--_loc_4] + " 【<font color=\'#F39800\'>" + this.linkWin(_loc_5.win) + "</font>】 " + ServerWarInfoLang.Win;
            _loc_6.see = linkText(ServerWarInfoLang.See, ["war", _loc_5.war_report_id, _loc_5.report_version]);
            _loc_1.push(_loc_6);
            if (_loc_5.win == this.idA)
            {
                _loc_2++;
                continue;
            }
            _loc_3++;
        }
        if (_loc_1.length > 0 && _loc_2 < 3 && _loc_3 < 3)
        {
            _loc_1.unshift({win:juString[this.warList.length] + ServerWarInfoLang.Waiting, see:""});
        }
        return _loc_1;
    }// end function

    public function get linkA() : String
    {
        return linkText(this.nameA, ["player", this.idA, this.nameA]);
    }// end function

    public function get linkB() : String
    {
        return linkText(this.nameB, ["player", this.idB, this.nameB]);
    }// end function

    public function linkWin(param1:int) : String
    {
        if (param1 == this.idA)
        {
            return "<b>" + this.linkA + "</b>";
        }
        if (param1 == this.idB)
        {
            return "<b>" + this.linkB + "</b>";
        }
        return "";
    }// end function

}


class UserClass extends Object
{
    public var name:String = "";
    public var id:int = 0;
    public var roleId:int = 0;
    public var roleIconList:Array;
    public var roleHeadUrl:String = "";
    public var dps:int = 0;
    public var fame:int = 0;
    public var level:int = 0;
    public var stageName:String = "";
    public var serverName:String = "";
    public var petLv:int = 0;
    public var petStar:int = 0;
    public var tipSprite:Sprite;
    public var socialStatus:Number = 0;

    function UserClass() : void
    {
        this.roleIconList = [];
        this.tipSprite = new Sprite();
        return;
    }// end function

    public function initData(param1:Object) : void
    {
        this.id = param1.player_id;
        this.name = instance.removeNickNameSuffix(param1.player_nickname);
        this.roleId = param1.role_id;
        this.dps = param1.attack_power;
        this.fame = param1.fame;
        this.level = param1.level;
        this.stageName = param1.stage_name;
        this.serverName = param1.view_server_name;
        this.socialStatus = param1.bet_coin;
        this.roleHeadUrl = param1.headUrl;
        this.petStar = param1.pet_step;
        this.petLv = param1.pet_level;
        this.roleIconList = param1.role_list;
        return;
    }// end function

    public function get nameLink() : String
    {
        if (this.id == 0)
        {
            return "";
        }
        return linkText(this.name, ["player", this.id, this.name]);
    }// end function

    public function get nameTip() : Sprite
    {
        var _loc_4:Sprite = null;
        var _loc_5:Array = null;
        var _loc_6:Array = null;
        if (this.id == 0)
        {
            return null;
        }
        this.tipSprite.graphics.clear();
        this.tipSprite.graphics.lineStyle(1, 3880756);
        while (this.tipSprite.numChildren)
        {
            
            this.tipSprite.removeChildAt(0);
        }
        var _loc_1:int = 0;
        var _loc_2:int = 0;
        var _loc_3:String = "";
        _loc_3 = ServerWarInfoLang.Socialstatus + this.socialStatusTip;
        if (this.isCrossService())
        {
            _loc_3 = ServerWarInfoLang.Socialstatus + this.socialStatusTip;
            _loc_3 = _loc_3 + "\n" + ServerWarInfoLang.Dps + this.dps;
            _loc_3 = _loc_3 + "\n" + Lang.sprintf(ServerWarInfoLang.From, this.stageName, this.serverName);
        }
        _loc_3 = _loc_3 + "\n\n" + ServerWarInfoLang.BattleRole;
        this.tipSprite.addChild(this.getTF(_loc_3, _loc_2));
        _loc_2 = this.tipSprite.height + 5;
        this.tipSprite.graphics.moveTo(0, _loc_2 - 33);
        this.tipSprite.graphics.lineTo(155, _loc_2 - 33);
        if (this.roleIconList.length == 0)
        {
            this.tipSprite.addChild(this.getTF(ServerWarInfoLang.None, _loc_2));
            _loc_2 = this.tipSprite.height + 5;
        }
        else
        {
            for each (_loc_4 in this.roleIconList)
            {
                
                _loc_4.x = _loc_1;
                _loc_4.y = _loc_2;
                _loc_1 = _loc_1 + 39;
                this.tipSprite.addChild(_loc_4);
            }
            _loc_2 = _loc_2 + 43;
        }
        if (this.petLv > 0)
        {
            _loc_5 = ["", ServerWarInfoLang.Jie1, ServerWarInfoLang.Jie2, ServerWarInfoLang.Jie3, ServerWarInfoLang.Jie4, ServerWarInfoLang.Jie5, ServerWarInfoLang.Jie6, ServerWarInfoLang.Jie7, ServerWarInfoLang.Jie8, ServerWarInfoLang.Jie9, ServerWarInfoLang.Jie10];
            _loc_6 = ["", "", ServerWarInfoLang.Bian1, ServerWarInfoLang.Bian2, ServerWarInfoLang.Bian3, ServerWarInfoLang.Bian4, ServerWarInfoLang.Bian5, ServerWarInfoLang.Bian6, ServerWarInfoLang.Bian7, ServerWarInfoLang.Bian8, ServerWarInfoLang.Bian9];
            _loc_3 = HtmlText.format(_loc_5[this.petStar] + PetType.getName(this.petLv) + _loc_6[this.petLv], PetType.getColor(this.petLv));
            this.tipSprite.addChild(this.getTF(ServerWarInfoLang.PetLv + _loc_3, _loc_2));
        }
        return this.tipSprite;
    }// end function

    private function getTF(param1:String, param2:int) : TextField
    {
        var _loc_3:* = new TextField();
        _loc_3.textColor = 15658734;
        _loc_3.htmlText = "<textformat leading=\'3\'>" + param1 + "</textformat>";
        _loc_3.width = 155;
        _loc_3.height = _loc_3.textHeight + 5;
        _loc_3.y = param2;
        return _loc_3;
    }// end function

    public function get socialStatusTip() : String
    {
        if (this.socialStatus == 0)
        {
            return "0";
        }
        if (this.socialStatus >= 1000000000)
        {
            return int(this.socialStatus / 100000000) + ServerWarInfoLang.Yi;
        }
        return int(this.socialStatus / 10000) + ServerWarInfoLang.Wang;
    }// end function

    public function get dpsTip() : String
    {
        if (this.id == 0)
        {
            return "";
        }
        if (this.isThisService())
        {
            return "";
        }
        return ServerWarInfoLang.Dps + this.dps;
    }// end function

    public function get lvTip() : String
    {
        if (this.id == 0)
        {
            return "";
        }
        return ServerWarInfoLang.Lv + this.level;
    }// end function

    public function get fameTip() : String
    {
        if (this.id == 0)
        {
            return "";
        }
        return ServerWarInfoLang.Fame + this.fame;
    }// end function

}

