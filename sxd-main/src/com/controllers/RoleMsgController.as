package com.controllers
{

    public class RoleMsgController extends Base
    {

        public function RoleMsgController()
        {
            return;
        }// end function

        public function get roleList() : Array
        {
            return _data.rolemsg.roleList;
        }// end function

        public function get otherRoleList() : Array
        {
            return _data.rolemsg.otherRoleList;
        }// end function

        public function get result() : int
        {
            return _data.rolemsg.nearResult;
        }// end function

        public function get roleIdList() : Array
        {
            return _data.rolemsg.roleIdList;
        }// end function

        public function get ExpChange() : int
        {
            return _data.rolemsg.ExpChange;
        }// end function

        public function get coin() : int
        {
            return _data.rolemsg.coin;
        }// end function

        public function get radio() : int
        {
            return _data.rolemsg.radio;
        }// end function

        public function get trainingBase() : Array
        {
            return _data.rolemsg.trainingBase;
        }// end function

        public function get trainingOld() : Array
        {
            return _data.rolemsg.trainingOld;
        }// end function

        public function get trainingNew() : Array
        {
            return _data.rolemsg.trainingNew;
        }// end function

        public function get simpleRoleList() : Array
        {
            return _data.rolemsg.simpleRoleList;
        }// end function

        public function get flowersTips() : String
        {
            return _data.rolemsg.flowersTips;
        }// end function

        public function get hasLower() : Boolean
        {
            var _loc_1:int = 0;
            while (_loc_1 < 3)
            {
                
                if (_data.rolemsg.trainingNew[_loc_1] < _data.rolemsg.trainingOld[_loc_1])
                {
                    return true;
                }
                _loc_1++;
            }
            return false;
        }// end function

        public function get roleWarAttributeData() : Object
        {
            return _data.rolemsg.roleWarAttributeData;
        }// end function

        public function get getDefaultDeployFirstAttack() : Object
        {
            return _data.rolemsg.defaultDeployFirstAttackData;
        }// end function

    }
}
