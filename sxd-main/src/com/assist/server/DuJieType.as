package com.assist.server
{
    import com.lang.client.com.assist.server.source.*;

    public class DuJieType extends Object
    {
        private static const SpiritState:Object = {1:"炼气", 2:"筑基", 3:"结丹", 4:"元婴", 5:"化神", 6:"炼虚", 7:"合体", 8:"大乘", 9:"渡劫", 10:"仙人一阶", 11:"仙人二阶", 12:"仙人三阶", 13:"仙人四阶", 14:"仙人五阶", 15:"仙人六阶", 16:"仙人七阶"};
        private static const Require:Array = [[1, 1, 70, 3000], [1, 2, 70, 1000], [1, 3, 70, 1000], [2, 1, 70, 3000], [2, 2, 70, 1000], [2, 3, 70, 1000], [3, 1, 70, 3000], [3, 2, 70, 1000], [3, 3, 70, 1000], [4, 1, 80, 3600], [4, 2, 80, 1200], [4, 3, 80, 1200], [5, 1, 80, 3600], [5, 2, 80, 1200], [5, 3, 80, 1200], [6, 1, 80, 3600], [6, 2, 80, 1200], [6, 3, 80, 1200], [7, 1, 90, 4200], [7, 2, 90, 1400], [7, 3, 90, 1400], [8, 1, 90, 4200], [8, 2, 90, 1400], [8, 3, 90, 1400], [9, 1, 90, 4200], [9, 2, 90, 1400], [9, 3, 90, 1400], [10, 1, 100, 4800], [10, 2, 100, 1600], [10, 3, 100, 1600], [11, 1, 110, 4800], [11, 2, 110, 1600], [11, 3, 110, 1600], [12, 1, 120, 4800], [12, 2, 120, 1600], [12, 3, 120, 1600], [13, 1, 131, 5400], [13, 2, 131, 1800], [13, 3, 131, 1800], [14, 1, 141, 5400], [14, 2, 141, 1800], [14, 3, 141, 1800], [15, 1, 151, 5400], [15, 2, 151, 1800], [15, 3, 151, 1800], [16, 1, 161, -105000], [16, 2, 161, 0], [16, 3, 161, 0]];

        public function DuJieType()
        {
            return;
        }// end function

        public static function getSpiritLevelInfo(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case 1:
                {
                    _loc_2 = DuJieTypeData0Lang.Prime;
                    break;
                }
                case 2:
                {
                    _loc_2 = DuJieTypeData0Lang.Iterim;
                    break;
                }
                case 3:
                {
                    _loc_2 = DuJieTypeData0Lang.LaterPeriod;
                    break;
                }
                default:
                {
                    _loc_2 = "";
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getSpiritName(param1:int) : String
        {
            return SpiritState[param1] || "";
        }// end function

        public static function getSpiritColor(param1:int) : uint
        {
            if (param1 >= 1 && param1 <= 3)
            {
                return 41193;
            }
            if (param1 >= 4 && param1 <= 6)
            {
                return 16711935;
            }
            return 16776977;
        }// end function

        public static function getRequireRoleLevel(param1:int, param2:int) : int
        {
            var _loc_5:Array = null;
            var _loc_3:* = Require.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = Require[_loc_4];
                if (_loc_5[0] == param1 && _loc_5[1] == param2)
                {
                    return _loc_5[2];
                }
                _loc_4++;
            }
            return 0;
        }// end function

        public static function getRequireHealth(param1:int, param2:int) : int
        {
            var _loc_5:Array = null;
            var _loc_3:* = Require.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = Require[_loc_4];
                if (_loc_5[0] == param1 && _loc_5[1] == param2)
                {
                    return _loc_5[3];
                }
                _loc_4++;
            }
            return 0;
        }// end function

    }
}
