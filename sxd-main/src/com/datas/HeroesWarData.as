package com.datas
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.haloer.data.*;
    import com.protocols.*;

    public class HeroesWarData extends Base
    {
        private var _aryGetHeroesOpenTime:Array;
        private var _intIsOpenHeroesWar:int;
        private var _aryGetPlayerHeroesWarInfo:Array;
        private var _aryJoinHeroesWar:Array;
        private var _warData:WarData;
        private var _warDetail:Object;
        private var _awardFame:int;
        private var _awardCoin:int;
        private var _aryNotify:Array;
        private var _aryGetIntegral:Array;
        private var _aryGetHeroesPlayer:Array;
        private var _aryNotifyReport:Array;
        private var _objOpenHeroesWar:Object;
        private var _aryHeroesLevelArea:Array;
        private var _aryHeroesPlayerList:Array;
        private var _objBuyBuff:Object;
        private var _objGetBuff:Object;
        private var _objSetRobot:Object;
        private var _objGetRobotStatus:Object;
        private var _objGetWarMode:Object;
        private var _objNotifyFirstOpenHeroesWar:Object;
        private var _objNotifyType:Object;
        private var _aryNotifyTopWinner:Array;
        private var _aryNotifyIntegral:Array;
        public var _aryPlayStatusData:Array;

        public function HeroesWarData()
        {
            this._aryGetHeroesOpenTime = [];
            this._aryGetPlayerHeroesWarInfo = [];
            this._aryJoinHeroesWar = [];
            this._aryNotify = [];
            this._aryGetIntegral = [];
            this._aryGetHeroesPlayer = [];
            this._aryNotifyReport = [];
            this._objOpenHeroesWar = {};
            this._aryHeroesLevelArea = [];
            this._aryHeroesPlayerList = [];
            this._objBuyBuff = {};
            this._objGetBuff = {};
            this._objSetRobot = {};
            this._objGetRobotStatus = {};
            this._objGetWarMode = {};
            this._objNotifyFirstOpenHeroesWar = {};
            this._objNotifyType = {};
            this._aryNotifyTopWinner = [];
            this._aryNotifyIntegral = [];
            this._aryPlayStatusData = [];
            return;
        }// end function

        public function openHeroesWar() : Object
        {
            return this._objOpenHeroesWar;
        }// end function

        public function getHeroesOpenTime() : Array
        {
            return this._aryGetHeroesOpenTime;
        }// end function

        public function getIsOpenHeroesWar() : int
        {
            return this._intIsOpenHeroesWar;
        }// end function

        public function getHeroesPlayer() : Array
        {
            return this._aryHeroesPlayerList;
        }// end function

        public function getHeroesLevelArea() : Array
        {
            return this._aryHeroesLevelArea;
        }// end function

        public function getJoinHeroesWar() : Object
        {
            var _loc_1:Object = {result:this._aryJoinHeroesWar[0]};
            return _loc_1;
        }// end function

        public function getWarResult() : WarData
        {
            return this._warData;
        }// end function

        public function getWarDetail() : Object
        {
            return this._warDetail;
        }// end function

        public function getAwardFame() : int
        {
            return this._awardFame;
        }// end function

        public function getAwardCoin() : int
        {
            return this._awardCoin;
        }// end function

        public function getNotifyType() : Object
        {
            return this._objNotifyType;
        }// end function

        public function getNotifyTopWinner() : Array
        {
            var _loc_1:Object = null;
            var _loc_3:Array = null;
            var _loc_2:Array = [];
            for each (_loc_3 in this._aryNotifyTopWinner[2])
            {
                
                _loc_1 = {};
                oObject.list(_loc_3, _loc_1, ["top_player_id", "top_player_nick_name", "top_win_times", "team_id", "role_id"]);
                _loc_1["url"] = URI.iconsUrl + RoleType.getRoleSign(_loc_1["role_id"]) + ".png";
                _loc_1["top_player_nick_name"] = this._data.player.removeNickNameSuffix(_loc_1["top_player_nick_name"]);
                _loc_2.push(_loc_1);
            }
            return _loc_2;
        }// end function

        public function getNotifyIntegral() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._aryNotifyIntegral, _loc_1, ["shushan_integral", "kunlun_integral", "win_camp_id"]);
            return _loc_1;
        }// end function

        public function getNotifyPlayerHeroesInfo() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._aryNotify[4][0], _loc_1, ["max_win_times", "win_times", "current_win_times", "lose_times", "get_fame", "get_coin", "status"]);
            return _loc_1;
        }// end function

        public function getWarReport() : Array
        {
            var _loc_1:* = this._aryNotifyReport.slice(0);
            this._aryNotifyReport = [];
            return _loc_1;
        }// end function

        public function get getWarReportLength() : int
        {
            return this._aryNotifyReport.length;
        }// end function

        public function get getPlayerStatusDataLength() : int
        {
            return this._aryPlayStatusData.length;
        }// end function

        public function getPlayerStatusData() : Array
        {
            var _loc_1:* = this._aryPlayStatusData.slice(0);
            this._aryPlayStatusData = [];
            return _loc_1;
        }// end function

        public function buyBuff() : Object
        {
            return this._objBuyBuff;
        }// end function

        public function getBuff() : Object
        {
            return this._objGetBuff;
        }// end function

        public function setRobot() : Object
        {
            return this._objSetRobot;
        }// end function

        public function getWarMode() : Object
        {
            return this._objGetWarMode;
        }// end function

        public function getRobotStatus() : Object
        {
            return this._objGetRobotStatus;
        }// end function

        public function notifyFirstOpenHeroesWar() : Object
        {
            return this._objNotifyFirstOpenHeroesWar;
        }// end function

        private function testPlayerData() : Array
        {
            var _loc_1:Array = [{min_level:40, max_level:80, player_id:Math.ceil(Math.random() * 1000), player_nick_name:"t11", status:Mod_HeroesWar_Base.JOIN_HEROES_WAR, team_id:FactionType.ShuShanCheng}];
            return _loc_1;
        }// end function

        private function testReportData() : Array
        {
            var _loc_1:Array = [{winner_player_id:41, loser_player_id:60, winner_nick_name:"no me", loser_nick_name:"no you", winner_team_id:3, loser_team_id:4, win_times:3, winner_get_fame:20, winner_get_coin:1000, loser_get_fame:10, loser_get_coin:500, loser_win_times:2}];
            return _loc_1;
        }// end function

        public function get_heroes_open_time(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this._aryGetHeroesOpenTime = [];
            for each (_loc_3 in param1[1])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["start_time", "end_time"]);
                this._aryGetHeroesOpenTime.push(_loc_2);
            }
            this._aryGetHeroesOpenTime.sortOn("start_time", Array.NUMERIC);
            this._intIsOpenHeroesWar = param1[0] as int;
            return;
        }// end function

        public function open_heroes_war(param1:Array) : void
        {
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            this._objOpenHeroesWar = {};
            oObject.list(param1, this._objOpenHeroesWar, ["team_a_integral", "team_b_integral", "max_win_times", "win_times", "current_win_times", "lose_times", "get_fame", "get_coin", "status"]);
            var _loc_2:Array = [];
            for each (_loc_4 in param1[(param1.length - 1)])
            {
                
                _loc_3 = {};
                oObject.list(_loc_4, _loc_3, ["top_player_id", "top_player_nick_name", "top_win_times", "team_id", "role_id"]);
                _loc_3["url"] = URI.iconsUrl + RoleType.getRoleSign(_loc_3["role_id"]) + ".png";
                _loc_3["top_player_nick_name"] = this._data.player.removeNickNameSuffix(_loc_3["top_player_nick_name"]);
                _loc_2.push(_loc_3);
            }
            this._objOpenHeroesWar["top_player_list"] = _loc_2;
            return;
        }// end function

        public function close_heroes_war() : void
        {
            return;
        }// end function

        public function get_heroes_player(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            var _loc_5:Array = null;
            this._aryHeroesLevelArea = [];
            this._aryHeroesPlayerList = [];
            for each (_loc_4 in param1[1])
            {
                
                _loc_2 = {};
                _loc_2["team_id"] = param1[0];
                _loc_2["min_level"] = _loc_4[0];
                _loc_2["max_level"] = _loc_4[1];
                _loc_2["length"] = (_loc_4[2] as Array).length;
                this._aryHeroesLevelArea.push(_loc_2);
                for each (_loc_5 in _loc_4[2])
                {
                    
                    _loc_3 = {};
                    _loc_3["min_level"] = _loc_4[0];
                    _loc_3["max_level"] = _loc_4[1];
                    oObject.list(_loc_5, _loc_3, ["player_id", "player_nick_name", "status"]);
                    _loc_3["player_nick_name"] = this._data.player.removeNickNameSuffix(_loc_3["player_nick_name"]);
                    this._aryHeroesPlayerList.push(_loc_3);
                }
            }
            this._aryHeroesLevelArea.sortOn("min_level", Array.DESCENDING);
            return;
        }// end function

        public function join_heroes_war(param1:Array) : void
        {
            this._aryJoinHeroesWar = param1;
            return;
        }// end function

        public function exit_heroes_war() : void
        {
            return;
        }// end function

        public function get_war_result(param1:Array) : void
        {
            var _loc_2:Array = [0, 0, 0, param1[0]];
            this._warData = new WarData();
            this._warData.format(_loc_2);
            this._awardFame = param1[1];
            this._awardCoin = param1[2];
            this._warDetail = {attackerCurWinTop:param1[3], attackerWinTop:param1[4], defenderCurWinTop:param1[5], defenderWinTop:param1[6], attackerInspire:param1[7], defenderInspire:param1[8]};
            return;
        }// end function

        public function notify(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this._objNotifyType = {notify_type:param1[0]};
            if (param1[0] == Mod_HeroesWar_Base.PLAYER_JOIN_HEROES_WAR || param1[0] == Mod_HeroesWar_Base.PLAYER_EXIT_HEROES_WAR || param1[0] == Mod_HeroesWar_Base.UPDATE_PLAYER_HEROES_STATUS)
            {
                if (this._aryPlayStatusData.length > 1500)
                {
                    this._aryPlayStatusData = [];
                }
                _loc_2 = {};
                for each (_loc_3 in param1[1])
                {
                    
                    _loc_2 = {};
                    oObject.list(_loc_3, _loc_2, ["player_id", "player_nick_name", "team_id", "min_level", "max_level", "status"]);
                    _loc_2["player_nick_name"] = this._data.player.removeNickNameSuffix(_loc_2["player_nick_name"]);
                    if (param1[0] != Mod_HeroesWar_Base.UPDATE_PLAYER_HEROES_STATUS)
                    {
                        _loc_2["status"] = param1[0];
                    }
                    this._aryPlayStatusData.push(_loc_2);
                }
                if (this._aryNotify.length > 0)
                {
                    this._aryNotify = [];
                }
            }
            else if (param1[0] == Mod_HeroesWar_Base.UPDATE_INTEGRAL || param1[0] == Mod_HeroesWar_Base.END_HEROES_WAR)
            {
                this._aryNotifyIntegral = param1[3][0];
            }
            else if (param1[0] == Mod_HeroesWar_Base.UPDATE_TOP_WINNER)
            {
                this._aryNotifyTopWinner = param1[2][0];
            }
            else
            {
                this._aryNotify = param1;
            }
            return;
        }// end function

        public function notify_report(param1:Array) : void
        {
            var _loc_3:Array = null;
            if (this._aryNotifyReport.length > 1000)
            {
                this._aryNotifyReport = [];
            }
            var _loc_2:Object = {};
            for each (_loc_3 in param1[0])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["winner_player_id", "loser_player_id", "winner_nick_name", "loser_nick_name", "winner_team_id", "loser_team_id", "win_times", "winner_get_fame", "winner_get_coin", "loser_get_fame", "loser_get_coin", "loser_win_times", "stop_loser_win_fame"]);
                _loc_2["winner_nick_name"] = this._data.player.removeNickNameSuffix(_loc_2["winner_nick_name"]);
                _loc_2["loser_nick_name"] = this._data.player.removeNickNameSuffix(_loc_2["loser_nick_name"]);
                this._aryNotifyReport.push(_loc_2);
            }
            return;
        }// end function

        public function finish_war(param1:Array) : void
        {
            return;
        }// end function

        public function buy_buff(param1:Array) : void
        {
            oObject.list(param1, this._objBuyBuff, ["result", "add_buff_value", "buff_value"]);
            return;
        }// end function

        public function get_buff(param1:Array) : void
        {
            this._objGetBuff["buff_value"] = param1[0];
            return;
        }// end function

        public function set_robot(param1:Array) : void
        {
            this._objSetRobot["result"] = param1[0];
            return;
        }// end function

        public function get_robot_status(param1:Array) : void
        {
            oObject.list(param1, this._objGetRobotStatus, ["result", "last_award_coin", "last_award_fame"]);
            return;
        }// end function

        public function get_war_mode(param1:Array) : void
        {
            this._objGetWarMode = {mode:param1[0]};
            return;
        }// end function

        public function notify_first_open_heroes_war(param1:Array) : void
        {
            this._objNotifyFirstOpenHeroesWar["player_nickname"] = this._data.player.removeNickNameSuffix(param1[0]);
            return;
        }// end function

    }
}
