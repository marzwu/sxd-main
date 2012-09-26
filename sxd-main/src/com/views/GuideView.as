package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.guide.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.lang.client.com.views.guide.*;
    import flash.display.*;
    import flash.geom.*;

    public class GuideView extends Base implements IView
    {
        private var _Guide:Class;
        private var _list:Object;
        private var guides:Object;
        private var _guide:IGuide;

        public function GuideView() : void
        {
            this._list = {};
            this.guides = {};
            this.initGuideData();
            return;
        }// end function

        public function show() : void
        {
            var callback:* = function () : void
            {
                var _loc_1:* = new _Guide() as IGuide;
                _loc_1.x = 300;
                _loc_1.y = 400;
                _loc_1.text = "测试1\n测试2";
                _loc_1.dir = GuideDir.Right;
                _popup.addChild(_loc_1.content);
                return;
            }// end function
            ;
            this.load(callback);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function load(param1:Function) : void
        {
            var file:File;
            var callback:* = param1;
            if (this._Guide == null)
            {
                file = new File();
                file.onComplete = function () : void
            {
                _Guide = file.getClassByName("Guide");
                callback();
                return;
            }// end function
            ;
                file.load(URI.assetsUrl + "guide.swf");
            }
            else
            {
                this.callback();
            }
            return;
        }// end function

        public function checkVisible() : void
        {
            var _loc_2:Object = null;
            var _loc_1:* = _view.townMap.inStage;
            for each (_loc_2 in this._list)
            {
                
                if (_loc_2["guide"])
                {
                    _loc_2["guide"].visible = _loc_1;
                }
            }
            return;
        }// end function

        public function open() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Object = null;
            for each (_loc_3 in this._ctrl.quest.townQuestData)
            {
                
                _loc_1 = _loc_3["quest_id"];
                _loc_2 = _loc_3["state"];
                this.beginner(_loc_1, _loc_2);
                this.training(_loc_1, _loc_2);
                this.upgrade(_loc_1, _loc_2);
                this.partners(_loc_1, _loc_2);
                this.partners2(_loc_1, _loc_2);
                this.ItemWear(_loc_1, _loc_2);
                this.autoWay(_loc_1, _loc_2);
                this.fateLodge(_loc_1, _loc_2);
            }
            if (this._ctrl.player.level > 1)
            {
                if (this.hasGuide(GuideType.ItemWear))
                {
                    this.stopItemWearGuides();
                }
            }
            if (this._ctrl.player.level > 5)
            {
                if (this.hasGuide(GuideType.Upgrade))
                {
                    this.stopUpgradeGuides();
                }
            }
            this.checkVisible();
            return;
        }// end function

        public function start(param1:int) : void
        {
            if (this._list[param1])
            {
                return;
            }
            if (_view.getCookie(URI.ip + "Guide" + "_" + this._ctrl.player.playerId + "_" + param1))
            {
                return;
            }
            this._list[param1] = {guide:null, index:0};
            return;
        }// end function

        public function hasGuide(param1:int) : Boolean
        {
            return this._list[param1];
        }// end function

        public function stop(param1:int) : void
        {
            this.hideTrack(param1);
            if (this._list[param1] && this._list[param1].guide)
            {
                this._list[param1].guide.clear();
                _view.tip.iTip.removeTarget(this._list[param1].guide.content);
            }
            delete this._list[param1];
            return;
        }// end function

        public function hideTrack(param1:int) : void
        {
            if (this._list[param1])
            {
                if (this._list[param1].guide && this._list[param1].guide.parent)
                {
                    this._list[param1].guide.parent.removeChild(this._list[param1].guide);
                }
            }
            return;
        }// end function

        public function hasTrack(param1:int) : Boolean
        {
            return this._list[param1];
        }// end function

        public function isLastTrace(param1:int) : Boolean
        {
            if (this.hasTrack(param1))
            {
                return (this.guides[param1].length - 1) == this._list[param1].index;
            }
            return false;
        }// end function

        public function track(param1:int, param2:int, param3:Sprite) : void
        {
            var type:* = param1;
            var index:* = param2;
            var parent:* = param3;
            if (this.hasTrack(type) == false)
            {
                return;
            }
            var callback:* = function () : void
            {
                var _loc_4:Point = null;
                if (hasTrack(type) == false)
                {
                    return;
                }
                var _loc_1:* = _list[type].guide;
                if (_loc_1 == null)
                {
                    _loc_1 = new _Guide() as IGuide;
                    _list[type].guide = _loc_1;
                }
                var _loc_2:* = _list[type].index;
                if ((_loc_2 - 1) >= index || (_loc_2 + 1) < index)
                {
                    return;
                }
                _list[type].index = index;
                parent.addChild(_loc_1.content);
                _view.tip.iTip.addTarget(_loc_1.content, GuideViewLang.Arrow);
                var _loc_3:* = guides[type][(index - 1)];
                _loc_1.dir = _loc_3[2];
                _loc_1.text = _loc_3[3];
                if (_loc_3[4] is Function)
                {
                    var _loc_5:* = _loc_3;
                    _loc_5._loc_3[4]();
                    _loc_4 = Structure.stageOffset;
                    _loc_1.x = _loc_3[0] - _loc_4.x;
                    _loc_1.y = _loc_3[1] - _loc_4.y;
                }
                else
                {
                    _loc_1.x = _loc_3[0];
                    _loc_1.y = _loc_3[1];
                }
                if (_loc_3[5] is Function)
                {
                    _loc_1.content.buttonMode = true;
                    _loc_1.onClick = _loc_3[5];
                }
                else
                {
                    _loc_1.content.buttonMode = false;
                    _loc_1.onClick = null;
                }
                checkFateLodgeGuideVisible();
                checkPartnersGuideVisible();
                return;
            }// end function
            ;
            this.load(callback);
            return;
        }// end function

        public function setCookie(param1:int) : void
        {
            if (this.hasGuide(param1))
            {
                _view.setCookie(URI.ip + "Guide" + "_" + this._ctrl.player.playerId + "_" + param1, true);
            }
            return;
        }// end function

        public function setPoint(param1:int, param2:int, param3:int) : void
        {
            if (!this._list[param1])
            {
                return;
            }
            var _loc_4:* = this._list[param1].guide;
            if (this._list[param1].guide != null)
            {
                _loc_4.x = param2;
                _loc_4.y = param3;
            }
            return;
        }// end function

        public function reposition() : void
        {
            var _loc_1:String = null;
            var _loc_2:IGuide = null;
            var _loc_3:int = 0;
            var _loc_4:Array = null;
            var _loc_5:Point = null;
            for (_loc_1 in this._list)
            {
                
                _loc_2 = this._list[_loc_1].guide;
                if (_loc_2 == null)
                {
                    continue;
                }
                _loc_3 = this._list[_loc_1].index;
                if (_loc_2.content.parent == _view.toolbar.content)
                {
                    _loc_4 = this.guides[_loc_1][(_loc_3 - 1)];
                    if (_loc_4[4] is Function)
                    {
                        var _loc_8:* = _loc_4;
                        _loc_8._loc_4[4]();
                    }
                    _loc_5 = Structure.stageOffset;
                    _loc_2.x = _loc_4[0] - _loc_5.x;
                    _loc_2.y = _loc_4[1] - _loc_5.y;
                }
            }
            return;
        }// end function

        private function initGuideData() : void
        {
            this.initPartners();
            this.initBeginner();
            this.initItemWear();
            this.initUpgrade();
            this.initTraining();
            this.initAutoWay();
            this.initFateLodge();
            this.initFateWear();
            return;
        }// end function

        private function initPartners() : void
        {
            this.guides[GuideType.Partners] = [[2045, 245, GuideDir.Right, partnersLang.ClickHere], [175, 110, GuideDir.Right, partnersLang.ClickHere], [250, 118, GuideDir.Right, partnersLang.ClickHere], [690, 11, GuideDir.Right, partnersLang.ClickHere], [221, 288, GuideDir.Right, partnersLang.ClickHere]];
            this.initPartners2();
            return;
        }// end function

        public function trackPartners(param1:int, param2:Sprite) : void
        {
            this.track(GuideType.Partners, param1, param2);
            return;
        }// end function

        private function partners(param1:int, param2:int) : void
        {
            if (param1 == QuestType.PartnersQuestId && param2 == QuestType.Accepted)
            {
                this.start(GuideType.Partners);
                this.trackPartners(1, _view.townMap.guideLayder);
            }
            return;
        }// end function

        public function triggerDeploy() : void
        {
            if (FunctionType.isPlayed(FunctionType.Deploy) == false)
            {
                this._view.toolbar.triggerDeploy();
            }
            return;
        }// end function

        public function stopPartnersGuide() : void
        {
            var _loc_1:Object = null;
            for each (_loc_1 in this._ctrl.quest.townQuestData)
            {
                
                if (_loc_1["quest_id"] == QuestType.PartnersQuestId && _loc_1["state"] == QuestType.Completed)
                {
                    this.setCookie(GuideType.Partners);
                    this.stop(GuideType.Partners);
                }
            }
            return;
        }// end function

        private function initPartners2() : void
        {
            this.guides[GuideType.Partners2] = [[250, 245, GuideDir.Right, partnersLang.ClickInn], [175, 123, GuideDir.Right, partnersLang.ClickRole], [250, 118, GuideDir.Right, partnersLang.ClickPartners], [690, 11, GuideDir.Right, partnersLang.ClickClose]];
            return;
        }// end function

        public function trackPartners2(param1:int, param2:Sprite) : void
        {
            this.track(GuideType.Partners2, param1, param2);
            return;
        }// end function

        private function partners2(param1:int, param2:int) : void
        {
            if (param1 == QuestType.PartnersQuestId2 && param2 == QuestType.Accepted)
            {
                this.start(GuideType.Partners2);
                this.trackPartners2(1, _view.townMap.guideLayder);
            }
            return;
        }// end function

        public function setPartnersIndex2(param1:int) : void
        {
            if (param1 > 1)
            {
                this.guides[GuideType.Partners2][1] = [175, 135, GuideDir.Right, partnersLang.ClickRole];
            }
            else
            {
                this.guides[GuideType.Partners2][1] = [175, 110, GuideDir.Right, partnersLang.ClickRole];
            }
            return;
        }// end function

        public function stopPartnersGuides2() : void
        {
            this.setCookie(GuideType.Partners2);
            this.stop(GuideType.Partners2);
            return;
        }// end function

        public function checkPartnersGuideVisible() : void
        {
            if (this._ctrl.player.mapId != TownType.getId(TownType.SuZhou))
            {
                this.hideTrack(GuideType.Partners2);
            }
            return;
        }// end function

        private function initBeginner() : void
        {
            var firstAction:* = function () : void
            {
                var _loc_1:* = _ctrl.player.mapId;
                _view.quest.moveToNPC(_loc_1, TownType.getTownNPCId(_loc_1, NPCType.ShuiLing));
                return;
            }// end function
            ;
            this.guides[GuideType.Beginner] = [[480, 260, GuideDir.Right, beginnerLang.StartQuest, null, firstAction], [175, 110, GuideDir.Right, beginnerLang.Dialog], [175, 110, GuideDir.Right, beginnerLang.Dialog], [655, 230, GuideDir.Right, beginnerLang.CompleteQuest], [175, 110, GuideDir.Right, beginnerLang.Dialog], [175, 110, GuideDir.Right, beginnerLang.AcceptQuest]];
            return;
        }// end function

        private function beginner(param1:int, param2:int) : void
        {
            if (param1 == QuestType.BeginnerQuestId && param2 == QuestType.Completed)
            {
                this.trackBeginner(4, _view.townMap.guideLayder);
            }
            if (param1 == QuestType.BeginnerQuestId && param2 == QuestType.Acceptable)
            {
                if (this.hasGuide(GuideType.Beginner))
                {
                    this.stopBeginnerGuides();
                }
                this.start(GuideType.Beginner);
                this.trackBeginner(1, _view.townMap.guideLayder);
            }
            return;
        }// end function

        public function trackBeginner(param1:int, param2:Sprite) : void
        {
            this.track(GuideType.Beginner, param1, param2);
            return;
        }// end function

        public function stopBeginnerGuides() : void
        {
            this.stop(GuideType.Beginner);
            this.stopItemWearGuides();
            return;
        }// end function

        private function initItemWear() : void
        {
            this.guides[GuideType.ItemWear] = [[838, 551, GuideDir.Right, itemWearLang.OpenBag], [0, 0, GuideDir.Right, itemWearLang.WearItem], [276, 13, GuideDir.Right, itemWearLang.ClickClose], [279, 13, GuideDir.Right, itemWearLang.ClickClose]];
            return;
        }// end function

        public function trackItemWear(param1:int, param2:Sprite) : void
        {
            return;
        }// end function

        private function ItemWear(param1:int, param2:int) : void
        {
            var handler:Function;
            var questId:* = param1;
            var questState:* = param2;
            if (questId == QuestType.BeginnerItemId && questState == QuestType.Accepted && this._ctrl.player.level < 2)
            {
                if (this.hasGuide(GuideType.Beginner))
                {
                    _view.guide.setCookie(GuideType.Beginner);
                    this.stopBeginnerGuides();
                }
                return;
            }
            return;
        }// end function

        public function startItemWearGuide(param1:Sprite, param2:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:ItemInfo = null;
            var _loc_6:Object = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            return;
            for each (_loc_6 in this._ctrl.quest.townQuestData)
            {
                
                if (_loc_6["quest_id"] == QuestType.BeginnerItemId)
                {
                    this.guides[GuideType.ItemWear][1] = [_loc_3, _loc_4, GuideDir.Right, itemWearLang.WearItem];
                    this.trackItemWear(2, param1);
                    break;
                }
            }
            if (_loc_3 == 0 || this._structure.popup.hasView(this._view.shop))
            {
                _view.guide.trackItemWear(3, this._view.pack.content);
            }
            return;
        }// end function

        public function closePackGuides() : void
        {
            return;
        }// end function

        public function closeRoleMsgGuides() : void
        {
            return;
        }// end function

        public function stopItemWearGuides() : void
        {
            var _loc_1:Object = null;
            this.stop(GuideType.ItemWear);
            for each (_loc_1 in this._ctrl.quest.townQuestData)
            {
                
                if (_loc_1["quest_id"] == QuestType.BeginnerItemId)
                {
                    if (!this.hasGuide(GuideType.AutoWay))
                    {
                        this.start(GuideType.AutoWay);
                        if (_loc_1["state"] == QuestType.Accepted)
                        {
                            this.trackAutoWay(1, _view.toolbar.questTraceContent);
                        }
                    }
                }
            }
            return;
        }// end function

        private function initUpgrade() : void
        {
            this.guides[GuideType.Upgrade] = [[838, 551, GuideDir.Right, upgradeLang.OpenUpgrade], [531, 341, GuideDir.Right, upgradeLang.ClickUpgrade], [680, 13, GuideDir.Right, upgradeLang.ClickClose], [12, 45, GuideDir.Right, upgradeLang.AutoWay]];
            return;
        }// end function

        public function trackUpgrade(param1:int, param2:Sprite) : void
        {
            this.track(GuideType.Upgrade, param1, param2);
            return;
        }// end function

        private function upgrade(param1:int, param2:int) : void
        {
            if (param1 == QuestType.BeginnerUpgradeId && param2 == QuestType.Completed)
            {
                this.stopAutoWayGuides();
                this.stopItemWearGuides();
                this.setCookie(GuideType.AutoWay);
                if (FunctionType.isPlayed(FunctionType.Upgrade))
                {
                    this._view.guide.startUpgradeGuides();
                }
            }
            if (param1 == 3 && param2 == QuestType.Acceptable)
            {
                if (this.hasGuide(GuideType.Upgrade))
                {
                    this._view.guide.setCookie(GuideType.Upgrade);
                    this._view.guide.stopUpgradeGuides();
                }
            }
            if (param1 == QuestType.BeginnerUpgradeId && (param2 == QuestType.Acceptable || param2 == QuestType.Accepted))
            {
                if (this.hasGuide(GuideType.AutoWay))
                {
                    this.setCookie(GuideType.AutoWay);
                    this.stopAutoWayGuides();
                }
                if (this.hasGuide(GuideType.ItemWear))
                {
                    this.setCookie(GuideType.ItemWear);
                    this.stop(GuideType.ItemWear);
                }
            }
            return;
        }// end function

        public function stopUpgradeGuides() : void
        {
            this.stop(GuideType.Upgrade);
            return;
        }// end function

        public function startUpgradeGuides() : void
        {
            var questId:int;
            var handler:Function;
            var _loc_2:int = 0;
            var _loc_3:* = _ctrl.quest.completedQuest;
            while (_loc_3 in _loc_2)
            {
                
                questId = _loc_3[_loc_2];
                if (questId == QuestType.BeginnerUpgradeId)
                {
                    this.stopAutoWayGuides();
                    this.stopItemWearGuides();
                    this.start(GuideType.Upgrade);
                    handler = function () : void
            {
                var _loc_1:* = _view.toolbar.getFunctionPoint(FunctionType.Upgrade);
                guides[GuideType.Upgrade][0][0] = _loc_1.x - 10;
                guides[GuideType.Upgrade][0][1] = _loc_1.y - 16;
                return;
            }// end function
            ;
                    this.guides[GuideType.Upgrade][0] = [0, 0, GuideDir.Right, upgradeLang.OpenUpgrade, handler];
                    this.handler();
                    this.trackUpgrade(1, this._view.toolbar.content);
                    break;
                }
            }
            return;
        }// end function

        private function initTraining() : void
        {
            this.guides[GuideType.Training] = [[675, 551, GuideDir.Right, trainingLang.OpenRole], [100, 386, GuideDir.Right, trainingLang.OpenTraining], [170, 303, GuideDir.Right, trainingLang.ClickTraining], [130, 303, GuideDir.Right, trainingLang.ClickSave]];
            return;
        }// end function

        public function trackTraining(param1:int, param2:Sprite, param3:int = 0, param4:int = 0) : void
        {
            if (param1 == 2)
            {
                this.guides[GuideType.Training][1][0] = param3;
                this.guides[GuideType.Training][1][1] = param4;
            }
            this.track(GuideType.Training, param1, param2);
            return;
        }// end function

        private function training(param1:int, param2:int) : void
        {
            if (param1 == QuestType.BeginnerTrainingId && param2 == QuestType.Completed && FunctionType.isPlayed(FunctionType.Training))
            {
                this.startTrainingGuides();
            }
            return;
        }// end function

        public function startTrainingGuides() : void
        {
            var questId:int;
            var handler:Function;
            var _loc_2:int = 0;
            var _loc_3:* = _ctrl.quest.completedQuest;
            while (_loc_3 in _loc_2)
            {
                
                questId = _loc_3[_loc_2];
                if (questId == QuestType.BeginnerTrainingId)
                {
                    this.start(GuideType.Training);
                    handler = function () : void
            {
                var _loc_1:* = _view.toolbar.getFunctionPoint(FunctionType.Body);
                guides[GuideType.Training][0][0] = _loc_1.x - 10;
                guides[GuideType.Training][0][1] = _loc_1.y - 16;
                return;
            }// end function
            ;
                    this.guides[GuideType.Training][0] = [0, 0, GuideDir.Right, trainingLang.OpenRole, handler];
                    this.handler();
                    this.trackTraining(1, this._view.toolbar.content);
                    break;
                }
            }
            return;
        }// end function

        public function stopTrainingGuides() : void
        {
            this.stop(GuideType.Training);
            return;
        }// end function

        private function initAutoWay() : void
        {
            this.guides[GuideType.AutoWay] = [[25, 62, GuideDir.Right, autoWayLang.autoWay], [12, 45, GuideDir.Right, autoWayLang.autoWay]];
            return;
        }// end function

        private function autoWay(param1:int, param2:int) : void
        {
            if (param1 == QuestType.BeginnerAutoWayId)
            {
                if (param2 == QuestType.Acceptable && this.hasGuide(GuideType.AutoWay))
                {
                    this.stopAutoWayGuides();
                }
                if (param2 == QuestType.Accepted && !this.hasGuide(GuideType.ItemWear))
                {
                    this.start(GuideType.AutoWay);
                    this.trackAutoWay(1, _view.toolbar.questTraceContent);
                }
            }
            return;
        }// end function

        public function trackAutoWay(param1:int, param2:Sprite) : void
        {
            this.track(GuideType.AutoWay, param1, param2);
            return;
        }// end function

        public function stopAutoWayGuides() : void
        {
            this.stop(GuideType.AutoWay);
            return;
        }// end function

        private function initDeploy() : void
        {
            this.guides[GuideType.Deploy] = [[833, 556, GuideDir.Right, deployLang.ClickHere], [55, 175, GuideDir.Right, deployLang.First], [537, 14, GuideDir.Right, deployLang.ClickHere]];
            this.initDeloy2();
            return;
        }// end function

        public function trackDeploy(param1:int, param2:Sprite) : void
        {
            this.track(GuideType.Deploy, param1, param2);
            if (param1 == 1)
            {
                this.start(GuideType.Deploy2);
            }
            if (param1 == 2)
            {
                this.trackDeploy2(1, param2);
            }
            if (param1 == 3)
            {
                this.setCookie(GuideType.Deploy2);
                this.stop(GuideType.Deploy2);
            }
            return;
        }// end function

        public function stopDeployGuides() : void
        {
            var _loc_1:Object = null;
            for each (_loc_1 in this._ctrl.quest.townQuestData)
            {
                
                if (_loc_1["quest_id"] == QuestType.PartnersQuestId && _loc_1["state"] == QuestType.Completed)
                {
                    this.setCookie(GuideType.Deploy);
                    this.stop(GuideType.Deploy);
                    this.stop(GuideType.Deploy2);
                    if (FunctionType.isPlayed(FunctionType.Deploy) == false)
                    {
                        this._view.toolbar.triggerDeploy();
                    }
                }
            }
            return;
        }// end function

        public function startDeployGuides() : void
        {
            var obj:Object;
            var handler:Function;
            var _loc_2:int = 0;
            var _loc_3:* = this._ctrl.quest.townQuestData;
            while (_loc_3 in _loc_2)
            {
                
                obj = _loc_3[_loc_2];
                if (obj["quest_id"] == QuestType.PartnersQuestId && obj["state"] == QuestType.Accepted)
                {
                    this.start(GuideType.Deploy);
                    handler = function () : void
            {
                var _loc_1:* = _view.toolbar.getFunctionPoint(FunctionType.Deploy);
                guides[GuideType.Deploy][0][0] = _loc_1.x - 20;
                guides[GuideType.Deploy][0][1] = _loc_1.y - 16;
                return;
            }// end function
            ;
                    this.guides[GuideType.Deploy][0] = [0, 0, GuideDir.Right, deployLang.ClickHere, handler];
                    this.handler();
                    this.trackDeploy(1, this._view.toolbar.content);
                }
            }
            return;
        }// end function

        private function initDeloy2() : void
        {
            this.guides[GuideType.Deploy2] = [[217, 255, GuideDir.Right, deployLang.Second]];
            return;
        }// end function

        public function trackDeploy2(param1:int, param2:Sprite) : void
        {
            this.track(GuideType.Deploy2, param1, param2);
            return;
        }// end function

        private function initFateLodge() : void
        {
            this.guides[GuideType.FateLodge] = [[0, 0, GuideDir.Right, fateLang.IntoInn], [43, 5, GuideDir.Bottom, fateLang.ClickHere], [-26, 56, GuideDir.Top, fateLang.PickUp]];
            return;
        }// end function

        public function trackFateLodge(param1:int, param2:Sprite) : void
        {
            this.track(GuideType.FateLodge, param1, param2);
            return;
        }// end function

        private function fateLodge(param1:int, param2:int) : void
        {
            if ((param1 == QuestType.BeginnerFateIdByShuShan || param1 == QuestType.BeginnerFateIdByKunLun) && param2 == QuestType.Completed)
            {
                if (!this.hasGuide(GuideType.FateLodge))
                {
                    this.start(GuideType.FateLodge);
                }
                this.startFateLodgeGuide();
            }
            return;
        }// end function

        public function checkFateLodgeGuideVisible() : void
        {
            if (this._ctrl.player.inSelfCampTown)
            {
                if (!this.hasGuide(GuideType.FateLodge))
                {
                    this.trackFateLodge(1, _view.townMap.guideLayder);
                }
            }
            else
            {
                this.hideTrack(GuideType.FateLodge);
            }
            return;
        }// end function

        public function startFateLodgeGuide() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            if (this._ctrl.player.campId == FactionType.campId(FactionType.KunLunCheng))
            {
                _loc_1 = 1035;
                _loc_2 = 200;
            }
            else if (this._ctrl.player.campId == FactionType.campId(FactionType.ShuShanCheng))
            {
                _loc_1 = 920;
                _loc_2 = 180;
            }
            if (this._ctrl.player.inSelfCampTown)
            {
                this.guides[GuideType.FateLodge][0] = [_loc_1, _loc_2, GuideDir.Right, fateLang.IntoInn];
                this.trackFateLodge(1, _view.townMap.guideLayder);
            }
            else
            {
                this.hideTrack(GuideType.FateLodge);
            }
            return;
        }// end function

        public function stopFateLodgeGuide(param1:MovieClip) : void
        {
            if (this.hasGuide(GuideType.FateLodge))
            {
                this.start(GuideType.FateWear);
                this.trackFateWear(1, param1);
            }
            this.stop(GuideType.FateLodge);
            return;
        }// end function

        private function initFateWear() : void
        {
            this.guides[GuideType.FateWear] = [[860, 54, GuideDir.Right, fateLang.OpenBag], [40, 125, GuideDir.Right, fateLang.WearFate1], [693, 11, GuideDir.Right, fateLang.ClickClose], [840, -20, GuideDir.Right, fateLang.ClickClose]];
            this.initFateWear2();
            return;
        }// end function

        private function initFateWear2() : void
        {
            this.guides[GuideType.FateWear2] = [[365, 232, GuideDir.Right, fateLang.WearFate2]];
            return;
        }// end function

        public function trackFateWear(param1:int, param2:Sprite) : void
        {
            if (param2 == null)
            {
                return;
            }
            this.track(GuideType.FateWear, param1, param2);
            if (param1 == 2)
            {
                if (this.hasGuide(GuideType.FateWear))
                {
                    this.start(GuideType.FateWear2);
                    this.trackFateWear2(1, param2);
                }
            }
            if (param1 == 3)
            {
                this.setCookie(GuideType.FateWear2);
                this.stop(GuideType.FateWear2);
            }
            return;
        }// end function

        private function trackFateWear2(param1:int, param2:Sprite) : void
        {
            this.track(GuideType.FateWear2, param1, param2);
            return;
        }// end function

        public function stopFateWearGuide() : void
        {
            if (FunctionType.isPlayed(FunctionType.Fate) == false)
            {
                this._view.toolbar.triggerFate();
            }
            if (this.hasGuide(GuideType.FateWear) || this.hasGuide(GuideType.FateLodge))
            {
                _view.setCookie(URI.ip + "Guide" + "_" + this._ctrl.player.playerId + "_" + GuideType.FateLodge, true);
                this.stop(GuideType.FateLodge);
                this.setCookie(GuideType.FateWear);
                this.setCookie(GuideType.FateWear2);
                this.stop(GuideType.FateWear);
                this.stop(GuideType.FateWear2);
            }
            return;
        }// end function

        public function showAloneGuide(param1:Sprite, param2:String, param3:Point, param4:String = "right") : void
        {
            var parent:* = param1;
            var text:* = param2;
            var point:* = param3;
            var dir:* = param4;
            var callback:* = function () : void
            {
                if (hasTrack(GuideType.Upgrade) || hasTrack(GuideType.AutoWay))
                {
                    return;
                }
                if (_guide)
                {
                    parent.addChild(_guide.content);
                    return;
                }
                _guide = new _Guide() as IGuide;
                _guide.text = text;
                _guide.dir = dir;
                _guide.x = point.x;
                _guide.y = point.y;
                parent.addChild(_guide.content);
                return;
            }// end function
            ;
            this.load(callback);
            return;
        }// end function

        public function hideAlongGuide() : void
        {
            if (this._guide && this._guide.content.parent)
            {
                this._guide.content.parent.removeChild(this._guide.content);
            }
            return;
        }// end function

    }
}
