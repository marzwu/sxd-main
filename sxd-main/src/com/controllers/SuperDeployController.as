package com.controllers
{

    public class SuperDeployController extends Base
    {

        public function SuperDeployController()
        {
            return;
        }// end function

        public function get deployResearch() : Object
        {
            return this._data.superDeploy.deployResearch;
        }// end function

        public function get roleList() : Array
        {
            return this._data.superDeploy.roleList;
        }// end function

        public function get deployGrid() : Array
        {
            return this._data.superDeploy.deployGrid;
        }// end function

        public function get upDeploy() : Object
        {
            return this._data.superDeploy.upDeploy;
        }// end function

        public function get downDeploy() : Object
        {
            return this._data.superDeploy.downDeploy;
        }// end function

        public function get newDeployGridOpenNotify() : Object
        {
            return this._data.superDeploy.newDeployGridOpenNotify;
        }// end function

    }
}
