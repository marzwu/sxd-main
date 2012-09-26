package com.controllers
{

    public class DuanWuController extends Base
    {

        public function DuanWuController()
        {
            return;
        }// end function

        public function get isWorshiped() : int
        {
            return _data.duanWu.isWorshiped();
        }// end function

        public function get zongziNum() : int
        {
            return _data.duanWu.getZongziNum();
        }// end function

        public function get getRecordList() : Array
        {
            return _data.duanWu.getRecordList();
        }// end function

        public function get worshipResult() : int
        {
            return _data.duanWu.worshipResult();
        }// end function

        public function get worshipZongziNum() : int
        {
            return _data.duanWu.worshipZongziNum();
        }// end function

        public function get worshipList() : Array
        {
            return _data.duanWu.worshipList();
        }// end function

        public function get stateResult() : int
        {
            return _data.duanWu.stateResult;
        }// end function

        public function get getItemResult() : int
        {
            return _data.duanWu.getItemResult;
        }// end function

    }
}
