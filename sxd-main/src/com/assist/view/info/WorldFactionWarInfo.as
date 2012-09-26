package com.assist.view.info
{
    import com.*;
    import com.assist.view.*;
    import com.haloer.data.*;
    import com.lang.client.com.assist.view.info.*;
    import flash.utils.*;

    public class WorldFactionWarInfo extends Object
    {
        private var _factionList:Array;
        private var _date:Date;
        public var getCookie:Function;
        public var setCookie:Function;
        public var removeNickNameSuffix:Function;
        public var stateServer:int = 0;
        public var stateTeam:int = 0;
        public var statePlayer:int = 0;
        public var zoneIdx:int = 0;
        public var zoneName:String = "";
        public var cupRoundObjList:Array;
        public var cupBetList:Array;
        public var guessTip:String = "";
        public var guessMsg:String = "";
        public var guessList:Array;
        public var appId:int = 0;
        public var appName:String = "";
        public var nowGroup:WorldFactionWarGroupClass;
        public var roundTimeList:Array;
        public var roundTimeInterval:int = 0;
        public var serverNameList:Array;
        public var _serverTime:Number = 0;
        public var awardInfo:Object;
        public var receiveAwardInfo:Object;
        public var serverInitTime:Number = 0;
        public static const StepS41:String = "S41";
        public static const StepE41:String = "E41";
        public static const StepS42:String = "S42";
        public static const StepE42:String = "E42";
        public static const StepS43:String = "S43";
        public static const StepE43:String = "E43";
        public static const StepS44:String = "S44";
        public static const StepE44:String = "E44";
        public static const StepS21:String = "S21";
        public static const StepE21:String = "E21";
        public static const StepS22:String = "S22";
        public static const StepE22:String = "E22";
        public static const StepS11:String = "S11";
        public static const StepE11:String = "E11";
        public static const StepE00:String = "E00";

        public function WorldFactionWarInfo()
        {
            this._factionList = [];
            this._date = new Date();
            this.getCookie = new Function();
            this.setCookie = new Function();
            this.removeNickNameSuffix = function (param1:String) : String
            {
                return param1;
            }// end function
            ;
            this.cupRoundObjList = [];
            this.cupBetList = [];
            this.guessList = [];
            this.roundTimeList = [];
            this.serverNameList = [];
            if (instance == null)
            {
                instance = this;
            }
            return;
        }// end function

        public function get serverTime() : Number
        {
            return this.serverInitTime + getTimer();
        }// end function

        public function resetCupGroup(param1:Array, param2:Array, param3:Array, param4:Array, param5:Array) : void
        {
            if (param2.length < 4)
            {
                param3 = param2;
                ;
            }
            if (param2.length < 2)
            {
                param4 = param2;
                ;
            }
            WorldFactionWarGroupClass.info = this;
            WorldFactionWarGroupClass.resetGroup(param1, param3, param4, param5);
            this.nowGroup = this.getWarGroupAtStep();
            return;
        }// end function

        public function get roundIdxTipList() : Array
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            if (this.stateServer == this.STEP_1_Complete())
            {
                return ["", "", "", ""];
            }
            var _loc_1:* = this.nowGroup.warTime;
            var _loc_2:Array = ["", WorldFactionWarInfoLang.Ju1, WorldFactionWarInfoLang.Ju2, WorldFactionWarInfoLang.Ju3];
            var _loc_3:Array = ["", this.getTime_HI(_loc_1), this.getTime_HI(_loc_1 + this.roundTimeInterval), this.getTime_HI(_loc_1 + this.roundTimeInterval * 2)];
            if (this.serverTime > _loc_1 + 3 * this.roundTimeInterval)
            {
            }
            else if (this.serverTime >= _loc_1 + 2 * this.roundTimeInterval)
            {
                _loc_2[3] = HtmlText.yellow2(_loc_2[3]);
                _loc_3[3] = HtmlText.yellow2(_loc_3[3]);
                _loc_3[2] = WorldFactionWarInfoLang.Over;
                _loc_3[1] = WorldFactionWarInfoLang.Over;
            }
            else if (this.serverTime >= _loc_1 + this.roundTimeInterval)
            {
                _loc_2[2] = HtmlText.yellow2(_loc_2[2]);
                _loc_3[2] = HtmlText.yellow2(_loc_3[2]);
                _loc_3[1] = WorldFactionWarInfoLang.Over;
            }
            else if (this.serverTime >= _loc_1)
            {
                _loc_2[1] = HtmlText.yellow2(_loc_2[1]);
                _loc_3[1] = HtmlText.yellow2(_loc_3[1]);
            }
            if (this.serverTime >= _loc_1 && (this.appId == this.nowGroup.idA || this.appId == this.nowGroup.idB))
            {
                _loc_4 = 0;
                _loc_5 = 0;
                for each (_loc_6 in this.cupRoundObjList)
                {
                    
                    _loc_2[_loc_6.round] = HtmlText.white(_loc_2[_loc_6.round]);
                    if (_loc_6.result == 1)
                    {
                        _loc_5++;
                        _loc_3[_loc_6.round] = HtmlText.white(linkText(WorldFactionWarInfoLang.Win, ["war", _loc_6.apply_id1, _loc_6.apply_id2, _loc_6.race_step, _loc_6.round]));
                    }
                    else if (_loc_6.result == 2)
                    {
                        _loc_5 = _loc_5 - 1;
                        _loc_3[_loc_6.round] = HtmlText.red(linkText(WorldFactionWarInfoLang.UnWin, ["war", _loc_6.apply_id1, _loc_6.apply_id2, _loc_6.race_step, _loc_6.round]));
                    }
                    _loc_4++;
                }
                if (_loc_4 == 2 && (_loc_5 == 2 || _loc_5 == -2))
                {
                    _loc_3[3] = HtmlText.white(WorldFactionWarInfoLang.Over);
                }
            }
            return ["", _loc_2[1] + "\n" + _loc_3[1], _loc_2[2] + "\n" + _loc_3[2], _loc_2[3] + "\n" + _loc_3[3]];
        }// end function

        public function get roundTip() : String
        {
            if (this.stateServer == this.STEP_1_Complete())
            {
                return "";
            }
            var _loc_1:String = "";
            var _loc_2:Array = ["", WorldFactionWarInfoLang.War0, WorldFactionWarInfoLang.War2, "", WorldFactionWarInfoLang.War4];
            var _loc_3:Array = ["", WorldFactionWarInfoLang.Chang1, WorldFactionWarInfoLang.Chang2, WorldFactionWarInfoLang.Chang3, WorldFactionWarInfoLang.Chang4];
            if (this.serverTime < this.nowGroup.warTime)
            {
                _loc_1 = Lang.sprintf(WorldFactionWarInfoLang.WillInTo, this.getTime_MDHI(this.nowGroup.warTime), _loc_2[this.nowGroup.lv]);
            }
            else
            {
                _loc_1 = Lang.sprintf(WorldFactionWarInfoLang.OnInTo, _loc_2[this.nowGroup.lv]);
            }
            if (this.nowGroup.lv != 1)
            {
                _loc_1 = _loc_1 + _loc_3[this.nowGroup.idx];
            }
            return _loc_1;
        }// end function

        private function getTime_MDHI(param1:Number) : String
        {
            var _loc_2:* = this.getDateArray(param1);
            this._date.time = this.serverTime;
            if (int(this._date.date) == int(_loc_2[1]))
            {
                return Lang.sprintf(WorldFactionWarInfoLang.DateTodayHI, _loc_2[2], _loc_2[3]);
            }
            var _loc_3:int = 86400000;
            this._date.time = this.serverTime + _loc_3;
            if (int(this._date.date) == int(_loc_2[1]))
            {
                return Lang.sprintf(WorldFactionWarInfoLang.DateTomorrowHI, _loc_2[2], _loc_2[3]);
            }
            return Lang.sprintf(WorldFactionWarInfoLang.DateMDHI, _loc_2[0], _loc_2[1], _loc_2[2], _loc_2[3]);
        }// end function

        private function getTime_HI(param1:Number) : String
        {
            var _loc_2:* = this.getDateArray(param1);
            return _loc_2[2] + ":" + _loc_2[3];
        }// end function

        private function getDateArray(param1:Number) : Array
        {
            this._date.time = param1;
            var _loc_2:* = "" + this._date.hours;
            var _loc_3:* = "" + (this._date.minutes < 10 ? ("0" + this._date.minutes) : (this._date.minutes));
            var _loc_4:* = "" + (this._date.seconds < 10 ? ("0" + this._date.seconds) : (this._date.seconds));
            return [(this._date.month + 1), this._date.date, _loc_2, _loc_3, _loc_4, this._date.fullYear];
        }// end function

        public function get getServerTimeString() : String
        {
            var _loc_1:* = this.getDateArray(this.serverTime);
            this._date.time = this.serverTime;
            return this.zoneName + "   " + Lang.sprintf(WorldFactionWarInfoLang.DateMDHIS, _loc_1[0], _loc_1[1], _loc_1[2], _loc_1[3], _loc_1[4]);
        }// end function

        public function getRoundTime(param1:int) : Number
        {
            var _loc_2:Number = 0;
            switch(this.stateServer)
            {
                case this.STEP_DIBANG_Complete():
                case this.STEP_4():
                {
                    _loc_2 = Number(this.roundTimeList[this.STEP_4()]);
                    break;
                }
                case this.STEP_4_Complete():
                case this.STEP_2():
                {
                    _loc_2 = Number(this.roundTimeList[this.STEP_2()]);
                    break;
                }
                case this.STEP_2_Complete():
                case this.STEP_1():
                {
                    _loc_2 = Number(this.roundTimeList[this.STEP_1()]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2 = Number(this.roundTimeList[param1]) || _loc_2;
            return _loc_2;
        }// end function

        public function getStateName(param1:int, param2:int) : String
        {
            var _loc_3:String = "";
            switch(param1)
            {
                case this.STEP_TIANBANG():
                case this.STEP_DIBANG():
                {
                    _loc_3 = WorldFactionWarInfoLang.TaoTaiSai;
                    break;
                }
                case this.STEP_DIBANG_Complete():
                case this.STEP_4():
                {
                    _loc_3 = WorldFactionWarInfoLang.War4;
                    break;
                }
                case this.STEP_4_Complete():
                case this.STEP_2():
                {
                    _loc_3 = WorldFactionWarInfoLang.War2;
                    break;
                }
                case this.STEP_2_Complete():
                case this.STEP_1():
                {
                    _loc_3 = WorldFactionWarInfoLang.War0;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function setGuessList(param1:Array) : void
        {
            var _loc_5:Array = null;
            var _loc_6:Object = null;
            var _loc_7:String = null;
            var _loc_8:GuessClass = null;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            this.guessMsg = "";
            for each (_loc_5 in param1)
            {
                
                _loc_6 = {};
                oObject.list(_loc_5, _loc_6, ["race_step", "team", "apply_id", "faction_name", "result", "bet_coin", "win_coin", "group"]);
                _loc_6.faction_name = this.removeNickNameSuffix(_loc_6.faction_name);
                _loc_7 = this.getStateName(_loc_6.race_step, 0);
                _loc_8 = new GuessClass();
                _loc_8.bet = _loc_6.bet_coin;
                _loc_8.id = _loc_6.apply_id;
                _loc_8.name = _loc_6.faction_name;
                _loc_8.betTip = HtmlText.yellow2(Lang.sprintf(WorldFactionWarInfoLang.BetTip, _loc_6.faction_name, coinString3(_loc_8.bet)));
                switch(_loc_6.race_step)
                {
                    case this.STEP_4():
                    {
                        _loc_8.betIdx = 40 + _loc_6.team;
                        break;
                    }
                    case this.STEP_2():
                    {
                        _loc_8.betIdx = 20 + _loc_6.team;
                        break;
                    }
                    case this.STEP_1():
                    {
                        _loc_8.betIdx = 10 + _loc_6.team;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2 = _loc_2 + _loc_8.bet;
                if (_loc_6.result == 0)
                {
                    _loc_7 = _loc_7 + "  " + Lang.sprintf(WorldFactionWarInfoLang.BetWait, _loc_6.faction_name, HtmlText.yellow3(coinString2(_loc_8.bet)));
                }
                else if (_loc_6.result == 1)
                {
                    _loc_4 = _loc_4 + _loc_8.bet;
                    _loc_3 = _loc_3 + _loc_8.bet;
                    _loc_7 = _loc_7 + "  " + Lang.sprintf(WorldFactionWarInfoLang.BetWin, _loc_6.faction_name, HtmlText.yellow3(coinString2(_loc_8.bet)), HtmlText.green2(coinString2(_loc_8.bet)));
                }
                else
                {
                    _loc_4 = _loc_4 + _loc_8.bet;
                    _loc_3 = _loc_3 - (_loc_8.bet >> 1);
                    _loc_7 = _loc_7 + "  " + Lang.sprintf(WorldFactionWarInfoLang.BetNoWin, _loc_6.faction_name, HtmlText.yellow3(coinString2(_loc_8.bet)), HtmlText.red(coinString2(_loc_8.bet >> 1)));
                }
                this.guessMsg = this.guessMsg + "\n" + _loc_7;
                this.guessList[_loc_8.betIdx] = _loc_8;
            }
            if (_loc_2 == 0)
            {
                this.guessTip = WorldFactionWarInfoLang.GuessAllTip0;
            }
            else if (_loc_3 >= 0)
            {
                this.guessTip = Lang.sprintf(WorldFactionWarInfoLang.GuessAllTip1, param1.length, HtmlText.yellow2(coinString1(_loc_2)), HtmlText.green2(coinString1(_loc_3)));
            }
            else
            {
                this.guessTip = Lang.sprintf(WorldFactionWarInfoLang.GuessAllTip1, param1.length, HtmlText.yellow2(coinString1(_loc_2)), HtmlText.red(coinString1(_loc_3)));
            }
            return;
        }// end function

        public function get step() : String
        {
            if (this.stateServer == this.STEP_DIBANG_Complete())
            {
                return StepS41;
            }
            var _loc_1:int = 86400000;
            var _loc_2:* = this.getRoundTime(this.STEP_4());
            if (this.serverTime < _loc_2)
            {
                return StepS41;
            }
            this._date.time = _loc_2;
            this._date.hours = 23;
            this._date.minutes = 59;
            if (this.serverTime < this._date.time)
            {
                return StepE41;
            }
            _loc_2 = _loc_2 + _loc_1;
            if (this.serverTime < _loc_2)
            {
                return StepS42;
            }
            this._date.time = _loc_2;
            this._date.hours = 23;
            this._date.minutes = 59;
            if (this.serverTime < this._date.time)
            {
                return StepE42;
            }
            _loc_2 = _loc_2 + _loc_1;
            if (this.serverTime < _loc_2)
            {
                return StepS43;
            }
            this._date.time = _loc_2;
            this._date.hours = 23;
            this._date.minutes = 59;
            if (this.serverTime < this._date.time)
            {
                return StepE43;
            }
            _loc_2 = _loc_2 + _loc_1;
            if (this.serverTime < _loc_2)
            {
                return StepS44;
            }
            this._date.time = _loc_2;
            this._date.hours = 23;
            this._date.minutes = 59;
            if (this.serverTime < this._date.time)
            {
                return StepE44;
            }
            _loc_2 = _loc_2 + _loc_1;
            if (this.serverTime < _loc_2)
            {
                return StepS21;
            }
            this._date.time = _loc_2;
            this._date.hours = 23;
            this._date.minutes = 59;
            if (this.serverTime < this._date.time)
            {
                return StepE21;
            }
            _loc_2 = _loc_2 + _loc_1;
            if (this.serverTime < _loc_2)
            {
                return StepS22;
            }
            this._date.time = _loc_2;
            this._date.hours = 23;
            this._date.minutes = 59;
            if (this.serverTime < this._date.time)
            {
                return StepE22;
            }
            _loc_2 = _loc_2 + _loc_1;
            if (this.serverTime < _loc_2)
            {
                return StepS11;
            }
            this._date.time = _loc_2;
            this._date.hours = 23;
            this._date.minutes = 59;
            if (this.serverTime < this._date.time)
            {
                return StepE11;
            }
            return StepE00;
        }// end function

        public function get nowGuessObj() : GuessClass
        {
            var _loc_1:* = this.guessList[this.nowGroup.lv * 10 + this.nowGroup.idx] as GuessClass;
            return _loc_1;
        }// end function

        private function getWarGroupAtStep(param1:String = "") : WorldFactionWarGroupClass
        {
            var _loc_2:WorldFactionWarGroupClass = null;
            param1 = param1 || this.step;
            switch(param1)
            {
                case StepS41:
                {
                    _loc_2 = this.getWarGroup(4, 1);
                    break;
                }
                case StepE41:
                {
                    _loc_2 = this.getWarGroup(4, 1);
                    if (_loc_2.win != 0)
                    {
                        _loc_2 = this.getWarGroup(4, 2);
                    }
                    break;
                }
                case StepS42:
                {
                    _loc_2 = this.getWarGroup(4, 2);
                    break;
                }
                case StepE42:
                {
                    _loc_2 = this.getWarGroup(4, 2);
                    if (_loc_2.win != 0)
                    {
                        _loc_2 = this.getWarGroup(4, 3);
                    }
                    break;
                }
                case StepS43:
                {
                    _loc_2 = this.getWarGroup(4, 3);
                    break;
                }
                case StepE43:
                {
                    _loc_2 = this.getWarGroup(4, 3);
                    if (_loc_2.win != 0)
                    {
                        _loc_2 = this.getWarGroup(4, 4);
                    }
                    break;
                }
                case StepS44:
                {
                    _loc_2 = this.getWarGroup(4, 4);
                    break;
                }
                case StepE44:
                {
                    _loc_2 = this.getWarGroup(4, 4);
                    if (_loc_2.win != 0)
                    {
                        _loc_2 = this.getWarGroup(2, 1);
                    }
                    break;
                }
                case StepS21:
                {
                    _loc_2 = this.getWarGroup(2, 1);
                    break;
                }
                case StepE21:
                {
                    _loc_2 = this.getWarGroup(2, 1);
                    if (_loc_2.win != 0)
                    {
                        _loc_2 = this.getWarGroup(2, 2);
                    }
                    break;
                }
                case StepS22:
                {
                    _loc_2 = this.getWarGroup(2, 2);
                    break;
                }
                case StepE22:
                {
                    _loc_2 = this.getWarGroup(2, 2);
                    if (_loc_2.win != 0)
                    {
                        _loc_2 = this.getWarGroup(1, 1);
                    }
                    break;
                }
                case StepS11:
                case StepE11:
                {
                    _loc_2 = this.getWarGroup(1, 1);
                    break;
                }
                default:
                {
                    _loc_2 = this.getWarGroup(1, 1);
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function getWarGroup(param1:int, param2:int) : WorldFactionWarGroupClass
        {
            return WorldFactionWarGroupClass.list[param1][param2] as WorldFactionWarGroupClass;
        }// end function

        public function get isWarComplete() : Boolean
        {
            return this.STEP_1_Complete() == this.stateServer;
        }// end function

        public function getFaction(param1:int) : FactionClass
        {
            var _loc_2:* = new FactionClass();
            this._factionList[param1] = new FactionClass();
            return this._factionList[param1] || _loc_2;
        }// end function

    }
}

class FactionClass extends Object
{
    public var id:int = 0;
    public var name:String = "";
    public var num:int = 0;
    public var lv:int = 0;
    public var fullName:String = "";
    public var from:String = "";
    public var iconUrl:String = "";
    public var price:Number = 0;
    public var totalStrength:int = 0;
    public var coin:int = 0;
    public var isLost:Boolean = false;

    function FactionClass()
    {
        return;
    }// end function

    public function init(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:String, param8:Number) : void
    {
        this.id = param1;
        this.name = instance.removeNickNameSuffix(param6 + " " + param7);
        this.num = param4;
        this.lv = param3;
        this.totalStrength = param5;
        this.price = param8;
        this.from = param6 + " " + param7;
        this.fullName = param2;
        return;
    }// end function

    public function get nameLink() : String
    {
        if (this.id == 0)
        {
            return "";
        }
        return linkText(this.name, ["faction", this.id, this.name]);
    }// end function

    public function get nameTip() : String
    {
        if (this.id == 0)
        {
            return "";
        }
        return [this.name + "(" + this.fullName + ")", Lang.sprintf(WorldFactionWarInfoLang.FactionPrice, this.priceTip), this.numTip, this.strengthTip].join("\n");
    }// end function

    public function get priceTip() : String
    {
        if (this.price == 0)
        {
            return "0";
        }
        if (this.price >= 1000000000)
        {
            return int(this.price / 100000000) + WorldFactionWarInfoLang.Yi;
        }
        return int(this.price / 10000) + WorldFactionWarInfoLang.Wang;
    }// end function

    public function get lvTip() : String
    {
        return Lang.sprintf(WorldFactionWarInfoLang.FactionLv, this.lv);
    }// end function

    public function get numTip() : String
    {
        return Lang.sprintf(WorldFactionWarInfoLang.FactionMember, this.num);
    }// end function

    public function get strengthTip() : String
    {
        return Lang.sprintf(WorldFactionWarInfoLang.TotalStrength, this.totalStrength);
    }// end function

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

