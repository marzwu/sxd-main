package com.assist.server
{

    public class HerbsType extends Object
    {
        private static var Herbs:Object = {1:["LingZhi", "普通灵芝", 32400, 86000, 1, 6, 1, 0], 2:["BaiNianLingZhi", "百年灵芝", 32400, 170000, 2, 6, 1, 0], 3:["QianNianLingZhi", "千年灵芝", 32400, 350000, 3, 6, 1, 0], 4:["WanNianLingZhi", "万年灵芝", 32400, 520000, 4, 6, 1, 0], 5:["JiPinLingZhi", "极品灵芝", 32400, 1600000, 5, 6, 1, 0], 6:["LongGuCao", "普通龙骨草", 32400, 57000, 1, 5, 1, 0], 7:["BaiNianLongGuCao", "百年龙骨草", 32400, 110000, 2, 5, 1, 0], 8:["QianNianLongGuCao", "千年龙骨草", 32400, 230000, 3, 5, 1, 0], 9:["WanNianLongGuCao", "万年龙骨草", 32400, 340000, 4, 5, 1, 0], 10:["JiPinLongGuCao", "极品龙骨草", 32400, 1000000, 5, 5, 1, 0], 11:["DanShen", "普通丹参", 32400, 9600, 1, 3, 1, 0], 12:["BaiNianDanShen", "百年丹参", 32400, 19000, 2, 3, 1, 0], 13:["QianNianDanShen", "千年丹参", 32400, 39000, 3, 3, 1, 0], 14:["WanNianDanShen", "万年丹参", 32400, 58000, 4, 3, 1, 0], 15:["JiPinDanShen", "极品丹参", 32400, 180000, 5, 3, 1, 0], 16:["LingShen", "普通灵参", 32400, 24000, 1, 4, 1, 0], 17:["BaiNianLingShen", "百年灵参", 32400, 47000, 2, 4, 1, 0], 18:["QianNianLingShen", "千年灵参", 32400, 94000, 3, 4, 1, 0], 19:["WanNianLingShen", "万年灵参", 32400, 140000, 4, 4, 1, 0], 20:["JiPinLingShen", "极品灵参", 32400, 420000, 5, 4, 1, 0], 21:["PuTongRenShenGuo", "普通人参果", 32400, 190000, 1, 7, 1, 0], 22:["BaiNianRenShenGuo", "百年人参果", 32400, 380000, 2, 7, 1, 0], 23:["QianNianRenShenGuo", "千年人参果", 32400, 770000, 3, 7, 1, 0], 24:["WanNianRenShenGuo", "万年人参果", 32400, 1200000, 4, 7, 1, 0], 25:["JiPinRenShenGuo", "极品人参果", 32400, 3500000, 5, 7, 1, 0], 26:["PuTongLuoHanGuo", "普通罗汉果", 32400, 330000, 1, 8, 1, 0], 27:["BaiNianLuoHanGuo", "百年罗汉果", 32400, 650000, 2, 8, 1, 0], 28:["QianNianLuoHanGuo", "千年罗汉果", 32400, 1300000, 3, 8, 1, 0], 29:["WanNianLuoHanGuo", "万年罗汉果", 32400, 2000000, 4, 8, 1, 0], 30:["JiPinLuoHanGuo", "极品罗汉果", 32400, 5900000, 5, 8, 1, 0], 31:["FaCaiShu", "普通发财树", 0, 0, 1, 100, 2, 5000], 32:["FaCaiShu", "优秀发财树", 0, 0, 2, 100, 2, 20000], 33:["FaCaiShu", "精良发财树", 0, 0, 3, 100, 2, 40000], 34:["FaCaiShu", "传奇发财树", 0, 0, 4, 100, 2, 80000], 35:["FaCaiShu", "神话发财树", 0, 0, 5, 100, 2, 270000], 36:["PuTongFuLing", "普通茯苓", 32400, 1620000, 1, 9, 1, 0], 37:["BaiNianFuLing", "百年茯苓", 32400, 3300000, 2, 9, 1, 0], 38:["QianNianFuLing", "千年茯苓", 32400, 6300000, 3, 9, 1, 0], 39:["WanNianFuLing", "万年茯苓", 32400, 9600000, 4, 9, 1, 0], 40:["JiPinFuLing", "极品茯苓", 32400, 29100000, 5, 9, 1, 0], 42:["PuTongTianXianTeng", "普通天仙藤", 32400, 2340000, 1, 10, 1, 0], 43:["BaiNianTianXianTeng", "百年天仙藤", 32400, 4800000, 2, 10, 1, 0], 44:["QianNianTianXianTeng", "千年天仙藤", 32400, 9300000, 3, 10, 1, 0], 45:["WanNianTianXianTeng", "万年天仙藤", 32400, 14100000, 4, 10, 1, 0], 46:["JiPinTianXianTeng", "极品天仙藤", 32400, 42000000, 5, 10, 1, 0], 47:["PuTongDongChongXiaCao", "普通冬虫夏草", 32400, 3300000, 1, 11, 1, 0], 48:["BaiNianDongChongXiaCao", "百年冬虫夏草", 32400, 6300000, 2, 11, 1, 0], 49:["QianNianDongChongXiaCao", "千年冬虫夏草", 32400, 12600000, 3, 11, 1, 0], 50:["WanNianDongChongXiaCao", "万年冬虫夏草", 32400, 18900000, 4, 11, 1, 0], 51:["JiPinDongChongXiaCao", "极品冬虫夏草", 32400, 57000000, 5, 11, 1, 0], 52:["PuTongShanYao", "普通山药", 32400, 6000000, 1, 12, 1, 0], 53:["BaiNianShanYao", "百年山药", 32400, 12000000, 2, 12, 1, 0], 54:["QianNianShanYao", "千年山药", 32400, 23500000, 3, 12, 1, 0], 55:["WanNianShanYao", "万年山药", 32400, 35000000, 4, 12, 1, 0], 56:["JiPinShanYao", "极品山药", 32400, 105000000, 5, 12, 1, 0], 57:["PuTongDangGui", "普通当归", 32400, 7000000, 1, 13, 1, 0], 58:["BaiNianDangGui", "百年当归", 32400, 14000000, 2, 13, 1, 0], 59:["QianNianDangGui", "千年当归", 32400, 28000000, 3, 13, 1, 0], 60:["WanNianDangGui", "万年当归", 32400, 42000000, 4, 13, 1, 0], 61:["JiPinDangGui", "极品当归", 32400, 125000000, 5, 13, 1, 0], 62:["PuTongGouQi", "普通枸杞", 32400, 10200000, 1, 14, 1, 0], 63:["BaiNianGouQi", "百年枸杞", 32400, 21000000, 2, 14, 1, 0], 64:["QianNianGouQi", "千年枸杞", 32400, 42000000, 3, 14, 1, 0], 65:["WanNianGouQi", "万年枸杞", 32400, 60000000, 4, 14, 1, 0], 66:["JiPinGouQi", "极品枸杞", 32400, 186000000, 5, 14, 1, 0], 67:["PuTongShaoYao", "普通芍药", 32400, 15000000, 1, 15, 1, 0], 68:["BaiNianShaoYao", "百年芍药", 32400, 31000000, 2, 15, 1, 0], 69:["QianNianShaoYao", "千年芍药", 32400, 63000000, 3, 15, 1, 0], 70:["WanNianShaoYao", "万年芍药", 32400, 95000000, 4, 15, 1, 0], 71:["JiPinShaoYao", "极品芍药", 32400, 280000000, 5, 15, 1, 0], 72:["PuTongLaoHuJiang", "普通老虎姜", 32400, 26000000, 1, 16, 1, 0], 73:["BaiNianLaoHuJiang", "百年老虎姜", 32400, 53000000, 2, 16, 1, 0], 74:["QianNianLaoHuJiang", "千年老虎姜", 32400, 100000000, 3, 16, 1, 0], 75:["WanNianLaoHuJiang", "万年老虎姜", 32400, 160000000, 4, 16, 1, 0], 76:["JiPinLaoHuJiang", "极品老虎姜", 32400, 470000000, 5, 16, 1, 0], 77:["PuTongLaoHuJiang", "普通老虎姜", 32400, 26000000, 1, 17, 1, 0], 78:["BaiNianLaoHuJiang", "百年老虎姜", 32400, 53000000, 2, 17, 1, 0], 79:["QianNianLaoHuJiang", "千年老虎姜", 32400, 100000000, 3, 17, 1, 0], 80:["WanNianLaoHuJiang", "万年老虎姜", 32400, 160000000, 4, 17, 1, 0], 81:["JiPinLaoHuJiang", "极品老虎姜", 32400, 470000000, 5, 17, 1, 0], 82:["PuTongManTuoLuo", "普通曼陀罗", 32400, 45000000, 1, 18, 1, 0], 83:["BaiNianManTuoLuo", "百年曼陀罗", 32400, 90000000, 2, 18, 1, 0], 84:["QianNianManTuoLuo", "千年曼陀罗", 32400, 180000000, 3, 18, 1, 0], 85:["WanNianManTuoLuo", "万年曼陀罗", 32400, 270000000, 4, 18, 1, 0], 86:["JiPinManTuoLuo", "极品曼陀罗", 32400, 810000000, 5, 18, 1, 0]};

        public function HerbsType()
        {
            return;
        }// end function

        public static function getSign(param1:int) : String
        {
            return Herbs[param1] ? (Herbs[param1][0]) : ("");
        }// end function

        public static function getName(param1:int) : String
        {
            return Herbs[param1] ? (Herbs[param1][1]) : ("");
        }// end function

        public static function getRipeTime(param1:int) : int
        {
            return Herbs[param1] ? (Herbs[param1][2]) : (0);
        }// end function

        public static function getExperience(param1:int) : int
        {
            return Herbs[param1] ? (Herbs[param1][3]) : (0);
        }// end function

        public static function getStarLevel(param1:int) : int
        {
            return Herbs[param1] ? (Herbs[param1][4]) : (0);
        }// end function

        public static function getLock(param1:int) : int
        {
            return Herbs[param1] ? (Herbs[param1][5]) : (0);
        }// end function

        public static function getType(param1:int) : int
        {
            return Herbs[param1] ? (Herbs[param1][6]) : (0);
        }// end function

        public static function getCoin(param1:int) : int
        {
            return Herbs[param1] ? (Herbs[param1][7]) : (0);
        }// end function

        public static function getIdsByLock(param1:int) : Array
        {
            var _loc_3:Object = null;
            var _loc_2:Array = [];
            for (_loc_3 in Herbs)
            {
                
                if (Herbs[_loc_3][5] == param1)
                {
                    _loc_2.push(_loc_3 as int);
                }
            }
            _loc_2.sort();
            return _loc_2;
        }// end function

    }
}
