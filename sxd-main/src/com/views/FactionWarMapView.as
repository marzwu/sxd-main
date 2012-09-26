package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.factionWar.*;
    import com.assist.view.map.*;
    import com.assist.view.sound.*;
    import com.controllers.*;
    import com.haloer.display.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import com.views.map.*;
    import flash.display.*;
    import flash.utils.*;

    public class FactionWarMapView extends MapViewBase
    {
        private var _Map:IFactionWarMap;
        private var _factionMsg:IFactionMapMsg;
        private var _inWar:Boolean = false;
        private var _zhanbaoList:Array;
        private var _zhanbaoTime:int = 0;
        private var autoOutTime:int = 16777215;

        public function FactionWarMapView()
        {
            this._zhanbaoList = [];
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:* = MapStatic.mapInstance.faction;
            this._Map = MapStatic.mapInstance.faction;
            _mapBase = _loc_1;
            return;
        }// end function

        override public function clear() : void
        {
            super.clear();
            _data.cancelPatch(Mod_FactionWar_Base.send_versus_fight_data);
            _data.cancelPatch(Mod_FactionWar_Base.notify_round_over);
            this._zhanbaoList = [];
            return;
        }// end function

        private function get ctrlWar() : FactionWarMapController
        {
            return _ctrl.factionWarMap;
        }// end function

        public function gotoFactionWar() : void
        {
            if (inStage == true)
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
            if (_view.getPeach.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            _inStageTipTitle = FactionWarMapViewLang.inFactionWar;
            _inStageTipContent = "";
            _id = this.ctrlWar.warTownId;
            _view.screen.currentMap = this;
            _view.initLoading.tip = _loadTips[getTimer() % _loadTips.length];
            _view.initLoading.show();
            _view.initLoading.loading1(FactionWarMapViewLang.LoadingTip);
            this.enter_town();
            return;
        }// end function

        private function infoComplete(param1:MapInfo) : void
        {
            _info = param1;
            var _loc_2:Array = [_info.urlMini];
            if (this._factionMsg == null)
            {
                _loc_2.push(URI.assetsUrl + "faction_map_msg.swf");
            }
            File.loadList(_loc_2, this.miniMapLoaded);
            return;
        }// end function

        private function miniMapLoaded(param1:Array) : void
        {
            if (this._factionMsg == null)
            {
                this._factionMsg = (param1[1] as File).getClassObject("MCFactionMapMsg") as IFactionMapMsg;
            }
            _content.addChild(this._Map.content);
            _content.addChild(this._factionMsg.content);
            this._factionMsg.reset();
            this._factionMsg.onRankOK = this.onCancel;
            this._factionMsg.onCancel = this.onCancel;
            this._factionMsg.onCup = this.onCup;
            var _loc_2:* = this.ctrlWar.warMapList;
            this._factionMsg.TFLv1 = _loc_2[0].lv;
            this._factionMsg.TFName1 = _loc_2[0].name;
            this._factionMsg.TFNum1 = 0;
            this._factionMsg.TFLv2 = _loc_2[1].lv;
            this._factionMsg.TFName2 = _loc_2[1].name;
            this._factionMsg.TFNum2 = 0;
            this._factionMsg.factionCount = this.ctrlWar.roundWarIdx;
            this._factionMsg.addMsgShow(Lang.sprintf(FactionWarMapViewLang.AddFactionWarMap, htmlFormat(_playerInfo.name, 12, _playerInfo.nameColor)));
            this._Map.backMini = param1[0].loader.content as Bitmap;
            this._Map.onMoveTo = move_to;
            this._Map.onWar = this.onWar;
            this._Map.initMapinfo(_info);
            this._Map.initFactionList(_loc_2);
            this._Map.addPlayer(_playerInfo);
            File.loadList([_info.urlMap], this.bgLoadedHandler);
            this.enterMapComplete();
            return;
        }// end function

        private function bgLoadedHandler(param1:Array) : void
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
            _view.mapSwitched(MapViewBase.FactionWar);
            _view.addToTimerProcessList(this + "", this.timerProcess);
            _view.miniFactionWar.startPreload();
            _data.patch(Mod_FactionWar_Base.send_versus_fight_data, this.send_versus_fight_data_back);
            _data.patch(Mod_FactionWar_Base.notify_round_over, this.notify_round_over_back);
            get_players();
            SoundManage.playBgSound(URI.mapUrl + "sound/FactionWarMap2.mp3");
            this._inWar = false;
            this.updateWarTipMsg();
            return;
        }// end function

        private function timerProcess() : void
        {
            var _loc_2:Object = null;
            if (inStage == false)
            {
                return;
            }
            var _loc_1:* = this.ctrlWar.warStatusList;
            for each (_loc_2 in _loc_1)
            {
                
                if (_loc_2.time == 0)
                {
                    _loc_2.aInfo.warState = 2;
                    _loc_2.bInfo.warState = 2;
                    this._Map.updatePlayerWarState(_loc_2.aInfo.id);
                    this._Map.updatePlayerWarState(_loc_2.bInfo.id);
                    continue;
                }
                this._zhanbaoList.push(_loc_2);
            }
            if (this._zhanbaoList.length == 0)
            {
                this._zhanbaoTime = getTimer();
            }
            else if (this._zhanbaoTime == -1)
            {
                while (this._zhanbaoList.length > 0)
                {
                    
                    _loc_2 = this._zhanbaoList.shift();
                    _loc_2.aInfo.warState = _loc_2.aSate;
                    _loc_2.bInfo.warState = _loc_2.bSate;
                    this._Map.updatePlayerWarState(_loc_2.aInfo.id);
                    this._Map.updatePlayerWarState(_loc_2.bInfo.id);
                    this._factionMsg.addMsgShow(_loc_2.msg);
                }
                this.updateWarPlayerNum();
            }
            else if (this._zhanbaoTime + 3000 < getTimer())
            {
                this._zhanbaoTime = getTimer();
                _loc_2 = this._zhanbaoList.shift();
                _loc_2.aInfo.warState = _loc_2.aSate;
                _loc_2.bInfo.warState = _loc_2.bSate;
                this._Map.updatePlayerWarState(_loc_2.aInfo.id);
                this._Map.updatePlayerWarState(_loc_2.bInfo.id);
                this._factionMsg.addMsgShow(_loc_2.msg);
                this.updateWarPlayerNum();
            }
            return;
        }// end function

        private function onCancel() : void
        {
            this.autoOutTime = 16777215;
            _view.removeFromTimerProcessList("FactionWarMapViewTimeOut");
            gotoLastMap();
            return;
        }// end function

        private function onCup() : void
        {
            _view.factionTable.show();
            return;
        }// end function

        public function updateWarTipMsg() : void
        {
            var _loc_1:Image = null;
            if (inStage == false)
            {
                return;
            }
            if (this.ctrlWar.intoTime > 0)
            {
                this._factionMsg.toWait(this.ctrlWar.intoTime);
            }
            else
            {
                this._factionMsg.toWar(this.ctrlWar.warTime);
                this._Map.startFactionWar();
                SoundManage.playBgSound(URI.mapUrl + "sound/FactionWarMap1.mp3");
                _popup.closeAll();
                _loc_1 = new Image(MapStatic.FolderEffects + "FactionWarGo.swf");
                _loc_1.mouseChildren = false;
                _loc_1.mouseEnabled = false;
                _content.addChild(_loc_1);
            }
            return;
        }// end function

        private function onWar(param1:PlayerInfo) : void
        {
            _data.call(Mod_FactionWar_Base.fight_player, null, [param1.id]);
            return;
        }// end function

        private function warStart() : void
        {
            this._inWar = true;
            var _loc_1:* = this.ctrlWar.warData;
            var _loc_2:* = this.ctrlWar.awardData;
            _view.miniFactionWar.warData = _loc_1;
            _view.miniFactionWar.onClose = this.warClose;
            _view.miniFactionWar.awardCoin = _loc_2[0];
            _view.miniFactionWar.awardExp = _loc_2[1];
            _view.miniFactionWar.awardFame = _loc_2[2];
            _view.miniFactionWar.show();
            return;
        }// end function

        private function warClose(param1:Boolean) : void
        {
            if (this.ctrlWar.hasWarData)
            {
                this.warStart();
            }
            else
            {
                this._inWar = false;
                this._zhanbaoTime = -1;
            }
            return;
        }// end function

        public function get isFactionWarStart() : Boolean
        {
            if (inStage && this.ctrlWar.intoTime <= 0)
            {
                _view.showTip(FactionWarMapViewLang.Inoperable);
                return true;
            }
            return false;
        }// end function

        private function updateWarPlayerNum() : void
        {
            var _loc_1:* = this.ctrlWar.warMapList;
            var _loc_2:* = _loc_1[0].list.length;
            var _loc_3:* = _loc_1[1].list.length;
            this._factionMsg.TFNum1 = _loc_2;
            this._factionMsg.TFNum2 = _loc_3;
            if (this.ctrlWar.intoTime <= 0)
            {
                if (_loc_2 > _loc_3)
                {
                    this._factionMsg.TopIdx = 1;
                }
                else if (_loc_2 < _loc_3)
                {
                    this._factionMsg.TopIdx = 2;
                }
                else
                {
                    this._factionMsg.TopIdx = 0;
                }
            }
            return;
        }// end function

        public function showWorldNotice(param1:String) : void
        {
            if (this._inWar == false)
            {
                this._view.worldNotice.showMessage(param1);
            }
            else
            {
                setTimeout(this.showWorldNotice, 2000, param1);
            }
            return;
        }// end function

        override protected function enter_town() : void
        {
            super.enter_town();
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
                        this.get_faction_war_info();
                        continue;
                    }
                    _view.alert.confirm(FactionWarMapViewLang.IntoFails, gotoLastMap);
                }
            }
            return;
        }// end function

        override protected function get_players_back() : void
        {
            var _loc_3:PlayerInfo = null;
            var _loc_1:* = ctrlMap.entownList;
            var _loc_2:int = 0;
            for each (_loc_2 in _loc_1)
            {
                
                if (_loc_2 != _playerInfo.id)
                {
                    _loc_3 = ctrlMap.getPlayerInfo(_loc_2);
                    _mapBase.addPlayer(_loc_3);
                    this._factionMsg.addMsgShow(Lang.sprintf(FactionWarMapViewLang.AddFactionWarMap, htmlFormat(_loc_3.name, 12, _loc_3.nameColor)));
                }
            }
            this.updateWarPlayerNum();
            return;
        }// end function

        override protected function leave_town_back() : void
        {
            super.leave_town_back();
            this.updateWarPlayerNum();
            return;
        }// end function

        private function get_faction_war_info() : void
        {
            _data.call(Mod_FactionWar_Base.get_faction_war_info, this.get_faction_war_info_back, []);
            return;
        }// end function

        private function get_faction_war_info_back() : void
        {
            getTownMapInfo(TownType.getSign(_id), this.infoComplete);
            return;
        }// end function

        private function send_versus_fight_data_back() : void
        {
            if (this._inWar == false)
            {
                this.warStart();
                closePractice(true);
                this._Map.stopRun(true);
                MouseCursor.show();
            }
            return;
        }// end function

        private function notify_round_over_back() : void
        {
            if (inStage == false)
            {
                return;
            }
            if (this._inWar == false)
            {
                this._factionMsg.toEnd(_playerInfo.factionId == this.ctrlWar.winId, this.ctrlWar.killRank);
            }
            else
            {
                setTimeout(this.notify_round_over_back, 2000);
            }
            if (this.autoOutTime == 16777215)
            {
                this.autoOutTime = getTimer() + 80000;
                _view.addToTimerProcessList("FactionWarMapViewTimeOut", this.FactionWarMapViewTimeOut);
            }
            return;
        }// end function

        private function FactionWarMapViewTimeOut() : void
        {
            if (this.autoOutTime < getTimer())
            {
                this.onCancel();
            }
            return;
        }// end function

    }
}
