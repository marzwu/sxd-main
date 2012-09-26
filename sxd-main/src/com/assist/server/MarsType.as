package com.assist.server
{

    public class MarsType extends Object
    {
        private static const Offerings:Object = {1:["白檀香", 5, 120, 10, 0, 100, 0], 2:["苏合香", 50, 240, 100, 30, 0, 1], 3:["天木香", 1000, 720, 1000, 90, 0, 2]};

        public function MarsType()
        {
            return;
        }// end function

        public static function getOfferingName(param1:int) : String
        {
            return Offerings[param1] ? (Offerings[param1][0]) : ("");
        }// end function

        public static function getOfferingExp(param1:int) : int
        {
            return Offerings[param1] ? (Offerings[param1][1]) : (0);
        }// end function

        public static function getOfferingBlessingCount(param1:int) : int
        {
            return Offerings[param1] ? (Offerings[param1][2]) : (0);
        }// end function

        public static function getOfferingFame(param1:int) : int
        {
            return Offerings[param1] ? (Offerings[param1][3]) : (0);
        }// end function

        public static function getOfferingIngot(param1:int) : int
        {
            return Offerings[param1] ? (Offerings[param1][4]) : (0);
        }// end function

        public static function getOfferingSkill(param1:int) : int
        {
            return Offerings[param1] ? (Offerings[param1][5]) : (0);
        }// end function

        public static function getOfferingVipLevel(param1:int) : int
        {
            return Offerings[param1] ? (Offerings[param1][6]) : (0);
        }// end function

    }
}
