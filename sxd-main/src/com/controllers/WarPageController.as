package com.controllers
{

    public class WarPageController extends Base
    {

        public function WarPageController()
        {
            return;
        }// end function

        public function get enemyList() : Array
        {
            return _data.warPage.warPageInfo.enemyList;
        }// end function

    }
}
