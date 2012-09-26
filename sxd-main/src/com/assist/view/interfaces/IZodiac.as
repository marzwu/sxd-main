package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IZodiac
    {

        public function IZodiac();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set myLevel(param1:int) : void;

        function get myLevel() : int;

        function clear() : void;

        function init() : void;

        function renderZodiacInfo(param1:Object, param2:Boolean = false) : void;

        function renderChallengeSuccess(param1:Object, param2:Object) : void;

        function set onStartWar(param1:Function) : void;

        function set onGoldOilShop(param1:Function) : void;

    }
}
