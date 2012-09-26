package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface ITakeBibleReady
    {

        public function ITakeBibleReady();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set onClose(param1:Function) : void;

        function set drag(param1:IDrag) : void;

        function set inspireInfo(param1:int) : void;

        function set onSure(param1:Function) : void;

        function set awardState(param1:Number) : void;

        function set onCancel(param1:Function) : void;

        function set isUserProtection(param1:int) : void;

        function set vipLevel(param1:int) : void;

        function init() : void;

        function hasApplyFriend(param1:Boolean, param2:Boolean = false) : void;

        function clear() : void;

        function set onTip(param1:Function) : void;

        function set onInspire(param1:Function) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

        function set onSummon(param1:Function) : void;

        function set onRefreshAngel(param1:Function) : void;

        function set onStartEscort(param1:Function) : void;

        function set escortStata(param1:int) : void;

        function set changeRefreshPrice(param1:int) : void;

        function set getEscortData(param1:Object) : void;

    }
}
