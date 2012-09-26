package com.datas
{
    import com.assist.server.*;
    import com.haloer.data.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;

    public class QuestData extends Base
    {
        public var listPlayerQuest:Array = null;
        public var canReceiveQuest:Array = null;
        public var acceptQuest:int;
        public var npcInfoByNPCId:Array = null;
        public var npcInfoByQuestId:Object = null;
        public var townQuest:Array = null;
        public var completedState:int;
        public var awardItemId:int;
        public var hasQuestForNPC:Boolean = false;
        public var finishQuest:int;

        public function QuestData()
        {
            return;
        }// end function

        public function npc_info_by_npcid(param1:Array) : void
        {
            this.npcInfoByNPCId = this.format_npc_info(param1[0], true) as Array;
            return;
        }// end function

        public function npc_info_by_questid(param1:Array) : void
        {
            this.npcInfoByQuestId = this.format_npc_info(param1, false);
            return;
        }// end function

        public function accept_quest(param1:Array) : void
        {
            this.acceptQuest = param1[0];
            return;
        }// end function

        public function complete_quest(param1:Array) : void
        {
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["state", "experience", "coins", "itemId", "townKey", "questKey", "newQuest"]);
            this.completedState = _loc_2["state"];
            this.awardItemId = _loc_2["itemId"];
            this.hasQuestForNPC = _loc_2["newQuest"] == Mod_Quest_Base.NEWQUEST;
            return;
        }// end function

        public function giveup_quest(param1:Array) : void
        {
            return;
        }// end function

        public function list_player_quest(param1:Array) : void
        {
            this.listPlayerQuest = param1[0];
            return;
        }// end function

        public function can_receive_quest(param1:Array) : void
        {
            this.canReceiveQuest = param1[0];
            return;
        }// end function

        public function town_quest_show(param1:Array) : void
        {
            this.format_town_quest_show(param1[0]);
            return;
        }// end function

        public function finish_quest(param1:Array) : void
        {
            this.finishQuest = param1[0];
            return;
        }// end function

        private function format_npc_info(param1:Array, param2:Boolean) : Object
        {
            var _loc_6:Array = null;
            var _loc_7:Object = null;
            var _loc_8:int = 0;
            var _loc_9:String = null;
            var _loc_3:Array = [];
            if (param2 == false)
            {
                param1 = [param1];
            }
            var _loc_4:* = param1.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_3[_loc_5] = {};
                _loc_6 = ["quest_id", "state"];
                if (param2 == false)
                {
                    _loc_6.push("need_type", "quest_need");
                }
                oObject.list(param1[_loc_5], _loc_3[_loc_5], _loc_6);
                _loc_7 = _loc_3[_loc_5];
                _loc_8 = _loc_7["quest_id"];
                _loc_7["name"] = QuestType.getTitle(_loc_8);
                _loc_7["content"] = QuestType.getContent(_loc_8);
                _loc_7["begin_npc_id"] = QuestType.getBeginNPCId(_loc_8);
                _loc_7["begin_town_id"] = TownType.getIdByTownNPCId(QuestType.getBeginNPCId(_loc_8));
                _loc_7["end_npc_id"] = QuestType.getEndNPCId(_loc_8);
                _loc_7["end_town_id"] = TownType.getIdByTownNPCId(QuestType.getEndNPCId(_loc_8));
                _loc_7["award_experience"] = QuestType.getAwardExperience(_loc_8);
                _loc_7["award_coins"] = QuestType.getAwardCoins(_loc_8);
                _loc_7["award_item"] = QuestType.getAwardItemIdByRoleId(_loc_8, _data.player.mainRoleId);
                switch(_loc_7["state"])
                {
                    case QuestType.Acceptable:
                    {
                        break;
                    }
                    case QuestType.LevelLimit:
                    case QuestType.Accepted:
                    {
                        break;
                    }
                    case QuestType.Completed:
                    {
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_5++;
            }
            if (param2)
            {
                return this.sortNPCInfo(_loc_3);
            }
            return _loc_3[0];
        }// end function

        private function sortNPCInfo(param1:Array) : Array
        {
            var _loc_2:Array = [];
            var _loc_3:Array = [];
            var _loc_4:Array = [];
            var _loc_5:Array = [];
            var _loc_6:Array = [];
            var _loc_7:Array = [];
            var _loc_8:Array = [];
            var _loc_9:Array = [];
            var _loc_10:Array = [];
            this.classQuest(param1, _loc_2, _loc_3, _loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10);
            _loc_6.sortOn("quest_lock", Array.NUMERIC);
            _loc_7.sortOn("quest_lock", Array.NUMERIC);
            var _loc_11:* = [].concat(_loc_2, _loc_5, _loc_8, _loc_4, _loc_7, _loc_10, _loc_3, _loc_6, _loc_9);
            return [].concat(_loc_2, _loc_5, _loc_8, _loc_4, _loc_7, _loc_10, _loc_3, _loc_6, _loc_9);
        }// end function

        private function format_town_quest_show(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            this.townQuest = [];
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.townQuest[_loc_3] = [];
                oObject.list(param1[_loc_3], this.townQuest[_loc_3], ["quest_id", "state", "need_type", "quest_need"]);
                _loc_4 = this.townQuest[_loc_3]["quest_id"];
                _loc_5 = this.townQuest[_loc_3];
                _loc_5["quest_lock"] = QuestType.getLock(_loc_4);
                _loc_5["quest_lv"] = QuestType.getLevel(_loc_4);
                _loc_5["name"] = QuestType.getTitle(_loc_4);
                _loc_5["begin_npc_id"] = QuestType.getBeginNPCId(_loc_4);
                _loc_5["begin_town_id"] = TownType.getIdByTownNPCId(QuestType.getBeginNPCId(_loc_4));
                _loc_5["end_npc_id"] = QuestType.getEndNPCId(_loc_4);
                _loc_5["end_town_id"] = TownType.getIdByTownNPCId(QuestType.getEndNPCId(_loc_4));
                _loc_5["quest_type"] = QuestType.getType(_loc_4);
                _loc_5["conditions"] = QuestType.getConditions(_loc_4);
                _loc_5["town_text"] = QuestType.getTownText(_loc_4);
                _loc_5["mission_id"] = QuestType.getMissionId(_loc_4);
                _loc_5["mission_name"] = MissionType.getMissionName(QuestType.getMissionId(_loc_4));
                _loc_5["mission_monster_name"] = MissionType.getMissionMonsterId(QuestType.getMissionId(_loc_4));
                _loc_5["is_talk_quest"] = QuestType.getIsTalkQuest(_loc_4);
                _loc_3++;
            }
            this.townQuest = this.sortQuest(this.townQuest);
            return;
        }// end function

        public function sortQuest(param1:Array) : Array
        {
            return this.sortNPCInfo(param1);
        }// end function

        public function classQuest(param1:Array, param2:Array, param3:Array, param4:Array, param5:Array, param6:Array, param7:Array, param8:Array, param9:Array, param10:Array) : void
        {
            var _loc_13:Object = null;
            var _loc_11:* = param1.length;
            var _loc_12:int = 0;
            while (_loc_12 < _loc_11)
            {
                
                _loc_13 = param1[_loc_12];
                if (_loc_13["quest_type"] == QuestType.Master)
                {
                    if (QuestType.Completed == _loc_13["state"])
                    {
                        param2.push(_loc_13);
                    }
                    else if (QuestType.Accepted == _loc_13["state"])
                    {
                        param3.push(_loc_13);
                    }
                    else
                    {
                        param4.push(_loc_13);
                    }
                }
                else if (_loc_13["quest_type"] == QuestType.Slave)
                {
                    if (QuestType.Completed == _loc_13["state"])
                    {
                        param5.push(_loc_13);
                    }
                    else if (QuestType.Accepted == _loc_13["state"])
                    {
                        param6.push(_loc_13);
                    }
                    else
                    {
                        param7.push(_loc_13);
                    }
                }
                else if (QuestType.Completed == _loc_13["state"])
                {
                    param8.push(_loc_13);
                }
                else if (QuestType.Accepted == _loc_13["state"])
                {
                    param9.push(_loc_13);
                }
                else
                {
                    param10.push(_loc_13);
                }
                _loc_12++;
            }
            return;
        }// end function

    }
}
