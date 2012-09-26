package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface IFingerGuess
    {

        public function IFingerGuess();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function set onClose(param1:Function) : void;

        function init() : void;

        function set onGameEnd(param1:Function) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

        function fingerGuessData(param1:Object) : void;

        function set onChuQuan(param1:Function) : void;

        function MainChuQuanSuccess() : void;

        function OtherChuQuan2Success() : void;

        function getAward(param1:Object) : void;

    }
}
