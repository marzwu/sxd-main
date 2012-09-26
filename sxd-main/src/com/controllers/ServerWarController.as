package com.controllers
{
    import com.assist.view.info.*;

    public class ServerWarController extends Base
    {

        public function ServerWarController()
        {
            return;
        }// end function

        public function get info() : ServerWarInfo
        {
            return this._data.serverWar.info;
        }// end function

        public function get result() : int
        {
            return this._data.serverWar.result;
        }// end function

        public function get signupState() : int
        {
            return this._data.serverWar.signupState;
        }// end function

        public function get dieoutTip() : String
        {
            return this._data.serverWar.dieoutTip;
        }// end function

        public function get dieoutWarList() : Array
        {
            return this._data.serverWar.dieoutWarList;
        }// end function

    }
}
