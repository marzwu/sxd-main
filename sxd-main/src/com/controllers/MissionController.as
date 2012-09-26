package com.controllers
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.datas.*;
    import com.protocols.*;
    import flash.utils.*;

    public class MissionController extends Base
    {
        public var ownData:MissionData;
        private var _rankobj:Object;

        public function MissionController() : void
        {
            this._rankobj = {};
            this._rankobj[Mod_Mission_Base.SCORE_A] = "A";
            this._rankobj[Mod_Mission_Base.SCORE_B] = "B";
            this._rankobj[Mod_Mission_Base.SCORE_C] = "C";
            return;
        }// end function

        public function get result() : int
        {
            return _data.mission.result;
        }// end function

        public function get missionId() : int
        {
            return _data.mission.missionId;
        }// end function

        public function get missionLock() : int
        {
            return _data.mission.missionLock;
        }// end function

        public function get monsterLock() : int
        {
            return _data.mission.monsterLock;
        }// end function

        public function renderTownMission(param1:int) : Array
        {
            return MissionType.getNormalMissionListByTownId(param1);
        }// end function

        public function renderTownHeroMission(param1:int) : Array
        {
            return MissionType.getHeroMissionListByTownId(param1);
        }// end function

        public function get openMission() : Array
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_1:Array = [];
            var _loc_2:* = this.ownData.sectionsList;
            if (_loc_2 != null)
            {
                _loc_3 = _loc_2.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_1.push(this.missions(_loc_2[_loc_4]));
                    _loc_4++;
                }
            }
            return _loc_1;
        }// end function

        public function get openHeroMission() : Array
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_1:Array = [];
            var _loc_2:* = this.ownData.getHeroMissionList;
            if (_loc_2 != null)
            {
                _loc_3 = _loc_2.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_1.push(this.heroMissions(_loc_2[_loc_4]));
                    _loc_4++;
                }
            }
            return _loc_1;
        }// end function

        private function heroMissions(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.id = param1[0];
            _loc_2.status = param1[1];
            _loc_2.isVip3 = VIPType.check(VIPType.Level3);
            _loc_2.buyStatus = param1[2];
            _loc_2.buyPrice = param1[3];
            _loc_2.rank = this._rankobj[param1[4]];
            _loc_2.isFinished = param1[5];
            _loc_2.allBuyTimes = param1[6];
            _loc_2.remainBuyTimes = param1[7];
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

        private function missions(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.id = param1[0];
            _loc_2.status = param1[1];
            _loc_2.rank = this._rankobj[param1[2]];
            _loc_2.isBoss = param1[3];
            _loc_2.iconUrl = "";
            if (_loc_2.status != 0)
            {
                _loc_2.isPractice = true;
            }
            else
            {
                _loc_2.isPractice = false;
            }
            if (_loc_2.isBoss == 0)
            {
                _loc_2.monsterLen = 3;
            }
            else
            {
                _loc_2.monsterLen = 1;
            }
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

        public function get warData() : WarData
        {
            return this.ownData.warData;
        }// end function

        public function get warStatus() : int
        {
            return this.ownData.warStatus;
        }// end function

        public function get worship() : int
        {
            return this.ownData.worship;
        }// end function

        public function get warAura() : int
        {
            return this.ownData.warAura;
        }// end function

        public function zeroWarAura() : void
        {
            this.ownData.warAura = 0;
            return;
        }// end function

        public function get rank() : Object
        {
            return this.ownData.rank;
        }// end function

        public function get awardlist() : Array
        {
            return this.ownData.awardList;
        }// end function

        public function get pickupAward() : int
        {
            return this.ownData.pickupAward;
        }// end function

        public function get strategyList() : Array
        {
            return this.ownData.strategyList;
        }// end function

        public function get masterMonsterId() : int
        {
            return this.ownData.masterMonsterId;
        }// end function

        public function get strategyWarData() : ByteArray
        {
            return this.ownData.strategyWarData;
        }// end function

        public function get itemObj() : Object
        {
            return this.ownData.itemObj;
        }// end function

        public function get fetchItemObj() : Object
        {
            return this.ownData.fetchItemObj;
        }// end function

    }
}
