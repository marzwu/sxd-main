package com.controllers
{
    import com.assist.*;
    import com.assist.server.*;
    import com.protocols.*;

    public class HeroMissionController extends Base
    {
        private var _rankobj:Object;
        private var _startPractice:Array;
        private var _cancelPractice:Array;
        private var _quickly:Array;

        public function HeroMissionController() : void
        {
            this._rankobj = {};
            this._rankobj[Mod_Mission_Base.SCORE_A] = "A";
            this._rankobj[Mod_Mission_Base.SCORE_B] = "B";
            this._rankobj[Mod_Mission_Base.SCORE_C] = "C";
            return;
        }// end function

        public function renderTownHeroMission(param1:int) : Array
        {
            var _loc_2:* = MissionType.getHeroMissionListByTownId(param1);
            return _loc_2;
        }// end function

        public function get openHeroMission() : Object
        {
            var _loc_1:Object = {};
            _loc_1.heroList = [];
            var _loc_2:* = _data.heroMission.getHeroMissionList;
            _loc_1.AllBuyTimes = _loc_2[1];
            _loc_1.RemainBuyTimes = _loc_2[2];
            _loc_1.BuyPrice = _loc_2[3];
            var _loc_3:* = _loc_2[0];
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_1.heroList.push(this.heroMissions(_loc_3[_loc_5]));
                _loc_5++;
            }
            return _loc_1;
        }// end function

        private function heroMissions(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.id = param1[0];
            _loc_2.isCanChallenge = param1[1];
            _loc_2.rank = this._rankobj[param1[2]];
            _loc_2.isFinished = param1[3];
            var _loc_3:* = MissionType.getMissionMonsterId(_loc_2.id);
            var _loc_4:* = MonsterType.getMonsterSign(_loc_3);
            if (MonsterType.getMonsterSign(_loc_3).length <= 1)
            {
                _loc_4 = "Temp";
            }
            _loc_2.iconUrl = URI.bossUrl + _loc_4 + ".swf";
            _loc_2.mousterId = _loc_3;
            return _loc_2;
        }// end function

        public function get buyHeroChallenge() : Object
        {
            var _loc_1:* = _data.heroMission.buyHeroChallenge;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get startPractice() : Object
        {
            var _loc_1:* = _data.heroMission.startPractice;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.practiceTime = _loc_1[1];
            return _loc_2;
        }// end function

        public function get cancelPractice() : Array
        {
            return this._cancelPractice;
        }// end function

        public function get quickly() : Object
        {
            var _loc_1:* = _data.missionPractice.getQuickly;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.timer = _loc_1[1];
            return _loc_2;
        }// end function

        public function get notify() : Object
        {
            var _loc_1:* = _data.heroMission.getNotify;
            var _loc_2:Object = {};
            _loc_2.type = _loc_1[0];
            _loc_2.newWarReport = this.renderNewWar(_loc_1[1]);
            _loc_2.rankReport = this.renderAwardItem(_loc_1[2]);
            _loc_2.emptyBagNumber = _loc_1[3];
            return _loc_2;
        }// end function

        private function renderNewWar(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.type = Mod_MissionPractice_Base.NEW_WAR_REPORT;
                _loc_5.awardExperience = this.renderExp(param1[_loc_4][0]);
                _loc_5.awardItem = this.renderAward(param1[_loc_4][1]);
                _loc_5.worship = param1[_loc_4][2];
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function renderAwardItem(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.type = Mod_MissionPractice_Base.RANK_REPORT;
                _loc_5.missionId = param1[_loc_4][0];
                _loc_5.missionName = MissionType.getMissionName(_loc_5.missionId);
                _loc_5.awardCoin = param1[_loc_4][1];
                _loc_5.awardIngot = param1[_loc_4][2];
                _loc_5.awardSkill = param1[_loc_4][3];
                _loc_5.awardExperience = this.renderExp(param1[_loc_4][4]);
                _loc_5.awardItem = this.renderAward(param1[_loc_4][5]);
                _loc_5.bless = param1[_loc_4][6];
                _loc_5.worship = param1[_loc_4][7];
                _loc_5.randomCoin = param1[_loc_4][8];
                _loc_5.randomSkill = param1[_loc_4][9];
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function renderExp(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.roleId = param1[_loc_4][0];
                _loc_5.experience = param1[_loc_4][1];
                if (_loc_5.roleId == this._ctrl.player.mainRoleId)
                {
                    _loc_5.isPlayer = true;
                    _loc_5.PlayerName = this._ctrl.player.nickname;
                }
                else
                {
                    _loc_5.isPlayer = false;
                    _loc_5.PlayerName = RoleType.getRoleName(_loc_5.roleId);
                }
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function renderAward(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.awardId = param1[_loc_4][0];
                _loc_5.awardName = ItemType.getName(_loc_5.awardId);
                _loc_5.color = ItemType.getItemColor(_loc_5.awardId);
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get getQuickly() : Object
        {
            var _loc_1:* = _data.heroMission.getQuickly;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get continuePracticeInfo() : Object
        {
            var _loc_1:* = _data.heroMission.getContinuePracticeInfo;
            var _loc_2:Object = {};
            _loc_2.isHeroPractice = _loc_1[0];
            _loc_2.townId = _loc_1[1];
            _loc_2.missionList = this.renderMonster(_loc_1[2]);
            _loc_2.practiceTime = _loc_1[3];
            return _loc_2;
        }// end function

        public function renderMonster(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = {};
                _loc_5.missionId = param1[_loc_4];
                _loc_5.missionName = MissionType.getMissionName(_loc_5.missionId);
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            return _loc_3;
        }// end function

    }
}
