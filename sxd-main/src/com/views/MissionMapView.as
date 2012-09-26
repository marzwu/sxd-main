package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.assist.view.pack.*;
    import com.assist.view.sound.*;
    import com.assist.view.warSoul.*;
    import com.controllers.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import com.views.map.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class MissionMapView extends MapViewBase
    {
        private var _award:IMissionGet;
        private var _chest:IMissionChest;
        private var _Map:IMissionMap;
        private var _monsterList:Array;
        private var _dramaList:Array;
        private var _mInfo:MonsterInfo;
        private var _dramaToWar:Boolean = false;
        private var _warAura:int = 0;
        private var randomItemList:Array;
        private var _warSoul:WarSoul;
        public static var dramaList:Array = [];

        public function MissionMapView()
        {
            this._monsterList = [];
            this._dramaList = [];
            this.randomItemList = new Array();
            _inStageTipTitle = MissionMapViewLang.NoOpen;
            _inStageTipContent = "";
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:* = MapStatic.mapInstance.mission;
            this._Map = MapStatic.mapInstance.mission;
            _mapBase = _loc_1;
            return;
        }// end function

        override public function clear() : void
        {
            super.clear();
            _data.cancelPatch(Mod_Mission_Base.random_item);
            while (this.randomItemList.length > 0)
            {
                
                this.randomItemList.pop();
            }
            _view.missionFailedTips.close();
            this.closeAward();
            _view.war.clearRoles();
            return;
        }// end function

        protected function get ctrlMission() : MissionController
        {
            return _ctrl.mission;
        }// end function

        public function gotoMissionAtId(param1:int) : void
        {
            if (_view.tower.inStageWithTip)
            {
                return;
            }
            _id = param1;
            _playerInfo = ctrlPlayer.playerInfo;
            this.enter_mission(_id);
            return;
        }// end function

        private function parseMissionData() : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            var _loc_4:String = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_8:MonsterInfo = null;
            var _loc_9:ItemBasically = null;
            this._dramaList = [[0]];
            if (this.canPlayDrama(_id, MissionType.getVideoId(_id)) == true)
            {
                this._dramaList[0] = [MissionType.getVideoId(_id), MissionType.getVideoFile(_id)];
            }
            if (dramaList.length > 0)
            {
                this._dramaList[0] = [16777215, dramaList.pop()];
            }
            var _loc_1:* = MissionType.getSences(_id)[0];
            this._monsterList = [];
            for each (_loc_2 in _loc_1.monsters)
            {
                
                _loc_8 = new MonsterInfo();
                _loc_8.x = _loc_2.position_x;
                _loc_8.y = _loc_2.position_y;
                _loc_8.id = _loc_2.id;
                _loc_8.name = _loc_2.monster_name;
                _loc_8.sign = MonsterType.sameResource(_loc_2.monster_sign);
                _loc_8.sayMsg = MonsterType.words(_loc_8.sign);
                this._monsterList.push(_loc_8);
                if (this.canPlayDrama(_id, int(_loc_2.start_video_id)) == true)
                {
                    this._dramaList[0] = [int(_loc_2.start_video_id), _loc_2.start_video_file];
                }
                this._dramaList[_loc_8.id] = [0];
                if (this.canPlayDrama(_id, int(_loc_2.end_video_id)) == true)
                {
                    this._dramaList[_loc_8.id] = [int(_loc_2.end_video_id), _loc_2.end_video_file];
                }
            }
            this._monsterList.sortOn("x", Array.NUMERIC);
            this._mInfo = this._monsterList[0];
            _loc_3 = MissionType.getMissionAwardItems(_id);
            _loc_4 = "";
            _loc_5 = 0;
            for each (_loc_6 in _loc_3)
            {
                
                if (_loc_5 > 0)
                {
                    if ((_loc_5 & 1) == 1)
                    {
                        _loc_4 = _loc_4 + "、";
                    }
                    else
                    {
                        _loc_4 = _loc_4 + "\n";
                    }
                }
                _loc_9 = ItemBasically.getBasic(_loc_6);
                _loc_4 = _loc_4 + HtmlText.format(_loc_9.getItemName(0), _loc_9.getItemColor(0));
                _loc_5++;
            }
            _loc_7 = MissionType.getMissionName(_id);
            if (_loc_5 > 0)
            {
                this._Map.tfName.htmlText = "<a href=\'event:str\'>" + _loc_7 + HtmlText.blue2(" <u>" + MissionMapViewLang.Fall + "</u>") + "</a>";
                _view.tip.iTip.addTarget(this._Map.tfName, _loc_4);
            }
            else
            {
                this._Map.tfName.htmlText = _loc_7;
                _view.tip.iTip.removeTarget(this._Map.tfName);
            }
            getMissionMapInfo(MissionType.getSectionSignByMissionId(_id), _loc_1.map, this.infoComplete);
            return;
        }// end function

        private function canPlayDrama(param1:int, param2:int) : Boolean
        {
            if (param2 == 0)
            {
                return false;
            }
            return MissionType.getVideoLock(param1, param2) > this.ctrlMission.missionLock;
        }// end function

        private function infoComplete(param1:MapInfo) : void
        {
            _info = param1;
            _data.call(Mod_Role_Base.get_role_id_list, this.loadResources, []);
            return;
        }// end function

        private function loadResources() : void
        {
            var res:Array;
            _view.war.missionId = _id;
            _view.war.mainRoleSuffix = _playerInfo.signSuffix;
            res = _view.war.getResourcesUrl();
            res.push(_info.urlMini);
            var errorHandler:* = function (param1:int) : void
            {
                var _loc_2:* = param1 == (res.length - 1) ? ("Can not find MiniMap") : ("Can not find:" + res[param1].replace(/^[\s\S]+\/""^[\s\S]+\//, ""));
                _view.alert.confirm(_loc_2);
                return;
            }// end function
            ;
            File.loadList(res, this.miniMapLoaded, showProgress, null, errorHandler);
            return;
        }// end function

        private function miniMapLoaded(param1:Array) : void
        {
            var _loc_2:* = param1.pop();
            _view.war.resourcesLoaded(param1);
            _content.addChild(this._Map.content);
            this._Map.onCancel = _view.townMap.gotoTownAtId;
            this._Map.onGongLue = this.onGongLue;
            this._Map.initMapinfo(_info);
            this._Map.backMini = _loc_2.loader.content;
            this._Map.onWar = this.onWar;
            this._Map.onMoveTo = this.move_to;
            this._Map.onSound = this.onSound;
            this._Map.onRandomItem = this.onFetchRandomItem;
            _playerInfo.x = 200;
            _playerInfo.y = 420;
            this._Map.addPlayer(_playerInfo);
            this._Map.addMonsters(this._monsterList);
            this._Map.soundState = SoundManage.mute;
            File.loadList([_info.urlMap], this.bgLoad);
            SoundManage.playBgSound(_info.urlSound);
            this.enterMapComplete();
            return;
        }// end function

        private function dramaEnd() : void
        {
            if (_view.drama.toWar == true)
            {
                this.warStart();
            }
            return;
        }// end function

        override protected function enterMapComplete() : void
        {
            var _loc_1:Array = null;
            super.enterMapComplete();
            _ctrl.player.isEnterHeroMission = MissionType.isHeroMission(_id);
            _view.mapSwitched(MapViewBase.Mission);
            for each (_loc_1 in this._dramaList)
            {
                
                if (_loc_1[0] != 0)
                {
                    _view.drama.init(_loc_1[0], _loc_1[1]);
                }
            }
            _loc_1 = this._dramaList[0];
            if (_loc_1[0] != 0)
            {
                _view.drama.playdrama(_loc_1[0], this.dramaEnd, false);
                _loc_1[0] = 0;
            }
            _view.specialPartner.getPartnerInfo();
            return;
        }// end function

        public function randomItem() : void
        {
            if (_ctrl.mission.itemObj.id == 1)
            {
                _ctrl.mission.itemObj.x = 850 + Math.random() * 350;
            }
            else
            {
                _ctrl.mission.itemObj.x = 1400 + Math.random() * 400;
            }
            _ctrl.mission.itemObj.y = 400 + Math.random() * 100;
            this.randomItemList.push(_ctrl.mission.itemObj);
            this.randomItemShow();
            return;
        }// end function

        private function randomItemShow() : void
        {
            this._Map.setRandomItem(_ctrl.mission.itemObj);
            return;
        }// end function

        public function onFetchRandomItem(param1:int) : void
        {
            _data.call(Mod_Mission_Base.fetch_random_item, this.onFetchRandomItemBack, [param1]);
            return;
        }// end function

        public function onFetchRandomItemBack() : void
        {
            if (_ctrl.mission.fetchItemObj.result == Mod_Mission_Base.SUCCESS)
            {
                this._Map.clearRandomItem(_ctrl.mission.fetchItemObj.id);
            }
            return;
        }// end function

        private function onGongLue() : void
        {
            _view.strategy.missionId = _id;
            _view.strategy.monsterTeamId = this._mInfo.id;
            _view.strategy.background = this._Map.getMapWarBG();
            _view.strategy.show();
            return;
        }// end function

        private function onSound(param1:Boolean) : void
        {
            if (param1 == true)
            {
                var _loc_2:int = 1;
                SoundManage.mute = 1;
                this._Map.soundState = _loc_2;
            }
            else
            {
                var _loc_2:int = 0;
                SoundManage.mute = 0;
                this._Map.soundState = _loc_2;
            }
            return;
        }// end function

        private function bgLoad(param1:Array) : void
        {
            if (inStage == false)
            {
                return;
            }
            this._Map.backSWF = param1[0].loader.content as IMapSWF;
            return;
        }// end function

        public function change_equip_main() : void
        {
            if (inStage == false)
            {
                return;
            }
            _mapBase.updateBodyUrl(_playerInfo.id);
            return;
        }// end function

        private function onWar() : void
        {
            closePractice(true);
            MouseCursor.show();
            this.warStart(false);
            return;
        }// end function

        private function warStart(param1:Boolean = true) : void
        {
            SoundManage.playBgSound("");
            _view.war.isBoss = false;
            _view.war.isLastMonster = this._monsterList.length == 1;
            _view.war.background = this._Map.getMapWarBG();
            _view.war.monsterTeamId = this._mInfo.id;
            _view.war.onClose = this.warClose;
            _view.war.onAfterAdded = this.onAfterAdded;
            _view.war.show();
            this._dramaToWar = param1;
            return;
        }// end function

        private function onAfterAdded() : void
        {
            _view.drama.dramaClear();
            return;
        }// end function

        private function warClose(param1:Boolean) : void
        {
            var _loc_2:Array = null;
            if (param1)
            {
                this._warAura = this.ctrlMission.warAura;
                _loc_2 = this._dramaList[this._mInfo.id];
                if (_loc_2 && int(_loc_2[0]) != 0)
                {
                    _view.drama.playdrama(_loc_2[0], this.warToNext, false);
                    _loc_2[0] = 0;
                }
                else
                {
                    this.warToNext();
                }
            }
            else
            {
                this._Map.warClose(false);
            }
            SoundManage.playBgSound(_info.urlSound);
            return;
        }// end function

        private function warToNext() : void
        {
            this._monsterList.shift();
            this._Map.warClose(true);
            if (this._dramaToWar)
            {
                this._dramaToWar = false;
                this._Map.movePlayer(_playerInfo.id, this._mInfo.x + 50, this._mInfo.y);
            }
            if (this._monsterList.length == 0)
            {
                _view.missionRank.show();
            }
            else
            {
                this._mInfo = this._monsterList[0];
                if (_ctrl.player.level < 25 && VIPType.check(VIPType.Level4))
                {
                    _view.quest.wayFinding("mission," + _ctrl.player.mapId + "," + _ctrl.mission.missionId);
                }
                this.checkShowWarAura();
            }
            return;
        }// end function

        private function checkShowWarAura() : void
        {
            if (this._warAura > 200)
            {
                this._Map.showWarSoul(12, _view.war.auraClass, _view.war.fusionClass);
                setTimeout(showTextEffect, 3000, MissionMapViewLang.WuHun + " +" + this._warAura, 41193);
            }
            else if (this._warAura > 0)
            {
                this._Map.showWarSoul(6, _view.war.auraClass, _view.war.fusionClass);
                setTimeout(showTextEffect, 2000, MissionMapViewLang.WuHun + " +" + this._warAura, 41193);
            }
            return;
        }// end function

        public function testMC() : void
        {
            this.showWarSoul(6, _view.war.auraClass, _view.war.fusionClass);
            return;
        }// end function

        public function showWarSoul(param1:int, param2:Class, param3:Class) : void
        {
            if (param1 < 1)
            {
                return;
            }
            this._warSoul = this._warSoul || new WarSoul();
            _content.addChild(this._warSoul);
            this._warSoul.getSoulTarget(param2);
            this._warSoul.lightTarget(param3);
            this._warSoul.getSoulNum(param1);
            this._warSoul.getStartPoint(new Point(500, 500));
            this._warSoul.getEndPoint(new Point(200, 200));
            this._warSoul.mcPlay();
            return;
        }// end function

        public function gotoNearMonster() : void
        {
            this._Map.gotoNearMonster();
            return;
        }// end function

        public function showChest() : void
        {
            this.get_award_list();
            if (this._award == null)
            {
                this._award = _view.getAssetsObject("MissionRank", "MCMissionGet") as IMissionGet;
            }
            this._award.onPickupClose = this.closeAward;
            this._award.onPickup = this.pickup_award;
            if (this._chest == null)
            {
                this._chest = _view.getAssetsObject("MissionRank", "MCMissionChest") as IMissionChest;
                _view.tip.iTip.addTarget(this._chest.content, MissionMapViewLang.Chest);
            }
            this._chest.content.addEventListener(MouseEvent.MOUSE_DOWN, this.chestClick);
            this.checkShowWarAura();
            return;
        }// end function

        private function closeAward() : void
        {
            if (this._award && this._award.content.parent == _content)
            {
                _content.removeChild(this._award.content);
            }
            return;
        }// end function

        private function chestClick(event:MouseEvent) : void
        {
            event.stopPropagation();
            event.stopImmediatePropagation();
            this._chest.goto();
            _view.screen.display.addChild(this._award.content);
            _content.addChild(this._award.content);
            this._award.content.x = _view.stage.mouseX - 50;
            this._award.content.y = 100;
            if (this._award.content.x > 620)
            {
                this._award.content.x = 620;
            }
            return;
        }// end function

        override protected function move_to(param1:int, param2:int, param3:int, param4:int) : void
        {
            closePractice(false);
            if (param1 == param3 && param2 == param4)
            {
                endMove();
            }
            else
            {
                startMove(param1, param2, param3, param4);
            }
            return;
        }// end function

        override protected function enter_town() : void
        {
            return;
        }// end function

        override protected function enter_town_back() : void
        {
            return;
        }// end function

        override protected function get_players() : void
        {
            return;
        }// end function

        override protected function get_players_back() : void
        {
            return;
        }// end function

        private function enter_mission(param1:int) : void
        {
            _data.call(Mod_Mission_Base.enter_mission, this.enter_mission_back, [param1], false);
            return;
        }// end function

        private function enter_mission_back() : void
        {
            if (this.ctrlMission.result != Mod_Mission_Base.SUCCESS)
            {
                _view.showTip(MissionMapViewLang.LackStamina, "", TipType.Question);
            }
            else if (this.ctrlMission.missionId == _id)
            {
                _view.screen.currentMap = this;
                _data.patch(Mod_Mission_Base.random_item, this.randomItem);
                _view.initLoading.tip = _loadTips[getTimer() % _loadTips.length];
                _view.initLoading.show();
                _view.initLoading.loading(MissionMapViewLang.Loading);
                MissionType.loadMissionData(_id, this.parseMissionData);
            }
            return;
        }// end function

        private function pickup_award() : void
        {
            this.closeAward();
            _data.call(Mod_Mission_Base.pickup_award, this.pickup_award_back, []);
            return;
        }// end function

        private function pickup_award_back() : void
        {
            var _loc_1:Array = null;
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            if (this.ctrlMission.pickupAward == Mod_Mission_Base.PICKUP_SUCCESS)
            {
                this._Map.removeOtherFlash("chest");
                gotoLastMap();
            }
            else
            {
                _view.showTip(MissionMapViewLang.Full);
                _content.addChild(this._award.content);
                _loc_1 = this.ctrlMission.awardlist;
                _loc_2 = this._award.boxList;
                _loc_3 = 0;
                while (_loc_3 < 3)
                {
                    
                    _loc_4 = _loc_2[_loc_3];
                    _loc_5 = _loc_1[_loc_3];
                    if (_loc_5 == null || _loc_5.tip == null)
                    {
                        _loc_4.reset();
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function get_award_list() : void
        {
            _data.call(Mod_Mission_Base.open_box, this.get_award_list_back, [], false);
            return;
        }// end function

        private function get_award_list_back() : void
        {
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            if (inStage == false)
            {
                return;
            }
            this._Map.addOtherFlash("chest", this._chest.content, this._mInfo.x, this._mInfo.y);
            this._chest.initChest();
            var _loc_1:* = this.ctrlMission.awardlist;
            var _loc_2:* = this._award.boxList;
            var _loc_3:int = 0;
            while (_loc_3 < 3)
            {
                
                _loc_4 = _loc_2[_loc_3];
                _loc_5 = _loc_1[_loc_3];
                _loc_4.reset();
                _view.tip.iTip.removeTarget(_loc_4 as Sprite);
                if (_loc_5 != null)
                {
                    _loc_4.init(_loc_5.url, _loc_5.num, _loc_5.name);
                    if (_loc_5.tip != null)
                    {
                        _view.tip.iTip.addTarget(_loc_4 as Sprite, _loc_5.tip);
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

    }
}
