package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.assist.view.sound.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import com.views.map.*;
    import flash.display.*;
    import flash.utils.*;

    public class TopWarMapView extends MapViewBase
    {
        private var _warTime:int = 0;
        private var _Map:ITopWarMap;
        private var _tmpRoleList:Array;
        private var _targetUi:IMcTopWarMapUi;
        private var _onWar:Boolean;

        public function TopWarMapView()
        {
            this._tmpRoleList = [];
            this.init();
            _inStageTipTitle = TopWarMapViewLang.ViewUsing;
            _inStageTipContent = "";
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:* = MapStatic.mapInstance.topWarMap;
            this._Map = MapStatic.mapInstance.topWarMap;
            _mapBase = _loc_1;
            return;
        }// end function

        override public function clear() : void
        {
            this._onWar = false;
            super.clear();
            if (this._targetUi)
            {
                this._targetUi.clear();
            }
            _view.topWarCreate.openType = 0;
            _data.cancelPatch(Mod_TopWar_Base.get_player_team_info);
            _data.cancelPatch(Mod_TopWar_Base.get_war_result);
            return;
        }// end function

        public function gotoTown() : void
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
            _id = TownType.getId(TownType.DianFengDuiJue);
            _view.screen.currentMap = this;
            _view.initLoading.tip = _loadTips[getTimer() % _loadTips.length];
            _view.initLoading.show();
            _view.initLoading.loading1(TopWarMapViewLang.EnterTownTip);
            _view.chat.changeChannel(Mod_Chat_Base.ACTIVITY);
            this.enter_town();
            super.enterMapComplete();
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
            res.push(URI.assetsUrl + "top_war_map_ui.swf");
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
            File.loadList(res, this.miniMapLoaded, showProgress, oneComplete, errorHandler);
            return;
        }// end function

        private function onExitSystem() : void
        {
            _data.call(Mod_TopWar_Base.exit_team, this.exit_team_Back, []);
            return;
        }// end function

        private function exit_team_Back() : void
        {
            if (_ctrl.topWar.exitResult == Mod_TopWar_Base.SUCCESS)
            {
                this.closeWindow();
            }
            else
            {
                _view.showTip(TopWarMapViewLang.ExitFails);
            }
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
            _data.call(Mod_TopWar_Base.helper_role_list, this.getMyRoleList, []);
            return;
        }// end function

        private function onPlayerOut(param1:int) : void
        {
            _data.call(Mod_TopWar_Base.kicked_out_member, new Function(), [param1]);
            return;
        }// end function

        private function onChangeRoleOk(param1:int) : void
        {
            _data.call(Mod_TopWar_Base.choose_helper_role, this.onChangeRoleOkBack, [param1]);
            return;
        }// end function

        private function onChangeRoleOkBack() : void
        {
            if (_ctrl.topWar.changeRoleResult == Mod_TopWar_Base.FAILED)
            {
                _view.showTip(TopWarMapViewLang.ChangeRoleFails);
            }
            return;
        }// end function

        private function onOpenDeployPanel() : void
        {
            _data.call(Mod_TopWar_Base.deploy_list, this.onOpenDeployPanelBack, []);
            return;
        }// end function

        private function onOpenDeployPanelBack() : void
        {
            this._targetUi.deployList(_ctrl.topWar.deployList, _ctrl.topWar.firstAttack);
            return;
        }// end function

        private function onDeploy(param1:int, param2:int, param3:int) : void
        {
            _data.call(Mod_TopWar_Base.change_position, this.onDeployBack, [param1, param2, param3]);
            return;
        }// end function

        private function onDeployBack() : void
        {
            if (_ctrl.topWar.changeDeployResult == Mod_TopWar_Base.FAILED)
            {
                this.onOpenDeployPanel();
            }
            return;
        }// end function

        private function onOtherTeam() : void
        {
            _view.topWarCreate.show();
            return;
        }// end function

        private function miniMapLoaded(param1:Array) : void
        {
            var _loc_4:BuildInfo = null;
            var _loc_5:MovieClip = null;
            var _loc_2:* = param1.pop();
            var _loc_3:* = param1.pop();
            if (!this._targetUi)
            {
                this._targetUi = _loc_2.getClassObject("McTopWarUi") as IMcTopWarMapUi;
                this._targetUi.onShowPlayerInfoView = this.showPlayerInfoView;
                this._targetUi.changeRole = this.onChangeRoleOk;
                this._targetUi.openChangeRolePanel = this.onChangeRole;
                this._targetUi.onOutFun = this.onPlayerOut;
                this._targetUi.onOpenDeploy = this.onOpenDeployPanel;
                this._targetUi.onDeploy = this.onDeploy;
                this._targetUi.onWar = this.onWar;
                this._targetUi.onTip = this.onTip;
                this._targetUi.onOtherTeam = this.onOtherTeam;
                this._targetUi.onCloseWindow = this.onExitSystem;
                _loc_5 = _loc_2.getClassObject("McTeamLeader") as MovieClip;
                this._Map.mcLeader = _loc_5;
            }
            _content.addChild(this._Map.content);
            _content.addChild(this._targetUi.content);
            this._Map.backMini = _loc_3.bitmap;
            this._Map.onMoveTo = move_to;
            this._Map.onWar = this.onWar;
            this._Map.onMapClick = this.onMapClick;
            this._Map.initMapinfo(_info);
            _playerInfo.x = 400;
            _playerInfo.y = 500;
            this._Map.addPlayer(_playerInfo);
            for each (_loc_4 in _info.builds)
            {
                
                this._Map.addBuild(_loc_4);
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
            _view.mapSwitched(MapViewBase.DianFengDuiJue);
            SoundManage.playBgSound(_info.urlSound);
            _data.cancelPatch(Mod_Town_Base.player_follow_role_change);
            _data.patch(Mod_TopWar_Base.get_player_team_info, this.getTeams);
            _data.patch(Mod_TopWar_Base.get_war_result, this.getWarResultCallBack);
            this.get_players();
            return;
        }// end function

        override protected function get_players() : void
        {
            super.get_players();
            _data.call(Mod_TopWar_Base.get_player_team_info, this.getTeams, []);
            return;
        }// end function

        private function getMyRoleList() : void
        {
            if (_ctrl.topWar.myRoleList.length == 0)
            {
                _view.showTip(TopWarMapViewLang.NoRole);
            }
            this._targetUi.myRoleList = _ctrl.topWar.myRoleList;
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
                _loc_3.x = 400;
                _loc_3.y = 500;
                this._Map.addPlayer(_loc_3);
                this._Map.setFollowChange(_loc_4.playerId, _loc_4.roleId);
            }
            setFactionCloth();
            return;
        }// end function

        private function getTeams() : void
        {
            var _loc_3:Object = null;
            var _loc_1:* = _ctrl.topWar.myTeamList;
            if (_loc_1.length == 0)
            {
                _view.showTip(TopWarMapViewLang.BackTown);
                this.closeWindow();
                return;
            }
            this._targetUi.teamList = _ctrl.topWar.myTeamList;
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
            this._Map.leaderId = _ctrl.topWar.leaderId;
            this._Map.canWar = _ctrl.topWar.canWar;
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

        private function onWar() : void
        {
            if (_ctrl.topWar.myTeamList.length == 3)
            {
                _data.call(Mod_TopWar_Base.match, new Function(), []);
            }
            else
            {
                _view.showTip(TopWarMapViewLang.NotFull);
            }
            return;
        }// end function

        private function getWarResultCallBack() : void
        {
            this._onWar = true;
            this._targetUi.otherTeamList = _ctrl.topWar.otherTeamList;
            var _loc_1:* = new PlayerInfo();
            _loc_1.id = _ctrl.topWar.otherTeamList[0].playerId;
            _loc_1.sign = _ctrl.topWar.otherTeamList[0].sign;
            _loc_1.followRoleId = _ctrl.topWar.otherTeamList[0].roleId;
            _loc_1.name = _ctrl.topWar.otherTeamList[0].playerName;
            _loc_1.fullHeadUrl = _ctrl.topWar.otherTeamList[0].fullHeadUrl;
            _loc_1.x = 750;
            _loc_1.y = 450;
            var _loc_2:* = new PlayerInfo();
            _loc_2.id = _ctrl.topWar.otherTeamList[1].playerId;
            _loc_2.sign = _ctrl.topWar.otherTeamList[1].sign;
            _loc_2.followRoleId = _ctrl.topWar.otherTeamList[1].roleId;
            _loc_2.name = _ctrl.topWar.otherTeamList[1].playerName;
            _loc_2.fullHeadUrl = _ctrl.topWar.otherTeamList[1].fullHeadUrl;
            _loc_2.x = 850;
            _loc_2.y = 400;
            var _loc_3:* = new PlayerInfo();
            _loc_3.id = _ctrl.topWar.otherTeamList[2].playerId;
            _loc_3.sign = _ctrl.topWar.otherTeamList[2].sign;
            _loc_3.followRoleId = _ctrl.topWar.otherTeamList[2].roleId;
            _loc_3.name = _ctrl.topWar.otherTeamList[2].playerName;
            _loc_3.fullHeadUrl = _ctrl.topWar.otherTeamList[2].fullHeadUrl;
            _loc_3.x = 920;
            _loc_3.y = 550;
            this._Map.addOtherPlayer(_loc_1);
            this._Map.addOtherPlayer(_loc_2);
            this._Map.addOtherPlayer(_loc_3);
            setTimeout(this.startWar, 800);
            return;
        }// end function

        private function startWar() : void
        {
            _view.topWarWar.warData = _ctrl.topWar.warData;
            _view.topWarWar.onClose = function (param1:Boolean) : void
            {
                if (param1)
                {
                }
                _onWar = false;
                _view.chat.resetDepth();
                closeWindow();
                _view.topWarCreate.show();
                return;
            }// end function
            ;
            _view.topWarWar.show();
            return;
        }// end function

        public function notifyState(param1:int) : void
        {
            if (!this._targetUi)
            {
                return;
            }
            this._targetUi.uiState = param1;
            if (param1 == Mod_TopWar_Base.KICK_OUT_TEAM || param1 == Mod_TopWar_Base.LEADER_DISSOLVE)
            {
                this.closeWindow();
            }
            else if (param1 == Mod_TopWar_Base.STOP_TOP_WAR)
            {
                if (!this._onWar)
                {
                    this.closeWindow();
                }
            }
            return;
        }// end function

        public function reposition() : void
        {
            if (!inStage || !this._targetUi)
            {
                return;
            }
            this._targetUi.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            return;
        }// end function

        override protected function enter_town() : void
        {
            super.enter_town();
            getTownMapInfo(TownType.DianFengDuiJue, this.infoComplete);
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

    }
}
