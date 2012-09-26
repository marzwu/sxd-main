package com.assist.server
{

    public class SpecialPartnerType extends Object
    {
        private static const Data:Object = {1:[75, 482, 649, 70, 1477, 30, 50, 0, 0, 0, 300000, 10], 2:[75, 488, 660, 80, 1478, 20, 0, 1000, 0, 0, 400000, 20], 3:[75, 525, 858, 90, 1479, 10, 0, 0, 452, 1, 500000, 50], 4:[75, 580, 916, 100, 1480, 5, 0, 0, 475, 1, 600000, 100], 5:[77, 152, 57, 20, 1483, 30, 50, 0, 0, 0, 40000, 10], 6:[77, 104, 141, 40, 1484, 20, 0, 1000, 0, 0, 60000, 15], 7:[77, 126, 182, 50, 1485, 10, 0, 0, 440, 3, 80000, 40], 8:[77, 151, 263, 60, 1486, 5, 0, 0, 468, 3, 100000, 100]};

        public function SpecialPartnerType()
        {
            return;
        }// end function

        public static function getMissionId(param1:int) : int
        {
            return Data[param1] ? (Data[param1][1]) : (0);
        }// end function

        public static function getMonsterId(param1:int) : int
        {
            return Data[param1] ? (Data[param1][2]) : (0);
        }// end function

        public static function getRequireLevel(param1:int) : int
        {
            return Data[param1] ? (Data[param1][3]) : (0);
        }// end function

        public static function getRequireItemId(param1:int) : int
        {
            return Data[param1] ? (Data[param1][4]) : (0);
        }// end function

        public static function getRequireItemAmount(param1:int) : int
        {
            return Data[param1] ? (Data[param1][5]) : (0);
        }// end function

        public static function getAwardPower(param1:int) : int
        {
            return Data[param1] ? (Data[param1][6]) : (0);
        }// end function

        public static function getAwardFame(param1:int) : int
        {
            return Data[param1] ? (Data[param1][7]) : (0);
        }// end function

        public static function getAwardItemId(param1:int) : int
        {
            return Data[param1] ? (Data[param1][8]) : (0);
        }// end function

        public static function getAwardItemAmount(param1:int) : int
        {
            return Data[param1] ? (Data[param1][9]) : (0);
        }// end function

        public static function getAwardExperience(param1:int) : int
        {
            return Data[param1] ? (Data[param1][10]) : (0);
        }// end function

        public static function getRequireItemPrice(param1:int) : int
        {
            return Data[param1] ? (Data[param1][11]) : (0);
        }// end function

    }
}
