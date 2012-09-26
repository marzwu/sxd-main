package com.views
{
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.controllers.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class QuestView extends Base implements IView
    {
        public var ownCtrl:QuestController;
        private var _quest:IQuest;
        private var _wayFindingText:String;
        private var _marked:Boolean = false;
        private var _halted:Boolean = false;

        public function QuestView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            if (_view.factionWarMap.isFactionWarStart == true)
            {
                return;
            }
            _data.call(Mod_Quest_Base.list_player_quest, this.loadResources, [], false);
            return;
        }// end function

        private function list_player_quest() : void
        {
            _data.call(Mod_Quest_Base.list_player_quest, this.listPlayerQuestCallback, []);
            return;
        }// end function

        private function can_receive_quest() : void
        {
            _data.call(Mod_Quest_Base.can_receive_quest, this.canReceiveQuestCallback, [_ctrl.player.mapId]);
            return;
        }// end function

        private function npc_info_by_questid(param1:int) : void
        {
            _data.call(Mod_Quest_Base.npc_info_by_questid, this.npcInfoByQuestidCallback, [param1]);
            return;
        }// end function

        public function accept_quest(param1:int, param2:Function = null) : void
        {
            var questId:* = param1;
            var callback:* = param2;
            var func:* = function () : void
            {
                switch(ownCtrl.acceptQuest)
                {
                    case Mod_Quest_Base.SUCCEED:
                    {
                        acceptQuestCallback();
                        _view.townMap.showQuestAdd();
                        if (callback is Function)
                        {
                            callback();
                        }
                        ;
                    }
                    case Mod_Quest_Base.FAILED:
                    {
                        ;
                    }
                    case Mod_Quest_Base.PACKFULL:
                    {
                        _view.showTip(QuestViewLang.PackFullTitle, QuestViewLang.PackFullContent, TipType.Question);
                        _view.npcDialog.rfQuest(questId);
                        ;
                    }
                    default:
                    {
                        ;
                    }
                }
                return;
            }// end function
            ;
            _data.call(Mod_Quest_Base.accept_quest, func, [questId]);
            return;
        }// end function

        private function giveup_quest(param1:int) : void
        {
            _data.call(Mod_Quest_Base.giveup_quest, this.giveUpCallback, [param1]);
            return;
        }// end function

        public function complete_quest(param1:int, param2:Function) : void
        {
            _data.call(Mod_Quest_Base.complete_quest, param2, [param1]);
            return;
        }// end function

        public function finish_quest(param1:int, param2:Function) : void
        {
            _data.call(Mod_Quest_Base.finish_quest, param2, [param1], false);
            return;
        }// end function

        private function loadResources() : void
        {
            loadAssets("Quest", this.render, QuestViewLang.LoadInfo);
            return;
        }// end function

        private function listPlayerQuestCallback() : void
        {
            this._quest.renderAccepted(this.ownCtrl.listPlayerQuest);
            return;
        }// end function

        private function canReceiveQuestCallback() : void
        {
            this._quest.renderAccepted(this.ownCtrl.canReceiveQuest);
            return;
        }// end function

        private function npcInfoByQuestidCallback() : void
        {
            this._quest.renderDetail(this.ownCtrl.npcInfoByQuestId);
            this._quest.acceptBtnVisible = _view.townMap.inStage;
            return;
        }// end function

        private function acceptQuestCallback() : void
        {
            _view.toolbar.loadQuestTrace();
            return;
        }// end function

        private function giveUpCallback() : void
        {
            this.list_player_quest();
            _view.toolbar.loadQuestTrace();
            return;
        }// end function

        private function render() : void
        {
            this._quest = _view.getAssetsObject("Quest", "Quest") as IQuest;
            this._quest.tip = _view.tip.iTip;
            this._quest.drag = _view.drag.iDrag;
            this._quest.abortVisible = _view.townMap.inStage;
            this._quest.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._quest.onDetail = function (param1:uint) : void
            {
                npc_info_by_questid(param1);
                return;
            }// end function
            ;
            this._quest.hasTrace = _view.toolbar.questTraceVisible;
            this._quest.onTrace = function (param1:Boolean) : void
            {
                _view.toolbar.questTraceVisible = param1;
                return;
            }// end function
            ;
            this._quest.onAccepted = function () : void
            {
                list_player_quest();
                return;
            }// end function
            ;
            this._quest.onAcceptable = function () : void
            {
                can_receive_quest();
                return;
            }// end function
            ;
            this._quest.onAccept = function (param1:int, param2:int, param3:int) : void
            {
                moveToNPC(param2, param3);
                return;
            }// end function
            ;
            this._quest.onComplete = function (param1:uint) : void
            {
                return;
            }// end function
            ;
            this._quest.onAbort = function (param1:uint) : void
            {
                giveup_quest(param1);
                return;
            }// end function
            ;
            this._quest.onWayFinding = function (param1:String) : void
            {
                wayFinding(param1);
                close();
                return;
            }// end function
            ;
            this._quest.init();
            this._quest.renderAccepted(this.ownCtrl.listPlayerQuest);
            _popup.addView(this, this._quest.content);
            _view.center(sign, this._quest.content);
            return;
        }// end function

        public function wayFinding(param1:String) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            this._wayFindingText = param1;
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (_view.factionWarMap.inStage)
            {
                _view.showTip(QuestViewLang.FactionEnableWarFinding);
                return;
            }
            var _loc_2:* = param1.split(/\s*,\s*""\s*,\s*/);
            switch(_loc_2[0])
            {
                case "mission":
                {
                    _loc_3 = _ctrl.mission.missionId;
                    if (_view.townMap.inStage)
                    {
                        this.moveToMission(_loc_2[1], _loc_2[2]);
                        _loc_4 = _loc_2[5] - _loc_2[6];
                        _view.missionPractice.getQuestArr(_loc_2[4], _loc_4);
                    }
                    else if (_view.war.missionCompleted)
                    {
                        _view.showTip(QuestViewLang.MonsterHitted);
                    }
                    else
                    {
                        _view.missionMap.gotoNearMonster();
                    }
                    break;
                }
                case "npc":
                {
                    if (_view.missionMap.inStage)
                    {
                        this.wayFinding("mission," + _ctrl.player.mapId + "," + _ctrl.mission.missionId);
                        return;
                    }
                    if (_view.missionMap.inStage && _loc_2[3] == QuestType.Completed)
                    {
                        _view.showTip(QuestViewLang.QuestCompleted);
                    }
                    else
                    {
                        this.moveToNPC(_loc_2[1], _loc_2[2]);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function markWayFinding() : void
        {
            this._marked = true;
            return;
        }// end function

        public function finishWayFinding() : void
        {
            this._marked = false;
            this._halted = false;
            return;
        }// end function

        public function haltWayFinding(param1:Boolean = false) : void
        {
            var timer:Timer;
            var handler:Function;
            var force:* = param1;
            return;
        }// end function

        public function moveToNPC(param1:int, param2:int) : void
        {
            var callback:Function;
            var townId:* = param1;
            var townNPCId:* = param2;
            if (_view.townMap.inStage == false)
            {
                _view.showTip(QuestViewLang.MissionEnableWarFinding, null, TipType.Question);
                return;
            }
            if (townId == _ctrl.player.mapId)
            {
                _view.townMap.moveToNPCAtId(townNPCId);
            }
            else
            {
                callback = function () : void
            {
                if (townId == _ctrl.player.mapId)
                {
                    _view.townMap.moveToNPCAtId(townNPCId);
                }
                return;
            }// end function
            ;
                _view.delayExecute(DelayType.WayFinding, callback);
                this.directEnterTown(townId);
            }
            return;
        }// end function

        public function moveToNPCByFunc(param1:int) : void
        {
            var _loc_2:* = TownType.getMaxTownId();
            var _loc_3:* = TownType.getTownNPCIdByFunc(_loc_2, param1);
            this.moveToNPC(_loc_2, _loc_3);
            return;
        }// end function

        public function gotoNPCByFunc(param1:int) : void
        {
            var _loc_2:* = _ctrl.player.townMapId;
            var _loc_3:* = TownType.getTownNPCIdByFunc(_loc_2, param1);
            this.moveToNPC(_loc_2, _loc_3);
            return;
        }// end function

        public function moveToMission(param1:int, param2:int, param3:String = "") : void
        {
            var isHeroMission:Boolean;
            var callback:Function;
            var townId:* = param1;
            var missionId:* = param2;
            var info:* = param3;
            if (info == "")
            {
                info = _view.chooseMission.mainMissionInfo;
            }
            if (_view.townMap.inStage == false)
            {
                _view.showTip(QuestViewLang.MissionEnableWarFinding, null, TipType.Question);
                return;
            }
            if (_ctrl.player.townKey < TownType.getLock(townId))
            {
                _view.showTip(QuestViewLang.TownNoOpen, "", TipType.Question);
                return;
            }
            var inSelfTown:Boolean;
            isHeroMission = MissionType.isHeroMission(missionId);
            var townSign:* = TownType.getSign(_ctrl.player.mapId);
            if (isHeroMission)
            {
                _view.heroMission.autoMissionId(townId, missionId, info);
                _view.heroMission.switchSelf();
                inSelfTown;
                return;
            }
            if (inSelfTown && (townId == _ctrl.player.mapId || isHeroMission))
            {
                if (!_view.chooseMission.inStage)
                {
                    if (isHeroMission)
                    {
                        _view.heroMission.autoMissionId(townId, missionId, info);
                    }
                    else
                    {
                        _view.chooseMission.autoMissionId(missionId, info);
                    }
                    _view.townMap.moveToPortal(isHeroMission);
                }
            }
            else
            {
                callback = function () : void
            {
                if (townId == _ctrl.player.mapId)
                {
                    if (isHeroMission)
                    {
                        _view.heroMission.autoMissionId(townId, missionId, info);
                    }
                    else
                    {
                        _view.chooseMission.autoMissionId(missionId, info);
                    }
                    _view.townMap.moveToPortal(isHeroMission);
                }
                return;
            }// end function
            ;
                _view.delayExecute(DelayType.MoveToPortal, callback);
                this.directEnterTown(townId);
            }
            return;
        }// end function

        private function directEnterTown(param1:int) : void
        {
            var _loc_2:* = _ctrl.player.townMapId;
            if (TownType.isTownById(_ctrl.player.townMapId))
            {
                if (_ctrl.player.townMapId > TownType.MaxOldMap && param1 > TownType.MaxOldMap)
                {
                    _view.newWorld.autoEnterTown(_ctrl.player.townMapId, param1);
                }
                else if (_ctrl.player.townMapId <= TownType.MaxOldMap && param1 <= TownType.MaxOldMap)
                {
                    _view.world.autoEnterTown(_ctrl.player.townMapId, param1);
                }
                else if (_ctrl.player.townMapId > TownType.MaxOldMap && param1 <= TownType.MaxOldMap)
                {
                    _view.newWorld.autoEnterTown(_ctrl.player.townMapId, 0);
                    _view.world.autoEnterTown(0, param1);
                }
                else
                {
                    _view.newWorld.autoEnterTown(0, param1);
                    _view.world.autoEnterTown(_ctrl.player.townMapId, 0);
                }
                _view.openWorld();
            }
            else if (_loc_2)
            {
                if (_loc_2 > TownType.MaxOldMap && param1 > TownType.MaxOldMap)
                {
                    _view.newWorld.autoEnterTown(_loc_2, param1);
                }
                else if (_loc_2 <= TownType.MaxOldMap && param1 <= TownType.MaxOldMap)
                {
                    _view.world.autoEnterTown(_loc_2, param1);
                }
                else if (_loc_2 > TownType.MaxOldMap && param1 <= TownType.MaxOldMap)
                {
                    _view.newWorld.autoEnterTown(_loc_2, 0);
                    _view.world.autoEnterTown(0, param1);
                }
                else
                {
                    _view.newWorld.autoEnterTown(0, param1);
                    _view.world.autoEnterTown(_loc_2, 0);
                }
                _view.openWorld();
            }
            else
            {
                _view.townMap.gotoTownAtId(param1);
            }
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
            this._quest.clear();
            return;
        }// end function

    }
}
