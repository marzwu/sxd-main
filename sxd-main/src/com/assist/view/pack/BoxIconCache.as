package com.assist.view.pack
{
    import com.haloer.display.*;

    public class BoxIconCache extends Object
    {
        private static var _cacheList:Array = [];

        public function BoxIconCache()
        {
            return;
        }// end function

        public static function pushImg(param1:Image) : void
        {
            if (param1 == null)
            {
                return;
            }
            var _loc_2:* = param1.url;
            _cacheList[_loc_2] = _cacheList[_loc_2] || [];
            _cacheList[_loc_2].push(param1);
            return;
        }// end function

        public static function getImg(param1:String, param2:Boolean) : Image
        {
            var _loc_3:Image = null;
            _cacheList[param1] = _cacheList[param1] || [];
            if (_cacheList[param1].length > 0)
            {
                _loc_3 = _cacheList[param1].pop() as Image;
                _loc_3.x = 0;
                _loc_3.y = 0;
                return _loc_3;
            }
            return new Image(param1, param2);
        }// end function

    }
}
