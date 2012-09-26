package com.datas
{

    public class FateData extends Base
    {
        private var _fateNpc:Array;
        private var _tempFate:Array;
        private var _pickupFate:Array;
        private var _saleTempFate:Array;
        private var _bagList:Array;
        private var _buyBagGrid:Array;
        private var _roleFateList:Array;
        private var _wearOn:Array;
        private var _discardFate:Array;
        private var _appointFateNpc:Array;
        private var _wearOffFate:Array;
        private var _openFate:Array;
        private var _changeFateGrid:Array;
        private var _changePosition:Array;
        private var _merge:Array;
        private var _getFatePower:Array;
        private var _mergeData:Array;
        private var _mergeAllInBag:Array;
        private var _buyFateNpc:Array;
        public var ExchangeFate:Array;
        public var getScrapAmount:Array;
        public var MergeAllNormalInBag:Array;

        public function FateData()
        {
            return;
        }// end function

        public function get fateNpc() : Array
        {
            return this._fateNpc;
        }// end function

        public function get tempFate() : Array
        {
            return this._tempFate;
        }// end function

        public function get pickupFate() : Array
        {
            return this._pickupFate;
        }// end function

        public function get saleTempFate() : Array
        {
            return this._saleTempFate;
        }// end function

        public function get bagList() : Array
        {
            return this._bagList;
        }// end function

        public function get buyBagGrid() : Array
        {
            return this._buyBagGrid;
        }// end function

        public function get roleFateList() : Array
        {
            return this._roleFateList;
        }// end function

        public function get wearOn() : Array
        {
            return this._wearOn;
        }// end function

        public function get discardFate() : Array
        {
            return this._discardFate;
        }// end function

        public function get appointFateNpc() : Array
        {
            return this._appointFateNpc;
        }// end function

        public function get wearOffFate() : Array
        {
            return this._wearOffFate;
        }// end function

        public function get openFate() : Array
        {
            return this._openFate;
        }// end function

        public function get changeFateGrid() : Array
        {
            return this._changeFateGrid;
        }// end function

        public function get changePosition() : Array
        {
            return this._changePosition;
        }// end function

        public function get merge() : Array
        {
            return this._merge;
        }// end function

        public function get getFatePower() : Array
        {
            return this._getFatePower;
        }// end function

        public function get mergeData() : Array
        {
            return this._mergeData;
        }// end function

        public function get mergeAllInBag() : Array
        {
            return this._mergeAllInBag;
        }// end function

        public function get buyFateNpc() : Array
        {
            return this._buyFateNpc;
        }// end function

        public function get_fate_npc(param1:Array) : void
        {
            this._fateNpc = param1;
            return;
        }// end function

        public function get_temp_fate(param1:Array) : void
        {
            this._tempFate = param1;
            return;
        }// end function

        public function pickup_fate(param1:Array) : void
        {
            this._pickupFate = param1;
            return;
        }// end function

        public function sale_temp_fate(param1:Array) : void
        {
            this._saleTempFate = param1;
            return;
        }// end function

        public function get_bag_list(param1:Array) : void
        {
            this._bagList = param1;
            return;
        }// end function

        public function buy_bag_grid(param1:Array) : void
        {
            this._buyBagGrid = param1;
            return;
        }// end function

        public function get_role_fate_list(param1:Array) : void
        {
            this._roleFateList = param1;
            return;
        }// end function

        public function wear_on(param1:Array) : void
        {
            this._wearOn = param1;
            return;
        }// end function

        public function discard_fate(param1:Array) : void
        {
            this._discardFate = param1;
            return;
        }// end function

        public function appoint_fate_npc(param1:Array) : void
        {
            this._appointFateNpc = param1;
            return;
        }// end function

        public function wear_off_fate(param1:Array) : void
        {
            this._wearOffFate = param1;
            return;
        }// end function

        public function open_fate(param1:Array) : void
        {
            this._openFate = param1;
            return;
        }// end function

        public function change_fate_grid(param1:Array) : void
        {
            this._changeFateGrid = param1;
            return;
        }// end function

        public function change_position(param1:Array) : void
        {
            this._changePosition = param1;
            return;
        }// end function

        public function merge_fate(param1:Array) : void
        {
            this._merge = param1;
            return;
        }// end function

        public function get_player_role_fate_power(param1:Array) : void
        {
            this._getFatePower = param1;
            return;
        }// end function

        public function get_merge_data(param1:Array) : void
        {
            this._mergeData = param1;
            return;
        }// end function

        public function merge_all_in_bag(param1:Array) : void
        {
            this._mergeAllInBag = param1;
            return;
        }// end function

        public function buy_fate_npc(param1:Array) : void
        {
            this._buyFateNpc = param1;
            return;
        }// end function

        public function exchange_fate(param1:Array) : void
        {
            this.ExchangeFate = param1;
            return;
        }// end function

        public function get_scrap_amount(param1:Array) : void
        {
            this.getScrapAmount = param1;
            return;
        }// end function

        public function merge_all_normal_in_bag(param1:Array) : void
        {
            this.MergeAllNormalInBag = param1;
            return;
        }// end function

    }
}
