package com.controllers
{
    import com.assist.view.info.*;

    public class PetAnimalController extends Base
    {

        public function PetAnimalController()
        {
            return;
        }// end function

        public function get result() : int
        {
            return _data.pet.result;
        }// end function

        public function get info() : PetLongInfo
        {
            return _data.pet.info;
        }// end function

    }
}
