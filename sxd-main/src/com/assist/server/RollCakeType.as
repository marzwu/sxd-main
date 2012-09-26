package com.assist.server
{
    import com.adobe.serialization.json.*;
    import com.assist.*;
    import com.haloer.net.*;
    import com.lang.client.com.assist.server.*;

    public class RollCakeType extends Object
    {
        private static var _rollCake:Object;
        private static var _rollCount:Object;
        public static var statePoint:int = 0;
        public static var totalStatePoint:int = 0;
        private static const _stateLevelList:Array = [1900, 7600, 15200, 30400, 60800, 121600, 243200, 486400];
        private static const levelData:Object = {1:{id:13, type:RollCakeTypeLang.Gift1}, 2:{id:14, type:RollCakeTypeLang.Gift2}, 3:{id:15, type:RollCakeTypeLang.Gift3}, 4:{id:16, type:RollCakeTypeLang.Gift4}, 5:{id:17, type:RollCakeTypeLang.Gift5}, 6:{id:6, type:RollCakeTypeLang.Gift6}, 7:{id:8, type:RollCakeTypeLang.Gift7}, 8:{id:10, type:RollCakeTypeLang.Gift8}};

        public function RollCakeType()
        {
            return;
        }// end function

        public static function loadData(param1:Function, param2:Function = null) : void
        {
            var callback:* = param1;
            var error:* = param2;
            if (_rollCake)
            {
                RollCakeType.callback();
                return;
            }
            var url:* = URI.assetsUrl + "templet/roll_cake/roll_cake.txt";
            url = url + ("?v=" + URI.getVersion(url));
            var http:* = new HTTP();
            http.onComplete = function (param1:String) : void
            {
                formatData(JSON.decode(param1));
                callback();
                return;
            }// end function
            ;
            http.load(url);
            return;
        }// end function

        private static function formatData(param1:Array) : void
        {
            _rollCake = param1[0];
            _rollCount = param1[1];
            return;
        }// end function

        public static function getRollCakeName(param1:int) : String
        {
            return _rollCake[param1] ? (_rollCake[param1][0]) : ("");
        }// end function

        public static function getRollCakeNickName(param1:int) : String
        {
            return _rollCake[param1] ? (_rollCake[param1][1]) : ("");
        }// end function

        public static function getRollCakeSkill(param1:int) : int
        {
            return _rollCake[param1] ? (_rollCake[param1][2]) : (0);
        }// end function

        public static function getRollCakeStatePoint(param1:int) : int
        {
            return _rollCake[param1] ? (_rollCake[param1][3]) : (0);
        }// end function

        public static function getRollCakeCoin(param1:int) : int
        {
            return _rollCake[param1] ? (_rollCake[param1][4]) : (0);
        }// end function

        public static function getRollCountText(param1:int) : String
        {
            return _rollCount[param1] ? (_rollCount[param1][0]) : ("");
        }// end function

        public static function getRollCountPicture(param1:int) : String
        {
            return _rollCount[param1] ? (_rollCount[param1][1]) : ("");
        }// end function

        public static function expForLevelData(param1:int) : Object
        {
            var _loc_7:int = 0;
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            var _loc_4:Number = 0;
            var _loc_5:* = _stateLevelList.length;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = _stateLevelList[_loc_6];
                if (param1 < _loc_7)
                {
                    _loc_3 = _loc_7;
                    break;
                }
                else
                {
                    param1 = param1 - _loc_7;
                    _loc_2 = _loc_7;
                }
                _loc_4 = _loc_4 + 1;
                _loc_6++;
            }
            if (_loc_4 >= 8)
            {
                _loc_3 = param1;
            }
            return {minExp:_loc_2, maxExp:_loc_3, level:_loc_4, mainExp:param1};
        }// end function

        public static function levelForData(param1:int) : Object
        {
            return levelData[param1] || {};
        }// end function

    }
}
