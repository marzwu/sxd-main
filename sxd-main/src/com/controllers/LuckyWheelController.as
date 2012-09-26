package com.controllers
{

    public class LuckyWheelController extends Base
    {

        public function LuckyWheelController()
        {
            return;
        }// end function

        public function get state() : int
        {
            return _data.luckyWheel.state;
        }// end function

        public function get openInfo() : Object
        {
            return _data.luckyWheel.openInfo;
        }// end function

        public function get runState() : int
        {
            return _data.luckyWheel.runState;
        }// end function

        public function get runInfo() : Object
        {
            return _data.luckyWheel.runInfo;
        }// end function

    }
}
