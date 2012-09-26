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
    import com.assist.view.pack.*;
    import com.assist.view.sound.*;
    import com.assist.view.toolbar.*;
    import com.controllers.*;
    import com.haloer.data.*;
    import com.haloer.net.*;
    import com.lang.client.com.assist.view.info.*;
    import com.lang.client.com.views.toolbar.*;
    import com.protocols.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class ToolbarView extends Base implements IView
    {
        private var _toolbar:IToolbar;
        private var _alert:IAlert;
        private var _firstInTown:Boolean = true;
        private var _soundMuteEnabled:Boolean = false;
        public var isBuy:Boolean = false;
        public var isCanBuy:Boolean = true;
        public var superSportCdTime:Number;
        public var superSportChallengeCount:int;
        private var _travelEventEndTime:Number;
        public var travelEventCdTime:int;
        public var travelEventJoinCount:int;
        public var travelEventTotalCount:int;
        private var strCanMultMission:String = "";
        private var _aryDeployRoleId:Array;
        private var _aryDeployRoleIdTemp:Array;
        private var _aryEquipList:Array;
        private var _objMinUpgradeEquip:Object = null;
        private var isJustEquipUpgrade:Boolean = false;
        private var _minResearchSkill:int;
        private var _lastTraceVisible:Boolean = true;
        private var _first:Boolean = true;
        private var _fateTipSprite:FateTipSprite;
        private var _soulTipSprite:SoulTipSprite;
        private var _isOpenFactionActivity:Boolean = false;
        public var showChatId:int = 0;
        private var _hasDeploy:Boolean = false;
        private var _hasFate:Boolean = false;
        public var lastState:int = 0;
        private var _takeBibleData:Object = null;
        private var _robList:Array;
        private var _showMessageList:Array;
        private var thisAwardList:Array;
        public var coinDelay:Boolean;
        private var _blockedHealth:Boolean = false;
        private var _oldPower:int = 0;
        public var skillDelay:Boolean;
        private var _loadEffectCircle:Class;
        private var _miniMap:IMiniMap;
        private var _practiceTime:int = 0;
        private var _px:int = 16777215;
        private var _py:int = 16777215;

        public function ToolbarView()
        {
            this._aryDeployRoleId = [];
            this._aryDeployRoleIdTemp = [];
            this._aryEquipList = [];
            this._robList = [];
            this._showMessageList = [];
            this.thisAwardList = [];
            return;
        }// end function

        public function get width() : Number
        {
            return this._toolbar.content.width;
        }// end function

        public function get height() : Number
        {
            return this._toolbar.content.height;
        }// end function

        public function get content() : Sprite
        {
            return this._toolbar.content;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._toolbar && this._toolbar.content.parent;
        }// end function

        public function init() : void
        {
            this._toolbar = _view.getAssetsObject("Toolbar", "Toolbar") as IToolbar;
            this._toolbar.tip = _view.tip.iTip;
            this._toolbar.goodsIconUrl = URI.goodsIconUrl;
            this._toolbar.addonsUrl = URI.addonsUrl;
            this._toolbar.init();
            this._toolbar.alert = _view.alert.iAlert;
            this._alert = _view.alert.iAlert;
            this.playerData();
            this.buffInfo();
            this.functionLink();
            this.activityInfo();
            this.initMiniMap();
            this.questTrace();
            this.chat();
            this.functionBar();
            this.keepAlive();
            this.friend();
            _view.addToPositionList(sign, this.reposition);
            this.autoPractice();
            _view.whatsNew.show();
            this.load_effect_circle();
            this.loadFunctionBarEffect();
            _view.addToFrameProcessList("ToolbarUpdateMouseCursor", this.updateMouseCursor);
            return;
        }// end function

        private function updateMouseCursor() : void
        {
            MouseCursor.updateCursorXY();
            return;
        }// end function

        public function show() : void
        {
            this._toolbar.content.visible = true;
            return;
        }// end function

        public function hide() : void
        {
            this._toolbar.content.visible = false;
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            if (this._toolbar.content.parent)
            {
                this._toolbar.content.parent.removeChild(this._toolbar.content);
            }
            return;
        }// end function

        public function clear() : void
        {
            _data.cancelPatch(Mod_Player_Base.receive_player_delay_notify_message);
            _data.cancelPatch(Mod_Notify_Base.mission_award);
            _data.cancelPatch(Mod_Notify_Base.pk_award);
            _data.cancelPatch(Mod_Friend_Base.notify_online_state);
            _data.cancelPatch(Mod_Friend_Base.notify_message_count);
            _data.cancelPatch(Mod_CampWar_Base.notify);
            _data.cancelPatch(Mod_HeroesWar_Base.notify);
            _data.cancelPatch(Mod_Notify_Base.role_num_notify);
            _data.cancelPatch(Mod_Notify_Base.new_research_notify);
            _data.cancelPatch(Mod_Notify_Base.new_partners_notify);
            this._toolbar.clear();
            return;
        }// end function

        public function set playerDataVisible(param1:Boolean) : void
        {
            this._toolbar.playerDataVisible = param1;
            this._toolbar.visibleBuff = param1;
            return;
        }// end function

        public function set functionLinkVisible(param1:Boolean) : void
        {
            this._toolbar.functionLinkVisible = param1;
            return;
        }// end function

        public function reposition() : void
        {
            if (this.inStage == true)
            {
                this._toolbar.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            Tip.offset = Structure.stageOffset;
            _structure.reposition();
            _view.reposition();
            _view.achievementComplete.reposition(false);
            _view.activities.reposition(false);
            _view.alert.reposition();
            _view.beelzebubTrialsWar.reposition(false);
            _view.chat.reposition(false);
            _view.delayMessage.reposition(false);
            _view.dreamSectionWar.reposition(false);
            _view.dujieWar.reposition(false);
            _view.factionWar.reposition(false);
            _view.fate.reposition(false);
            _view.friendMessage.reposition(false);
            _view.fingerGuess.reposition(false);
            _view.getPeachWar.reposition(false);
            _view.guide.reposition();
            _view.haloRoleWar.reposition(false);
            _view.inCampWar.reposition(false);
            _view.initLoading.reposition(false);
            _view.lodge.reposition(false);
            _view.miniFactionWar.reposition(false);
            _view.missionFailedTips.reposition(false);
            _view.multiWar.reposition(false);
            _view.pkWar.reposition(false);
            _view.processTip.reposition(false);
            _view.sealSoul.reposition(false);
            _view.sendFlower.reposition(false);
            _view.sportWar.reposition(false);
            _view.superSport.reposition(false);
            _view.superSportWar.reposition(false);
            _view.takeBibleRoad.reposition(false);
            _view.takeBibleWar.reposition(false);
            _view.tip2.reposition();
            _view.towerWar.reposition(false);
            _view.war.reposition(false);
            _view.world.reposition(false);
            _view.newWorld.reposition(false);
            _view.worldBossWar.reposition(false);
            _view.nineRegionsWar.reposition(false);
            _view.nineRegionsHiddenWar.reposition(false);
            _view.worldNotice.reposition(false);
            _view.rollCake.reposition(false);
            _view.factionRollCake.reposition(false);
            _view.zodiacWar.reposition(false);
            _view.studyStunt.reposition(false);
            _view.topWarWar.reposition(false);
            _view.factionMonsterWar.reposition(false);
            _view.activitiesShow.reposition();
            _view.furnaceMap.reposition();
            _view.topWarMap.reposition();
            _view.beelzebubTrialsMap.reposition();
            _view.nineRegionsMap.reposition();
            _view.topWarCreate.reposition();
            _view.newTopWar.reposition();
            _view.topThrone.reposition();
            _view.findImmortal.reposition();
            return;
        }// end function

        public function repositionInTown() : void
        {
            if (_view.townMap.inStage && this._firstInTown == true)
            {
                this._firstInTown = false;
                this.reposition();
            }
            return;
        }// end function

        public function set vipLevel(param1:int) : void
        {
            this._toolbar.vipLevel = param1;
            return;
        }// end function

        public function checkRechargeVisible() : void
        {
            this._toolbar.rechargeVisible = VIPType.enabled;
            return;
        }// end function

        public function soundMute(param1:Boolean) : void
        {
            this._toolbar.soundMute(param1);
            this._soundMuteEnabled = param1;
            return;
        }// end function

        private function playerData() : void
        {
            this.vipLevel = _ctrl.player.vipLevel;
            this._toolbar.onPlayerIcon = _view.roleMsg.switchSelf;
            var url:* = URI.avatarUrl + RoleType.getRoleSign(_ctrl.player.mainRoleId) + ".swf";
            this._toolbar.loadPlayerAvatar(url);
            this._toolbar.onSoundControl = function () : void
            {
                if (_soundMuteEnabled)
                {
                    _view.setting.openSound();
                }
                else
                {
                    _view.setting.closeSound();
                }
                return;
            }// end function
            ;
            this._toolbar.onBuyPower = this.buy_power;
            this._toolbar.onPlayerIconOver = this.MainPlayerInfo;
            this.MainPlayerInfo();
            this._toolbar.onRecharge = _view.vip.switchSelf;
            this.checkRechargeVisible();
            this.updateCoins();
            this.updateIngot();
            this._toolbar.nickName = _ctrl.player.nickname;
            this.updateHealth();
            this.updatePower();
            this.updateLevel();
            this.initBuffer();
            this.rune();
            return;
        }// end function

        public function buy_power() : void
        {
            this.isBuy = true;
            _data.call(Mod_Player_Base.buy_power, this.buyPowerCallBack, []);
            return;
        }// end function

        private function buyPowerCallBack() : void
        {
            var _loc_1:* = this._ctrl.player.buyPower;
            switch(_loc_1.msg)
            {
                case Mod_Player_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(playerDataLang.NoIngot);
                    this.isCanBuy = false;
                    break;
                }
                case Mod_Player_Base.FULL_BUY_TIMES:
                {
                    _view.showTip(playerDataLang.NoPowerCount);
                    this.isCanBuy = false;
                    break;
                }
                case Mod_Player_Base.SUCCESS:
                {
                    this._toolbar.powerInfo = _loc_1;
                    this.isCanBuy = true;
                    this._view.missionPractice.getLostPowerNum = _loc_1.buyNum;
                    this._view.heroPractice.getLostPowerNum = _loc_1.buyNum;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.isBuy = false;
            return;
        }// end function

        private function MainPlayerInfo() : void
        {
            _data.call(Mod_Player_Base.player_info_contrast, this.PlayerInfoContrastCallBack, [this._ctrl.player.playerId], false);
            return;
        }// end function

        private function PlayerInfoContrastCallBack() : void
        {
            var _loc_1:* = this._ctrl.player.playerInfoContrastData;
            var _loc_2:* = this.isShowPlayerInfo;
            if (_loc_2 == false)
            {
                this._toolbar.PlayerInfo = "";
                return;
            }
            var _loc_3:String = "";
            if (ActivityType.FactionLevel >= 1)
            {
                _loc_3 = playerDataLang.FactionName + _loc_1.factionName + "\n";
            }
            var _loc_4:* = playerDataLang.RankIng + _loc_1.rankIng + "\n" + _loc_3 + playerDataLang.Combat + _loc_1.combat + "\n" + playerDataLang.Fame + _loc_1.fame + "\n" + playerDataLang.Skill + _loc_1.skill + "\n" + playerDataLang.AchievmentPoints + _loc_1.achievmentPoints + "\n" + playerDataLang.FirstAttack + _loc_1.firstAttack + "\n" + playerDataLang.StatePoint + _loc_1.statePoint + "\n" + playerDataLang.FlowerCount + _loc_1.flowerCount;
            this._toolbar.PlayerInfo = "<font color=\"#ffffff\">" + _loc_4 + "</font>";
            return;
        }// end function

        public function get isShowPlayerInfo() : Boolean
        {
            var _loc_1:* = this._ctrl.mission.renderTownMission(TownType.getId(TownType.LiShuShan));
            var _loc_2:* = _loc_1[0];
            var _loc_3:* = this._ctrl.player.missionKey >= _loc_2.lock;
            return _loc_3;
        }// end function

        public function get_player_info_by_username(param1:String, param2:Function) : void
        {
            this._data.call(Mod_Player_Base.get_player_info_by_username, param2, [param1], false);
            return;
        }// end function

        public function getPlayerInfoResult(param1:int) : void
        {
            this._view.showTip("fild");
            return;
        }// end function

        private function rune() : void
        {
            this.runeVisible = false;
            this._toolbar.onOpenRune = _view.rune.switchSelf;
            return;
        }// end function

        public function set runeVisible(param1:Boolean) : void
        {
            this._toolbar.runeVisible = param1;
            return;
        }// end function

        public function set showBuff(param1:Object) : void
        {
            this._toolbar.addBuff = param1;
            return;
        }// end function

        public function set removeBuff(param1:String) : void
        {
            this._toolbar.removeBuff = param1;
            return;
        }// end function

        public function set visbleBuff(param1:Boolean) : void
        {
            this._toolbar.visibleBuff = param1;
            return;
        }// end function

        private function buffInfo() : void
        {
            this._toolbar.onDoubleRemoveBuff = function (param1:String) : void
            {
                if (param1 == BufferType.Mounts)
                {
                    _data.call(Mod_Item_Base.dismount_transport, null, []);
                }
                else if (param1 == BufferType.Avatar)
                {
                    _data.call(Mod_Item_Base.avatar_card_off, null, []);
                }
                else if (param1 == BufferType.FactionClothes)
                {
                    _data.call(Mod_Item_Base.take_off_clothes, null, []);
                }
                return;
            }// end function
            ;
            return;
        }// end function

        private function updateExtraPower() : void
        {
            var _loc_1:* = this._ctrl.player.extraPower;
            var _loc_2:* = this._ctrl.player.maxExtraPower;
            if (_loc_1 <= 0)
            {
                this.removeBuff = BufferType.ExtraPower;
            }
            else
            {
                this.showBuff = {type:BufferType.ExtraPower, doubleClickable:false, sign:BufferType.ExtraPower, name:buffInfoLang.PowerName, effect:Lang.sprintf(buffInfoLang.Powereffect, _loc_1), info:buffInfoLang.PowerInfo};
            }
            return;
        }// end function

        private function updateMountsBuffer() : void
        {
            var _loc_2:Object = null;
            var _loc_1:* = this._ctrl.player.mounts;
            if (_loc_1 == 0)
            {
                this.removeBuff = BufferType.Mounts;
            }
            else
            {
                if (BufferType.MountsSign.length == 0)
                {
                    BufferType.MountsSign[32] = "Cloud";
                    BufferType.MountsSign[1055] = "BaiHu";
                    BufferType.MountsSign[1008] = "FeiJian";
                    BufferType.MountsSign[1094] = "LiuGuangXiangYun";
                    BufferType.MountsSign[1177] = "JinYu";
                    BufferType.MountsSign[1192] = "HuLu";
                    BufferType.MountsSign[1195] = "HuLu2";
                    BufferType.MountsSign[1196] = "FengLeiYi";
                    BufferType.MountsSign[1372] = "QingRenJieZhiYi";
                    BufferType.MountsSign[1482] = "Q0";
                }
                _loc_2 = {};
                _loc_2.doubleClickable = true;
                _loc_2.type = BufferType.Mounts;
                _loc_2.sign = BufferType.MountsSign[_loc_1] || "Cloud";
                _loc_2.name = ItemType.getName(_loc_1);
                _loc_2.info = buffInfoLang.ClickCancel;
                _loc_2.effect = ItemType.getDescription(_loc_1);
                this.showBuff = _loc_2;
            }
            return;
        }// end function

        private function updateAvatarBuffer() : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:String = null;
            var _loc_7:Object = null;
            var _loc_1:* = this._ctrl.player.avatar;
            var _loc_2:* = (this._ctrl.player.avatarCD - getTimer()) * 0.001;
            if (_loc_2 < 0)
            {
                _loc_2 = 0;
                ;
            }
            if (_loc_1 == 0)
            {
                this.removeBuff = BufferType.Avatar;
                this._view.removeFromTimerProcessList(BufferType.Avatar);
            }
            else
            {
                _loc_3 = int(_loc_2 / 3600);
                _loc_4 = int(_loc_2 / 60) % 60;
                _loc_5 = _loc_2 % 60;
                _loc_6 = buffInfoLang.RemainingTime;
                if (_loc_3 > 0)
                {
                    _loc_6 = _loc_6 + (_loc_3 + buffInfoLang.Hours);
                }
                if (_loc_4 > 0)
                {
                    _loc_6 = _loc_6 + (_loc_4 + buffInfoLang.Minute);
                }
                _loc_6 = _loc_6 + (_loc_5 + buffInfoLang.Second);
                if (BufferType.AvatarSign.length == 0)
                {
                    BufferType.AvatarSign[1273] = "QingRenJieZhiYi";
                }
                _loc_7 = {};
                _loc_7.doubleClickable = true;
                _loc_7.type = BufferType.Avatar;
                _loc_7.sign = BufferType.AvatarSign[_loc_1] || BufferType.Avatar;
                _loc_7.name = ItemType.getName(_loc_1);
                _loc_7.info = _loc_6 + "\n" + buffInfoLang.ClickCancel;
                _loc_7.effect = ItemType.getDescription(_loc_1);
                this.showBuff = _loc_7;
                this._view.addToTimerProcessList(BufferType.Avatar, this.updateAvatarBuffer);
            }
            return;
        }// end function

        public function updateFactionBlessing(param1:Object) : void
        {
            if (param1["count"] <= 0)
            {
                this.removeBuff = BufferType.FactionBlessing;
                return;
            }
            this.showBuff = {type:BufferType.FactionBlessing, doubleClickable:false, sign:BufferType.FactionBlessing, name:buffInfoLang.FactionBlessingName, effect:Lang.sprintf(buffInfoLang.FactionBlessingEffect, HtmlText.green(param1["count"])), info:Lang.sprintf(buffInfoLang.FactionBlessingInfo, HtmlText.green("+" + param1["coin_add"] + "%"))};
            return;
        }// end function

        public function updateMarsBlessing(param1:Object) : void
        {
            if (param1["count"] <= 0)
            {
                this.removeBuff = BufferType.MarsBlessing;
                return;
            }
            this.showBuff = {type:BufferType.MarsBlessing, doubleClickable:false, sign:BufferType.MarsBlessing, name:buffInfoLang.MarsBlessingName, effect:Lang.sprintf(buffInfoLang.MarsBlessingEffect, HtmlText.green(param1["count"])), info:Lang.sprintf(buffInfoLang.MarsBlessingInfo, HtmlText.green("+" + param1["exp_add"] + "%"))};
            return;
        }// end function

        public function updateCampWarInspire(param1:int) : void
        {
            if (param1 <= 0)
            {
                this.removeBuff = BufferType.CampWarInspire;
                return;
            }
            this.showBuff = {type:BufferType.CampWarInspire, doubleClickable:false, sign:BufferType.CampWarInspire, name:buffInfoLang.WarName, effect:Lang.sprintf(buffInfoLang.WarEffect, param1), info:buffInfoLang.WarInfo};
            return;
        }// end function

        private function initBuffer() : void
        {
            this.updateMountsBuffer();
            this.updateAvatarBuffer();
            this.updateExtraPower();
            this._view.factionBlessing.getBlessingCount();
            this._data.call(Mod_Player_Base.update_player_data, null, [Mod_Player_Base.PLAYER_INIT_MEDICAL]);
            this._data.call(Mod_Player_Base.update_player_data, null, [Mod_Player_Base.PLAYER_MEDICAL]);
            this._data.call(Mod_Player_Base.update_player_data, null, [Mod_Player_Base.CAN_INCENSE_COUNT]);
            return;
        }// end function

        public function updateWorldBossBuffer(param1:int, param2:String) : void
        {
            if (param1 <= 0)
            {
                this.removeBuff = param2;
                return;
            }
            this.showBuff = {type:param2, doubleClickable:false, sign:BufferType.WorldBossInspire, name:buffInfoLang.WarName, effect:Lang.sprintf(buffInfoLang.WarEffect, param1), info:buffInfoLang.WarInfo};
            return;
        }// end function

        public function factionClothes(param1:Object = null) : void
        {
            if (!param1)
            {
                this.removeBuff = BufferType.FactionClothes;
                return;
            }
            this.showBuff = {type:BufferType.FactionClothes, doubleClickable:true, sign:BufferType.FactionClothes, name:"", effect:param1.effect, info:param1.info + "\n" + buffInfoLang.ClickCancel};
            return;
        }// end function

        public function renderFunctionLink(param1:Object) : void
        {
            this._toolbar.renderFunctionLink(param1);
            return;
        }// end function

        public function renderFunctionLinkBtnTip(param1:String, param2:String) : void
        {
            this._toolbar.renderFunctionLinkBtnTip(param1, param2);
            return;
        }// end function

        public function renderFunctionTextTip(param1:String, param2:String) : void
        {
            this._toolbar.renderFunctionTextTip(param1, param2);
            return;
        }// end function

        private function functionLink() : void
        {
            this._toolbar.onLinkTextClick = this.onLinkTextClick;
            this._toolbar.onLinkBtnClick = this.onLinkBtnClick;
            this._view.addToTimerProcessList(this.sign + Math.random(), this.functionLinkTimer);
            return;
        }// end function

        private function functionLinkTimer() : void
        {
            this.travelEventCdTime = Math.ceil((this._travelEventEndTime - new Date().time) / 1000);
            if (this.travelEventCdTime > 0)
            {
                if (this.travelEventCdTime % 60 == 0)
                {
                    this.renderTravelEventTip(Math.ceil(this.travelEventCdTime / 60));
                }
            }
            else
            {
                this.travelEventCdTime = 0;
            }
            this.renderTravelEventLink(this.travelEventCdTime);
            if (this.superSportCdTime > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this.superSportCdTime - 1;
                _loc_1.superSportCdTime = _loc_2;
                if (this.superSportCdTime % 60 == 0)
                {
                    this.renderSuperSportTip(Math.ceil(this.superSportCdTime / 60));
                }
            }
            else
            {
                this.superSportCdTime = 0;
            }
            this.renderSuperSport(this.superSportCdTime);
            this.setFunctionLinkPoint();
            return;
        }// end function

        private function onLinkTextClick(param1:String) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            switch(param1)
            {
                case FunctionType.Farm:
                {
                    this._view.farm.switchSelf();
                    break;
                }
                case FunctionType.MultiMission:
                {
                    if (this._view.multiMission.inStage)
                    {
                        this._view.multiMission.clear();
                    }
                    else
                    {
                        this._view.multiMission.show();
                    }
                    break;
                }
                case FunctionType.TravelEvent:
                {
                    if (this.travelEventJoinCount >= this.travelEventTotalCount)
                    {
                        this._view.showTip(functionLinkLang.CountUsed);
                        return;
                    }
                    if (this.travelEventCdTime > 0)
                    {
                        this._view.travelEvent.cancelCd();
                        return;
                    }
                    this._view.travelEvent.switchSelf();
                    break;
                }
                case FunctionType.Research:
                {
                    this._view.research.switchSelf();
                    break;
                }
                case FunctionType.Upgrade:
                {
                    this._view.upgrade.switchSelf();
                    break;
                }
                case ActivityType.FactionRollCake:
                {
                    if (this._view.missionMap.inStageWithTip)
                    {
                        return;
                    }
                    _loc_2 = TownType.getTownNPCIdByFunc(this._ctrl.player.mapId, NPCType.FactionGodNPC);
                    if (_loc_2 == 0)
                    {
                        this._view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
                    }
                    this.showFactionRollCake();
                    break;
                }
                case FunctionType.SuperSport:
                {
                    if (this.superSportCdTime > 0)
                    {
                        _loc_3 = Math.ceil(this.superSportCdTime / 60);
                        this._view.superSport.clearCdTimer(_loc_3);
                        return;
                    }
                    this._view.superSport.switchSelf();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onLinkBtnClick(param1:String) : void
        {
            var _loc_2:int = 0;
            switch(param1)
            {
                case FunctionType.TravelEvent:
                {
                    this._view.travelEvent.cancelCd();
                    break;
                }
                case FunctionType.SuperSport:
                {
                    _loc_2 = Math.ceil(this.superSportCdTime / 60);
                    this._view.superSport.clearCdTimer(_loc_2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function clearFunctionLink() : void
        {
            this._toolbar.clearFunctionLink();
            var _loc_1:int = 0;
            this.travelEventCdTime = 0;
            return;
        }// end function

        public function removeFunctionLink(param1:String) : void
        {
            this._toolbar.removeFunctionLink(param1);
            return;
        }// end function

        private function getFunctionLink(param1:String) : void
        {
            switch(param1)
            {
                case FunctionType.Farm:
                {
                    this._view.farm.getFarmState();
                    break;
                }
                case FunctionType.TravelEvent:
                {
                    this._view.travelEvent.get_activity_info();
                    break;
                }
                case FunctionType.Research:
                {
                    this.getResearchInfo();
                    break;
                }
                case FunctionType.Upgrade:
                {
                    this.get_simple_role_list();
                    break;
                }
                case ActivityType.FactionRollCake:
                {
                    this.getFactionRollCakeInfo();
                    break;
                }
                case FunctionType.SuperSport:
                {
                    this._view.superSport.get_challenge_times();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function showFunctionLink() : void
        {
            if (FunctionType.isOpened(FunctionType.Upgrade))
            {
                this.getFunctionLink(FunctionType.Upgrade);
            }
            if (FunctionType.isOpened(FunctionType.Research))
            {
                this.getFunctionLink(FunctionType.Research);
            }
            if (FunctionType.isOpened(FunctionType.Farm))
            {
                this.getFunctionLink(FunctionType.Farm);
            }
            if (FunctionType.isOpened(FunctionType.TravelEvent))
            {
                this.getFunctionLink(FunctionType.TravelEvent);
            }
            if (FunctionType.isOpened(FunctionType.SuperSport))
            {
                this.getFunctionLink(FunctionType.SuperSport);
            }
            setTimeout(this.setFunctionLinkPoint, 1000);
            setTimeout(this.setFunctionLinkPoint, 2000);
            return;
        }// end function

        public function setFunctionLinkPoint() : void
        {
            this._toolbar.setFunctionLinkPoint();
            return;
        }// end function

        private function getFunctionLinkIndex(param1:String) : int
        {
            var _loc_2:int = 0;
            switch(param1)
            {
                case FunctionType.TravelEvent:
                {
                    var _loc_3:int = 6;
                    _loc_2 = 6;
                    break;
                }
                case FunctionType.Farm:
                {
                    var _loc_3:int = 7;
                    _loc_2 = 7;
                    break;
                }
                case FunctionType.MultiMission:
                {
                    var _loc_3:int = 3;
                    _loc_2 = 3;
                    break;
                }
                case FunctionType.Research:
                {
                    var _loc_3:int = 2;
                    _loc_2 = 2;
                    break;
                }
                case FunctionType.Upgrade:
                {
                    var _loc_3:int = 1;
                    _loc_2 = 1;
                    break;
                }
                case ActivityType.FactionRollCake:
                {
                    var _loc_3:int = 5;
                    _loc_2 = 5;
                    break;
                }
                case FunctionType.SuperSport:
                {
                    var _loc_3:int = 4;
                    _loc_2 = 4;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function renderSuperSport(param1:int) : void
        {
            if (!FunctionType.isOpened(FunctionType.SuperSport))
            {
                return;
            }
            var _loc_2:* = param1 > 0 ? (16777215) : (65280);
            var _loc_3:* = this.superSportChallengeCount > 0 ? (htmlFormat(Lang.sprintf(functionLinkLang.SuperSport, this.superSportChallengeCount), 12, _loc_2, false, true)) : ("");
            var _loc_4:Object = {sign:FunctionType.SuperSport, timeText:param1 == 0 ? ("") : (DateTime.formatFromSecond(param1)), stopText:_loc_3, runText:htmlFormat(functionLinkLang.InSuperSportCd, 12, _loc_2), index:this.getFunctionLinkIndex(FunctionType.SuperSport), time:param1};
            this.renderFunctionLink(_loc_4);
            return;
        }// end function

        public function renderSuperSportTip(param1:int) : void
        {
            this._view.toolbar.renderFunctionLinkBtnTip(FunctionType.SuperSport, HtmlText.orange(Lang.sprintf(functionLinkLang.ClearCd, param1)));
            return;
        }// end function

        public function set travelEventEndTime(param1:Number) : void
        {
            var _loc_2:* = param1;
            this._travelEventEndTime = param1;
            return;
        }// end function

        public function renderTravelEventLink(param1:int) : void
        {
            if (!FunctionType.isOpened(FunctionType.TravelEvent))
            {
                return;
            }
            var _loc_2:* = this.travelEventJoinCount == this.travelEventTotalCount || param1 > 0 ? (16777215) : (65280);
            var _loc_3:Object = {sign:FunctionType.TravelEvent, timeText:param1 == 0 ? ("") : (DateTime.formatFromSecond(param1)), stopText:htmlFormat(functionLinkLang.TravelEvent + "(" + this.travelEventJoinCount + "/" + this.travelEventTotalCount + ")", 12, _loc_2, false, true), runText:htmlFormat(functionLinkLang.InTravelCd, 12, _loc_2), index:this.getFunctionLinkIndex(FunctionType.TravelEvent), time:param1};
            this.renderFunctionLink(_loc_3);
            return;
        }// end function

        public function renderTravelEventTip(param1:int) : void
        {
            this._view.toolbar.renderFunctionLinkBtnTip(FunctionType.TravelEvent, HtmlText.orange(Lang.sprintf(functionLinkLang.ClearCd, param1)));
            return;
        }// end function

        public function setFarmLink(param1:int, param2:int) : void
        {
            this.renderFarmLink(param1, param2);
            return;
        }// end function

        private function renderFarmLink(param1:int, param2:int) : void
        {
            if (!FunctionType.isOpened(FunctionType.Farm))
            {
                return;
            }
            var _loc_3:* = param1 < param2 ? (65280) : (16777215);
            var _loc_4:Object = {sign:FunctionType.Farm, timeText:"", stopText:htmlFormat(functionLinkLang.Farm + "(" + param1 + "/" + param2 + ")", 12, _loc_3, false, true), runText:"", index:this.getFunctionLinkIndex(FunctionType.Farm), time:0};
            this.renderFunctionLink(_loc_4);
            return;
        }// end function

        public function renderMultMissionLink(param1:String) : void
        {
            if (!FunctionType.isOpened(FunctionType.MultiMission))
            {
                return;
            }
            var _loc_2:* = param1;
            if (_loc_2 == "" && this.strCanMultMission != "")
            {
                var _loc_3:* = this.strCanMultMission;
                _loc_2 = this.strCanMultMission;
            }
            this.renderFunctionLink({sign:FunctionType.MultiMission, timeText:"", stopText:_loc_2, runText:"", index:this.getFunctionLinkIndex(FunctionType.MultiMission), time:0});
            this.setFunctionLinkPoint();
            return;
        }// end function

        public function renderCanMultMissionLink(param1:String) : void
        {
            if (!FunctionType.isOpened(FunctionType.MultiMission))
            {
                return;
            }
            var _loc_2:* = param1;
            this.strCanMultMission = param1;
            this.renderFunctionLink({sign:FunctionType.MultiMission, timeText:"", stopText:param1, runText:"", index:this.getFunctionLinkIndex(FunctionType.MultiMission), time:0});
            this.setFunctionLinkPoint();
            return;
        }// end function

        public function renderUpgradeLink(param1:String) : void
        {
            if (!FunctionType.isOpened(FunctionType.Upgrade))
            {
                return;
            }
            this.renderFunctionLink({sign:FunctionType.Upgrade, timeText:"", stopText:param1, runText:"", index:this.getFunctionLinkIndex(FunctionType.Upgrade), time:0});
            this.setFunctionLinkPoint();
            return;
        }// end function

        private function get_simple_role_list() : void
        {
            if (!FunctionType.isOpened(FunctionType.Upgrade))
            {
                return;
            }
            this._data.call(Mod_Role_Base.get_simple_role_list, this.getSimpleRoleListCallBack, [this._ctrl.player.playerId]);
            return;
        }// end function

        private function getSimpleRoleListCallBack() : void
        {
            var _loc_2:Object = null;
            var _loc_3:* = [];
            this._aryDeployRoleId = [];
            var _loc_3:* = [];
            this._aryDeployRoleIdTemp = [];
            var _loc_1:* = this._ctrl.upgrade.getSimpleRoleList();
            for each (_loc_5 in _loc_1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                if (_loc_2["is_deploy"] != Mod_Role_Base.DEPLOY)
                {
                    continue;
                }
                this._aryDeployRoleId.push(_loc_2["id"]);
                this._aryDeployRoleIdTemp.push(_loc_2["id"]);
            }
            if (this._aryDeployRoleIdTemp.length > 0)
            {
                var _loc_3:* = [];
                this._aryEquipList = [];
                this.get_equipment_list(this._aryDeployRoleIdTemp[0]);
            }
            return;
        }// end function

        private function get_equipment_list(param1:int) : void
        {
            this._data.call(Mod_Item_Base.get_equipment_list, this.getEquipmentListCallBack, [0, param1]);
            return;
        }// end function

        private function getEquipmentListCallBack() : void
        {
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            var _loc_1:* = this._ctrl.upgrade.getEquipmentList();
            for each (_loc_6 in _loc_1)
            {
                
                _loc_2 = _loc_5[_loc_4];
                _loc_3 = {};
                var _loc_6:* = _loc_2;
                _loc_3 = _loc_2;
                this._aryEquipList.push(_loc_3);
            }
            this._aryDeployRoleIdTemp.shift();
            if (this._aryDeployRoleIdTemp.length > 0)
            {
                this.get_equipment_list(this._aryDeployRoleIdTemp[0]);
            }
            else
            {
                this.minUpgradeCoinEquip();
            }
            return;
        }// end function

        private function minUpgradeCoinEquip() : void
        {
            var _loc_1:Object = null;
            var _loc_2:Boolean = false;
            this.isJustEquipUpgrade = false;
            var _loc_2:String = null;
            this._objMinUpgradeEquip = null;
            for each (_loc_4 in this._aryEquipList)
            {
                
                _loc_1 = _loc_3[_loc_2];
                if (_loc_1["upgrade_level"] >= this._ctrl.player.level)
                {
                    continue;
                }
                var _loc_4:* = _loc_1;
                this._objMinUpgradeEquip = _loc_1;
                break;
            }
            for each (_loc_4 in this._aryEquipList)
            {
                
                _loc_1 = _loc_3[_loc_2];
                if (_loc_1["upgrade_level"] >= this._ctrl.player.level)
                {
                    continue;
                }
                if (_loc_1["upgrade_price"] < this._objMinUpgradeEquip["upgrade_price"])
                {
                    var _loc_4:* = _loc_1;
                    this._objMinUpgradeEquip = _loc_1;
                }
            }
            this.checkIsCanEquipUpgrade();
            return;
        }// end function

        private function checkIsCanEquipUpgrade() : void
        {
            if (!FunctionType.isOpened(FunctionType.Upgrade))
            {
                return;
            }
            if (this._objMinUpgradeEquip != null && this._ctrl.player.coins >= this._objMinUpgradeEquip["upgrade_price"])
            {
                this.renderUpgradeLink(htmlFormat(functionLinkLang.CanUpgrade, 12, HtmlText.Green, false, true));
            }
            else
            {
                this.renderUpgradeLink("");
            }
            return;
        }// end function

        private function checkIsRoleOnDeploy(param1:int) : Boolean
        {
            var _loc_3:int = 0;
            var _loc_2:Boolean = false;
            for each (_loc_6 in this._aryDeployRoleId)
            {
                
                _loc_3 = _loc_5[_loc_4];
                if (param1 == _loc_3)
                {
                    var _loc_6:Boolean = true;
                    _loc_2 = true;
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function checkRoleItem(param1:int) : Boolean
        {
            var _loc_2:Object = null;
            for each (_loc_5 in this._aryEquipList)
            {
                
                _loc_2 = _loc_4[_loc_3];
                if (_loc_2["player_role_id"] == param1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function removeRoleItem(param1:int) : void
        {
            var _loc_3:Object = null;
            var _loc_2:* = this._aryEquipList.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aryEquipList[_loc_2] as Object;
                if (_loc_3["player_role_id"] == param1)
                {
                    this._aryEquipList.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function upgradeEquipBack(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:Object = null;
            var _loc_5:Boolean = true;
            this.isJustEquipUpgrade = true;
            for each (_loc_7 in this._aryEquipList)
            {
                
                _loc_4 = _loc_6[_loc_5];
                if (_loc_4["player_item_id"] == param1)
                {
                    var _loc_7:* = param2;
                    _loc_4["upgrade_level"] = param2;
                    var _loc_7:* = param3;
                    _loc_4["upgrade_price"] = param3;
                    break;
                }
            }
            return;
        }// end function

        public function deployBack(param1:Array) : void
        {
            var _loc_2:Object = null;
            for each (_loc_5 in param1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                if (_loc_2["is_deploy"] == 0 && this.checkRoleItem(_loc_2["player_role_id"]))
                {
                    this.removeRoleItem(_loc_2["player_role_id"]);
                    this.minUpgradeCoinEquip();
                    break;
                }
            }
            for each (_loc_5 in param1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                if (_loc_2["is_deploy"] == 1 && !this.checkIsRoleOnDeploy(_loc_2["player_role_id"]))
                {
                    this.get_equipment_list(_loc_2["player_role_id"]);
                }
            }
            var _loc_3:* = [];
            this._aryDeployRoleId = [];
            for each (_loc_5 in param1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                if (_loc_2["is_deploy"] == 1)
                {
                    this._aryDeployRoleId.push(_loc_2["player_role_id"]);
                }
            }
            return;
        }// end function

        public function downPartnersBack(param1:int) : void
        {
            if (this.checkRoleItem(param1))
            {
                this.removeRoleItem(param1);
            }
            if (this._objMinUpgradeEquip != null && this._objMinUpgradeEquip["player_role_id"] == param1)
            {
                this.minUpgradeCoinEquip();
            }
            var _loc_2:* = this._aryDeployRoleId.length - 1;
            while (_loc_2 >= 0)
            {
                
                param1 = this._aryDeployRoleId[_loc_2] as int;
                this._aryDeployRoleId.splice(_loc_2, 1);
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function roleEquipChangeBack(param1:int) : void
        {
            var _loc_2:int = 0;
            if (param1 < 0)
            {
                return;
            }
            if (this.checkRoleItem(param1))
            {
                this.removeRoleItem(param1);
            }
            for each (_loc_5 in this._aryDeployRoleId)
            {
                
                _loc_2 = _loc_4[_loc_3];
                if (param1 == _loc_2)
                {
                    this.get_equipment_list(param1);
                    break;
                }
            }
            return;
        }// end function

        private function renderResearchLink(param1:String) : void
        {
            if (!FunctionType.isOpened(FunctionType.Research))
            {
                return;
            }
            this.renderFunctionLink({sign:FunctionType.Research, timeText:"", stopText:param1, runText:"", index:this.getFunctionLinkIndex(FunctionType.Research), time:0});
            this.setFunctionLinkPoint();
            return;
        }// end function

        public function getResearchInfo() : void
        {
            if (!FunctionType.isOpened(FunctionType.Research))
            {
                return;
            }
            this._view.research.research_list(this.minResearchSkill);
            return;
        }// end function

        private function minResearchSkill() : void
        {
            var _loc_2:Object = null;
            var _loc_3:int = -1;
            this._minResearchSkill = -1;
            var _loc_1:* = this._ctrl.research.getResearchList();
            for each (_loc_5 in _loc_1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                if (_loc_2["player_level"] <= this._ctrl.player.level && _loc_2["player_level"] != -1)
                {
                    var _loc_5:* = _loc_2["skill"];
                    this._minResearchSkill = _loc_2["skill"];
                    break;
                }
            }
            for each (_loc_5 in _loc_1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                if (this._minResearchSkill > _loc_2["skill"] && _loc_2["player_level"] <= this._ctrl.player.level && _loc_2["player_level"] != -1)
                {
                    var _loc_5:* = _loc_2["skill"];
                    this._minResearchSkill = _loc_2["skill"];
                }
            }
            this.checkIsCanResearchUpgrade();
            return;
        }// end function

        private function checkIsCanResearchUpgrade() : void
        {
            if (!FunctionType.isOpened(FunctionType.Research))
            {
                return;
            }
            if (this._ctrl.player.skill >= this._minResearchSkill && this._minResearchSkill > -1)
            {
                this.renderResearchLink(htmlFormat(functionLinkLang.CanResearch, 12, HtmlText.Green, false, true));
            }
            else
            {
                this.renderResearchLink("");
            }
            return;
        }// end function

        private function getFactionRollCakeInfo() : void
        {
            if (!FunctionType.isOpened(FunctionType.Faction))
            {
                return;
            }
            this._view.factionRollCake.faction_roll_cake_remain_times();
            return;
        }// end function

        public function renderFactionRollCakeLink(param1:int) : void
        {
            if (!FunctionType.isOpened(FunctionType.Faction))
            {
                return;
            }
            var _loc_2:String = "";
            if (param1 > 0)
            {
                var _loc_3:* = htmlFormat(functionLinkLang.FactionRollCake, 12, HtmlText.Green, false, true);
                _loc_2 = htmlFormat(functionLinkLang.FactionRollCake, 12, HtmlText.Green, false, true);
            }
            this.renderFunctionLink({sign:ActivityType.FactionRollCake, timeText:"", stopText:_loc_2, runText:"", index:this.getFunctionLinkIndex(ActivityType.FactionRollCake), time:0});
            this.setFunctionLinkPoint();
            return;
        }// end function

        private function showFactionRollCake() : void
        {
            if (this._view.initLoading.inStage)
            {
                setTimeout(this.showFactionRollCake, 500);
            }
            else
            {
                this._view.factionRollCake.show();
            }
            return;
        }// end function

        public function set questTraceVisible(param1:Boolean) : void
        {
            var _loc_2:* = param1;
            this._toolbar.questTraceVisible = param1;
            var _loc_2:* = param1;
            this._lastTraceVisible = param1;
            return;
        }// end function

        public function get questTraceVisible() : Boolean
        {
            return this._toolbar.questTraceVisible;
        }// end function

        private function set tempTraceVisible(param1:Boolean) : void
        {
            var _loc_2:* = param1;
            this._toolbar.questTraceVisible = param1;
            return;
        }// end function

        private function restoreTraceVisible() : void
        {
            var _loc_1:* = this._lastTraceVisible;
            this._toolbar.questTraceVisible = this._lastTraceVisible;
            return;
        }// end function

        public function set questTraceTipVisible(param1:Boolean) : void
        {
            var _loc_2:* = param1;
            this._toolbar.questTraceTipVisible = param1;
            return;
        }// end function

        private function questTrace() : void
        {
            var _loc_2:Boolean = true;
            this.questTraceVisible = true;
            var _loc_2:* = function (param1:String) : void
            {
                if (_view.campWar.inStageWithTip)
                {
                    return;
                }
                if (_view.heroesWar.inStageWithTip)
                {
                    return;
                }
                if (_view.multiMission.isMinimumWithTip)
                {
                    return;
                }
                if (_view.zodiac.inStageWithTip)
                {
                    return;
                }
                _view.guide.hideAlongGuide();
                _view.quest.wayFinding(param1);
                return;
            }// end function
            ;
            this._toolbar.questTraceLink = function (param1:String) : void
            {
                if (_view.campWar.inStageWithTip)
                {
                    return;
                }
                if (_view.heroesWar.inStageWithTip)
                {
                    return;
                }
                if (_view.multiMission.isMinimumWithTip)
                {
                    return;
                }
                if (_view.zodiac.inStageWithTip)
                {
                    return;
                }
                _view.guide.hideAlongGuide();
                _view.quest.wayFinding(param1);
                return;
            }// end function
            ;
            return;
        }// end function

        public function get questTraceContent() : Sprite
        {
            return this._toolbar.questTraceContent;
        }// end function

        public function loadQuestTrace() : void
        {
            _data.call(Mod_Quest_Base.town_quest_show, this.renderQuestTrace, []);
            return;
        }// end function

        public function renderQuestTrace() : void
        {
            if (_ctrl.quest.townQuestData == null)
            {
                return;
            }
            this._toolbar.renderQuestTrace(this._ctrl.quest.townQuest);
            this.renderQuestStatus();
            return;
        }// end function

        private function renderQuestStatus() : void
        {
            var _loc_1:* = _ctrl.quest.relatedNPC;
            _view.townMap.resetNPCHead(_loc_1);
            _view.guide.open();
            var _loc_2:Boolean = true;
            this.questTraceVisible = true;
            var _loc_2:* = _view.townMap.inStage;
            this.questTraceTipVisible = _view.townMap.inStage;
            if (this.questTraceVisible && _ctrl.quest.hasMasterCompleted)
            {
                _view.quest.haltWayFinding(true);
            }
            return;
        }// end function

        public function loadQuestTraceInTown() : void
        {
            if (this._first == true)
            {
                var _loc_1:Boolean = false;
                this._first = false;
                this.loadQuestTrace();
            }
            else
            {
                this.renderQuestStatus();
            }
            return;
        }// end function

        private function chat() : void
        {
            AllChatLimit.initCookie();
            this._view.chat.show();
            return;
        }// end function

        public function set chatVisible(param1:Boolean) : void
        {
            var _loc_2:* = param1;
            this._view.chat.chatVisible = param1;
            return;
        }// end function

        public function receiveTown(param1:String, param2:Boolean = true, param3:int = 99) : void
        {
            this._view.chat.receive(param1, param2, param3);
            return;
        }// end function

        public function onTextLink(param1) : void
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            var _loc_15:int = 0;
            var _loc_16:int = 0;
            var _loc_17:int = 0;
            var _loc_18:int = 0;
            var _loc_19:Object = null;
            var _loc_20:int = 0;
            var _loc_2:* = param1 is TextEvent ? (param1.text) : (String(param1));
            var _loc_3:* = _loc_2.split("_");
            var _loc_4:* = _loc_3[0];
            var _loc_5:* = _loc_3[1];
            switch(_loc_4)
            {
                case TextLinkType.Player:
                {
                    setTimeout(this.showPlayerInfo, 50, _loc_5, String(_loc_3[2]), _loc_3[3] || "");
                    break;
                }
                case TextLinkType.Item:
                {
                    setTimeout(this.showItemInfo, 50, int(_loc_3[1]), int(_loc_3[2]), int(_loc_3[3]), int(_loc_3[4]), _loc_3[5]);
                    break;
                }
                case TextLinkType.SeeMsg:
                {
                    this._view.otherRoleMsg.init(_loc_5, _loc_3[2]);
                    this._view.otherRoleMsg.show();
                    break;
                }
                case TextLinkType.AddFocus:
                {
                    this._view.friendList.addFriend("", _loc_5);
                    break;
                }
                case TextLinkType.Fate:
                {
                    _loc_6 = _loc_3[1];
                    setTimeout(this.showFateInfo, 50, _loc_6);
                    break;
                }
                case TextLinkType.ViewReport:
                {
                    this._view.war.formatReportUrl(_loc_3.slice(1));
                    break;
                }
                case TextLinkType.Gag:
                {
                    this._view.chat.disableTalkPlayer(_loc_5, _loc_3[2]);
                    break;
                }
                case TextLinkType.Shield:
                {
                    this._view.chat.isShieldPlayerTalk(_loc_5, _loc_3[2]);
                    break;
                }
                case TextLinkType.PM:
                {
                    this._view.friendChat.get_friendinfo_chatrecord_list(_loc_5);
                    break;
                }
                case TextLinkType.PK:
                {
                    if (this._view.factionWarMap.inStageWithTip)
                    {
                        return;
                    }
                    var _loc_21:* = _loc_5;
                    this._view.pkWar.defenderPlayerId = _loc_5;
                    this._view.pkWar.show();
                    break;
                }
                case TextLinkType.CopyName:
                {
                    Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, _loc_3[2]);
                    this._view.showTip(Lang.sprintf(chatLang.CopySuccess, _loc_3[2]), "", TipType.Success);
                    break;
                }
                case TextLinkType.SendFlower:
                {
                    var _loc_21:* = _loc_5;
                    this._view.sendFlower.sendPlayerID = _loc_5;
                    this._view.sendFlower.show();
                    break;
                }
                case TextLinkType.soul:
                {
                    _loc_7 = _loc_3[1];
                    _loc_8 = _loc_3[2];
                    _loc_9 = _loc_3[3];
                    _loc_10 = _loc_3[4];
                    _loc_11 = _loc_3[5];
                    _loc_12 = _loc_3[6];
                    _loc_13 = _loc_3[7];
                    _loc_14 = _loc_3[8];
                    _loc_15 = _loc_3[9];
                    setTimeout(this.showSoulInfo, 50, _loc_7, _loc_8, _loc_9, _loc_10, _loc_11, _loc_12, _loc_13, _loc_14, _loc_15);
                    break;
                }
                case TextLinkType.Achievement:
                {
                    _loc_16 = _loc_3[1];
                    this._view.achievement.gotoAchievementLabel(_loc_16);
                    break;
                }
                case TextLinkType.Faction:
                {
                    _loc_17 = _loc_3[1];
                    this._view.joinFaction.apply_faction(_loc_17);
                    break;
                }
                case TextLinkType.NineRegions:
                {
                    if (!this._ctrl.nineRegions.bOpenNineRegions)
                    {
                        this._view.showTip(chatLang.NotOpenNineRegions);
                        return;
                    }
                    if (this._view.nineRegionsMap.inStageWithTip)
                    {
                        return;
                    }
                    if (this._view.beelzebubTrialsMap.inStageWithTip)
                    {
                        return;
                    }
                    if (this._view.topWarMap.inStageWithTip)
                    {
                        return;
                    }
                    if (this._view.inWar)
                    {
                        this._view.showTip(chatLang.InWar);
                        return;
                    }
                    _loc_18 = _loc_3[1];
                    if (_loc_3[2] != this._ctrl.player.playerId)
                    {
                        _loc_19 = new Object();
                        var _loc_21:* = _loc_3[3];
                        _loc_19.jieId = _loc_3[3];
                        var _loc_21:* = _loc_3[4];
                        _loc_19.lvId = _loc_3[4];
                        var _loc_21:* = _loc_3[2];
                        _loc_19.teamId = _loc_3[2];
                        this._view.nineRegionsTeamCreat.onAddTeam(_loc_19);
                    }
                    break;
                }
                case TextLinkType.BeelzebubTrials:
                {
                    if (!FunctionType.isOpened(FunctionType.BeelzebubTrials))
                    {
                        this._view.showTip(chatLang.NotOpenBeelzeBubTrials);
                        return;
                    }
                    if (this._view.nineRegionsMap.inStageWithTip)
                    {
                        return;
                    }
                    if (this._view.beelzebubTrialsMap.inStageWithTip)
                    {
                        return;
                    }
                    if (this._view.topWarMap.inStageWithTip)
                    {
                        return;
                    }
                    if (this._view.inWar)
                    {
                        this._view.showTip(chatLang.InWar);
                        return;
                    }
                    if (!this._ctrl.beelzebubTrials.bActiveTime)
                    {
                        this._view.showTip(chatLang.NotBeelzeBubTrialsActiveTime);
                        return;
                    }
                    if (!this._ctrl.beelzebubTrials.bCanIn(_loc_3[3]))
                    {
                        this._view.showTip(chatLang.CannotInThisBoss);
                        return;
                    }
                    _loc_20 = _loc_3[1];
                    if (_loc_3[2] != this._ctrl.player.playerId)
                    {
                        this._view.beelzebubTrials.joinTeamForChat(_loc_20, _loc_3[3]);
                    }
                    break;
                }
                case TextLinkType.GotoJiHuiSuo:
                {
                    if (this._ctrl.player.jihuisuoId == 0)
                    {
                        if (this._view.inWar)
                        {
                            this._view.showTip(chatLang.InWar);
                            return;
                        }
                        if (this._view.nineRegionsMap.inStageWithTip)
                        {
                            return;
                        }
                        if (this._view.beelzebubTrialsMap.inStageWithTip)
                        {
                            return;
                        }
                        if (this._view.topWarMap.inStageWithTip)
                        {
                            return;
                        }
                        this._view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
                    }
                    else
                    {
                        this._view.showTip(chatLang.InJiHuiSuo);
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

        public function showPlayerInfo(param1:int, param2:String, param3:String = "") : void
        {
            if (param1 == this._ctrl.player.playerId)
            {
                return;
            }
            var _loc_4:Array = [chatLang.CopyData];
            var _loc_5:Array = [[TextLinkType.SeeMsg, param1].join("_")];
            if (FunctionType.isOpened(FunctionType.Friend))
            {
                _loc_4.push(chatLang.AddAttention, chatLang.SendTalk);
                _loc_5.push([TextLinkType.AddFocus, param1, param2].join("_"), [TextLinkType.PM, param1, param2].join("_"));
            }
            if (this._ctrl.player.isAdvancedTester == true)
            {
                _loc_4.push(chatLang.Gag);
                _loc_5.push([TextLinkType.Gag, param1, param2].join("_"));
            }
            _loc_4.push(chatLang.ShieldTalk, chatLang.CopyName);
            _loc_5.push([TextLinkType.Shield, param1, param2].join("_"), [TextLinkType.CopyName, param1, param2].join("_"));
            if (FunctionType.isOpened(FunctionType.SendFlower))
            {
                _loc_4.push(chatLang.SendFlower);
                _loc_5.push([TextLinkType.SendFlower, param1, param2].join("_"));
            }
            var _loc_6:* = new ClickTipList(_loc_4, _loc_5, this.onTextLink);
            this._view.tip.iTip.clickToOpen(_loc_6);
            return;
        }// end function

        private function showItemInfo(param1:int, param2:int, param3:int, param4:int, param5:String) : void
        {
            var _loc_6:* = new ItemInfo();
            new ItemInfo().parseSee(param1, param2, param4);
            var _loc_8:* = param3;
            _loc_6.playerItemId = param3;
            var _loc_8:* = param5 || "";
            param5 = param5 || "";
            var _loc_7:* = _loc_6.getTipsSprite1("", param5 == "" ? ("") : (chatLang.Owner + param5));
            this._view.tip.iTip.clickToOpen(_loc_7);
            return;
        }// end function

        private function showFateInfo(param1:int) : void
        {
            if (this._fateTipSprite == null)
            {
                var _loc_2:* = new FateTipSprite();
                this._fateTipSprite = new FateTipSprite();
                var _loc_2:* = this._view.tip.iTip;
                this._fateTipSprite.tip = this._view.tip.iTip;
            }
            var _loc_2:* = param1;
            this._fateTipSprite.getFateId = param1;
            var _loc_2:* = this._toolbar.content;
            this._fateTipSprite.target = this._toolbar.content;
            return;
        }// end function

        private function showSoulInfo(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int) : void
        {
            var _loc_21:int = 0;
            var _loc_22:int = 0;
            var _loc_23:int = 0;
            var _loc_10:* = NineRegionsType.getBlessNameByIdx(param8);
            var _loc_11:int = 0;
            var _loc_12:* = SoulType.getSoulName(param1);
            if (param9 && _loc_11 > 0)
            {
                var _loc_24:* = _loc_12 + HtmlText.yellow("(+" + _loc_11 + "%)");
                _loc_12 = _loc_12 + HtmlText.yellow("(+" + _loc_11 + "%)");
            }
            var _loc_24:* = param9 ? (_loc_11) : (0);
            _loc_11 = param9 ? (_loc_11) : (0);
            var _loc_13:* = SoulType.getSoulQualityId(param1);
            var _loc_14:* = SoulType.getQualityColor(_loc_13);
            var _loc_15:* = SoulType.getSoulSubTypeId(param1);
            var _loc_16:* = SoulType.getSoulTypeIdByAllTypeId(_loc_15);
            var _loc_17:* = SoulType.getJobNameToTypeId(_loc_16);
            var _loc_18:* = URI.getSoulsIconUrl(param1);
            var _loc_19:String = "";
            var _loc_20:Object = {};
            if (this._soulTipSprite == null)
            {
                var _loc_24:* = new SoulTipSprite();
                this._soulTipSprite = new SoulTipSprite();
            }
            else
            {
                var _loc_24:Boolean = true;
                this._soulTipSprite.ischange = true;
            }
            var _loc_24:* = _loc_18;
            this._soulTipSprite.iconUrl = _loc_18;
            var _loc_24:int = 0;
            this._soulTipSprite.star1 = 0;
            var _loc_24:int = 0;
            this._soulTipSprite.star2 = 0;
            var _loc_24:int = 0;
            this._soulTipSprite.star3 = 0;
            if (param2 != 0)
            {
                var _loc_24:* = this._ctrl.sealSoul.renderLocationList(param2, _loc_13, param5, _loc_11);
                _loc_20 = this._ctrl.sealSoul.renderLocationList(param2, _loc_13, param5, _loc_11);
                var _loc_24:* = _loc_19 + (HtmlText.format(_loc_20.name + " +" + _loc_20.valueInfo, _loc_20.color) + "\n");
                _loc_19 = _loc_19 + (HtmlText.format(_loc_20.name + " +" + _loc_20.valueInfo, _loc_20.color) + "\n");
                _loc_21 = SoulType.getQualityForIDValue(param2, _loc_13, param5);
                var _loc_24:* = _loc_21;
                this._soulTipSprite.star1 = _loc_21;
            }
            if (param3 != 0)
            {
                var _loc_24:* = this._ctrl.sealSoul.renderLocationList(param3, _loc_13, param6, _loc_11);
                _loc_20 = this._ctrl.sealSoul.renderLocationList(param3, _loc_13, param6, _loc_11);
                var _loc_24:* = _loc_19 + (HtmlText.format(_loc_20.name + " +" + _loc_20.valueInfo, _loc_20.color) + "\n");
                _loc_19 = _loc_19 + (HtmlText.format(_loc_20.name + " +" + _loc_20.valueInfo, _loc_20.color) + "\n");
                _loc_22 = SoulType.getQualityForIDValue(param3, _loc_13, param6);
                var _loc_24:* = _loc_22;
                this._soulTipSprite.star2 = _loc_22;
            }
            if (param4 != 0)
            {
                var _loc_24:* = this._ctrl.sealSoul.renderLocationList(param4, _loc_13, param7, _loc_11);
                _loc_20 = this._ctrl.sealSoul.renderLocationList(param4, _loc_13, param7, _loc_11);
                var _loc_24:* = _loc_19 + (HtmlText.format(_loc_20.name + " +" + _loc_20.valueInfo, _loc_20.color) + "\n");
                _loc_19 = _loc_19 + (HtmlText.format(_loc_20.name + " +" + _loc_20.valueInfo, _loc_20.color) + "\n");
                _loc_23 = SoulType.getQualityForIDValue(param4, _loc_13, param7);
                var _loc_24:* = _loc_23;
                this._soulTipSprite.star3 = _loc_23;
            }
            var _loc_24:* = HtmlText.format(_loc_12, _loc_14);
            this._soulTipSprite.nameHtml = HtmlText.format(_loc_12, _loc_14);
            var _loc_24:String = "";
            this._soulTipSprite.desHtml = "";
            var _loc_24:* = _loc_19;
            this._soulTipSprite.addHtml = _loc_19;
            this._view.tip.iTip.clickToOpen(this._soulTipSprite);
            return;
        }// end function

        private function functionBar() : void
        {
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.roleMsg.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onBody = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.roleMsg.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.pack.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onPack = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.pack.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.upgrade.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onUpgrade = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.upgrade.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.superDeploy.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onDeploy = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.superDeploy.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.research.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onResearch = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.research.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.fate.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onFate = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.fate.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.sealSoul.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onSealSoul = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.sealSoul.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.studyStunt.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onStudyStunt = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.studyStunt.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.quest.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onQuest = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.quest.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.achievement.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onAchievement = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.achievement.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                if (_view.friendMessage.isShowMostBox)
                {
                    _view.friendMessage.clear();
                }
                else
                {
                    _view.friendMessage.message_box_list();
                }
                return;
            }// end function
            ;
            this._toolbar.onFriend = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                if (_view.friendMessage.isShowMostBox)
                {
                    _view.friendMessage.clear();
                }
                else
                {
                    _view.friendMessage.message_box_list();
                }
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.myFaction.switchSelf();
                return;
            }// end function
            ;
            this._toolbar.onFaction = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                _view.myFaction.switchSelf();
                return;
            }// end function
            ;
            var _loc_2:* = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                switchPractice();
                return;
            }// end function
            ;
            this._toolbar.onPractice = function () : void
            {
                SoundEffect.play(SoundEffect.Button);
                switchPractice();
                return;
            }// end function
            ;
            this.renderFunctionBar();
            this.bubble();
            this.updateExperience();
            this.getPrestigeNo1PlayerId();
            return;
        }// end function

        private function getPrestigeNo1PlayerId() : void
        {
            this._view.townMap.getPrestigeNo1PlayerId();
            return;
        }// end function

        public function set functionBarParent(param1:Sprite) : void
        {
            var _loc_2:* = param1;
            this._toolbar.functionBarParent = param1;
            return;
        }// end function

        public function switchPractice() : void
        {
            if (this._ctrl.player.playerInfo.practice == Mod_Town_Base.ON_PRACTICE)
            {
                this.closePractice();
            }
            else
            {
                if (this._view.factionWarMap.isFactionWarStart == true)
                {
                    return;
                }
                this.startPractice();
            }
            return;
        }// end function

        private function renderFunctionBar() : void
        {
            this._toolbar.newFunctionBar(FunctionType.DefaultList, FunctionType.DefaultList);
            this.get_player_function();
            return;
        }// end function

        private function get_player_function() : void
        {
            this._data.call(Mod_Player_Base.get_player_function, this.getPlayerFunctionCallback, []);
            return;
        }// end function

        private function getPlayerFunctionCallback(param1:Boolean = false) : void
        {
            var downOldList:Array;
            var downNewList:Array;
            var sign:String;
            var index:int;
            var newAddedIds:Array;
            var newAddedSigns:Array;
            var item:Object;
            var id:String;
            var trigger:* = param1;
            var list:* = this._ctrl.player.functionList;
            var upList:Array;
            downOldList;
            downNewList;
            this.checkHasManual(list);
            FunctionType.updateOpenedList(list);
            for each (_loc_5 in FunctionType.DefaultList)
            {
                
                sign = _loc_4[_loc_3];
                var _loc_5:* = FunctionType.functionIndex(sign);
                index = FunctionType.functionIndex(sign);
                var _loc_5:* = sign;
                downOldList[index] = sign;
                var _loc_5:* = sign;
                downNewList[index] = sign;
            }
            newAddedIds;
            newAddedSigns;
            for each (_loc_5 in list)
            {
                
                item = _loc_4[_loc_3];
                var _loc_5:* = FunctionType.sign(item["id"]);
                sign = FunctionType.sign(item["id"]);
                var _loc_5:* = FunctionType.functionIndex(sign);
                index = FunctionType.functionIndex(sign);
                if (trigger == false && (this.isDeploy(sign) || this.isFate(sign)))
                {
                    continue;
                }
                if (index > -1)
                {
                    if (item["isPlayed"] == 1)
                    {
                        var _loc_5:* = sign;
                        downOldList[index] = sign;
                    }
                    var _loc_5:* = sign;
                    downNewList[index] = sign;
                }
                else
                {
                    upList.push(sign);
                }
                if (item["isPlayed"] == 0)
                {
                    var _loc_5:int = 1;
                    item["isPlayed"] = 1;
                    newAddedIds.push(item["id"]);
                    if (sign == FunctionType.Robot && VIPType.check(VIPType.Level5) == false)
                    {
                        continue;
                    }
                    if (FunctionType.isIgnoreTip(sign) == false)
                    {
                        if (index == -1)
                        {
                            newAddedSigns.push(sign);
                        }
                        else
                        {
                            newAddedSigns.unshift(sign);
                        }
                        this.functionHandler(sign);
                    }
                }
            }
            this.removeUndefined(downOldList);
            this.removeUndefined(downNewList);
            this._toolbar.newFunctionBar(downOldList, downOldList);
            if (newAddedSigns.length > 0)
            {
                if (downNewList.length > downOldList.length)
                {
                    var _loc_3:* = function () : void
            {
                _toolbar.newFunctionBar(downOldList, downNewList);
                var _loc_1:String = null;
                _view.triggerFunction.onStart = null;
                return;
            }// end function
            ;
                    _view.triggerFunction.onStart = function () : void
            {
                _toolbar.newFunctionBar(downOldList, downNewList);
                var _loc_1:String = null;
                _view.triggerFunction.onStart = null;
                return;
            }// end function
            ;
                    var _loc_3:* = function () : void
            {
                _toolbar.updatePackMessageXY();
                _view.guide.stopPartnersGuide();
                _view.guide.startUpgradeGuides();
                _view.guide.startFateLodgeGuide();
                return;
            }// end function
            ;
                    this._toolbar.onEnd = function () : void
            {
                _toolbar.updatePackMessageXY();
                _view.guide.stopPartnersGuide();
                _view.guide.startUpgradeGuides();
                _view.guide.startFateLodgeGuide();
                return;
            }// end function
            ;
                }
                this._view.triggerFunction.triggerList(newAddedSigns);
                _view.triggerFunction.switchSelf();
            }
            this.updateFunction();
            this.updateOtherFunction();
            this.openOtherFunction(upList);
            for each (_loc_5 in newAddedIds)
            {
                
                id = _loc_4[_loc_3];
                this._data.call(Mod_Player_Base.sign_play_player_function, null, [parseInt(id)]);
                switch(FunctionType.sign(parseInt(id)))
                {
                    case FunctionType.LuckyShop:
                    {
                        _view.processTip.open(ProcessTipsType.LuckyShop);
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

        private function functionHandler(param1:String) : void
        {
            switch(param1)
            {
                case FunctionType.PetAnimal:
                {
                    _view.pet.getPetAnimalInfo();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function testFunction() : void
        {
            if (Config.EnableDomainSelector == true)
            {
                this.openOtherFunction([FunctionType.HaloRole, FunctionType.CatHunt]);
            }
            return;
        }// end function

        private function updateFunction() : void
        {
            this._toolbar.updatePackMessageXY();
            _view.chat.chatOpenFunction();
            this.showFunctionLink();
            if (FunctionType.isOpened(FunctionType.Faction) == false)
            {
                var _loc_1:Boolean = false;
                this._view.chat.isOpenFaction = false;
            }
            else
            {
                var _loc_1:Boolean = true;
                this._view.chat.isOpenFaction = true;
                this.get_faction_level();
            }
            AchievementType.loadData(new Function());
            if (FunctionType.isOpened(FunctionType.Friend))
            {
                this._data.patch(Mod_Friend_Base.get_unreceive_friend_list, this.unreceiveMsg);
                this._data.call(Mod_Friend_Base.get_unreceive_friend_list, this.unreceiveMsg, []);
                this._view.friendMessage.show();
            }
            if (FunctionType.isOpened(FunctionType.BeelzebubTrials))
            {
                this._data.call(Mod_BeelzebubTrials_Base.get_player_can_challenge_list, new Function(), []);
            }
            return;
        }// end function

        private function updateOtherFunction() : void
        {
            return;
        }// end function

        private function openOtherFunction(param1:Array) : void
        {
            var _loc_2:String = null;
            for each (_loc_5 in param1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                switch(_loc_2)
                {
                    case FunctionType.DailyBox:
                    {
                        this._view.gameHelper.loader_first_info();
                        this._view.activities.addActivity(ActivityType.GameHelper);
                        break;
                    }
                    case FunctionType.BuyPower:
                    {
                        var _loc_5:* = this._ctrl.player.power < 200 && VIPType.enabled;
                        this._toolbar.powerVisible = this._ctrl.player.power < 200 && VIPType.enabled;
                        this.updatePower();
                        break;
                    }
                    case FunctionType.CampWar:
                    {
                        this._view.activities.openActivity(FunctionType.CampWar);
                        break;
                    }
                    case FunctionType.CatHunt:
                    {
                        this._view.activities.addActivity(FunctionType.CatHunt);
                        break;
                    }
                    case FunctionType.DreamSection:
                    {
                        this._view.activities.openActivity(FunctionType.DreamSection);
                        break;
                    }
                    case FunctionType.Furnace:
                    {
                        this._view.activities.openActivity(FunctionType.Furnace);
                        break;
                    }
                    case FunctionType.DailyQuest:
                    {
                        this._view.activities.openActivity(FunctionType.DailyQuest);
                        break;
                    }
                    case FunctionType.Farm:
                    {
                        this._data.patch(Mod_Farm_Base.get_simple_farmlandinfo, this._view.farm.getSimpleFarmlandinfoCallBack);
                        break;
                    }
                    case FunctionType.GetPeach:
                    {
                        this.peach_info();
                        break;
                    }
                    case FunctionType.HeroMission:
                    {
                        this._view.activities.addActivity(FunctionType.HeroMission);
                        break;
                    }
                    case FunctionType.HaloRole:
                    {
                        this._view.haloRole.add_HaloRole();
                        break;
                    }
                    case FunctionType.MultiMission:
                    {
                        this._view.activities.openActivity(TownType.All);
                        this._view.activities.openActivity(TownType.MultiMission);
                        var _loc_5:Boolean = true;
                        this._view.chat.isOpenActivity = true;
                        break;
                    }
                    case FunctionType.OfflineExp:
                    {
                        this._view.activities.openActivity(TownType.OfflineExp);
                        break;
                    }
                    case FunctionType.OnlineGift:
                    {
                        if (this._ctrl.player.onlineGiftTime > 0)
                        {
                            this._view.activities.openActivity(TownType.OnlineGift);
                        }
                        break;
                    }
                    case FunctionType.PetAnimal:
                    {
                        this._view.activities.addActivity(FunctionType.PetAnimal);
                        this._view.pet.get_pet_animal_info();
                        break;
                    }
                    case FunctionType.Rune:
                    {
                        this._view.rune.rune_list();
                        break;
                    }
                    case FunctionType.RollCake:
                    {
                        this._data.call(Mod_Player_Base.update_player_data, null, [Mod_Player_Base.STATE_POINT]);
                        this._data.call(Mod_Player_Base.update_player_data, null, [Mod_Player_Base.TOTAL_STATE_POINT]);
                        this._view.rollCake.get_count();
                        break;
                    }
                    case FunctionType.SuperSport:
                    {
                        this.patchNotifyGlobal();
                        this._view.activities.openActivity(FunctionType.SuperSport);
                        break;
                    }
                    case FunctionType.StudyStunt:
                    {
                        this._view.activities.openActivity(FunctionType.StudyStunt);
                        break;
                    }
                    case FunctionType.TakeBible:
                    {
                        this._view.takeBibleRoad.get_rulai_open_time();
                        this.takeBibleInfo();
                        this._view.activities.openActivity(FunctionType.TakeBible);
                        break;
                    }
                    case FunctionType.Tower:
                    {
                        this._view.sealStone.notifyGet();
                        this._view.tower.get_tower_info3();
                        this._view.activities.addActivity(FunctionType.Tower);
                        break;
                    }
                    case FunctionType.World:
                    {
                        var _loc_5:Boolean = true;
                        this._miniMap.gameHelpVisible = true;
                        var _loc_5:Boolean = true;
                        this._miniMap.worldVisible = true;
                        var _loc_5:Boolean = true;
                        this._miniMap.hideVisible = true;
                        var _loc_5:Boolean = true;
                        this._miniMap.settingVisible = true;
                        this._data.call(Mod_Item_Base.has_level_gift_item, null, []);
                        break;
                    }
                    case FunctionType.WorldBoss:
                    {
                        this._view.activityWindow.get_world_boss_list();
                        break;
                    }
                    case FunctionType.WorshipMars:
                    {
                        this._view.activities.openActivity(FunctionType.WorshipMars);
                        break;
                    }
                    case FunctionType.Zodiac:
                    {
                        this._view.activities.openActivity(FunctionType.Zodiac);
                        break;
                    }
                    case FunctionType.WeeklyRank:
                    {
                        this._view.weekRanking.show_Btn();
                        break;
                    }
                    case FunctionType.BeelzebubTrials:
                    {
                        this._view.activities.openActivity(FunctionType.BeelzebubTrials);
                        break;
                    }
                    case FunctionType.SpecialPartner:
                    {
                        this._view.specialPartner.getPartnerInfo();
                        break;
                    }
                    case FunctionType.FindImmortal:
                    {
                        this._view.findImmortal.showBtn();
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

        public function peach_info() : void
        {
            if (FunctionType.isOpened(FunctionType.GetPeach))
            {
                _data.call(Mod_GetPeach_Base.peach_info, this.peachInfoCallback, []);
            }
            return;
        }// end function

        private function peachInfoCallback() : void
        {
            var _loc_1:* = this._ctrl.getPeach.peachInfo;
            if (_loc_1.peachNum <= 0)
            {
                this._view.activities.removeActivity(FunctionType.GetPeach);
            }
            else
            {
                this._view.activities.addActivity(FunctionType.GetPeach);
            }
            return;
        }// end function

        public function get_faction_level() : void
        {
            this._data.patch(Mod_Faction_Base.get_faction_level, this.getFactionLevelCallBack);
            this._data.call(Mod_Faction_Base.get_faction_level, this.getFactionLevelCallBack, []);
            return;
        }// end function

        private function getFactionLevelCallBack() : void
        {
            var _loc_1:* = _ctrl.faction.getFactionLevel;
            var _loc_2:* = _loc_1;
            this._view.liveness.factionId = _loc_1;
            var _loc_2:* = _loc_1;
            ActivityType.FactionLevel = _loc_1;
            if (_loc_1 > 0 && this._isOpenFactionActivity == false)
            {
                if (_loc_1 >= 4)
                {
                    this._view.factionWindow.getFactionMonsterTime();
                }
                if (_loc_1 >= 4 && this._ctrl.factionMonster.actityStatus == Mod_FactionMonster_Base.OPEN)
                {
                    this._view.townMap.joinFactionMonster();
                }
                this._view.activities.openActivity(ActivityType.FactionAll);
                var _loc_2:Boolean = true;
                this._isOpenFactionActivity = true;
                this._data.call(Mod_Faction_Base.is_can_join_activity, null, []);
                this._view.factionSeal.seal_satan_info();
                this._data.patch(Mod_Faction_Base.seal_satan_info, _view.factionSeal.sealSatanInfoCallBack);
                this._data.patch(Mod_Faction_Base.call_eat_detailed_info, _view.factionEat.callEatDetailedInfoCallBack);
            }
            else
            {
                this._view.activityWindow.deleteActivity(ActivityType.FactionMonster);
                if (this._isOpenFactionActivity && _loc_1 <= 0)
                {
                    this._view.activities.removeActivity(ActivityType.FactionAll);
                    var _loc_2:Boolean = false;
                    this._isOpenFactionActivity = false;
                }
            }
            this._view.factionBlessing.checkIncense();
            this._view.factionEat.checkFactionEat();
            this.getFactionRollCakeInfo();
            return;
        }// end function

        private function removeUndefined(param1:Array) : void
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = _loc_2 - 1;
            while (_loc_3 > -1)
            {
                
                if (undefined == param1[_loc_3])
                {
                    param1.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
            }
            return;
        }// end function

        private function bubble() : void
        {
            this._data.call(Mod_Player_Base.update_player_data, this.updatePlayerDataCallback, [Mod_Player_Base.PLAYER_PACK_EMPTY_NUM]);
            return;
        }// end function

        private function unreceiveMsg() : void
        {
            var _loc_4:int = 0;
            var _loc_5:Boolean = false;
            var _loc_1:* = this._ctrl.friend.getUnreceiveFriendList;
            if (_loc_1.length <= 0)
            {
                this._view.friendMessage.clearList();
            }
            if (_loc_1 == null || _loc_1.length <= 0 || this._view.friendMessage.isShowMostBox)
            {
                this.friendMsg(0);
                return;
            }
            var _loc_2:* = _loc_1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _loc_1[_loc_3];
                _loc_5 = this._view.friendChat.checkPlayerId(_loc_4);
                if (_loc_5)
                {
                    this._view.friendList.check_receive_message(_loc_4);
                    var _loc_6:* = _loc_4;
                    this._ctrl.friend.clearPlayerId = _loc_4;
                }
                else
                {
                    var _loc_6:* = _loc_4;
                    this.showChatId = _loc_4;
                }
                _loc_3++;
            }
            var _loc_6:* = this._ctrl.friend.getUnreceiveFriendList;
            _loc_1 = this._ctrl.friend.getUnreceiveFriendList;
            var _loc_6:* = _loc_1.length;
            _loc_2 = _loc_1.length;
            this.friendMsg(_loc_2);
            return;
        }// end function

        public function friendMsg(param1:int) : void
        {
            this._toolbar.switchBubble(param1);
            return;
        }// end function

        public function playGoodsEffect(param1:String) : void
        {
            var url:* = param1;
            var callback:* = function (param1:Array) : void
            {
                var obj:Object;
                var list:* = param1;
                var QuestGoods:* = list[1].getClassByName("QuestGoods");
                obj = new QuestGoods(list[0].bitmap.bitmapData);
                _toolbar.content.addChild(obj as MovieClip);
                var handler:* = function () : void
                {
                    var _loc_1:* = _toolbar.getFunctionPoint(FunctionType.Pack);
                    var _loc_2:* = _loc_1.x - 67 - Structure.stageOffset.x;
                    obj.x = _loc_1.x - 67 - Structure.stageOffset.x;
                    var _loc_2:* = _loc_1.y - 147 - Structure.stageOffset.y;
                    obj.y = _loc_1.y - 147 - Structure.stageOffset.y;
                    return;
                }// end function
                ;
                new activation.handler();
                var _loc_3:* = handler;
                obj.onEnterFrame = handler;
                obj.gotoAndPlay(2);
                return;
            }// end function
            ;
            File.loadList([url, URI.addonsUrl + "quest_goods.swf"], callback);
            return;
        }// end function

        private function takeBibleInfo() : void
        {
            this._data.call(Mod_TakeBible_Base.take_bible_info, this.takeBibleInfoCallBack, []);
            return;
        }// end function

        private function takeBibleInfoCallBack() : void
        {
            this._view.takeBibleRoad.getRulaiOpenTimeCallBack();
            return;
        }// end function

        private function checkHasManual(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            var _loc_4:String = null;
            var _loc_5:int = 0;
            for (_loc_8 in param1)
            {
                
                _loc_2 = _loc_7[_loc_6];
                _loc_3 = param1[_loc_2]["id"];
                _loc_4 = FunctionType.sign(_loc_3);
                _loc_5 = param1[_loc_2]["isPlayed"];
                if (FunctionType.Deploy == _loc_4 && _loc_5 == 0)
                {
                    var _loc_8:Boolean = true;
                    this._hasDeploy = true;
                    break;
                    continue;
                }
                if (FunctionType.Fate == _loc_4 && _loc_5 == 0)
                {
                    var _loc_8:Boolean = true;
                    this._hasFate = true;
                    break;
                }
            }
            return;
        }// end function

        private function isDeploy(param1:String) : Boolean
        {
            return this._hasDeploy && FunctionType.Deploy == param1;
        }// end function

        private function isFate(param1:String) : Boolean
        {
            return this._hasFate && FunctionType.Fate == param1;
        }// end function

        public function triggerDeploy() : void
        {
            this.getPlayerFunctionCallback(true);
            var _loc_1:Boolean = false;
            this._hasDeploy = false;
            return;
        }// end function

        public function triggerFate() : void
        {
            this.getPlayerFunctionCallback(true);
            var _loc_1:Boolean = false;
            this._hasFate = false;
            return;
        }// end function

        public function getFunctionPoint(param1:String) : Point
        {
            var _loc_2:* = this._toolbar.getFunctionPoint(param1);
            return _loc_2;
        }// end function

        public function showExpFile(param1:Boolean) : void
        {
            this._toolbar.showExpFile(param1);
            return;
        }// end function

        private function keepAlive() : void
        {
            this._view.consumeAlertSetting.loadSettingInfo();
            this._view.delayMessage.init();
            this._view.worldNotice.preLoad();
            this._data.patch(Mod_Player_Base.update_player_data, this.updatePlayerDataCallback);
            this._data.patch(Mod_CampWar_Base.notify, this.campWarNotifyCallBack);
            this._data.patch(Mod_HeroesWar_Base.notify, this.heroesWarNotifyCallBack);
            this._data.patch(Mod_Notify_Base.mission_award, this.mission_award_back);
            this._data.patch(Mod_Notify_Base.pk_award, this.pkAwardCallBack);
            this._data.patch(Mod_Notify_Base.notify_get_good_fate, this.goodFateCallBack);
            this._data.patch(Mod_Notify_Base.complete_reel_production, this.completeReelProduction);
            this._data.patch(Mod_Notify_Base.role_num_notify, this.roleNumNotifyCallBack);
            this._data.patch(Mod_Notify_Base.new_research_notify, this.newResearchNotifyCallBack);
            this._data.patch(Mod_SuperDeploy_Base.new_deploy_grid_open_notify, this.newDeployGridOpenNotifyCallBack);
            this._data.patch(Mod_Notify_Base.new_partners_notify, this.newPartnersNotifyCallBack);
            this._data.patch(Mod_Notify_Base.buy_good_stuff_in_lucky_shop, this.buyGoodStuffInLuckyShopCallBack);
            this._data.patch(Mod_Notify_Base.player_take_bible, this.playerTakeBibleCallBack);
            this._data.patch(Mod_Notify_Base.player_take_bible_berobbed, this.playerTakeBibleBerobbedCallBack);
            this._data.patch(Mod_WorldBoss_Base.open_world_boss, this.open_world_boss_back);
            this._data.patch(Mod_WorldBoss_Base.close_world_boss, this.close_world_boss_back);
            this._data.patch(Mod_WorldBoss_Base.defeat_world_boss, this.defeat_world_boss_back);
            this._data.patch(Mod_WorldBoss_Base.world_boss_low_health, this.worldBossLowHealth);
            this._data.patch(Mod_Notify_Base.disband_faction_notify, this.disband_faction_notify_back);
            this._data.patch(Mod_Notify_Base.kickout_member_notify, this.kickout_member_notify_back);
            this._data.patch(Mod_Faction_Base.faction_message_notify, this.faction_message_notify_back);
            this._data.patch(Mod_FactionWar_Base.notify_good_faction_war_gift, this.notify_good_faction_war_gift_back);
            this._data.patch(Mod_FactionWar_Base.notify_faction_war_over, this.notify_faction_war_over_back);
            this._data.patch(Mod_FactionWar_Base.notify_give_faction_war_gift, this.notify_give_faction_war_gift_back);
            this._data.patch(Mod_Notify_Base.lucky_wheel_award_seven_medicine_reel, this.lucky_wheel_award_seven_medicine_reel_back);
            this._data.patch(Mod_Notify_Base.find_immortal_five_notify, this.find_immortal_five_notify_back);
            this._data.patch(Mod_Notify_Base.exchange_hu_lu_wa_notify, this.exchange_hu_lu_wa_notify_back);
            this._data.patch(Mod_Notify_Base.unlock_special_partner, this.unlock_special_partner_back);
            this._data.patch(Mod_Faction_Base.blessing_count_change, this.blessingCountChangeCallBack);
            this._data.patch(Mod_WorshipMars_Base.blessing_times_and_exp_add_notify, this.blessingCountAndExpAddNotifyCallBack);
            this._data.patch(Mod_Notify_Base.game_timer, this.server_time);
            this._data.call(Mod_Player_Base.update_player_data, null, [Mod_Player_Base.PLAYER_SKILL]);
            this._view.addToTimerProcessList(this.sign + Math.random(), this.hourlyRefresh);
            this._data.patch(Mod_Rune_Base.rune_use_notify, this.runeUseNotifyCallback);
            this._data.patch(Mod_TakeBible_Base.notify_global, this.takeBibleNotifyCallBack);
            this._data.patch(Mod_Notify_Base.send_flower, this.sendFlowerCallBack);
            this._data.patch(Mod_Notify_Base.flower_week_number_one, this.flowerWeekNumberOneCallBack);
            this._data.patch(Mod_Notify_Base.pass_tower, this.pass_tower_back);
            this._data.patch(Mod_Notify_Base.update_rulai_status, this.rulaiStateCallBack);
            this._data.patch(Mod_Notify_Base.roll_cake, this.rollCakeCallBack);
            this._data.patch(Mod_Notify_Base.special_notify, this.tianDiYuPaiNotifyCallBack);
            this._data.patch(Mod_Achievement_Base.notify_complete_achievement, this.notifyCompleteAchievementCallBack);
            this._data.patch(Mod_Item_Base.notify_super_gift_items, this.notify_super_gift_items_back);
            this._data.patch(Mod_Notify_Base.server_war_winner, this.server_war_winner_back);
            this._data.patch(Mod_Notify_Base.server_faction_war_winner, this.server_faction_war_winner_back);
            this._data.patch(Mod_Notify_Base.world_war_top_login, this.world_war_top_login_back);
            this._data.patch(Mod_SealSoul_Base.notify_get, this.sealStoneNotifyGetCallBack);
            this._data.patch(Mod_Notify_Base.zodiac_entry_notify, this.zodiacEntryNotifyCallBack);
            this._data.patch(Mod_Notify_Base.get_pet_animal_exp, this.get_pet_animal_exp_back);
            this._data.patch(Mod_Notify_Base.study_stunt_notify, this.studyStuntNotifyCallBack);
            this._data.patch(Mod_StudyStunt_Base.player_can_study_stunt, this.playerCanStudyStuntNotifyCallBack);
            this._data.patch(Mod_Notify_Base.update_player_super_gift, this.update_player_super_gift_back);
            this._view.liveness.getBoxInfo();
            this._data.patch(Mod_Assistant_Base.complete_number, this.completeNumberCallBack);
            this._view.factionWindow.factionWarInit();
            this._data.patch(Mod_Notify_Base.cat_hunt_golden_box, this.catHuntGoldenBoxCallBack);
            this._data.patch(Mod_Notify_Base.week_ranking, this.weekRankingCallBack);
            this._data.patch(Mod_BeelzebubTrials_Base.notify, this.beelzebubTrialsNotifyCallBack);
            this._data.patch(Mod_NineRegions_Base.get_player_bless_level, new Function());
            if (this._view.screen.currentMap)
            {
                this._view.screen.currentMap.getPrestigeNo1PlayerId();
            }
            this._data.patch(Mod_TopWar_Base.notify, this.topWarNotifyCallBack);
            this._data.call(Mod_NewTopWar_Base.get_top_war_step, this.newTopwarStep, []);
            this._data.patch(Mod_NewTopWar_Base.update_step, this.newTopwarStep1);
            this._data.patch(Mod_Notify_Base.world_top_war_gift_has_white_tiger, this.world_top_war_gift_q0);
            this._data.patch(Mod_FactionMonster_Base.notify, this.factionMonsterNotify);
            this._data.patch(Mod_FactionMonster_Base.get_win_player_list, this.getWinPlayerListBack);
            this._view.factionWindow.getFactionMonsterTime();
            this._data.patch(Mod_FactionMonster_Base.notify_get_award, this.getFactionMonsterAwardBack);
            return;
        }// end function

        private function getFactionMonsterAwardBack() : void
        {
            var _loc_1:* = this._ctrl.factionMonster.notifyAwardObj;
            var _loc_2:* = TextLinkType.Player + "_" + _loc_1.playerId + "_" + _loc_1.nickName;
            var _loc_3:String = "";
            var _loc_5:* = HtmlText.yellow("<u><a href=\'event:" + _loc_2 + "\'>" + _loc_1.nickName + "</a></u></font>");
            _loc_3 = HtmlText.yellow("<u><a href=\'event:" + _loc_2 + "\'>" + _loc_1.nickName + "</a></u></font>");
            var _loc_4:* = HtmlText.format(keepAliveLang.BanPai, 8438377);
            if (_loc_1.bKiller)
            {
                var _loc_5:* = _loc_4 + Lang.sprintf(keepAliveLang.KillAward, _loc_3, _loc_1.itemNum, HtmlText.yellow(keepAliveLang.QingLongLing));
                _loc_4 = _loc_4 + Lang.sprintf(keepAliveLang.KillAward, _loc_3, _loc_1.itemNum, HtmlText.yellow(keepAliveLang.QingLongLing));
            }
            else
            {
                var _loc_5:* = _loc_4 + Lang.sprintf(keepAliveLang.JoinAward, _loc_3, _loc_1.itemNum, HtmlText.yellow(keepAliveLang.QingLongLing));
                _loc_4 = _loc_4 + Lang.sprintf(keepAliveLang.JoinAward, _loc_3, _loc_1.itemNum, HtmlText.yellow(keepAliveLang.QingLongLing));
            }
            this._view.chat.receive(_loc_4, false, Mod_Chat_Base.FACTION);
            return;
        }// end function

        private function factionMonsterNotify() : void
        {
            var _loc_1:* = this._ctrl.factionMonster.actityStatus;
            this._ctrl.factionMonster.openTime.state = this._ctrl.factionMonster.actityStatus;
            if (this._ctrl.factionMonster.bMonsterDead)
            {
                this._view.townMap.removeFactionMonsterById(this._ctrl.factionMonster.deathMonsterId);
                return;
            }
            switch(this._ctrl.factionMonster.actityStatus)
            {
                case Mod_FactionMonster_Base.OPEN:
                {
                    this._view.townMap.getFactionMonsterInfo();
                    this._view.townMap.joinFactionMonster();
                    this._view.factionWindow.getFactionMonsterTime();
                    this.showOpenFactionMonster();
                    break;
                }
                case Mod_FactionMonster_Base.CLOSE:
                {
                    this._view.factionWindow.getFactionMonsterTime();
                    this._view.townMap.removeAllFactionMonster();
                    if (this.lastState != Mod_FactionMonster_Base.OVER)
                    {
                        if (ActivityType.FactionLevel >= 4)
                        {
                            this._view.chat.receive(this.factionMonsterClose, false, Mod_Chat_Base.FACTION);
                        }
                        this.showFactionMonsterClose();
                    }
                    break;
                }
                case Mod_FactionMonster_Base.OVER:
                {
                    this._view.townMap.resetPlayerScale();
                    this._view.factionWindow.getFactionMonsterTime();
                    this._view.townMap.removeAllFactionMonster();
                    this.showFactionMonsterClose();
                    this._view.townMap.getAward();
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_1:* = this._ctrl.factionMonster.actityStatus;
            this.lastState = this._ctrl.factionMonster.actityStatus;
            return;
        }// end function

        public function showFactionMonsterClose() : void
        {
            if (this._ctrl.player.jihuisuoId != 0 && !this._view.factionMonsterWar.bInStage)
            {
                this._view.worldNotice.showMessage(keepAliveLang.ThisFactionMonsterOver);
            }
            return;
        }// end function

        public function showOpenFactionMonster() : void
        {
            if (ActivityType.FactionLevel < 4)
            {
                return;
            }
            var _loc_1:* = HtmlText.format(keepAliveLang.BanPai, 8438377) + HtmlText.white(keepAliveLang.OpenFactionMonster);
            var _loc_2:* = _loc_1 + ("<font color=\'#ffff00\'><u><a href=\'event:" + TextLinkType.GotoJiHuiSuo + "\'>" + keepAliveLang.JoinNow + "</a></u></font>");
            _loc_1 = _loc_1 + ("<font color=\'#ffff00\'><u><a href=\'event:" + TextLinkType.GotoJiHuiSuo + "\'>" + keepAliveLang.JoinNow + "</a></u></font>");
            this._view.chat.receive(_loc_1, false, Mod_Chat_Base.FACTION);
            this._view.worldNotice.showMessage(keepAliveLang.ThisFactionMonsterStart);
            return;
        }// end function

        private function get factionMonsterClose() : String
        {
            var _loc_1:* = HtmlText.format(keepAliveLang.BanPai, 8438377) + HtmlText.white(keepAliveLang.NotKillAll);
            return _loc_1;
        }// end function

        private function getWinPlayerListBack() : void
        {
            var _loc_4:Object = null;
            var _loc_5:String = null;
            var _loc_1:* = this._ctrl.factionMonster.killPlayerList;
            var _loc_2:* = HtmlText.format(keepAliveLang.BanPai, 8438377) + HtmlText.white(keepAliveLang.KillNameList);
            var _loc_3:int = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                if (_loc_3 != 0)
                {
                    var _loc_6:* = _loc_2 + "、";
                    _loc_2 = _loc_2 + "、";
                }
                _loc_4 = _loc_1[_loc_3];
                _loc_5 = TextLinkType.Player + "_" + _loc_4.playerId + "_" + _loc_4.nickName;
                var _loc_6:* = _loc_2 + HtmlText.yellow("<u><a href=\'event:" + _loc_5 + "\'>" + _loc_4.nickName + "</a></u></font>");
                _loc_2 = _loc_2 + HtmlText.yellow("<u><a href=\'event:" + _loc_5 + "\'>" + _loc_4.nickName + "</a></u></font>");
                _loc_3++;
            }
            this._view.chat.receive(_loc_2, false, Mod_Chat_Base.FACTION);
            var _loc_6:* = HtmlText.format(keepAliveLang.BanPai, 8438377) + HtmlText.white(keepAliveLang.WinnerAward);
            _loc_2 = HtmlText.format(keepAliveLang.BanPai, 8438377) + HtmlText.white(keepAliveLang.WinnerAward);
            this._view.chat.receive(_loc_2, false, Mod_Chat_Base.FACTION);
            return;
        }// end function

        public function weekRankingCallBack() : void
        {
            var _loc_1:* = this._ctrl.notify.getWeekRanking;
            this._view.worldNotice.showMessage(_loc_1);
            if (this._view.screen.currentMap)
            {
                this._view.screen.currentMap.getPrestigeNo1PlayerId();
            }
            return;
        }// end function

        public function update_player_super_gift_back() : void
        {
            var _loc_1:String = null;
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            for each (_loc_6 in ActivityType.GiftList)
            {
                
                _loc_1 = _loc_5[_loc_4];
                this._view.activities.removeActivity(_loc_1);
            }
            _loc_2 = this._ctrl.notify.giftList;
            for each (_loc_6 in _loc_2)
            {
                
                _loc_3 = _loc_5[_loc_4];
                this._view.activities.addActivity(_loc_3.sign);
                this._view.activities.showActivityTitle(_loc_3.sign, keepAliveLang.ClickGet);
            }
            return;
        }// end function

        private function get_pet_animal_exp_back() : void
        {
            this._view.worldNotice.showMessage(this._ctrl.notify.petBaoJi);
            return;
        }// end function

        private function pass_tower_back() : void
        {
            this._view.tower.updateNotice(this._ctrl.notify.passTowerMsg);
            return;
        }// end function

        private function rollCakeCallBack() : void
        {
            RollCakeType.loadData(function () : void
            {
                var _loc_1:* = _ctrl.notify.rollCakInfo;
                _view.chat.receive(_loc_1.info, true);
                return;
            }// end function
            );
            return;
        }// end function

        private function notify_super_gift_items_back() : void
        {
            this._view.alert.confirm(this._ctrl.item.giftUseMsg);
            return;
        }// end function

        private function server_war_winner_back() : void
        {
            this._view.worldNotice.showMessage(this._ctrl.notify.serverWarWinnerMsg);
            return;
        }// end function

        private function server_faction_war_winner_back() : void
        {
            this._view.worldNotice.showMessage(this._ctrl.notify.serverFactionWarWinnerMsg);
            return;
        }// end function

        public function world_war_top_login_back() : void
        {
            if (this._ctrl.notify.firstLoginWorld == "")
            {
                return;
            }
            this._view.worldNotice.showMessage(this._ctrl.notify.firstLoginWorld);
            this._view.chat.receive(this._ctrl.notify.firstLoginChat, true, Mod_Chat_Base.WORLD);
            var _loc_1:String = "";
            this._ctrl.notify.firstLoginWorld = "";
            return;
        }// end function

        public function rulaiStateCallBack() : void
        {
            var data:Object;
            var value:Number;
            var startTime:int;
            var callback:Function;
            var obj:Object;
            if (FunctionType.isOpened(FunctionType.TakeBible))
            {
                data = this._ctrl.notify.rulaiStatus;
                var _loc_2:* = data.type;
                this._view.takeBibleRoad.rulaiType = data.type;
                switch(data.type)
                {
                    case Mod_Notify_Base.RULAI_OPEN_FOR_CALL:
                    {
                        this.rulaiType(1);
                        var _loc_2:int = 0;
                        _view.takeBibleReady.awardState = 0;
                        break;
                    }
                    case Mod_Notify_Base.RULAI_OPEN:
                    {
                        value = this._view.takeBibleRuLai.checkAwardState(data.ruLaiPlayerAry);
                        var _loc_2:* = value;
                        this._view.takeBibleReady.awardState = value;
                        if (this._view.takeBibleRoad.inStage)
                        {
                            this._view.takeBibleRoad.updateRuLaiData();
                        }
                        else if (this.checkCalled(data.ruLaiPlayerAry))
                        {
                            callback = function () : void
            {
                this._view.takeBibleRoad.updateRuLaiData();
                return;
            }// end function
            ;
                            this._view.alert.confirm(keepAliveLang.IsNotOpenRuLai);
                        }
                        this._view.takeBibleRuLai.close();
                        this.rulaiType(2);
                        break;
                    }
                    case Mod_Notify_Base.RULAI_CLOSE:
                    {
                        if (this._view.takeBibleReady.inStage)
                        {
                            var _loc_2:int = 0;
                            _view.takeBibleReady.awardState = 0;
                            this._view.takeBibleReady.get_take_bible_info();
                        }
                        this.rulaiType(3);
                        startTime = this._view.takeBibleRoad.getStartTime;
                        if (startTime == 0)
                        {
                            obj = this._view.takeBibleRoad._rulaiStartTimeList[0];
                            var _loc_2:* = obj.startTime;
                            startTime = obj.startTime;
                        }
                        var _loc_2:* = startTime;
                        data.time = startTime;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (this._view.takeBibleReady.inStage)
                {
                    this._view.takeBibleReady.get_take_bible_info();
                }
                var _loc_2:* = data;
                this._view.takeBibleRoad.getRuLaiData = data;
                this._view.takeBibleRoad.get_take_bible_updata_data();
                if (data.type == Mod_Notify_Base.RULAI_OPEN)
                {
                    this._view.worldNotice.showMessage(data.info);
                }
            }
            return;
        }// end function

        private function checkCalled(param1:Array) : Boolean
        {
            var _loc_3:Object = null;
            var _loc_2:* = _ctrl.player.playerId;
            for each (_loc_6 in param1)
            {
                
                _loc_3 = _loc_5[_loc_4];
                if (_loc_2 == _loc_3["player_id"])
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function rulaiType(param1:int) : void
        {
            var _loc_2:* = VIPType.check(VIPType.Level4);
            switch(param1)
            {
                case 1:
                {
                    this._view.activities.showActivityTitle(FunctionType.TakeBible, keepAliveLang.CanCall);
                    this._view.activities.visibleBtnEffect(FunctionType.TakeBible, keepAliveLang.RuLaiSpirit, false);
                    this._view.activities.visibleBtnEffect(FunctionType.TakeBible, keepAliveLang.CanCall, false);
                    if (_loc_2 == false)
                    {
                        this._view.activities.hideActivityTimer(FunctionType.TakeBible, keepAliveLang.CanCall);
                    }
                    break;
                }
                case 2:
                {
                    if (this._ctrl.TakeBible.canTakeBibleTimes > 0)
                    {
                        this._view.activities.visibleBtnEffect(FunctionType.TakeBible, keepAliveLang.RuLaiSpirit, true);
                    }
                    else
                    {
                        this._view.activities.visibleBtnEffect(FunctionType.TakeBible, keepAliveLang.CanCall, false);
                        this._view.activities.visibleBtnEffect(FunctionType.TakeBible, keepAliveLang.RuLaiSpirit, false);
                    }
                    _view.activities.showActivityTitle(FunctionType.TakeBible, keepAliveLang.RuLaiSpirit);
                    break;
                }
                case 3:
                {
                    _view.activities.showActivityTitle(FunctionType.TakeBible, keepAliveLang.RuLaiSpirit);
                    this._view.activities.hideActivityTimer(FunctionType.TakeBible, keepAliveLang.RuLaiSpirit);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function playerTakeBibleCallBack() : void
        {
            var _loc_1:Object = null;
            if (FunctionType.isOpened(FunctionType.TakeBible))
            {
                _loc_1 = this._ctrl.notify.takeBible;
                this._view.worldNotice.showMessage(_loc_1.info);
            }
            return;
        }// end function

        private function playerTakeBibleBerobbedCallBack() : void
        {
            var _loc_1:Object = null;
            if (FunctionType.isOpened(FunctionType.TakeBible))
            {
                _loc_1 = this._ctrl.notify.takeBibleBerobbed;
                if (_loc_1.robPlayerNickname != this._ctrl.player.nickname)
                {
                    this._view.worldNotice.showMessage(_loc_1.info);
                }
                else
                {
                    var _loc_2:* = _loc_1;
                    this._takeBibleData = _loc_1;
                }
            }
            return;
        }// end function

        public function renderTakeBibleBerobbed() : void
        {
            if (this._takeBibleData == null)
            {
                return;
            }
            this._view.worldNotice.showMessage(this._takeBibleData.info);
            var _loc_1:String = null;
            this._takeBibleData = null;
            return;
        }// end function

        private function takeBibleNotifyCallBack() : void
        {
            var data:* = this._ctrl.TakeBible.notifyGlobal;
            switch(data.type)
            {
                case Mod_TakeBible_Base.BEROB:
                {
                    if (this._view.inWar)
                    {
                        this._robList.push(data);
                        var _loc_2:* = function () : void
            {
                robShow();
                return;
            }// end function
            ;
                        this._view.onWarClose = function () : void
            {
                robShow();
                return;
            }// end function
            ;
                    }
                    else
                    {
                        var _loc_2:* = data;
                        this._view.takeBibleRoad.beRob = data;
                    }
                    break;
                }
                case Mod_TakeBible_Base.PROTECT_BEROB:
                {
                    if (this._view.inWar)
                    {
                        this._robList.push(data);
                        var _loc_2:* = function () : void
            {
                robShow();
                return;
            }// end function
            ;
                        this._view.onWarClose = function () : void
            {
                robShow();
                return;
            }// end function
            ;
                    }
                    else
                    {
                        var _loc_2:* = data;
                        this._view.takeBibleRoad.beRob = data;
                    }
                    break;
                }
                case Mod_TakeBible_Base.APPLY_PROTECT:
                {
                    this.applyProtectList();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function robShow() : void
        {
            var _loc_1:Object = null;
            if (this._robList.length > 0)
            {
                _loc_1 = this._robList[0];
                switch(_loc_1.type)
                {
                    case Mod_TakeBible_Base.BEROB:
                    {
                        var _loc_2:* = _loc_1;
                        this._view.takeBibleRoad.beRob = _loc_1;
                        break;
                    }
                    case Mod_TakeBible_Base.PROTECT_BEROB:
                    {
                        var _loc_2:* = _loc_1;
                        this._view.takeBibleRoad.protectRob = _loc_1;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this._robList.splice(0, 1);
            }
            return;
        }// end function

        private function applyProtectList() : void
        {
            var _loc_4:Object = null;
            var _loc_5:String = null;
            var _loc_6:uint = 0;
            var _loc_1:* = this._ctrl.TakeBible.applyProtectList;
            var _loc_2:* = _loc_1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _loc_1[_loc_3];
                _loc_5 = Lang.sprintf(keepAliveLang.Invite, "<【" + _loc_4.playerShowName + "】&Y>", _loc_4.protectName, _loc_4.protectAwardFame);
                var _loc_7:* = AlertButtonType.Yes | AlertButtonType.No;
                _loc_6 = AlertButtonType.Yes | AlertButtonType.No;
                this._view.delayMessage.addDelayMessage(DelayNotifyType.TakeBibleApplyProtect, _loc_5, _loc_6, this.applyProtectCallback(_loc_4));
                this._ctrl.TakeBible.removeApplyProtect(_loc_4.playerId);
                _loc_3++;
            }
            return;
        }// end function

        private function applyProtectCallback(param1:Object) : Function
        {
            var data:* = param1;
            var handler:* = function (param1:uint) : void
            {
                if (AlertButtonType.Yes == param1)
                {
                    _view.takeBibleReady.approve_apply(data.playerId);
                }
                else
                {
                    _view.takeBibleReady.reject_apply(data.playerId);
                }
                return;
            }// end function
            ;
            return handler;
        }// end function

        private function faction_message_notify_back() : void
        {
            RollCakeType.loadData(function () : void
            {
                var _loc_1:* = _ctrl.faction.factionMessage;
                _view.chat.receive(_loc_1.info, false, Mod_Chat_Base.FACTION);
                return;
            }// end function
            );
            return;
        }// end function

        private function runeUseNotifyCallback() : void
        {
            var _loc_1:* = this._ctrl.rune.runeUseNotify;
            this._view.chat.addSystemMessage(Lang.sprintf(keepAliveLang.Rune, _loc_1.coins));
            this._view.rune.isBtnUser(_loc_1);
            return;
        }// end function

        private function disband_faction_notify_back() : void
        {
            this._view.townMap.quitJiHuiSuo();
            var _loc_1:int = 0;
            this._ctrl.player.playerInfo.factionId = 0;
            var _loc_1:String = "";
            this._ctrl.player.playerInfo.factionName = "";
            return;
        }// end function

        private function kickout_member_notify_back() : void
        {
            this._view.townMap.quitJiHuiSuo();
            var _loc_1:int = 0;
            this._ctrl.player.playerInfo.factionId = 0;
            var _loc_1:String = "";
            this._ctrl.player.playerInfo.factionName = "";
            return;
        }// end function

        private function notify_faction_war_over_back() : void
        {
            this._view.factionWarMap.showWorldNotice(this._ctrl.factionWarMap.overWorldMsg);
            var _loc_1:* = this._ctrl.factionWarMap.overChatMsg;
            if (_loc_1 != "")
            {
                this.receiveTown(_loc_1, true, Mod_Chat_Base.FACTION);
            }
            return;
        }// end function

        private function notify_give_faction_war_gift_back() : void
        {
            var _loc_2:String = null;
            var _loc_1:* = this._ctrl.factionWarMap.chatFaction;
            for each (_loc_5 in _loc_1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                this.receiveTown(_loc_2, true, Mod_Chat_Base.FACTION);
            }
            return;
        }// end function

        private function notify_good_faction_war_gift_back() : void
        {
            var _loc_2:String = null;
            var _loc_1:* = this._ctrl.factionWarMap.chatWorld;
            for each (_loc_5 in _loc_1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                this.receiveTown(_loc_2);
            }
            var _loc_3:* = this._ctrl.factionWarMap.chatFaction;
            _loc_1 = this._ctrl.factionWarMap.chatFaction;
            for each (_loc_5 in _loc_1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                this.receiveTown(_loc_2, false, Mod_Chat_Base.FACTION);
            }
            var _loc_3:* = this._ctrl.factionWarMap.showWorld;
            _loc_1 = this._ctrl.factionWarMap.showWorld;
            for each (_loc_5 in _loc_1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                this._view.worldNotice.showMessage(_loc_2, 9);
            }
            return;
        }// end function

        private function lucky_wheel_award_seven_medicine_reel_back() : void
        {
            var _loc_1:* = this._ctrl.notify.luckyWheelNotify;
            this._view.worldNotice.showMessage(_loc_1);
            return;
        }// end function

        private function find_immortal_five_notify_back() : void
        {
            return;
        }// end function

        private function exchange_hu_lu_wa_notify_back() : void
        {
            var _loc_1:* = this._ctrl.notify.huLuWa;
            var _loc_2:* = _loc_1.info;
            this._view.worldNotice.showMessage(_loc_2);
            return;
        }// end function

        private function unlock_special_partner_back() : void
        {
            this._view.specialPartner.getPartnerInfo();
            return;
        }// end function

        private function hourlyRefresh() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:String = null;
            _loc_1 = this._view.ctrl.player.serverTime;
            _loc_2 = TimeChange.timerToNum(_loc_1);
            if (_loc_2 == "00:00")
            {
                this._view.rune.rune_list();
            }
            return;
        }// end function

        private function completeReelProduction() : void
        {
            var _loc_1:Array = null;
            var _loc_2:String = null;
            _loc_1 = this._ctrl.notify.reelList;
            for each (_loc_5 in _loc_1)
            {
                
                _loc_2 = _loc_4[_loc_3];
                this.receiveTown(_loc_2);
            }
            return;
        }// end function

        public function patchNotifyGlobal() : void
        {
            this._data.patch(Mod_SuperSport_Base.notify_global, this.notifyGlobalCallBack);
            return;
        }// end function

        public function cancelPatchNotifyGlobal() : void
        {
            this._data.cancelPatch(Mod_SuperSport_Base.notify_global);
            return;
        }// end function

        private function open_world_boss_back() : void
        {
            var _loc_1:String = null;
            var _loc_2:String = null;
            _loc_1 = this._ctrl.worldBossMap.notifyBoss.worldTips;
            if (_loc_1 != "")
            {
                this._view.worldNotice.showMessage(_loc_1);
            }
            _loc_2 = this._ctrl.worldBossMap.notifyBoss.chatTips;
            if (_loc_2 != "")
            {
                this.receiveTown(_loc_2, false, Mod_Chat_Base.FACTION);
            }
            this._view.activityWindow.get_world_boss_list();
            this._view.worldBossMap.updateBossOpen();
            return;
        }// end function

        private function close_world_boss_back() : void
        {
            var _loc_1:String = null;
            _loc_1 = this._ctrl.worldBossMap.notifyBoss.chatTips;
            setTimeout(this.receiveTown, 5000, _loc_1);
            setTimeout(this.receiveTown, 30000, _loc_1);
            this._view.activityWindow.get_world_boss_list();
            this._view.worldBossMap.updateBossOver();
            return;
        }// end function

        private function defeat_world_boss_back() : void
        {
            var _loc_1:String = null;
            _loc_1 = this._ctrl.worldBossMap.notifyBoss.chatTips;
            setTimeout(this.receiveTown, 5000, _loc_1);
            setTimeout(this.receiveTown, 30000, _loc_1);
            this._view.activityWindow.get_world_boss_list();
            this._view.worldBossMap.updateBossKill();
            return;
        }// end function

        private function worldBossLowHealth() : void
        {
            this._view.worldNotice.showMessage(Lang.sprintf(BossInfoLang.BossLowHealth, BossInfo.getBossNameById(this._ctrl.worldBossMap.lowHealthBossId)));
            return;
        }// end function

        private function pkAwardCallBack() : void
        {
            var _loc_1:String = null;
            _loc_1 = this._ctrl.notify.pkAward;
            this.receiveTown(_loc_1);
            return;
        }// end function

        private function goodFateCallBack() : void
        {
            var _loc_1:String = null;
            _loc_1 = this._ctrl.notify.getGoodFate;
            this.receiveTown(_loc_1);
            return;
        }// end function

        public function notifyGlobalCallBack() : void
        {
            var _loc_1:Object = null;
            _loc_1 = this._ctrl.superSport.notifyGlobal;
            if (_loc_1.type == Mod_SuperSport_Base.AWARD_TOP)
            {
                this.receiveTown(_loc_1.info);
            }
            else if (this._view.superSport.startChallenge)
            {
                this._showMessageList.push(_loc_1);
            }
            else
            {
                this.hasGlobalShow(_loc_1);
            }
            return;
        }// end function

        public function saveNotifyGlobal() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Object = null;
            _loc_1 = this._showMessageList.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._showMessageList[_loc_2];
                this.hasGlobalShow(_loc_3);
                _loc_2++;
            }
            var _loc_4:* = [];
            this._showMessageList = [];
            return;
        }// end function

        private function hasGlobalShow(param1:Object) : void
        {
            if (param1.type == Mod_SuperSport_Base.WIN_TOP)
            {
                if (param1.winTimesTop >= 5)
                {
                    this.sendGlobalShow(param1);
                }
            }
            else if (param1.type == Mod_SuperSport_Base.KILL_WIN_TOP)
            {
                if (param1.timesTop >= 5)
                {
                    this.sendGlobalShow(param1);
                }
            }
            else
            {
                this.sendGlobalShow(param1);
            }
            return;
        }// end function

        private function sendGlobalShow(param1:Object) : void
        {
            this._view.worldNotice.showMessage(param1.worldInfo);
            this._view.superSport.changeNotife(param1.info);
            return;
        }// end function

        private function mission_award_back() : void
        {
            var _loc_1:Array = null;
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            _loc_1 = this._ctrl.notify.missionAwardList;
            for each (_loc_6 in _loc_1)
            {
                
                _loc_2 = _loc_5[_loc_4];
                _loc_3 = _loc_2.shift();
                if (_loc_3 == this._ctrl.player.playerId && this._view.war.requested == true)
                {
                    var _loc_6:* = this.thisAwardList.concat(_loc_2);
                    this.thisAwardList = this.thisAwardList.concat(_loc_2);
                    this._view.delayExecute(DelayType.MissionAward, this.mission_award_back);
                    continue;
                }
                while (_loc_2.length)
                {
                    
                    this.receiveTown(_loc_2.pop());
                }
            }
            if (this._view.war.requested == false)
            {
                while (this.thisAwardList.length)
                {
                    
                    this.receiveTown(this.thisAwardList.pop());
                }
            }
            return;
        }// end function

        private function updatePlayerDataCallback() : void
        {
            var control:PlayerController;
            var change:int;
            var str:String;
            control = this._ctrl.player;
            if (control.isChanged(Mod_Player_Base.PLAYER_COINS))
            {
                this.updateCoins();
            }
            if (control.isChanged(Mod_Player_Base.PLAYER_INGOT))
            {
                this.updateIngot();
            }
            if (control.isChanged(Mod_Player_Base.PLAYER_HEALTH) || control.isChanged(Mod_Player_Base.PLAYER_MAX_HEALTH))
            {
                this.updateHealth();
            }
            if (control.isChanged(Mod_Player_Base.PLAYER_POWER))
            {
                this.updatePower();
            }
            if (control.isChanged(Mod_Player_Base.PLAYER_EXPERIENCE))
            {
                this.updateExperience();
            }
            if (control.isChanged(Mod_Player_Base.PLAYER_TOWN_KEY))
            {
                this._view.heroMission.changeTownKey();
            }
            if (control.isChanged(Mod_Player_Base.PLAYER_PACK_EMPTY_NUM))
            {
                var _loc_2:* = control.packNum;
                this._view.missionPractice.pickNum = control.packNum;
                if (control.packNum == 0)
                {
                    this._toolbar.addPackFull();
                }
                else
                {
                    this._toolbar.removePackFull();
                }
            }
            if (control.isChanged(Mod_Player_Base.PLAYER_LEVEL))
            {
                this.updateLevel();
            }
            this.partnerUpgrade();
            if (control.isChanged(Mod_Player_Base.PLAYER_TRANSPORT))
            {
                this._view.missionMap.updatePlayerBody();
                this.updateMountsBuffer();
            }
            if (control.isChanged(Mod_Player_Base.PLAYER_AVATAR))
            {
                this._view.missionMap.updatePlayerBody();
                this.updateAvatarBuffer();
            }
            if (control.isChanged(Mod_Player_Base.BUY_NUMBER))
            {
                this._view.findImmortal.summonTimes();
            }
            this.updateExtraPower();
            if (control.hasNewFunction)
            {
                var _loc_2:Boolean = false;
                control.hasNewFunction = false;
                this._view.screen.currentMap.updateNpcLoack(control.functionLock);
                this.delayOpenFunction();
            }
            if (control.hasQuestState)
            {
                var _loc_2:Boolean = false;
                control.hasQuestState = false;
                this.delayLoadQuestTrace();
            }
            if (control.isChanged(Mod_Player_Base.HEALTH_UP_SYS))
            {
                this._view.delayExecute(DelayType.HealthUpdateMessage, function () : void
            {
                _view.chat.addSystemMessage(keepAliveLang.HealthFull);
                return;
            }// end function
            );
            }
            if (control.isChanged(Mod_Player_Base.GET_ONLINE_GIFT))
            {
                this._view.activities.onlineGiftActivity();
            }
            if (control.isChanged(Mod_Player_Base.CAMP_SALARY))
            {
                if (this._ctrl.player.campSalaryEnabled)
                {
                    this._view.activities.openActivity(TownType.CampSalary);
                    this._view.activities.addCampSalaryActivityTip();
                }
                else
                {
                    this._view.activities.removeActivity(TownType.CampSalary);
                }
            }
            if (control.isChanged(Mod_Player_Base.PLAYER_DAY_QUEST))
            {
                if (this._ctrl.player.dayQuestState == 1)
                {
                    this._view.activities.showActivityTitle(FunctionType.DailyQuest, keepAliveLang.CanComplete);
                    this._view.activities.visibleBtnEffect(FunctionType.DailyQuest, FunctionType.DailyQuest, true);
                }
                else if (this._ctrl.player.dayQuestState == 0)
                {
                    this._view.activities.hideActivityTimer(FunctionType.DailyQuest, keepAliveLang.CanComplete);
                    this._view.activities.visibleBtnEffect(FunctionType.DailyQuest, FunctionType.DailyQuest, false);
                }
            }
            if (control.isChanged(Mod_Player_Base.FINISH_DAY_QUEST))
            {
                if (this._ctrl.player.finishDayQuest == 1)
                {
                    this._view.activities.removeActivity(FunctionType.DailyQuest);
                }
                else if (this._ctrl.player.finishDayQuest == 0)
                {
                    this._view.activities.addActivity(FunctionType.DailyQuest);
                }
            }
            if (control.isChanged(Mod_Player_Base.CAN_INCENSE_COUNT))
            {
                this._view.factionBlessing.checkIncense();
            }
            if (control.isChanged(Mod_Player_Base.VIP_LEVEL))
            {
                if (FunctionType.isOpened(FunctionType.Rune))
                {
                    this._view.rune.rune_list();
                }
                this.checkRechargeVisible();
                this.updatePower();
            }
            if (control.isChanged(Mod_Player_Base.PLAYER_SKILL))
            {
                this.updateSkill();
            }
            if (control.isChanged(Mod_Player_Base.FAME))
            {
                this.updateFame();
                var _loc_2:* = this._ctrl.player.fameChange;
                change = this._ctrl.player.fameChange;
                if (change > 0)
                {
                    var _loc_2:* = "+" + change + keepAliveLang.Fame;
                    str = "+" + change + keepAliveLang.Fame;
                    this.showPlayerTextEffect(str, 15658734);
                }
            }
            if (control.isChanged(Mod_Player_Base.STATE_POINT))
            {
                this.updateStatePoint();
            }
            var _loc_2:* = control.vipLevel;
            this.vipLevel = control.vipLevel;
            this._view.processTip.checkOpenGift();
            return;
        }// end function

        private function updateCoins() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:String = null;
            if (this.coinDelay == true)
            {
                this._view.delayExecute(DelayType.CoinDelay, this.updateCoins);
                return;
            }
            var _loc_3:* = this._ctrl.player.coins;
            this._toolbar.coins = this._ctrl.player.coins;
            var _loc_3:* = this._ctrl.player.coins;
            this._view.superSport.renderCoins = this._ctrl.player.coins;
            var _loc_3:* = this._ctrl.player.coins;
            this._view.lodge.renderCoins = this._ctrl.player.coins;
            var _loc_3:* = this._ctrl.player.coins;
            this._view.upgrade.updateCoins = this._ctrl.player.coins;
            var _loc_3:* = this._ctrl.player.coins;
            this._view.takeBibleRoad.renderCoins = this._ctrl.player.coins;
            var _loc_3:* = this._ctrl.player.coins;
            this._view.serverWarCup.renderCoins = this._ctrl.player.coins;
            var _loc_3:* = this._ctrl.player.coins;
            this._view.serverFactionWarCup.renderCoins = this._ctrl.player.coins;
            var _loc_3:* = this._ctrl.player.coins;
            this._view.worldFactionWarCup.renderCoins = this._ctrl.player.coins;
            var _loc_3:* = this._ctrl.player.coins;
            this._view.furnaceMap.coinsValue = this._ctrl.player.coins;
            var _loc_3:* = this._ctrl.player.coins;
            this._view.findImmortal.coins = this._ctrl.player.coins;
            if (this.isJustEquipUpgrade)
            {
                this.minUpgradeCoinEquip();
            }
            else
            {
                this.checkIsCanEquipUpgrade();
            }
            _loc_1 = this._ctrl.player.coinChange;
            if (_loc_1 > 0)
            {
                _loc_2 = "+" + _loc_1 + keepAliveLang.Coin;
                this.showPlayerTextEffect(_loc_2, 15658734);
            }
            return;
        }// end function

        private function updateIngot() : void
        {
            var _loc_1:int = 0;
            var _loc_2:String = null;
            var _loc_3:* = this._ctrl.player.ingot;
            this._toolbar.ingot = this._ctrl.player.ingot;
            var _loc_3:* = this._ctrl.player.ingot;
            this._view.superSport.renderIngot = this._ctrl.player.ingot;
            var _loc_3:* = this._ctrl.player.ingot;
            this._view.lodge.renderIngot = this._ctrl.player.ingot;
            var _loc_3:* = this._ctrl.player.ingot;
            this._view.takeBibleRoad.renderIngot = this._ctrl.player.ingot;
            var _loc_3:* = this._ctrl.player.ingot;
            this._view.serverWarCup.renderIngot = this._ctrl.player.ingot;
            var _loc_3:* = this._ctrl.player.ingot;
            this._view.serverFactionWarCup.renderIngot = this._ctrl.player.ingot;
            var _loc_3:* = this._ctrl.player.ingot;
            this._view.worldFactionWarCup.renderIngot = this._ctrl.player.ingot;
            var _loc_3:* = this._ctrl.player.ingot;
            this._view.furnaceMap.ingotValue = this._ctrl.player.ingot;
            var _loc_3:* = this._ctrl.player.ingot;
            this._view.findImmortal.ingot = this._ctrl.player.ingot;
            _loc_1 = this._ctrl.player.ingotChange;
            if (_loc_1 > 0)
            {
                _loc_2 = "+" + _loc_1 + keepAliveLang.Ingot;
                this.showPlayerTextEffect(_loc_2, 16773632);
            }
            return;
        }// end function

        private function updateFame() : void
        {
            var _loc_1:* = this._ctrl.player.fame;
            this._view.findImmortal.fame = this._ctrl.player.fame;
            return;
        }// end function

        private function updateStatePoint() : void
        {
            this._view.goldOilShop.updateStatePoint();
            return;
        }// end function

        private function showPlayerTextEffect(param1:String, param2:uint) : void
        {
            if (this._view.screen.currentMap != null)
            {
                this._view.screen.currentMap.showTextEffect(param1, param2);
            }
            return;
        }// end function

        private function updateHealth() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            _loc_1 = this._ctrl.player.health;
            _loc_2 = this._ctrl.player.maxHealth;
            if (this._blockedHealth == true)
            {
                this._toolbar.health(_loc_2, _loc_2);
                return;
            }
            if (this._view.war.requested == true)
            {
                this._view.delayExecute(DelayType.UpdateHealth, this.updateHealth);
            }
            else
            {
                if (_loc_1 > _loc_2)
                {
                    Helper.alert(keepAliveLang.Health, _loc_1, keepAliveLang.MaxHealth, _loc_2, keepAliveLang.CheckReturn);
                    var _loc_3:* = _loc_2;
                    _loc_1 = _loc_2;
                }
                this._toolbar.health(_loc_1, _loc_2);
            }
            return;
        }// end function

        public function blockHealthInCampWar() : void
        {
            var _loc_1:Boolean = true;
            this._blockedHealth = true;
            this.updateHealth();
            return;
        }// end function

        public function unblockHealthInCampWar() : void
        {
            var _loc_1:Boolean = false;
            this._blockedHealth = false;
            this.updateHealth();
            return;
        }// end function

        private function updatePower() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:String = null;
            _loc_1 = this._ctrl.player.power;
            this._data.call(Mod_Player_Base.get_buy_power_data, this.buyPowerDataCallBack, []);
            var _loc_4:* = FunctionType.isOpened(FunctionType.BuyPower) && _loc_1 < 200 && VIPType.enabled;
            this._toolbar.powerVisible = FunctionType.isOpened(FunctionType.BuyPower) && _loc_1 < 200 && VIPType.enabled;
            if (_loc_1 < 5)
            {
                this._view.processTip.openPracticeTip();
            }
            else
            {
                this._view.processTip.removeType(ProcessTipsType.Practice);
            }
            this._view.gameHelper.updateGameAssistant();
            this._view.liveness.updateInfo();
            var _loc_4:* = _loc_1;
            this._view.missionPractice.upDataPower = _loc_1;
            var _loc_4:* = _loc_1;
            this._view.heroPractice.upDataPower = _loc_1;
            this._toolbar.power(_loc_1, _loc_1 > 200 ? (_loc_1) : (200));
            _loc_2 = _loc_1 - this._oldPower;
            if (_loc_2 > 0)
            {
                this._view.chat.addSystemMessage(Lang.sprintf(keepAliveLang.GetPower, _loc_2));
                _loc_3 = "+" + _loc_2 + keepAliveLang.Power;
                this.showPlayerTextEffect(_loc_3, 2552101);
            }
            var _loc_4:* = _loc_1;
            this._oldPower = _loc_1;
            return;
        }// end function

        private function buyPowerDataCallBack() : void
        {
            var _loc_1:Object = null;
            _loc_1 = this._ctrl.player.buyPowerData;
            var _loc_2:* = _loc_1;
            this._toolbar.powerInfo = _loc_1;
            var _loc_2:* = _loc_1.buyNum;
            this._view.missionPractice.getLostPowerNum = _loc_1.buyNum;
            var _loc_2:* = _loc_1.buyNum;
            this._view.heroPractice.getLostPowerNum = _loc_1.buyNum;
            return;
        }// end function

        public function checkWarCdTime(param1:Function, param2:int = 13) : void
        {
            var handle:Function;
            var callback:* = param1;
            var type:* = param2;
            handle = function () : void
            {
                var _loc_1:Object = null;
                _loc_1 = _ctrl.player.hasWarCdTime;
                if (_loc_1.hasWarTime)
                {
                    _view.tip2.showHackToolsTip(_loc_1.cdTimer);
                }
                callback(_loc_1.hasWarTime);
                return;
            }// end function
            ;
            this._data.call(Mod_Player_Base.get_player_war_cd_time, handle, [type]);
            return;
        }// end function

        private function buyGoodStuffInLuckyShopCallBack() : void
        {
            var _loc_1:Object = null;
            _loc_1 = this._ctrl.notify.getBuyGoodStuffInLuckyShop();
            this._view.chat.addSystemMessage(_loc_1["chat"] as String);
            return;
        }// end function

        private function blessingCountChangeCallBack() : void
        {
            this._view.factionBlessing.getBlessingCount();
            return;
        }// end function

        private function blessingCountAndExpAddNotifyCallBack() : void
        {
            this._view.worshipMars.getBlessingTimesAndExpAdd();
            return;
        }// end function

        private function gameTimerCallBack() : void
        {
            var callBack:Function;
            callBack = function () : void
            {
                if (_view.factionWindow.inStage)
                {
                    _view.factionEat.call_eat_info();
                    _view.factionSeal.seal_satan_info();
                }
                else if (_view.factionSeal.inStage)
                {
                    _view.factionSeal.seal_satan_member_list();
                    _view.factionSeal.seal_satan_info();
                }
                return;
            }// end function
            ;
            if (this._ctrl.notify.gameTimer["timer_type"] == Mod_Notify_Base.FACTION)
            {
                this._data.call(Mod_Faction_Base.is_can_join_activity, callBack, []);
            }
            if (this._ctrl.notify.gameTimer["timer_type"] == Mod_Notify_Base.CHANGE_MONEY)
            {
                this._view.rune.rune_list();
            }
            this._view.sealStone.notifyGet();
            this._view.rollCake.get_count();
            this._view.activities.redEnvelopes();
            this._view.weekRanking.show_Btn();
            this.peach_info();
            this._view.farm.getFarmlandinfoList();
            this._view.worshipMars.getRemainIncenseTimes();
            this._view.travelEvent.get_activity_info();
            this._view.sendFlower.update();
            this.getFactionRollCakeInfo();
            this._view.activities.refreshMissionStatus();
            this._view.haloRole.openHaloRole();
            return;
        }// end function

        private function server_time() : void
        {
            _data.call(Mod_Player_Base.server_time, this.gameTimerCallBack, []);
            return;
        }// end function

        private function sendFlowerCallBack() : void
        {
            var _loc_1:Object = null;
            var _loc_2:String = null;
            _loc_1 = this._ctrl.notify.sendFlowerInfo;
            _loc_2 = "";
            if (this.isNewYear())
            {
                if (_loc_1["receive_player_sex"] == 0)
                {
                    var _loc_3:* = Lang.sprintf(keepAliveLang.SendFlowerToMan, _loc_1["send_player_nickname"], _loc_1["receive_player_nickname"], HtmlText.format(_loc_1["flower_count"], HtmlText.Green, 24));
                    _loc_2 = Lang.sprintf(keepAliveLang.SendFlowerToMan, _loc_1["send_player_nickname"], _loc_1["receive_player_nickname"], HtmlText.format(_loc_1["flower_count"], HtmlText.Green, 24));
                }
                else
                {
                    var _loc_3:* = Lang.sprintf(keepAliveLang.SendFlowerToWoman, _loc_1["send_player_nickname"], _loc_1["receive_player_nickname"], HtmlText.format(_loc_1["flower_count"], HtmlText.Green, 24));
                    _loc_2 = Lang.sprintf(keepAliveLang.SendFlowerToWoman, _loc_1["send_player_nickname"], _loc_1["receive_player_nickname"], HtmlText.format(_loc_1["flower_count"], HtmlText.Green, 24));
                }
            }
            else
            {
                var _loc_3:* = Lang.sprintf(keepAliveLang.SendFlower, _loc_1["send_player_nickname"], _loc_1["receive_player_nickname"], HtmlText.format(_loc_1["flower_count"], HtmlText.Green, 24));
                _loc_2 = Lang.sprintf(keepAliveLang.SendFlower, _loc_1["send_player_nickname"], _loc_1["receive_player_nickname"], HtmlText.format(_loc_1["flower_count"], HtmlText.Green, 24));
            }
            this._view.worldNotice.showMessage(_loc_2);
            return;
        }// end function

        private function flowerWeekNumberOneCallBack() : void
        {
            var _loc_1:Object = null;
            var _loc_2:String = null;
            _loc_1 = this._ctrl.notify.flowerWeekNumberOne;
            _loc_2 = Lang.sprintf(keepAliveLang.FlowerWeekNumberOne, _loc_1["player_nickname"]);
            this._view.worldNotice.showMessage(_loc_2);
            return;
        }// end function

        private function notifyCompleteAchievementCallBack() : void
        {
            this._view.achievementComplete.notifyCompleteAchievementCallBack();
            return;
        }// end function

        private function isNewYear() : Boolean
        {
            var _loc_1:Date = null;
            var _loc_2:Boolean = false;
            _loc_1 = new Date(this._ctrl.player.serverTime * 1000);
            _loc_2 = _loc_1.month == 0 && (_loc_1.date >= 18 && _loc_1.date <= 31) || _loc_1.month == 1 && (_loc_1.date >= 1 && _loc_1.date <= 6);
            return _loc_2;
        }// end function

        private function sealStoneNotifyGetCallBack() : void
        {
            if (FunctionType.isOpened(FunctionType.SealSoul))
            {
                this._view.sealStone.notifyGetCallBack();
            }
            return;
        }// end function

        private function zodiacEntryNotifyCallBack() : void
        {
            var _loc_1:Object = null;
            _loc_1 = this._ctrl.notify.zodiacEntryNotify;
            this._view.worldNotice.showMessage(Lang.sprintf(keepAliveLang.ZodiacEntryNotify, _loc_1["nickname"], this.getChineseNumber(_loc_1["zodiac_leve"])));
            return;
        }// end function

        private function getChineseNumber(param1:int) : String
        {
            var _loc_2:Object = null;
            _loc_2 = {1:keepAliveLang.One, 2:keepAliveLang.Two, 3:keepAliveLang.Three, 4:keepAliveLang.Four, 5:keepAliveLang.Five, 6:keepAliveLang.Six, 7:keepAliveLang.Seven, 8:keepAliveLang.Eight, 9:keepAliveLang.Nine, 10:keepAliveLang.Ten};
            return _loc_2[param1];
        }// end function

        private function studyStuntNotifyCallBack() : void
        {
            var _loc_1:Object = null;
            _loc_1 = this._ctrl.notify.studyStuntNotify;
            this._view.worldNotice.showMessage(Lang.sprintf(keepAliveLang.StudyStuntNotify, _loc_1["nickname"], _loc_1["stunt_name"]));
            return;
        }// end function

        private function completeNumberCallBack() : void
        {
            var _loc_1:Boolean = true;
            this._view.liveness.isChangeNum = true;
            this._view.liveness.getBoxInfo();
            return;
        }// end function

        private function updateExperience() : void
        {
            var _loc_1:int = 0;
            var _loc_2:String = null;
            if (this._view.war.requested == true || this._view.missionRank.requested == true || this._view.getPeachWar.requested == true)
            {
                this._view.delayExecute(DelayType.Experience, this.updateExperience);
            }
            else
            {
                this._toolbar.updateExperience(this._ctrl.player.experience, this._ctrl.player.maxExperience);
                _loc_1 = this._ctrl.rolemsg.ExpChange;
                if (_loc_1 > 0)
                {
                    _loc_2 = "+" + _loc_1 + keepAliveLang.Exp;
                    this.showPlayerTextEffect(_loc_2, 2552101);
                }
            }
            return;
        }// end function

        private function updateLevel() : void
        {
            if (this._view.war.requested == true || this._view.missionRank.requested == true || this._view.drama.inStage || this._view.getPeachWar.requested == true)
            {
                this._view.delayExecute(DelayType.LevelUp, this.updateLevel);
            }
            else
            {
                var _loc_1:* = this._ctrl.player.level;
                this._toolbar.level = this._ctrl.player.level;
                this._view.chat.addSystemMessage(this._ctrl.player.nickname + " " + keepAliveLang.LevelUp, 16776960);
                if (this._view.screen.currentMap != null)
                {
                    this._view.screen.currentMap.showLevelUp();
                }
                if (this._ctrl.quest.hasLevelLimit && this._view.townMap.inStage == true)
                {
                    this.loadQuestTrace();
                }
            }
            if (_ctrl.player.level >= 70)
            {
                this._view.activities.openActivity(ActivityType.TopWar);
                if (Mod_NewTopWar_Base.CLOSE == this._ctrl.newTopWar.topWarStep)
                {
                    this._view.activities.removeActivity(ActivityType.TopWar);
                }
                else
                {
                    this._view.activities.addActivity(ActivityType.TopWar);
                }
            }
            this._view.gameHelper.updateGameAssistant();
            this._view.liveness.updateInfo();
            this.minResearchSkill();
            this.minUpgradeCoinEquip();
            if (this._view.nineRegions.inStageWithTip)
            {
                this._view.nineRegions.updatePlayerLv();
            }
            return;
        }// end function

        private function updateSkill() : void
        {
            var _loc_1:int = 0;
            var _loc_2:String = null;
            if (this.skillDelay == true)
            {
                this._view.delayExecute(DelayType.SkillDelay, this.updateSkill);
                return;
            }
            this._view.campWar.updateSkill(this._ctrl.player.skill);
            this._view.heroesWar.updateSkill(this._ctrl.player.skill);
            var _loc_3:* = this._ctrl.player.skill;
            this._view.findImmortal.skill = this._ctrl.player.skill;
            this.checkIsCanResearchUpgrade();
            _loc_1 = this._ctrl.player.skillChange;
            if (_loc_1 > 0)
            {
                _loc_2 = "+" + _loc_1 + keepAliveLang.Skill;
                this.showPlayerTextEffect(_loc_2, 16737792);
            }
            return;
        }// end function

        private function partnerUpgrade() : void
        {
            var _loc_1:Array = null;
            var _loc_2:int = 0;
            if (this._view.war.requested == true || this._view.getPeachWar.requested == true)
            {
                this._view.delayExecute(DelayType.PartnerUpgrade, this.partnerUpgrade);
            }
            else
            {
                _loc_1 = this._ctrl.player.upLevelRoles;
                for each (_loc_5 in _loc_1)
                {
                    
                    _loc_2 = _loc_4[_loc_3];
                    delete _loc_1[_loc_2];
                    this._view.chat.addSystemMessage(RoleType.getRoleName(_loc_2) + " " + keepAliveLang.LevelUp, 16776960);
                }
            }
            return;
        }// end function

        private function delayOpenFunction() : void
        {
            if (this._view.townMap.inStage == false)
            {
                this._view.delayExecute(DelayType.OpenFunction, this.get_player_function);
            }
            else
            {
                this.get_player_function();
            }
            return;
        }// end function

        private function delayLoadQuestTrace() : void
        {
            if (this._view.townMap.inStage == false && this._view.war.requested == true)
            {
                this._view.delayExecute(DelayType.QuestTrace, this.loadQuestTrace);
            }
            else
            {
                this.loadQuestTrace();
            }
            return;
        }// end function

        private function campWarNotifyCallBack() : void
        {
            var _loc_1:Object = null;
            var _loc_2:Object = null;
            if (FunctionType.isPlayed(FunctionType.CampWar) == false)
            {
                return;
            }
            _loc_1 = this._ctrl.campWar.getNotifyType();
            if (_loc_1["notify_type"] == Mod_CampWar_Base.END_CAMP_WAR)
            {
                this.showCampTopWinMessage();
                this.showCampWinMessage();
            }
            if (_loc_1["notify_type"] == Mod_CampWar_Base.OPEN_CAMP_WAR)
            {
                this._view.worldNotice.showMessage(keepAliveLang.CampWarOpen);
                _loc_2 = this._ctrl.campWar.getCurrentCampOpenTime();
                this._view.activities.activityShowCampWar(1, _loc_2["start_time"], _loc_2["end_time"]);
            }
            this._view.campWar.notifyCallBack(_loc_1);
            return;
        }// end function

        private function showCampTopWinMessage() : void
        {
            var _loc_1:Array = null;
            var _loc_2:Object = null;
            var _loc_3:String = null;
            _loc_1 = this._ctrl.campWar.getNotifyTopWinner();
            for each (_loc_6 in _loc_1)
            {
                
                _loc_2 = _loc_5[_loc_4];
                if (_loc_2["min_level"] <= this._ctrl.player.level && _loc_2["max_level"] >= this._ctrl.player.level && _loc_2["top_win_times"] > 8)
                {
                    _loc_3 = Lang.sprintf(keepAliveLang.CampTopWin, htmlFormat(_loc_2["top_player_nick_name"], 24, 16776960), htmlFormat(_loc_2["top_win_times"], 24, 16776960));
                    this._view.worldNotice.showMessage(_loc_3);
                    break;
                }
            }
            return;
        }// end function

        private function showCampWinMessage() : void
        {
            var obj:Object;
            var strWinCampName:String;
            var strLoseCampName:String;
            var strMsg:String;
            var showMessage:Function;
            showMessage = function () : void
            {
                _view.chat.addSystemMessage(strMsg);
                return;
            }// end function
            ;
            obj = this._ctrl.campWar.getNotifyIntegral();
            if (obj["win_camp_id"] == 0)
            {
                return;
            }
            strWinCampName = FactionType.campName(obj["win_camp_id"]);
            strLoseCampName = obj["win_camp_id"] == FactionType.campId(FactionType.KunLunCheng) ? (FactionType.campName(FactionType.campId(FactionType.ShuShanCheng))) : (FactionType.campName(FactionType.campId(FactionType.KunLunCheng)));
            strMsg = Lang.sprintf(keepAliveLang.CampWin, strWinCampName, strLoseCampName);
            this._view.worldNotice.showMessage(strMsg);
            var _loc_2:* = "<font color=\"#fff200\">" + Lang.sprintf(keepAliveLang.CampDisciple, strWinCampName, strLoseCampName, strWinCampName) + "</font>";
            strMsg = "<font color=\"#fff200\">" + Lang.sprintf(keepAliveLang.CampDisciple, strWinCampName, strLoseCampName, strWinCampName) + "</font>";
            this.showMessage();
            setTimeout(showMessage, 3000);
            return;
        }// end function

        private function heroesWarNotifyCallBack() : void
        {
            var _loc_1:Object = null;
            var _loc_2:Object = null;
            if (FunctionType.isPlayed(FunctionType.CampWar) == false)
            {
                return;
            }
            _loc_1 = this._ctrl.heroesWar.getNotifyType();
            if (_loc_1["notify_type"] == Mod_HeroesWar_Base.END_HEROES_WAR)
            {
                this.showHeroesTopWinMessage();
                this.showHeroesWinMessage();
            }
            if (_loc_1["notify_type"] == Mod_HeroesWar_Base.OPEN_HEROES_WAR)
            {
                this._view.worldNotice.showMessage(keepAliveLang.HeroesWarOpen);
                _loc_2 = this._ctrl.heroesWar.getCurrentHeroesOpenTime();
                this._view.activities.activityShowHeroesWar(1, _loc_2["start_time"], _loc_2["end_time"]);
            }
            this._view.heroesWar.notifyCallBack(_loc_1);
            return;
        }// end function

        private function showHeroesTopWinMessage() : void
        {
            var _loc_1:Array = null;
            var _loc_2:Object = null;
            var _loc_3:String = null;
            _loc_1 = this._ctrl.heroesWar.getNotifyTopWinner();
            for each (_loc_6 in _loc_1)
            {
                
                _loc_2 = _loc_5[_loc_4];
                if (_loc_2["min_level"] <= this._ctrl.player.level && _loc_2["max_level"] >= this._ctrl.player.level && _loc_2["top_win_times"] > 8)
                {
                    _loc_3 = Lang.sprintf(keepAliveLang.HeroesTopWin, htmlFormat(_loc_2["top_player_nick_name"], 24, 16776960), htmlFormat(_loc_2["top_win_times"], 24, 16776960));
                    this._view.worldNotice.showMessage(_loc_3);
                    break;
                }
            }
            return;
        }// end function

        private function showHeroesWinMessage() : void
        {
            return;
        }// end function

        private function beelzebubTrialsNotifyCallBack() : void
        {
            var _loc_1:int = 0;
            _loc_1 = this._ctrl.beelzebubTrials.notifyValue;
            _view.beelzebubTrials.notifyHandle(_loc_1);
            this._view.beelzebubTrialsMap.notifyBack(_loc_1);
            switch(_loc_1)
            {
                case Mod_BeelzebubTrials_Base.UPDATE_TEAM_INFO:
                {
                    break;
                }
                case Mod_BeelzebubTrials_Base.LEADER_DISSOLVE:
                {
                    break;
                }
                case Mod_BeelzebubTrials_Base.HAVE_WAR_RESULT:
                {
                    break;
                }
                case Mod_BeelzebubTrials_Base.START_BEELZEBUB_TRAILS:
                {
                    this._view.activities.beelzebubTrialsActivity();
                    var _loc_2:Boolean = true;
                    this._ctrl.beelzebubTrials.bActiveTime = true;
                    this._view.worldNotice.showMessage(BeelzebubTrialsBossInfoLang.SystemOpen);
                    break;
                }
                case Mod_BeelzebubTrials_Base.STOP_BEELZEBUB_TRAILS:
                {
                    this._view.activities.beelzebubTrialsActivity();
                    var _loc_2:Boolean = false;
                    this._ctrl.beelzebubTrials.bActiveTime = false;
                    this._view.worldNotice.showMessage(BeelzebubTrialsBossInfoLang.SystemEnd);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function topWarNotifyCallBack() : void
        {
            var _loc_1:int = 0;
            _loc_1 = this._ctrl.topWar.notifyValue;
            this._view.topWarMap.notifyState(_loc_1);
            switch(_loc_1)
            {
                case Mod_TopWar_Base.START_TOP_WAR:
                {
                    this._view.activities.startTopWar();
                    break;
                }
                case Mod_TopWar_Base.STOP_TOP_WAR:
                {
                    this._view.activities.endTopWar();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function newTopwarStep() : void
        {
            this._view.newTopWar.stepState();
            if (this._ctrl.newTopWar.topWarStep == Mod_NewTopWar_Base.CLOSE || this._ctrl.player.level < 70)
            {
                this._view.activities.removeActivity(ActivityType.TopWar);
            }
            else
            {
                this._view.activities.addActivity(ActivityType.TopWar);
            }
            this.updateTopWarBtnSign();
            return;
        }// end function

        private function newTopwarStep1() : void
        {
            this._view.newTopWar.stepState();
            if (this._ctrl.newTopWar.topWarStep == Mod_NewTopWar_Base.SIGN_OPEN)
            {
                this._data.call(Mod_NewTopWar_Base.get_top_war_step, new Function(), []);
            }
            if (this._ctrl.newTopWar.topWarStep == Mod_NewTopWar_Base.CLOSE || this._ctrl.player.level < 70)
            {
                this._view.activities.removeActivity(ActivityType.TopWar);
            }
            else
            {
                this._view.activities.addActivity(ActivityType.TopWar);
            }
            switch(this._ctrl.newTopWar.topWarStep)
            {
                case Mod_NewTopWar_Base.TAOTAI:
                {
                    this._view.worldNotice.showMessage(keepAliveLang.TopWarTaoTai);
                    break;
                }
                case Mod_NewTopWar_Base.WORLD_1:
                case Mod_NewTopWar_Base.WORLD_2:
                case Mod_NewTopWar_Base.WORLD_3:
                case Mod_NewTopWar_Base.WORLD_4:
                {
                    this._view.worldNotice.showMessage(keepAliveLang.TopWarKuaFu);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.updateTopWarBtnSign();
            return;
        }// end function

        private function world_top_war_gift_q0() : void
        {
            this._view.worldNotice.showMessage(Lang.sprintf(keepAliveLang.TopWarGiftContent, this._ctrl.notify.topwarGifName));
            return;
        }// end function

        private function updateTopWarBtnSign() : void
        {
            switch(this._ctrl.newTopWar.topWarStep)
            {
                case Mod_NewTopWar_Base.SIGN_OPEN:
                {
                    this._view.activities.showActivityTitle(ActivityType.TopWar, keepAliveLang.BaoMing);
                    break;
                }
                case Mod_NewTopWar_Base.SIGN_CLOSE:
                {
                    this._view.activities.showActivityTitle(ActivityType.TopWar, keepAliveLang.BaoMingJieZhi);
                    break;
                }
                case Mod_NewTopWar_Base.TAOTAI:
                {
                    this._view.activities.showActivityTitle(ActivityType.TopWar, keepAliveLang.TaoTaiSai);
                    break;
                }
                case Mod_NewTopWar_Base.TAOTAI_END:
                case Mod_NewTopWar_Base.WORLD_1:
                case Mod_NewTopWar_Base.WORLD_1_END:
                case Mod_NewTopWar_Base.WORLD_2:
                case Mod_NewTopWar_Base.WORLD_2_END:
                case Mod_NewTopWar_Base.WORLD_3:
                case Mod_NewTopWar_Base.WORLD_3_END:
                case Mod_NewTopWar_Base.WORLD_4:
                {
                    this._view.activities.showActivityTitle(ActivityType.TopWar, keepAliveLang.JiFenSai);
                    break;
                }
                case Mod_NewTopWar_Base.WORLD_4_END:
                {
                    this._view.activities.showActivityTitle(ActivityType.TopWar, keepAliveLang.DianFengWangZuo);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function roleNumNotifyCallBack() : void
        {
            if (this._view.townMap.inStage == false)
            {
                this._view.delayExecute(DelayType.PartnersCount, this._view.processTip.openPartnersCount);
            }
            else
            {
                this._view.processTip.openPartnersCount();
            }
            return;
        }// end function

        private function newResearchNotifyCallBack() : void
        {
            if (!FunctionType.isOpened(FunctionType.Research))
            {
                return;
            }
            if (this._view.townMap.inStage == false)
            {
                this._view.delayExecute(DelayType.Research, this._view.processTip.openResearch);
            }
            else
            {
                this._view.processTip.openResearch();
            }
            return;
        }// end function

        private function newPartnersNotifyCallBack() : void
        {
            if (this._view.townMap.inStage == false)
            {
                this._view.delayExecute(DelayType.Partners, this._view.processTip.openPartners);
            }
            else
            {
                this._view.processTip.openPartners();
            }
            return;
        }// end function

        private function newDeployGridOpenNotifyCallBack() : void
        {
            var _loc_1:Object = null;
            if (!FunctionType.isOpened(FunctionType.Deploy))
            {
                return;
            }
            _loc_1 = this._ctrl.superDeploy.newDeployGridOpenNotify;
            if (_loc_1["id"] == 1 || _loc_1["id"] == 3)
            {
                return;
            }
            if (this._view.townMap.inStage == false)
            {
                this._view.delayExecute(DelayType.SuperDeploy, this._view.processTip.openSuperDeploy);
            }
            else
            {
                this._view.processTip.openSuperDeploy();
            }
            return;
        }// end function

        private function playerCanStudyStuntNotifyCallBack() : void
        {
            if (!FunctionType.isOpened(FunctionType.StudyStunt))
            {
                return;
            }
            if (this._view.inWar)
            {
                var _loc_2:* = function () : void
            {
                _view.processTip.openStudyStunt();
                var _loc_1:String = null;
                _view.onWarClose = null;
                return;
            }// end function
            ;
                this._view.onWarClose = function () : void
            {
                _view.processTip.openStudyStunt();
                var _loc_1:String = null;
                _view.onWarClose = null;
                return;
            }// end function
            ;
            }
            else
            {
                this._view.processTip.openStudyStunt();
            }
            return;
        }// end function

        private function catHuntGoldenBoxCallBack() : void
        {
            this._view.chat.receive(this._ctrl.notify.catHuntGoldenBox, true);
            return;
        }// end function

        private function tianDiYuPaiNotifyCallBack() : void
        {
            if (this._view.townMap.inStage == false)
            {
                this._view.delayExecute(DelayType.TianDiYuPai, this._view.processTip.openTianDiYuPai);
            }
            else
            {
                this._view.processTip.openTianDiYuPai();
            }
            return;
        }// end function

        private function friend() : void
        {
            _data.patch(Mod_Friend_Base.notify_online_state, this.onlineStateCallBack);
            _data.patch(Mod_Friend_Base.notify_message_count, this.messageCountCallBack);
            return;
        }// end function

        private function onlineStateCallBack() : void
        {
            var _loc_1:Object = null;
            _loc_1 = _ctrl.friend.onlineState();
            var _loc_2:* = _loc_1;
            _view.friendList.onlineState = _loc_1;
            var _loc_2:* = _loc_1;
            _view.friendChat.onlineState = _loc_1;
            var _loc_2:* = _loc_1;
            _view.audience.onlineState = _loc_1;
            return;
        }// end function

        private function messageCountCallBack() : void
        {
            var _loc_1:Object = null;
            _loc_1 = _ctrl.friend.messageCount();
            var _loc_2:* = _loc_1;
            _view.friendList.messageCount = _loc_1;
            return;
        }// end function

        private function activityInfo() : void
        {
            _view.activities.activityInfo();
            return;
        }// end function

        public function startPractice() : void
        {
            _view.screen.currentMap.startPractice();
            return;
        }// end function

        public function closePractice() : void
        {
            _view.screen.currentMap.closePractice(true);
            return;
        }// end function

        private function load_effect_circle() : void
        {
            var _loc_1:Array = null;
            _loc_1 = [URI.addonsUrl + "load_effect_circle.swf"];
            File.loadList(_loc_1, this.loadEffectCircle);
            return;
        }// end function

        private function loadEffectCircle(param1:Array) : void
        {
            var _loc_2:* = (param1[0] as File).getClassByName("LoadEffectCircle") as Class;
            this._loadEffectCircle = (param1[0] as File).getClassByName("LoadEffectCircle") as Class;
            return;
        }// end function

        public function get getLoadEffectCircle() : Class
        {
            return this._loadEffectCircle;
        }// end function

        private function loadFunctionBarEffect() : void
        {
            FunctionBarEffect.loadEffect();
            return;
        }// end function

        public function playFlowerRain() : void
        {
            this._toolbar.playFlowerRain(URI.flowerUrl, Structure.maxStageHeight, Structure.maxStageWidth);
            return;
        }// end function

        public function get miniMap() : IMiniMap
        {
            return this._miniMap;
        }// end function

        private function initMiniMap() : void
        {
            var _loc_1:* = this._toolbar.miniMap;
            this._miniMap = this._toolbar.miniMap;
            var _loc_1:* = _view.tip.iTip;
            this._miniMap.tip = _view.tip.iTip;
            var _loc_1:Boolean = false;
            this._miniMap.gameHelpVisible = false;
            var _loc_1:Boolean = false;
            this._miniMap.worldVisible = false;
            var _loc_1:Boolean = false;
            this._miniMap.settingVisible = false;
            var _loc_1:Boolean = false;
            this._miniMap.showVisible = false;
            var _loc_1:Boolean = false;
            this._miniMap.hideVisible = false;
            var _loc_1:* = _view.openWorld;
            this._miniMap.onWorld = _view.openWorld;
            var _loc_1:* = _view.setting.switchSelf;
            this._miniMap.onSetting = _view.setting.switchSelf;
            var _loc_1:* = this._view.dramaPlayBack.switchSelf;
            this._miniMap.onGameHelp = this._view.dramaPlayBack.switchSelf;
            var _loc_1:* = this._view.townMap.otherShow;
            this._miniMap.onShow = this._view.townMap.otherShow;
            var _loc_1:* = this._view.townMap.otherHide;
            this._miniMap.onHide = this._view.townMap.otherHide;
            return;
        }// end function

        private function autoPractice() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            setTimeout(this.autoPractice, 60000);
            _loc_1 = int(_view.stage.mouseX);
            _loc_2 = int(_view.stage.mouseY);
            if (_loc_1 != this._px || _loc_2 != this._py)
            {
                var _loc_3:* = _loc_1;
                this._px = _loc_1;
                var _loc_3:* = _loc_2;
                this._py = _loc_2;
                var _loc_3:* = getTimer() + 300000;
                this._practiceTime = getTimer() + 300000;
                return;
            }
            if (getTimer() < this._practiceTime)
            {
                return;
            }
            if (_ctrl.player.playerInfo.practice == Mod_Town_Base.ON_PRACTICE)
            {
                return;
            }
            if (_view.missionPractice.isBatton)
            {
                return;
            }
            if (_view.heroPractice.isBatton)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.Practice) == false)
            {
                return;
            }
            if (_view.screen.currentMap == null)
            {
                return;
            }
            _view.screen.currentMap.startPractice();
            return;
        }// end function

    }
}
