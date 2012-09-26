package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.guide.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class DeployView extends Base implements IView
    {
        private var _deploy:IDeploy;
        private var _firstAttack:int = 0;
        private var _playerData:Array;
        private var _deployData:Array;
        private var _deFaultData:Array;
        private var _downTimer:int = 0;
        private var _showDeploy:String = "";
        private var _openDeployLevel:int = 0;
        private var _isDefautDeploy:Boolean = false;
        private var _deployID:int = 0;
        private var _isShowSequence:Boolean = false;

        public function DeployView()
        {
            this._playerData = [];
            this._deployData = [];
            this._deFaultData = [];
            return;
        }// end function

        private function open_Deploy(param1:int) : void
        {
            _data.call(Mod_Deploy_Base.deploy_list, this.openDeployCallback, [param1]);
            return;
        }// end function

        private function deploy_list(param1:int) : void
        {
            _data.call(Mod_Deploy_Base.deploy_list, this.deployListCallback, [param1]);
            return;
        }// end function

        private function up_deploy(param1:int, param2:int, param3:int) : void
        {
            _data.call(Mod_Deploy_Base.up_deploy, this.upDeployCallback, [param1, param2, param3]);
            return;
        }// end function

        private function down_deploy(param1:int, param2:int) : void
        {
            _data.call(Mod_Deploy_Base.down_deploy, this.downDeployCallback, [param1, param2]);
            return;
        }// end function

        private function all_down_deploy(param1:int) : void
        {
            _data.call(Mod_Deploy_Base.all_down_deploy, this.allDownDeployCallback, [param1], false);
            return;
        }// end function

        private function set_defaut_deploy(param1:int) : void
        {
            _data.call(Mod_Deploy_Base.set_defaut_deploy, this.setDefautDeployCallback, [param1], false);
            return;
        }// end function

        public function show() : void
        {
            if (_view.factionWarMap.isFactionWarStart == true)
            {
                return;
            }
            this.open_Deploy(0);
            return;
        }// end function

        private function openDeployCallback() : void
        {
            var _loc_5:Object = null;
            var _loc_1:* = _ctrl.deploy.deployList;
            var _loc_2:* = _loc_1[0].length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = {};
                _loc_5 = this.playerIcon(_loc_1[0][_loc_4]);
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            this._playerData = _loc_3;
            this._deployData = _loc_1[1];
            this._deFaultData = _loc_1[2];
            this._downTimer = _loc_1[3];
            this._firstAttack = _loc_1[4].firstAttack;
            this._showDeploy = this._deFaultData[0].name;
            this._openDeployLevel = this._deFaultData[0].level;
            if (inStage == false)
            {
                loadAssets("Deploy", this.render, DeployViewLang.LoadAssets);
            }
            return;
        }// end function

        private function deployListCallback() : void
        {
            var _loc_5:Object = null;
            var _loc_1:* = _ctrl.deploy.deployList;
            var _loc_2:* = _loc_1[0].length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = {};
                _loc_5 = this.playerIcon(_loc_1[0][_loc_4]);
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            this._playerData = _loc_3;
            this._deployData = _loc_1[1];
            this._deFaultData = _loc_1[2];
            this._downTimer = _loc_1[3];
            this._firstAttack = _loc_1[4].firstAttack;
            this._deploy.downTimer = this._downTimer;
            this._deploy.getFirstAttack = this._firstAttack;
            if (this._showDeploy != this._deFaultData[0].name || this._openDeployLevel != this._deFaultData[0].level || this._isDefautDeploy)
            {
                if (!this._isDefautDeploy)
                {
                    this._deploy.playerData(this._playerData);
                    this._deploy.deployInfo(this._deFaultData);
                }
                this._deploy.openDeploy(this._deployData);
                this._showDeploy = this._deFaultData[0].name;
                this._openDeployLevel = this._deFaultData[0].level;
                this._isDefautDeploy = false;
            }
            return;
        }// end function

        private function upDeployCallback() : void
        {
            this.deploy_list(this._deployID);
            _view.guide.trackDeploy(3, this._deploy.content);
            if (_view.guide.isLastTrace(GuideType.Deploy) == false)
            {
                _view.guide.setCookie(GuideType.Deploy);
            }
            return;
        }// end function

        private function downDeployCallback() : void
        {
            this.deploy_list(this._deployID);
            return;
        }// end function

        private function allDownDeployCallback() : void
        {
            this.deploy_list(this._deployID);
            return;
        }// end function

        private function setDefautDeployCallback() : void
        {
            this.deploy_list(this._deployID);
            this._isDefautDeploy = true;
            return;
        }// end function

        private function upLevelResearchCallBack() : void
        {
            var _loc_1:* = _ctrl.research.ResearchUpgrade();
            if (_loc_1.result == Mod_Research_Base.SUCCEED)
            {
                this.deploy_list(this._deployID);
            }
            else
            {
                _view.showTip(DeployViewLang.UpLevelSuccess);
            }
            return;
        }// end function

        private function clearCdTimerCallBack() : void
        {
            var _loc_1:* = _ctrl.research.ClearCdTime();
            if (_loc_1.result == Mod_Research_Base.SUCCEED)
            {
                this._deploy.downTimer = 0;
            }
            else
            {
                _view.showTip(DeployViewLang.ClearCdFail);
            }
            return;
        }// end function

        private function playerIcon(param1:Object) : Object
        {
            var _loc_2:* = URI.getRoleIconUrl(param1.job);
            param1.url = _loc_2;
            return param1;
        }// end function

        private function render() : void
        {
            this._deploy = _view.getAssetsObject("Deploy", "Deploy") as IDeploy;
            _popup.addView(this, this._deploy.content);
            this._deploy.tip = _view.tip.iTip;
            this._deploy.drag = _view.drag.iDrag;
            var obj:* = _view.getCookie("isShowSequence");
            this._isShowSequence = _view.getCookie("isShowSequence");
            this._deploy.deforeShowSequence = this._isShowSequence;
            this._deploy.isOpenResearch = FunctionType.isOpened(FunctionType.Research);
            this._deploy.isShowSequence = FunctionType.isOpened(FunctionType.TravelEvent);
            this._deploy.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._deploy.onUpDeploy = function (param1:Object, param2:int, param3:int) : void
            {
                _deployID = param2;
                up_deploy(param1.id, param2, param3);
                loaderUpDeploy(param1.id, (param3 - 1));
                return;
            }// end function
            ;
            this._deploy.onDownDeploy = function (param1:int, param2:int) : void
            {
                loaderDownDeploy((param2 - 1));
                Helper.output(param1, param2);
                _deployID = param1;
                down_deploy(param1, param2);
                return;
            }// end function
            ;
            this._deploy.onDeploy = function (param1:int) : void
            {
                Helper.output(param1);
                _deployID = param1;
                deploy_list(param1);
                return;
            }// end function
            ;
            this._deploy.onShowSequence = function (param1:Boolean) : void
            {
                _view.setCookie("isShowSequence", param1);
                _isShowSequence = param1;
                return;
            }// end function
            ;
            this._deploy.onDefault = function (param1:int) : void
            {
                Helper.output(param1);
                _deployID = param1;
                set_defaut_deploy(param1);
                return;
            }// end function
            ;
            this._deploy.onClearCdTimer = function () : void
            {
                _view.research.clearCdTime(clearCdTimerCallBack);
                return;
            }// end function
            ;
            this._deploy.onUpLevelHandler = function (param1:Object) : void
            {
                _view.research.researchUpgrade(param1.researchId, upLevelResearchCallBack);
                return;
            }// end function
            ;
            this._deploy.downTimer = this._downTimer;
            this._deploy.playerData(this._playerData);
            this._deploy.deployInfo(this._deFaultData);
            this._deploy.openDeploy(this._deployData);
            this._deploy.getFirstAttack = this._firstAttack;
            _view.center(sign, this._deploy.content);
            _view.guide.trackDeploy(2, this._deploy.content);
            return;
        }// end function

        public function clearCdTimer() : void
        {
            if (inStage == false)
            {
                return;
            }
            this._deploy.downTimer = 0;
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            Helper.gc();
            _popup.closeView(this);
            this._view.guide.stopDeployGuides();
            return;
        }// end function

        public function clear() : void
        {
            this._deploy.clear();
            return;
        }// end function

        private function loaderDownDeploy(param1:int) : void
        {
            var _loc_2:* = this.changeOldDeployId(param1);
            this.changeUpDeploy(_loc_2, false);
            this._deploy.playerData(this._playerData);
            this._deploy.deployInfo(this._deFaultData);
            return;
        }// end function

        private function loaderUpDeploy(param1:int, param2:int) : void
        {
            var _loc_5:Object = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:Boolean = false;
            var _loc_3:* = this._deFaultData[0].player.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = this._deFaultData[0].player[_loc_4];
                _loc_6 = 0;
                _loc_7 = _ctrl.player.mainPlayerRoleId;
                if (_loc_5.place == param2)
                {
                    _loc_8 = this.isUpDeploy(param1);
                    if (_loc_5.id != 0)
                    {
                        if (_loc_8)
                        {
                            _loc_6 = this.changeOldDeploy(param1, _loc_5.place);
                            this.changeOldDeploy(_loc_5.id, _loc_6);
                        }
                        else
                        {
                            if (_loc_5.id == _loc_7)
                            {
                                _view.showTip(DeployViewLang.DownDeploy);
                                return;
                            }
                            this.changeUpDeploy(param1, true);
                            this.changeUpDeploy(_loc_5.id, false);
                            _loc_5.id = param1;
                        }
                    }
                    else
                    {
                        if (_loc_8)
                        {
                            _loc_6 = this.changeOldDeploy(param1, _loc_5.place, false);
                            this.changeOldDeployId(_loc_6);
                        }
                        else
                        {
                            this.changeUpDeploy(param1, true);
                        }
                        _loc_5.id = param1;
                    }
                }
                _loc_4++;
            }
            this._deploy.playerData(this._playerData);
            this._deploy.deployInfo(this._deFaultData);
            return;
        }// end function

        private function isUpDeploy(param1:int) : Boolean
        {
            var _loc_4:Object = null;
            var _loc_2:* = this._playerData.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._playerData[_loc_3];
                if (_loc_4.id == param1)
                {
                    return _loc_4.isDeploy == 1;
                }
                _loc_3++;
            }
            return false;
        }// end function

        private function changeUpDeploy(param1:int, param2:Boolean) : void
        {
            var _loc_5:Object = null;
            var _loc_3:* = this._playerData.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = this._playerData[_loc_4];
                if (_loc_5.id == param1)
                {
                    if (param2)
                    {
                        _loc_5.isDeploy = 1;
                    }
                    else
                    {
                        _loc_5.isDeploy = 0;
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private function changeOldDeploy(param1:int, param2:int, param3:Boolean = true) : int
        {
            var _loc_6:Object = null;
            var _loc_7:int = 0;
            var _loc_4:* = this._deFaultData[0].player.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = this._deFaultData[0].player[_loc_5];
                if (_loc_6.id == param1)
                {
                    _loc_7 = _loc_6.place;
                    if (param3)
                    {
                        _loc_6.place = param2;
                    }
                    return _loc_7;
                }
                _loc_5++;
            }
            return -1;
        }// end function

        private function changeOldDeployId(param1:int) : int
        {
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_2:* = this._deFaultData[0].player.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._deFaultData[0].player[_loc_3];
                if (_loc_4.place == param1)
                {
                    _loc_5 = _loc_4.id;
                    _loc_4.id = 0;
                    return _loc_5;
                }
                _loc_3++;
            }
            return 0;
        }// end function

    }
}
