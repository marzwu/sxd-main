package com.datas
{

    public class FingerGuessData extends Base
    {
        public var FingerGuessState:Array;
        public var EnterRoom:Array;
        public var Fight:Array;
        public var Award:Array;
        public var IsFight:Array;
        public var TodayTimes:Array;

        public function FingerGuessData()
        {
            return;
        }// end function

        public function finger_guess_state(param1:Array) : void
        {
            this.FingerGuessState = param1;
            return;
        }// end function

        public function enter_room(param1:Array) : void
        {
            this.EnterRoom = param1;
            return;
        }// end function

        public function fight(param1:Array) : void
        {
            this.Fight = param1;
            return;
        }// end function

        public function award(param1:Array) : void
        {
            this.Award = param1;
            return;
        }// end function

        public function is_fight(param1:Array) : void
        {
            this.IsFight = param1;
            return;
        }// end function

        public function today_times(param1:Array) : void
        {
            this.TodayTimes = param1;
            return;
        }// end function

    }
}
