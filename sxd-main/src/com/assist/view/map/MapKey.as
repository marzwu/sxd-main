package com.assist.view.map
{
    import com.assist.view.interfaces.map.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    final public class MapKey extends Object
    {
        public static const KEY_W:int = 87;
        public static const KEY_A:int = 65;
        public static const KEY_S:int = 83;
        public static const KEY_D:int = 68;
        public static const KEY_Space:int = 32;
        public static const KEY_RIGHT:int = 39;
        public static const KEY_LEFT:int = 37;
        public static const KEY_DOWN:int = 40;
        public static const KEY_UP:int = 38;
        public static const Event_Space:String = "Event_Space";
        private static var _MouseLeft:int = 0;
        private static var _MouseLeftTime:int = 0;
        private static var _keyArray:Array = [];
        private static var _ed:EventDispatcher = new EventDispatcher();

        public function MapKey()
        {
            return;
        }// end function

        public static function initKey(param1:Stage) : void
        {
            param1.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
            param1.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
            reset();
            return;
        }// end function

        public static function uninitKey(param1:Stage) : void
        {
            if (param1)
            {
                param1.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
                param1.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
            }
            reset();
            return;
        }// end function

        public static function keyDownHandler(event:KeyboardEvent) : void
        {
            _keyArray[event.keyCode] = true;
            return;
        }// end function

        public static function keyUpHandler(event:KeyboardEvent) : void
        {
            _keyArray[event.keyCode] = false;
            if (event.keyCode == KEY_Space)
            {
                _ed.dispatchEvent(new Event(Event_Space));
            }
            return;
        }// end function

        public static function reset() : void
        {
            if (_keyArray.length > 0)
            {
                _keyArray = [];
            }
            _MouseLeft = 0;
            return;
        }// end function

        public static function addEventListener(param1:String, param2:Function) : void
        {
            _ed.addEventListener(param1, param2);
            return;
        }// end function

        public static function removeEventListener(param1:String, param2:Function) : void
        {
            _ed.removeEventListener(param1, param2);
            return;
        }// end function

        private static function stageMouseUp(event:Event) : void
        {
            _MouseLeft = 0;
            _MouseLeftTime = getTimer();
            return;
        }// end function

        private static function stageMouseDown(event:Event) : void
        {
            var _loc_2:* = event.target as DisplayObject;
            while (_loc_2)
            {
                
                if (_loc_2 is IMap)
                {
                    _MouseLeft = 1;
                    _MouseLeftTime = getTimer();
                    break;
                }
                _loc_2 = _loc_2.parent;
            }
            return;
        }// end function

        public static function get isKeyAorLeft() : int
        {
            if (_keyArray[KEY_A] == true)
            {
                return 1;
            }
            if (_keyArray[KEY_LEFT] == true)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function get isKeyDorRIGHT() : int
        {
            if (_keyArray[KEY_D] == true)
            {
                return 1;
            }
            if (_keyArray[KEY_RIGHT] == true)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function get isKeySorDOWN() : int
        {
            if (_keyArray[KEY_S] == true)
            {
                return 1;
            }
            if (_keyArray[KEY_DOWN] == true)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function get isKeyWorUP() : int
        {
            if (_keyArray[KEY_W] == true)
            {
                return 1;
            }
            if (_keyArray[KEY_UP] == true)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function get isMouseFollow() : Boolean
        {
            return _MouseLeft == 1 && getTimer() - _MouseLeftTime > 300;
        }// end function

    }
}
