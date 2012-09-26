package com.assist.view.interfaces
{
    import com.haloer.display.*;
    import flash.display.*;

    public interface IFactionSeal
    {

        public function IFactionSeal();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set playerID(param1:int) : void;

        function set onCloseBtn(param1:Function) : void;

        function set onCallPlayerBtn(param1:Function) : void;

        function set onCallNpcBtn(param1:Function) : void;

        function set onJoinBtn(param1:Function) : void;

        function render() : void;

        function clear() : void;

        function renderFactionSealInfo(param1:Array, param2:int, param3:Boolean) : void;

        function renderSealingCartoon(param1:Image) : void;

        function renderSealedCartoon(param1:Image, param2:Function) : void;

    }
}
