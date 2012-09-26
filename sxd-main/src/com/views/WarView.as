package com.views
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.sound.*;
    import com.assist.view.toolbar.*;
    import com.assist.view.war.*;
    import com.assist.view.war.roles.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class WarView extends Base implements IView
    {
        protected var _cWar:Class;
        protected var _war:IWar;
        protected var _warResources:File;
        protected var _type:String;
        protected var _reportId:int;
        protected var _effect:MovieClip;
        protected var _warIcon:Bitmap;
        protected var _roleBitmapDatas:Object;
        protected var _win:Boolean;
        public var missionId:int;
        public var monsterTeamId:int;
        public var isBoss:Boolean;
        public var isLastMonster:Boolean;
        public var mainRoleSuffix:String;
        public var background:BitmapData;
        public var onAfterAdded:Function;
        public var onClose:Function;
        private var _onWarClose:Function;
        private var _opened:Boolean;
        public var IsGetWarData:Boolean = false;
        private var _effectFinish:Boolean = false;
        private var _loaded:Boolean = false;
        protected var _mainRoleStunt:Object;
        protected var _signs:Array;
        protected var _urls:Array;
        protected var _warData:WarData;
        public var onProgress:Function;
        private var _reportArgs:Array;

        public function WarView() : void
        {
            this._roleBitmapDatas = {};
            this._mainRoleStunt = {};
            this._signs = [];
            this._urls = [];
            this._reportArgs = [];
            this._type = WarType.War;
            return;
        }// end function

        public function set onWarClose(param1:Function) : void
        {
            var func:Function;
            var value:* = param1;
            if (value != null && this._onWarClose != null)
            {
                func = this._onWarClose;
                this._onWarClose = function () : void
            {
                func();
                value();
                return;
            }// end function
            ;
            }
            else
            {
                this._onWarClose = value;
            }
            return;
        }// end function

        public function show() : void
        {
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            this.checkWarCdTime();
            return;
        }// end function

        private function checkWarCdTime() : void
        {
            var handler:* = function (param1:Boolean) : void
            {
                if (param1 == true && onClose is Function)
                {
                    leaverWar(-1);
                }
                else
                {
                    _view.tip.hide();
                    _loaded = false;
                    _effectFinish = false;
                    showEffect();
                    loadData();
                }
                return;
            }// end function
            ;
            if (WarType.War == this._type)
            {
                _view.toolbar.checkWarCdTime(handler);
            }
            else
            {
                this.handler(false);
            }
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._war && this._war.content.parent;
        }// end function

        public function set opened(param1:Boolean) : void
        {
            this._opened = param1;
            return;
        }// end function

        public function get opened() : Boolean
        {
            return this.inStage || _requested || this._opened || this.IsGetWarData;
        }// end function

        protected function showEffect() : void
        {
            _structure.tip.addChild(this._effect);
            this._effect.gotoAndPlay(2);
            this.reposition(false);
            return;
        }// end function

        protected function removeEffect() : void
        {
            this._loaded = false;
            this._effectFinish = false;
            if (this._effect && this._effect.parent)
            {
                this._effect.parent.removeChild(this._effect);
            }
            return;
        }// end function

        protected function onEffectFinish(event:Event) : void
        {
            this._effectFinish = true;
            if (this._loaded)
            {
                this.render();
            }
            return;
        }// end function

        protected function loadData() : void
        {
            _requested = true;
            _data.call(Mod_Mission_Base.fight_monster, this.fightMonsterCallback, [this.monsterTeamId, 0]);
            this.addTimeOut();
            return;
        }// end function

        private function fightMonsterCallback() : void
        {
            if (_ctrl.mission.warStatus == Mod_Mission_Base.SUCCESS)
            {
                this._warData = _ctrl.mission.warData;
                this.loadMainRoleResource(function () : void
            {
                loadStudyStunt(loadResources1);
                return;
            }// end function
            );
            }
            else
            {
                this.leaverWar(-1, true);
            }
            return;
        }// end function

        protected function addTimeOut() : void
        {
            var limit:int;
            var num:int;
            limit;
            num;
            var handler:* = function () : void
            {
                if (inStage)
                {
                    removeTimeOut();
                    return;
                }
                if (num >= limit)
                {
                    _view.alert.confirm(WarViewLang.NetStatus, leaverWar);
                    num = 0;
                }
                (num + 1);
                return;
            }// end function
            ;
            _view.addToTimerProcessList(sign, handler);
            return;
        }// end function

        protected function removeTimeOut() : void
        {
            _view.removeFromTimerProcessList(sign);
            _view.alert.hide();
            return;
        }// end function

        private function leaverWar(param1:int, param2:Boolean = false) : void
        {
            this.removeTimeOut();
            this.removeEffect();
            this.onCloseHandler(param2);
            return;
        }// end function

        protected function loadMainRoleResource(param1:Function) : void
        {
            var roleSign:String;
            var handler:* = param1;
            this.mainRoleSuffix = _ctrl.player.playerInfo.signSuffix;
            roleSign = RoleType.getRoleSign(_ctrl.player.mainRoleId);
            if (roleSign == "")
            {
                this.handler();
                return;
            }
            roleSign = roleSign + this.mainRoleSuffix;
            if (this._roleBitmapDatas[roleSign] != null)
            {
                this.handler();
                return;
            }
            var callback:* = function (param1:Array) : void
            {
                var _loc_2:* = (param1[0] as File).getClassByName("RoleBmd");
                _roleBitmapDatas[roleSign] = new _loc_2;
                _view.hideLoading();
                handler();
                return;
            }// end function
            ;
            var progress:* = function (param1:int, param2:int) : void
            {
                _view.showLoading(WarViewLang.MainRole, param2);
                return;
            }// end function
            ;
            File.loadList([URI.warRolesUrl + roleSign + ".swf"], callback, progress, null, handler);
            return;
        }// end function

        protected function loadStudyStunt(param1:Function) : void
        {
            var callback:* = param1;
            this._mainRoleStunt = {};
            var handler:* = function () : void
            {
                var _loc_2:Array = null;
                var _loc_3:Array = null;
                var _loc_4:int = 0;
                var _loc_5:int = 0;
                var _loc_6:int = 0;
                var _loc_7:String = null;
                var _loc_8:String = null;
                var _loc_1:* = _ctrl.studyStunt.mainRoleStuntIds;
                if (_loc_1 && _loc_1.length > 0)
                {
                    _loc_2 = [];
                    _loc_3 = [];
                    _loc_4 = 0;
                    while (_loc_4 < _loc_1.length)
                    {
                        
                        _loc_5 = _loc_1[_loc_4]["playerId"];
                        _loc_6 = _loc_1[_loc_4]["stuntId"];
                        _loc_7 = RoleStunt.getStuntSign(_loc_6);
                        if (_loc_7 == "")
                        {
                        }
                        else
                        {
                            _signs.push(_loc_7);
                            _urls.push(URI.stuntsUrl + _loc_7 + ".swf");
                            _loc_2.push(URI.stuntsUrl + _loc_7 + ".swf");
                            _loc_3.push(_loc_7);
                            _loc_8 = RoleAction.addonEffect(_loc_7);
                            if (_loc_8 != "")
                            {
                                _loc_2.push(URI.stuntsUrl + _loc_8 + ".swf");
                                _loc_3.push(_loc_8);
                            }
                            _mainRoleStunt[_loc_5] = _loc_7;
                        }
                        _loc_4++;
                    }
                    loadStudyStuntResources(_loc_3, _loc_2, callback);
                }
                else
                {
                    callback();
                }
                return;
            }// end function
            ;
            _data.call(Mod_StudyStunt_Base.player_use_role_stunt_id, handler, [this.getStudyStuntPlayerIds()]);
            return;
        }// end function

        protected function getStudyStuntPlayerIds() : Array
        {
            var _loc_1:Array = [[this._warData.attackerId]];
            if (!WarType.hasMonster(this._type))
            {
                _loc_1.push([this._warData.defenderId]);
            }
            return _loc_1;
        }// end function

        protected function loadStudyStuntResources(param1:Array, param2:Array, param3:Function) : void
        {
            var signs:* = param1;
            var urls:* = param2;
            var callback:* = param3;
            if (urls.length == 0)
            {
                this.callback();
                return;
            }
            var handler:* = function (param1:Array) : void
            {
                var _loc_2:int = 0;
                while (_loc_2 < param1.length)
                {
                    
                    _roleBitmapDatas[signs[_loc_2]] = param1[_loc_2].getClassByName("RoleMC");
                    _loc_2++;
                }
                callback();
                return;
            }// end function
            ;
            File.loadList(urls, handler);
            return;
        }// end function

        public function getResourcesUrl() : Array
        {
            this._signs = [];
            this._urls = [];
            var _loc_1:* = this.getPlayerSigns();
            this.getRoleResources(_loc_1[0], _loc_1[1], false);
            this.getMonsterResources();
            this.addonRole(this._signs, this._urls);
            this.addonWarIcon(this._signs, this._urls);
            this._signs.push("War");
            this._urls.push(_view.getAssetsUrl("War"));
            return this._urls;
        }// end function

        private function getPlayerSigns() : Array
        {
            var _loc_5:String = null;
            var _loc_1:Array = [];
            var _loc_2:* = RoleType.getRoleSigns(_ctrl.rolemsg.roleIdList);
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                var _loc_6:* = _loc_2[_loc_4];
                _loc_1[_loc_4] = _loc_2[_loc_4];
                _loc_5 = _loc_6;
                if (RoleType.isMainRole(_loc_5))
                {
                    _loc_1[_loc_4] = _loc_1[_loc_4] + this.mainRoleSuffix;
                }
                _loc_4++;
            }
            return [_loc_1, _loc_2];
        }// end function

        protected function getRoleResources(param1:Array, param2:Array, param3:Boolean) : void
        {
            var _loc_5:String = null;
            var _loc_4:Array = [];
            if (FunctionType.isOpened(FunctionType.Stunt))
            {
                _loc_4 = param3 ? (RoleStunt.getMonsterStunts(param2)) : (RoleStunt.getRoleStunts(param2));
            }
            else
            {
                _loc_4 = [RoleStunt.MengJi];
            }
            for each (_loc_5 in param1)
            {
                
                _loc_5 = param3 ? (MonsterType.sameResource(_loc_5)) : (_loc_5);
                _loc_5 = _loc_5 + WarType.getMiniSuffix(this._type);
                this._signs.push(_loc_5);
                this._urls.push(URI.warRolesUrl + _loc_5 + ".swf");
            }
            for each (_loc_5 in _loc_4)
            {
                
                if (RoleAction.isStunt(_loc_5) == false)
                {
                    continue;
                }
                this._signs.push(_loc_5);
                this._urls.push(URI.stuntsUrl + _loc_5 + ".swf");
            }
            return;
        }// end function

        protected function getMonsterResources() : void
        {
            var _loc_1:Array = [];
            _loc_1 = _loc_1.concat(MissionType.getMissionMonsterList(this.missionId));
            this.getRoleResources(_loc_1, _loc_1, true);
            return;
        }// end function

        public function resourcesLoaded(param1:Array) : void
        {
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.getExportObject(this._signs[_loc_3], param1[_loc_3]);
                _loc_3++;
            }
            return;
        }// end function

        protected function loadResources1(param1:WarData = null) : void
        {
            this.removeTimeOut();
            this._warData = param1 || _ctrl.mission.warData;
            this._loaded = true;
            if (this._effectFinish)
            {
                this.render();
            }
            return;
        }// end function

        protected function loadResources() : void
        {
            var _loc_1:LoadResponder = null;
            this.removeTimeOut();
            this._warData = _ctrl.mission.warData;
            if (_view.hasResource("War"))
            {
                this.loadRoleResource();
            }
            else
            {
                _loc_1 = new LoadResponder(this.loadRoleResource, this.onProgress);
                _view.loadResources(["War"], _loc_1);
            }
            return;
        }// end function

        protected function loadRoleResource() : void
        {
            var signs:Array;
            var urls:Array;
            var list:* = this.extractRoleData();
            signs = list[0];
            urls = list[1];
            var callback:* = function (param1:Array) : void
            {
                var files:* = param1;
                loadStudyStunt(function () : void
                {
                    var _loc_1:* = files.length;
                    var _loc_2:int = 0;
                    while (_loc_2 < _loc_1)
                    {
                        
                        getExportObject(signs[_loc_2], files[_loc_2]);
                        _loc_2++;
                    }
                    _loaded = true;
                    if (_type != WarType.War)
                    {
                        showEffect();
                    }
                    else if (_effectFinish)
                    {
                        render();
                    }
                    return;
                }// end function
                );
                return;
            }// end function
            ;
            var error:* = function (param1:int) : void
            {
                var index:* = param1;
                var message:* = "[war]: " + urls[index].replace(/^[\s\S]+\/""^[\s\S]+\//, "");
                var handler:* = function (param1:uint) : void
                {
                    _view.hideLoading();
                    return;
                }// end function
                ;
                _view.alert.confirm(message, handler);
                return;
            }// end function
            ;
            File.loadList(urls, callback, this.onProgress, null, error);
            return;
        }// end function

        protected function extractRoleData() : Array
        {
            var signs:Array;
            var urls:Array;
            signs;
            urls;
            var deal:* = function (param1:Object, param2:int, param3:String, param4:Boolean) : Array
            {
                var _loc_6:String = null;
                var _loc_7:int = 0;
                var _loc_8:String = null;
                var _loc_9:String = null;
                var _loc_10:String = null;
                var _loc_11:String = null;
                var _loc_12:String = null;
                var _loc_13:String = null;
                var _loc_14:Object = null;
                var _loc_15:int = 0;
                var _loc_16:String = null;
                var _loc_5:Array = [];
                for (_loc_6 in param1)
                {
                    
                    _loc_7 = param1[_loc_6]["id"];
                    _loc_8 = _loc_7 != param2 ? ("") : (param3);
                    _loc_9 = param1[_loc_6]["sign"];
                    _loc_10 = _loc_9 + _loc_8;
                    _loc_11 = param4 ? (MonsterType.sameResource(_loc_10)) : (_loc_10);
                    if (_type == WarType.GetPeachWar && param4 == false && _loc_7 < 0)
                    {
                        _loc_11 = MonsterType.sameResource(_loc_10);
                        _loc_9 = _loc_11;
                        param1[_loc_6]["sign"] = _loc_11;
                    }
                    if ((_type == WarType.BeelzebubTrialsWar || _type == WarType.NineRegionsWar || _type == WarType.TopWarWar) && param4 == false && param2 != _loc_7)
                    {
                        _loc_15 = Math.abs(int(_loc_7));
                        if (_type == WarType.BeelzebubTrialsWar)
                        {
                            _loc_14 = _ctrl.beelzebubTrials.equitData[_loc_15];
                        }
                        if (_type == WarType.NineRegionsWar)
                        {
                            _loc_14 = _ctrl.nineRegions.equitData[_loc_15];
                        }
                        if (_type == WarType.TopWarWar)
                        {
                            _loc_14 = _ctrl.topWar.equitData[_loc_15];
                        }
                        if (_loc_14 != null)
                        {
                            _loc_16 = ItemType.getItemSuffix(_loc_14.equitItemId);
                            _loc_10 = _loc_10 + _loc_16;
                            _loc_11 = MonsterType.sameResource(_loc_10);
                        }
                    }
                    _loc_11 = _loc_11 + WarType.getMiniSuffix(_type);
                    _loc_12 = WarType.warAdditionalEffect(_loc_10);
                    _loc_13 = WarType.warStuntEffect(_loc_12);
                    if (_loc_12 != "")
                    {
                        signs.push(_loc_12);
                        urls.push(URI.stuntsUrl + _loc_12 + ".swf");
                        if (_loc_13 != "")
                        {
                            signs.push(_loc_13);
                            urls.push(URI.stuntsUrl + _loc_13 + ".swf");
                        }
                    }
                    if (signs.indexOf(_loc_11) == -1)
                    {
                        signs.push(_loc_11);
                        urls.push(URI.warRolesUrl + _loc_11 + ".swf");
                    }
                    if (_loc_5.indexOf(_loc_9) == -1)
                    {
                        _loc_5.push(_loc_9);
                    }
                }
                return _loc_5;
            }// end function
            ;
            var hasMonster:* = WarType.hasMonster(this._type);
            var originSigns1:* = this.deal(this._warData.attackerSoldiers, this._warData.attackerMainPlayerRoleId, this._warData.attackerMainRoleSuffix, false);
            var originSigns2:* = this.deal(this._warData.defenderSoldiers, this._warData.defenderMainPlayerRoleId, this._warData.defenderMainRoleSuffix, hasMonster);
            this.extractStuntData(signs, urls, originSigns1, false);
            this.extractStuntData(signs, urls, originSigns2, hasMonster);
            this.addonRole(signs, urls);
            this.addonWarIcon(signs, urls);
            return [signs, urls];
        }// end function

        protected function extractStuntData(param1:Array, param2:Array, param3:Array, param4:Boolean) : void
        {
            var _loc_6:String = null;
            var _loc_7:String = null;
            if (WarType.hasStunt(this._type) == false)
            {
                return;
            }
            var _loc_5:* = param4 ? (RoleStunt.getMonsterStunts(param3)) : (RoleStunt.getRoleStunts(param3));
            for each (_loc_6 in _loc_5)
            {
                
                if (RoleAction.isStunt(_loc_6) == false)
                {
                    continue;
                }
                param1.push(_loc_6);
                param2.push(URI.stuntsUrl + _loc_6 + ".swf");
                _loc_7 = this.AdditionalStunt(_loc_6);
                if (_loc_7 != "")
                {
                    param1.push(_loc_7);
                    param2.push(URI.stuntsUrl + _loc_7 + ".swf");
                }
            }
            return;
        }// end function

        private function AdditionalStunt(param1:String) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case RoleStunt.YaoShouAnYing:
                {
                    _loc_2 = RoleStunt.KuangShouZhiLi;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            param1.push("WarIcon");
            param2.push(URI.missionUrl + MissionType.getSectionSignByMissionId(this.missionId) + "/" + "war_icon" + ".png");
            if (FunctionType.isOpened(FunctionType.StudyStunt))
            {
                param1.push("Aura");
                param2.push(URI.effectsUrl + "aura.swf");
            }
            return;
        }// end function

        protected function addonRole(param1:Array, param2:Array) : void
        {
            if (this._effect == null)
            {
                param1.push("EnterWarEffect");
                param2.push(URI.assetsUrl + "enter_war_effect.swf");
            }
            if (param1.indexOf("WarResources") == -1)
            {
                param1.push("WarResources");
                param2.push(_view.getAssetsUrl("WarResources"));
            }
            return;
        }// end function

        private function getExportObject(param1:String, param2:File) : void
        {
            var _loc_3:Class = null;
            var _loc_4:Class = null;
            var _loc_5:String = null;
            var _loc_6:Class = null;
            var _loc_7:Class = null;
            switch(param1)
            {
                case "EnterWarEffect":
                {
                    _loc_3 = param2.getClassByName("EnterWarEffect") as Class;
                    this._effect = new _loc_3 as MovieClip;
                    this._effect.gotoAndStop(1);
                    this._effect.addEventListener("finish", this.onEffectFinish);
                    break;
                }
                case "War":
                {
                    this._cWar = param2.getClassByName("War") as Class;
                    break;
                }
                case "WarResources":
                {
                    this._warResources = param2;
                    break;
                }
                case "WarIcon":
                {
                    this._warIcon = param2.bitmap;
                    break;
                }
                case "Background":
                {
                    _loc_4 = param2.getClassByName("Bmd");
                    this.background = new _loc_4 as BitmapData;
                    break;
                }
                case "Aura":
                {
                    this._roleBitmapDatas["Aura"] = param2.getClassByName("Aura");
                    break;
                }
                default:
                {
                    _loc_5 = param1.replace(/T\dQ\d$""T\dQ\d$/, "");
                    if (RoleAction.isStunt(_loc_5) == false || RoleAction.isBMD(_loc_5))
                    {
                        _loc_6 = param2.getClassByName("RoleBmd");
                        this._roleBitmapDatas[param1] = new _loc_6;
                        if (RoleStunt.FeiYuJian == _loc_5)
                        {
                            this._roleBitmapDatas[param1 + "Start"] = param2.getClassByName("RoleBmdStart");
                        }
                    }
                    else
                    {
                        _loc_7 = param2.getClassByName("RoleMC");
                        this._roleBitmapDatas[param1] = _loc_7;
                    }
                    break;
                }
            }
            return;
        }// end function

        protected function render() : void
        {
            _view.closeEvent();
            this.removeEffect();
            this.removeTimeOut();
            this.createTarget();
            _popup.addView(this, this._war.content);
            _popup.addMask(false, 1);
            var isNewVip:* = VIPType.check(VIPType.Level4) && _ctrl.player.level < 25;
            this._war.isAdvancedTester = _ctrl.player.isAdvancedTester || Config.EnableWarIgnoreButton || isNewVip;
            this._war.warType = this._type;
            this._war.playerId = _ctrl.player.playerId;
            this._war.nickName = _ctrl.player.nickname;
            this._war.roleId = _ctrl.player.mainRoleId;
            this._war.playerRoleId = _ctrl.player.mainPlayerRoleId;
            this._war.mainRoleStunt = this._mainRoleStunt;
            this._war.assetsUrl = URI.assetsUrl;
            this._war.iconsUrl = URI.iconsUrl;
            this._war.goodsIconUrl = URI.goodsIconUrl;
            this._war.reportUrl = this.reportUrl;
            this._war.copyReportEnabled = URI.isBaidu == false;
            var sUrl:* = URI.assetsUrl + "war_sport_report.swf";
            this._war.sportReportUrl = sUrl + "?v=" + URI.getVersion(sUrl);
            sUrl = URI.assetsUrl + "war_sport_detail.swf";
            this._war.sportDetailUrl = sUrl + "?v=" + URI.getVersion(sUrl);
            this._war.onSportDetail = this.onSportDetail;
            this._war.warIcon = this._warIcon;
            this._war.background = this.background;
            this._war.warResources = this._warResources;
            this._war.roleBitmapDatas = this._roleBitmapDatas;
            this._war.tip = _view.tip.iTip;
            this._war.alert = _view.alert.iAlert;
            this._war.onSendChat = this.onSendChatHandler;
            this._war.onCopy = this.onCopyHandler;
            this._war.onClose = this.onCloseBaseHandler;
            this._war.compareStrengthVisible = FunctionType.isOpened(FunctionType.FirstAttcak);
            this._war.onCompareStrength = this.onCompareStrength;
            this._war.init();
            this.reposition();
            if (WarType.War == this._type)
            {
                _view.missionFailedTips.close();
            }
            if (this.onAfterAdded is Function)
            {
                this.onAfterAdded();
            }
            if (_ctrl.mission.warAura > 0 && !this._roleBitmapDatas["Fusion"])
            {
                File.loadList([URI.effectsUrl + "fusion.swf"], function (param1:Array) : void
            {
                _roleBitmapDatas["Fusion"] = (param1[0] as File).getClassByName("Fusion");
                return;
            }// end function
            );
            }
            return;
        }// end function

        protected function createTarget() : void
        {
            this._war = new this._cWar();
            this._war.warData = _ctrl.mission.warData;
            this._war.sportDetailData = {worship:_ctrl.mission.worship, aura:_ctrl.mission.warAura};
            this._war.onWin = this.onWin;
            SoundManage.playBgSound(URI.soundUrl + (this.isBoss ? ("BossWar.mp3") : ("War.mp3")));
            return;
        }// end function

        protected function onSendChatHandler(param1:String, param2:String) : void
        {
            var _loc_4:int = 0;
            var _loc_3:* = this.reportArgs;
            if (_loc_3.length > 0)
            {
                _loc_3.unshift(ChatMsgType.WarReport, param1, WarType.War == this._type ? (MonsterType.getMonsterIdByName(param2)) : (param2));
                _loc_4 = _view.superSport.topRank;
                if (_loc_4 <= 0)
                {
                    _loc_4 = 1;
                }
                _loc_3.push(_loc_4);
                _view.chat.showMsg(_loc_3);
            }
            return;
        }// end function

        private function onCloseBaseHandler(param1:Boolean) : void
        {
            this.opened = false;
            if (this._onWarClose is Function)
            {
                this._onWarClose();
            }
            this.onCloseHandler(param1);
            return;
        }// end function

        protected function onCopyHandler() : void
        {
            _data.call(Mod_WarReport_Base.record_war_report, null, []);
            return;
        }// end function

        protected function onCloseHandler(param1:Boolean) : void
        {
            this.IsGetWarData = false;
            this._win = param1;
            this.closeWar();
            if (this.onClose is Function)
            {
                this.onClose(param1);
            }
            if (this.isLastMonster == false)
            {
                _view.triggerDelayed(DelayType.LevelUp, DelayType.Experience, DelayType.HealthUpdateMessage, DelayType.PartnerUpgrade, DelayType.UpdateHealth, DelayType.PassTower);
            }
            else
            {
                _view.triggerDelayed(DelayType.MissionAward, DelayType.HealthUpdateMessage, DelayType.UpdateHealth);
            }
            if (_view.hasDelayed(DelayType.QuestTrace))
            {
                _view.triggerDelayed(DelayType.QuestTrace);
            }
            else
            {
                _view.toolbar.loadQuestTrace();
            }
            if (WarType.War == this._type && param1 == false)
            {
                _view.missionFailedTips.showMission(this.missionId);
            }
            if (this._type != WarType.War)
            {
                this.clearRoles();
            }
            _ctrl.mission.zeroWarAura();
            return;
        }// end function

        private function onWin() : void
        {
            SoundManage.playBgSound("");
            return;
        }// end function

        private function onSportDetail(param1:int) : void
        {
            if (param1 == _ctrl.player.playerId)
            {
                _view.roleMsg.show();
            }
            else
            {
                _view.otherRoleMsg.init(param1, "");
                _view.otherRoleMsg.show();
            }
            return;
        }// end function

        protected function closeWar() : void
        {
            _popup.closeView(this);
            _popup.removeMask();
            this._win = false;
            _requested = false;
            this.background = null;
            this._war = null;
            Helper.gc();
            _view.openEvent();
            return;
        }// end function

        public function clearRoles() : void
        {
            this._war = null;
            this._warIcon = null;
            this._signs = [];
            this._urls = [];
            this._roleBitmapDatas = {};
            Helper.gc();
            return;
        }// end function

        private function onCompareStrength(param1:int, param2:String) : void
        {
            var playerId:* = param1;
            var nickname:* = param2;
            _view.otherRoleMsg.init(playerId, nickname);
            _view.otherRoleMsg.onAfterOpened = function () : void
            {
                _view.otherRoleMsg.onAfterOpened = null;
                _view.otherRoleMsg.onStrength();
                return;
            }// end function
            ;
            _view.otherRoleMsg.show();
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function get reportArgs() : Array
        {
            this.onCopyHandler();
            return this._reportArgs;
        }// end function

        private function get reportUrl() : String
        {
            var _loc_2:String = null;
            var _loc_3:URLVariables = null;
            var _loc_1:String = "";
            if (this._warData && this._warData.reportId > 0)
            {
                _loc_2 = URI.getVersion(URI.assetsUrl + _loc_1);
                this._reportArgs = [Config.GameVersion, this._type, this._warData.reportId, this.missionId, _loc_2];
                _loc_1 = "strategy_war/" + Config.GameVersion + ".swf";
                _loc_3 = new URLVariables();
                _loc_3.v = Config.GameVersion;
                _loc_3.w = this._type;
                _loc_3.r = this._warData.reportId;
                _loc_3.m = this.missionId;
                _loc_3.c = _loc_2;
                _loc_1 = URI.serverUrl + "war.php?" + _loc_3.toString();
            }
            else
            {
                this._reportArgs = [];
            }
            return _loc_1;
        }// end function

        public function formatReportUrl(param1:Array) : void
        {
            var _loc_2:* = new URLVariables();
            _loc_2.v = param1[0];
            _loc_2.w = param1[1];
            _loc_2.r = param1[2];
            _loc_2.m = param1[3];
            _loc_2.c = param1[4];
            var _loc_3:* = URI.serverUrl + "war.php?" + _loc_2.toString();
            navigateToURL(new URLRequest(_loc_3), "_blank");
            return;
        }// end function

        public function get missionCompleted() : Boolean
        {
            return this.isLastMonster && this._win;
        }// end function

        public function get auraClass() : Class
        {
            return this._roleBitmapDatas["Aura"];
        }// end function

        public function get fusionClass() : Class
        {
            return this._roleBitmapDatas["Fusion"];
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                if (this._effect != null)
                {
                    this._effect.scaleX = Structure.stageWidth / 500;
                    this._effect.scaleY = Structure.stageHeight / 300;
                }
                if (this.inStage == false)
                {
                    return;
                }
                this._war.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

    }
}
