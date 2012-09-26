package com.controllers
{

    public class ConsumeAlertSettingController extends Base
    {

        public function ConsumeAlertSettingController()
        {
            return;
        }// end function

        public function get playerConsumeAlertSetInfo() : Array
        {
            return this._data.consumeAlertSetting.playerConsumeAlertSetInfo;
        }// end function

        public function get playerConsumeAlertSet() : Object
        {
            return this._data.consumeAlertSetting.playerConsumeAlertSet;
        }// end function

    }
}
