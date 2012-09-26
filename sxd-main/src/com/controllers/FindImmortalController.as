package com.controllers
{

    public class FindImmortalController extends Base
    {

        public function FindImmortalController()
        {
            return;
        }// end function

        public function get openFindImmortal() : Object
        {
            return _data.findImmortal.openFindImmortal;
        }// end function

        public function get start() : Object
        {
            return _data.findImmortal.start;
        }// end function

        public function get goad() : Object
        {
            return _data.findImmortal.goadResult;
        }// end function

        public function get pickUpAward() : Object
        {
            return _data.findImmortal.pickUpAward;
        }// end function

        public function get flagNum() : int
        {
            return _data.findImmortal.flagNum;
        }// end function

    }
}
