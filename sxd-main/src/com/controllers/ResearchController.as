package com.controllers
{

    public class ResearchController extends Base
    {

        public function ResearchController()
        {
            return;
        }// end function

        public function getResearchList() : Array
        {
            return this._data.research.getResearchList;
        }// end function

        public function getCdTime() : int
        {
            return this._data.research.getCdTime;
        }// end function

        public function ResearchUpgrade() : Object
        {
            return this._data.research.getResearchUpgrade;
        }// end function

        public function ClearCdTimeShow() : Object
        {
            return this._data.research.getClearCdTimeShow;
        }// end function

        public function ClearCdTime() : Object
        {
            return this._data.research.getClearCdTime;
        }// end function

        public function getMySkill() : int
        {
            return this._data.research.getMySkill;
        }// end function

        public function researchAddList() : Array
        {
            return this._data.research.researchAddList;
        }// end function

    }
}
