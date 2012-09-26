package com.controllers
{

    public class AssistantController extends Base
    {

        public function AssistantController()
        {
            return;
        }// end function

        public function get getBoxInfo() : Array
        {
            return this._data.assistant.getBoxInfo;
        }// end function

        public function get getAward() : Object
        {
            return this._data.assistant.getAward;
        }// end function

        public function get completeNumber() : Object
        {
            return this._data.assistant.completeNumber;
        }// end function

        public function get liveNum() : int
        {
            return this._data.assistant.liveNum;
        }// end function

        public function get boxInfo() : Array
        {
            return this._data.assistant.boxInfo;
        }// end function

    }
}
