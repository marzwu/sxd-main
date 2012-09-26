package com.assist.server
{

    public class PlayerType extends Object
    {
        private static var _coefficient:Number = 0.05;

        public function PlayerType()
        {
            return;
        }// end function

        public static function isTester(param1:int) : Boolean
        {
            return isCommonTester(param1) || isAdvancedTester(param1) || isGM(param1) || isTrainer(param1);
        }// end function

        public static function isCommonTester(param1:int) : Boolean
        {
            return param1 == 1;
        }// end function

        public static function isStar(param1:int) : Boolean
        {
            return param1 == 1;
        }// end function

        public static function isAdvancedTester(param1:int) : Boolean
        {
            return param1 == 2;
        }// end function

        public static function isGM(param1:int) : Boolean
        {
            return param1 == 3;
        }// end function

        public static function isTrainer(param1:int) : Boolean
        {
            return param1 == 4;
        }// end function

        private static function getCoefficient(param1:int) : Number
        {
            if (param1 >= 50)
            {
                _coefficient = 0.05;
            }
            else
            {
                _coefficient = 0.02;
            }
            return _coefficient;
        }// end function

        public static function changePropertyLevel(param1:Number) : int
        {
            var _loc_2:* = param1 * 1000;
            return _loc_2;
        }// end function

        public static function propertyChange(param1:int, param2:int, param3:int) : Number
        {
            var _loc_4:* = getCoefficient(param2);
            var _loc_5:* = param1 * _loc_4 / param3;
            return param1 * _loc_4 / param3;
        }// end function

    }
}
