package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IFarm
    {

        public function IFarm();

        function get content() : MovieClip;

        function set onCloseBtn(param1:Function) : void;

        function render() : void;

        function clear() : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set myIngot(param1:int) : void;

        function set cropIconUrl(param1:String) : void;

        function set onCanPlantCrop(param1:Function) : void;

        function set onFullStar(param1:Function) : void;

        function set onOpenField(param1:Function) : void;

        function set onPlantCrop(param1:Function) : void;

        function set onFarmData(param1:Function) : void;

        function set onPlantRole(param1:Function) : void;

        function set onRefreshCrop(param1:Function) : void;

        function set onHarvest(param1:Function) : void;

        function set onFieldCdBtn(param1:Function) : void;

        function set onBuyCoinTreeBtn(param1:Function) : void;

        function set onShowTip(param1:Function) : void;

        function set onFieldLevelUp(param1:Function) : void;

        function set onIngotForFarmland(param1:Function) : void;

        function set onBatPlant(param1:Function) : void;

        function set onIsChristmas(param1:Function) : void;

        function set onIsTreePlantingDay(param1:Function) : void;

        function set cropID(param1:int) : void;

        function get cropID() : int;

        function set fieldID(param1:int) : void;

        function get fieldID() : int;

        function set roleID(param1:int) : void;

        function get roleID() : int;

        function set myLevel(param1:int) : void;

        function get myLevel() : int;

        function set herbsTypeExp(param1:int) : void;

        function set herbsTypeCoin(param1:int) : void;

        function get isInPlanting() : Boolean;

        function renderFarmData(param1:Array) : void;

        function renderCanPlantCrop(param1:Object, param2:Array) : void;

        function renderPlantRole(param1:Array) : void;

        function renderPlantCrop(param1:Array) : void;

        function renderRefreshCrop(param1:Object) : void;

        function renderFullStar(param1:Object) : void;

        function renderOpenField(param1:Object) : void;

        function renderHarvest(param1:Object, param2:String) : void;

        function renderClearFarmlandCd(param1:int) : void;

        function renderCoinTreeCountInfo(param1:Object) : void;

        function renderIngotForFarmland(param1:Object) : void;

        function renderFieldLevelUp(param1:int) : void;

        function updateFieldCd() : void;

        function updateCoinTreeCd(param1:int) : void;

        function updateCoinTreeCount(param1:int) : void;

    }
}
