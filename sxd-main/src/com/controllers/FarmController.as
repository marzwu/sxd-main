package com.controllers
{

    public class FarmController extends Base
    {

        public function FarmController()
        {
            return;
        }// end function

        public function get getFarmlandinfoList() : Array
        {
            return this._data.farm.getFarmlandinfoList;
        }// end function

        public function get maxFarmlandCount() : int
        {
            return this._data.farm.maxFarmlandCount;
        }// end function

        public function get getPlayerRoleInfoList() : Array
        {
            return this._data.farm.getPlayerRoleInfoList;
        }// end function

        public function get getSingleHerbsSeed() : Object
        {
            return this._data.farm.getSingleHerbsSeed;
        }// end function

        public function get getGroupHerbsSeed() : Array
        {
            return this._data.farm.getGroupHerbsSeed;
        }// end function

        public function get refreshHerbsSeed() : Object
        {
            return this._data.farm.refreshHerbsSeed;
        }// end function

        public function get getTopHerbsSeed() : Object
        {
            return this._data.farm.getTopHerbsSeed;
        }// end function

        public function get plantHerbs() : Object
        {
            return this._data.farm.plantHerbs;
        }// end function

        public function get harvestHerbs() : Object
        {
            return this._data.farm.harvestHerbs;
        }// end function

        public function get openFarmland() : Object
        {
            return this._data.farm.openFarmland;
        }// end function

        public function get checkRoleState() : Object
        {
            return this._data.farm.checkRoleState;
        }// end function

        public function get getSimpleFarmlandinfo() : Object
        {
            return this._data.farm.getSimpleFarmlandinfo;
        }// end function

        public function get clearFarmlandCd() : Object
        {
            return this._data.farm.clearFarmlandCd;
        }// end function

        public function get buyCoinTreeCountInfo() : Object
        {
            return this._data.farm.buyCoinTreeCountInfo;
        }// end function

        public function get buyCoinTreeCount() : Object
        {
            return this._data.farm.buyCoinTreeCount;
        }// end function

        public function get coinTreeCountNotify() : Object
        {
            return this._data.farm.coinTreeCountNotify;
        }// end function

        public function get ingotForFarmland() : Object
        {
            return this._data.farm.ingotForFarmland;
        }// end function

        public function get upFarmlandLevel() : Object
        {
            return this._data.farm.upFarmlandLevel;
        }// end function

        public function get getIsImgComplete() : Boolean
        {
            return this._data.farm.getIsImgComplete;
        }// end function

    }
}
