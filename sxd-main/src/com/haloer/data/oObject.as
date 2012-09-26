package com.haloer.data
{

    public class oObject extends Object
    {

        public function oObject()
        {
            return;
        }// end function

        public static function list(param1:Array, param2:Object, param3:Array) : void
        {
            if (!param1 || !param3)
            {
                throw new Error("list方法的第一个和第三个参数不能为null或undefined！");
            }
            var _loc_4:* = param3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                param2[param3[_loc_5]] = param1[_loc_5];
                _loc_5++;
            }
            return;
        }// end function

        public static function getKeys(param1:Object) : Array
        {
            var _loc_3:Object = null;
            var _loc_2:Array = [];
            for (_loc_3 in param1)
            {
                
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        public static function getValues(param1:Object) : Array
        {
            var _loc_3:Object = null;
            var _loc_2:Array = [];
            for (_loc_3 in param1)
            {
                
                _loc_2.push(param1[_loc_3]);
            }
            return _loc_2;
        }// end function

    }
}
