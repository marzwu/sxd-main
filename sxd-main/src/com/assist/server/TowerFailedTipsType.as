﻿package com.assist.server
{

    public class TowerFailedTipsType extends Object
    {
        private static const _TIPS:Array = [[1, 1, 5], [1, 1, 7], [1, 1, 9], [1, 1, 12], [1, 2, 5], [1, 2, 7], [1, 2, 9], [1, 2, 12], [1, 3, 5], [1, 3, 7], [1, 3, 9], [1, 3, 12], [1, 4, 5], [1, 4, 7], [1, 4, 9], [1, 4, 12], [1, 5, 5], [1, 5, 7], [1, 5, 9], [1, 5, 12], [1, 6, 5], [1, 6, 7], [1, 6, 9], [1, 6, 12], [1, 7, 5], [1, 7, 7], [1, 7, 9], [1, 7, 12], [1, 8, 5], [1, 8, 7], [1, 8, 9], [1, 8, 12], [1, 9, 5], [1, 9, 7], [1, 9, 9], [1, 9, 12], [1, 10, 5], [1, 10, 7], [1, 10, 9], [1, 10, 12], [1, 11, 5], [1, 11, 7], [1, 11, 9], [1, 11, 12], [1, 12, 5], [1, 12, 7], [1, 12, 9], [1, 12, 12], [1, 13, 5], [1, 13, 7], [1, 13, 9], [1, 13, 12], [1, 14, 5], [1, 14, 7], [1, 14, 9], [1, 14, 12], [1, 15, 5], [1, 15, 7], [1, 15, 9], [1, 15, 12], [1, 16, 5], [1, 16, 7], [1, 16, 9], [1, 16, 12], [1, 17, 5], [1, 17, 7], [1, 17, 9], [1, 17, 12], [1, 18, 5], [1, 18, 7], [1, 18, 9], [1, 18, 12], [1, 19, 5], [1, 19, 7], [1, 19, 9], [1, 19, 12], [1, 20, 5], [1, 20, 7], [1, 20, 9], [1, 20, 12], [1, 21, 5], [1, 21, 7], [1, 21, 9], [1, 21, 12], [1, 22, 5], [1, 22, 7], [1, 22, 9], [1, 22, 12], [1, 23, 5], [1, 23, 7], [1, 23, 9], [1, 23, 12], [1, 24, 5], [1, 24, 7], [1, 24, 9], [1, 24, 12], [1, 25, 5], [1, 25, 7], [1, 25, 9], [1, 25, 12], [2, 1, 5], [2, 1, 7], [2, 1, 9], [2, 1, 12], [2, 2, 5], [2, 2, 7], [2, 2, 9], [2, 2, 12], [2, 3, 5], [2, 3, 7], [2, 3, 9], [2, 3, 12], [2, 4, 5], [2, 4, 7], [2, 4, 9], [2, 4, 12], [2, 5, 5], [2, 5, 7], [2, 5, 9], [2, 5, 12], [2, 6, 5], [2, 6, 7], [2, 6, 9], [2, 6, 12], [2, 7, 5], [2, 7, 7], [2, 7, 9], [2, 7, 12], [2, 8, 5], [2, 8, 7], [2, 8, 9], [2, 8, 12], [2, 9, 5], [2, 9, 7], [2, 9, 9], [2, 9, 12], [2, 10, 5], [2, 10, 7], [2, 10, 9], [2, 10, 12], [2, 11, 5], [2, 11, 7], [2, 11, 9], [2, 11, 12], [2, 12, 5], [2, 12, 7], [2, 12, 9], [2, 12, 12], [2, 13, 5], [2, 13, 7], [2, 13, 9], [2, 13, 12], [2, 14, 5], [2, 14, 7], [2, 14, 9], [2, 14, 12], [2, 15, 5], [2, 15, 7], [2, 15, 9], [2, 15, 12], [2, 16, 5], [2, 16, 7], [2, 16, 9], [2, 16, 12], [2, 17, 5], [2, 17, 7], [2, 17, 9], [2, 17, 12], [2, 18, 5], [2, 18, 7], [2, 18, 9], [2, 18, 12], [2, 19, 5], [2, 19, 7], [2, 19, 9], [2, 19, 12], [2, 20, 5], [2, 20, 7], [2, 20, 9], [2, 20, 12], [2, 21, 5], [2, 21, 7], [2, 21, 9], [2, 21, 12], [2, 22, 5], [2, 22, 7], [2, 22, 9], [2, 22, 12], [2, 23, 5], [2, 23, 7], [2, 23, 9], [2, 23, 12], [2, 24, 5], [2, 24, 7], [2, 24, 9], [2, 24, 12], [2, 25, 5], [2, 25, 7], [2, 25, 9], [2, 25, 12], [3, 1, 5], [3, 1, 7], [3, 1, 9], [3, 1, 12], [3, 2, 5], [3, 2, 7], [3, 2, 9], [3, 2, 12], [3, 3, 5], [3, 3, 7], [3, 3, 9], [3, 3, 12], [3, 4, 5], [3, 4, 7], [3, 4, 9], [3, 4, 12], [3, 5, 5], [3, 5, 7], [3, 5, 9], [3, 5, 12], [3, 6, 5], [3, 6, 7], [3, 6, 9], [3, 6, 12], [3, 7, 5], [3, 7, 7], [3, 7, 9], [3, 7, 12], [3, 8, 5], [3, 8, 7], [3, 8, 9], [3, 8, 12], [3, 9, 5], [3, 9, 7], [3, 9, 9], [3, 9, 12], [3, 10, 5], [3, 10, 7], [3, 10, 9], [3, 10, 12], [3, 11, 5], [3, 11, 7], [3, 11, 9], [3, 11, 12], [3, 12, 5], [3, 12, 7], [3, 12, 9], [3, 12, 12], [3, 13, 5], [3, 13, 7], [3, 13, 9], [3, 13, 12], [3, 14, 5], [3, 14, 7], [3, 14, 9], [3, 14, 12], [3, 15, 5], [3, 15, 7], [3, 15, 9], [3, 15, 12], [3, 16, 5], [3, 16, 7], [3, 16, 9], [3, 16, 12], [3, 17, 5], [3, 17, 7], [3, 17, 9], [3, 17, 12], [3, 18, 5], [3, 18, 7], [3, 18, 9], [3, 18, 12], [3, 19, 5], [3, 19, 7], [3, 19, 9], [3, 19, 12], [3, 20, 5], [3, 20, 7], [3, 20, 9], [3, 20, 12], [3, 21, 5], [3, 21, 7], [3, 21, 9], [3, 21, 12], [3, 22, 5], [3, 22, 7], [3, 22, 9], [3, 22, 12], [3, 23, 5], [3, 23, 7], [3, 23, 9], [3, 23, 12], [3, 24, 5], [3, 24, 7], [3, 24, 9], [3, 24, 12], [3, 25, 5], [3, 25, 7], [3, 25, 9], [3, 25, 12], [4, 1, 5], [4, 1, 7], [4, 1, 9], [4, 1, 12], [4, 2, 5], [4, 2, 7], [4, 2, 9], [4, 2, 12], [4, 3, 5], [4, 3, 7], [4, 3, 9], [4, 3, 12], [4, 4, 5], [4, 4, 7], [4, 4, 9], [4, 4, 12], [4, 5, 5], [4, 5, 7], [4, 5, 9], [4, 5, 12], [4, 6, 5], [4, 6, 7], [4, 6, 9], [4, 6, 12], [4, 7, 5], [4, 7, 7], [4, 7, 9], [4, 7, 12], [4, 8, 5], [4, 8, 7], [4, 8, 9], [4, 8, 12], [4, 9, 5], [4, 9, 7], [4, 9, 9], [4, 9, 12], [4, 10, 5], [4, 10, 7], [4, 10, 9], [4, 10, 12], [4, 11, 5], [4, 11, 7], [4, 11, 9], [4, 11, 12], [4, 12, 5], [4, 12, 7], [4, 12, 9], [4, 12, 12], [4, 13, 5], [4, 13, 7], [4, 13, 9], [4, 13, 12], [4, 14, 5], [4, 14, 7], [4, 14, 9], [4, 14, 12], [4, 15, 5], [4, 15, 7], [4, 15, 9], [4, 15, 12], [4, 16, 5], [4, 16, 7], [4, 16, 9], [4, 16, 12], [4, 17, 5], [4, 17, 7], [4, 17, 9], [4, 17, 12], [4, 18, 5], [4, 18, 7], [4, 18, 9], [4, 18, 12], [4, 19, 5], [4, 19, 7], [4, 19, 9], [4, 19, 12], [4, 20, 5], [4, 20, 7], [4, 20, 9], [4, 20, 12], [4, 21, 5], [4, 21, 7], [4, 21, 9], [4, 21, 12], [4, 22, 5], [4, 22, 7], [4, 22, 9], [4, 22, 12], [4, 23, 5], [4, 23, 7], [4, 23, 9], [4, 23, 12], [4, 24, 5], [4, 24, 7], [4, 24, 9], [4, 24, 12], [4, 25, 5], [4, 25, 7], [4, 25, 9], [4, 25, 12], [5, 1, 5], [5, 1, 7], [5, 1, 9], [5, 1, 12], [5, 2, 5], [5, 2, 7], [5, 2, 9], [5, 2, 12], [5, 3, 5], [5, 3, 7], [5, 3, 9], [5, 3, 12], [5, 4, 5], [5, 4, 7], [5, 4, 9], [5, 4, 12], [5, 5, 5], [5, 5, 7], [5, 5, 9], [5, 5, 12], [5, 6, 5], [5, 6, 7], [5, 6, 9], [5, 6, 12], [5, 7, 5], [5, 7, 7], [5, 7, 9], [5, 7, 12], [5, 8, 5], [5, 8, 7], [5, 8, 9], [5, 8, 12], [5, 9, 5], [5, 9, 7], [5, 9, 9], [5, 9, 12], [5, 10, 5], [5, 10, 7], [5, 10, 9], [5, 10, 12], [5, 11, 5], [5, 11, 7], [5, 11, 9], [5, 11, 12], [5, 12, 5], [5, 12, 7], [5, 12, 9], [5, 12, 12], [5, 13, 5], [5, 13, 7], [5, 13, 9], [5, 13, 12], [5, 14, 5], [5, 14, 7], [5, 14, 9], [5, 14, 12], [5, 15, 5], [5, 15, 7], [5, 15, 9], [5, 15, 12], [5, 16, 5], [5, 16, 7], [5, 16, 9], [5, 16, 12], [5, 17, 5], [5, 17, 7], [5, 17, 9], [5, 17, 12], [5, 18, 5], [5, 18, 7], [5, 18, 9], [5, 18, 12], [5, 19, 5], [5, 19, 7], [5, 19, 9], [5, 19, 12], [5, 20, 5], [5, 20, 7], [5, 20, 9], [5, 20, 12], [5, 21, 5], [5, 21, 7], [5, 21, 9], [5, 21, 12], [5, 22, 5], [5, 22, 7], [5, 22, 9], [5, 22, 12], [5, 23, 5], [5, 23, 7], [5, 23, 9], [5, 23, 12], [5, 24, 5], [5, 24, 7], [5, 24, 9], [5, 24, 12], [5, 25, 5], [5, 25, 7], [5, 25, 9], [5, 25, 12], [6, 1, 5], [6, 1, 7], [6, 1, 9], [6, 1, 12], [6, 2, 5], [6, 2, 7], [6, 2, 9], [6, 2, 12], [6, 3, 5], [6, 3, 7], [6, 3, 9], [6, 3, 12], [6, 4, 5], [6, 4, 7], [6, 4, 9], [6, 4, 12], [6, 5, 5], [6, 5, 7], [6, 5, 9], [6, 5, 12], [6, 6, 5], [6, 6, 7], [6, 6, 9], [6, 6, 12], [6, 7, 5], [6, 7, 7], [6, 7, 9], [6, 7, 12], [6, 8, 5], [6, 8, 7], [6, 8, 9], [6, 8, 12], [6, 9, 5], [6, 9, 7], [6, 9, 9], [6, 9, 12], [6, 10, 5], [6, 10, 7], [6, 10, 9], [6, 10, 12], [6, 11, 5], [6, 11, 7], [6, 11, 9], [6, 11, 12], [6, 12, 5], [6, 12, 7], [6, 12, 9], [6, 12, 12], [6, 13, 5], [6, 13, 7], [6, 13, 9], [6, 13, 12], [6, 14, 5], [6, 14, 7], [6, 14, 9], [6, 14, 12], [6, 15, 5], [6, 15, 7], [6, 15, 9], [6, 15, 12], [6, 16, 5], [6, 16, 7], [6, 16, 9], [6, 16, 12], [6, 17, 5], [6, 17, 7], [6, 17, 9], [6, 17, 12], [6, 18, 5], [6, 18, 7], [6, 18, 9], [6, 18, 12], [6, 19, 5], [6, 19, 7], [6, 19, 9], [6, 19, 12], [6, 20, 5], [6, 20, 7], [6, 20, 9], [6, 20, 12], [6, 21, 5], [6, 21, 7], [6, 21, 9], [6, 21, 12], [6, 22, 5], [6, 22, 7], [6, 22, 9], [6, 22, 12], [6, 23, 5], [6, 23, 7], [6, 23, 9], [6, 23, 12], [6, 24, 5], [6, 24, 7], [6, 24, 9], [6, 24, 12], [6, 25, 5], [6, 25, 7], [6, 25, 9], [6, 25, 12]];
        private static var _tipData:Object = {};

        public function TowerFailedTipsType()
        {
            return;
        }// end function

        public static function getTipsList(param1:int, param2:int) : Array
        {
            var _loc_5:Array = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            if (_tipData[param1])
            {
                return _tipData[param1][param2] || [];
            }
            var _loc_3:* = _TIPS.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _TIPS[_loc_4];
                _loc_6 = _loc_5[0];
                _loc_7 = _loc_5[1];
                if (_tipData[_loc_6] == null)
                {
                    _tipData[_loc_6] = {};
                }
                if (_tipData[_loc_6][_loc_7] == null)
                {
                    _tipData[_loc_6][_loc_7] = [];
                }
                _tipData[_loc_6][_loc_7].push(_loc_5[2]);
                _loc_4++;
            }
            return _tipData[param1][param2] || [];
        }// end function

    }
}
