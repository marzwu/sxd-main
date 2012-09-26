package com.datas
{

    public class DeployData extends Base
    {
        private var _deployList:Array;
        private var _upDeploy:Array;
        private var _downDeploy:Array;
        private var _allDownDeploy:Array;
        private var _setDefautDeploy:Array;

        public function DeployData()
        {
            return;
        }// end function

        public function get deployList() : Array
        {
            return this._deployList;
        }// end function

        public function get upDeploy() : Array
        {
            return this._upDeploy;
        }// end function

        public function get downDeploy() : Array
        {
            return this._downDeploy;
        }// end function

        public function get allDownDeploy() : Array
        {
            return this._allDownDeploy;
        }// end function

        public function get setDefautDeploy() : Array
        {
            return this._setDefautDeploy;
        }// end function

        public function deploy_list(param1:Array) : void
        {
            this._deployList = param1;
            return;
        }// end function

        public function up_deploy(param1:Array) : void
        {
            this._upDeploy = param1;
            return;
        }// end function

        public function down_deploy(param1:Array) : void
        {
            this._downDeploy = param1;
            return;
        }// end function

        public function all_down_deploy(param1:Array) : void
        {
            this._allDownDeploy = param1;
            return;
        }// end function

        public function set_defaut_deploy(param1:Array) : void
        {
            this._setDefautDeploy = param1;
            return;
        }// end function

    }
}
