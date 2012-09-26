package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class PlayerCompareView extends Base implements IView
    {
        public var myPlayerId:int;
        public var myName:String;
        public var anotherPlayerId:int;
        public var anotherName:String;
        private var _playerCompare:IPlayerCompare;
        private var _aryMyResearch:Array;
        private var _aryAnotherResearch:Array;

        public function PlayerCompareView()
        {
            this._aryMyResearch = [];
            this._aryAnotherResearch = [];
            return;
        }// end function

        public function show() : void
        {
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
            this._playerCompare.clear();
            Helper.gc();
            return;
        }// end function

        public function updateSkill() : void
        {
            return;
        }// end function

        private function loadData() : void
        {
            this.research_add_list(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("PlayerCompare", this.render, PlayerCompareViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._playerCompare.content);
            _view.center(sign, this._playerCompare.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._playerCompare == null)
            {
                this._playerCompare = _view.getAssetsObject("PlayerCompare", "PlayerCompare") as IPlayerCompare;
            }
            this.init();
            this.get_simple_role_list();
            this._playerCompare.renderResearchCompare(this._aryMyResearch, this._aryAnotherResearch);
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._playerCompare.tip = this._view.tip.iTip;
            this._playerCompare.drag = this._view.drag.iDrag;
            this._playerCompare.onClose = this.close;
            this._playerCompare.onResearchCompare = this.researchAddList;
            this._playerCompare.onFirstAttackCompare = this.get_default_deploy_first_attack;
            this._playerCompare.onAttribCompare = this.get_role_war_attribute;
            this._playerCompare.onFateCompare = this.get_role_fate_list;
            this._playerCompare.onPetCompare = this.pet_animal_info;
            this._playerCompare.init(this.myName, this.anotherName);
            return;
        }// end function

        private function copyObject(param1:Object) : Object
        {
            var _loc_3:String = null;
            var _loc_2:Object = {};
            for (_loc_3 in param1)
            {
                
                _loc_2[_loc_3] = param1[_loc_3];
            }
            return _loc_2;
        }// end function

        private function getPetObject(param1:PetLongInfo) : Object
        {
            var _loc_2:Object = {};
            if (param1.lv > 0)
            {
                _loc_2["name"] = param1.mouseTip.replace("<b>", "").replace("</b>", "");
            }
            else
            {
                _loc_2["name"] = PlayerCompareViewLang.Nothing;
            }
            _loc_2["attack_add"] = PetType.getAttack(param1.lv, param1.star);
            _loc_2["defense_add"] = PetType.getDefense(param1.lv, param1.star);
            _loc_2["health_add"] = PetType.getLife(param1.lv, param1.star);
            _loc_2["critical"] = PetType.getCritical(param1.lv);
            _loc_2["kill"] = PetType.getKill(param1.lv);
            _loc_2["block"] = PetType.getBlock(param1.lv);
            _loc_2["break_block"] = PetType.getBreakBlock(param1.lv);
            _loc_2["dodge"] = PetType.getDodge(param1.lv);
            _loc_2["hit"] = PetType.getHit(param1.lv);
            _loc_2["break_critical"] = PetType.getBreakCritical(param1.lv);
            _loc_2["stunt_attack"] = PetType.getStuntAttack(param1.lv);
            return _loc_2;
        }// end function

        private function researchAddList() : void
        {
            var callBack:Function;
            callBack = function () : void
            {
                _playerCompare.renderResearchCompare(_aryMyResearch, _aryAnotherResearch);
                return;
            }// end function
            ;
            this.research_add_list(callBack);
            return;
        }// end function

        private function setSmallFate(param1:Array) : void
        {
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            var _loc_5:Object = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:Object = null;
            var _loc_9:int = 0;
            var _loc_2:* = param1.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = param1[_loc_2] as Object;
                if (_loc_3["fateId"] == 0)
                {
                }
                else
                {
                    _loc_3["attribName"] = WarAttributeType.getName(FateType.getWarAttributeType(_loc_3["fateId"]));
                    if (_loc_3["needActived"] == 1)
                    {
                        _loc_4 = FateType.getActivedList(_loc_3["fateId"]) as Array;
                        _loc_5 = _loc_3["activedFate"] as Object;
                        _loc_6 = 0;
                        while (_loc_6 < _loc_4.length)
                        {
                            
                            _loc_7 = _loc_4[_loc_6];
                            _loc_8 = {};
                            _loc_8["fateId"] = _loc_3["fateId"] * 1000 + _loc_7;
                            _loc_8["fateLevel"] = _loc_3["fateLevel"];
                            _loc_8["color"] = _loc_3["color"];
                            _loc_8["fateName"] = _loc_3["fateName"];
                            _loc_8["info"] = FateType.getFateDescription(_loc_7);
                            _loc_8["needActived"] = 0;
                            _loc_8["attribName"] = WarAttributeType.getName(FateType.getWarAttributeType(_loc_7));
                            _loc_8["quality"] = _loc_3["quality"];
                            if (_loc_5.hasOwnProperty(_loc_7.toString()))
                            {
                                _loc_8["isActived"] = true;
                                if (_loc_6 == 0)
                                {
                                    _loc_9 = FateType.getFateAddonValue(_loc_3["fateId"], _loc_8["fateLevel"]);
                                }
                                else
                                {
                                    _loc_9 = FateType.getFateAddonValue2(_loc_3["fateId"], _loc_8["fateLevel"]);
                                }
                                _loc_8["addValue"] = _loc_9;
                                if (FateType.isWarAttribute(_loc_7))
                                {
                                    _loc_8["addValue"] = _loc_8["addValue"] * 10;
                                }
                            }
                            else
                            {
                                _loc_8["isActived"] = false;
                                _loc_8["addValue"] = PlayerCompareViewLang.NoActivated;
                            }
                            param1.push(_loc_8);
                            _loc_6++;
                        }
                    }
                    else
                    {
                        _loc_3["isActived"] = _loc_3["attribName"] != "";
                    }
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        private function get_default_deploy_first_attack() : void
        {
            var objMy:Object;
            var objAnother:Object;
            var fun1:Function;
            var fun2:Function;
            fun1 = function () : void
            {
                objMy = copyObject(_ctrl.rolemsg.getDefaultDeployFirstAttack);
                _data.call(Mod_Role_Base.get_default_deploy_first_attack, fun2, [anotherPlayerId]);
                return;
            }// end function
            ;
            fun2 = function () : void
            {
                objAnother = copyObject(_ctrl.rolemsg.getDefaultDeployFirstAttack);
                _playerCompare.renderFirstAttack(objMy, objAnother);
                return;
            }// end function
            ;
            this._data.call(Mod_Role_Base.get_default_deploy_first_attack, fun1, [this.myPlayerId]);
            objMy;
            objAnother;
            return;
        }// end function

        private function research_add_list(param1:Function) : void
        {
            var fun1:Function;
            var fun2:Function;
            var callBack:* = param1;
            fun1 = function () : void
            {
                _aryMyResearch = _ctrl.research.researchAddList().slice();
                _data.call(Mod_Research_Base.research_add_list, fun2, [anotherPlayerId]);
                return;
            }// end function
            ;
            fun2 = function () : void
            {
                _aryAnotherResearch = _ctrl.research.researchAddList().slice();
                callBack();
                return;
            }// end function
            ;
            this._data.call(Mod_Research_Base.research_add_list, fun1, [this.myPlayerId]);
            return;
        }// end function

        private function get_role_war_attribute(param1:int, param2:int) : void
        {
            var objMy:Object;
            var objAnother:Object;
            var fun1:Function;
            var fun2:Function;
            var intMyRoleId:* = param1;
            var intAnotherRoleId:* = param2;
            fun1 = function () : void
            {
                objMy = copyObject(_ctrl.rolemsg.roleWarAttributeData);
                _data.call(Mod_Role_Base.get_role_war_attribute, fun2, [intAnotherRoleId]);
                return;
            }// end function
            ;
            fun2 = function () : void
            {
                objAnother = copyObject(_ctrl.rolemsg.roleWarAttributeData);
                _playerCompare.renderAttrib(objMy, objAnother);
                return;
            }// end function
            ;
            _data.call(Mod_Role_Base.get_role_war_attribute, fun1, [intMyRoleId]);
            objMy;
            objAnother;
            return;
        }// end function

        private function get_role_fate_list(param1:int, param2:int) : void
        {
            var objMy:Object;
            var objAnother:Object;
            var fun1:Function;
            var fun2:Function;
            var intMyRoleId:* = param1;
            var intAnotherRoleId:* = param2;
            fun1 = function () : void
            {
                objMy = copyObject(_ctrl.fate.roleFateData);
                setSmallFate(objMy["fateList"] as Array);
                _data.call(Mod_Fate_Base.get_role_fate_list, fun2, [intAnotherRoleId]);
                return;
            }// end function
            ;
            fun2 = function () : void
            {
                objAnother = copyObject(_ctrl.fate.roleFateData);
                setSmallFate(objAnother["fateList"] as Array);
                _playerCompare.renderFate(objMy, objAnother);
                return;
            }// end function
            ;
            _data.call(Mod_Fate_Base.get_role_fate_list, fun1, [intMyRoleId]);
            objMy;
            objAnother;
            return;
        }// end function

        private function get_simple_role_list() : void
        {
            var aryMyRole:Array;
            var aryAnotherRole:Array;
            var fun1:Function;
            var fun2:Function;
            fun1 = function () : void
            {
                var _loc_2:Object = null;
                aryMyRole = _ctrl.upgrade.getSimpleRoleList().slice();
                var _loc_1:* = aryMyRole.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_2 = aryMyRole[_loc_1] as Object;
                    if (_loc_2["is_deploy"] == Mod_Role_Base.NODEPLOY)
                    {
                        aryMyRole.splice(_loc_1, 1);
                    }
                    _loc_1 = _loc_1 - 1;
                }
                _data.call(Mod_Role_Base.get_simple_role_list, fun2, [anotherPlayerId]);
                return;
            }// end function
            ;
            fun2 = function () : void
            {
                var _loc_2:Object = null;
                aryAnotherRole = _ctrl.upgrade.getSimpleRoleList().slice();
                var _loc_1:* = aryAnotherRole.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_2 = aryAnotherRole[_loc_1] as Object;
                    if (_loc_2["roleId"] <= 6)
                    {
                        _loc_2["old_name"] = anotherName;
                    }
                    if (_loc_2["is_deploy"] == Mod_Role_Base.NODEPLOY)
                    {
                        aryAnotherRole.splice(_loc_1, 1);
                    }
                    aryAnotherRole.sortOn("roleId", Array.NUMERIC);
                    _loc_1 = _loc_1 - 1;
                }
                _playerCompare.renderRoleList(aryMyRole, aryAnotherRole);
                return;
            }// end function
            ;
            _data.call(Mod_Role_Base.get_simple_role_list, fun1, [this.myPlayerId]);
            aryMyRole;
            aryAnotherRole;
            return;
        }// end function

        private function pet_animal_info() : void
        {
            var objMy:Object;
            var objAnother:Object;
            var fun1:Function;
            var fun2:Function;
            fun1 = function () : void
            {
                objMy = getPetObject(_ctrl.pet.info);
                _data.call(Mod_PetAnimal_Base.pet_animal_info, fun2, [anotherPlayerId]);
                return;
            }// end function
            ;
            fun2 = function () : void
            {
                objAnother = getPetObject(_ctrl.pet.info);
                _playerCompare.renderPet(objMy, objAnother);
                return;
            }// end function
            ;
            this._data.call(Mod_PetAnimal_Base.pet_animal_info, fun1, [this.myPlayerId]);
            objMy;
            objAnother;
            return;
        }// end function

    }
}
