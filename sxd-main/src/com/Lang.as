package com
{
    import com.haloer.data.*;
    import flash.utils.*;

    public class Lang extends Object
    {

        public function Lang()
        {
            return;
        }// end function

        public static function sprintf(param1:String, ... args) : String
        {
            var _loc_5:RegExp = null;
            args = args.length;
            var _loc_4:int = 1;
            while (_loc_4 <= args)
            {
                
                _loc_5 = new RegExp("\\$<" + _loc_4 + ">");
                param1 = param1.replace(_loc_5, args[(_loc_4 - 1)]);
                _loc_4++;
            }
            return param1;
        }// end function

        public static function output(param1:Class) : String
        {
            var _loc_6:XML = null;
            var _loc_7:Array = null;
            var _loc_8:String = null;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:String = null;
            var _loc_2:* = describeType(param1);
            var _loc_3:* = _loc_2.children();
            var _loc_4:Object = {};
            var _loc_5:String = "";
            for each (_loc_6 in _loc_3)
            {
                
                _loc_11 = _loc_6.name();
                if (_loc_11 == "constant" || _loc_11 == "variable")
                {
                    _loc_5 = _loc_6.attribute("name");
                    _loc_4[_loc_5] = param1[_loc_5].replace(/\r|\
n""\r|\n/g, "\\n");
                }
            }
            _loc_7 = oObject.getKeys(_loc_4);
            _loc_7.sort(Array.CASEINSENSITIVE);
            _loc_8 = "";
            _loc_9 = _loc_7.length;
            _loc_10 = 0;
            while (_loc_10 < _loc_9)
            {
                
                if (_loc_8 != "")
                {
                    _loc_8 = _loc_8 + "\r\n";
                }
                _loc_5 = _loc_7[_loc_10];
                _loc_8 = _loc_8 + (_loc_5 + " : " + _loc_4[_loc_5]);
                _loc_10++;
            }
            return _loc_8;
        }// end function

    }
}
