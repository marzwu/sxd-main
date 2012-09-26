package com.assist.view.warSoul
{
    import flash.display.*;
    import flash.geom.*;

    public class Moving extends Object
    {

        public function Moving()
        {
            return;
        }// end function

        public static function moveBeeline(param1:MovieClip, param2:Number, param3:Number) : void
        {
            param1.x = param1.x - param2 * Math.sin(param3 / 180 * Math.PI);
            param1.y = param1.y + param2 * Math.cos(param3 / 180 * Math.PI);
            return;
        }// end function

        public static function mcAngle(param1:Point, param2:Point) : Number
        {
            var _loc_3:* = param1.x - param2.x;
            var _loc_4:* = param1.y - param2.y;
            var _loc_5:* = (270 + Math.atan2(_loc_4, _loc_3) * 180 / Math.PI) % 360;
            return (270 + Math.atan2(_loc_4, _loc_3) * 180 / Math.PI) % 360;
        }// end function

        public static function rocketMoveForPoint(param1:MovieClip, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:int = 1) : void
        {
            var _loc_7:* = param1.x - param2;
            var _loc_8:* = param1.y - param3;
            var _loc_9:* = (270 + Math.atan2(_loc_8, _loc_7) * 180 / Math.PI) % 360;
            var _loc_10:* = ((270 + Math.atan2(_loc_8, _loc_7) * 180 / Math.PI) % 360 - param1.rotation + 360) % 360;
            param6 = ((270 + Math.atan2(_loc_8, _loc_7) * 180 / Math.PI) % 360 - param1.rotation + 360) % 360 <= 180 ? (1) : (-1);
            if (param5)
            {
                param1.rotation = _loc_10 < 180 && _loc_10 > param5 || _loc_10 > 180 && 360 - _loc_10 > param5 ? (param1.rotation + param5 * param6) : (_loc_9);
            }
            else
            {
                param1.rotation = _loc_9;
            }
            param1.x = param1.x - param4 * Math.sin(param1.rotation / 180 * Math.PI) * 2;
            param1.y = param1.y + param4 * Math.cos(param1.rotation / 180 * Math.PI);
            return;
        }// end function

        public static function mcPointMove(param1:MovieClip, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:int = 1) : void
        {
            var _loc_7:* = param1.x - param2;
            var _loc_8:* = param1.y - param3;
            var _loc_9:* = (270 + Math.atan2(_loc_8, _loc_7) * 180 / Math.PI) % 360;
            param1.x = param1.x - param4 * Math.sin(_loc_9 / 180 * Math.PI);
            param1.y = param1.y + param4 * Math.cos(_loc_9 / 180 * Math.PI);
            return;
        }// end function

        public static function pointDistance(param1:MovieClip, param2:Number, param3:Number) : Number
        {
            var _loc_4:* = param1.x - param2;
            var _loc_5:* = param1.y - param3;
            var _loc_6:* = Math.sqrt(_loc_4 * _loc_4 + _loc_5 * _loc_5);
            return Math.sqrt(_loc_4 * _loc_4 + _loc_5 * _loc_5);
        }// end function

    }
}
