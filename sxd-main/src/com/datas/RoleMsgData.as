package com.datas
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.haloer.data.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;

    public class RoleMsgData extends Base
    {
        public var roleList:Array;
        public var otherRoleList:Array;
        public var coin:int = 0;
        public var radio:int = 0;
        public var trainingBase:Array;
        public var trainingOld:Array;
        public var trainingNew:Array;
        public var nearResult:int;
        public var roleIdList:Array;
        public var simpleRoleList:Array;
        public var flowersTips:String = "";
        public var roleWarAttributeData:Object;
        public var defaultDeployFirstAttackData:Object;
        public var ExpChange:int = 0;

        public function RoleMsgData()
        {
            this.roleList = [];
            this.otherRoleList = [];
            this.trainingBase = [];
            this.trainingOld = [];
            this.trainingNew = [];
            this.roleIdList = [];
            this.simpleRoleList = [];
            this.roleWarAttributeData = {};
            this.defaultDeployFirstAttackData = {};
            return;
        }// end function

        public function get_role_list(param1:Array) : void
        {
            var _loc_6:RoleInfo = null;
            var _loc_7:Array = null;
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["main_player_role_id", "eqId", "player_id", "sport_ranking", "listener_count", "flower_count", "fame", "faction_name", "max_player_id", "max_nickname", "max_flower_count", "fame_level", "player_pet_animal_lv", "player_pet_animal_stage", "role_list"]);
            var _loc_3:* = RoleMsgDataLang.PlayerRole;
            if (_loc_2.faction_name != "" && _loc_2.sport_ranking > 0)
            {
                _loc_3 = "[" + _loc_2.faction_name + "]" + RoleMsgDataLang.ArenaIdx + _loc_2.sport_ranking;
            }
            else if (_loc_2.faction_name != "")
            {
                _loc_3 = "[" + _loc_2.faction_name + "]";
            }
            else if (_loc_2.sport_ranking > 0)
            {
                _loc_3 = "[" + RoleMsgDataLang.ArenaIdx + _loc_2.sport_ranking + "]";
            }
            this.flowersTips = "";
            if (_loc_2.max_flower_count != 0)
            {
                this.flowersTips = HtmlText.format(_loc_2.max_nickname, 16631433) + " " + HtmlText.format(_loc_2.max_flower_count + RoleMsgDataLang.Flower);
                this.flowersTips = "<b>" + RoleMsgDataLang.Send + "\n" + this.flowersTips + "</b>";
            }
            var _loc_4:* = _loc_2.player_id != _data.player.playerId;
            var _loc_5:Array = [];
            for each (_loc_7 in _loc_2.role_list)
            {
                
                var _loc_10:* = new RoleInfo();
                _loc_6 = new RoleInfo();
                _loc_5.push(_loc_10);
                oObject.list(_loc_7, _loc_6, ["name", "roleId", "playerRoleId", "exp", "expMax", "lv", "jobId", "pZhiYe", "pZhanFa", "pZhanFaMsg", "pShengMing", "pShengMing", "pWuLi", "pJueJi", "pFaShu", "pWuXing", "fatePower", "isdeploy", "toTrans", "beTrans"]);
                _loc_6.ismain = _loc_6.playerRoleId == _loc_2.main_player_role_id;
                _loc_6.isfight = _loc_6.isdeploy == Mod_Role_Base.DEPLOY && _loc_4 == false;
                _loc_6.fame = _loc_2.fame;
                _loc_6.fameLv = _loc_2.fame_level;
                _loc_6.flowers = _loc_2.flower_count;
                _loc_6.tingzhong = _loc_2.listener_count;
                _loc_6.headUrl = URI.iconsUrl + RoleType.getRoleSign(_loc_6.roleId) + ".png";
                _loc_6.sign = RoleType.getRoleSign(_loc_6.roleId) + (_loc_6.ismain ? (ItemType.getItemSuffix(_loc_2.eqId)) : (""));
                _loc_6.name = _data.player.removeNickNameSuffix(_loc_6.name);
                _loc_6.showDanYao = _data.player.townKey >= TownType.getLock(TownType.getId(TownType.JingCheng));
                _loc_6.showTraining = FunctionType.isOpened(FunctionType.Training);
                _loc_6.showFollow = _loc_6.ismain == false && _data.player.vipLevel >= 3;
                _loc_6.showFlower = _loc_6.ismain == true && FunctionType.isOpened(FunctionType.SendFlower);
                _loc_6.showTFFame = _loc_6.ismain == true && _loc_6.fame > 0;
                _loc_6.showChuanCheng = _loc_6.ismain == false && FunctionType.isOpened(FunctionType.Inherit);
                _loc_6.showSeeInfo = FunctionType.isOpened(FunctionType.WarAttribute);
                _loc_6.showYaoQing = _loc_6.showDanYao && _loc_6.ismain;
                if (_loc_6.expMax == -1)
                {
                    _loc_6.expMax = 100;
                    _loc_6.exp = 100;
                }
                if (_loc_6.ismain)
                {
                    _loc_3 = _loc_6.name + _loc_3;
                    _loc_6.petLv = _loc_2.player_pet_animal_lv;
                    _loc_6.petStar = _loc_2.player_pet_animal_stage;
                }
                if (_loc_6.toTrans != "")
                {
                    _loc_6.toTrans = Lang.sprintf(RoleMsgDataLang.ToTrans, _loc_6.toTrans);
                }
                if (_loc_6.beTrans != "")
                {
                    _loc_6.beTrans = Lang.sprintf(RoleMsgDataLang.BeTrans, _loc_6.beTrans);
                }
                if (_loc_6.toTrans == "" && _loc_6.beTrans == "")
                {
                    _loc_6.canTrans = RoleMsgDataLang.CanTrans;
                }
            }
            _loc_5.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
            for each (_loc_6 in _loc_5)
            {
                
                _loc_6.roleTopMsg = _loc_3;
            }
            if (_loc_4 == false)
            {
                this.roleList = _loc_5;
            }
            else
            {
                this.otherRoleList = _loc_5;
            }
            return;
        }// end function

        public function get_role_list_simpe(param1:Array) : void
        {
            var _loc_2:RoleInfo = null;
            for each (_loc_2 in this.roleList)
            {
                
                if (_loc_2.playerRoleId == param1[1])
                {
                    _loc_2.exp = param1[2];
                    _loc_2.expMax = param1[3];
                    _loc_2.pShengMing = param1[4];
                    _loc_2.pWuLi = param1[6];
                    _loc_2.pJueJi = param1[7];
                    _loc_2.pFaShu = param1[8];
                    if (_loc_2.expMax == -1)
                    {
                        _loc_2.expMax = 100;
                        _loc_2.exp = 100;
                    }
                    break;
                }
            }
            return;
        }// end function

        public function set_follow_role(param1:Array) : void
        {
            return;
        }// end function

        public function get_role_id_list(param1:Array) : void
        {
            this.roleIdList = [];
            param1 = param1[0];
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.roleIdList.push(param1[_loc_3][0]);
                _loc_3++;
            }
            return;
        }// end function

        public function exp_change_notify(param1:Array) : void
        {
            this.ExpChange = param1[1];
            return;
        }// end function

        public function get_simple_role_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            this.simpleRoleList = [];
            var _loc_2:Object = {};
            for each (_loc_3 in param1[0])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["id", "roleId", "level", "is_deploy"]);
                this.simpleRoleList.push(_loc_2);
            }
            return;
        }// end function

        public function panel_show(param1:Array) : void
        {
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["id", "lv", "coin", "role_name", "strength", "agile", "intellect", "tranining_button"]);
            this.coin = _loc_2.coin;
            this.radio = [Mod_Training_Base.GENERAL, Mod_Training_Base.STRENGTHEN, Mod_Training_Base.PLATINUM, Mod_Training_Base.DIAMOND, Mod_Training_Base.EXTREME].indexOf(_loc_2.tranining_button);
            this.trainingBase = [_loc_2.strength, _loc_2.agile, _loc_2.intellect];
            this.trainingOld = param1[8][0];
            this.trainingNew = [];
            return;
        }// end function

        public function training(param1:Array) : void
        {
            this.nearResult = param1[0];
            if (this.nearResult == Mod_Training_Base.SUCCEED)
            {
                this.trainingNew = [param1[1], param1[2], param1[3]];
            }
            else
            {
                this.trainingNew = [];
            }
            return;
        }// end function

        public function modify_role_data(param1:Array) : void
        {
            this.nearResult = param1[0];
            if (this.nearResult == Mod_Training_Base.SUCCEED)
            {
                this.trainingOld = this.trainingNew.concat();
            }
            this.trainingNew = [];
            return;
        }// end function

        public function down_partners(param1:Array) : void
        {
            this.nearResult = param1[0];
            return;
        }// end function

        public function get_role_war_attribute(param1:Array) : void
        {
            this.roleWarAttributeData = {};
            oObject.list(param1, this.roleWarAttributeData, ["role_id", "role_job_id", "role_level", "health", "attack", "defense", "hit", "dodge", "critical", "block", "break_critical", "break_block", "stunt_attack", "stunt_defense", "magic_attack", "magic_defense", "stunt_id", "kill", "first_attack"]);
            this.roleWarAttributeData["url"] = URI.iconsUrl + RoleType.getRoleSign(this.roleWarAttributeData["role_id"]) + ".png";
            this.roleWarAttributeData["role_name"] = RoleType.getRoleName(this.roleWarAttributeData["role_id"]);
            this.roleWarAttributeData["role_job_name"] = RoleType.getJobName(this.roleWarAttributeData["role_job_id"]);
            this.roleWarAttributeData["hit"] = this.roleWarAttributeData["hit"] / 10;
            this.roleWarAttributeData["dodge"] = this.roleWarAttributeData["dodge"] / 10;
            this.roleWarAttributeData["critical"] = this.roleWarAttributeData["critical"] / 10;
            this.roleWarAttributeData["block"] = this.roleWarAttributeData["block"] / 10;
            this.roleWarAttributeData["break_critical"] = this.roleWarAttributeData["break_critical"] / 10;
            this.roleWarAttributeData["break_block"] = this.roleWarAttributeData["break_block"] / 10;
            this.roleWarAttributeData["kill"] = this.roleWarAttributeData["kill"] / 10;
            var _loc_2:* = RoleStunt.getStuntName(RoleStunt.getStuntSign(this.roleWarAttributeData["stunt_id"]));
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                if (_loc_2.charCodeAt(_loc_4) > 127)
                {
                    _loc_3 = _loc_3 + 2;
                }
                else
                {
                    _loc_3 = _loc_3 + 1;
                }
                if (_loc_3 > 16)
                {
                    if (_loc_2.charCodeAt((_loc_4 - 1)) > 127)
                    {
                        _loc_2 = _loc_2.substr(0, (_loc_4 - 1)) + "...";
                    }
                    else
                    {
                        _loc_2 = _loc_2.substr(0, _loc_4 - 2) + "...";
                    }
                }
                _loc_4++;
            }
            this.roleWarAttributeData["stunt_name"] = _loc_2;
            this.roleWarAttributeData["stunt_description"] = RoleStunt.getStuntDescription(this.roleWarAttributeData["stunt_id"]);
            return;
        }// end function

        public function get_default_deploy_first_attack(param1:Array) : void
        {
            var _loc_3:String = null;
            this.defaultDeployFirstAttackData = {};
            oObject.list(param1, this.defaultDeployFirstAttackData, ["deploy_name", "research_add", "item_add", "itemstrength_add", "fate_add", "level_add", "train_add"]);
            var _loc_2:int = 0;
            for (_loc_3 in this.defaultDeployFirstAttackData)
            {
                
                if (this.defaultDeployFirstAttackData[_loc_3] is int)
                {
                    _loc_2 = _loc_2 + this.defaultDeployFirstAttackData[_loc_3];
                }
            }
            this.defaultDeployFirstAttackData["total"] = _loc_2;
            return;
        }// end function

        private function getRoleInfoAtId(param1:int, param2:Array) : RoleInfo
        {
            var _loc_3:RoleInfo = null;
            for each (_loc_3 in param2)
            {
                
                if (_loc_3.playerRoleId == param1)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

    }
}
