package com.controllers
{

    public class WorshipMarsController extends Base
    {

        public function WorshipMarsController()
        {
            return;
        }// end function

        public function get marsInfo() : Object
        {
            return this._data.worshipMars.marsInfo;
        }// end function

        public function get incenseLog() : Array
        {
            return this._data.worshipMars.incenseLog;
        }// end function

        public function get marsIncense() : Object
        {
            return this._data.worshipMars.marsIncense;
        }// end function

        public function get getBlessingTimesAndExpAdd() : Object
        {
            return this._data.worshipMars.getBlessingTimesAndExpAdd;
        }// end function

        public function get getRemainIncenseTimes() : Object
        {
            return this._data.worshipMars.getRemainIncenseTimes;
        }// end function

    }
}
