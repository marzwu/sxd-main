package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface IFactionRollCake
    {

        public function IFactionRollCake();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onClose(param1:Function) : void;

        function init() : void;

        function clear() : void;

        function set onTip(param1:Function) : void;

        function reposition(param1:Point) : void;

        function set onSound(param1:Function) : void;

        function getMainSzData(param1:Object, param2:Boolean) : void;

        function set onGetRoll(param1:Function) : void;

        function allszAgain() : void;

        function set getFactionRollCakeInfo(param1:Object) : void;

        function set onShowMouse(param1:Function) : void;

    }
}
