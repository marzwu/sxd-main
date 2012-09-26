package com.controllers
{

    public class SpecialPartnerController extends Base
    {

        public function SpecialPartnerController()
        {
            return;
        }// end function

        public function get getPartnerInfo() : Array
        {
            return this._data.specialPartner.getPartnerInfo;
        }// end function

        public function get getMissionAward() : Object
        {
            return this._data.specialPartner.getMissionAward;
        }// end function

        public function get ingotComplete() : Object
        {
            return this._data.specialPartner.ingotComplete;
        }// end function

        public function get ingotCompleteRequireList() : Array
        {
            return this._data.specialPartner.ingotCompleteRequireList;
        }// end function

        public function get invitePartner() : Object
        {
            return this._data.specialPartner.invitePartner;
        }// end function

    }
}
