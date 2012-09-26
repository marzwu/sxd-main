package com.assist.server
{

    public class PeachType extends Object
    {
        private static const PeachData:Object = {1:[750000], 2:[1000000], 3:[1400000], 4:[1800000], 5:[5000000], 6:[12000000], 7:[13000000], 8:[13500000], 9:[14000000], 10:[14250000], 11:[14500000], 12:[14750000], 13:[15000000], 14:[15250000], 15:[23250000], 16:[23625000], 17:[24000000]};
        public static const MaxLevel:int = 17;

        public function PeachType()
        {
            return;
        }// end function

        public static function getExp(param1:int) : int
        {
            return PeachData[param1] ? (PeachData[param1][0]) : (0);
        }// end function

    }
}
