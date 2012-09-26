package com.controllers
{
    import com.datas.*;
    import com.lang.client.com.controllers.*;

    public class DeployController extends Base
    {
        public var ownData:DeployData;
        public var DeployResearchId:int = 0;

        public function DeployController()
        {
            return;
        }// end function

        public function get deployList() : Array
        {
            var _loc_1:* = this.ownData.deployList;
            var _loc_2:Array = [];
            _loc_2[0] = this.renderPlayer(_loc_1);
            _loc_2[1] = this.renderOpenDeploy(_loc_1);
            _loc_2[2] = this.renderDeploy(_loc_1);
            _loc_2[3] = _loc_1[6];
            _loc_2[4] = {firstAttack:_loc_1[8]};
            return _loc_2;
        }// end function

        public function renderPlayer(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1[5].length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_6 = param1[5][_loc_4];
                _loc_5.id = _loc_6[0];
                _loc_5.isRoleMain = _loc_6[1];
                _loc_5.health = _loc_6[2] + "/" + _loc_6[3];
                _loc_5.name = _loc_6[4];
                if (_loc_5.isRoleMain == 1)
                {
                    _loc_5.name = _data.player.nickname;
                }
                _loc_5.job = _loc_6[5];
                _loc_5.level = _loc_6[6];
                _loc_5.roleJobName = _loc_6[7];
                _loc_5.roleStunt = _loc_6[8];
                _loc_5.liveType = _loc_6[9];
                _loc_5.strength = _loc_6[10];
                _loc_5.agile = _loc_6[11];
                _loc_5.intellect = _loc_6[12];
                _loc_5.isDeploy = _loc_6[13];
                _loc_5.isPlant = _loc_6[14];
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function renderOpenDeploy(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1[0].length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_6 = param1[0][_loc_4];
                _loc_5.id = _loc_6[0];
                _loc_5.name = _loc_6[1];
                _loc_5.level = _loc_6[2];
                _loc_5.isDefaut = _loc_6[3];
                _loc_5.researchId = _loc_6[4];
                _loc_5.topLevel = _loc_6[5] < 0;
                _loc_5.isPlayerLevel = _ctrl.player.level >= _loc_6[5];
                _loc_5.playerSkill = param1[7];
                _loc_5.upLevelSkill = _loc_6[6];
                if (_loc_5.level > 0)
                {
                    _loc_2.push(_loc_5);
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function renderDeploy(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_2:Array = [];
            _loc_2[0] = {};
            _loc_2[0].name = param1[1];
            _loc_2[0].level = param1[2];
            _loc_2[0].discript = param1[3];
            _loc_2[0].addInfo = _loc_2[0].level > 10 ? (DeployControllerLang.FirstStrike) : ("");
            this.DeployResearchId = param1[4];
            _loc_2[0].player = [];
            var _loc_3:* = param1[4].length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_6 = param1[4][_loc_4];
                _loc_5.id = _loc_6[1];
                _loc_5.place = _loc_6[0] - 1;
                _loc_2[0].player.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get upDeploy() : Array
        {
            var _loc_1:* = this.ownData.upDeploy;
            return _loc_1;
        }// end function

        public function get downDeploy() : Array
        {
            var _loc_1:* = this.ownData.downDeploy;
            return _loc_1;
        }// end function

        public function get allDownDeploy() : Array
        {
            var _loc_1:* = this.ownData.allDownDeploy;
            return _loc_1;
        }// end function

        public function get setDefautDeploy() : Array
        {
            var _loc_1:* = this.ownData.setDefautDeploy;
            return _loc_1;
        }// end function

    }
}
