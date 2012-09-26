package com.controllers
{
    import com.assist.server.*;
    import com.protocols.*;

    public class MissionPracticeController extends Base
    {
        private var _startPractice:Array;
        private var _cancelPractice:Array;
        private var _quickly:Array;

        public function MissionPracticeController()
        {
            return;
        }// end function

        public function get practiceInfo() : Object
        {
            var _loc_1:* = _data.missionPractice.practiceInfo;
            var _loc_2:* = this.renderPracticeInfo(_loc_1);
            return _loc_2;
        }// end function

        private function renderPracticeInfo(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.hourPower = param1[0];
            _loc_2.monsterList = this.renderMonster(param1[1]);
            _loc_2.isBoss = param1[2];
            if (_loc_2.isBoss == 0)
            {
                _loc_2.monsterLen = 3;
            }
            else
            {
                _loc_2.monsterLen = 1;
            }
            _loc_2.attackPower = param1[3];
            return _loc_2;
        }// end function

        private function renderMonster(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.monsterId = param1[_loc_4][0];
                _loc_5.monsterName = MonsterType.getMonsterNameById(param1[_loc_4][0]);
                _loc_5.level = param1[_loc_4][1];
                _loc_5.number = param1[_loc_4][2];
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get startPractice() : Object
        {
            var _loc_1:* = _data.missionPractice.startPractice;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.practiceTime = _loc_1[1];
            _loc_2.remainWarTimes = _loc_1[2];
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
            var _loc_1:* = _data.missionPractice.getNotify;
            var _loc_2:Object = {};
            _loc_2.type = _loc_1[0];
            _loc_2.newWarReport = this.renderNewWar(_loc_1[1]);
            _loc_2.rankReport = this.renderAwardItem(_loc_1[2]);
            _loc_2.remainTime = _loc_1[3];
            _loc_2.remainWarTimes = _loc_1[4];
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
                _loc_5.warMissionIndex = param1[_loc_4][0];
                _loc_5.warMonsterTeamIndex = param1[_loc_4][1];
                if (_loc_5.warMonsterTeamIndex == 1)
                {
                    _loc_5.isFirst = true;
                }
                else
                {
                    _loc_5.isFirst = false;
                }
                _loc_5.remainWarTimes = param1[_loc_4][2];
                _loc_5.awardExperience = this.renderExp(param1[_loc_4][3]);
                _loc_5.awardItem = this.renderAward(param1[_loc_4][4]);
                _loc_5.worship = param1[_loc_4][5];
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
                _loc_5.awardCoin = param1[_loc_4][0];
                _loc_5.awardIngot = param1[_loc_4][1];
                _loc_5.awardSkill = param1[_loc_4][2];
                _loc_5.awardExperience = this.renderExp(param1[_loc_4][3]);
                _loc_5.awardItem = this.renderAward(param1[_loc_4][4]);
                _loc_5.bless = param1[_loc_4][5];
                _loc_5.worship = param1[_loc_4][6];
                _loc_5.randomCoin = param1[_loc_4][7];
                _loc_5.randomSkill = param1[_loc_4][8];
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
                _loc_5.isQuest = param1[_loc_4][2] == ItemType.QuestItemTypeId;
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get continuePracticeInfo() : Object
        {
            var _loc_1:* = _data.missionPractice.continuePracticeInfo;
            var _loc_2:Object = {};
            _loc_2.practiceInfo = this.renderPracticeInfo(_loc_1);
            _loc_2.missionId = _loc_1[4];
            _loc_2.timeType = _loc_1[5];
            _loc_2.remainWarTimes = _loc_1[6];
            _loc_2.remainTime = _loc_1[7];
            _loc_2.isAutoSaleItem = _loc_1[8];
            return _loc_2;
        }// end function

        public function get cancelAutoSale() : Object
        {
            var _loc_1:* = _data.missionPractice.CancelAutoSale;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get setAutoSale() : Object
        {
            var _loc_1:* = _data.missionPractice.SetAutoSale;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

    }
}
