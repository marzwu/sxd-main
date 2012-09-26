package com.controllers
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class WeekRankingController extends Base
    {

        public function WeekRankingController()
        {
            return;
        }// end function

        public function get getWeekRanking() : Object
        {
            var _loc_1:* = _data.weekRanking.GetWeekRanking;
            var _loc_2:Object = {};
            _loc_2.rankingType = _loc_1[0];
            var _loc_3:* = this.renderType(_loc_2.rankingType);
            _loc_2.frameNum = _loc_3.num;
            _loc_2.typeName = _loc_3.name;
            _loc_2.typeInfo = _loc_3.info;
            _loc_2.dayInfo = _loc_3.dayInfo;
            _loc_2.rankingList = this.renderWeekRanking(_loc_1[1], _loc_2.rankingType);
            return _loc_2;
        }// end function

        public function renderWeekRanking(param1:Array, param2:int) : Array
        {
            var _loc_6:Object = null;
            var _loc_7:Object = null;
            var _loc_8:int = 0;
            var _loc_3:* = param1.length;
            var _loc_4:Array = [];
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = {};
                _loc_6.rank = _loc_5 + 1;
                _loc_6.playerId = param1[_loc_5][0];
                _loc_6.roleId = param1[_loc_5][1];
                _loc_6.nickName = param1[_loc_5][2];
                _loc_7 = this.renderType(param2);
                _loc_6.frameNum = _loc_7.num;
                _loc_6.job = RoleType.getJobSignByRoleId(_loc_6.roleId) + RoleType.getRoleGender(_loc_6.roleId);
                _loc_6.url = URI.getRoleIconUrl(_loc_6.job);
                _loc_6.showValue = "";
                if (param2 == Mod_WeekRanking_Base.RANKING_TYPE_COIN)
                {
                    _loc_6.value = param1[_loc_5][3];
                    _loc_6.showValue = Math.floor(Number(_loc_6.value / 10000)) + WeekRankingControllerLang.TenThousand;
                }
                else if (param2 != Mod_WeekRanking_Base.RANKING_TYPE_MISSION)
                {
                    _loc_6.value = param1[_loc_5][3];
                }
                else
                {
                    _loc_8 = param1[_loc_5][3];
                    _loc_6.value = MissionType.getMissionName(_loc_8);
                }
                _loc_4.push(_loc_6);
                _loc_5++;
            }
            return _loc_4;
        }// end function

        private function renderType(param1:int) : Object
        {
            var _loc_2:Object = {};
            var _loc_3:int = 0;
            var _loc_4:String = "";
            var _loc_5:String = "";
            switch(param1)
            {
                case Mod_WeekRanking_Base.RANKING_TYPE_COIN:
                {
                    _loc_3 = 4;
                    _loc_4 = WeekRankingControllerLang.RANKING_TYPE_COIN;
                    _loc_5 = WeekRankingControllerLang.coinAward;
                    break;
                }
                case Mod_WeekRanking_Base.RANKING_TYPE_FAME:
                {
                    _loc_4 = WeekRankingControllerLang.RANKING_TYPE_FAME;
                    _loc_3 = 1;
                    _loc_5 = WeekRankingControllerLang.fameAward;
                    break;
                }
                case Mod_WeekRanking_Base.RANKING_TYPE_MISSION:
                {
                    _loc_4 = WeekRankingControllerLang.RANKING_TYPE_MISSION;
                    _loc_3 = 3;
                    _loc_5 = WeekRankingControllerLang.missionAward;
                    break;
                }
                case Mod_WeekRanking_Base.RANKING_TYPE_STATE_POINT:
                {
                    _loc_4 = WeekRankingControllerLang.RANKING_TYPE_STATE_POINT;
                    _loc_3 = 2;
                    _loc_5 = WeekRankingControllerLang.pointAward;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2.dayInfo = Lang.sprintf(WeekRankingControllerLang.dayAward, _loc_4);
            _loc_2.num = _loc_3;
            _loc_2.name = _loc_4;
            _loc_2.info = _loc_5;
            return _loc_2;
        }// end function

        public function get prestigeFirstList() : Array
        {
            return _data.weekRanking.prestigeFirstList;
        }// end function

        public function get rangkingOfType() : int
        {
            return _data.weekRanking.rangkingOfType;
        }// end function

    }
}
