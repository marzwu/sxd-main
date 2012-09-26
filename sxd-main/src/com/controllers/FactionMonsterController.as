package com.controllers
{
    import com.assist.data.mission.*;

    public class FactionMonsterController extends Base
    {

        public function FactionMonsterController()
        {
            return;
        }// end function

        public function get result() : int
        {
            return _data.factionMonster.result;
        }// end function

        public function get openTime() : Object
        {
            return _data.factionMonster.openTime;
        }// end function

        public function get actityStatus() : int
        {
            return _data.factionMonster.actityStatus;
        }// end function

        public function get monsterLv() : int
        {
            return _data.factionMonster.monsterLv;
        }// end function

        public function get monsterList() : Array
        {
            return _data.factionMonster.monsterList;
        }// end function

        public function get deathMonsterId() : int
        {
            return _data.factionMonster.deathMonsterId;
        }// end function

        public function get bMonsterDead() : Boolean
        {
            return _data.factionMonster.bMonsterDead;
        }// end function

        public function get awardExperience() : int
        {
            return _data.factionMonster.AwardExperience;
        }// end function

        public function get awardCoin() : int
        {
            return _data.factionMonster.AwardCoin;
        }// end function

        public function get warData() : WarData
        {
            var _loc_1:* = new WarData();
            _loc_1.format([0, 0, 0, [_data.factionMonster.WarData]]);
            return _loc_1;
        }// end function

        public function get killPlayerList() : Array
        {
            return _data.factionMonster.killPlayerList;
        }// end function

        public function get bHaveAward() : Boolean
        {
            return _data.factionMonster.bHaveAward;
        }// end function

        public function get endTime() : int
        {
            return _data.factionMonster.endTime;
        }// end function

        public function get myAwardObj() : Object
        {
            return _data.factionMonster.myAwardObj;
        }// end function

        public function get notifyAwardObj() : Object
        {
            return _data.factionMonster.notifyAwardObj;
        }// end function

    }
}
