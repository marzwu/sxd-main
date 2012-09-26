package com.datas
{
    import com.assist.server.*;
    import com.haloer.data.*;

    public class ResearchData extends Base
    {
        private var _aryResearchList:Array;
        private var _aryResearchUpgrade:Array;
        private var _aryClearCdTimeShow:Array;
        private var _aryClearCdTime:Array;
        private var _aryResearchAddList:Array;

        public function ResearchData()
        {
            this._aryResearchList = [];
            this._aryResearchUpgrade = [];
            this._aryClearCdTimeShow = [];
            this._aryClearCdTime = [];
            this._aryResearchAddList = [];
            return;
        }// end function

        public function get getResearchList() : Array
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            var _loc_1:Array = [];
            if (this._aryResearchList.length > 0)
            {
                for each (_loc_3 in this._aryResearchList[0])
                {
                    
                    _loc_2 = {};
                    oObject.list(_loc_3, _loc_2, ["order_key", "research_id", "level", "last_level", "player_level", "type", "skill", "cd_time"]);
                    _loc_2["name"] = ResearchType.getName(_loc_2["research_id"]);
                    _loc_2["content"] = ResearchType.getContent(_loc_2["research_id"]);
                    _loc_1.push(_loc_2);
                }
                _loc_1.sortOn(["type", "order_key"], Array.NUMERIC);
            }
            return _loc_1;
        }// end function

        public function get getCdTime() : int
        {
            var _loc_1:* = this._aryResearchList[3];
            return _loc_1;
        }// end function

        public function get getMySkill() : int
        {
            var _loc_1:* = this._aryResearchList[1];
            return _loc_1;
        }// end function

        public function get getResearchUpgrade() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._aryResearchUpgrade, _loc_1, ["result", "type_id", "research_id", "level", "last_level", "player_level", "cd_time", "skill", "myskill", "ingot", "curr_time"]);
            _loc_1["type"] = _loc_1["type_id"];
            _loc_1["name"] = ResearchType.getName(_loc_1["research_id"]);
            _loc_1["content"] = ResearchType.getContent(_loc_1["research_id"]);
            return _loc_1;
        }// end function

        public function get getClearCdTimeShow() : Object
        {
            var _loc_1:Object = {cd_time:this._aryClearCdTimeShow[0], ingot:this._aryClearCdTimeShow[1], myingot:this._aryClearCdTimeShow[2]};
            return _loc_1;
        }// end function

        public function get getClearCdTime() : Object
        {
            var _loc_1:Object = {result:this._aryClearCdTime[0], myingot:this._aryClearCdTime[1]};
            return _loc_1;
        }// end function

        public function get researchAddList() : Array
        {
            return this._aryResearchAddList;
        }// end function

        public function research_list(param1:Array) : void
        {
            this._aryResearchList = param1;
            return;
        }// end function

        public function research_upgrade(param1:Array) : void
        {
            this._aryResearchUpgrade = param1;
            return;
        }// end function

        public function clear_cd_time_show(param1:Array) : void
        {
            this._aryClearCdTimeShow = param1;
            return;
        }// end function

        public function clear_cd_time(param1:Array) : void
        {
            this._aryClearCdTime = param1;
            return;
        }// end function

        public function research_add_list(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this._aryResearchAddList = [];
            for each (_loc_3 in param1[0])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["research_id", "order_key", "addition_type", "add_value"]);
                _loc_2["name"] = ResearchType.getName(_loc_2["research_id"]);
                this._aryResearchAddList.push(_loc_2);
            }
            this._aryResearchAddList.sortOn("order_key", Array.NUMERIC);
            return;
        }// end function

    }
}
