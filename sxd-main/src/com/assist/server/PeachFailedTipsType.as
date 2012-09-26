package com.assist.server
{

    public class PeachFailedTipsType extends Object
    {
        private static const _TIPS:Array = [[1, 5], [1, 7], [1, 9], [1, 12], [2, 5], [2, 7], [2, 9], [2, 12], [3, 5], [3, 7], [3, 9], [3, 12], [4, 5], [4, 7], [4, 9], [4, 12], [5, 5], [5, 7], [5, 9], [5, 12], [6, 5], [6, 7], [6, 9], [6, 12], [7, 5], [7, 7], [7, 9], [7, 12], [8, 5], [8, 7], [8, 9], [8, 12], [9, 5], [9, 7], [9, 9], [9, 12], [10, 5], [10, 7], [10, 9], [10, 12], [11, 5], [11, 7], [11, 9], [11, 12], [12, 5], [12, 7], [12, 9], [12, 12], [13, 5], [13, 7], [13, 9], [13, 12], [14, 5], [14, 7], [14, 9], [14, 12], [15, 5], [15, 7], [15, 9], [15, 12], [16, 5], [16, 7], [16, 9], [16, 12], [17, 5], [17, 7], [17, 9], [17, 12]];
        private static var _tipData:Object = {};

        public function PeachFailedTipsType()
        {
            return;
        }// end function

        public static function getTipsList(param1:int) : Array
        {
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            if (_tipData[param1])
            {
                return _tipData[param1] || [];
            }
            var _loc_2:* = _TIPS.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _TIPS[_loc_3];
                _loc_5 = _loc_4[0];
                if (_tipData[_loc_5] == null)
                {
                    _tipData[_loc_5] = [];
                }
                _tipData[_loc_5].push(_loc_4[1]);
                _loc_3++;
            }
            return _tipData[param1] || [];
        }// end function

    }
}
