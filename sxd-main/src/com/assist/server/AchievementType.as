package com.assist.server
{
    import com.adobe.serialization.json.*;
    import com.assist.*;
    import com.haloer.data.*;
    import com.haloer.net.*;

    public class AchievementType extends Object
    {
        private static var _achievement:Object;
        private static var _tag:Object;

        public function AchievementType()
        {
            return;
        }// end function

        public static function loadData(param1:Function, param2:Function = null) : void
        {
            var callback:* = param1;
            var error:* = param2;
            if (_achievement)
            {
                AchievementType.callback();
                return;
            }
            var url:* = URI.assetsUrl + "templet/achievement/achievement.txt";
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
            _achievement = param1[0];
            _tag = param1[1];
            return;
        }// end function

        public static function getAchievementIds() : Array
        {
            return oObject.getKeys(_achievement);
        }// end function

        public static function getSign(param1:int) : String
        {
            return _achievement[param1] ? (_achievement[param1][0]) : ("");
        }// end function

        public static function getName(param1:int) : String
        {
            return _achievement[param1] ? (_achievement[param1][1]) : ("");
        }// end function

        public static function getContent(param1:int) : String
        {
            return _achievement[param1] ? (_achievement[param1][2]) : ("");
        }// end function

        public static function getTotal(param1:int) : int
        {
            return _achievement[param1] ? (_achievement[param1][3]) : (0);
        }// end function

        public static function getPoint(param1:int) : int
        {
            return _achievement[param1] ? (_achievement[param1][4]) : (0);
        }// end function

        public static function getSpecialAward(param1:int) : String
        {
            return _achievement[param1] ? (_achievement[param1][5]) : ("");
        }// end function

        public static function getSortOrder(param1:int) : int
        {
            return _achievement[param1] ? (_achievement[param1][6]) : (0);
        }// end function

        public static function getAchievementTagId(param1:int) : int
        {
            return _achievement[param1] ? (_achievement[param1][7]) : (0);
        }// end function

        public static function getAchievementTagName(param1:int) : String
        {
            return _tag[param1] ? (_tag[param1][1]) : ("");
        }// end function

        public static function getMasterTagIds() : Array
        {
            var _loc_2:String = null;
            var _loc_1:Array = [];
            for (_loc_2 in _tag)
            {
                
                if (_tag[_loc_2][0] == 0)
                {
                    _loc_1.push(parseInt(_loc_2));
                }
            }
            return _loc_1;
        }// end function

        public static function getSlaveTagIds(param1:int) : Array
        {
            var _loc_3:String = null;
            var _loc_2:Array = [];
            for (_loc_3 in _tag)
            {
                
                if (_tag[_loc_3][2] == param1 && _tag[_loc_3][0] == 1)
                {
                    _loc_2.push(parseInt(_loc_3));
                }
            }
            return _loc_2;
        }// end function

    }
}
