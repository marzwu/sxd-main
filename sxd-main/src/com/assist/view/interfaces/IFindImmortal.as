package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IFindImmortal
    {

        public function IFindImmortal();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function set onClose(param1:Function) : void;

        function set onSummon(param1:Function) : void;

        function set onGoad(param1:Function) : void;

        function set isGoad(param1:Boolean) : void;

        function set onPickUp(param1:Function) : void;

        function set award(param1:Object) : void;

        function set pickUpAward(param1:Object) : void;

        function set ingot(param1:int) : void;

        function set coins(param1:Number) : void;

        function set fame(param1:int) : void;

        function set skill(param1:int) : void;

        function render() : void;

        function set state(param1:int) : void;

        function set onShowTip(param1:Function) : void;

        function set godId(param1:int) : void;

        function set summonTimes(param1:int) : void;

        function set isOpen(param1:Boolean) : void;

        function set resetMoving(param1:Boolean) : void;

        function reposition(param1:Number, param2:Number) : void;

        function loadEffect() : void;

        function set turnBig(param1:MovieClip) : void;

        function set greenBorn(param1:MovieClip) : void;

        function set greenWait(param1:MovieClip) : void;

        function set blueBorn(param1:MovieClip) : void;

        function set blueWait(param1:MovieClip) : void;

        function set purpleBorn(param1:MovieClip) : void;

        function set purpleWait(param1:MovieClip) : void;

        function set goldBorn(param1:MovieClip) : void;

        function set goldWait(param1:MovieClip) : void;

        function set greenFailed(param1:MovieClip) : void;

        function set blueFailed(param1:MovieClip) : void;

        function set purpleFailed(param1:MovieClip) : void;

        function set goldFailed(param1:MovieClip) : void;

        function set waitToBig(param1:MovieClip) : void;

        function bornEffect(param1:int) : void;

    }
}
