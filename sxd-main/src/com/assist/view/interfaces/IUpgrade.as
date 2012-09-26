package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IUpgrade
    {

        public function IUpgrade();

        function get content() : MovieClip;

        function set onCloseBtn(param1:Function) : void;

        function init(param1:int, param2:int) : void;

        function clear() : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onLevelUpBtn(param1:Function) : void;

        function set onEquipmentData(param1:Function) : void;

        function set onShowInsufficientCoins(param1:Function) : void;

        function set currentRoleID(param1:int) : void;

        function get currentRoleID() : int;

        function set pageCount(param1:int) : void;

        function get pageCount() : int;

        function set pageCurrent(param1:int) : void;

        function get pageCurrent() : int;

        function set previousEquipID(param1:int) : void;

        function get previousEquipID() : int;

        function get equipmentID() : int;

        function set myLevel(param1:int) : void;

        function set myCoins(param1:Number) : void;

        function renderEquipmentList(param1:Array) : void;

        function renderUpgradeSuccess(param1:Object) : void;

        function renderUpgradeUnSucess() : void;

        function renderRoleList(param1:Array) : void;

        function showUpgrageMessage(param1:String, param2:uint) : void;

        function updateCoins() : void;

    }
}
