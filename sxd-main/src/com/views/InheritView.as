package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class InheritView extends Base implements IView
    {
        private var _inherit:IInherit;
        private var _dialog:IAlert = null;
        private var _objInheritAttrib:Object = null;
        private var _aryInheritDrug:Array;
        private var _objBeInheritAttrib:Object = null;
        private var _aryAfterInheritDrug:Array;
        private var _intRoleType:int;
        private var _intRoleTypeInherit:int = 0;
        private var _intRoleTypeBeInherit:int = 1;
        private var _objInheritInfo:Object = null;
        private var _objBeInheritInfo:Object = null;
        private var _aryBeInheritRoleList:Array;
        private var _immInfo:ImmortalityInfo;
        public var playerRoleId:int;

        public function InheritView()
        {
            this._aryInheritDrug = [];
            this._aryAfterInheritDrug = [];
            this._aryBeInheritRoleList = [];
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
            this._objInheritAttrib = null;
            this._objBeInheritAttrib = null;
            this._objInheritInfo = null;
            this._objBeInheritInfo = null;
            this._aryAfterInheritDrug = [];
            this._aryInheritDrug = [];
            this._aryBeInheritRoleList = [];
            if (this._view.immortalityMsg.inStage)
            {
                this._view.immortalityMsg.close();
            }
            this._inherit.clear();
            Helper.gc();
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._inherit.content);
            _view.center(sign, this._inherit.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._inherit == null)
            {
                this._inherit = _view.getAssetsObject("Inherit", "Inherit") as IInherit;
            }
            this.init();
            this.roleListCallBack();
            this._intRoleType = this._intRoleTypeInherit;
            this.role_list(this._intRoleType);
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._dialog = _view.alert.iAlert;
            this._inherit.tip = this._view.tip.iTip;
            this._inherit.drag = this._view.drag.iDrag;
            this._inherit.onClose = this.close;
            this._inherit.onDrugInherit = this.showInheritDrug;
            this._inherit.onDrugBeInherit = this.shwoAfterInheritDrug;
            this._inherit.onInherit = this.roleInherit;
            this._inherit.onRoleInheritChoose = this.role_attribute;
            this._inherit.onRoleBeInheritChoose = this.role_attribute;
            this._inherit.onIngotLevelCheck = this.ingotLevelCheck;
            this._inherit.onShwoDialog = this.showDialog;
            this._inherit.init(this.playerRoleId);
            return;
        }// end function

        private function showInheritDrug(param1:String, param2:int) : void
        {
            if (this._aryInheritDrug.length == 0)
            {
                return;
            }
            this._immInfo = new ImmortalityInfo();
            this._immInfo.listWuli = this._aryInheritDrug[ItemType.WuLiDan];
            this._immInfo.listJueJi = this._aryInheritDrug[ItemType.JueJiDan];
            this._immInfo.listFaShu = this._aryInheritDrug[ItemType.FaShuDan];
            this._immInfo.roleLv = param2;
            this._immInfo.roleName = param1;
            _view.immortalityMsg.showSee(this._immInfo);
            return;
        }// end function

        private function shwoAfterInheritDrug(param1:String, param2:int, param3:int) : void
        {
            if (this._aryAfterInheritDrug.length == 0)
            {
                return;
            }
            this._immInfo = new ImmortalityInfo();
            var _loc_4:* = this._aryAfterInheritDrug[param3] as Object;
            var _loc_5:* = (this._aryAfterInheritDrug[param3] as Object)["after_inherit_drug_info"];
            this._immInfo.listWuli = _loc_5[ItemType.WuLiDan];
            this._immInfo.listJueJi = _loc_5[ItemType.JueJiDan];
            this._immInfo.listFaShu = _loc_5[ItemType.FaShuDan];
            this._immInfo.roleLv = param2;
            this._immInfo.roleName = param1;
            _view.immortalityMsg.showSee(this._immInfo);
            return;
        }// end function

        private function roleInherit(param1:int) : void
        {
            var intIngot:int;
            var intCoin:int;
            var intSkill:int;
            var callBack:Function;
            var strTemp:String;
            var strMessage:String;
            var intType:* = param1;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    inherit(intType);
                }
                return;
            }// end function
            ;
            if (this._objInheritInfo == null || this._objBeInheritInfo == null)
            {
                _view.showTip(InheritViewLang.NoChoose);
                return;
            }
            var ary:* = this._ctrl.inherit.attributeAfterInherit;
            if (intType == 0)
            {
                intSkill = (ary[0] as Object)["skill"];
                intCoin = (ary[0] as Object)["coin"];
            }
            else if (intType == 1)
            {
                intIngot = (ary[1] as Object)["ingot"];
            }
            else
            {
                intIngot = (ary[2] as Object)["ingot"];
            }
            if (intCoin == 0 && intSkill == 0 && intIngot == 0 && this.compareStateInvalid(intType))
            {
                _view.showTip(InheritViewLang.NoEffect);
                return;
            }
            if (intCoin > 0 || intSkill > 0 || intIngot > 0)
            {
                strTemp;
                if (intIngot > 0)
                {
                    strTemp = strTemp + (HtmlText.yellow(intIngot.toString()) + InheritViewLang.Ingot);
                }
                if (intCoin > 0)
                {
                    strTemp = strTemp + (HtmlText.yellow(intCoin.toString()) + InheritViewLang.Coin);
                }
                if (intSkill > 0)
                {
                    strTemp = strTemp + (HtmlText.yellow(intSkill.toString()) + InheritViewLang.Skill);
                }
                strMessage = Lang.sprintf(InheritViewLang.IsStartInherit, strTemp);
                this._dialog.yesLabel = InheritViewLang.DialogYes;
                this._dialog.noLabel = InheritViewLang.DialogNo;
                this._dialog.show(strMessage, AlertButtonType.Yes | AlertButtonType.No, callBack);
            }
            else
            {
                return;
            }
            return;
        }// end function

        private function compareStateInvalid(param1:int) : Boolean
        {
            var _loc_2:Boolean = false;
            var _loc_3:* = this._ctrl.inherit.attributeAfterInherit[param1] as Object;
            if (this._objBeInheritAttrib["state_id"] > _loc_3["state_id"])
            {
                _loc_2 = true;
            }
            else if (this._objBeInheritAttrib["state_id"] == _loc_3["state_id"])
            {
                if (this._objBeInheritAttrib["state_level"] >= _loc_3["state_level"])
                {
                    _loc_2 = true;
                }
            }
            return _loc_2;
        }// end function

        private function showDialog(param1:String) : void
        {
            var callBack:Function;
            var strMessage:* = param1;
            callBack = function (param1:uint) : void
            {
                close();
                return;
            }// end function
            ;
            this._view.activities.showWinEffect();
            this._dialog.yesLabel = InheritViewLang.DialogYes;
            this._dialog.show(InheritViewLang.InheritSuccess, AlertButtonType.Yes, callBack);
            return;
        }// end function

        private function ingotLevelCheck(param1:int) : void
        {
            if (this._objBeInheritInfo == null)
            {
                return;
            }
            this.updateAfterInheritDrugMsg(this._objBeInheritInfo["roleName"], this._objBeInheritInfo["level"], param1);
            return;
        }// end function

        private function updateAfterInheritDrugMsg(param1:String, param2:int, param3:int) : void
        {
            if (_view.immortalityMsg.inStage && _view.immortalityMsg.roleName == param1)
            {
                this.shwoAfterInheritDrug(param1, param2, param3);
            }
            return;
        }// end function

        private function updateInheritDrugMsg(param1:String, param2:int) : void
        {
            if (_view.immortalityMsg.inStage && _view.immortalityMsg.roleName == param1)
            {
                this.showInheritDrug(param1, param2);
            }
            return;
        }// end function

        private function loadData() : void
        {
            this._intRoleType = this._intRoleTypeBeInherit;
            _data.call(Mod_Inherit_Base.role_list, this.loadDataCallBack, [this._intRoleType]);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("Inherit", this.render, InheritViewLang.LoadInfo);
            return;
        }// end function

        private function role_list(param1:int) : void
        {
            _data.call(Mod_Inherit_Base.role_list, this.roleListCallBack, [param1]);
            return;
        }// end function

        private function roleListCallBack() : void
        {
            var _loc_1:* = this._ctrl.inherit.roleList;
            if (this._intRoleType == this._intRoleTypeInherit)
            {
                this._inherit.renderRoleInheritList(_loc_1);
            }
            else
            {
                this._aryBeInheritRoleList = _loc_1;
            }
            return;
        }// end function

        private function role_attribute(param1:Object, param2:int, param3:int) : void
        {
            var callBack:Function;
            var ary:Array;
            var i:int;
            var objRole:Object;
            var obj:* = param1;
            var intRoleType:* = param2;
            var intInheritType:* = param3;
            callBack = function () : void
            {
                roleAttributeCallBack(intInheritType);
                return;
            }// end function
            ;
            this._intRoleType = intRoleType;
            if (this._intRoleType == this._intRoleTypeInherit)
            {
                this._objInheritInfo = obj;
                this._objBeInheritInfo = null;
                this._objBeInheritAttrib = null;
                this._aryAfterInheritDrug = [];
                ary = this._aryBeInheritRoleList.slice();
                i = (ary.length - 1);
                while (i >= 0)
                {
                    
                    objRole = ary[i];
                    if (objRole["player_role_id"] == this._objInheritInfo["roleId"])
                    {
                        ary.splice(i, 1);
                    }
                    i = (i - 1);
                }
                this._inherit.renderRoleBeInheritList(ary);
            }
            else
            {
                this._objBeInheritInfo = obj;
            }
            _data.call(Mod_Inherit_Base.role_attribute, callBack, [obj["roleId"]]);
            return;
        }// end function

        private function roleAttributeCallBack(param1:int) : void
        {
            if (this._intRoleType == this._intRoleTypeInherit)
            {
                this.get_player_role_elixir_record(param1);
            }
            else
            {
                this.attribute_after_inherit(param1);
            }
            return;
        }// end function

        private function get_player_role_elixir_record(param1:int) : void
        {
            var callBack:Function;
            var intInheritType:* = param1;
            callBack = function () : void
            {
                getPlayerRoleElixirRecordCallBack(intInheritType);
                return;
            }// end function
            ;
            _data.call(Mod_Item_Base.get_player_role_elixir_record, callBack, [this._objInheritInfo["roleId"]]);
            return;
        }// end function

        private function getPlayerRoleElixirRecordCallBack(param1:int) : void
        {
            this.attribute_after_inherit(param1);
            return;
        }// end function

        private function attribute_after_inherit(param1:int) : void
        {
            var intInheritType:* = param1;
            if (this._objBeInheritInfo == null)
            {
                this._objInheritAttrib = this._ctrl.inherit.roleAttribute;
                this._aryInheritDrug = this._ctrl.item.danyaoList;
                if (this._intRoleType == this._intRoleTypeInherit)
                {
                    this.updateInheritDrugMsg(this._objInheritInfo["roleName"], this._objInheritInfo["level"]);
                }
                else
                {
                    this.updateAfterInheritDrugMsg(this._objBeInheritInfo["roleName"], this._objBeInheritInfo["level"], intInheritType);
                }
                this._inherit.renderRoleCompare(this._objInheritAttrib, this._objBeInheritAttrib, this._ctrl.inherit.attributeAfterInherit);
            }
            else
            {
                var callBack:* = function () : void
            {
                attributeAfterInheritCallBack(intInheritType);
                return;
            }// end function
            ;
                _data.call(Mod_Inherit_Base.attribute_after_inherit, callBack, [this._objInheritInfo["roleId"], this._objBeInheritInfo["roleId"]]);
            }
            return;
        }// end function

        private function attributeAfterInheritCallBack(param1:int) : void
        {
            if (this._intRoleType == this._intRoleTypeInherit)
            {
                this._aryInheritDrug = this._ctrl.item.danyaoList;
                this._objInheritAttrib = this._ctrl.inherit.roleAttribute;
                this.updateInheritDrugMsg(this._objInheritInfo["roleName"], this._objInheritInfo["level"]);
            }
            else
            {
                this._aryAfterInheritDrug = this._ctrl.inherit.attributeAfterInherit;
                this._objBeInheritAttrib = this._ctrl.inherit.roleAttribute;
                this.updateAfterInheritDrugMsg(this._objBeInheritInfo["roleName"], this._objBeInheritInfo["level"], param1);
            }
            this._inherit.renderRoleCompare(this._objInheritAttrib, this._objBeInheritAttrib, this._ctrl.inherit.attributeAfterInherit);
            return;
        }// end function

        private function inherit(param1:int) : void
        {
            _data.call(Mod_Inherit_Base.inherit, this.inheritCallBack, [this._objInheritInfo["roleId"], this._objBeInheritInfo["roleId"], param1]);
            return;
        }// end function

        private function inheritCallBack() : void
        {
            var _loc_1:* = this._ctrl.inherit.inherit;
            if (_loc_1["result"] == Mod_Inherit_Base.SUCCESS)
            {
                this._inherit.renderInheritSuccess();
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Inherit_Base.SUCCESS:
                {
                    _loc_2 = InheritViewLang.Success;
                    break;
                }
                case Mod_Inherit_Base.NO_COIN:
                {
                    _loc_2 = InheritViewLang.NoCoin;
                    break;
                }
                case Mod_Inherit_Base.NO_SKILL:
                {
                    _loc_2 = InheritViewLang.NoSkill;
                    break;
                }
                case Mod_Inherit_Base.NO_INGOT:
                {
                    _loc_2 = InheritViewLang.NoIngot;
                    break;
                }
                case Mod_Inherit_Base.CAN_NOT_INHERIT:
                {
                    _loc_2 = InheritViewLang.CanNotInherit;
                    break;
                }
                default:
                {
                    _loc_2 = InheritViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
