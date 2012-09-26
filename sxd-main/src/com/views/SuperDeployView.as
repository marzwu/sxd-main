package com.views
{
    import com.assist.view.guide.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class SuperDeployView extends Base implements IView
    {
        private var _superDeploy:ISuperDeploy;
        private var _blnInResearchUpgrade:Boolean = false;

        public function SuperDeployView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._superDeploy.clear();
            this._view.guide.stopDeployGuides();
            return;
        }// end function

        private function loadData() : void
        {
            this.super_deploy_list(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("SuperDeploy", this.render, SuperDeployViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._superDeploy.content);
            _view.center(sign, this._superDeploy.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._superDeploy == null)
            {
                this._superDeploy = _view.getAssetsObject("SuperDeploy", "SuperDeploy") as ISuperDeploy;
            }
            this.init();
            this.deploy_research_and_first_attack();
            this.superDeployCallBack();
            this.showUI();
            _view.guide.trackDeploy(2, this._superDeploy.content);
            return;
        }// end function

        private function init() : void
        {
            this._blnInResearchUpgrade = false;
            this._superDeploy.tip = this._view.tip.iTip;
            this._superDeploy.drag = this._view.drag.iDrag;
            this._superDeploy.onClose = this.close;
            this._superDeploy.onUpDeploy = this.up_deploy;
            this._superDeploy.onDownDeploy = this.down_deploy;
            this._superDeploy.onLevelUp = this.research_upgrade;
            this._superDeploy.onSaveShowOrder = this.saveShowOrder;
            this._superDeploy.playerLevel = this._ctrl.player.level;
            this._superDeploy.playerSkill = this._ctrl.player.skill;
            this._superDeploy.init();
            return;
        }// end function

        private function saveShowOrder(param1:Boolean) : void
        {
            _view.setCookie("SuperDeployShowOrder", param1);
            return;
        }// end function

        private function checkUpDeploy(param1:int, param2:int) : Boolean
        {
            var _loc_8:int = 0;
            var _loc_3:* = this._ctrl.superDeploy.roleList;
            var _loc_4:* = this._ctrl.superDeploy.deployGrid;
            var _loc_5:Object = {};
            var _loc_6:Object = {};
            var _loc_7:Object = {};
            for each (_loc_5 in _loc_3)
            {
                
                if (_loc_5["player_role_id"] == param1)
                {
                    if (_loc_5["is_deploy"] == 0)
                    {
                        for each (_loc_6 in _loc_4)
                        {
                            
                            if (_loc_6["grid_type_id"] == param2 && _loc_6["is_main_role"] == 1)
                            {
                                _view.showTip(SuperDeployViewLang.CanNotDownMainRole);
                                this._superDeploy.renderDeploy(_loc_3, _loc_4, _view.getCookie("SuperDeployShowOrder"));
                                return false;
                            }
                        }
                    }
                }
            }
            if (this.getRoleObject(param1, _loc_3)["is_deploy"] == 0)
            {
                _loc_8 = _loc_4.length >= 5 ? (5) : (_loc_4.length);
                for each (_loc_6 in _loc_4)
                {
                    
                    if (_loc_6["grid_type_id"] == param2 && _loc_6["player_role_id"] == 0)
                    {
                        for each (_loc_7 in _loc_4)
                        {
                            
                            if (_loc_7["player_role_id"] != 0)
                            {
                                _loc_8 = _loc_8 - 1;
                            }
                            if (_loc_8 <= 0)
                            {
                                _view.showTip(SuperDeployViewLang.FullDeploy);
                                this._superDeploy.renderDeploy(_loc_3, _loc_4, _view.getCookie("SuperDeployShowOrder"));
                                return false;
                            }
                        }
                    }
                }
            }
            return true;
        }// end function

        private function checkDownDeploy(param1:int) : Boolean
        {
            var _loc_2:* = this._ctrl.superDeploy.roleList;
            var _loc_3:* = this._ctrl.superDeploy.deployGrid;
            var _loc_4:Object = {};
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4["grid_type_id"] == param1 && _loc_4["is_main_role"] == 1)
                {
                    _view.showTip(SuperDeployViewLang.CanNotDownMainRole);
                    this._superDeploy.renderDeploy(_loc_2, _loc_3, _view.getCookie("SuperDeployShowOrder"));
                    return false;
                }
            }
            return true;
        }// end function

        private function beforeUpDeployServerToRenderSuccess(param1:int, param2:int) : void
        {
            this._superDeploy.clearDeployGrid();
            this._superDeploy.clearRoleIcon();
            var _loc_3:* = this._ctrl.superDeploy.roleList;
            var _loc_4:* = this._ctrl.superDeploy.deployGrid;
            var _loc_5:Object = {};
            var _loc_6:Object = {};
            var _loc_7:* = this.getRoleObject(param1, _loc_3);
            this.getRoleObject(param1, _loc_3)["is_deploy"] = 1;
            var _loc_8:* = _loc_7["role_name"];
            var _loc_9:* = _loc_7["url"];
            var _loc_10:* = _loc_7["is_main_role"];
            param1 = _loc_7["player_role_id"];
            var _loc_11:* = _loc_7["role_color"];
            var _loc_12:* = _loc_7["is_special_partner"];
            var _loc_13:Object = null;
            for each (_loc_5 in _loc_4)
            {
                
                if (_loc_5["grid_type_id"] == param2 && _loc_5["player_role_id"] != 0)
                {
                    _loc_13 = this.getRoleObject(_loc_5["player_role_id"], _loc_3);
                    _loc_13["is_deploy"] = 0;
                    for each (_loc_6 in _loc_4)
                    {
                        
                        if (_loc_6["player_role_id"] == _loc_7["player_role_id"])
                        {
                            _loc_6["role_name"] = _loc_13["role_name"];
                            _loc_6["url"] = _loc_13["url"];
                            _loc_6["is_main_role"] = _loc_13["is_main_role"];
                            _loc_6["player_role_id"] = _loc_13["player_role_id"];
                            _loc_6["role_color"] = _loc_13["role_color"];
                            _loc_13["is_deploy"] = 1;
                            break;
                        }
                    }
                    _loc_5["role_name"] = _loc_8;
                    _loc_5["url"] = _loc_9;
                    _loc_5["is_main_role"] = _loc_10;
                    _loc_5["player_role_id"] = param1;
                    _loc_5["role_color"] = _loc_11;
                    _loc_5["is_special_partner"] = _loc_12;
                    break;
                }
            }
            if (_loc_13 == null)
            {
                for each (_loc_6 in _loc_4)
                {
                    
                    if (_loc_6["player_role_id"] == _loc_7["player_role_id"])
                    {
                        _loc_6["role_name"] = "";
                        _loc_6["url"] = "";
                        _loc_6["is_main_role"] = 0;
                        _loc_6["player_role_id"] = 0;
                        _loc_6["role_color"] = 16777215;
                        break;
                    }
                }
                for each (_loc_5 in _loc_4)
                {
                    
                    if (_loc_5["grid_type_id"] == param2)
                    {
                        _loc_5["role_name"] = _loc_8;
                        _loc_5["url"] = _loc_9;
                        _loc_5["is_main_role"] = _loc_10;
                        _loc_5["player_role_id"] = param1;
                        _loc_5["role_color"] = _loc_11;
                        _loc_5["is_special_partner"] = _loc_12;
                        break;
                    }
                }
            }
            this._superDeploy.renderDeploy(_loc_3, _loc_4, _view.getCookie("SuperDeployShowOrder"));
            return;
        }// end function

        private function beforeDownDeployServerToRenderSuccess(param1:int) : void
        {
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            this._superDeploy.clearDeployGrid();
            this._superDeploy.clearRoleIcon();
            var _loc_2:* = this._ctrl.superDeploy.roleList;
            var _loc_3:* = this._ctrl.superDeploy.deployGrid;
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4["grid_type_id"] == param1)
                {
                    _loc_5 = this.getRoleObject(_loc_4["player_role_id"], _loc_2);
                    _loc_5["is_deploy"] = 0;
                    _loc_4["role_name"] = "";
                    _loc_4["url"] = "";
                    _loc_4["is_main_role"] = 0;
                    _loc_4["player_role_id"] = 0;
                    _loc_4["role_color"] = 16777215;
                    break;
                }
            }
            this._superDeploy.renderDeploy(_loc_2, _loc_3, _view.getCookie("SuperDeployShowOrder"));
            return;
        }// end function

        private function getRoleObject(param1:int, param2:Array) : Object
        {
            var _loc_3:Object = null;
            for each (_loc_3 in param2)
            {
                
                if (_loc_3["player_role_id"] == param1)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        private function sendDeployRoleIdToFurnace(param1:Array) : void
        {
            var _loc_3:Object = null;
            if (!this._view.furnaceMap.inStage)
            {
                return;
            }
            var _loc_2:Array = [];
            for each (_loc_3 in param1)
            {
                
                if (_loc_3["is_main_role"] == 1)
                {
                    continue;
                }
                if (_loc_3["is_deploy"] != 1)
                {
                    continue;
                }
                _loc_2.push(_loc_3["role_id"]);
            }
            this._view.furnaceMap.curDeployRoleList = _loc_2;
            return;
        }// end function

        private function super_deploy_list(param1:Function) : void
        {
            _data.call(Mod_SuperDeploy_Base.super_deploy_list, param1, []);
            return;
        }// end function

        private function superDeployCallBack() : void
        {
            var _loc_1:* = this._ctrl.superDeploy.roleList;
            var _loc_2:* = this._ctrl.superDeploy.deployGrid;
            this._superDeploy.renderDeploy(_loc_1, _loc_2, _view.getCookie("SuperDeployShowOrder"));
            this.sendDeployRoleIdToFurnace(_loc_1);
            this._view.toolbar.deployBack(this._ctrl.superDeploy.roleList);
            return;
        }// end function

        private function up_deploy(param1:int, param2:int) : void
        {
            if (!this.checkUpDeploy(param1, param2))
            {
                return;
            }
            this.beforeUpDeployServerToRenderSuccess(param1, param2);
            _data.call(Mod_SuperDeploy_Base.up_deploy, this.upDeployCallBack, [param1, param2]);
            _view.guide.trackDeploy(3, this._superDeploy.content);
            if (_view.guide.isLastTrace(GuideType.Deploy) == false)
            {
                _view.guide.setCookie(GuideType.Deploy);
            }
            return;
        }// end function

        private function upDeployCallBack() : void
        {
            var _loc_1:* = this._ctrl.superDeploy.upDeploy;
            if (_loc_1["result"] != Mod_SuperDeploy_Base.SUCCEED)
            {
                _view.showTip(this.superDeployMessage(_loc_1["result"]));
            }
            this.super_deploy_list(this.superDeployCallBack);
            this.deploy_research_and_first_attack();
            return;
        }// end function

        private function down_deploy(param1:int) : void
        {
            if (!this.checkDownDeploy(param1))
            {
                return;
            }
            this.beforeDownDeployServerToRenderSuccess(param1);
            _data.call(Mod_SuperDeploy_Base.down_deploy, this.downDeployCallBack, [param1]);
            return;
        }// end function

        private function downDeployCallBack() : void
        {
            var _loc_1:* = this._ctrl.superDeploy.downDeploy;
            if (_loc_1["result"] != Mod_SuperDeploy_Base.SUCCEED)
            {
                _view.showTip(this.superDeployMessage(_loc_1["result"]));
            }
            this.super_deploy_list(this.superDeployCallBack);
            this.deploy_research_and_first_attack();
            return;
        }// end function

        private function research_upgrade(param1:int) : void
        {
            if (this._blnInResearchUpgrade)
            {
                return;
            }
            this._blnInResearchUpgrade = true;
            this._data.call(Mod_Research_Base.research_upgrade, this.researchUpgradeCallBack, [param1]);
            return;
        }// end function

        private function researchUpgradeCallBack() : void
        {
            var _loc_1:* = this._ctrl.research.ResearchUpgrade();
            if (_loc_1["result"] == Mod_Research_Base.SUCCEED)
            {
                this._superDeploy.isPlayLevelUpCartoon = true;
                this.deploy_research_and_first_attack();
            }
            else
            {
                _view.showTip(this.researchMessage(_loc_1["result"]));
                this._blnInResearchUpgrade = false;
            }
            return;
        }// end function

        private function deploy_research_and_first_attack() : void
        {
            _data.call(Mod_SuperDeploy_Base.deploy_research_and_first_attack, this.deployResearchAndFirstAttack, []);
            return;
        }// end function

        private function deployResearchAndFirstAttack() : void
        {
            var _loc_1:* = this._ctrl.superDeploy.deployResearch;
            this._superDeploy.playerSkill = this._ctrl.player.skill;
            this._superDeploy.renderDeployResearch(_loc_1);
            this._blnInResearchUpgrade = false;
            return;
        }// end function

        private function superDeployMessage(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_SuperDeploy_Base.SUCCEED:
                {
                    _loc_2 = SuperDeployViewLang.Succeed;
                    break;
                }
                case Mod_SuperDeploy_Base.CAN_NOT_DOWN_MAIN_ROLE:
                {
                    _loc_2 = SuperDeployViewLang.CanNotDownMainRole;
                    break;
                }
                case Mod_SuperDeploy_Base.NOT_MY_ROLE:
                {
                    _loc_2 = SuperDeployViewLang.NotMyRole;
                    break;
                }
                case Mod_SuperDeploy_Base.LEAVE_TEAM:
                {
                    _loc_2 = SuperDeployViewLang.LeaveTeam;
                    break;
                }
                case Mod_SuperDeploy_Base.NOT_ENOUGTH_LEVEL:
                {
                    _loc_2 = SuperDeployViewLang.NotEnougthLevel;
                    break;
                }
                case Mod_SuperDeploy_Base.FULL_DEPLOY:
                {
                    _loc_2 = SuperDeployViewLang.FullDeploy;
                    break;
                }
                default:
                {
                    _loc_2 = SuperDeployViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function researchMessage(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Research_Base.SUCCEED:
                {
                    _loc_2 = ResearchViewLang.Succeed;
                    break;
                }
                case Mod_Research_Base.FAILED:
                {
                    _loc_2 = ResearchViewLang.Failed;
                    break;
                }
                case Mod_Research_Base.FULL:
                {
                    _loc_2 = ResearchViewLang.Full;
                    break;
                }
                case Mod_Research_Base.CDTIME:
                {
                    _loc_2 = ResearchViewLang.CdTime2;
                    break;
                }
                case Mod_Research_Base.NOENOUGHSKILL:
                {
                    _loc_2 = ResearchViewLang.NoEnoughSkill;
                    break;
                }
                case Mod_Research_Base.LIMITLEVELSTRUCT:
                {
                    _loc_2 = ResearchViewLang.LimitLevelStruct;
                    break;
                }
                case Mod_Research_Base.NOENOUGHLEVEL:
                {
                    _loc_2 = ResearchViewLang.NoEnoughLevel;
                    break;
                }
                case Mod_Research_Base.NOENOUGHINGOT:
                {
                    _loc_2 = ResearchViewLang.NoEnoughIngot;
                    break;
                }
                default:
                {
                    _loc_2 = ResearchViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
