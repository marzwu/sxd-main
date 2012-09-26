package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface ISealSoul
    {

        public function ISealSoul();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function reposition(param1:Point) : void;

        function set onOpenSoulShop(param1:Function) : void;

        function clear() : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onChange(param1:Function) : void;

        function set isSave(param1:Boolean) : void;

        function isLockOn(param1:int, param2:Boolean) : void;

        function set onMove(param1:Function) : void;

        function set getSuccinctNum(param1:int) : void;

        function set getStoneNum(param1:int) : void;

        function set onSaveSoul(param1:Function) : void;

        function set showTip(param1:Function) : void;

        function set onSuccinct(param1:Function) : void;

        function set getOpenNum(param1:int) : void;

        function set onLock(param1:Function) : void;

        function set onUnLock(param1:Function) : void;

        function set onActivation(param1:Function) : void;

        function set onBuy(param1:Function) : void;

        function set onShowChat(param1:Function) : void;

        function set isLevel5(param1:Boolean) : void;

        function init() : void;

        function set onShowBatchTraining(param1:Function) : void;

        function set onHideBatchTraining(param1:Function) : void;

        function set onBlessLevel(param1:Function) : void;

        function hideTraining() : void;

        function set onCloseTraining(param1:Function) : void;

        function set onSave(param1:Function) : void;

        function set onTraining(param1:Function) : void;

        function set getbatchTrainingList(param1:Array) : void;

        function buyLoadData() : void;

        function LoadData() : void;

        function resetLive() : void;

        function set onCheckPlayer(param1:Function) : void;

        function getPlayerList(param1:Array, param2:int) : void;

        function set getWeaponList(param1:Array) : void;

        function set getPlayerWeaponInfo(param1:Object) : void;

        function set getJobToSealSoul(param1:String) : void;

        function set getSealSoulList(param1:Array) : void;

    }
}
