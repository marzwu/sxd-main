package com.assist.server
{

    public class AssistantAwardType extends Object
    {
        private static const Data:Object = {1:[0, 5, "蓝色宝箱", 500, 2, 5, 1000], 2:[0, 10, "蓝色宝箱", 1500, 3, 25, 5000], 3:[0, 15, "蓝色宝箱", 3000, 4, 50, 10000], 4:[6, 30, "紫色宝箱", 3000, 5, 100, 20000], 5:[6, 50, "紫色宝箱", 3000, 6, 200, 50000], 6:[6, 100, "紫色宝箱", 3000, 7, 300, 100000], 7:[10, 150, "金色宝箱", 5000, 8, 500, 200000], 8:[10, 200, "金色宝箱", 10000, 9, 700, 500000], 9:[10, 250, "金色宝箱", 20000, 10, 800, 500000]};

        public function AssistantAwardType()
        {
            return;
        }// end function

        public static function getIdList() : Array
        {
            var _loc_2:String = null;
            var _loc_1:Array = [];
            for (_loc_2 in Data)
            {
                
                _loc_1.push(int(_loc_2));
            }
            return _loc_1;
        }// end function

        public static function getVIP(param1:int) : int
        {
            return Data[param1] ? (Data[param1][0]) : (0);
        }// end function

        public static function getTimes(param1:int) : int
        {
            return Data[param1] ? (Data[param1][1]) : (0);
        }// end function

        public static function getName(param1:int) : String
        {
            return Data[param1] ? (Data[param1][2]) : ("");
        }// end function

        public static function getSkill(param1:int) : int
        {
            return Data[param1] ? (Data[param1][3]) : (0);
        }// end function

        public static function getCardNum(param1:int) : int
        {
            return Data[param1] ? (Data[param1][4]) : (0);
        }// end function

        public static function getActiveDegree(param1:int) : int
        {
            return Data[param1] ? (Data[param1][5]) : (0);
        }// end function

        public static function getCoin(param1:int) : int
        {
            return Data[param1] ? (Data[param1][6]) : (0);
        }// end function

        public static function getMaxTimes() : int
        {
            var _loc_2:Object = null;
            var _loc_1:int = 0;
            for each (_loc_2 in Data)
            {
                
                if (_loc_1 < _loc_2[1])
                {
                    _loc_1 = _loc_2[1];
                }
            }
            return _loc_1;
        }// end function

        public static function getBoxCount(param1:int) : int
        {
            var _loc_3:Object = null;
            var _loc_2:int = 0;
            for each (_loc_3 in Data)
            {
                
                if (_loc_3[0] <= param1)
                {
                    _loc_2++;
                }
            }
            return _loc_2;
        }// end function

    }
}
