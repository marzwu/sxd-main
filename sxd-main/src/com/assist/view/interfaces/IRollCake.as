package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface IRollCake
    {

        public function IRollCake();

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

        function set isFirst(param1:Boolean) : void;

        function set szAgainForId(param1:int) : void;

        function allszAgain() : void;

        function set onRobelRedirection(param1:Function) : void;

        function set onSureAward(param1:Function) : void;

        function getPoinExp(param1:Number, param2:Number, param3:Number) : void;

        function set onSaveState(param1:Function) : void;

        function set saveState(param1:int) : void;

        function set getPointLevel(param1:int) : void;

        function set getCountNum(param1:int) : void;

        function set getSkill(param1:int) : void;

        function set getStatePoing(param1:int) : void;

        function set getFreeRobeNum(param1:int) : void;

        function set getRobeMaxNum(param1:int) : void;

        function set isVip4(param1:Boolean) : void;

        function set isVip10(param1:Boolean) : void;

        function set onUserRobel(param1:Function) : void;

        function set onShowMouse(param1:Function) : void;

        function set sureTip(param1:String) : void;

        function userRobel() : void;

        function set onAuto(param1:Function) : void;

        function set isAuto(param1:Boolean) : void;

    }
}
