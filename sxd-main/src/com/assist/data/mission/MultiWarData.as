package com.assist.data.mission
{
    import com.assist.server.*;
    import com.haloer.data.*;
    import com.lang.client.com.assist.data.mission.*;

    public class MultiWarData extends Object
    {
        public var multipleTeamId:int;
        public var multipleMissionId:int;
        public var winner:int;
        public var attackerInfo:Array;
        public var attackerIndexes:Object;
        public var defenderInfo:Array;
        public var defenderIndexes:Object;
        public var lineOne:Array;
        public var lineTwo:Array;
        public var lineThree:Array;
        public var awardSkill:int = 0;
        public var awardExperiences:Array;
        public var awardItems:Array;
        public var studyStuntIds:Array;

        public function MultiWarData()
        {
            this.attackerInfo = [];
            this.attackerIndexes = {};
            this.defenderInfo = [];
            this.defenderIndexes = {};
            this.lineOne = [];
            this.lineTwo = [];
            this.lineThree = [];
            return;
        }// end function

        public function format(param1:Array) : void
        {
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["multipleTeamId", "multipleMissionId", "winner", "attackerInfo", "defenderInfo", "fightResult", "award", "studyStuntIds"]);
            this.multipleTeamId = _loc_2["multipleTeamId"];
            this.multipleMissionId = _loc_2["multipleMissionId"];
            this.winner = _loc_2["winner"];
            this.attackerInfo = this.formatPlayerInfo(_loc_2["attackerInfo"], true);
            this.defenderInfo = this.formatPlayerInfo(_loc_2["defenderInfo"], false);
            var _loc_3:* = this.formatFightResult(_loc_2["fightResult"][0]);
            this.lineOne = _loc_3[0] || [];
            this.lineTwo = _loc_3[1] || [];
            this.lineThree = _loc_3[2] || [];
            _loc_3 = this.formatAward(_loc_2["award"][0]);
            this.awardSkill = _loc_3[0];
            this.awardExperiences = _loc_3[1];
            this.awardItems = _loc_3[2];
            this.studyStuntIds = _loc_2["studyStuntIds"];
            return;
        }// end function

        private function formatPlayerInfo(param1:Array, param2:Boolean) : Array
        {
            var _loc_6:Array = null;
            var _loc_7:Array = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:String = null;
            var _loc_3:Array = [];
            var _loc_4:* = param1.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = param1[_loc_5];
                _loc_3[_loc_5] = {};
                oObject.list(_loc_6, _loc_3[_loc_5], ["playerId", "nickName", "mainRoleSign", "level"]);
                _loc_3[_loc_5]["nickName"] = WarData.removeNickNameSuffix(_loc_3[_loc_5]["nickName"] || "");
                _loc_3[_loc_5]["roleList"] = {};
                _loc_3[_loc_5]["mainRoleSuffix"] = WarData.getItemSuffix(parseInt(_loc_6[5]));
                _loc_7 = _loc_6[4];
                _loc_8 = _loc_7.length;
                _loc_9 = 0;
                while (_loc_9 < _loc_8)
                {
                    
                    _loc_10 = _loc_7[_loc_9][1];
                    _loc_3[_loc_5]["roleList"][_loc_10] = {};
                    oObject.list(_loc_7[_loc_9], _loc_3[_loc_5]["roleList"][_loc_10], ["sign", "stations", "health", "maxHealth"]);
                    _loc_3[_loc_5]["roleList"][_loc_10]["stations"] = "A" + _loc_3[_loc_5]["roleList"][_loc_10]["stations"];
                    _loc_9++;
                }
                if (param2)
                {
                    this.attackerIndexes[_loc_3[_loc_5]["playerId"]] = _loc_5;
                }
                else
                {
                    this.defenderIndexes[_loc_3[_loc_5]["playerId"]] = _loc_5;
                }
                _loc_5++;
            }
            return _loc_3;
        }// end function

        private function formatFightResult(param1:Array) : Array
        {
            var _loc_5:Array = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:WarData = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1[_loc_4];
                _loc_6 = _loc_5.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    _loc_8 = new WarData();
                    _loc_8.format([0, 0, 0, [_loc_5[_loc_7]]]);
                    if (_loc_2[_loc_4] == undefined)
                    {
                        _loc_2[_loc_4] = [];
                    }
                    _loc_2[_loc_4].push(_loc_8);
                    _loc_7++;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function formatAward(param1:Array) : Array
        {
            if (param1.length == 0)
            {
                return [0, [], []];
            }
            return [param1[0], this.formatAwardExperiences(param1[1]), [{id:0, name:MultiWarDataLang.Fame, count:param1[2]}, {id:1152, name:MultiWarDataLang.Skill, count:param1[0]}]];
        }// end function

        private function formatAwardExperiences(param1:Array) : Array
        {
            var _loc_2:Array = [];
            if (param1 == null)
            {
                return _loc_2;
            }
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2[_loc_3] = {roleId:param1[_loc_3][0], exps:param1[_loc_3][1]};
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private function formatAwardItems(param1:Array) : Array
        {
            var _loc_5:Array = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_2:Array = [];
            var _loc_3:Object = {};
            var _loc_4:int = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_5 = param1[_loc_4];
                _loc_6 = _loc_5[0];
                _loc_7 = _loc_5[(_loc_5.length - 1)];
                _loc_8 = _loc_3[_loc_6] == null ? (-1) : (_loc_3[_loc_6]);
                if (_loc_8 == -1)
                {
                    _loc_8 = _loc_2.length;
                    _loc_3[_loc_6] = _loc_8;
                    _loc_2.push({id:_loc_6, name:ItemType.getName(_loc_6), count:_loc_7});
                }
                else
                {
                    _loc_2[_loc_8]["count"] = _loc_2[_loc_8]["count"] + _loc_7;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function isAttacker(param1:int) : Boolean
        {
            return this.attackerIndexes[param1] != null;
        }// end function

    }
}
