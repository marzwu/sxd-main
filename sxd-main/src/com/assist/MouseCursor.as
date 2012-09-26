package com.assist
{
    import flash.display.*;
    import flash.ui.*;

    public class MouseCursor extends Object
    {
        private static var _arr:Array = [];
        private static var _cursor:DisplayObject;
        private static var _offX:int = 0;
        private static var _offY:int = 0;
        private static var _layder:Sprite;
        private static var idx:int = 1;
        public static var Map1Cursor:int = idx + 1;
        public static var Map2Cursor:int = idx + 1;
        public static var Map3Cursor:int = idx + 1;

        public function MouseCursor()
        {
            return;
        }// end function

        public static function init(param1:Sprite, param2:Stage) : void
        {
            _layder = param1;
            return;
        }// end function

        public static function updateCursorXY() : void
        {
            if (_cursor)
            {
                _cursor.x = _layder.mouseX + _offX;
                _cursor.y = _layder.mouseY + _offY;
            }
            return;
        }// end function

        private static function updateCursor() : void
        {
            var _loc_1:* = _arr.length;
            var _loc_2:Object = null;
            while (_loc_1 > 0)
            {
                
                _loc_1 = _loc_1 - 1;
                _loc_2 = _arr[_loc_1];
                if (_loc_2)
                {
                    break;
                }
            }
            if (_cursor == _loc_2)
            {
                return;
            }
            if (_cursor && _cursor.parent == _layder)
            {
                _layder.removeChild(_cursor);
            }
            _cursor = null;
            if (_loc_2)
            {
                _cursor = _loc_2.m as DisplayObject;
                _layder.addChild(_cursor);
                _offX = _loc_2.x;
                _offY = _loc_2.y;
                _cursor.x = _layder.mouseX + _offX;
                _cursor.y = _layder.mouseY + _offY;
                Mouse.hide();
            }
            else
            {
                Mouse.show();
            }
            return;
        }// end function

        public static function showMouseCursor(param1:int, param2:DisplayObject, param3:int = 0, param4:int = 0) : void
        {
            _arr[param1] = {m:param2, x:param3, y:param4};
            if (param2 != _cursor)
            {
                updateCursor();
            }
            return;
        }// end function

        public static function hideMouseCursor(param1:int) : void
        {
            _arr[param1] = null;
            updateCursor();
            return;
        }// end function

        public static function show() : void
        {
            _arr = [];
            if (_cursor && _cursor.parent == _layder)
            {
                _layder.removeChild(_cursor);
            }
            _cursor = null;
            Mouse.show();
            return;
        }// end function

        public static function hide() : void
        {
            _arr = [];
            if (_cursor && _cursor.parent == _layder)
            {
                _layder.removeChild(_cursor);
            }
            _cursor = null;
            Mouse.hide();
            return;
        }// end function

    }
}
