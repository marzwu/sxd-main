package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
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

    public class FurnaceMapView extends MapViewBase
    {
        private var _Map:IFurnaceMap;
        private var _guideLayder:Sprite;
        private var _iconContainer:IRefiningIconContainer;
        private var _warRoleId:int = 0;

        public function FurnaceMapView()
        {
            this._guideLayder = new Sprite();
            return;
        }// end function

        override public function show() : void
        {
            this.gotoTownAtId(28);
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:* = MapStatic.mapInstance.furnace;
            this._Map = MapStatic.mapInstance.furnace;
            _mapBase = _loc_1;
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
            _view.initLoading.loading1(FurnaceMapViewLang.RequestInFurnace);
            this.enter_town();
            return;
        }// end function

        private function infoComplete(param1:MapInfo) : void
        {
            _info = param1;
            _view.initLoading.loading1(FurnaceMapViewLang.Tip2);
            File.loadList([_info.urlMini], this.miniMapLoaded);
            return;
        }// end function

        private function miniMapLoaded(param1:Array) : void
        {
            var _loc_2:PortalInfo = null;
            var _loc_3:BuildInfo = null;
            _content.addChild(this._Map.content);
            _content.addChild(this._guideLayder);
            this._Map.backMini = param1[0].loader.content;
            this._Map.onMoveTo = this.move_to;
            this._Map.onNpcSpeak = this.onNpcSpeak;
            this._Map.onBuildClick = this.onBuildClick;
            this._Map.onPortal = this.onPortal;
            this._Map.onNpcRange = this.onNpcRange;
            this._Map.onMapClick = this.onMapClick;
            this._Map.onUpdateXY = this.onUpdateXY;
            this._Map.onRoleSpeak = this.onRoleSpeak;
            this._Map.initMapinfo(_info);
            for each (_loc_2 in _info.portals)
            {
                
                _mapBase.addPortal(_loc_2);
            }
            for each (_loc_3 in _info.builds)
            {
                
                _mapBase.addBuild(_loc_3);
            }
            _playerInfo.x = 1060;
            _playerInfo.y = 470;
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

        public function quit() : void
        {
            if (_ctrl.player.jihuisuoId != 0)
            {
                _view.townMap.gotoTownAtId(_ctrl.player.jihuisuoId);
            }
            else
            {
                _view.townMap.gotoTownAtId(ctrlPlayer.townMapId);
            }
            _view.quest.finishWayFinding();
            return;
        }// end function

        override protected function enterMapComplete() : void
        {
            _data.patch(Mod_Player_Base.update_player_data_for_town, update_player_data_for_town_back);
            _data.patch(Mod_Player_Base.practice_notify, practice_notify_back);
            _data.patch(Mod_Notify_Base.change_equip, change_equip_back);
            _data.call(Mod_Furnace_Base.player_role_info, this.roleInfoComplete, []);
            _view.chat.onPassClick = this._Map.passClick;
            _view.mapSwitched(MapViewBase.HuZhongJie);
            _view.toolbar.miniMap.mapName = TownType.getName(_id);
            _view.toolbar.soundMute(SoundManage.mute == 0);
            get_practice_data();
            _mapBase.onCancelPraceice = onCancelPraceice;
            _mapBase.onGoonPraceice = startPractice;
            _mapBase.onPracticeAction = onPracticeAction;
            if (!this._iconContainer)
            {
                File.loadList([URI.assetsUrl + "furnace_ui.swf"], this.resouceLoadComplete, this.showProgress);
            }
            this.updateContainer();
            return;
        }// end function

        private function roleInfoComplete() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < _ctrl.furnaceMap.curRoleList.length)
            {
                
                if (_ctrl.furnaceMap.curRoleList[_loc_1].inBody)
                {
                    this._Map.addAvatar(_ctrl.furnaceMap.curRoleList[_loc_1]);
                }
                _loc_1++;
            }
            this.updateContainer();
            return;
        }// end function

        private function resouceLoadComplete(param1:Array) : void
        {
            var _loc_2:* = param1.pop();
            if (this._iconContainer == null)
            {
                this._iconContainer = _loc_2.getClassObject("McHeadIconContainer") as IRefiningIconContainer;
                this._iconContainer.onIconClick = this.onRoleSpeakForContainer;
                this._iconContainer.onTip = this.onTip;
                this._iconContainer.closeFun = this.quit;
                this._iconContainer.onOpenRune = this.onOpenRune;
                this.ingotValue = _ctrl.player.ingot;
                this.coinsValue = _ctrl.player.coins;
            }
            this._iconContainer.showRune(_view.rune.Count > 0);
            this.updateContainer();
            this.reposition();
            return;
        }// end function

        private function onOpenRune() : void
        {
            _view.rune.switchSelf();
            return;
        }// end function

        public function showRune(param1:int) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._iconContainer.showRune(param1 > 0);
            return;
        }// end function

        public function updateContainer() : void
        {
            var _loc_1:Array = null;
            var _loc_2:int = 0;
            if (this._iconContainer)
            {
                _loc_1 = new Array();
                _loc_2 = 0;
                while (_loc_2 < _ctrl.furnaceMap.curRoleList.length)
                {
                    
                    if (_ctrl.furnaceMap.curRoleList[_loc_2].fame <= _ctrl.player.fame && _ctrl.furnaceMap.curRoleList[_loc_2].canLevel && _ctrl.furnaceMap.isCanShow(_ctrl.furnaceMap.curRoleList[_loc_2].roleId))
                    {
                        _loc_1.push(_ctrl.furnaceMap.curRoleList[_loc_2]);
                    }
                    _loc_2++;
                }
                _loc_2 = 0;
                while (_loc_2 < _ctrl.furnaceMap.curPurpleList.length)
                {
                    
                    if (!_ctrl.furnaceMap.curPurpleList[_loc_2].wared && _ctrl.furnaceMap.curPurpleList[_loc_2].roleId != 66 && _ctrl.furnaceMap.curPurpleList[_loc_2].roleId != 70)
                    {
                        _loc_1.push(_ctrl.furnaceMap.curPurpleList[_loc_2]);
                    }
                    _loc_2++;
                }
                this._iconContainer.curRoleList = _loc_1;
                _content.addChild(this._iconContainer.content);
            }
            return;
        }// end function

        public function updateFav(param1:int, param2:int) : void
        {
            if (this._iconContainer)
            {
                this._iconContainer.updateFav(param1, param2);
            }
            return;
        }// end function

        override protected function showProgress(param1:int, param2:int, param3:int, param4:String) : void
        {
            _view.initLoading.loading(param2 + "", param3, param2, param1, param4);
            return;
        }// end function

        public function changeRole(param1:int) : void
        {
            if (this._iconContainer)
            {
                this._iconContainer.clearByRoleId(param1);
            }
            var _loc_2:* = _ctrl.furnaceMap.levelRole(param1);
            _ctrl.furnaceMap.curPurpleList.push(_loc_2);
            this.updateContainer();
            this._Map.levelRole(_loc_2, param1);
            return;
        }// end function

        public function warSeccess(param1:int) : void
        {
            this._warRoleId = param1;
            _data.call(Mod_Furnace_Base.get_level_up_award, this.getLevelUpAwardBack, [param1]);
            return;
        }// end function

        private function getLevelUpAwardBack() : void
        {
            var _loc_1:int = 0;
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:Array = null;
            var _loc_5:String = null;
            if (_ctrl.furnaceMap.result == Mod_Furnace_Base.AWARD_SUCCESS)
            {
                _loc_1 = _ctrl.furnaceMap.opRoleId;
                _loc_2 = _ctrl.furnaceMap.curPurpleList;
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    if (_loc_2[_loc_3].roleId == _loc_1)
                    {
                        _loc_2[_loc_3].wared = true;
                    }
                    _loc_3++;
                }
                if (this._iconContainer)
                {
                    this._iconContainer.clearByRoleId(_loc_1);
                }
                _loc_4 = FurnaceType.getAwardByRoleId(this._warRoleId);
                _loc_5 = FurnaceMapViewLang.WarSucess;
                _loc_5 = _loc_5 + (HtmlText.yellow(FurnaceMapViewLang.WuHun + _loc_4[0]) + "\n");
                _loc_5 = _loc_5 + HtmlText.purple(RoleType.getRoleName(this._warRoleId));
                _loc_5 = _loc_5 + (HtmlText.yellow(FurnaceMapViewLang.WuLi + _loc_4[1]) + "、");
                _loc_5 = _loc_5 + (HtmlText.yellow(FurnaceMapViewLang.JueJi + _loc_4[2]) + "、");
                _loc_5 = _loc_5 + HtmlText.yellow(FurnaceMapViewLang.FaShu + _loc_4[3]);
                _view.alert.confirm(_loc_5);
            }
            return;
        }// end function

        public function setLevelUpMc(param1:MovieClip) : void
        {
            this._Map.setMcLevel(param1);
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

        protected function onMapClick(param1:Object, param2:int, param3:int) : void
        {
            return;
        }// end function

        override protected function move_to(param1:int, param2:int, param3:int, param4:int) : void
        {
            this.closePractice(true);
            return;
        }// end function

        private function onPortal(param1:PortalInfo) : void
        {
            this.quit();
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
            _view.npcDialog.townNPCId = param1.id;
            _view.npcDialog.npcSign = param1.sign;
            _view.npcDialog.switchSelf();
            return;
        }// end function

        private function onRoleSpeak(param1:int) : void
        {
            _view.furnaceRoleDialog.onRoleSpeak(param1);
            return;
        }// end function

        private function onRoleSpeakForContainer(param1:int, param2:Boolean) : void
        {
            if (param2)
            {
                _view.haloButtle.getButtleRoleId(param1);
            }
            else
            {
                _view.furnaceRoleDialog.onRoleSpeak(param1);
            }
            return;
        }// end function

        public function getInfoByRoleId(param1:int) : Object
        {
            return _ctrl.furnaceMap.getInfoByRoleId(param1);
        }// end function

        private function onUpdateXY(param1:int, param2:int) : void
        {
            this._guideLayder.x = -param1;
            this._guideLayder.y = -param2;
            return;
        }// end function

        private function onBuildClick(param1:BuildInfo) : void
        {
            _view.refiningFurnace.show();
            return;
        }// end function

        public function set coinsValue(param1:Number) : void
        {
            if (this._iconContainer)
            {
                this._iconContainer.coinsValue = param1;
            }
            return;
        }// end function

        public function set ingotValue(param1:Number) : void
        {
            if (this._iconContainer)
            {
                this._iconContainer.ingotValue = param1;
            }
            return;
        }// end function

        public function set curDeployRoleList(param1:Array) : void
        {
            var _loc_7:String = null;
            var _loc_2:* = this._Map.curDeployRoleIdList;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            while (_loc_5 < param1.length)
            {
                
                if (!this.inArray(_loc_2, param1[_loc_5]))
                {
                    _loc_3 = param1[_loc_5];
                    break;
                }
                _loc_5++;
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                if (!this.inArray(param1, _loc_2[_loc_5]) && _loc_2[_loc_5] != 0)
                {
                    _loc_4 = _loc_2[_loc_5];
                    break;
                }
                _loc_5++;
            }
            if (_loc_3 == 0 && _loc_4 == 0)
            {
                return;
            }
            var _loc_6:* = _ctrl.furnaceMap.getInfoByRoleId(_loc_3);
            if (_ctrl.furnaceMap.getInfoByRoleId(_loc_3).roleId != 0 && _loc_6.outData)
            {
                _loc_6.sign = RoleType.getRoleSign(_loc_6.roleId);
                _loc_6.name = RoleType.getRoleName(_loc_6.roleId);
                _loc_6.have_amount = 0;
                _loc_7 = FurnaceType.getChat(_loc_6.roleId, FurnaceType.COMMONFLAG);
                _loc_6.chatList = _loc_7.split("|");
                _loc_7 = FurnaceType.getChat(_loc_6.roleId, FurnaceType.LEVELFLAG);
                _loc_6.levelChat = _loc_7;
                _loc_6.inBody = true;
                _loc_6.isLvUp = false;
                _loc_6.canLevel = false;
                _loc_6.fame = RoleType.getRoleFame(_loc_6.roleId);
            }
            this._Map.updateRole(_loc_6, _loc_4);
            return;
        }// end function

        private function inArray(param1:Array, param2:int) : Boolean
        {
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param2 == param1[_loc_3])
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
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

        public function moveToNPCAtId(param1:int) : void
        {
            if (inStage == false)
            {
                return;
            }
            this._Map.moveToNPCAtId(param1);
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

        public function reposition() : void
        {
            if (!inStage || !this._iconContainer)
            {
                return;
            }
            this._iconContainer.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            return;
        }// end function

        override protected function enter_town() : void
        {
            _playerInfo = ctrlPlayer.playerInfo;
            var _loc_1:* = new Date();
            if (_loc_1.hours > 6 && _loc_1.hours < 18)
            {
                getTownMapInfo("HuZhongJie_Day", this.infoComplete);
            }
            else
            {
                getTownMapInfo("HuZhongJie_Night", this.infoComplete);
            }
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

    }
}
