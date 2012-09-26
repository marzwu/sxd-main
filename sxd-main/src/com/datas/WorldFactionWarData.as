package com.datas
{
    import com.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.haloer.data.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;
    import flash.utils.*;

    public class WorldFactionWarData extends Base
    {
        public var signUpType:int = 0;
        public var result:int = 0;
        public var info:WorldFactionWarInfo;
        public var signUpList:Array;
        public var dieOutTip:String = "";
        public var dieOutWarList:Array;
        public var warData:Array;
        public var seeRecordList:Array;
        public var myRank:int = 0;
        public var betRank:Array;
        public var memberList:Array;
        public var recordList:Array;
        public var recordTip:String = "";

        public function WorldFactionWarData()
        {
            this.info = new WorldFactionWarInfo();
            this.signUpList = [];
            this.dieOutWarList = [];
            this.seeRecordList = [];
            this.recordList = [];
            return;
        }// end function

        public function get_race_step(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["is_can_sign_up", "race_type", "race_step", "team", "player_faction_step", "war_round", "player_number", "time_list", "cup_race_time_step", "apply_id", "group", "war_zone", "server_list", "server_time"]);
            this.signUpType = _loc_2.is_can_sign_up;
            this.info.removeNickNameSuffix = _data.player.removeNickNameSuffix;
            this.info.appName = _data.player.playerInfo.factionName;
            this.info.serverInitTime = Number(_loc_2.server_time) * 1000 - getTimer();
            this.info.roundTimeInterval = _loc_2.cup_race_time_step * 1000;
            this.info.stateServer = _loc_2.race_step;
            this.info.stateTeam = _loc_2.team;
            this.info.statePlayer = _loc_2.player_faction_step;
            this.info.appId = _loc_2.apply_id;
            this.info.zoneIdx = int(_loc_2.war_zone);
            this.info.zoneName = Lang.sprintf(WorldFactionWarDataLang.ZoneName, _loc_2.war_zone);
            for each (_loc_3 in _loc_2.time_list)
            {
                
                this.info.roundTimeList[_loc_3[0]] = _loc_3[1] * 1000;
            }
            this.info.serverNameList = [];
            for each (_loc_3 in _loc_2.server_list)
            {
                
                this.info.serverNameList.push(_loc_3.join(" "));
            }
            this.dieOutTip = "";
            if (_loc_2.race_step == Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_TIANBANG)
            {
                this.dieOutTip = Lang.sprintf(WorldFactionWarDataLang.OutWarTip, _loc_2.war_round, _loc_2.player_number);
            }
            else if (_loc_2.race_step == Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG)
            {
                this.dieOutTip = Lang.sprintf(WorldFactionWarDataLang.OutWarTip, _loc_2.war_round, _loc_2.player_number);
            }
            return;
        }// end function

        public function get_race_list(param1:Array) : void
        {
            var _loc_5:Array = null;
            var _loc_6:Array = null;
            var _loc_7:Array = null;
            var _loc_8:Object = null;
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["group", "faction_list", "current_war_result", "top_16", "top_8", "top_4", "top_2", "top_1", "can_bet_coin_list"]);
            var _loc_3:Array = [null];
            var _loc_4:Array = [];
            for each (_loc_5 in _loc_2.faction_list)
            {
                
                _loc_6 = _loc_5.slice(0, 8);
                _loc_7 = _loc_5.slice(8, 16);
                this.info.getFaction(_loc_6[0]).init(_loc_6[0], _loc_6[1], _loc_6[2], _loc_6[3], _loc_6[4], _loc_6[5], _loc_6[6], _loc_6[7]);
                this.info.getFaction(_loc_7[0]).init(_loc_7[0], _loc_7[1], _loc_7[2], _loc_7[3], _loc_7[4], _loc_7[5], _loc_7[6], _loc_7[7]);
                _loc_3.push([_loc_6[0], _loc_7[0]]);
                if (_loc_6[0] != 0)
                {
                    _loc_4.push(_loc_6[0]);
                }
                if (_loc_7[0] != 0)
                {
                    _loc_4.push(_loc_7[0]);
                }
            }
            this.info.resetCupGroup(_loc_3, _loc_4, this.mergerArray(_loc_2.top_4), this.mergerArray(_loc_2.top_2), [_loc_2.top_1]);
            this.info.cupRoundObjList = [];
            for each (_loc_5 in _loc_2.current_war_result)
            {
                
                _loc_8 = {};
                oObject.list(_loc_5, _loc_8, ["result", "apply_id1", "apply_id2", "race_step", "round", "war_apply_id", "report_version"]);
                this.info.cupRoundObjList[_loc_8.round] = _loc_8;
            }
            this.info.cupBetList = [];
            for each (_loc_5 in _loc_2.can_bet_coin_list)
            {
                
                this.info.cupBetList.push({label:int(_loc_5[0] / 10000) + WorldFactionWarDataLang.Wang, num:int(_loc_5[0])});
            }
            return;
        }// end function

        private function mergerArray(param1:Array) : Array
        {
            var _loc_3:int = 0;
            var _loc_2:Array = [];
            for each (_loc_3 in param1)
            {
                
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        public function get_war_result_list(param1:Array) : void
        {
            var _loc_8:Object = null;
            var _loc_9:Array = null;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            this.seeRecordList = [];
            param1[3].sortOn("0", Array.NUMERIC);
            var _loc_2:Array = [WorldFactionWarDataLang.Ju3, WorldFactionWarDataLang.Ju2, WorldFactionWarDataLang.Ju1];
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:* = param1[0];
            var _loc_6:* = param1[1];
            var _loc_7:* = param1[2];
            for each (_loc_9 in param1[3])
            {
                
                _loc_10 = _loc_9[1];
                _loc_11 = _loc_9[0];
                _loc_8 = {};
                _loc_8.name = _loc_2.pop() + "【" + this.info.getFaction(_loc_10).nameLink + "】" + WorldFactionWarDataLang.Win;
                _loc_8.see = this.linkText(WorldFactionWarDataLang.See, ["war", _loc_5, _loc_6, _loc_7, _loc_11]);
                if (_loc_10 == _loc_5)
                {
                    _loc_3++;
                }
                else if (_loc_10 == _loc_6)
                {
                    _loc_4++;
                }
                this.seeRecordList.push(_loc_8);
            }
            if (_loc_2.length == 3 && this.info.nowGroup.warState != 1)
            {
                _loc_8 = {};
                _loc_8.name = this.info.roundTip;
                _loc_8.see = "";
                this.seeRecordList.push(_loc_8);
            }
            else if (_loc_3 < 2 && _loc_4 < 2)
            {
                _loc_8 = {};
                _loc_8.name = _loc_2.pop() + " " + WorldFactionWarDataLang.Wait;
                _loc_8.see = "";
                this.seeRecordList.push(_loc_8);
            }
            return;
        }// end function

        public function get_standings(param1:Array) : void
        {
            var _loc_5:Array = null;
            var _loc_6:Object = null;
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["race_step", "war_round", "faction_number", "group", "faction_status", "war_list"]);
            var _loc_3:String = "";
            this.dieOutTip = "";
            if (_loc_2.race_step == Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_TIANBANG)
            {
                this.dieOutTip = Lang.sprintf(WorldFactionWarDataLang.OutWarTip, _loc_2.war_round, _loc_2.faction_number);
                _loc_3 = WorldFactionWarDataLang.OutWar;
            }
            else if (_loc_2.race_step == Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG)
            {
                this.dieOutTip = Lang.sprintf(WorldFactionWarDataLang.OutWarTip, _loc_2.war_round, _loc_2.faction_number);
                _loc_3 = WorldFactionWarDataLang.OutWar;
            }
            if (this.dieOutTip != "")
            {
                if (_loc_2.faction_status == 1)
                {
                    this.dieOutTip = this.dieOutTip + WorldFactionWarDataLang.YouIn8;
                    _loc_3 = WorldFactionWarDataLang.OutWar;
                }
                else if (_loc_2.faction_status == 2)
                {
                    this.dieOutTip = HtmlText.red(this.dieOutTip + WorldFactionWarDataLang.YouOut);
                }
                this.dieOutTip = HtmlText.green(this.dieOutTip);
            }
            var _loc_4:int = 0;
            _loc_2.war_list.sortOn("3", Array.NUMERIC);
            this.dieOutWarList = [];
            for each (_loc_5 in _loc_2.war_list)
            {
                
                _loc_6 = {};
                oObject.list(_loc_5, _loc_6, ["apply_id", "faction_name", "race_step", "round", "result", "war_apply_id", "report_version"]);
                _loc_6.id = _loc_6.apply_id;
                _loc_6.name = _data.player.removeNickNameSuffix(_loc_6.faction_name);
                _loc_6.idx = this.info.getStateName(_loc_6.race_step, 0);
                if (_loc_6.result == 1)
                {
                    _loc_6.mark = HtmlText.white("1:0");
                    _loc_6.win = HtmlText.white(WorldFactionWarDataLang.Win);
                }
                else
                {
                    _loc_6.mark = HtmlText.red("0:1");
                    _loc_6.win = HtmlText.red(WorldFactionWarDataLang.NoWin);
                }
                _loc_6.win = this.linkText(_loc_6.win, ["war", this.info.appId, _loc_6.apply_id, _loc_6.race_step, _loc_6.round]);
                this.dieOutWarList.push(_loc_6);
            }
            return;
        }// end function

        public function sign_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            this.signUpList = [];
            this.myRank = param1[0];
            var _loc_2:int = 0;
            for each (_loc_3 in param1[1])
            {
                
                _loc_2++;
                _loc_4 = {};
                _loc_4.id = _loc_3[0];
                _loc_4.rowname = _data.player.removeNickNameSuffix(_loc_3[1]);
                _loc_4.nickName = _loc_4.rowname;
                _loc_4.lv = _loc_3[2] + "";
                _loc_4.times = _loc_3[3] + "";
                _loc_4.color = 16777215;
                this.signUpList.push(_loc_4);
                if (_loc_3[0] == _data.player.playerInfo.id)
                {
                    _loc_4.color = 15964160;
                }
            }
            return;
        }// end function

        public function sign_up(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result == Mod_WorldFactionWar_Base.SUCCESS)
            {
                this.signUpType = 2;
            }
            return;
        }// end function

        public function get_player_bet(param1:Array) : void
        {
            this.info.setGuessList(param1[0]);
            return;
        }// end function

        public function bet(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function get_bet_coin_rank(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            param1[0].sortOn("4", Array.DESCENDING | Array.NUMERIC);
            this.betRank = [];
            var _loc_2:int = 0;
            for each (_loc_3 in param1[0])
            {
                
                _loc_4 = {};
                _loc_4.name = ++_loc_2 + " " + _data.player.removeNickNameSuffix(_loc_3[1]);
                _loc_4.nameTip = Lang.sprintf(WorldFactionWarDataLang.From, _loc_3[2], _loc_3[3]);
                _loc_4.bet = this.coinString(_loc_3[4]);
                this.betRank.push(_loc_4);
            }
            return;
        }// end function

        public function fight_member_list(param1:Array) : void
        {
            var _loc_4:Object = null;
            var _loc_5:Array = null;
            var _loc_6:int = 0;
            var _loc_2:Array = [WorldFactionWarDataLang.Job0, WorldFactionWarDataLang.Job1, WorldFactionWarDataLang.Job2];
            var _loc_3:Array = [0, 268435455, 16777215];
            this.memberList = [];
            for each (_loc_5 in param1[0])
            {
                
                _loc_4 = {};
                _loc_4.name = _data.player.removeNickNameSuffix(_loc_5[1]);
                _loc_4.job = _loc_2[_loc_5[3]];
                _loc_4.lv = _loc_5[2] + WorldFactionWarDataLang.Ji;
                _loc_4.war = WorldFactionWarDataLang.War + _loc_5[4];
                _loc_4.priority = _loc_3[_loc_5[3]] + _loc_5[4];
                this.memberList.push(_loc_4);
            }
            this.memberList.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
            _loc_6 = 0;
            for each (_loc_4 in this.memberList)
            {
                
                _loc_4.name = ++_loc_6 + " " + _loc_4.name;
            }
            return;
        }// end function

        public function get_race_standings(param1:Array) : void
        {
            var _loc_8:Array = null;
            var _loc_9:Array = null;
            this.recordList = [];
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:String = "";
            var _loc_5:Object = {};
            var _loc_6:Object = {};
            var _loc_7:int = 0;
            for each (_loc_8 in param1[0])
            {
                
                _loc_6 = {};
                oObject.list(_loc_8, _loc_6, ["race_step", "apply_id", "faction_name", "war_list", "group"]);
                if (_loc_6.apply_id == 0)
                {
                    continue;
                }
                _loc_6.round = this.info.getStateName(_loc_6.race_step, 0);
                _loc_6.name = _data.player.removeNickNameSuffix(_loc_6.faction_name);
                _loc_6.name = WorldFactionWarDataLang.DuiZheng + this.linkText(_loc_6.name, ["faction", _loc_6.apply_id, _loc_6.faction_name]);
                _loc_6.war = "";
                _loc_6.win = 0;
                _loc_6.priority = _loc_6.race_step * 500;
                var _loc_12:int = 0;
                _loc_3 = 0;
                _loc_2 = _loc_12;
                _loc_6.war_list.sortOn("2", Array.NUMERIC);
                _loc_9 = [WorldFactionWarDataLang.Ju3, WorldFactionWarDataLang.Ju2, WorldFactionWarDataLang.Ju1];
                for each (_loc_8 in _loc_6.war_list)
                {
                    
                    _loc_5 = {};
                    oObject.list(_loc_8, _loc_5, ["result", "race_step", "round", "war_apply_id", "report_version"]);
                    if (_loc_5.result == 1)
                    {
                        _loc_2++;
                        _loc_4 = _loc_9.pop();
                    }
                    else
                    {
                        _loc_3++;
                        _loc_4 = HtmlText.red(_loc_9.pop());
                    }
                    _loc_6.war = _loc_6.war + this.linkText(_loc_4, ["war", this.info.appId, _loc_6.apply_id, _loc_5.race_step, _loc_5.round]) + "   ";
                    _loc_6.priority = _loc_6.priority + _loc_5.round;
                }
                _loc_6.mark = _loc_2 + ":" + _loc_3;
                if (_loc_6.race_step == Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_TIANBANG || _loc_6.race_step == Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG)
                {
                    _loc_6.round = _loc_6.round + Lang.sprintf(WorldFactionWarDataLang.DiJiLun, _loc_5.round);
                    if (_loc_2 == 1)
                    {
                        _loc_6.mark = _loc_6.mark + WorldFactionWarDataLang.Win;
                        _loc_6.win = 1;
                    }
                    else
                    {
                        _loc_6.mark = _loc_6.mark + WorldFactionWarDataLang.NoWin;
                        _loc_6.win = 2;
                        _loc_7++;
                    }
                }
                else if (_loc_2 >= 2)
                {
                    _loc_6.mark = _loc_6.mark + WorldFactionWarDataLang.Win;
                    _loc_6.win = 1;
                }
                else if (_loc_3 >= 2)
                {
                    _loc_6.mark = _loc_6.mark + WorldFactionWarDataLang.NoWin;
                    _loc_6.win = 2;
                    _loc_7 = 3;
                }
                this.recordList.push(_loc_6);
            }
            this.recordList.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
            _loc_5 = this.recordList[0];
            this.recordTip = WorldFactionWarDataLang.NoWar;
            if (_loc_5 != null)
            {
                if (_loc_7 >= 3)
                {
                    this.recordTip = WorldFactionWarDataLang.YouOut;
                }
                else if (_loc_5.win == 0)
                {
                    this.recordTip = Lang.sprintf(WorldFactionWarDataLang.Waring, this.info.getStateName(_loc_5.race_step, _loc_5.group));
                }
                else
                {
                    switch(_loc_5.race_step)
                    {
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_TIANBANG:
                        {
                            this.recordTip = Lang.sprintf(WorldFactionWarDataLang.YouIn, this.info.getStateName(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4, Mod_WorldFactionWar_Base.GROUP_TIAN_BANG));
                            break;
                        }
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG:
                        {
                            this.recordTip = Lang.sprintf(WorldFactionWarDataLang.YouIn, this.info.getStateName(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4, Mod_WorldFactionWar_Base.GROUP_DI_BANG));
                            break;
                        }
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4:
                        {
                            this.recordTip = Lang.sprintf(WorldFactionWarDataLang.YouIn, this.info.getStateName(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2, _loc_5.group));
                            break;
                        }
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2:
                        {
                            this.recordTip = Lang.sprintf(WorldFactionWarDataLang.YouIn, this.info.getStateName(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1, _loc_5.group));
                            break;
                        }
                        case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1:
                        {
                            this.recordTip = _loc_5.group == Mod_WorldFactionWar_Base.GROUP_TIAN_BANG ? (WorldFactionWarDataLang.YouWin) : (WorldFactionWarDataLang.YouWin);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            return;
        }// end function

        public function getStateLv(param1:int) : int
        {
            switch(param1)
            {
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG_COMPLETE:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4:
                {
                    return 4;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4_COMPLETE:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2:
                {
                    return 2;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2_COMPLETE:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1_COMPLETE:
                {
                    return 1;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        private function linkText(param1:String, param2:Array) : String
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            if (param2[0] == "war")
            {
                _loc_3 = param2[1];
                _loc_4 = param2[2];
                switch(param2[3])
                {
                    case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG:
                    case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_TIANBANG:
                    {
                        if (_loc_4 == this.info.appId)
                        {
                            var _loc_5:* = _loc_3;
                            _loc_4 = _loc_3;
                            _loc_3 = _loc_4 + 0 * _loc_5;
                        }
                        break;
                    }
                    default:
                    {
                        if (_loc_4 > _loc_3)
                        {
                            var _loc_5:* = _loc_3;
                            _loc_4 = _loc_3;
                            _loc_3 = _loc_4 + 0 * _loc_5;
                        }
                        break;
                        break;
                    }
                }
                param2[1] = _loc_3;
                param2[2] = _loc_4;
            }
            return "<u><a href=\'event:" + param2.join("_") + "\'>" + param1 + "</a></u>";
        }// end function

        private function coinString(param1:Number) : String
        {
            if (param1 == 0)
            {
                return "0";
            }
            if (param1 >= 1000000000)
            {
                return int(param1 / 100000000) + WorldFactionWarDataLang.Yi;
            }
            return int(param1 / 10000) + WorldFactionWarDataLang.Wang;
        }// end function

        public function world_faction_war_report(param1:Array) : void
        {
            this.warData = param1;
            return;
        }// end function

        public function award_info(param1:Array) : void
        {
            var _loc_2:* = new Object();
            var _loc_3:int = 0;
            _loc_2.is_have_award = param1[_loc_3++];
            _loc_2.is_can_receive = param1[_loc_3++];
            _loc_2.is_receive = param1[_loc_3++];
            _loc_2.award_time = param1[_loc_3++];
            _loc_2.fame = param1[_loc_3++];
            _loc_2.coin = param1[_loc_3++];
            _loc_2.stone = param1[_loc_3++];
            _loc_2.state_point = param1[_loc_3++];
            _loc_2.clothes_id = param1[_loc_3++];
            this.info.awardInfo = _loc_2;
            return;
        }// end function

        public function receive_award(param1:Array) : void
        {
            var _loc_2:* = new Object();
            var _loc_3:int = 0;
            _loc_2.result = param1[_loc_3++];
            _loc_2.winNo = param1[_loc_3++];
            _loc_2.fame = param1[_loc_3++];
            _loc_2.coin = param1[_loc_3++];
            _loc_2.stone = param1[_loc_3++];
            _loc_2.state_point = param1[_loc_3++];
            _loc_2.clothes_id = param1[_loc_3++];
            this.info.receiveAwardInfo = _loc_2;
            return;
        }// end function

    }
}
