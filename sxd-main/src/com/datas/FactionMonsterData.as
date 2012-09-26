package com.datas
{
    import com.protocols.*;

    public class FactionMonsterData extends Base
    {
        public var result:int = 0;
        public var actityStatus:int = -1;
        public var AwardExperience:int = 0;
        public var AwardCoin:int = 0;
        public var WarData:Array;
        public var openTime:Object;
        public var monsterLv:int = 0;
        public var monsterList:Array;
        public var deathMonsterId:int = 0;
        public var bMonsterDead:Boolean;
        public var killPlayerList:Array;
        public var bHaveAward:Boolean;
        public var endTime:int;
        public var myAwardObj:Object;
        public var notifyAwardObj:Object;

        public function FactionMonsterData()
        {
            this.openTime = {};
            this.monsterList = new Array();
            return;
        }// end function

        public function get_status(param1:Array) : void
        {
            this.actityStatus = param1[0];
            this.openTime.state = this.actityStatus;
            this.openTime.openTime = this.renderOpenTime(param1[1]);
            return;
        }// end function

        private function renderOpenTime(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = {};
                _loc_5.startTime = param1[_loc_4][0];
                _loc_5.endTime = param1[_loc_4][1];
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function get_monster_info(param1:Array) : void
        {
            this.monsterList = new Array();
            this.monsterLv = param1[0];
            var _loc_2:int = 0;
            while (_loc_2 < param1[1].length)
            {
                
                this.monsterList.push(param1[1][_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        public function start_fight(param1:Array) : void
        {
            this.result = param1[0];
            this.WarData = param1[1][0];
            this.AwardCoin = param1[3];
            this.AwardExperience = param1[4];
            return;
        }// end function

        public function notify(param1:Array) : void
        {
            this.bMonsterDead = false;
            this.bMonsterDead = param1[0] == Mod_FactionMonster_Base.MONSTER_DEAD;
            if (!this.bMonsterDead)
            {
                this.actityStatus = param1[0];
            }
            this.deathMonsterId = param1[1];
            return;
        }// end function

        public function get_win_player_list(param1:Array) : void
        {
            var _loc_4:Object = null;
            this.actityStatus = Mod_FactionMonster_Base.OVER;
            this.killPlayerList = new Array();
            var _loc_2:* = param1[0];
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = new Object();
                _loc_4.playerId = _loc_2[_loc_3][0];
                _loc_4.nickName = _loc_2[_loc_3][1];
                _loc_4.nickName = _data.player.removeNickNameSuffix(_loc_4.nickName);
                this.killPlayerList.push(_loc_4);
                _loc_3++;
            }
            return;
        }// end function

        public function is_can_get_award(param1:Array) : void
        {
            this.bHaveAward = param1[0] == 1;
            this.endTime = param1[1];
            return;
        }// end function

        public function get_award(param1:Array) : void
        {
            this.myAwardObj = new Object();
            this.myAwardObj.result = param1[0];
            this.myAwardObj.itemId = param1[1];
            this.myAwardObj.itemNum = param1[2];
            return;
        }// end function

        public function notify_get_award(param1:Array) : void
        {
            this.notifyAwardObj = new Object();
            this.notifyAwardObj.playerId = param1[0];
            this.notifyAwardObj.nickName = param1[1];
            this.notifyAwardObj.nickName = _data.player.removeNickNameSuffix(this.notifyAwardObj.nickName);
            this.notifyAwardObj.bKiller = param1[2] == 1;
            this.notifyAwardObj.itemId = param1[3];
            this.notifyAwardObj.itemNum = param1[4];
            return;
        }// end function

    }
}
