package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.assist.view.sound.*;
    import com.assist.view.toolbar.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import com.views.map.*;
    import flash.display.*;
    import flash.utils.*;

    public class NineRegionsMapView extends MapViewBase
    {
        private var _jieId:int = 0;
        private var _lvId:int = 0;
        private var _warTime:int = 0;
        private var _Map:INineRegionsMap;
        private var _targetUI:IMcNineRegionsMapUi;
        private var _monsterInfo:MonsterInfo;
        private var _closeTip:Array = null;
        private var _tmpRoleList:Array;
        private var _inWar:Boolean = false;

        public function NineRegionsMapView()
        {
            this._monsterInfo = new MonsterInfo();
            this._tmpRoleList = [];
            this.init();
            _inStageTipTitle = NineRegionsMapViewLang.ViewUsing;
            _inStageTipContent = "";
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:* = MapStatic.mapInstance.nineRegionsMap;
            this._Map = MapStatic.mapInstance.nineRegionsMap;
            _mapBase = _loc_1;
            return;
        }// end function

        override public function clear() : void
        {
            super.clear();
            if (this._targetUI)
            {
                this._targetUI.clear();
            }
            _data.cancelPatch(Mod_NineRegions_Base.get_player_team_info);
            _data.cancelPatch(Mod_NineRegions_Base.get_war_result);
            _data.cancelPatch(Mod_NineRegions_Base.notify);
            this._closeTip = null;
            this._inWar = false;
            return;
        }// end function

        public function gotoBossTown(param1:int, param2:int, param3:int = 1, param4:int = 1) : void
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
            this._inWar = false;
            _id = param1;
            this._jieId = param3;
            this._lvId = param4;
            this._monsterInfo = NineRegionsInfo.getMonsterInfoById(param2);
            _view.screen.currentMap = this;
            _view.initLoading.tip = _loadTips[getTimer() % _loadTips.length];
            _view.initLoading.show();
            _view.initLoading.loading1(NineRegionsMapViewLang.EnterTownTip);
            _view.chat.changeChannel(Mod_Chat_Base.ACTIVITY);
            this.enter_town();
            super.enterMapComplete();
            return;
        }// end function

        public function errTip(param1:DisplayObject, param2:Boolean) : void
        {
            if (param2)
            {
                this.onTip(param1, NineRegionsMapViewLang.MustTree);
            }
            else
            {
                this.onTip(param1, "");
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

        private function infoComplete(param1:MapInfo) : void
        {
            _info = param1;
            this.loadResources();
            return;
        }// end function

        private function loadResources() : void
        {
            var res:Array;
            res = new Array();
            res.push(_info.urlMini);
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
            res.push(URI.screenUrl + "stand/" + this._monsterInfo.sign + ".swf");
            res.push(URI.assetsUrl + "nine_regions_map_ui.swf");
            File.loadList(res, this.miniMapLoaded, showProgress, oneComplete, errorHandler);
            MouseCursor.show();
            if (this._jieId * 10 + this._lvId > _ctrl.nineRegions.curJie * 10 + _ctrl.nineRegions.curLevel)
            {
                _view.nineRegionsWar.IsFirst = true;
            }
            else
            {
                _view.nineRegionsWar.IsFirst = false;
            }
            _view.nineRegionsWar.NineId = this._jieId;
            _view.nineRegionsWar.NineLevel = this._lvId;
            return;
        }// end function

        private function onExitSystem() : void
        {
            _data.call(Mod_NineRegions_Base.exit_region_team, this.exit_team_Back, []);
            return;
        }// end function

        private function exit_team_Back() : void
        {
            if (_ctrl.nineRegions.exitFlag == Mod_NineRegions_Base.FAILED)
            {
                return;
            }
            this.closeWindow();
            _view.nineRegions.show();
            return;
        }// end function

        public function closeWindow() : void
        {
            this.clear();
            if (_ctrl.player.jihuisuoId != 0)
            {
                _view.townMap.gotoTownAtId(_ctrl.player.jihuisuoId);
            }
            else
            {
                _view.townMap.gotoTownAtId(ctrlPlayer.townMapId);
            }
            _view.chat.changeChannel();
            _view.quest.finishWayFinding();
            return;
        }// end function

        private function onChangeRole() : void
        {
            _data.call(Mod_NineRegions_Base.get_helper_role_list, this.getMyRoleList, []);
            return;
        }// end function

        private function kicked_out_member(param1:int) : void
        {
            _data.call(Mod_NineRegions_Base.kick_member, null, [param1]);
            return;
        }// end function

        private function onChangeRoleOk(param1:int, param2:int) : void
        {
            _data.call(Mod_NineRegions_Base.choose_helper_role, null, [param1, param2]);
            return;
        }// end function

        private function onSortTeam() : void
        {
            var _loc_1:* = _ctrl.nineRegions.myTeamList;
            if (_loc_1.length != 3)
            {
                return;
            }
            var _loc_2:* = _loc_1[2].playerId + "," + _loc_1[0].playerId + "," + _loc_1[1].playerId;
            _data.call(Mod_NineRegions_Base.sort_region_team, null, [_loc_2]);
            return;
        }// end function

        public function onCallHelp() : void
        {
            var _loc_1:* = NineRegionsType.TeamFull - _ctrl.nineRegions.myTeamList.length;
            if (_loc_1 == 0)
            {
                return;
            }
            var _loc_2:* = TextLinkType.NineRegions + "_" + _ctrl.player.playerId + "_" + _ctrl.player.nickname + "_" + _ctrl.nineRegions.myTeamId + "_" + _loc_1 + "_" + this._jieId + "_" + this._lvId;
            _data.call(Mod_Chat_Base.chat_with_players, new Function(), [Mod_Chat_Base.FACTION, _loc_2, "", ""]);
            return;
        }// end function

        private function miniMapLoaded(param1:Array) : void
        {
            var _loc_5:BuildInfo = null;
            var _loc_6:MovieClip = null;
            var _loc_2:* = param1.pop();
            param1.pop();
            var _loc_3:* = param1.pop();
            if (!this._targetUI)
            {
                this._targetUI = _loc_2.getClassObject("McNineRegionsMapUi") as IMcNineRegionsMapUi;
                this._targetUI.onExit = this.onExitSystem;
                this._targetUI.onChangeRole = this.onChangeRole;
                this._targetUI.onChangeRoleOk = this.onChangeRoleOk;
                this._targetUI.onShowPlayerInfoView = this.showPlayerInfoView;
                this._targetUI.onOutFun = this.kicked_out_member;
                this._targetUI.onSortTeam = this.onSortTeam;
                this._targetUI.onCallHelp = this.onCallHelp;
                _loc_6 = _loc_2.getClassObject("McTeamLeader") as MovieClip;
                this._Map.mcLeader = _loc_6;
            }
            var _loc_4:* = PlayerInfo.info;
            if (PlayerInfo.info)
            {
                this._targetUI.hasFaction = _loc_4.factionId != 0;
            }
            this._targetUI.jieId = this._jieId;
            _content.addChild(this._Map.content);
            _content.addChild(this._targetUI.content);
            this._Map.backMini = _loc_3.bitmap;
            this._Map.onMoveTo = move_to;
            this._Map.onWar = this.onWar;
            this._Map.onMapClick = this.onMapClick;
            this._Map.initMapinfo(_info);
            this._Map.addMonster(this._monsterInfo);
            this._Map.addPlayer(_playerInfo);
            this._Map.errTip = this.errTip;
            this._Map.bossSayContent = NineRegionsType.getMonsterTalkById(this._monsterInfo.id);
            for each (_loc_5 in _info.builds)
            {
                
                this._Map.addBuild(_loc_5);
            }
            File.loadList([_info.urlMap], this.bgLoad);
            this.enterMapComplete();
            this.reposition();
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
            _data.cancelPatch(Mod_Town_Base.player_follow_role_change);
            _data.patch(Mod_NineRegions_Base.get_player_team_info, this.getTeams);
            _data.patch(Mod_NineRegions_Base.notify, this.notifyBack);
            _data.patch(Mod_NineRegions_Base.get_war_result, this.getWarResultCallBack);
            _view.mapSwitched(MapViewBase.NineRegions);
            SoundManage.playBgSound(_info.urlSound);
            this.get_players();
            return;
        }// end function

        override protected function get_players() : void
        {
            super.get_players();
            _data.call(Mod_NineRegions_Base.get_player_team_info, this.getTeams, []);
            return;
        }// end function

        private function getMyRoleList() : void
        {
            if (_ctrl.nineRegions.myRoleList.length == 0)
            {
                _view.showTip(NineRegionsMapViewLang.NoRole);
            }
            this._targetUI.roleList = _ctrl.nineRegions.myRoleList;
            return;
        }// end function

        override protected function get_players_back() : void
        {
            var _loc_3:PlayerInfo = null;
            var _loc_4:Object = null;
            var _loc_1:* = ctrlMap.entownList;
            var _loc_2:int = 0;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = ctrlMap.getPlayerInfo(_loc_2);
                _loc_4 = this.getTmpRole(_loc_3.id);
                if (!this._Map.getPlayerInStage(_loc_3))
                {
                    _loc_3.followRoleId = 0;
                }
                this._Map.addPlayer(_loc_3);
                this._Map.setFollowChange(_loc_4.playerId, _loc_4.roleId);
            }
            setFactionCloth();
            return;
        }// end function

        private function getTeams() : void
        {
            var _loc_3:Object = null;
            var _loc_1:* = _ctrl.nineRegions.myTeamList;
            if (_loc_1.length == 0)
            {
                _view.showTip(NineRegionsMapViewLang.BackTown);
                this.closeWindow();
                return;
            }
            this._targetUI.setTeamInfo(_loc_1);
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = _loc_1[_loc_2];
                this._Map.setFollowChange(_loc_3.playerId, _loc_3.roleId);
                if (_loc_3.playerId == _ctrl.player.playerId && _loc_3.roleId == 0)
                {
                    this.onChangeRole();
                }
                this.pushTmpRole(_loc_3);
                _loc_2++;
            }
            this._Map.leaderId = _ctrl.nineRegions.leaderId;
            this._Map.canWar = _ctrl.nineRegions.canWar;
            return;
        }// end function

        private function pushTmpRole(param1:Object) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this._tmpRoleList.length)
            {
                
                if (this._tmpRoleList[_loc_2].playerId == param1.playerId)
                {
                    this._tmpRoleList[_loc_2] = param1;
                    return;
                }
                _loc_2++;
            }
            this._tmpRoleList.push(param1);
            return;
        }// end function

        private function getTmpRole(param1:int) : Object
        {
            var _loc_2:int = 0;
            while (_loc_2 < this._tmpRoleList.length)
            {
                
                if (param1 == this._tmpRoleList[_loc_2].playerId)
                {
                    return this._tmpRoleList[_loc_2];
                }
                _loc_2++;
            }
            return {playerId:param1, roleId:0};
        }// end function

        public function notifyBack() : void
        {
            var _loc_1:* = _ctrl.nineRegions.notifyValue;
            if (_loc_1 == Mod_NineRegions_Base.UPDATE_TEAM_INFO)
            {
                _data.call(Mod_NineRegions_Base.get_player_team_info, this.getTeams, []);
            }
            else if (_loc_1 == Mod_NineRegions_Base.LEADER_DISSOLVE || _loc_1 == Mod_NineRegions_Base.KICK_OUT_TEAM)
            {
                if (this.inStage && !this._inWar)
                {
                    this.closeWindow();
                }
            }
            return;
        }// end function

        private function showPlayerInfoView(param1:int, param2:String) : void
        {
            if (param1 == _playerInfo.id)
            {
                return;
            }
            _view.otherRoleMsg.init(param1, param2);
            _view.otherRoleMsg.show();
            return;
        }// end function

        private function get canToWar() : Boolean
        {
            if (getTimer() - this._warTime < 4000)
            {
                return false;
            }
            return true;
        }// end function

        private function onWar(param1:int) : void
        {
            if (this.canToWar == false || this._inWar)
            {
                return;
            }
            if (param1 == _ctrl.nineRegions.leaderId && _ctrl.player.playerId == param1)
            {
                if (_ctrl.nineRegions.canWar)
                {
                    this.get_war_result();
                }
                else
                {
                    _view.showTip(NineRegionsMapViewLang.NotEnoughPlayer);
                }
            }
            return;
        }// end function

        private function get_war_result() : void
        {
            this._inWar = true;
            _data.call(Mod_NineRegions_Base.get_war_result, this.getWarResultCallBack, []);
            return;
        }// end function

        private function getWarResultCallBack() : void
        {
            var result:* = _ctrl.nineRegions.warResult;
            if (result == Mod_NineRegions_Base.SUCCESS || result == Mod_NineRegions_Base.CHALLENGE_SUCCESS)
            {
                _view.nineRegionsWar.warData = _ctrl.nineRegions.warData;
                _view.nineRegionsWar.onClose = function (param1:Boolean) : void
            {
                if (param1)
                {
                }
                _view.chat.resetDepth();
                closeWindow();
                _view.nineRegions.show();
                return;
            }// end function
            ;
                _view.nineRegionsWar.show();
            }
            else
            {
                this._inWar = false;
                switch(result)
                {
                    case Mod_NineRegions_Base.LIMIT_MEMBER_NUMBER:
                    {
                        _view.showTip(NineRegionsMapViewLang.NotEnoughPlayer);
                        break;
                    }
                    case Mod_NineRegions_Base.NO_LEADER:
                    {
                        _view.showTip(NineRegionsMapViewLang.NotLeader);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function reposition() : void
        {
            if (!inStage || !this._targetUI)
            {
                return;
            }
            this._targetUI.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            return;
        }// end function

        override protected function enter_town() : void
        {
            super.enter_town();
            getTownMapInfo(TownType.JiuKongWuJie + this._jieId, this.infoComplete);
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
                            continue;
                        }
                    }
                }
            }
            return;
        }// end function

        protected function onMapClick(param1:Object, param2:int, param3:int) : void
        {
            _view.otherHead.info = param1 as PlayerInfo;
            _view.otherHead.show();
            _view.quest.haltWayFinding();
            return;
        }// end function

        public function getChatViewStr(param1:Array) : String
        {
            var _loc_2:* = TextLinkType.Player + "_" + param1[1] + "_" + param1[2];
            var _loc_3:* = TextLinkType.NineRegions + "_" + param1[3] + "_" + param1[1] + "_" + param1[5] + "_" + param1[6];
            var _loc_4:* = NineRegionsType.getNameByIdx(param1[5]);
            var _loc_5:* = "<font color=\'#80c269\'>" + NineRegionsMapViewLang.BanPai + "</font>" + "<font color=\'#ffff00\'><u><a href=\'event:" + _loc_2 + "\'>" + param1[2] + "</a></u></font>" + HtmlText.white(Lang.sprintf(NineRegionsMapViewLang.JiuJieNeed, _loc_4, param1[6], param1[4])) + "\n<font color=\'#ffff00\'><u><a href=\'event:" + _loc_3 + "\'>" + NineRegionsMapViewLang.JiaRu + "</a></u></font>";
            return "<font color=\'#80c269\'>" + NineRegionsMapViewLang.BanPai + "</font>" + "<font color=\'#ffff00\'><u><a href=\'event:" + _loc_2 + "\'>" + param1[2] + "</a></u></font>" + HtmlText.white(Lang.sprintf(NineRegionsMapViewLang.JiuJieNeed, _loc_4, param1[6], param1[4])) + "\n<font color=\'#ffff00\'><u><a href=\'event:" + _loc_3 + "\'>" + NineRegionsMapViewLang.JiaRu + "</a></u></font>";
        }// end function

    }
}
