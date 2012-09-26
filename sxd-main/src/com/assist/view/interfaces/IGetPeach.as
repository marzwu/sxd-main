package com.assist.view.interfaces
{
    import com.haloer.display.*;
    import flash.display.*;

    public interface IGetPeach
    {

        public function IGetPeach();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onClose(param1:Function) : void;

        function clear() : void;

        function set onTip(param1:Function) : void;

        function set onGetPeach(param1:Function) : void;

        function set onBuyMonkeys(param1:Function) : void;

        function peachInfo(param1:Object, param2:Boolean, param3:Boolean) : void;

        function set playerInfo(param1:Object) : void;

        function set summerWuKong(param1:int) : void;

        function set buttenSuccess(param1:Object) : void;

        function addWuKong(param1:Image) : void;

        function addAnger(param1:Image) : void;

    }
}
