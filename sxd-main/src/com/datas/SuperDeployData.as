package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.haloer.data.*;

    public class SuperDeployData extends Base
    {
        private var _objDeployResearch:Object;
        private var _aryRoleList:Array;
        private var _aryDeployGrid:Array;
        private var _objUpDeploy:Object;
        private var _objDownDeploy:Object;
        private var _objNewDeployGridOpenNotify:Object;

        public function SuperDeployData()
        {
            this._objDeployResearch = {};
            this._aryRoleList = [];
            this._aryDeployGrid = [];
            this._objUpDeploy = {};
            this._objDownDeploy = {};
            this._objNewDeployGridOpenNotify = {};
            return;
        }// end function

        public function get deployResearch() : Object
        {
            return this._objDeployResearch;
        }// end function

        public function get roleList() : Array
        {
            return this._aryRoleList;
        }// end function

        public function get deployGrid() : Array
        {
            return this._aryDeployGrid;
        }// end function

        public function get upDeploy() : Object
        {
            return this._objUpDeploy;
        }// end function

        public function get downDeploy() : Object
        {
            return this._objDownDeploy;
        }// end function

        public function get newDeployGridOpenNotify() : Object
        {
            return this._objNewDeployGridOpenNotify;
        }// end function

        public function super_deploy_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            this._aryRoleList = [];
            for each (_loc_2 in param1[param1.length - 2])
            {
                
                _loc_4 = {};
                oObject.list(_loc_2, _loc_4, ["player_role_id", "is_main_role", "health", "max_health", "role_sign", "role_name", "role_level", "role_job_name", "role_stunt", "strength", "agile", "intellect", "is_deploy"]);
                _loc_4["role_id"] = RoleType.getRoleId(_loc_4["role_sign"]);
                _loc_4["role_color"] = RoleType.getRoleColorById(_loc_4["role_id"]);
                _loc_4["is_special_partner"] = RoleType.checkSuperRole(_loc_4["role_id"]);
                if (_loc_4["is_main_role"] == 1)
                {
                    _loc_4["role_name"] = this._data.player.nickname;
                }
                _loc_4["url"] = URI.iconsUrl + _loc_4["role_sign"] + ".png";
                this._aryRoleList.push(_loc_4);
            }
            this._aryDeployGrid = [];
            for each (_loc_3 in param1[(param1.length - 1)])
            {
                
                _loc_5 = {};
                oObject.list(_loc_3, _loc_5, ["grid_type_id", "player_role_id"]);
                for each (_loc_6 in this._aryRoleList)
                {
                    
                    if (_loc_5["player_role_id"] != _loc_6["player_role_id"])
                    {
                        continue;
                    }
                    _loc_5["role_name"] = _loc_6["role_name"];
                    _loc_5["url"] = _loc_6["url"];
                    _loc_5["is_main_role"] = _loc_6["is_main_role"];
                    _loc_5["role_color"] = _loc_6["role_color"];
                    _loc_5["is_special_partner"] = _loc_6["is_special_partner"];
                }
                this._aryDeployGrid.push(_loc_5);
            }
            return;
        }// end function

        public function up_deploy(param1:Array) : void
        {
            this._objUpDeploy = {};
            oObject.list(param1, this._objUpDeploy, ["result"]);
            return;
        }// end function

        public function down_deploy(param1:Array) : void
        {
            this._objDownDeploy = {};
            oObject.list(param1, this._objDownDeploy, ["result"]);
            return;
        }// end function

        public function deploy_research_and_first_attack(param1:Array) : void
        {
            this._objDeployResearch = {};
            oObject.list(param1, this._objDeployResearch, ["research_id", "research_name", "research_level", "skill", "player_level", "first_attack"]);
            this._objDeployResearch["content"] = ResearchType.getContent(this._objDeployResearch["research_id"]);
            return;
        }// end function

        public function new_deploy_grid_open_notify(param1:Array) : void
        {
            this._objNewDeployGridOpenNotify = {};
            oObject.list(param1, this._objNewDeployGridOpenNotify, ["id"]);
            return;
        }// end function

    }
}
