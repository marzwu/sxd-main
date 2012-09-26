package com.assist.server
{

    public class FateType extends Object
    {
        private static var _Fates:Object = null;
        private static const FateNPCs:Object = {1:["周一仙", 8000], 2:["小仙女", 10000], 3:["左慈", 20000], 4:["张道陵", 40000], 5:["姜子牙", 60000]};
        private static var _FateLevel:Object = null;
        private static const FateQuality:Object = {1:["杂物", 5400, 0], 2:["优秀", 6750, 30], 3:["精良", 13500, 60], 4:["传奇", 20250, 120], 5:["神器", 27000, 720], 6:["普通", 27000, 1200], 7:["碎片", 27000, 0], 8:["天命", 30000, 0]};
        public static const Health:int = 1;
        public static const Attack:int = 2;
        public static const Defense:int = 3;
        public static const MagicAttack:int = 4;
        public static const MagicDefense:int = 5;
        public static const StuntAttack:int = 6;
        public static const StuntDefense:int = 7;
        public static const Hit:int = 8;
        public static const Block:int = 9;
        public static const Dodge:int = 10;
        public static const Critical:int = 11;
        public static const Momentum:int = 12;
        public static const BreakBlock:int = 13;
        public static const BreakCritical:int = 14;
        public static const Kill:int = 15;
        private static const FateRequestLevel:Object = {37:60, 38:60, 39:60, 40:60, 41:60, 42:60, 43:60, 44:60, 45:110, 46:120, 47:100, 48:90, 49:100, 50:110, 51:120};

        public function FateType()
        {
            return;
        }// end function

        public static function get Fates() : Object
        {
            if (_Fates == null)
            {
                throw new Error("还未赋值！");
            }
            return _Fates;
        }// end function

        public static function set Fates(param1:Object) : void
        {
            if (_Fates != null)
            {
                throw new Error("非法赋值");
            }
            _Fates = param1;
            return;
        }// end function

        public static function get FateLevel() : Object
        {
            if (_FateLevel == null)
            {
                throw new Error("还未赋值！");
            }
            return _FateLevel;
        }// end function

        public static function set FateLevel(param1:Object) : void
        {
            if (_FateLevel != null)
            {
                throw new Error("非法赋值");
            }
            _FateLevel = param1;
            return;
        }// end function

        public static function getFateName(param1:int) : String
        {
            return Fates[param1] ? (Fates[param1][0]) : ("");
        }// end function

        public static function getFateSign(param1:int) : String
        {
            return Fates[param1] ? (Fates[param1][1]) : ("");
        }// end function

        public static function getFateQuality(param1:int) : int
        {
            return Fates[param1] ? (Fates[param1][2]) : (0);
        }// end function

        public static function getFateDescription(param1:int) : String
        {
            return Fates[param1] ? (Fates[param1][3]) : ("");
        }// end function

        public static function getWarAttributeType(param1:int) : int
        {
            return Fates[param1] ? (Fates[param1][4]) : (0);
        }// end function

        public static function isWarAttribute(param1:int) : Boolean
        {
            var _loc_2:* = getWarAttributeType(param1);
            if (_loc_2 == Hit || _loc_2 == Block || _loc_2 == Dodge || _loc_2 == Critical || _loc_2 == BreakBlock || _loc_2 == BreakCritical || _loc_2 == Kill)
            {
                return true;
            }
            return false;
        }// end function

        public static function getActivedList(param1:int) : Array
        {
            var _loc_3:int = 0;
            var _loc_2:Array = [];
            if (Fates[param1] != null)
            {
                _loc_3 = Fates[param1][6];
                if (_loc_3 > 0)
                {
                    _loc_2.push(_loc_3);
                }
                _loc_3 = Fates[param1][7];
                if (_loc_3 > 0)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public static function getNeedActived(param1:int) : int
        {
            return Fates[param1] ? (Fates[param1][8]) : (0);
        }// end function

        public static function getNPCName(param1:int) : String
        {
            return FateNPCs[param1] ? (FateNPCs[param1][0]) : ("");
        }// end function

        public static function getNPCFee(param1:int) : int
        {
            return FateNPCs[param1] ? (FateNPCs[param1][1]) : (0);
        }// end function

        public static function getMaxFateLevel(param1:int) : int
        {
            var _loc_5:Array = null;
            var _loc_2:* = FateLevel.length;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = FateLevel[_loc_4];
                if (param1 == _loc_5[0] && _loc_3 < _loc_5[1])
                {
                    _loc_3 = _loc_5[1];
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public static function getFateAddonValue(param1:int, param2:int) : int
        {
            var _loc_6:Array = null;
            var _loc_3:* = FateLevel.length;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = FateLevel[_loc_5];
                if (param1 == _loc_6[0] && param2 == _loc_6[1] && _loc_4 < _loc_6[2])
                {
                    _loc_4 = FateLevel[_loc_5][2];
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public static function getFateAddonValue2(param1:int, param2:int) : int
        {
            var _loc_6:Array = null;
            var _loc_3:* = FateLevel.length;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = FateLevel[_loc_5];
                if (param1 == _loc_6[0] && param2 == _loc_6[1] && _loc_4 < _loc_6[3])
                {
                    _loc_4 = FateLevel[_loc_5][3];
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public static function getSalePriceByFateId(param1:int) : int
        {
            var _loc_2:* = getFateQuality(param1);
            return getSalePriceByQualityId(_loc_2);
        }// end function

        public static function getSalePriceByQualityId(param1:int) : int
        {
            return FateQuality[param1] ? (FateQuality[param1][1]) : (0);
        }// end function

        public static function getExperienceByFateId(param1:int) : int
        {
            var _loc_2:* = getFateQuality(param1);
            return getExperienceByQualityId(_loc_2);
        }// end function

        public static function getExperienceByQualityId(param1:int) : int
        {
            return FateQuality[param1] ? (FateQuality[param1][2]) : (0);
        }// end function

        public static function fateChengeLevel(param1:int) : int
        {
            return FateRequestLevel[param1] || 0;
        }// end function

    }
}
