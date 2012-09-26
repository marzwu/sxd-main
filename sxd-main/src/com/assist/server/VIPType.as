package com.assist.server
{

    public class VIPType extends Object
    {
        private static const Levels:Object = {1:100, 2:500, 3:1000, 4:2000, 5:5000, 6:10000, 7:20000, 8:50000, 9:100000, 10:200000, 11:500000, 12:1000000};
        public static const Level0:int = 0;
        public static const Level1:int = 1;
        public static const Level2:int = 2;
        public static const Level3:int = 3;
        public static const Level4:int = 4;
        public static const Level5:int = 5;
        public static const Level6:int = 6;
        public static const Level7:int = 7;
        public static const Level8:int = 8;
        public static const Level9:int = 9;
        public static const Level10:int = 10;
        public static const Level11:int = 11;
        public static const Level12:int = 12;
        public static const MaxLevel:int = 12;
        private static var _level:int = -1;

        public function VIPType()
        {
            return;
        }// end function

        public static function set level(param1:int) : void
        {
            _level = param1;
            return;
        }// end function

        public static function check(param1:int) : Boolean
        {
            if (_level >= param1)
            {
                return true;
            }
            return false;
        }// end function

        public static function get enabled() : Boolean
        {
            return check(Level0);
        }// end function

        public static function getVIPInfo(param1:int, param2:int = 100) : String
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_3:String = "";
            if (infos[param1])
            {
                _loc_4 = infos[param1].length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4 && _loc_5 < param2)
                {
                    
                    if (_loc_3 != "")
                    {
                        _loc_3 = _loc_3 + "\n";
                    }
                    _loc_3 = _loc_3 + ((_loc_5 + 1) + "." + infos[param1][_loc_5]);
                    _loc_5++;
                }
            }
            return _loc_3;
        }// end function

        public static function getRequireMoney(param1:int) : int
        {
            return Levels[param1] || 0;
        }// end function

        public static function test() : void
        {
            var _loc_2:String = null;
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_1:String = "";
            for (_loc_2 in infos)
            {
                
                _loc_1 = _loc_1 + ("infos[VIPType.Level" + _loc_2 + "] = [\n");
                _loc_3 = infos[_loc_2];
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    _loc_1 = _loc_1 + ("\tVIPTypeData0Lang.Level" + _loc_2 + "_" + _loc_4);
                    if (_loc_4 < (_loc_3.length - 1))
                    {
                        _loc_1 = _loc_1 + ",";
                    }
                    _loc_1 = _loc_1 + "\n";
                    _loc_4++;
                }
                _loc_1 = _loc_1 + "];\n";
            }
            return;
        }// end function

    }
}
