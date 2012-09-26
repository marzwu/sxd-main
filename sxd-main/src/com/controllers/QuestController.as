package com.controllers
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.datas.*;
    import com.haloer.data.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class QuestController extends Base
    {
        public var ownData:QuestData;
        private var _relatedNPC:Object;
        private var _completedQuest:Array;
        private var _hasLevelLimit:Boolean = false;
        public var masterBeginTownId:int = 0;
        public var masterBeginNpcId:int = 0;
        public var masterEndTownId:int = 0;
        public var masterEndNpcId:int = 0;
        public var masterQuestId:int = 0;
        public var questNpcId:int = 0;
        public var townQuestSurplus:int = 0;
        public var isTalkMainQuest:Boolean = false;
        public var mainQuestState:int = 0;
        public var masterMissionId:int = 0;
        private var _hasMasterCompleted:Boolean = false;
        private var _masterLock:uint;

        public function QuestController()
        {
            this._relatedNPC = {};
            this._completedQuest = [];
            return;
        }// end function

        public function get listPlayerQuest() : Array
        {
            return this.format_quest_list(this.ownData.listPlayerQuest, false);
        }// end function

        public function get canReceiveQuest() : Array
        {
            return this.format_quest_list(this.ownData.canReceiveQuest, true);
        }// end function

        private function format_quest_list(param1:Array, param2:Boolean) : Array
        {
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:Object = null;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_3:Object = {name:QuestType.getTypeName(QuestType.Master), value:[], opened:true};
            var _loc_4:Object = {name:QuestType.getTypeName(QuestType.Slave), value:[], opened:true};
            var _loc_5:Object = {name:QuestType.getTypeName(QuestType.Daily), value:[], opened:true};
            var _loc_6:Object = {name:QuestType.getTypeName(QuestType.Elite), value:[], opened:true};
            var _loc_7:Array = [];
            _loc_9 = param1.length;
            _loc_8 = 0;
            while (_loc_8 < _loc_9)
            {
                
                _loc_12 = param1[_loc_8][0];
                var _loc_14:* = {quest_id:_loc_12, name:QuestType.getTitle(_loc_12), quest_type:QuestType.getType(_loc_12), quest_lock:QuestType.getLock(_loc_12)};
                _loc_7[_loc_8] = {quest_id:_loc_12, name:QuestType.getTitle(_loc_12), quest_type:QuestType.getType(_loc_12), quest_lock:QuestType.getLock(_loc_12)};
                _loc_10 = _loc_14;
                if (param2)
                {
                    _loc_10["quest_lv"] = QuestType.getLevel(_loc_12);
                }
                else
                {
                    _loc_10["state"] = param1[_loc_8][1];
                }
                if (_ctrl.player.level < _loc_10["quest_lv"])
                {
                    _loc_10["name"] = this.traceTextColor(_loc_10["name"] + "{" + _loc_10["quest_lv"] + "}");
                }
                else
                {
                    _loc_10["name"] = this.traceTextColor(_loc_10["name"]);
                }
                _loc_8++;
            }
            _loc_7 = this.ownData.sortQuest(_loc_7);
            _loc_9 = _loc_7.length;
            _loc_8 = 0;
            while (_loc_8 < _loc_9)
            {
                
                _loc_10 = _loc_7[_loc_8];
                _loc_13 = _loc_10["quest_type"];
                if (QuestType.Master == _loc_13)
                {
                    _loc_3.value.push(_loc_10);
                    this._masterLock = _loc_10["quest_lock"];
                }
                else if (QuestType.Slave == _loc_13)
                {
                    _loc_4.value.push(_loc_10);
                }
                else if (QuestType.Daily == _loc_13)
                {
                    _loc_5.value.push(_loc_10);
                }
                else if (QuestType.Elite == _loc_13)
                {
                    _loc_6.value.push(_loc_10);
                }
                _loc_8++;
            }
            if (_loc_3.value.length > 0)
            {
                _loc_3.value[0]["focus"] = true;
            }
            else if (_loc_4.value.length > 0)
            {
                _loc_4.value[0]["focus"] = true;
            }
            else if (_loc_5.value.length > 0)
            {
                _loc_5.value[0]["focus"] = true;
            }
            else if (_loc_6.value.length > 0)
            {
                _loc_6.value[0]["focus"] = true;
            }
            var _loc_11:Array = [_loc_3];
            if (this._masterLock > QuestType.SlaveQuestLock || _loc_4.value.length > 0)
            {
                _loc_11.push(_loc_4);
            }
            if (this._masterLock > QuestType.EliteQuestLock || _loc_6.value.length > 0)
            {
                _loc_11.push(_loc_6);
            }
            return _loc_11;
        }// end function

        public function get isTwoCanOperate() : Boolean
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:* = this.ownData.npcInfoByNPCId;
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (QuestType.Completed == _loc_3[_loc_5]["state"])
                {
                    _loc_1++;
                }
                if (QuestType.Acceptable == _loc_3[_loc_5]["state"])
                {
                    _loc_2++;
                }
                _loc_5++;
            }
            if (_loc_1 > 1 || _loc_2 > 1)
            {
                return true;
            }
            return false;
        }// end function

        public function get npcInfoByNPCId() : Array
        {
            return this.ownData.npcInfoByNPCId;
        }// end function

        public function get acceptQuest() : int
        {
            return this.ownData.acceptQuest;
        }// end function

        public function get completedState() : int
        {
            return this.ownData.completedState;
        }// end function

        public function get awardItemId() : int
        {
            return this.ownData.awardItemId;
        }// end function

        public function get hasQuestForNPC() : Boolean
        {
            return this.ownData.hasQuestForNPC;
        }// end function

        public function get finishQuest() : int
        {
            return this.ownData.finishQuest;
        }// end function

        public function get npcInfoByQuestId() : Object
        {
            var _loc_1:int = 0;
            var _loc_2:* = this.ownData.npcInfoByQuestId;
            var _loc_3:Array = [];
            var _loc_4:* = this.formatDescription(_loc_2).join("");
            _loc_3.push(QuestControllerLang.StartNPC);
            _loc_3.push("<font color=\"#fff200\">");
            _loc_3.push("<a href=\"event:");
            _loc_3.push("npc," + _loc_2["begin_town_id"] + "," + _loc_2["begin_npc_id"]);
            _loc_3.push("\">");
            _loc_3.push("<u>" + NPCType.getName(TownNPCType.getNPCId(_loc_2["begin_npc_id"])) + "</u>");
            _loc_3.push("</a>");
            _loc_3.push("</font>，");
            _loc_3.push(QuestControllerLang.EndNPC);
            _loc_3.push("<font color=\"#fff200\">");
            _loc_3.push("<a href=\"event:");
            _loc_3.push("npc," + _loc_2["end_town_id"] + "," + _loc_2["end_npc_id"]);
            _loc_3.push("\">");
            _loc_3.push("<u>" + NPCType.getName(TownNPCType.getNPCId(_loc_2["end_npc_id"])) + "</u>");
            _loc_3.push("</a>");
            _loc_3.push("</font><br>");
            if (QuestType.LevelLimit == _loc_2["state"])
            {
                _loc_3.push(QuestControllerLang.LevelLimit);
                _loc_2["name"] = this.traceTextColor(_loc_2["name"]);
            }
            else if (_loc_2["is_talk_quest"] == 1 || _loc_2["state"] != QuestType.Completed && _loc_2["state"] != QuestType.Accepted || QuestType.PartnersQuestId == _loc_2["quest_id"])
            {
                _loc_3.push("<a href=\"event:npc," + _loc_2["end_town_id"] + "," + _loc_2["end_npc_id"] + "\">");
                _loc_3.push(_loc_4);
                _loc_3.push("</a>");
            }
            else
            {
                _loc_3.push("<a href=\"event:mission," + _loc_2["begin_town_id"] + "," + _loc_2["mission_id"] + "," + _loc_2["state"] + "," + _loc_2["monster_id"] + "," + _loc_2["max_count"] + "," + _loc_2["current_count"] + "\">");
                _loc_3.push(_loc_4);
                _loc_3.push("</a>");
            }
            _loc_2["goal"] = _loc_3.join("");
            return _loc_2;
        }// end function

        private function formatDescription(param1:Object) : Array
        {
            var _loc_8:Array = null;
            var _loc_9:Object = null;
            var _loc_2:Array = [];
            var _loc_3:Array = [];
            var _loc_4:* = param1["quest_need"];
            var _loc_5:* = param1["quest_need"].length;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_2[_loc_6] = [];
                _loc_8 = ["current_count", "max_count"];
                if (Mod_Quest_Base.NOONE == param1["need_type"])
                {
                }
                else if (Mod_Quest_Base.MONSTER == param1["need_type"])
                {
                    _loc_8.unshift("monster_id");
                }
                else
                {
                    _loc_8.unshift("item_id");
                }
                oObject.list(_loc_4[_loc_6], _loc_2[_loc_6], _loc_8);
                _loc_6++;
            }
            _loc_3.push(this.traceTextColor(param1["town_text"]));
            var _loc_7:String = "";
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_9 = _loc_2[_loc_6];
                switch(param1["need_type"])
                {
                    case Mod_Quest_Base.GETQUESTITEM:
                    {
                        _loc_7 = _loc_7 + (QuestControllerLang.GetItem + "[" + ItemType.getName(_loc_9["item_id"]) + "(" + _loc_9["current_count"] + "/" + _loc_9["max_count"] + ")" + "]");
                        break;
                    }
                    case Mod_Quest_Base.GETITEM:
                    {
                        if (_loc_7 != "")
                        {
                            _loc_7 = _loc_7 + QuestControllerLang.Pause;
                        }
                        _loc_7 = _loc_7 + ("[" + ItemType.getName(_loc_9["item_id"]) + "(" + _loc_9["current_count"] + "/" + _loc_9["max_count"] + ")" + "]");
                        break;
                    }
                    case Mod_Quest_Base.MONSTER:
                    {
                        if (_loc_7 != "")
                        {
                            _loc_7 = _loc_7 + QuestControllerLang.Pause;
                        }
                        _loc_7 = _loc_7 + ("[" + MonsterType.getMonsterNameById(_loc_9["monster_id"]) + "(" + _loc_9["current_count"] + "/" + _loc_9["max_count"] + ")" + "]");
                        param1.max_count = _loc_9["max_count"];
                        param1.current_count = _loc_9["current_count"];
                        param1.monster_id = _loc_9["monster_id"];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_6++;
            }
            if (_loc_7 != "")
            {
                _loc_3.push(this.traceTextColor(_loc_7));
            }
            return _loc_3;
        }// end function

        public function get hasMasterCompleted() : Boolean
        {
            return this._hasMasterCompleted;
        }// end function

        public function get masterLock() : uint
        {
            return this._masterLock;
        }// end function

        public function get townQuest() : Object
        {
            var _loc_11:Object = null;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            var _loc_15:int = 0;
            var _loc_16:String = null;
            var _loc_17:Array = null;
            this._relatedNPC = {};
            this._completedQuest = [];
            this._hasLevelLimit = false;
            var _loc_1:* = this.npcQuestCounts;
            var _loc_2:* = _ctrl.player.mapId;
            var _loc_3:* = FactionType.campSign(_ctrl.player.campId);
            var _loc_4:* = TownType.getMaxTownId();
            var _loc_5:* = TownType.getPrevTownIdByTownId(_loc_4);
            var _loc_6:Object = {accepted:[], acceptable:[]};
            var _loc_7:Boolean = false;
            var _loc_8:* = this.ownData.townQuest;
            var _loc_9:* = this.ownData.townQuest.length;
            var _loc_10:int = 0;
            while (_loc_10 < _loc_9)
            {
                
                _loc_11 = _loc_8[_loc_10];
                _loc_12 = _loc_11["begin_town_id"];
                _loc_13 = _loc_11["begin_npc_id"];
                _loc_14 = _loc_11["end_town_id"];
                _loc_15 = _loc_11["end_npc_id"];
                _loc_16 = this.formatDescription(_loc_11).join("");
                _loc_17 = [];
                if (_loc_11["quest_type"] == QuestType.Master)
                {
                    _loc_17.push(QuestControllerLang.Master);
                    this.masterBeginTownId = _loc_12;
                    this.masterBeginNpcId = _loc_13;
                    this.masterQuestId = _loc_11["quest_id"];
                    this.mainQuestState = _loc_11["state"];
                    this.masterEndTownId = _loc_14;
                    this.masterEndNpcId = _loc_15;
                    this.masterMissionId = _loc_11["mission_id"];
                    this.questNpcId = this.mainQuestState == QuestType.Acceptable ? (_loc_11["begin_npc_id"]) : (_loc_11["end_npc_id"]);
                    this.isTalkMainQuest = _loc_11["is_talk_quest"];
                }
                else
                {
                    _loc_17.push(QuestControllerLang.Slave);
                }
                _loc_17.push(_loc_11["name"]);
                if (_loc_11["state"] == QuestType.Acceptable || _loc_11["state"] == QuestType.LevelLimit)
                {
                    var _loc_18:* = _loc_1;
                    var _loc_19:* = _loc_13;
                    _loc_18[_loc_19] = _loc_1[_loc_13] - 1;
                    if (this._relatedNPC[_loc_13] != NPCInfo.NPC_Complete && _loc_11["state"] != QuestType.LevelLimit && _loc_1[_loc_13] != null && _loc_1[_loc_13]-- > 0)
                    {
                        this._relatedNPC[_loc_13] = NPCInfo.NPC_Acceptable;
                    }
                    if (_loc_12 != _loc_4 && _loc_12 != _loc_5)
                    {
                    }
                    _loc_17.unshift("<font color=\"#ffffff\">");
                    if (_loc_11["state"] == QuestType.Acceptable)
                    {
                        _loc_17.push("<br>    ");
                        _loc_17.push("<a href=\"event:npc,", _loc_11["begin_town_id"], ",", _loc_13, ",", _loc_11["state"], "\">");
                        _loc_17.push(QuestControllerLang.StartNPC);
                        _loc_17.push("<font color=\"#fff200\">");
                        _loc_17.push("<u>");
                        _loc_17.push(NPCType.getName(TownNPCType.getNPCId(_loc_13)));
                        _loc_17.push("</u>");
                        _loc_17.push("</font>");
                        _loc_17.push("</a>");
                    }
                    else if (QuestType.LevelLimit == _loc_11["state"])
                    {
                        _loc_17.push(this.traceTextColor("{" + _loc_11["quest_lv"].toString() + "}") + "<br>    " + QuestControllerLang.LevelLimit1);
                        this._hasLevelLimit = true;
                    }
                }
                else if (_loc_11["state"] == QuestType.Accepted)
                {
                    var _loc_18:* = _loc_1;
                    var _loc_19:* = _loc_13;
                    _loc_18[_loc_19] = _loc_1[_loc_13] - 1;
                    if (this._relatedNPC[_loc_13] != NPCInfo.NPC_Complete && this._relatedNPC[_loc_13] != NPCInfo.NPC_Acceptable && _loc_1[_loc_13] != null && _loc_1[_loc_13]-- > 0)
                    {
                    }
                    _loc_17.push("<br>    ");
                    if (_loc_11["is_talk_quest"] == 1 || QuestType.PartnersQuestId == _loc_11["quest_id"])
                    {
                        _loc_17.push("<a href=\"event:npc," + _loc_11["end_town_id"] + "," + _loc_11["end_npc_id"] + "," + _loc_11["state"] + "\">");
                        _loc_17.push(_loc_16);
                        _loc_17.push("</a>");
                    }
                    else
                    {
                        _loc_17.push("<a href=\"event:mission," + _loc_11["begin_town_id"] + "," + _loc_11["mission_id"] + "," + _loc_11["state"] + "," + _loc_11["monster_id"] + "," + _loc_11["max_count"] + "," + _loc_11["current_count"] + "\">");
                        _loc_17.push(_loc_16);
                        _loc_17.push("</a>");
                    }
                }
                else if (_loc_11["state"] == QuestType.Completed)
                {
                    this._relatedNPC[_loc_11["end_npc_id"]] = NPCInfo.NPC_Complete;
                    if (_loc_1[_loc_11["end_npc_id"]] != null)
                    {
                        var _loc_18:* = _loc_1;
                        var _loc_19:* = _loc_11["end_npc_id"];
                        var _loc_20:* = _loc_1[_loc_11["end_npc_id"]] - 1;
                        _loc_18[_loc_19] = _loc_20;
                    }
                    _loc_17.unshift("<a href=\"event:npc," + _loc_11["end_town_id"] + "," + _loc_11["end_npc_id"] + "," + _loc_11["state"] + "\"><u>");
                    _loc_17.unshift("<font color=\"#00ff00\">");
                    _loc_17.push("(", QuestControllerLang.EnabledComplete, ")");
                    _loc_17.push("</u></a></font>");
                    this._completedQuest.push(_loc_11["quest_id"]);
                    if (_loc_11["quest_type"] == QuestType.Master)
                    {
                        _loc_7 = true;
                    }
                }
                if (_loc_11["state"] == QuestType.Acceptable || _loc_11["state"] == QuestType.LevelLimit)
                {
                    _loc_6["acceptable"].push(_loc_17.join(""));
                }
                else
                {
                    _loc_6["accepted"].push(_loc_17.join(""));
                }
                if (_loc_11["quest_type"] == QuestType.Master)
                {
                    this._masterLock = _loc_11["quest_lock"];
                }
                _loc_10++;
            }
            this._hasMasterCompleted = _loc_7;
            return _loc_6;
        }// end function

        public function get townQuestData() : Array
        {
            return this.ownData.townQuest;
        }// end function

        public function get relatedNPC() : Object
        {
            return this._relatedNPC;
        }// end function

        public function get completedQuest() : Array
        {
            return this._completedQuest;
        }// end function

        public function get hasLevelLimit() : Boolean
        {
            return this._hasLevelLimit;
        }// end function

        private function traceTextColor(param1:String) : String
        {
            param1 = param1.replace(/\[""\[/g, "<font color=\"#fff200\"><u>");
            param1 = param1.replace(/\]""\]/g, "</u></font>");
            param1 = param1.replace(/\{""\{/g, "<font color=\"#ff0000\">(");
            param1 = param1.replace(/\}""\}/g, Lang.sprintf(QuestControllerLang.TraceText, "") + ")</font>");
            return param1;
        }// end function

        private function get npcQuestCounts() : Object
        {
            var _loc_4:String = null;
            var _loc_5:Object = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_1:Object = {};
            var _loc_2:* = _ctrl.player.mapId;
            var _loc_3:* = TownType.getNPCList(_loc_2);
            for (_loc_4 in _loc_3)
            {
                
                _loc_5 = _loc_3[_loc_4];
                _loc_6 = _loc_5["id"];
                _loc_7 = NPCType.getId(TownType.getNPCSignByTownNPCId(_loc_6));
                _loc_8 = NPCType.getFunction(_loc_7);
                _loc_1[_loc_6] = 4 - (_loc_8 != NPCType.NonFunction ? (1) : (0));
            }
            return _loc_1;
        }// end function

    }
}
