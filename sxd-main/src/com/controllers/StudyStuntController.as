package com.controllers
{

    public class StudyStuntController extends Base
    {

        public function StudyStuntController()
        {
            return;
        }// end function

        public function get stuntPointInfo() : Array
        {
            return this._data.studyStunt.stuntPointInfo;
        }// end function

        public function get stuntInfo() : Array
        {
            return this._data.studyStunt.stuntInfo;
        }// end function

        public function get playerInfo() : Object
        {
            return this._data.studyStunt.playerInfo;
        }// end function

        public function get playerStudyStunt() : Object
        {
            return this._data.studyStunt.playerStudyStunt;
        }// end function

        public function get mainRoleStuntIds() : Array
        {
            return _data.studyStunt.mainRoleStuntIds;
        }// end function

        public function get playerCanStudyStunt() : Object
        {
            return _data.studyStunt.playerCanStudyStunt;
        }// end function

        public function get isLoadComplete() : Boolean
        {
            return _data.studyStunt.isLoadComplete;
        }// end function

    }
}
