package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ILodge
    {

        public function ILodge();

        function get content() : MovieClip;

        function get lodgePlayer() : MovieClip;

        function get fateMc() : MovieClip;

        function set tip(param1:ITip) : void;

        function close() : void;

        function set isUpLevel(param1:Boolean) : void;

        function set loadImage(param1:Class) : void;

        function set onClose(param1:Function) : void;

        function showRune(param1:Boolean) : void;

        function set onOpenFate(param1:Function) : void;

        function set onFateInfo(param1:Function) : void;

        function set renderIngot(param1:Number) : void;

        function set renderFateInfo(param1:Number) : void;

        function set isVip5(param1:Boolean) : void;

        function set renderCoins(param1:Number) : void;

        function set onFastFate(param1:Function) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int) : void;

        function set isVip4(param1:Boolean) : void;

        function set onFunsionPickUp(param1:Function) : void;

        function checkFunsionPickUp(param1:Boolean) : void;

        function get checkPickUpFate() : Array;

        function get checkSellAllFate() : Array;

        function set onIsShowChat(param1:Function) : void;

        function set onOpenRune(param1:Function) : void;

        function IsShowChat(param1:Boolean) : void;

        function get MCChatBox() : MovieClip;

        function setTextAnimation(param1:int, param2:String) : void;

        function set fateNpcList(param1:Array) : void;

        function set onStartFate(param1:Function) : void;

        function set freeAppointTimes(param1:int) : void;

        function set onBuyNpc(param1:Function) : void;

        function set lootFateList(param1:Array) : void;

        function set onPickUpFate(param1:Function) : void;

        function set onSellFate(param1:Function) : void;

        function set onAllSellFate(param1:Function) : void;

        function set pickUpAllFate(param1:Array) : void;

        function sellAllFate() : void;

        function lootFateTempFateId(param1:int, param2:String, param3:int = 0) : void;

        function set addDesignated(param1:Object) : void;

        function set clearDesignated(param1:int) : void;

    }
}
