package com.controllers
{
    import com.assist.data.mission.*;
    import com.assist.view.info.*;

    public class BeelzebubTrialsController extends Base
    {
        private var _bActiveTime:Boolean = false;
        private var _notify:Object;

        public function BeelzebubTrialsController()
        {
            return;
        }// end function

        public function get bActiveTime() : Boolean
        {
            return this._bActiveTime;
        }// end function

        public function set bActiveTime(param1:Boolean) : void
        {
            this._bActiveTime = param1;
            return;
        }// end function

        public function get openTime() : Object
        {
            return this._data.beelzebubtrials.openTime;
        }// end function

        public function get teamlist() : Array
        {
            return this._data.beelzebubtrials.teamList;
        }// end function

        public function get createBeelzebublist() : Array
        {
            return this._data.beelzebubtrials.createBeelzebubList;
        }// end function

        public function get joinBeelzebubList() : Array
        {
            return this._data.beelzebubtrials.joinBeelzebubList;
        }// end function

        public function get getteamlist() : Array
        {
            return this._data.beelzebubtrials.getteamList;
        }// end function

        public function get chanchallengetimes() : Object
        {
            return this._data.beelzebubtrials.chanchallengetimes;
        }// end function

        public function get leaderFactionId() : int
        {
            return this._data.beelzebubtrials.leaderFactionId;
        }// end function

        public function get createteamResult() : int
        {
            return this._data.beelzebubtrials.createteamResult;
        }// end function

        public function get joinTeamResult() : int
        {
            return this._data.beelzebubtrials.joinTeamResult;
        }// end function

        public function removeNotify(param1:int) : void
        {
            delete this._notify[param1];
            return;
        }// end function

        public function get newTeamList() : Array
        {
            return this._data.beelzebubtrials.notifynewteam;
        }// end function

        public function get drapTeam() : int
        {
            return this._data.beelzebubtrials.notifydropteam;
        }// end function

        public function get updatemember() : Object
        {
            return this._data.beelzebubtrials.updatemembernumber;
        }// end function

        public function getBossObjAtBossId(param1:int) : BeelzebubTrialsBossInfo
        {
            var _loc_2:String = null;
            for (_loc_2 in _data.beelzebubtrials.bossList)
            {
                
                if (_data.beelzebubtrials.bossList[_loc_2].bossId == param1)
                {
                    return _data.beelzebubtrials.bossList[_loc_2];
                }
            }
            return null;
        }// end function

        public function get canChallengeList() : Array
        {
            return this._data.beelzebubtrials.canChallengeList;
        }// end function

        public function set curBoss(param1:BeelzebubTrialsBossInfo) : void
        {
            _data.beelzebubtrials.btBossInfo = param1;
            return;
        }// end function

        public function get curBoss() : BeelzebubTrialsBossInfo
        {
            return _data.beelzebubtrials.btBossInfo;
        }// end function

        public function get myTeamList() : Array
        {
            return _data.beelzebubtrials.myTeamList;
        }// end function

        public function get myRoleList() : Array
        {
            return _data.beelzebubtrials.roleList;
        }// end function

        public function get leaderId() : int
        {
            return _data.beelzebubtrials.leaderId;
        }// end function

        public function get notifyValue() : int
        {
            return _data.beelzebubtrials.notifyValue;
        }// end function

        public function get awardFame() : int
        {
            return _data.beelzebubtrials.awardFame;
        }// end function

        public function get awardCoin() : int
        {
            return _data.beelzebubtrials.awardCoin;
        }// end function

        public function get exitFlag() : int
        {
            return _data.beelzebubtrials.exitFlag;
        }// end function

        public function get warResult() : int
        {
            return _data.beelzebubtrials.warResult;
        }// end function

        public function get awardFlag() : int
        {
            return _data.beelzebubtrials.awardFlag;
        }// end function

        public function get equitData() : Object
        {
            return _data.beelzebubtrials.equitData;
        }// end function

        public function get playerIdList() : Array
        {
            return _data.beelzebubtrials.playerIdList;
        }// end function

        public function get warData() : WarData
        {
            var _loc_1:* = new WarData();
            _loc_1.format([0, 0, 0, [_data.beelzebubtrials.warData]]);
            return _loc_1;
        }// end function

        public function get canWar() : Boolean
        {
            return this.myTeamList.length == 3;
        }// end function

        public function bCanIn(param1:int) : Boolean
        {
            var _loc_3:Array = null;
            if (!this.canChallengeList)
            {
                return false;
            }
            var _loc_2:int = 0;
            while (_loc_2 < this.canChallengeList.length)
            {
                
                _loc_3 = this.canChallengeList[_loc_2];
                if (_loc_3[0] == param1)
                {
                    return true;
                }
                _loc_2++;
            }
            return false;
        }// end function

    }
}
