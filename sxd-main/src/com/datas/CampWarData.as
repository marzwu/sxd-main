package com.datas
{
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.haloer.data.*;
    import com.protocols.*;

    public class CampWarData extends Base
    {
        private var _aryGetCampOpenTime:Array;
        private var _intIsOpenCampWar:int;
        private var _aryGetPlayerCampWarInfo:Array;
        private var _aryJoinCampWar:Array;
        private var _warData:WarData;
        private var _warDetail:Object;
        private var _awardFame:int;
        private var _awardCoin:int;
        private var _aryNotify:Array;
        private var _aryGetIntegral:Array;
        private var _aryGetCampPlayer:Array;
        private var _aryNotifyReport:Array;
        private var _aryOpenCampWar:Array;
        private var _aryCampLevelArea:Array;
        private var _aryCampPlayerList:Array;
        private var _objBuyBuff:Object;
        private var _objGetBuff:Object;
        private var _objSetRobot:Object;
        private var _objGetRobotStatus:Object;
        private var _objNotifyType:Object;
        private var _aryNotifyTopWinner:Array;
        private var _aryNotifyIntegral:Array;
        public var _aryPlayStatusData:Array;

        public function CampWarData()
        {
            this._aryGetCampOpenTime = [];
            this._aryGetPlayerCampWarInfo = [];
            this._aryJoinCampWar = [];
            this._aryNotify = [];
            this._aryGetIntegral = [];
            this._aryGetCampPlayer = [];
            this._aryNotifyReport = [];
            this._aryOpenCampWar = [];
            this._aryCampLevelArea = [];
            this._aryCampPlayerList = [];
            this._objBuyBuff = {};
            this._objGetBuff = {};
            this._objSetRobot = {};
            this._objGetRobotStatus = {};
            this._objNotifyType = {};
            this._aryNotifyTopWinner = [];
            this._aryNotifyIntegral = [];
            this._aryPlayStatusData = [];
            return;
        }// end function

        public function openCampWar() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._aryOpenCampWar, _loc_1, ["top_player_id", "top_player_nick_name", "top_win_times", "camp_id", "shushan_integral", "kunlun_integral", "max_win_times", "win_times", "current_win_times", "lose_times", "get_fame", "get_coin", "status"]);
            _loc_1["top_player_nick_name"] = this._data.player.removeNickNameSuffix(_loc_1["top_player_nick_name"]);
            return _loc_1;
        }// end function

        public function getCampOpenTime() : Array
        {
            return this._aryGetCampOpenTime;
        }// end function

        public function getIsOpenCampWar() : int
        {
            return this._intIsOpenCampWar;
        }// end function

        public function getCampPlayer() : Array
        {
            return this._aryCampPlayerList;
        }// end function

        public function getCampLevelArea() : Array
        {
            return this._aryCampLevelArea;
        }// end function

        public function getJoinCampWar() : Object
        {
            var _loc_1:Object = {result:this._aryJoinCampWar[0]};
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
            for each (_loc_3 in this._aryNotifyTopWinner)
            {
                
                _loc_1 = {};
                oObject.list(_loc_3, _loc_1, ["min_level", "max_level", "top_player_id", "top_player_nick_name", "top_win_times", "camp_id"]);
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

        public function getNotifyPlayerCampInfo() : Object
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

        public function getRobotStatus() : Object
        {
            return this._objGetRobotStatus;
        }// end function

        private function testPlayerData() : Array
        {
            var _loc_1:Array = [{min_level:40, max_level:80, player_id:Math.ceil(Math.random() * 1000), player_nick_name:"t11", status:Mod_CampWar_Base.JOIN_CAMP_WAR, camp_id:FactionType.ShuShanCheng}];
            return _loc_1;
        }// end function

        private function testReportData() : Array
        {
            var _loc_1:Array = [{winner_player_id:41, loser_player_id:60, winner_nick_name:"no me", loser_nick_name:"no you", winner_camp_id:3, loser_camp_id:4, win_times:3, winner_get_fame:20, winner_get_coin:1000, loser_get_fame:10, loser_get_coin:500, loser_win_times:2}];
            return _loc_1;
        }// end function

        public function get_camp_open_time(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this._aryGetCampOpenTime = [];
            for each (_loc_3 in param1[1])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["start_time", "end_time"]);
                this._aryGetCampOpenTime.push(_loc_2);
            }
            this._aryGetCampOpenTime.sortOn("start_time", Array.NUMERIC);
            this._intIsOpenCampWar = param1[0] as int;
            return;
        }// end function

        public function open_camp_war(param1:Array) : void
        {
            this._aryOpenCampWar = param1;
            return;
        }// end function

        public function close_camp_war() : void
        {
            return;
        }// end function

        public function get_camp_player(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            var _loc_5:Array = null;
            this._aryCampLevelArea = [];
            this._aryCampPlayerList = [];
            for each (_loc_4 in param1[1])
            {
                
                _loc_2 = {};
                _loc_2["camp_id"] = param1[0];
                _loc_2["min_level"] = _loc_4[0];
                _loc_2["max_level"] = _loc_4[1];
                _loc_2["length"] = (_loc_4[2] as Array).length;
                this._aryCampLevelArea.push(_loc_2);
                for each (_loc_5 in _loc_4[2])
                {
                    
                    _loc_3 = {};
                    _loc_3["min_level"] = _loc_4[0];
                    _loc_3["max_level"] = _loc_4[1];
                    oObject.list(_loc_5, _loc_3, ["player_id", "player_nick_name", "status"]);
                    _loc_3["player_nick_name"] = this._data.player.removeNickNameSuffix(_loc_3["player_nick_name"]);
                    this._aryCampPlayerList.push(_loc_3);
                }
            }
            this._aryCampLevelArea.sortOn("min_level", Array.DESCENDING);
            return;
        }// end function

        public function join_camp_war(param1:Array) : void
        {
            this._aryJoinCampWar = param1;
            return;
        }// end function

        public function exit_camp_war() : void
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
            if (param1[0] == Mod_CampWar_Base.PLAYER_JOIN_CAMP_WAR || param1[0] == Mod_CampWar_Base.PLAYER_EXIT_CAMP_WAR || param1[0] == Mod_CampWar_Base.UPDATE_PLAYER_CAMP_STATUS)
            {
                if (this._aryPlayStatusData.length > 1500)
                {
                    this._aryPlayStatusData = [];
                }
                _loc_2 = {};
                for each (_loc_3 in param1[1])
                {
                    
                    _loc_2 = {};
                    oObject.list(_loc_3, _loc_2, ["player_id", "player_nick_name", "camp_id", "min_level", "max_level", "status"]);
                    _loc_2["player_nick_name"] = this._data.player.removeNickNameSuffix(_loc_2["player_nick_name"]);
                    if (param1[0] != Mod_CampWar_Base.UPDATE_PLAYER_CAMP_STATUS)
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
            else if (param1[0] == Mod_CampWar_Base.UPDATE_INTEGRAL || param1[0] == Mod_CampWar_Base.END_CAMP_WAR)
            {
                this._aryNotifyIntegral = param1[3][0];
            }
            else if (param1[0] == Mod_CampWar_Base.UPDATE_TOP_WINNER)
            {
                this._aryNotifyTopWinner = param1[2];
            }
            else
            {
                this._aryNotify = param1;
            }
            return;
        }// end function

        public function get_integral(param1:Array) : void
        {
            this._aryGetIntegral = param1;
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
                oObject.list(_loc_3, _loc_2, ["winner_player_id", "loser_player_id", "winner_nick_name", "loser_nick_name", "winner_camp_id", "loser_camp_id", "win_times", "winner_get_fame", "winner_get_coin", "loser_get_fame", "loser_get_coin", "loser_win_times", "stop_loser_win_fame"]);
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

    }
}
