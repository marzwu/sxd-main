package com.assist.server
{

    public class PetType extends Object
    {
        public static const PetData:Object = {1:["岩龙", 70, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 2:["木龙", 80, 300, 2000, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0], 3:["水龙", 90, 400, 5000, 0, 0, 0, 5, 0, 0, 0, 0, 0, 5, 0, 0], 4:["火龙", 100, 500, 9000, 0, 0, 0, 5, 0, 5, 0, 0, 0, 5, 0, 0], 5:["风龙", 110, 600, 14000, 0, 0, 0, 5, 0, 5, 0, 5, 0, 5, 0, 0], 6:["雷龙", 120, 0, 20000, 100, 0, 0, 5, 5, 5, 0, 5, 0, 5, 5000, 0], 7:["冰龙", 130, 0, 20000, 150, 1000, 0, 5, 5, 5, 0, 5, 10, 5, 5000, 50000], 8:["飞龙", 140, 0, 20000, 200, 2500, 0, 5, 5, 5, 10, 5, 10, 5, 5000, 100000], 9:["黑龙", 150, 1000, 20000, 250, 4500, 10000, 5, 5, 5, 10, 5, 10, 5, 5000, 150000], 10:["金龙", 160, 2000, 30000, 1000, 7000, 20000, 5, 5, 5, 10, 5, 10, 5, 5000, 200000]};
        public static const PetIngot:Object = {70:[200, 20000], 80:[200, 20000], 90:[200, 20000], 0:[200, 20000], 1:[200, 20000], 2:[200, 20000], 3:[200, 20000], 4:[200, 20000], 5:[200, 20000], 6:[200, 20000]};
        public static const PetCoin:Object = {70:[10000, 5000], 80:[20000, 5000], 90:[30000, 5000], 0:[40000, 5000], 1:[50000, 5000], 2:[60000, 5000], 3:[70000, 5000], 4:[80000, 5000], 5:[90000, 5000], 6:[100000, 5000]};
        public static const PetExp:Object = {1:[0, 25000, 25000, 50000, 50000, 50000, 100000, 100000, 100000, 100000, 250000, 0], 2:[0, 200000, 200000, 200000, 200000, 200000, 300000, 300000, 300000, 300000, 600000, 0], 3:[0, 500000, 500000, 500000, 500000, 500000, 700000, 700000, 700000, 700000, 1200000, 0], 4:[0, 1000000, 1000000, 1000000, 1000000, 1000000, 1000000, 1000000, 1000000, 1000000, 1500000, 0], 5:[0, 1300000, 1300000, 1300000, 1300000, 1300000, 1300000, 1300000, 1300000, 1300000, 2200000, 0], 6:[0, 1800000, 1800000, 1800000, 1800000, 1800000, 1800000, 1800000, 1800000, 1800000, 3000000, 0], 7:[0, 2500000, 2500000, 2500000, 2500000, 2500000, 2500000, 2500000, 2500000, 2500000, 5000000, 0], 8:[0, 3200000, 3200000, 3200000, 3200000, 3200000, 3200000, 3200000, 3200000, 3200000, 7000000, 0], 9:[0, 4800000, 4800000, 4800000, 4800000, 4800000, 4800000, 4800000, 4800000, 4800000, 9000000, 0], 10:[0, 7000000, 7000000, 7000000, 7000000, 7000000, 7000000, 7000000, 7000000, 7000000, 7000000, 0]};

        public function PetType()
        {
            return;
        }// end function

        public static function getName(param1:int) : String
        {
            var _loc_2:* = PetData[param1] || [];
            return String(_loc_2[0]);
        }// end function

        public static function getReqLv(param1:int) : int
        {
            var _loc_2:* = PetData[param1] || [];
            return int(_loc_2[1]);
        }// end function

        public static function getAttack(param1:int, param2:int) : int
        {
            var _loc_3:* = PetData[param1] || [];
            return int(_loc_3[3]) + int(_loc_3[2]) * param2;
        }// end function

        public static function getDefense(param1:int, param2:int) : int
        {
            var _loc_3:* = PetData[param1] || [];
            return int(_loc_3[5]) + int(_loc_3[4]) * param2;
        }// end function

        public static function getLife(param1:int, param2:int) : int
        {
            var _loc_3:* = PetData[param1] || [];
            return int(_loc_3[15]) + int(_loc_3[14]) * param2;
        }// end function

        public static function getStuntAttack(param1:int) : int
        {
            var _loc_2:* = PetData[param1] || [];
            return int(_loc_2[6]);
        }// end function

        public static function getCritical(param1:int) : int
        {
            var _loc_2:* = PetData[param1] || [];
            return int(_loc_2[7]);
        }// end function

        public static function getDodge(param1:int) : int
        {
            var _loc_2:* = PetData[param1] || [];
            return int(_loc_2[8]);
        }// end function

        public static function getBlock(param1:int) : int
        {
            var _loc_2:* = PetData[param1] || [];
            return int(_loc_2[9]);
        }// end function

        public static function getBreakCritical(param1:int) : int
        {
            var _loc_2:* = PetData[param1] || [];
            return int(_loc_2[10]);
        }// end function

        public static function getBreakBlock(param1:int) : int
        {
            var _loc_2:* = PetData[param1] || [];
            return int(_loc_2[11]);
        }// end function

        public static function getHit(param1:int) : int
        {
            var _loc_2:* = PetData[param1] || [];
            return int(_loc_2[12]);
        }// end function

        public static function getKill(param1:int) : int
        {
            var _loc_2:* = PetData[param1] || [];
            return int(_loc_2[13]);
        }// end function

        public static function getExp(param1:int, param2:int) : int
        {
            var _loc_3:* = PetExp[param1] || [];
            return int(_loc_3[param2]);
        }// end function

        public static function getCoin(param1:int) : int
        {
            var _loc_2:* = PetCoin[param1] || [];
            return int(_loc_2[0]);
        }// end function

        public static function getCoinExp(param1:int) : int
        {
            var _loc_2:* = PetCoin[param1] || [];
            return int(_loc_2[1]);
        }// end function

        public static function getIngot(param1:int) : int
        {
            var _loc_2:* = PetIngot[param1] || [];
            return int(_loc_2[0]);
        }// end function

        public static function getIngotExp(param1:int) : int
        {
            var _loc_2:* = PetIngot[param1] || [];
            return int(_loc_2[1]);
        }// end function

        public static function getSignByLevel(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case 1:
                {
                    _loc_2 = "YanLong";
                    break;
                }
                case 2:
                {
                    _loc_2 = "MuLong";
                    break;
                }
                case 3:
                {
                    _loc_2 = "ShuiLong";
                    break;
                }
                case 4:
                {
                    _loc_2 = "HuoLong";
                    break;
                }
                case 5:
                {
                    _loc_2 = "FengLong";
                    break;
                }
                case 6:
                {
                    _loc_2 = "LeiLong";
                    break;
                }
                case 7:
                {
                    _loc_2 = "BingLong";
                    break;
                }
                case 8:
                {
                    _loc_2 = "FeiLong";
                    break;
                }
                case 9:
                {
                    _loc_2 = "HeiLong";
                    break;
                }
                case 10:
                {
                    _loc_2 = "JinLong";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getColor(param1:int) : int
        {
            var _loc_2:int = 16777215;
            switch(param1)
            {
                case 1:
                case 2:
                case 3:
                {
                    _loc_2 = 41193;
                    break;
                }
                case 4:
                case 5:
                case 6:
                {
                    _loc_2 = 16711935;
                    break;
                }
                case 7:
                case 8:
                case 9:
                case 10:
                {
                    _loc_2 = 16773632;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function isMaxLv(param1:int, param2:int) : Boolean
        {
            if (param1 == 0 && param2 == 10)
            {
                return true;
            }
            param2++;
            if (param2 > 10)
            {
                param2 = 1;
                param1++;
            }
            var _loc_3:* = getExp(param1, param2);
            return _loc_3 == 0;
        }// end function

    }
}
