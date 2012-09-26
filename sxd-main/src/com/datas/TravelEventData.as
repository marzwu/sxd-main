package com.datas
{

    public class TravelEventData extends Base
    {
        private var _activityInfo:Array;
        private var _eventAndAnswer:Array;
        private var _travelEvent:Array;
        private var _cancelCd:Array;

        public function TravelEventData()
        {
            return;
        }// end function

        public function get activityInfo() : Array
        {
            return this._activityInfo;
        }// end function

        public function get eventAndAnswer() : Array
        {
            return this._eventAndAnswer;
        }// end function

        public function get travelEvent() : Array
        {
            return this._travelEvent;
        }// end function

        public function get cancelCd() : Array
        {
            return this._cancelCd;
        }// end function

        public function get_activity_info(param1:Array) : void
        {
            this._activityInfo = param1;
            return;
        }// end function

        public function get_event_and_answer(param1:Array) : void
        {
            this._eventAndAnswer = param1;
            return;
        }// end function

        public function answer_travel_event(param1:Array) : void
        {
            this._travelEvent = param1;
            return;
        }// end function

        public function cancel_cd(param1:Array) : void
        {
            this._cancelCd = param1;
            return;
        }// end function

    }
}
