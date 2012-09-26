package com.assist.view
{
    import com.views.*;
    import flash.display.*;
    import flash.utils.*;

    public class Shortcut extends Object
    {
        public static var getRelatedView:Function;
        private static var _views:Dictionary = new Dictionary();
        private static var _focusView:IView;

        public function Shortcut()
        {
            return;
        }// end function

        public static function addTarget(param1:DisplayObject, param2:Function, ... args) : void
        {
            args = getRelatedView(param1);
            if (args == null)
            {
                return;
            }
            if (_views[args] == null)
            {
                _views[args] = {index:-1, list:[], hotspot:null};
            }
            _views[args]["list"].push({target:param1, handler:param2, args:args});
            if (_views[args]["index"] == -1)
            {
                moveDown();
            }
            return;
        }// end function

        public static function removeTarget(param1:DisplayObject) : void
        {
            var _loc_2:* = getRelatedView(param1);
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = _views[_loc_2]["list"];
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (_loc_3[_loc_5]["target"] == param1)
                {
                    _loc_3.splice(_loc_5, 1);
                    break;
                }
                _loc_5++;
            }
            return;
        }// end function

        public static function clearAllTarget(param1:DisplayObject) : void
        {
            var _loc_2:* = getRelatedView(param1);
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = _views[_loc_2]["hotspot"];
            if (_loc_3 && _loc_3.parent)
            {
                _loc_3.parent.removeChild(_loc_3);
            }
            _views[_loc_2]["list"] = [];
            return;
        }// end function

        public static function removeView(param1:IView) : void
        {
            if (_views[param1] != null)
            {
                delete _views[param1];
            }
            return;
        }// end function

        public static function moveUp() : Boolean
        {
            return move(true);
        }// end function

        public static function moveDown() : Boolean
        {
            return move(false);
        }// end function

        private static function move(param1:Boolean) : Boolean
        {
            if (_focusView == null)
            {
                return false;
            }
            var _loc_2:* = _views[_focusView];
            if (_loc_2 == null)
            {
                return false;
            }
            var _loc_3:* = _loc_2["index"];
            var _loc_4:* = _loc_2["list"];
            var _loc_5:* = _loc_2["hotspot"];
            if (_loc_4.length == 0)
            {
                return false;
            }
            _loc_3 = _loc_3 + (param1 ? (-1) : (1));
            if (_loc_3 <= -1)
            {
                _loc_3 = _loc_4.length - 1;
            }
            if (_loc_3 >= _loc_4.length)
            {
                _loc_3 = 0;
            }
            _loc_2["index"] = _loc_3;
            var _loc_6:* = _loc_4[_loc_3]["target"];
            var _loc_7:* = _loc_4[_loc_3]["handler"];
            if (_loc_5 == null)
            {
                var _loc_8:* = new Sprite();
                _loc_2["hotspot"] = new Sprite();
                _loc_5 = _loc_8;
                _loc_5.mouseEnabled = false;
            }
            _loc_5.graphics.clear();
            _loc_5.graphics.beginFill(13421772, 0.2);
            _loc_5.graphics.drawRect(0, 0, _loc_6.width, _loc_6.height);
            _loc_5.x = _loc_6.x;
            _loc_5.y = _loc_6.y;
            _loc_6.parent.addChild(_loc_5);
            return true;
        }// end function

        public static function execute() : Boolean
        {
            if (_focusView == null)
            {
                return false;
            }
            var _loc_1:* = _views[_focusView];
            if (_loc_1 == null)
            {
                return false;
            }
            var _loc_2:* = _loc_1["index"];
            var _loc_3:* = _loc_1["list"];
            if (undefined == _loc_3[_loc_2])
            {
                return false;
            }
            var _loc_4:* = _loc_3[_loc_2]["handler"];
            var _loc_5:* = _loc_3[_loc_2]["args"];
            if (_loc_4 is Function)
            {
                _loc_4.apply(null, _loc_5);
                return true;
            }
            return false;
        }// end function

        public static function set focusView(param1:IView) : void
        {
            _focusView = param1;
            return;
        }// end function

    }
}
