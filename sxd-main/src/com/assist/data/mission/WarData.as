package com.assist.data.mission
{
    import com.assist.server.*;
    import com.haloer.data.*;

    public class WarData extends Object
    {
        public var offset:Array;
        public var challenged:Boolean;
        public var winId:int;
        public var attackerId:int;
        public var attackerName:String;
        public var attackerSoldiers:Object;
        public var attackerMainPlayerRoleId:String;
        public var attackerMainRoleSuffix:String;
        public var attackerMainRoleId:int;
        public var attackerLevel:int;
        public var attackerFirstAttack:int;
        public var attackerPetName:String;
        public var attackerPetLevel:int;
        public var attackerPetStep:int;
        public var defenderId:int;
        public var defenderName:String;
        public var defenderSoldiers:Object;
        public var defenderMainPlayerRoleId:String;
        public var defenderMainRoleSuffix:String;
        public var defenderMainRoleId:int;
        public var defenderLevel:int;
        public var defenderFirstAttack:int;
        public var defenderPetName:String;
        public var defenderPetLevel:int;
        public var defenderPetStep:int;
        public var processes:Array;
        public var usedStunt:Array;
        public var awardExperiences:Array;
        public var awardItems:Array;
        public var failureAwardItem:Array;
        public var debugInfo:Array;
        public var reportId:int;
        public static var getItemSuffix:Function;
        public static var removeNickNameSuffix:Function;

        public function WarData()
        {
            return;
        }// end function

        public function format(param1:Array) : void
        {
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["offX", "offY", "challenged", "warResult", "awardExp", "awardItems", "failureAwardItem", "debugInfo", "reportId"]);
            this.offset = [_loc_2["offX"], _loc_2["offY"]];
            this.challenged = _loc_2["challenged"];
            this.formatWarResult(_loc_2["warResult"][0]);
            this.awardExperiences = this.formatAwardExperiences(_loc_2["awardExp"] || []);
            this.awardItems = this.formatAwardItems(_loc_2["awardItems"] || []);
            this.failureAwardItem = this.formatAwardItems(_loc_2["failureAwardItem"] || []);
            this.debugInfo = _loc_2["debugInfo"] || [];
            this.reportId = _loc_2["reportId"] || 0;
            return;
        }// end function

        private function formatWarResult(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            this.winId = param1[0];
            _loc_2 = param1[1][0];
            this.attackerId = _loc_2[0];
            this.attackerName = removeNickNameSuffix(_loc_2[1]);
            this.attackerSoldiers = this.formatFighter(_loc_2[2], true);
            this.attackerMainPlayerRoleId = _loc_2[3];
            this.attackerMainRoleSuffix = getItemSuffix(parseInt(_loc_2[4]));
            this.attackerMainRoleId = _loc_2[5];
            this.attackerLevel = _loc_2[6];
            this.attackerFirstAttack = _loc_2[7];
            this.attackerPetName = _loc_2[8];
            this.attackerPetLevel = _loc_2[9];
            this.attackerPetStep = _loc_2[10];
            _loc_2 = param1[1][1];
            this.defenderId = _loc_2[0];
            this.defenderName = removeNickNameSuffix(_loc_2[1]);
            this.defenderSoldiers = this.formatFighter(_loc_2[2], false);
            this.defenderMainPlayerRoleId = _loc_2[3];
            this.defenderMainRoleSuffix = getItemSuffix(parseInt(_loc_2[4]));
            this.defenderMainRoleId = _loc_2[5];
            this.defenderLevel = _loc_2[6];
            this.defenderFirstAttack = _loc_2[7];
            this.defenderPetName = _loc_2[8];
            this.defenderPetLevel = _loc_2[9];
            this.defenderPetStep = _loc_2[10];
            this.formatProcesses(param1[2]);
            return;
        }// end function

        private function formatFighter(param1:Array, param2:Boolean) : Object
        {
            var _loc_6:String = null;
            var _loc_3:Object = {};
            var _loc_4:* = param1.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = param1[_loc_5][0];
                _loc_3[_loc_6] = {};
                oObject.list(param1[_loc_5], _loc_3[_loc_6], ["id", "sign", "name", "jobId", "health", "maxHealth", "level", "stations", "momentum"]);
                _loc_3[_loc_6]["tempHealth"] = _loc_3[_loc_6]["health"];
                _loc_3[_loc_6]["stations"] = (param2 ? ("A") : ("B")) + _loc_3[_loc_6]["stations"];
                _loc_5++;
            }
            return _loc_3;
        }// end function

        private function formatProcesses(param1:Array) : void
        {
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:Array = null;
            var _loc_8:Object = null;
            var _loc_9:int = 0;
            var _loc_10:Array = null;
            var _loc_11:Object = null;
            var _loc_12:Array = null;
            var _loc_13:Array = null;
            var _loc_14:Array = null;
            var _loc_15:int = 0;
            var _loc_2:* = param1.length;
            this.processes = [];
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.processes[_loc_3] = [];
                _loc_4 = param1[_loc_3][0];
                _loc_5 = _loc_4.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_7 = _loc_4[_loc_6];
                    var _loc_16:* = {};
                    this.processes[_loc_3][_loc_6] = {};
                    _loc_8 = _loc_16;
                    oObject.list(_loc_7, _loc_8, ["masterId", "masterSoldierId", "stunt", "beStunt", "masterMomentum", "leftHealth", "selfHurt", "slaveId", "attackType", "slaveSignList", "addonItem"]);
                    _loc_8["stunt"] = this.getStuntSign(_loc_8["stunt"]);
                    _loc_10 = _loc_8["beStunt"];
                    _loc_11 = {};
                    _loc_8["beStunt"] = [];
                    _loc_9 = 0;
                    while (_loc_9 < _loc_10.length)
                    {
                        
                        if (_loc_11[_loc_10[_loc_9]] == null)
                        {
                            _loc_11[_loc_10[_loc_9]] = _loc_10[_loc_9];
                        }
                        else
                        {
                        }
                        _loc_8["beStunt"].push(this.getStuntSign(_loc_10[_loc_9] is Array ? (_loc_10[_loc_9][0]) : (_loc_10[_loc_9])));
                        _loc_9++;
                    }
                    _loc_12 = _loc_8["addonItem"];
                    _loc_8["addonItem"] = [];
                    _loc_9 = 0;
                    while (_loc_9 < _loc_12.length)
                    {
                        
                        _loc_8["addonItem"].push({type:_loc_12[_loc_9][0], data:_loc_12[_loc_9][1]});
                        _loc_9++;
                    }
                    _loc_13 = _loc_8.slaveSignList;
                    _loc_14 = [];
                    _loc_15 = 0;
                    while (_loc_15 < _loc_13.length)
                    {
                        
                        _loc_14[_loc_15] = {};
                        oObject.list(_loc_13[_loc_15], _loc_14[_loc_15], ["id", "stunt", "beStunt", "momentum", "hurt", "leftHealth", "hit", "block", "critical"]);
                        _loc_14[_loc_15]["stunt"] = this.getStuntSign(_loc_14[_loc_15]["stunt"]);
                        _loc_10 = _loc_14[_loc_15]["beStunt"];
                        _loc_14[_loc_15]["beStunt"] = [];
                        _loc_9 = 0;
                        while (_loc_9 < _loc_10.length)
                        {
                            
                            _loc_14[_loc_15]["beStunt"].push(this.getStuntSign(_loc_10[_loc_9] is Array ? (_loc_10[_loc_9][0]) : (_loc_10[_loc_9])));
                            _loc_9++;
                        }
                        _loc_15++;
                    }
                    _loc_8.slaveSignList = _loc_14;
                    _loc_6++;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function getStuntSign(param1) : String
        {
            return /^\d+$""^\d+$/.test(param1) ? (RoleStunt.getStuntSign(param1 as int)) : (param1 as String);
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

        public function getArmyName(param1:Boolean) : String
        {
            return param1 ? (this.attackerName) : (this.defenderName);
        }// end function

    }
}
