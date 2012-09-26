package com.controllers
{
    import com.assist.data.mission.*;
    import com.assist.view.info.*;

    public class DreamSectionController extends Base
    {

        public function DreamSectionController()
        {
            return;
        }// end function

        public function get result() : int
        {
            return _data.dreamSection.result;
        }// end function

        public function get dreamSectionInfo() : DreamSectionInfo
        {
            return _data.dreamSection.info;
        }// end function

        public function get requestRoleObj() : Object
        {
            return _data.dreamSection.info.requestRoleObj;
        }// end function

        public function get requestGuanObj() : Object
        {
            return _data.dreamSection.info.requestGuanObj;
        }// end function

        public function get aura() : int
        {
            return _data.dreamSection.info.aura;
        }// end function

        public function get bWin() : Boolean
        {
            return _data.dreamSection.info.bWin;
        }// end function

        public function set bWin(param1:Boolean) : void
        {
            _data.dreamSection.info.bWin = param1;
            return;
        }// end function

        public function get nextLock() : int
        {
            return _data.dreamSection.info.next_lock;
        }// end function

        public function get warData() : WarData
        {
            return _data.dreamSection.warData;
        }// end function

    }
}
