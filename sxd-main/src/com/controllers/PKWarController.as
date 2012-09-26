package com.controllers
{
    import com.assist.data.mission.*;

    public class PKWarController extends Base
    {

        public function PKWarController()
        {
            return;
        }// end function

        public function get warData() : WarData
        {
            return _data.pkWar.warData;
        }// end function

        public function get reportId() : int
        {
            return _data.pkWar.reportId;
        }// end function

    }
}
