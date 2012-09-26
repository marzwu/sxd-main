package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.haloer.data.*;
    import com.haloer.display.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;

    public class FarmData extends Base
    {
        private var _objHerbsColor:Object;
        private var _objImageUrl:Object;
        private var _aryGetFarmlandinfoList:Array;
        private var _intMaxFarmlandCount:int;
        private var _aryGetPlayerRoleInfoList:Array;
        private var _objGetSingleHerbsSeed:Object;
        private var _aryGetGroupHerbsSeed:Array;
        private var _objRefreshHerbsSeed:Object;
        private var _objGetTopHerbsSeed:Object;
        private var _objPlantHerbs:Object;
        private var _objHarvest:Object;
        private var _objReclamation:Object;
        private var _objCheckRoleState:Object;
        private var _objGetSimpleFarmlandinfo:Object;
        private var _objClearFarmlandCd:Object;
        private var _objBuyCoinTreeCountInfo:Object;
        private var _objBuyCoinTreeCount:Object;
        private var _objCoinTreeCountNotify:Object;
        private var _objIngotForFarmland:Object;
        private var _objUpFarmlandLevel:Object;
        private var _intLoadingImageCount:int;

        public function FarmData()
        {
            this._objHerbsColor = {1:HtmlText.White, 2:38979, 3:48127, 4:HtmlText.Purple, 5:HtmlText.Yellow};
            this._objImageUrl = {};
            this._aryGetFarmlandinfoList = [];
            this._aryGetPlayerRoleInfoList = [];
            this._objGetSingleHerbsSeed = {};
            this._aryGetGroupHerbsSeed = [];
            this._objRefreshHerbsSeed = {};
            this._objGetTopHerbsSeed = {};
            this._objPlantHerbs = {};
            this._objHarvest = {};
            this._objReclamation = {};
            this._objCheckRoleState = {};
            this._objGetSimpleFarmlandinfo = {};
            this._objClearFarmlandCd = {};
            this._objBuyCoinTreeCountInfo = {};
            this._objBuyCoinTreeCount = {};
            this._objCoinTreeCountNotify = {};
            this._objIngotForFarmland = {};
            this._objUpFarmlandLevel = {};
            return;
        }// end function

        public function get getFarmlandinfoList() : Array
        {
            return this._aryGetFarmlandinfoList;
        }// end function

        public function get maxFarmlandCount() : int
        {
            return this._intMaxFarmlandCount;
        }// end function

        public function get getPlayerRoleInfoList() : Array
        {
            return this._aryGetPlayerRoleInfoList;
        }// end function

        public function get getSingleHerbsSeed() : Object
        {
            return this._objGetSingleHerbsSeed;
        }// end function

        public function get getGroupHerbsSeed() : Array
        {
            return this._aryGetGroupHerbsSeed;
        }// end function

        public function get refreshHerbsSeed() : Object
        {
            return this._objRefreshHerbsSeed;
        }// end function

        public function get getTopHerbsSeed() : Object
        {
            return this._objGetTopHerbsSeed;
        }// end function

        public function get plantHerbs() : Object
        {
            return this._objPlantHerbs;
        }// end function

        public function get harvestHerbs() : Object
        {
            return this._objHarvest;
        }// end function

        public function get openFarmland() : Object
        {
            return this._objReclamation;
        }// end function

        public function get checkRoleState() : Object
        {
            return this._objCheckRoleState;
        }// end function

        public function get getSimpleFarmlandinfo() : Object
        {
            return this._objGetSimpleFarmlandinfo;
        }// end function

        public function get clearFarmlandCd() : Object
        {
            return this._objClearFarmlandCd;
        }// end function

        public function get buyCoinTreeCountInfo() : Object
        {
            return this._objBuyCoinTreeCountInfo;
        }// end function

        public function get buyCoinTreeCount() : Object
        {
            return this._objBuyCoinTreeCount;
        }// end function

        public function get coinTreeCountNotify() : Object
        {
            return this._objCoinTreeCountNotify;
        }// end function

        public function get ingotForFarmland() : Object
        {
            return this._objIngotForFarmland;
        }// end function

        public function get upFarmlandLevel() : Object
        {
            return this._objUpFarmlandLevel;
        }// end function

        public function get getIsImgComplete() : Boolean
        {
            return this._intLoadingImageCount == 0;
        }// end function

        private function getSimpleHerbeSign(param1:String) : String
        {
            var _loc_2:* = param1;
            _loc_2 = _loc_2.replace("PuTong", "");
            _loc_2 = _loc_2.replace("BaiNian", "");
            _loc_2 = _loc_2.replace("QianNian", "");
            _loc_2 = _loc_2.replace("WanNian", "");
            _loc_2 = _loc_2.replace("JiPin", "");
            return _loc_2;
        }// end function

        private function loadImageCache() : void
        {
            var strUrl:String;
            var img:Image;
            this._intLoadingImageCount = 0;
            var _loc_2:int = 0;
            var _loc_3:* = this._objImageUrl;
            while (_loc_3 in _loc_2)
            {
                
                strUrl = _loc_3[_loc_2];
                var _loc_4:String = this;
                var _loc_5:* = this._intLoadingImageCount + 1;
                _loc_4._intLoadingImageCount = _loc_5;
                if (!Image.isInCache(strUrl))
                {
                    img = new Image(strUrl);
                    img.onComplete = function () : void
            {
                var _loc_2:* = _intLoadingImageCount - 1;
                _intLoadingImageCount = _loc_2;
                return;
            }// end function
            ;
                    continue;
                }
                var _loc_4:String = this;
                var _loc_5:* = this._intLoadingImageCount - 1;
                _loc_4._intLoadingImageCount = _loc_5;
            }
            return;
        }// end function

        public function get_farmlandinfo_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            var _loc_7:Object = null;
            this._aryGetFarmlandinfoList = [];
            this._intMaxFarmlandCount = param1[1];
            for each (_loc_2 in param1[0])
            {
                
                _loc_6 = {};
                oObject.list(_loc_2, _loc_6, ["farmland_id", "player_role_id", "player_role_sign", "player_role_name", "player_role_level", "player_role_experience", "max_experience", "herbs_id", "farmland_time", "farmland_level", "is_plant", "herbs_type"]);
                _loc_6["herbs_sign"] = HerbsType.getSign(_loc_6["herbs_id"]);
                _loc_6["herbs_name"] = HerbsType.getName(_loc_6["herbs_id"]);
                _loc_6["herbs_star_level"] = HerbsType.getStarLevel(_loc_6["herbs_id"]);
                _loc_6["experience"] = Math.ceil(HerbsType.getExperience(_loc_6["herbs_id"]) * ((_loc_6["farmland_level"] - 1) * 0.2 + 1));
                _loc_6["coin"] = Math.ceil((HerbsType.getCoin(_loc_6["herbs_id"]) + _loc_6["player_role_level"] * 2000) * ((_loc_6["farmland_level"] - 1) * 0.2 + 1));
                _loc_6["color"] = this._objHerbsColor[_loc_6["herbs_star_level"]];
                _loc_6["is_can_open"] = 0;
                _loc_6["growing"] = 3;
                _loc_6["simple_herbs_sign"] = this.getSimpleHerbeSign(_loc_6["herbs_sign"]);
                if (_loc_6["herbs_id"] != 0)
                {
                    this._objImageUrl[_loc_6["simple_herbs_sign"] + "3"] = URI.farmIconUrl + _loc_6["simple_herbs_sign"] + "3.swf";
                }
                this._aryGetFarmlandinfoList.push(_loc_6);
            }
            this.loadImageCache();
            this._aryGetFarmlandinfoList.sortOn(["farmland_id"], Array.NUMERIC);
            _loc_3 = 0;
            _loc_4 = this._aryGetFarmlandinfoList.length;
            _loc_5 = this._aryGetFarmlandinfoList.length;
            while (_loc_5 < this._intMaxFarmlandCount)
            {
                
                _loc_7 = {};
                _loc_7["farmland_id"] = _loc_3 - 1;
                _loc_7["herbs_id"] = 0;
                _loc_7["farmland_level"] = 0;
                _loc_7["is_can_open"] = _loc_5 == _loc_4 ? (1) : (0);
                this._aryGetFarmlandinfoList.push(_loc_7);
                _loc_5++;
            }
            return;
        }// end function

        public function get_player_roleinfo_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            var _loc_4:Number = NaN;
            var _loc_5:int = 0;
            this._aryGetPlayerRoleInfoList = [];
            for each (_loc_2 in param1[0])
            {
                
                _loc_3 = {};
                oObject.list(_loc_2, _loc_3, ["player_role_id", "player_role_sign", "player_role_name", "player_role_level", "player_role_experience", "max_experience", "strength", "agile", "intellect", "player_role_state"]);
                _loc_3["role_experience"] = _loc_3["player_role_experience"] + "/" + _loc_3["max_experience"];
                _loc_3["url"] = URI.iconsUrl + _loc_3["player_role_sign"] + ".png";
                _loc_3["role_job_id"] = RoleType.getJobIdByRoleSign(_loc_3["player_role_sign"]);
                if (_loc_3["player_role_state"] == Mod_Farm_Base.WAR)
                {
                    _loc_3["text"] = HtmlText.format(_loc_3["player_role_name"] + " Lv." + _loc_3["player_role_level"] + FarmDataLang.Fight, 15425792);
                }
                else if (_loc_3["player_role_state"] == Mod_Farm_Base.INVITE)
                {
                    _loc_3["text"] = HtmlText.white(_loc_3["player_role_name"] + " Lv." + _loc_3["player_role_level"]);
                }
                else if (_loc_3["player_role_state"] == Mod_Farm_Base.NOINVITE)
                {
                    _loc_3["text"] = HtmlText.white(_loc_3["player_role_name"] + " Lv." + _loc_3["player_role_level"] + FarmDataLang.Inn);
                }
                else
                {
                    _loc_3["text"] = "";
                }
                _loc_4 = -_loc_3["player_role_experience"];
                _loc_5 = _loc_3["player_role_level"] + 1;
                while (_loc_5 <= this._data.player.level)
                {
                    
                    _loc_4 = _loc_4 + RoleType.getJobExp(_loc_3["role_job_id"], _loc_5);
                    _loc_5++;
                }
                _loc_3["top_level_need_exp"] = _loc_4;
                this._aryGetPlayerRoleInfoList.push(_loc_3);
            }
            return;
        }// end function

        public function get_herbs_seed(param1:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            this._objGetSingleHerbsSeed = {};
            oObject.list(param1, this._objGetSingleHerbsSeed, ["herbs_id", "refresh_ingot", "herbs_type"]);
            this._objGetSingleHerbsSeed["herbs_sign"] = HerbsType.getSign(this._objGetSingleHerbsSeed["herbs_id"]);
            this._objGetSingleHerbsSeed["herbs_name"] = HerbsType.getName(this._objGetSingleHerbsSeed["herbs_id"]);
            this._objGetSingleHerbsSeed["herbs_star_level"] = HerbsType.getStarLevel(this._objGetSingleHerbsSeed["herbs_id"]);
            this._objGetSingleHerbsSeed["experience"] = HerbsType.getExperience(this._objGetSingleHerbsSeed["herbs_id"]);
            this._objGetSingleHerbsSeed["coin"] = HerbsType.getCoin(this._objGetSingleHerbsSeed["herbs_id"]);
            this._objGetSingleHerbsSeed["ripe_time"] = HerbsType.getRipeTime(this._objGetSingleHerbsSeed["herbs_id"]);
            this._objGetSingleHerbsSeed["color"] = this._objHerbsColor[this._objGetSingleHerbsSeed["herbs_star_level"]];
            this._aryGetGroupHerbsSeed = [];
            var _loc_2:* = HerbsType.getIdsByLock(HerbsType.getLock(this._objGetSingleHerbsSeed["herbs_id"]));
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = {};
                _loc_4["herbs_id"] = _loc_3;
                _loc_4["herbs_sign"] = HerbsType.getSign(_loc_4["herbs_id"]);
                _loc_4["herbs_name"] = HerbsType.getName(_loc_4["herbs_id"]);
                _loc_4["herbs_star_level"] = HerbsType.getStarLevel(_loc_4["herbs_id"]);
                _loc_4["experience"] = HerbsType.getExperience(_loc_4["herbs_id"]);
                _loc_4["coin"] = HerbsType.getCoin(_loc_4["herbs_id"]);
                _loc_4["ripe_time"] = HerbsType.getRipeTime(_loc_4["herbs_id"]);
                _loc_4["herbs_type"] = HerbsType.getType(_loc_4["herbs_id"]);
                _loc_4["current"] = this._objGetSingleHerbsSeed["herbs_id"] == _loc_3;
                _loc_4["color"] = this._objHerbsColor[_loc_4["herbs_star_level"]];
                _loc_4["simple_herbs_sign"] = this.getSimpleHerbeSign(_loc_4["herbs_sign"]);
                _loc_4["url"] = URI.farmIconUrl + _loc_4["herbs_type"] + _loc_4["herbs_star_level"] + ".swf";
                this._objImageUrl[_loc_4["simple_herbs_sign"] + "3"] = URI.farmIconUrl + _loc_4["simple_herbs_sign"] + "3.swf";
                this._objImageUrl[_loc_4["simple_herbs_sign"] + "2"] = URI.farmIconUrl + _loc_4["simple_herbs_sign"] + "2.swf";
                this._objImageUrl[_loc_4["simple_herbs_sign"] + "1"] = URI.farmIconUrl + _loc_4["simple_herbs_sign"] + "1.swf";
                this._aryGetGroupHerbsSeed.push(_loc_4);
            }
            this.loadImageCache();
            this._aryGetGroupHerbsSeed.sortOn(["herbs_id"], Array.NUMERIC);
            return;
        }// end function

        public function refresh_herbs_seed(param1:Array) : void
        {
            this._objRefreshHerbsSeed = {};
            oObject.list(param1, this._objRefreshHerbsSeed, ["result", "herbs_id", "refresh_ingot", "herbs_type"]);
            this._objRefreshHerbsSeed["herbs_sign"] = HerbsType.getSign(this._objRefreshHerbsSeed["herbs_id"]);
            this._objRefreshHerbsSeed["herbs_name"] = HerbsType.getName(this._objRefreshHerbsSeed["herbs_id"]);
            this._objRefreshHerbsSeed["herbs_star_level"] = HerbsType.getStarLevel(this._objRefreshHerbsSeed["herbs_id"]);
            this._objRefreshHerbsSeed["experience"] = HerbsType.getExperience(this._objRefreshHerbsSeed["herbs_id"]);
            this._objRefreshHerbsSeed["coin"] = HerbsType.getCoin(this._objRefreshHerbsSeed["herbs_id"]);
            this._objRefreshHerbsSeed["ripe_time"] = HerbsType.getRipeTime(this._objRefreshHerbsSeed["herbs_id"]);
            this._objRefreshHerbsSeed["simple_herbs_sign"] = this.getSimpleHerbeSign(this._objRefreshHerbsSeed["herbs_sign"]);
            this._objRefreshHerbsSeed["color"] = this._objHerbsColor[this._objRefreshHerbsSeed["herbs_star_level"]];
            this._objRefreshHerbsSeed["current"] = true;
            return;
        }// end function

        public function get_top_herbs_seed(param1:Array) : void
        {
            this._objGetTopHerbsSeed = {};
            oObject.list(param1, this._objGetTopHerbsSeed, ["result", "herbs_id", "herbs_type"]);
            this._objGetTopHerbsSeed["herbs_sign"] = HerbsType.getSign(this._objGetTopHerbsSeed["herbs_id"]);
            this._objGetTopHerbsSeed["herbs_name"] = HerbsType.getName(this._objGetTopHerbsSeed["herbs_id"]);
            this._objGetTopHerbsSeed["herbs_star_level"] = HerbsType.getStarLevel(this._objGetTopHerbsSeed["herbs_id"]);
            this._objGetTopHerbsSeed["experience"] = HerbsType.getExperience(this._objGetTopHerbsSeed["herbs_id"]);
            this._objGetTopHerbsSeed["coin"] = HerbsType.getCoin(this._objGetTopHerbsSeed["herbs_id"]);
            this._objGetTopHerbsSeed["ripe_time"] = HerbsType.getRipeTime(this._objGetTopHerbsSeed["herbs_id"]);
            this._objGetTopHerbsSeed["color"] = this._objHerbsColor[this._objGetTopHerbsSeed["herbs_star_level"]];
            this._objGetTopHerbsSeed["simple_herbs_sign"] = this.getSimpleHerbeSign(this._objGetTopHerbsSeed["herbs_sign"]);
            this._objGetTopHerbsSeed["current"] = true;
            return;
        }// end function

        public function plant_herbs(param1:Array) : void
        {
            this._objPlantHerbs = {};
            oObject.list(param1, this._objPlantHerbs, ["result", "farmland_id", "player_role_id", "player_role_sign", "player_role_name", "player_role_level", "player_role_experience", "max_experience", "herbs_id", "farmland_level", "coin_tree_count", "is_plant", "herbs_type"]);
            this._objPlantHerbs["herbs_sign"] = HerbsType.getSign(this._objPlantHerbs["herbs_id"]);
            this._objPlantHerbs["herbs_name"] = HerbsType.getName(this._objPlantHerbs["herbs_id"]);
            this._objPlantHerbs["herbs_star_level"] = HerbsType.getStarLevel(this._objPlantHerbs["herbs_id"]);
            this._objPlantHerbs["experience"] = Math.ceil(HerbsType.getExperience(this._objPlantHerbs["herbs_id"]) * ((this._objPlantHerbs["farmland_level"] - 1) * 0.2 + 1));
            this._objPlantHerbs["coin"] = Math.ceil((HerbsType.getCoin(this._objPlantHerbs["herbs_id"]) + this._objPlantHerbs["player_role_level"] * 2000) * ((this._objPlantHerbs["farmland_level"] - 1) * 0.2 + 1));
            this._objPlantHerbs["color"] = this._objHerbsColor[this._objPlantHerbs["herbs_star_level"]];
            this._objPlantHerbs["is_can_open"] = 0;
            this._objPlantHerbs["growing"] = 1;
            this._objPlantHerbs["role_experience"] = this._objPlantHerbs["player_role_experience"] + "/" + this._objPlantHerbs["max_experience"];
            this._objPlantHerbs["simple_herbs_sign"] = this.getSimpleHerbeSign(this._objPlantHerbs["herbs_sign"]);
            return;
        }// end function

        public function harvest(param1:Array) : void
        {
            this._objHarvest = {};
            oObject.list(param1, this._objHarvest, ["result", "role_name", "herbs_name", "experience", "level", "coin", "farmland_time", "herbs_type"]);
            return;
        }// end function

        public function reclamation(param1:Array) : void
        {
            this._objReclamation = {};
            oObject.list(param1, this._objReclamation, ["result", "farmland_id"]);
            return;
        }// end function

        public function check_role_state(param1:Array) : void
        {
            this._objCheckRoleState = {};
            oObject.list(param1, this._objCheckRoleState, ["result"]);
            return;
        }// end function

        public function get_simple_farmlandinfo(param1:Array) : void
        {
            this._objGetSimpleFarmlandinfo = {};
            oObject.list(param1, this._objGetSimpleFarmlandinfo, ["farmland_count", "plant_count"]);
            return;
        }// end function

        public function clear_farmland_cd(param1:Array) : void
        {
            this._objClearFarmlandCd = {};
            oObject.list(param1, this._objClearFarmlandCd, ["result"]);
            return;
        }// end function

        public function buy_coin_tree_count_info(param1:Array) : void
        {
            this._objBuyCoinTreeCountInfo = {};
            oObject.list(param1, this._objBuyCoinTreeCountInfo, ["coin_tree_count", "remain_buy_times", "ingot", "recorve_cd"]);
            return;
        }// end function

        public function buy_coin_tree_count(param1:Array) : void
        {
            this._objBuyCoinTreeCount = {};
            oObject.list(param1, this._objBuyCoinTreeCount, ["result", "coin_tree_counts"]);
            return;
        }// end function

        public function coin_tree_count_notify(param1:Array) : void
        {
            this._objCoinTreeCountNotify = {};
            oObject.list(param1, this._objCoinTreeCountNotify, ["coin_tree_counts"]);
            return;
        }// end function

        public function ingot_for_farmland(param1:Array) : void
        {
            this._objIngotForFarmland = {};
            oObject.list(param1, this._objIngotForFarmland, ["ingot"]);
            return;
        }// end function

        public function up_farmland_level(param1:Array) : void
        {
            this._objUpFarmlandLevel = {};
            oObject.list(param1, this._objUpFarmlandLevel, ["result"]);
            return;
        }// end function

    }
}
