﻿package com.assist.server
{

    public class GoldOilType extends Object
    {
        private static const Oils:Object = {20:["一星", 90, 1, 0, 5000000, 0, 60], 20:["二星", 100, 2, 1203, 5000000, 0, 90], 20:["三星", 110, 3, 1204, 5000000, 0, 120], 20:["四星", 120, 4, 1205, 5000000, 0, 150], 20:["五星", 130, 5, 1206, 5000000, 0, 180], 20:["六星", 140, 6, 1207, 5000000, 0, 210], 20:["七星", 150, 7, 1208, 5000000, 0, 240], 21:["八星", 160, 8, 1209, 5000000, 0, 270], 21:["九星", 170, 9, 1210, 5000000, 0, 300]};
        private static const Data:Array = [[1203, 1, 0, 20, 0, 30, 0, 0, 0, 0], [1203, 2, 30, 0, 7, 0, 0, 0, 0, 1], [1203, 2, 30, 0, 7, 0, 0, 0, 0, 2], [1203, 2, 30, 0, 7, 0, 0, 0, 0, 3], [1203, 2, 30, 0, 7, 0, 0, 0, 0, 5], [1203, 2, 0, 0, 7, 0, 30, 0, 0, 6], [1203, 3, 0, 0, 30, 0, 0, 0, 0, 0], [1203, 4, 0, 50, 0, 0, 0, 0, 0, 0], [1203, 5, 0, 0, 0, 0, 0, 0, 80, 0], [1203, 6, 0, 0, 0, 80, 0, 0, 0, 0], [1204, 1, 0, 30, 0, 40, 0, 0, 0, 0], [1204, 2, 50, 0, 8, 0, 0, 0, 0, 1], [1204, 2, 50, 0, 8, 0, 0, 0, 0, 2], [1204, 2, 50, 0, 8, 0, 0, 0, 0, 3], [1204, 2, 40, 0, 8, 0, 0, 0, 0, 5], [1204, 2, 0, 0, 8, 0, 40, 0, 0, 6], [1204, 3, 0, 0, 40, 0, 0, 0, 0, 0], [1204, 4, 0, 70, 0, 0, 0, 0, 0, 0], [1204, 5, 0, 0, 0, 0, 0, 0, 100, 0], [1204, 6, 0, 0, 0, 100, 0, 0, 0, 0], [1205, 1, 0, 40, 0, 50, 0, 0, 0, 0], [1205, 2, 70, 0, 9, 0, 0, 0, 0, 1], [1205, 2, 70, 0, 9, 0, 0, 0, 0, 2], [1205, 2, 70, 0, 9, 0, 0, 0, 0, 3], [1205, 2, 50, 0, 9, 0, 0, 0, 0, 5], [1205, 2, 0, 0, 9, 0, 50, 0, 0, 6], [1205, 3, 0, 0, 50, 0, 0, 0, 0, 0], [1205, 4, 0, 90, 0, 0, 0, 0, 0, 0], [1205, 5, 0, 0, 0, 0, 0, 0, 120, 0], [1205, 6, 0, 0, 0, 120, 0, 0, 0, 0], [1206, 1, 0, 50, 0, 60, 0, 0, 0, 0], [1206, 2, 90, 0, 10, 0, 0, 0, 0, 1], [1206, 2, 90, 0, 10, 0, 0, 0, 0, 2], [1206, 2, 90, 0, 10, 0, 0, 0, 0, 3], [1206, 2, 60, 0, 10, 0, 0, 0, 0, 5], [1206, 2, 0, 0, 10, 0, 60, 0, 0, 6], [1206, 3, 0, 0, 60, 0, 0, 0, 0, 0], [1206, 4, 0, 110, 0, 0, 0, 0, 0, 0], [1206, 5, 0, 0, 0, 0, 0, 0, 140, 0], [1206, 6, 0, 0, 0, 140, 0, 0, 0, 0], [1207, 1, 0, 60, 0, 80, 0, 0, 0, 0], [1207, 2, 110, 0, 12, 0, 0, 0, 0, 1], [1207, 2, 110, 0, 12, 0, 0, 0, 0, 2], [1207, 2, 110, 0, 12, 0, 0, 0, 0, 3], [1207, 2, 70, 0, 12, 0, 0, 0, 0, 5], [1207, 2, 0, 0, 12, 0, 80, 0, 0, 6], [1207, 3, 0, 0, 80, 0, 0, 0, 0, 0], [1207, 4, 0, 130, 0, 0, 0, 0, 0, 0], [1207, 5, 0, 0, 0, 0, 0, 0, 180, 0], [1207, 6, 0, 0, 0, 180, 0, 0, 0, 0], [1208, 1, 0, 70, 0, 100, 0, 0, 0, 0], [1208, 2, 130, 0, 14, 0, 0, 0, 0, 1], [1208, 2, 130, 0, 14, 0, 0, 0, 0, 2], [1208, 2, 130, 0, 14, 0, 0, 0, 0, 3], [1208, 2, 80, 0, 14, 0, 0, 0, 0, 5], [1208, 2, 0, 0, 14, 0, 100, 0, 0, 6], [1208, 3, 0, 0, 100, 0, 0, 0, 0, 0], [1208, 4, 0, 150, 0, 0, 0, 0, 0, 0], [1208, 5, 0, 0, 0, 0, 0, 0, 220, 0], [1208, 6, 0, 0, 0, 220, 0, 0, 0, 0], [1209, 1, 0, 80, 0, 120, 0, 0, 0, 0], [1209, 2, 150, 0, 16, 0, 0, 0, 0, 1], [1209, 2, 150, 0, 16, 0, 0, 0, 0, 2], [1209, 2, 150, 0, 16, 0, 0, 0, 0, 3], [1209, 2, 90, 0, 16, 0, 0, 0, 0, 5], [1209, 2, 0, 0, 16, 0, 120, 0, 0, 6], [1209, 3, 0, 0, 120, 0, 0, 0, 0, 0], [1209, 4, 0, 170, 0, 0, 0, 0, 0, 0], [1209, 5, 0, 0, 0, 0, 0, 0, 260, 0], [1209, 6, 0, 0, 0, 260, 0, 0, 0, 0]];

        public function GoldOilType()
        {
            return;
        }// end function

        public static function getAllOilItemIds() : Array
        {
            var _loc_2:String = null;
            var _loc_1:Array = [];
            for (_loc_2 in Oils)
            {
                
                _loc_1[(Oils[_loc_2][2] - 1)] = parseInt(_loc_2);
            }
            return _loc_1;
        }// end function

        public static function getOilName(param1:int) : String
        {
            return ItemType.getName(param1);
        }// end function

        public static function getItemLevel(param1:int) : int
        {
            var _loc_2:* = Oils[param1];
            return _loc_2 ? (_loc_2[1]) : (0);
        }// end function

        public static function getOilLevel(param1:int) : int
        {
            var _loc_2:* = Oils[param1];
            return _loc_2 ? (_loc_2[2]) : (0);
        }// end function

        public static function getPrevOilItemId(param1:int) : int
        {
            var _loc_2:* = Oils[param1];
            return _loc_2 ? (_loc_2[3]) : (0);
        }// end function

        public static function getUseCoin(param1:int) : int
        {
            var _loc_2:* = Oils[param1];
            return _loc_2 ? (_loc_2[4]) : (0);
        }// end function

        public static function getUseStatePoint(param1:int) : int
        {
            var _loc_2:* = Oils[param1];
            return _loc_2 ? (_loc_2[5]) : (0);
        }// end function

        public static function getExchangeStatePoint(param1:int) : int
        {
            var _loc_2:* = Oils[param1];
            return _loc_2 ? (_loc_2[6]) : (0);
        }// end function

        public static function getOilAttr(param1:int, param2:int, param3:int = 0) : Object
        {
            var _loc_4:Array = [];
            var _loc_5:* = Data.length;
            if (param2 != 2)
            {
                param3 = 0;
            }
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                if (Data[_loc_6][0] == param1 && Data[_loc_6][1] == param2 && Data[_loc_6][9] == param3)
                {
                    _loc_4 = Data[_loc_6];
                    break;
                }
                _loc_6++;
            }
            return {attackUp:_loc_4[2] || 0, defenseUp:_loc_4[3] || 0, stuntAttackUp:_loc_4[4] || 0, stuntDefenseUp:_loc_4[5] || 0, magicAttackUp:_loc_4[6] || 0, magicDefenseUp:_loc_4[7] || 0, healthUp:_loc_4[8] || 0};
        }// end function

    }
}
