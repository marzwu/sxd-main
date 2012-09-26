package com.assist.view
{
    import com.assist.*;
    import com.haloer.net.*;
    import flash.display.*;

    public class FunctionBarEffect extends Object
    {
        private static var _fileList:Array;

        public function FunctionBarEffect()
        {
            return;
        }// end function

        public static function loadEffect() : void
        {
            var _loc_1:Array = [URI.addonsUrl + "function_bar_effect.swf", URI.addonsUrl + "function_open.swf"];
            File.loadList(_loc_1, loadEffectComplete);
            return;
        }// end function

        private static function loadEffectComplete(param1:Array) : void
        {
            _fileList = param1;
            return;
        }// end function

        public static function get light() : Class
        {
            var _loc_1:* = (_fileList[0] as File).getClassByName("Light") as Class;
            return _loc_1;
        }// end function

        public static function get functionOpen() : Class
        {
            var _loc_1:* = (_fileList[1] as File).getClassByName("FunctionOpen") as Class;
            return _loc_1;
        }// end function

        public static function get video() : MovieClip
        {
            var _loc_1:* = (_fileList[0] as File).getClassObject("MyVideo") as MovieClip;
            _loc_1.gotoAndStop(1);
            _loc_1.blendMode = BlendMode.SCREEN;
            _loc_1.mouseEnabled = false;
            _loc_1.mouseChildren = false;
            return _loc_1;
        }// end function

    }
}
