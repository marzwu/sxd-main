package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.assist.view.sound.*;
    import com.controllers.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import com.views.map.*;
    import flash.display.*;
    import flash.utils.*;

    public class WorldBossMapView extends MapViewBase
    {
        private var _updateTimeSign:String = "WorldBossMapView_updateTimeSign";
        private var _warTime:int = 0;
        private var _Map:IWorldBossMap;
        private var _bossUI:IWorldBossMapMsg;
        private var _bossInfo:BossInfo;
        private var _closeTip:Array = null;
        private var guwuBtn:DisplayObject;

        public function WorldBossMapView()
        {
            _inStageTipTitle = WorldBossMapViewLang.WorldBossTip;
            _inStageTipContent = "";
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:* = MapStatic.mapInstance.boss;
            this._Map = MapStatic.mapInstance.boss;
            _mapBase = _loc_1;
            return;
        }// end function

        override public function clear() : void
        {
            super.clear();
            _data.cancelPatch(Mod_WorldBoss_Base.hurt_world_boss);
            _data.cancelPatch(Mod_WorldBoss_Base.player_death_cd);
            _data.cancelPatch(Mod_WorldBoss_Base.update_world_boss_position);
            _data.cancelPatch(Mod_WorldBoss_Base.player_world_boss_buff);
            _data.cancelPatch(Mod_WorldBoss_Base.fight_world_boss);
            _view.toolbar.updateWorldBossBuffer(0, MonsterType.BossChiYanShou);
            _view.toolbar.updateWorldBossBuffer(0, MonsterType.BossQingTianMu);
            _view.toolbar.updateWorldBossBuffer(0, MonsterType.BossDaoBaTu);
            _view.removeFromTimerProcessList(this._updateTimeSign);
            this._closeTip = null;
            return;
        }// end function

        private function get ctrlBoss() : WorldBossMapController
        {
            return _ctrl.worldBossMap;
        }// end function

        public function gotoBossTown(param1:int) : void
        {
            if (_view.getPeach.inStageWithTip)
            {
                return;
            }
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            _id = param1;
            this._bossInfo = this.ctrlBoss.getBossObjAtTownId(param1);
            this.ctrlBoss.nowBoss = this._bossInfo;
            _view.screen.currentMap = this;
            _view.initLoading.tip = _loadTips[getTimer() % _loadTips.length];
            _view.initLoading.show();
            _view.initLoading.loading1(WorldBossMapViewLang.EnterTownTip);
            this.enter_town();
            return;
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
            _view.worldBossWar.worldBossId = this._bossInfo.bossId;
            _view.worldBossWar.mainRoleSuffix = _playerInfo.signSuffix;
            res = _view.worldBossWar.getResourcesUrl();
            var errorHandler:* = function (param1:int) : void
            {
                var _loc_2:* = param1 == (res.length - 1) ? ("Can not find MiniMap") : ("Can not find:" + res[param1].replace(/^[\s\S]+\/""^[\s\S]+\//, ""));
                _view.alert.confirm(_loc_2);
                return;
            }// end function
            ;
            var oneComplete:* = function (param1:int, param2:Boolean) : void
            {
                return;
            }// end function
            ;
            res.push(_info.urlMini);
            res.push(URI.assetsUrl + "world_boss_msg.swf");
            res.push(URI.screenUrl + "stand/" + this._bossInfo.sign + ".swf");
            File.loadList(res, this.miniMapLoaded, showProgress, oneComplete, errorHandler);
            return;
        }// end function

        private function miniMapLoaded(param1:Array) : void
        {
            param1.pop();
            var _loc_2:* = param1.pop();
            var _loc_3:* = param1.pop();
            _view.worldBossWar.resourcesLoaded(param1);
            if (this._bossUI == null)
            {
                this._bossUI = _loc_2.getClassObject("WorldBossMapUI") as IWorldBossMapMsg;
                this._bossUI.onCancel = this.onCancel;
                this._bossUI.onSkill = this.onSkill;
                this._bossUI.onIngot = this.onIngot;
                this._bossUI.onReset = this.onReset;
                this._bossUI.onClearCd = this.onFuHuo;
                this._bossUI.onTip = this.onTip;
            }
            _content.addChild(this._Map.content);
            _content.addChild(this._bossUI.content);
            this._bossUI.reset(ctrlPlayer.level, ctrlPlayer.vipLevel, this._bossInfo.bossId, "<b>" + Lang.sprintf(WorldBossMapViewLang.Lv, this._bossInfo.name, this._bossInfo.lv) + "</b>");
            this._bossUI.liftMax = this._bossInfo.lifeMax;
            this._bossUI.lift = this._bossInfo.life;
            this._Map.backMini = _loc_3.bitmap;
            this._Map.onMoveTo = move_to;
            this._Map.onWar = this.onWar;
            this._Map.initMapinfo(_info);
            this._Map.addMonster(this._bossInfo);
            this._Map.addPlayer(_playerInfo);
            this.updatePlayerState();
            File.loadList([_info.urlMap], this.bgLoad);
            this.enterMapComplete();
            return;
        }// end function

        private function updateGuWuTip() : void
        {
            if (this._bossInfo.guwu != 0)
            {
                this._bossUI.guwuString = Lang.sprintf(WorldBossMapViewLang.Inspire, this._bossInfo.guwu);
            }
            else
            {
                this._bossUI.guwuString = "";
            }
            _view.tip.iTip.addTarget(this._bossUI.btnIngot, HtmlText.yellow2(WorldBossMapViewLang.InspireTip));
            _view.tip.iTip.addTarget(this._bossUI.btnSkill, Lang.sprintf(WorldBossMapViewLang.InspireAdd, ctrlPlayer.skill));
            _view.tip.iTip.addTarget(this._bossUI.btnReset, HtmlText.yellow2(Lang.sprintf(WorldBossMapViewLang.ResetTip, this._bossInfo.resetIngot + WorldBossMapViewLang.Ingot, this._bossInfo.resetCount)));
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

        override protected function enterMapComplete() : void
        {
            super.enterMapComplete();
            _view.mapSwitched(MapViewBase.WorldBoss);
            _view.toolbar.updateWorldBossBuffer(this._bossInfo.guwu, this._bossInfo.sign);
            _view.addToTimerProcessList(this._updateTimeSign, this.updateTime);
            this.updateGuWuTip();
            this.updateTime();
            SoundManage.playBgSound(_info.urlSound);
            get_players();
            _data.patch(Mod_WorldBoss_Base.hurt_world_boss, this.hurt_world_boss_back);
            _data.patch(Mod_WorldBoss_Base.update_world_boss_position, this.update_world_boss_position_back);
            _data.patch(Mod_WorldBoss_Base.player_death_cd, this.player_death_cd_back);
            _data.patch(Mod_WorldBoss_Base.player_world_boss_buff, this.player_world_boss_buff_back);
            _data.patch(Mod_WorldBoss_Base.fight_world_boss, this.fight_world_boss_back);
            return;
        }// end function

        private function onSkill() : void
        {
            checkBoxSelect1("BossCookie2", WorldBossMapViewLang.SkillToWar, this.strengthen_combat_0);
            return;
        }// end function

        private function onIngot() : void
        {
            checkBoxSelect2(ConsumeAlertSetType.BossCookie3, Lang.sprintf(WorldBossMapViewLang.SkillToWarAsk, HtmlText.yellow2("20" + WorldBossMapViewLang.Ingot)), this.strengthen_combat_1);
            return;
        }// end function

        private function onReset() : void
        {
            if (this._bossInfo.resetCount == 0)
            {
                _view.showTip(WorldBossMapViewLang.ResetOver);
            }
            else if (this._bossInfo.state == 4)
            {
                _view.showTip(WorldBossMapViewLang.ChallengeFails);
            }
            else
            {
                checkBoxSelect2(ConsumeAlertSetType.BossCookie4, Lang.sprintf(WorldBossMapViewLang.ResetToWarAsk, HtmlText.yellow2(this._bossInfo.resetIngot + WorldBossMapViewLang.Ingot)), this.super_reborn);
            }
            return;
        }// end function

        private function onFuHuo() : void
        {
            checkBoxSelect2(ConsumeAlertSetType.BossCookie1, Lang.sprintf(WorldBossMapViewLang.ReviveAsk, HtmlText.yellow2("2" + WorldBossMapViewLang.Ingot)), this.clear_death_cd);
            return;
        }// end function

        private function onCancel() : void
        {
            _view.townMap.gotoTownAtId();
            return;
        }// end function

        private function get canToWar() : Boolean
        {
            if (_view.worldBossWar.opened == true)
            {
                return false;
            }
            if (this._bossInfo.state != 1)
            {
                return false;
            }
            if (getTimer() - this._warTime < 4000)
            {
                return false;
            }
            return true;
        }// end function

        private function onWar(param1:Boolean = true) : void
        {
            if (_playerInfo.warState != 0)
            {
                return;
            }
            if (this.canToWar == false)
            {
                return;
            }
            closePractice(true);
            MouseCursor.show();
            if (param1 == true)
            {
                this.fight_world_boss();
            }
            return;
        }// end function

        private function onWarClose(param1:Boolean) : void
        {
            this._Map.warClose(param1);
            SoundManage.playBgSound(_info.urlSound);
            return;
        }// end function

        public function updateBossOpen() : void
        {
            if (inStage == false)
            {
                return;
            }
            if (this.ctrlBoss.notifyBoss.bossId != this._bossInfo.bossId)
            {
                return;
            }
            this._data.call(Mod_WorldBoss_Base.get_world_boss_data, null, []);
            return;
        }// end function

        public function updateBossOver() : void
        {
            if (inStage == false || this.ctrlBoss.notifyBoss.bossId != this._bossInfo.bossId)
            {
                _view.worldNotice.showMessage(this.ctrlBoss.notifyBoss.worldTips);
            }
            else
            {
                this._bossUI.lift = 0;
                this._Map.bossKill();
                this._closeTip = [this.ctrlBoss.notifyBoss.worldTips, WorldBossMapViewLang.BossOver];
            }
            return;
        }// end function

        public function updateBossKill() : void
        {
            if (inStage == false || this.ctrlBoss.notifyBoss.bossId != this._bossInfo.bossId)
            {
                _view.worldNotice.showMessage(this.ctrlBoss.notifyBoss.worldTips);
            }
            else
            {
                this._bossUI.lift = 0;
                this._Map.bossKill();
                this._closeTip = [this.ctrlBoss.notifyBoss.worldTips, WorldBossMapViewLang.BossKill];
            }
            return;
        }// end function

        public function timeFormat(param1:int) : String
        {
            if (param1 <= 0)
            {
                return "00:00:00";
            }
            var _loc_2:* = param1 / 60;
            param1 = param1 % 60;
            var _loc_3:* = _loc_2 / 60;
            _loc_2 = _loc_2 % 60;
            if (_loc_3 > 0)
            {
                return _loc_3 + ":" + (_loc_2 > 9 ? (_loc_2) : ("0" + _loc_2)) + ":" + (param1 > 9 ? (param1) : ("0" + param1));
            }
            return (_loc_2 > 9 ? (_loc_2) : ("0" + _loc_2)) + ":" + (param1 > 9 ? (param1) : ("0" + param1));
        }// end function

        override protected function enter_town() : void
        {
            super.enter_town();
            return;
        }// end function

        override protected function enter_town_back() : void
        {
            var _loc_3:PlayerInfo = null;
            super.enter_town_back();
            var _loc_1:* = ctrlMap.entownList;
            var _loc_2:int = 0;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = ctrlMap.getPlayerInfo(_loc_2);
                if (_playerInfo.id == _loc_2)
                {
                    if (ctrlMap.result == Mod_Town_Base.SUCCESS)
                    {
                        if (_loc_3.warState > 0)
                        {
                            _loc_3.warState = getTimer() + _loc_3.warState * 1000;
                            ;
                        }
                        ctrlPlayer.setNewMapId(_id);
                        this.get_world_boss_data();
                        continue;
                    }
                    if (ctrlMap.result == Mod_Town_Base.FULL)
                    {
                        _view.alert.confirm(WorldBossMapViewLang.PeopleFull, gotoLastMap);
                        continue;
                    }
                    if (ctrlMap.result == Mod_Town_Base.NOT_ENOUGH_INGOT)
                    {
                        _view.alert.confirm(WorldBossMapViewLang.IngotLack, gotoLastMap);
                        continue;
                    }
                    _view.alert.confirm(WorldBossMapViewLang.BossOver, gotoLastMap);
                }
            }
            return;
        }// end function

        private function get_world_boss_data() : void
        {
            _data.call(Mod_WorldBoss_Base.get_world_boss_data, this.get_world_boss_data_back, []);
            return;
        }// end function

        private function get_world_boss_data_back() : void
        {
            getTownMapInfo(TownType.getSign(_id), this.infoComplete);
            return;
        }// end function

        private function updateTime() : void
        {
            var _loc_1:int = 0;
            this._Map.zhangAiVisible = this._bossInfo.state == 4;
            this._bossUI.timeString = "";
            this._bossUI.msgString = WorldBossMapViewLang.PeopleCount + this.playerCount;
            if (this._bossInfo.state == 1)
            {
                _loc_1 = (this._bossInfo.time - getTimer()) * 0.001;
                this._bossUI.msgString = WorldBossMapViewLang.PeopleCount + this.playerCount + " " + WorldBossMapViewLang.TimeLeft + this.timeFormat(_loc_1);
                this.get_defeat_record_list();
                this.player_count();
                if (this._bossUI.autoType == 1 && _playerInfo.warState == 0 && this.canToWar == true)
                {
                    this._Map.movePlayerToBoss();
                }
            }
            else if (this._bossInfo.state == 4)
            {
                this.player_count();
                _loc_1 = (this._bossInfo.time - getTimer()) * 0.001;
                this._bossUI.timeString = htmlFormat(WorldBossMapViewLang.About, 16, 15658734, true) + "\n" + htmlFormat(this.timeFormat(_loc_1), 30, 15658734, true);
            }
            else if (this._closeTip && _view.worldBossWar.opened == false && getTimer() - this._warTime > 2000)
            {
                _view.worldNotice.showMessage(this._closeTip[0]);
                _view.alert.confirm(this._closeTip[1], gotoLastMap);
                this._closeTip = null;
            }
            var _loc_2:* = _playerInfo.warState - getTimer();
            _loc_2 = int(_loc_2 * 0.001 + 0.5);
            if (_loc_2 <= 0)
            {
                _loc_2 = 0;
            }
            var _loc_3:* = _loc_2 + WorldBossMapViewLang.cdStr;
            this._bossUI.cdString = _loc_3;
            return;
        }// end function

        private function player_count() : void
        {
            if (this._bossInfo.bossId == BossInfo.BossDaoBaTu)
            {
                return;
            }
            _data.call(Mod_Town_Base.player_count, null, []);
            return;
        }// end function

        private function get playerCount() : int
        {
            if (this._bossInfo.bossId != BossInfo.BossDaoBaTu)
            {
                return ctrlMap.playercount;
            }
            return ctrlMap.count;
        }// end function

        public function player_world_boss_buff_back() : void
        {
            _view.toolbar.updateWorldBossBuffer(this._bossInfo.guwu, this._bossInfo.sign);
            this.updateGuWuTip();
            return;
        }// end function

        private function get_defeat_record_list() : void
        {
            _data.call(Mod_WorldBoss_Base.get_defeat_record_list, this.getDefeatRecordList, [this._bossInfo.bossId]);
            return;
        }// end function

        private function getDefeatRecordList() : void
        {
            this._bossUI.killRank = this._bossInfo.recordList;
            return;
        }// end function

        private function hurt_world_boss_back() : void
        {
            if (this._bossInfo.hurtList.length > 0)
            {
                this._bossUI.addHurtList(this._bossInfo.hurtList);
            }
            if (this._bossInfo.life == 1)
            {
                this._bossUI.lift = 1;
            }
            return;
        }// end function

        private function player_death_cd_back() : void
        {
            var _loc_2:Object = null;
            var _loc_3:PlayerInfo = null;
            var _loc_1:* = this._bossInfo.fuhuoList;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = ctrlMap.getPlayerInfo(_loc_2.id);
                _loc_3.warState = _loc_2.time;
                if (_loc_3.isMine && _loc_3.warState > 0 && this._bossUI.autoType == 0)
                {
                    setTimeout(this._Map.updatePlayerState, 3000, _loc_3.id);
                    setTimeout(this.updatePlayerState, 3000);
                    continue;
                }
                this._Map.updatePlayerState(_loc_3.id);
                this.updatePlayerState();
            }
            this._bossInfo.fuhuoList = [];
            return;
        }// end function

        private function clear_death_cd() : void
        {
            _data.call(Mod_WorldBoss_Base.clear_death_cd, this.clear_death_cd_back, []);
            return;
        }// end function

        private function clear_death_cd_back() : void
        {
            var _loc_1:* = this.ctrlBoss.result;
            if (_loc_1 == Mod_WorldBoss_Base.ACTION_SUCCESS)
            {
                _view.showTip(WorldBossMapViewLang.ResetSuccess, "", TipType.Success);
                _playerInfo.warState = 0;
                this._Map.updatePlayerState(_playerInfo.id);
                this.updatePlayerState();
            }
            else if (_loc_1 == Mod_WorldBoss_Base.NOT_ENOUGH_INGOT)
            {
                _view.showTip(WorldBossMapViewLang.IngotLack);
            }
            else
            {
                _view.showTip(WorldBossMapViewLang.Fails);
            }
            return;
        }// end function

        private function updatePlayerState() : void
        {
            this._bossUI.cdShow = _playerInfo.warState != 0;
            return;
        }// end function

        private function update_world_boss_position_back() : void
        {
            this._Map.bossMoveto(this._bossInfo.x, this._bossInfo.y);
            return;
        }// end function

        private function super_reborn() : void
        {
            if (this.canToWar == false)
            {
                return;
            }
            this._warTime = getTimer();
            this._bossUI.autoType = 0;
            _data.call(Mod_WorldBoss_Base.super_reborn, this.super_reborn_back, []);
            return;
        }// end function

        private function super_reborn_back() : void
        {
            if (this.ctrlBoss.result == Mod_WorldBoss_Base.ACTION_SUCCESS)
            {
                this.onWar(false);
            }
            else if (this.ctrlBoss.result == Mod_WorldBoss_Base.ACTION_FAILED)
            {
                _view.showTip(WorldBossMapViewLang.Fails);
            }
            else if (this.ctrlBoss.result == Mod_WorldBoss_Base.NOT_BEGIN)
            {
                _view.showTip(WorldBossMapViewLang.ChallengeFails);
            }
            else if (this.ctrlBoss.result == Mod_WorldBoss_Base.NOT_ENOUGH_INGOT)
            {
                _view.showTip(WorldBossMapViewLang.IngotLack);
            }
            else if (this.ctrlBoss.result == Mod_WorldBoss_Base.MAX_TIMES)
            {
                _view.showTip(WorldBossMapViewLang.ResetOver);
            }
            else
            {
                _view.showTip(WorldBossMapViewLang.BossOver);
            }
            return;
        }// end function

        private function strengthen_combat_0() : void
        {
            this.guwuBtn = this._bossUI.btnSkill;
            _data.call(Mod_WorldBoss_Base.strengthen_combat, this.strengthen_combat_back, [0]);
            return;
        }// end function

        private function strengthen_combat_1() : void
        {
            this.guwuBtn = this._bossUI.btnIngot;
            _data.call(Mod_WorldBoss_Base.strengthen_combat, this.strengthen_combat_back, [1]);
            return;
        }// end function

        private function strengthen_combat_back() : void
        {
            this.updateGuWuTip();
            switch(this.ctrlBoss.result)
            {
                case Mod_WorldBoss_Base.ACTION_SUCCESS:
                {
                    _view.tip.iTip.textTip(this.guwuBtn, WorldBossMapViewLang.InspireSuccess, 16773632);
                    break;
                }
                case Mod_WorldBoss_Base.ACTION_FAILED:
                {
                    _view.tip.iTip.textTip(this.guwuBtn, WorldBossMapViewLang.InspireFails, 16711680);
                    break;
                }
                case Mod_WorldBoss_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(WorldBossMapViewLang.IngotLack);
                    break;
                }
                case Mod_WorldBoss_Base.NOT_ENOUGH_SKILL:
                {
                    _view.showTip(WorldBossMapViewLang.SkillLack);
                    break;
                }
                case Mod_WorldBoss_Base.COMBAT_LIMIT:
                {
                    _view.showTip(WorldBossMapViewLang.Limit);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function fight_world_boss() : void
        {
            this._warTime = getTimer();
            _data.call(Mod_WorldBoss_Base.fight_world_boss, null, [this._bossInfo.bossId]);
            return;
        }// end function

        private function fight_world_boss_back() : void
        {
            switch(this.ctrlBoss.warStatus)
            {
                case Mod_WorldBoss_Base.ACTION_SUCCESS:
                {
                    if (this._bossUI.autoType == 1)
                    {
                        _view.showTip(WorldBossMapViewLang.BossAutoSuccess, null, TipType.Success);
                    }
                    else
                    {
                        _view.worldBossWar.warData = this.ctrlBoss.warData;
                        _view.worldBossWar.background = this._Map.getMapWarBG();
                        _view.worldBossWar.onClose = this.onWarClose;
                        _view.worldBossWar.show();
                    }
                    break;
                }
                case Mod_WorldBoss_Base.NOT_BEGIN:
                {
                    _view.showTip(WorldBossMapViewLang.BossClose);
                    break;
                }
                case Mod_WorldBoss_Base.MISSION_OVER:
                case Mod_WorldBoss_Base.NOT_BEGIN:
                case Mod_WorldBoss_Base.WORLD_BOSS_DEAD:
                {
                    _view.showTip(WorldBossMapViewLang.BossOver);
                    break;
                }
                case Mod_WorldBoss_Base.ACTION_FAILED:
                {
                    _view.showTip(WorldBossMapViewLang.LimitCD);
                    break;
                }
                case Mod_WorldBoss_Base.DEATH_STATUS:
                {
                    _view.showTip(WorldBossMapViewLang.ResetCD);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2 = null) : void
        {
            var _loc_3:Sprite = null;
            if (param2 == "" || param2 == null)
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
                _loc_3 = param1 as Sprite;
            }
            return;
        }// end function

    }
}
