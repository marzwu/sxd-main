package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.haloer.data.*;
    import com.haloer.display.*;
    import com.lang.client.com.datas.*;
    import flash.utils.*;

    public class StudyStuntData extends Base
    {
        private var _aryStuntPointInfo:Array;
        private var _aryStuntInfo:Array;
        private var _objPlayerInfo:Object;
        private var _objPlayerStudyStunt:Object;
        private var _mainRoleStuntIds:Array;
        private var _objPlayerCanStudyStunt:Object;
        private var _objLoadImage:Object;
        private var _intLoadTotal:int = 0;
        private var _intLoadComplete:int = 0;

        public function StudyStuntData()
        {
            this._aryStuntPointInfo = [];
            this._aryStuntInfo = [];
            this._objPlayerInfo = {};
            this._objPlayerStudyStunt = {};
            this._objPlayerCanStudyStunt = {};
            this._objLoadImage = {};
            return;
        }// end function

        public function get stuntPointInfo() : Array
        {
            return this._aryStuntPointInfo;
        }// end function

        public function get stuntInfo() : Array
        {
            return this._aryStuntInfo;
        }// end function

        public function get playerInfo() : Object
        {
            return this._objPlayerInfo;
        }// end function

        public function get playerStudyStunt() : Object
        {
            return this._objPlayerStudyStunt;
        }// end function

        public function get mainRoleStuntIds() : Array
        {
            return this._mainRoleStuntIds;
        }// end function

        public function get playerCanStudyStunt() : Object
        {
            return this._objPlayerCanStudyStunt;
        }// end function

        private function setStuntPointInfo(param1:Object) : void
        {
            param1["health_additional"] = StudyStuntType.getHealthAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["attack_additional"] = StudyStuntType.getAttackAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["stength_additional"] = StudyStuntType.getStengthAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["agile_additional"] = StudyStuntType.getAgileAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["intellect_additional"] = StudyStuntType.getIntellectAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["hit_additional"] = StudyStuntType.getHitAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["critical_additional"] = StudyStuntType.getCriticalAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["dodge_additional"] = StudyStuntType.getDodgeAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["block_additional"] = StudyStuntType.getBlockAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["break_critical_additional"] = StudyStuntType.getBreakCriticalAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["kill_additional"] = StudyStuntType.getKillAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["break_block_additional"] = StudyStuntType.getBreakBlockAdditional(param1["stunt_id"], param1["stunt_level"]);
            param1["need_aura"] = StudyStuntType.getNeedAura(param1["stunt_id"], param1["stunt_level"]);
            var _loc_2:String = "";
            if (param1["health_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.Health + param1["health_additional"] + "\r");
            }
            if (param1["attack_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.Attack + param1["attack_additional"] + "\r");
            }
            if (param1["stength_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.Stength + param1["stength_additional"] + "\r");
            }
            if (param1["agile_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.Agile + param1["agile_additional"] + "\r");
            }
            if (param1["intellect_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.Intellect + param1["intellect_additional"] + "\r");
            }
            if (param1["hit_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.Hit + param1["hit_additional"] * 10 + "\r");
            }
            if (param1["critical_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.Critical + param1["critical_additional"] * 10 + "\r");
            }
            if (param1["dodge_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.Dodge + param1["dodge_additional"] * 10 + "\r");
            }
            if (param1["block_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.Block + param1["block_additional"] * 10 + "\r");
            }
            if (param1["break_critical_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.BreakCritical + param1["break_critical_additional"] * 10 + "\r");
            }
            if (param1["kill_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.Kill + param1["kill_additional"] * 10 + "\r");
            }
            if (param1["break_block_additional"] > 0)
            {
                _loc_2 = _loc_2 + (StudyStuntDataLang.BreakBlock + param1["break_block_additional"] * 10 + "\r");
            }
            param1["tip"] = _loc_2;
            return;
        }// end function

        private function loadImage() : void
        {
            var _loc_1:String = null;
            var _loc_2:Image = null;
            this._intLoadTotal = 0;
            this._intLoadComplete = 0;
            for each (_loc_1 in this._objLoadImage)
            {
                
                var _loc_5:String = this;
                var _loc_6:* = this._intLoadTotal + 1;
                _loc_5._intLoadTotal = _loc_6;
                _loc_2 = new Image(_loc_1);
                _loc_2.onComplete = this.onLoadImageComplete;
            }
            this._objLoadImage = {};
            return;
        }// end function

        private function onLoadImageComplete() : void
        {
            var _loc_1:String = this;
            var _loc_2:* = this._intLoadComplete + 1;
            _loc_1._intLoadComplete = _loc_2;
            return;
        }// end function

        public function get isLoadComplete() : Boolean
        {
            var _loc_1:Boolean = false;
            if (this._intLoadTotal < 5)
            {
                _loc_1 = this._intLoadComplete == this._intLoadTotal;
            }
            else
            {
                _loc_1 = this._intLoadComplete + 2 >= this._intLoadTotal;
            }
            return _loc_1;
        }// end function

        private function getStuntPointData(param1:int, param2:Array) : Array
        {
            var _loc_4:Object = null;
            var _loc_3:Array = [];
            for each (_loc_4 in param2)
            {
                
                if (_loc_4["stunt_id"] == param1)
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        public function player_stunt_info(param1:Array) : void
        {
            var delay:Function;
            var i:int;
            var intNeedAura:int;
            var aryCurrentStuntPoint:Array;
            var k:int;
            var objAura:Object;
            var result:* = param1;
            delay = function () : void
            {
                var _loc_1:Image = null;
                if (!Image.isInCache(URI.studyStuntIconUrl + "show.swf"))
                {
                    _loc_1 = new Image(URI.studyStuntIconUrl + "show.swf");
                }
                if (!Image.isInCache(URI.studyStuntIconUrl + "hide.swf"))
                {
                    _loc_1 = new Image(URI.studyStuntIconUrl + "hide.swf");
                }
                return;
            }// end function
            ;
            this._objPlayerInfo = {};
            this._aryStuntPointInfo = [];
            this._aryStuntInfo = [];
            oObject.list(result, this._objPlayerInfo, ["stunt_id", "stunt_level", "aura", "stunt_state"]);
            if (this._objPlayerInfo["stunt_level"] == 9 && this._objPlayerInfo["stunt_id"] != 12)
            {
                (this._objPlayerInfo["stunt_id"] + 1);
                this._objPlayerInfo["stunt_level"] = 0;
            }
            if (!Image.isInCache(URI.studyStuntIconUrl + this._objPlayerInfo["stunt_id"] + "_small.swf"))
            {
                this._objLoadImage[this._objPlayerInfo["stunt_id"] + "_small.swf"] = URI.studyStuntIconUrl + this._objPlayerInfo["stunt_id"] + "_small.swf";
            }
            var objStunt:Object;
            var j:int;
            while (j <= this._objPlayerInfo["stunt_id"])
            {
                
                objStunt;
                objStunt["stunt_id"] = j;
                objStunt["stunt_name"] = StudyStuntType.getName(j);
                objStunt["stunt_elemente"] = StudyStuntType.getElement(j);
                objStunt["stunt_level"] = StudyStuntType.getLevel(j);
                objStunt["stunt_sign"] = StudyStuntType.getSign(j);
                objStunt["stunt_description"] = StudyStuntType.getDescription(j);
                this._aryStuntInfo.push(objStunt);
                if (j == this._objPlayerInfo["stunt_id"])
                {
                    this._objPlayerInfo["player_level"] = objStunt["stunt_level"];
                    this._objPlayerInfo["player_elemente"] = objStunt["stunt_elemente"];
                }
                if (!Image.isInCache(URI.studyStuntIconUrl + objStunt["stunt_id"] + "_big.swf"))
                {
                    this._objLoadImage[objStunt["stunt_id"] + "_big.swf"] = URI.studyStuntIconUrl + objStunt["stunt_id"] + "_big.swf";
                }
                j = (j + 1);
            }
            var objPoint:Object;
            var h:int;
            while (h <= this._objPlayerInfo["stunt_id"])
            {
                
                i;
                while (i <= 9)
                {
                    
                    objPoint;
                    objPoint["stunt_id"] = h;
                    objPoint["stunt_level"] = i;
                    this.setStuntPointInfo(objPoint);
                    this._aryStuntPointInfo.push(objPoint);
                    i = (i + 1);
                }
                h = (h + 1);
            }
            if (this._objPlayerInfo["player_level"] <= this._data.player.level)
            {
                intNeedAura;
                aryCurrentStuntPoint = this.getStuntPointData(this._objPlayerInfo["stunt_id"], this._aryStuntPointInfo);
                k = this._objPlayerInfo["stunt_level"];
                while (k < aryCurrentStuntPoint.length)
                {
                    
                    objAura = aryCurrentStuntPoint[k] as Object;
                    intNeedAura = intNeedAura + objAura["need_aura"];
                    if (this._objPlayerInfo["aura"] > objAura["need_aura"])
                    {
                        if (!Image.isInCache(URI.studyStuntIconUrl + "light.swf"))
                        {
                            this._objLoadImage["light.swf"] = URI.studyStuntIconUrl + "light.swf";
                        }
                    }
                    k = (k + 1);
                }
                if (this._objPlayerInfo["aura"] > intNeedAura)
                {
                    setTimeout(delay, 6000);
                }
            }
            this.loadImage();
            return;
        }// end function

        public function player_study_stunt(param1:Array) : void
        {
            this._objPlayerStudyStunt = {};
            oObject.list(param1, this._objPlayerStudyStunt, ["result", "stunt_state", "left_aura"]);
            return;
        }// end function

        public function player_use_role_stunt_id(param1:Array) : void
        {
            this._mainRoleStuntIds = [];
            var _loc_2:int = 0;
            while (_loc_2 < param1[0].length)
            {
                
                this._mainRoleStuntIds.push({playerId:param1[0][_loc_2][0], stuntId:param1[0][_loc_2][1]});
                _loc_2++;
            }
            return;
        }// end function

        public function player_can_study_stunt(param1:Array) : void
        {
            this._objPlayerCanStudyStunt = {};
            oObject.list(param1, this._objPlayerCanStudyStunt, ["stunt_id", "stunt_level"]);
            return;
        }// end function

    }
}
