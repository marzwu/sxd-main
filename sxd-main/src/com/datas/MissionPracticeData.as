package com.datas
{

    public class MissionPracticeData extends Base
    {
        private var _practiceInfo:Array;
        private var _startPractice:Array;
        private var _cancelPractice:Array;
        private var _quickly:Array;
        private var _notify:Array;
        private var _continuePracticeInfo:Array;
        private var _continuePractice:Array;
        public var SetAutoSale:Array;
        public var CancelAutoSale:Array;

        public function MissionPracticeData()
        {
            return;
        }// end function

        public function get practiceInfo() : Array
        {
            return this._practiceInfo;
        }// end function

        public function get startPractice() : Array
        {
            return this._startPractice;
        }// end function

        public function get cancelPractice() : Array
        {
            return this._cancelPractice;
        }// end function

        public function get getQuickly() : Array
        {
            return this._quickly;
        }// end function

        public function get getNotify() : Array
        {
            return this._notify;
        }// end function

        public function get continuePracticeInfo() : Array
        {
            return this._continuePracticeInfo;
        }// end function

        public function get continuePractice() : Array
        {
            return this._continuePractice;
        }// end function

        public function get_practice_info(param1:Array) : void
        {
            this._practiceInfo = param1;
            return;
        }// end function

        public function start_practice(param1:Array) : void
        {
            this._startPractice = param1;
            return;
        }// end function

        public function cancel_practice(param1:Array) : void
        {
            this._cancelPractice = param1;
            return;
        }// end function

        public function quickly(param1:Array) : void
        {
            this._quickly = param1;
            return;
        }// end function

        public function notify(param1:Array) : void
        {
            this._notify = param1;
            return;
        }// end function

        public function get_continue_practice_info(param1:Array) : void
        {
            this._continuePracticeInfo = param1;
            return;
        }// end function

        public function continue_practice(param1:Array) : void
        {
            this._continuePractice = param1;
            return;
        }// end function

        public function set_auto_sale_item(param1:Array) : void
        {
            this.SetAutoSale = param1;
            return;
        }// end function

        public function cancel_auto_sale_item(param1:Array) : void
        {
            this.CancelAutoSale = param1;
            return;
        }// end function

    }
}
