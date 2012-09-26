package com.datas
{

    public class RuneData extends Base
    {
        private var _runeList:Array;
        private var _runeUse:Object;
        private var _batchRuneList:Array;
        private var _batchRuneUse:Array;
        private var _autoRuneInfo:Array;
        private var _setAutoRune:Array;
        private var _runeUseNotify:Array;

        public function RuneData()
        {
            return;
        }// end function

        public function get runeList() : Array
        {
            return this._runeList;
        }// end function

        public function get runeUse() : Object
        {
            return this._runeUse;
        }// end function

        public function get batchRuneList() : Array
        {
            return this._batchRuneList;
        }// end function

        public function get batchRuneUse() : Array
        {
            return this._batchRuneUse;
        }// end function

        public function get autoRuneInfo() : Array
        {
            return this._autoRuneInfo;
        }// end function

        public function get setAutoRune() : Array
        {
            return this._setAutoRune;
        }// end function

        public function get runeUseNotify() : Array
        {
            return this._runeUseNotify;
        }// end function

        public function rune_list(param1:Array) : void
        {
            this._runeList = param1;
            return;
        }// end function

        public function rune_use(param1:Object) : void
        {
            this._runeUse = param1;
            return;
        }// end function

        public function batch_rune_list(param1:Array) : void
        {
            this._batchRuneList = param1;
            return;
        }// end function

        public function batch_rune_use(param1:Array) : void
        {
            this._batchRuneUse = param1;
            return;
        }// end function

        public function auto_rune_info(param1:Array) : void
        {
            this._autoRuneInfo = param1;
            return;
        }// end function

        public function set_auto_rune(param1:Array) : void
        {
            this._setAutoRune = param1;
            return;
        }// end function

        public function rune_use_notify(param1:Array) : void
        {
            this._runeUseNotify = param1;
            return;
        }// end function

    }
}
