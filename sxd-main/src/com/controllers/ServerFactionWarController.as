package com.controllers
{
    import com.assist.view.info.*;

    public class ServerFactionWarController extends Base
    {

        public function ServerFactionWarController()
        {
            return;
        }// end function

        public function get info() : ServerFactionWarInfo
        {
            return this._data.serverFactionWar.info;
        }// end function

        public function get result() : int
        {
            return this._data.serverFactionWar.result;
        }// end function

        public function get signupState() : int
        {
            return this._data.serverFactionWar.signupState;
        }// end function

        public function get dieoutTip() : String
        {
            return this._data.serverFactionWar.dieoutTip;
        }// end function

        public function get dieoutWarList() : Array
        {
            return this._data.serverFactionWar.dieoutWarList;
        }// end function

    }
}
