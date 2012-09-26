package com.assist.server
{

    public class FactionType extends Object
    {
        private static const Camps:Object = {1:[WeiKaiFang, "未开放"], 2:[WeiXuanZe, "未选择"], 3:[ShuShanCheng, "蜀山"], 4:[KunLunCheng, "昆仑"], 5:[PengLaiDao, "蓬莱"]};
        public static const WeiKaiFang:String = "WeiKaiFang";
        public static const WeiXuanZe:String = "WeiXuanZe";
        public static const ShuShanCheng:String = "ShuShanCheng";
        public static const KunLunCheng:String = "KunLunCheng";
        public static const PengLaiDao:String = "PengLaiDao";
        private static const FactionJobs:Object = {1:["HuiZhang", "会长"], 2:["FuHuiZhang", "副会长"]};
        private static const FactionLevels:Object = {};
        private static const GodOfferings:Object = {1:["白檀香", 0, 5, 10, 10, 0, 100], 2:["苏合香", 30, 50, 100, 30, 1, 0], 3:["天木香", 90, 1000, 1000, 100, 2, 0]};

        public function FactionType()
        {
            return;
        }// end function

        public static function campId(param1:String) : int
        {
            var _loc_2:int = 0;
            var _loc_3:Object = null;
            var _loc_4:Object = null;
            for (_loc_3 in Camps)
            {
                
                _loc_4 = Camps[_loc_3];
                if (_loc_4[0] == param1)
                {
                    _loc_2 = _loc_3 as int;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function campSign(param1:int) : String
        {
            var _loc_2:String = null;
            var _loc_3:Object = null;
            for (_loc_3 in Camps)
            {
                
                if (_loc_3 == param1)
                {
                    _loc_2 = Camps[_loc_3][0];
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function campName(param1:int) : String
        {
            var _loc_2:String = "";
            if (hasCamp(param1))
            {
                _loc_2 = Camps[param1][1];
            }
            return _loc_2;
        }// end function

        public static function hasCamp(param1:int) : Boolean
        {
            var _loc_2:* = campSign(param1);
            return _loc_2 && _loc_2 != WeiXuanZe && _loc_2 != WeiKaiFang;
        }// end function

        public static function getOfferName(param1:int) : String
        {
            return GodOfferings[param1] ? (GodOfferings[param1][0]) : ("");
        }// end function

        public static function getOfferIngot(param1:int) : int
        {
            return GodOfferings[param1] ? (GodOfferings[param1][1]) : (0);
        }// end function

        public static function getOfferExp(param1:int) : int
        {
            return GodOfferings[param1] ? (GodOfferings[param1][2]) : (0);
        }// end function

        public static function getOfferFame(param1:int) : int
        {
            return GodOfferings[param1] ? (GodOfferings[param1][3]) : (0);
        }// end function

        public static function getOfferBlessingCount(param1:int) : int
        {
            return GodOfferings[param1] ? (GodOfferings[param1][4]) : (0);
        }// end function

        public static function getOffsetVIPLevel(param1:int) : int
        {
            return GodOfferings[param1] ? (GodOfferings[param1][5]) : (0);
        }// end function

        public static function getOffsetSkill(param1:int) : int
        {
            return GodOfferings[param1] ? (GodOfferings[param1][6]) : (0);
        }// end function

    }
}
