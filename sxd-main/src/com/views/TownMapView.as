package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.assist.view.sound.*;
    import com.haloer.data.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import com.views.map.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class TownMapView extends MapViewBase
    {
        private var _Map:ITownMap;
        private const TownSign:String = "TownTimeSign";
        private var _guideLayder:Sprite;
        private var _showAwardSp:Sprite;
        private var _showAwardTF:TextField;
        public var bGuide:Boolean = false;

        public function TownMapView()
        {
            this._guideLayder = new Sprite();
            this._showAwardSp = new Sprite();
            this._showAwardTF = new TextField();
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:* = new TextFormat();
            _loc_1.color = 16777215;
            _loc_1.size = 12;
            _loc_1.leading = 5;
            this._showAwardTF.x = 5;
            this._showAwardTF.defaultTextFormat = _loc_1;
            this._showAwardSp.addChild(this._showAwardTF);
            this._showAwardTF.width = 130;
            this._showAwardTF.height = 90;
            this._showAwardSp.graphics.lineStyle(1, 4012085);
            this._showAwardSp.graphics.moveTo(5, 86);
            this._showAwardSp.graphics.lineTo(125, 86);
            var _loc_2:* = new TextField();
            _loc_2.defaultTextFormat = _loc_1;
            this._showAwardSp.addChild(_loc_2);
            _loc_2.x = 5;
            _loc_2.y = 88;
            _loc_2.height = 25;
            _loc_2.text = TownMapViewLang.ClickGetAward;
            var _loc_3:* = MapStatic.mapInstance.town;
            this._Map = MapStatic.mapInstance.town;
            _mapBase = _loc_3;
            this._Map.upTipLayer = _structure.content;
            return;
        }// end function

        public function get guideLayder() : Sprite
        {
            return this._guideLayder;
        }// end function

        public function get townSign() : String
        {
            return TownType.getSign(_id);
        }// end function

        public function gotoTownAtId(param1:int = 0) : void
        {
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            _view.screen.currentMap = this;
            _id = param1 || ctrlPlayer.townMapId || 1;
            _view.initLoading.tip = _loadTips[getTimer() % _loadTips.length];
            _view.initLoading.show();
            _view.initLoading.loading1(TownMapViewLang.Tip1);
            this.enter_town();
            return;
        }// end function

        private function infoComplete(param1:MapInfo) : void
        {
            _info = param1;
            _view.initLoading.loading1(TownMapViewLang.Tip2);
            File.loadList([_info.urlMini], this.miniMapLoaded);
            return;
        }// end function

        private function miniMapLoaded(param1:Array) : void
        {
            var _loc_3:String = null;
            var _loc_4:PortalInfo = null;
            var _loc_5:BuildInfo = null;
            var _loc_6:NPCInfo = null;
            _content.addChild(this._Map.content);
            _content.addChild(this._guideLayder);
            this._Map.backMini = param1[0].loader.content;
            this._Map.onMoveTo = move_to;
            this._Map.onNpcSpeak = this.onNpcSpeak;
            this._Map.onBuildClick = this.onBuildClick;
            this._Map.onPortal = this.onPortal;
            this._Map.onNpcRange = this.onNpcRange;
            this._Map.onMapClick = this.onMapClick;
            this._Map.onUpdateXY = this.onUpdateXY;
            this._Map.onWarFactionMonster = this.onWarFactionMonster;
            this._Map.initMapinfo(_info);
            var _loc_2:* = TownType.getNPCList(_id);
            for (_loc_3 in _loc_2)
            {
                
                _loc_2[_loc_3].sign = _loc_3;
                _loc_6 = new NPCInfo(_loc_2[_loc_3]);
                if (_loc_6.type != NPCType.FactionGodNPC)
                {
                    this._Map.addNPC(_loc_6);
                }
            }
            for each (_loc_4 in _info.portals)
            {
                
                this._Map.addPortal(_loc_4);
            }
            for each (_loc_5 in _info.builds)
            {
                
                this._Map.addBuild(_loc_5);
            }
            this._Map.addPlayer(_playerInfo);
            this._Map.updateNpcLoack(_ctrl.player.functionLock);
            SoundManage.playBgSound(_info.urlSound);
            File.loadList([_info.urlMap], this.bgLoadedHandler(_id));
            this.enterMapComplete();
            return;
        }// end function

        private function bgLoadedHandler(param1:int) : Function
        {
            var townId:* = param1;
            return function (param1:Array) : void
            {
                if (inStage == false)
                {
                    return;
                }
                if (townId == _id)
                {
                    _Map.backSWF = param1[0].loader.content as IMapSWF;
                }
                return;
            }// end function
            ;
        }// end function

        public function quitJiHuiSuo() : void
        {
            if (ctrlPlayer.jihuisuoId != 0)
            {
                this.gotoTownAtId(ctrlPlayer.townMapId);
            }
            return;
        }// end function

        override protected function enterMapComplete() : void
        {
            super.enterMapComplete();
            get_players();
            _view.mapSwitched(MapViewBase.Town);
            _view.toolbar.miniMap.mapName = TownType.getName(_id);
            _view.toolbar.soundMute(SoundManage.mute == 0);
            if (ctrlPlayer.isEnterHeroMission)
            {
                ctrlPlayer.isEnterHeroMission = false;
                _view.heroMission.show();
            }
            if (_id == ctrlPlayer.jihuisuoId)
            {
                if (_ctrl.factionMonster.actityStatus == Mod_FactionMonster_Base.OPEN)
                {
                    this.getFactionMonsterInfo();
                }
                else
                {
                    this._Map.scaleValue = 1;
                    this.getAward();
                }
            }
            else
            {
                this._Map.scaleValue = 1;
            }
            return;
        }// end function

        public function getAward() : void
        {
            if (ActivityType.FactionLevel >= 4 && _id == ctrlPlayer.jihuisuoId)
            {
                _data.call(Mod_FactionMonster_Base.is_can_get_award, this.showAward, []);
            }
            return;
        }// end function

        private function changeTimer() : void
        {
            var _loc_1:* = _ctrl.factionMonster.endTime - _ctrl.player.serverTime;
            if (!this.getBuildTarget(4))
            {
                _view.removeFromTimerProcessList(this.TownSign);
            }
            if (_loc_1 <= 0)
            {
                _view.tip.iTip.removeTarget(this.getBuildTarget(4));
                this.getBuildTarget(4).visible = false;
                _view.removeFromTimerProcessList(this.TownSign);
            }
            var _loc_2:* = DateTime.formatFromSecond(_loc_1);
            this._showAwardTF.htmlText = HtmlText.format(TownMapViewLang.JiTuiJiangLi, HtmlText.Yellow, 16, "", true) + "\n" + HtmlText.white(TownMapViewLang.ShengYuShiJian + " " + _loc_2) + "\n" + HtmlText.white(TownMapViewLang.JiShaZhe) + HtmlText.yellow(TownMapViewLang.QingLongLing) + "\n" + HtmlText.white(TownMapViewLang.XieZhuZhe) + HtmlText.yellow(TownMapViewLang.QingLongLing);
            return;
        }// end function

        private function showAward() : void
        {
            if (!this.getBuildTarget(4))
            {
                return;
            }
            if (ctrlPlayer.jihuisuoId == _id)
            {
                if (_ctrl.factionMonster.bHaveAward)
                {
                    _view.addToTimerProcessList(this.TownSign, this.changeTimer);
                    this.getBuildTarget(4).visible = true;
                    _view.tip.iTip.addTarget(this.getBuildTarget(4), this._showAwardSp);
                }
                else
                {
                    _view.tip.iTip.removeTarget(this.getBuildTarget(4));
                    this.getBuildTarget(4).visible = false;
                }
            }
            return;
        }// end function

        public function resetPlayerScale() : void
        {
            this._Map.scaleValue = 1;
            return;
        }// end function

        public function onWarFactionMonster(param1:int) : void
        {
            var id:* = param1;
            _view.toolbar.checkWarCdTime(function (param1:Boolean) : void
            {
                if (param1 == false)
                {
                    _data.call(Mod_FactionMonster_Base.start_fight, onWarFactionMonsterBack, [id]);
                }
                return;
            }// end function
            , WarCdTimeType.FactionMonsterWar);
            return;
        }// end function

        private function onWarFactionMonsterBack() : void
        {
            if (_ctrl.factionMonster.result != Mod_FactionMonster_Base.SUCCESS)
            {
                return;
            }
            _view.factionMonsterWar.warData = _ctrl.factionMonster.warData;
            _view.factionMonsterWar.onClose = function (param1:Boolean) : void
            {
                _view.chat.resetDepth();
                if (_ctrl.factionMonster.actityStatus == Mod_FactionMonster_Base.CLOSE || _ctrl.factionMonster.actityStatus == Mod_FactionMonster_Base.OVER)
                {
                    _view.toolbar.showFactionMonsterClose();
                }
                return;
            }// end function
            ;
            _view.factionMonsterWar.show();
            return;
        }// end function

        public function getFactionMonsterInfo() : void
        {
            if (ctrlPlayer.jihuisuoId == 0)
            {
                return;
            }
            this._Map.scaleValue = 0.7;
            _data.call(Mod_FactionMonster_Base.get_monster_info, this.getFactionMonsterInfoBack, []);
            return;
        }// end function

        private function getFactionMonsterInfoBack() : void
        {
            var _loc_4:int = 0;
            var _loc_5:Point = null;
            var _loc_6:MonsterInfo = null;
            var _loc_1:Array = [new Point(515, 345), new Point(562, 430), new Point(506, 523), new Point(627, 544), new Point(794, 539), new Point(719, 456), new Point(651, 383), new Point(768, 347), new Point(836, 401), new Point(892, 477)];
            var _loc_2:* = _ctrl.factionMonster.monsterList;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = Math.random() * _loc_1.length;
                _loc_5 = _loc_1[_loc_4];
                _loc_1.splice(_loc_4, 1);
                _loc_6 = new MonsterInfo();
                _loc_6.id = _loc_2[_loc_3];
                _loc_6.sign = FactionMonsterType.getMonsterSignById(_loc_6.id);
                _loc_6.name = FactionMonsterType.getMonsterNameById(_loc_6.id);
                _loc_6.x = _loc_5.x;
                _loc_6.y = _loc_5.y;
                this._Map.addMonster(_loc_6);
                _loc_3++;
            }
            return;
        }// end function

        public function joinFactionMonster() : void
        {
            if (_ctrl.player.jihuisuoId == _id)
            {
                _data.call(Mod_FactionMonster_Base.join, new Function(), []);
            }
            return;
        }// end function

        public function removeAllFactionMonster() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < _ctrl.factionMonster.monsterList.length)
            {
                
                this._Map.removeMonster(_ctrl.factionMonster.monsterList[_loc_1]);
                _loc_1++;
            }
            this._Map.scaleValue = 1;
            return;
        }// end function

        public function removeFactionMonsterById(param1:int) : void
        {
            this._Map.removeMonster(param1);
            return;
        }// end function

        public function playShuShangDrama() : void
        {
            SoundManage.playBgSound("");
            _view.drama.init(16777215, "YuJianFeiXing.xml");
            _view.drama.playdrama(16777215, this.dramaEnd, true, 50);
            return;
        }// end function

        private function dramaEnd() : void
        {
            this.gotoTownAtId(TownType.getId(TownType.ShuShanCheng));
            return;
        }// end function

        public function playWoLongDrama() : void
        {
            SoundManage.playBgSound("");
            _view.drama.init(16777215, "LongXiaoJiuTian.xml");
            _view.drama.playdrama(16777215, this.woLongDramaEnd, true, 50);
            return;
        }// end function

        private function woLongDramaEnd() : void
        {
            _view.newWorld.firstUse = true;
            _view.newWorld.show();
            return;
        }// end function

        protected function onMapClick(param1:Object, param2:int, param3:int) : void
        {
            _view.otherHead.info = param1 as PlayerInfo;
            _view.otherHead.show();
            _view.quest.haltWayFinding();
            return;
        }// end function

        private function onUpdateXY(param1:int, param2:int) : void
        {
            this._guideLayder.x = -param1;
            this._guideLayder.y = -param2;
            return;
        }// end function

        private function onPortal(param1:PortalInfo) : void
        {
            if (_view.tower.inStage)
            {
                return;
            }
            if (_view.serverWarCup.inStage)
            {
                return;
            }
            if (ctrlPlayer.jihuisuoId != 0)
            {
                this.gotoTownAtId(ctrlPlayer.townMapId);
            }
            else
            {
                _view.chooseMission.show();
            }
            _view.quest.finishWayFinding();
            return;
        }// end function

        public function moveToPortal(param1:Boolean = false) : void
        {
            if (inStage == false)
            {
                return;
            }
            this._Map.moveToPortal(param1);
            return;
        }// end function

        private function onNpcSpeak(param1:NPCInfo) : void
        {
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (this.bGuide && param1.sign == NPCType.LuWu)
            {
                _view.npcDialog.guideCallBack = this.openSealShop;
            }
            _view.npcDialog.townNPCId = param1.id;
            _view.npcDialog.npcSign = param1.sign;
            _view.npcDialog.switchSelf();
            this.bGuide = false;
            return;
        }// end function

        private function openSealShop() : void
        {
            _view.npcDialog.guideCallBack = null;
            _view.sealShop.bFirstFlag = true;
            _view.sealShop.npcId = _view.npcDialog.townNPCId;
            _view.sealShop.show();
            return;
        }// end function

        private function onBuildClick(param1:BuildInfo) : void
        {
            if (param1.id == 1)
            {
                _view.factionBlessing.show();
            }
            else if (param1.id == 2)
            {
                _view.factionEat.joinEat();
            }
            else if (param1.id == 3)
            {
                _view.factionRollCake.switchSelf();
            }
            else if (param1.id == 4)
            {
                if (_ctrl.player.packNum <= 0)
                {
                    _view.showTip(TownMapViewLang.PageFull);
                    return;
                }
                _data.call(Mod_FactionMonster_Base.get_award, this.receiveAward, []);
            }
            else if (param1.id == 7)
            {
                _view.buildSendItem.show();
            }
            return;
        }// end function

        private function receiveAward() : void
        {
            var _loc_1:ItemInfo = null;
            switch(_ctrl.factionMonster.myAwardObj.result)
            {
                case Mod_FactionMonster_Base.SUCCESS:
                {
                    _view.activities.showWinEffect();
                    _loc_1 = new ItemInfo();
                    _loc_1.parseSee(_ctrl.factionMonster.myAwardObj.itemId);
                    this._view.alert.iAlert.yesLabel = TownMapViewLang.Sure;
                    this._view.alert.iAlert.show(Lang.sprintf(TownMapViewLang.GetAwardSecces, _ctrl.factionMonster.myAwardObj.itemNum, HtmlText.yellow(_loc_1.name)), AlertButtonType.Yes);
                    _view.tip.iTip.removeTarget(this.getBuildTarget(4));
                    this.getBuildTarget(4).visible = false;
                    _view.removeFromTimerProcessList(this.TownSign);
                    break;
                }
                case Mod_FactionMonster_Base.FULL_BAG:
                {
                    _view.showTip(TownMapViewLang.PageFull);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function coinsString(param1:Number) : String
        {
            if (param1 >= 1000000000)
            {
                return int(param1 / 100000000) + TownMapViewLang.Yi;
            }
            if (param1 >= 100000)
            {
                return int(param1 / 10000) + TownMapViewLang.Wang;
            }
            return param1.toString();
        }// end function

        private function hiddenBuild(param1:uint) : void
        {
            _view.tip.iTip.removeTarget(_view.townMap.getBuildTarget(4));
            this.getBuildTarget(4).visible = false;
            return;
        }// end function

        public function setBuildGetVisible(param1:int, param2:Boolean) : void
        {
            this._Map.setBuildGetVisible(param1, param2);
            return;
        }// end function

        public function getBuildTarget(param1:int) : Sprite
        {
            return this._Map.getBuildTarget(param1);
        }// end function

        private function onNpcRange(param1:NPCInfo) : void
        {
            var _loc_2:* = _view.npcDialog;
            if (param1 == null || _loc_2.townNPCId != param1.id)
            {
                _loc_2.close();
            }
            return;
        }// end function

        public function moveJiHuiSuoNpc(param1:int) : void
        {
            var callback:Function;
            var npcId:* = param1;
            if (_ctrl.player.jihuisuoId != 0)
            {
                this.moveToNPCAtId(npcId);
            }
            else
            {
                callback = function () : void
            {
                moveToNPCAtId(npcId);
                return;
            }// end function
            ;
                _view.delayExecute(DelayType.WayFinding, callback);
                _view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
            }
            return;
        }// end function

        public function moveToNPCAtId(param1:int) : void
        {
            if (inStage == false)
            {
                return;
            }
            this._Map.moveToNPCAtId(param1);
            return;
        }// end function

        public function moveToNPCByTownIdAndNpcId(param1:int, param2:int) : void
        {
            var callback:Function;
            var townId:* = param1;
            var npcId:* = param2;
            if (townId == _ctrl.player.townMapId && _ctrl.player.jihuisuoId == 0)
            {
                this.moveToNPCAtId(npcId);
            }
            else
            {
                callback = function () : void
            {
                if (townId == _ctrl.player.townMapId)
                {
                    moveToNPCAtId(npcId);
                }
                return;
            }// end function
            ;
                _view.delayExecute(DelayType.WayFinding, callback);
                this.directEnterTown(townId);
            }
            return;
        }// end function

        public function resetNPCHead(param1:Object) : void
        {
            if (inStage == false)
            {
                return;
            }
            this._Map.resetNPCHead(param1);
            return;
        }// end function

        public function moveToBuild(param1:int, param2:int) : void
        {
            var callback:Function;
            var townId:* = param1;
            var buildId:* = param2;
            if (townId == _ctrl.player.townMapId && _ctrl.player.jihuisuoId == 0)
            {
                this.moveToBuildAtId(buildId);
            }
            else
            {
                callback = function () : void
            {
                if (townId == _ctrl.player.townMapId)
                {
                    moveToBuildAtId(buildId);
                }
                return;
            }// end function
            ;
                _view.delayExecute(DelayType.WayFinding, callback);
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

        public function moveToBuildAtId(param1:int) : void
        {
            if (inStage == false)
            {
                return;
            }
            this._Map.moveToBuildId(param1);
            return;
        }// end function

        public function set otherCount(param1:int) : void
        {
            if (inStage == false)
            {
                return;
            }
            this._Map.otherCount = param1;
            return;
        }// end function

        public function otherShow() : void
        {
            if (inStage == false)
            {
                return;
            }
            this._Map.otherVisible = true;
            return;
        }// end function

        public function otherHide() : void
        {
            if (inStage == false)
            {
                return;
            }
            this._Map.otherVisible = false;
            return;
        }// end function

        override protected function enter_town() : void
        {
            super.enter_town();
            var _loc_1:* = TownType.getSign(_id);
            var _loc_2:* = ctrlPlayer.level;
            ctrlMap.maxCount = 500;
            if (_loc_1 == TownType.XiaoYuCun && _loc_2 < 10)
            {
                ctrlMap.maxCount = 70;
            }
            return;
        }// end function

        override protected function enter_town_back() : void
        {
            var _loc_3:PlayerInfo = null;
            var _loc_1:* = ctrlMap.entownList;
            var _loc_2:int = 0;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = ctrlMap.getPlayerInfo(_loc_2);
                if (_playerInfo.id == _loc_2)
                {
                    if (ctrlMap.result == Mod_Town_Base.SUCCESS)
                    {
                        ctrlPlayer.setNewMapId(_id);
                        if (ctrlPlayer.jihuisuoId == _id && ctrlPlayer.isChampion)
                        {
                            getTownMapInfo(TownType.getSign(_id) + "_New", this.infoComplete);
                        }
                        else
                        {
                            getTownMapInfo(TownType.getSign(_id), this.infoComplete);
                        }
                        continue;
                    }
                    _view.alert.confirm(Lang.sprintf(TownMapViewLang.Tip4, TownType.getName(_id)), this.gotoTownAtId);
                }
            }
            return;
        }// end function

    }
}
