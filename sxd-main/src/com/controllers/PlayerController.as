package com.controllers
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.datas.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class PlayerController extends Base
    {
        public var ownData:PlayerData;
        public var isEnterHeroMission:Boolean = false;
        private var _f:int = 0;
        private var _s:int = 0;
        private var _fStr:String = "";
        private var _sStr:String = "";

        public function PlayerController()
        {
            return;
        }// end function

        public function get factionId() : int
        {
            return this.ownData.playerInfo.factionId;
        }// end function

        public function get factionName() : String
        {
            return this.ownData.playerInfo.factionName;
        }// end function

        public function get getPlayerInfo() : Object
        {
            return this.ownData.GetPlayerInfoByUserName;
        }// end function

        public function get logined() : int
        {
            return this.ownData.logined;
        }// end function

        public function get playerInfo() : PlayerInfo
        {
            return this.ownData.playerInfo;
        }// end function

        public function get playerId() : int
        {
            return this.ownData.playerId;
        }// end function

        public function get getWebInfo() : String
        {
            return this.ownData.webInfo;
        }// end function

        public function get isMinorAccount() : int
        {
            return this.ownData.isMinorAccount;
        }// end function

        public function get enableTime() : int
        {
            return this.ownData.enableTime;
        }// end function

        public function get abnormalTime() : int
        {
            return this.ownData.abnormalTime;
        }// end function

        public function get enableType() : int
        {
            return this.ownData.enableType;
        }// end function

        public function get createdRole() : int
        {
            return this.ownData.createdRole;
        }// end function

        public function get nickname() : String
        {
            return this.ownData.nickname;
        }// end function

        public function get originNickName() : String
        {
            return this.ownData.originNickName;
        }// end function

        public function get BlessLevel() : int
        {
            return this.ownData.BlessLevel;
        }// end function

        public function get signSuffix() : String
        {
            return this.ownData.signSuffix;
        }// end function

        public function get practiceChangeList() : Array
        {
            return this.ownData.practiceChangeList;
        }// end function

        public function set practiceChangeList(param1:Array) : void
        {
            this.ownData.practiceChangeList = param1;
            return;
        }// end function

        public function get buyPower() : Object
        {
            var _loc_1:* = this.ownData.buyPower;
            var _loc_2:Object = {};
            _loc_2.buyNum = _loc_1[0];
            _loc_2.buyIngot = _loc_1[1];
            _loc_2.msg = _loc_1[2];
            _loc_2.recoveryPower = _loc_1[3];
            this.buyPowerInfo(_loc_2);
            return _loc_2;
        }// end function

        public function get buyPowerData() : Object
        {
            var _loc_1:* = this.ownData.buyPowerData;
            var _loc_2:Object = {};
            _loc_2.buyNum = _loc_1[0];
            _loc_2.buyIngot = _loc_1[1];
            _loc_2.recoveryPower = _loc_1[2];
            this.buyPowerInfo(_loc_2);
            return _loc_2;
        }// end function

        private function buyPowerInfo(param1:Object) : void
        {
            if (param1.buyNum == -1)
            {
                param1.buyTimes = PlayerControllerLang.NoLimit;
            }
            else
            {
                param1.buyTimes = param1.buyNum;
            }
            if (param1.buyIngot <= 0)
            {
                param1.info = PlayerControllerLang.CantBuyPower;
                return;
            }
            if (_data.player.ingot >= param1.buyIngot)
            {
                if (param1.buyNum == 0)
                {
                    param1.info = PlayerControllerLang.CantBuyPower;
                }
                else
                {
                    param1.info = Lang.sprintf(PlayerControllerLang.RecoveryPower, param1.recoveryPower, param1.buyIngot);
                }
            }
            else
            {
                param1.info = PlayerControllerLang.NoIngotBuyPower;
            }
            return;
        }// end function

        public function setNewMapId(param1:int) : void
        {
            _data.player.bossMapId = 0;
            _data.player.mapId = param1;
            var _loc_2:* = TownType.getSign(param1);
            if (_loc_2 == TownType.JiHuiSuo)
            {
                _data.player.jihuisuoId = param1;
            }
            else if (_loc_2 == TownType.BossChiYanShou || _loc_2 == TownType.BossQingTianMu || _loc_2 == TownType.BossDaoBaTu)
            {
                _data.player.bossMapId = param1;
            }
            else if (_loc_2 == TownType.BaiHuFactionWar)
            {
            }
            else
            {
                _data.player.jihuisuoId = 0;
                _data.player.townMapId = param1;
            }
            return;
        }// end function

        public function get townMapId() : int
        {
            return this.ownData.townMapId;
        }// end function

        public function get mapId() : int
        {
            return this.ownData.mapId;
        }// end function

        public function get bossMapId() : int
        {
            return this.ownData.bossMapId;
        }// end function

        public function get jihuisuoId() : int
        {
            return this.ownData.jihuisuoId;
        }// end function

        public function get huzhongjieId() : int
        {
            return this.ownData.huzhongjieId;
        }// end function

        public function get mounts() : int
        {
            return this.ownData.mounts;
        }// end function

        public function get mainRoleId() : int
        {
            return this.ownData.mainRoleId;
        }// end function

        public function get mainPlayerRoleId() : int
        {
            return this.ownData.mainPlayerRoleId;
        }// end function

        public function get campId() : int
        {
            return this.ownData.campId;
        }// end function

        public function set campId(param1:int) : void
        {
            this.ownData.campId = param1;
            TownType.campSign = FactionType.campSign(param1);
            return;
        }// end function

        public function get townKey() : int
        {
            return this.ownData.townKey;
        }// end function

        public function get updatePlayerDataForTownList() : Array
        {
            return this.ownData.updatePlayerDataForTownList;
        }// end function

        public function get functionList() : Array
        {
            return this.ownData.functionList;
        }// end function

        public function get campResult() : int
        {
            return this.ownData.campResult;
        }// end function

        public function get isTester() : Boolean
        {
            return this.isCommonTester || this.isAdvancedTester || this.isGM || this.isTrainer;
        }// end function

        public function get isCommonTester() : Boolean
        {
            return PlayerType.isCommonTester(this.ownData.tester);
        }// end function

        public function get isAdvancedTester() : Boolean
        {
            return PlayerType.isAdvancedTester(this.ownData.tester);
        }// end function

        public function get isGM() : Boolean
        {
            return PlayerType.isGM(this.ownData.tester);
        }// end function

        public function get isTrainer() : Boolean
        {
            return PlayerType.isTrainer(this.ownData.tester);
        }// end function

        public function get lastPlayVersion() : int
        {
            return this.ownData.lastPlayVersion;
        }// end function

        public function get level() : int
        {
            return this.ownData.level;
        }// end function

        public function get ingot() : int
        {
            return this.ownData.ingot;
        }// end function

        public function get ingotString() : String
        {
            if (this.ingot >= 1000000000)
            {
                return int(this.ingot / 100000000) + PlayerControllerLang.Yi;
            }
            if (this.ingot >= 100000)
            {
                return int(this.ingot / 10000) + PlayerControllerLang.Wang;
            }
            return this.ingot + "";
        }// end function

        public function get ingotChange() : int
        {
            return this.ownData.ingotChange;
        }// end function

        public function get coins() : Number
        {
            return this.ownData.coins;
        }// end function

        public function get coinsString() : String
        {
            if (this.coins >= 1000000000)
            {
                return int(this.coins / 100000000) + PlayerControllerLang.Yi;
            }
            if (this.coins >= 100000)
            {
                return int(this.coins / 10000) + PlayerControllerLang.Wang;
            }
            return this.coins + "";
        }// end function

        public function get coinChange() : Number
        {
            return this.ownData.coinChange;
        }// end function

        public function get health() : int
        {
            return this.ownData.health;
        }// end function

        public function get maxHealth() : int
        {
            return this.ownData.maxHealth;
        }// end function

        public function get power() : int
        {
            return this.ownData.power;
        }// end function

        public function get experience() : Number
        {
            return this.ownData.experience;
        }// end function

        public function get maxExperience() : Number
        {
            return this.ownData.maxExperience;
        }// end function

        public function get vipLevel() : int
        {
            return this.ownData.vipLevel;
        }// end function

        public function get avatar() : int
        {
            return this.ownData.avatar;
        }// end function

        public function get avatarCD() : int
        {
            return this.ownData.avatarCD;
        }// end function

        public function get packNum() : int
        {
            return this.ownData.packNum;
        }// end function

        public function get upLevelRoles() : Array
        {
            return this.ownData.upRoleList;
        }// end function

        public function get functionLock() : int
        {
            return this.ownData.functionLock;
        }// end function

        public function get hasNewFunction() : Boolean
        {
            return this.ownData.hasNewFunction;
        }// end function

        public function set hasNewFunction(param1:Boolean) : void
        {
            this.ownData.hasNewFunction = param1;
            return;
        }// end function

        public function get hasQuestState() : Boolean
        {
            return this.ownData.hasQuestState;
        }// end function

        public function set hasQuestState(param1:Boolean) : void
        {
            this.ownData.hasQuestState = param1;
            return;
        }// end function

        public function set campSalaryEnabled(param1:Boolean) : void
        {
            this.ownData.campSalaryEnabled = param1;
            return;
        }// end function

        public function get campSalaryEnabled() : Boolean
        {
            return this.ownData.campSalaryEnabled;
        }// end function

        public function get campSalaryCoin() : int
        {
            return this.ownData.campSalaryCoin;
        }// end function

        public function get campSalaryStatus() : int
        {
            return this.ownData.campSalaryStatus;
        }// end function

        public function get getPlayerCampSalary() : int
        {
            return this.ownData.getPlayerCampSalary;
        }// end function

        public function get fame() : int
        {
            return this.ownData.fame;
        }// end function

        public function get fameChange() : int
        {
            return this.ownData.fameChange;
        }// end function

        public function get fameLevel() : int
        {
            return this.ownData.fameLevel;
        }// end function

        public function get missionKey() : int
        {
            return this.ownData.missionKey;
        }// end function

        public function get otherPlayerLv() : int
        {
            return this.ownData.otherPlayerLv;
        }// end function

        public function get extraPower() : int
        {
            return this.ownData.extraPower;
        }// end function

        public function get maxExtraPower() : int
        {
            return this.ownData.maxExtraPower;
        }// end function

        public function get dayQuestState() : int
        {
            return this.ownData.dayQuestState;
        }// end function

        public function get finishDayQuest() : int
        {
            return this.ownData.finishDayQuest;
        }// end function

        public function get canIncenseCount() : int
        {
            return this.ownData.canIncenseCount;
        }// end function

        public function get skill() : int
        {
            return this.ownData.skill;
        }// end function

        public function get skillChange() : int
        {
            return this.ownData.skillChange;
        }// end function

        public function get getGameAssistantInfo() : Object
        {
            return this.ownData.getGameAssistantInfo;
        }// end function

        public function get backTimesResult() : Object
        {
            return this.ownData.backTimesResult;
        }// end function

        public function get isSendIngotReceiveShowVip() : Boolean
        {
            return this.ownData.isSendIngotReceiveShowVip;
        }// end function

        public function get playerInfoContrastData() : Object
        {
            return this.ownData.playerInfoContrastData;
        }// end function

        public function get statePoint() : int
        {
            return this.ownData.statePoint;
        }// end function

        public function get totalStatePoint() : int
        {
            return this.ownData.totalStatePoint;
        }// end function

        public function get giftItemId() : int
        {
            return this.ownData.giftItemId;
        }// end function

        public function set giftItemId(param1:int) : void
        {
            this.ownData.giftItemId = param1;
            return;
        }// end function

        public function isChanged(param1:int) : Boolean
        {
            var _loc_2:int = 0;
            switch(param1)
            {
                case Mod_Player_Base.PLAYER_LEVEL:
                {
                    _loc_2 = this.level;
                    break;
                }
                case Mod_Player_Base.PLAYER_INGOT:
                {
                    _loc_2 = this.ingot;
                    break;
                }
                case Mod_Player_Base.PLAYER_COINS:
                {
                    _loc_2 = this.coins;
                    break;
                }
                case Mod_Player_Base.PLAYER_HEALTH:
                {
                    _loc_2 = this.health;
                    break;
                }
                case Mod_Player_Base.PLAYER_MAX_HEALTH:
                {
                    _loc_2 = this.maxHealth;
                    break;
                }
                case Mod_Player_Base.PLAYER_POWER:
                {
                    _loc_2 = this.power;
                    break;
                }
                case Mod_Player_Base.PLAYER_EXPERIENCE:
                {
                    _loc_2 = this.experience;
                    break;
                }
                case Mod_Player_Base.PLAYER_MAX_EXPERIENCE:
                {
                    _loc_2 = this.maxExperience;
                    break;
                }
                case Mod_Player_Base.PLAYER_TRANSPORT:
                {
                    _loc_2 = this.mounts;
                    break;
                }
                case Mod_Player_Base.PLAYER_AVATAR:
                {
                    _loc_2 = this.avatar;
                    break;
                }
                case Mod_Player_Base.PLAYER_AVATAR_CD:
                {
                    _loc_2 = this.avatarCD;
                    break;
                }
                case Mod_Player_Base.PLAYER_PACK_EMPTY_NUM:
                {
                    _loc_2 = this.packNum;
                    break;
                }
                case Mod_Player_Base.GET_ONLINE_GIFT:
                {
                    _loc_2 = this.ownData.isGetOnlineGift;
                    break;
                }
                case Mod_Player_Base.ONLINE_GIFT:
                {
                    _loc_2 = this.ownData.onlineGiftTime;
                    break;
                }
                case Mod_Player_Base.VIP_LEVEL:
                {
                    _loc_2 = this.ownData.vipLevel;
                    break;
                }
                case Mod_Player_Base.CAMP_SALARY:
                {
                    _loc_2 = this.ownData.campSalaryCoin;
                    break;
                }
                case Mod_Player_Base.PLAYER_DAY_QUEST:
                {
                    _loc_2 = this.ownData.dayQuestState;
                    break;
                }
                case Mod_Player_Base.FINISH_DAY_QUEST:
                {
                    _loc_2 = this.ownData.finishDayQuest;
                    break;
                }
                case Mod_Player_Base.CAN_INCENSE_COUNT:
                {
                    _loc_2 = this.ownData.canIncenseCount;
                    break;
                }
                case Mod_Player_Base.PLAYER_SKILL:
                {
                    _loc_2 = this.ownData.skill;
                    break;
                }
                case Mod_Player_Base.FAME:
                {
                    _loc_2 = this.ownData.fame;
                    break;
                }
                case Mod_Player_Base.PLAYER_TOWN_KEY:
                {
                    _loc_2 = this.ownData.townKey;
                    break;
                }
                case Mod_Player_Base.STATE_POINT:
                {
                    _loc_2 = this.ownData.statePoint;
                    break;
                }
                case Mod_Player_Base.BUY_NUMBER:
                {
                    _loc_2 = this.ownData.flagNum;
                }
                default:
                {
                    break;
                }
            }
            var _loc_3:Boolean = false;
            if (this.ownData.oldDatas[param1] != null && this.ownData.oldDatas[param1] != _loc_2)
            {
                _loc_3 = true;
                this.ownData.oldDatas[param1] = _loc_2;
            }
            return _loc_3;
        }// end function

        public function get afficheList() : Array
        {
            var _loc_1:* = this.ownData.afficheList;
            var _loc_2:* = this.renderAfficheList(_loc_1[0]);
            return _loc_2;
        }// end function

        public function get warningAffiche() : String
        {
            var _loc_1:* = this.ownData.warningAffiche;
            var _loc_2:* = _loc_1[0];
            return _loc_2;
        }// end function

        private function renderAfficheList(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.id = param1[_loc_4][0];
                _loc_5.html = param1[_loc_4][1];
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get hasWarCdTime() : Object
        {
            var _loc_1:Object = {};
            _loc_1.cdTimer = this.renderTime(this.ownData.warCdTime);
            _loc_1.hasWarTime = this.ownData.warCdTime > 0;
            return _loc_1;
        }// end function

        private function renderTime(param1:int) : String
        {
            var _loc_2:* = param1;
            if (_loc_2 / 60 > 0)
            {
                this._f = Math.floor(_loc_2 / 60);
                _loc_2 = _loc_2 - this._f * 60;
            }
            this._s = _loc_2;
            this._fStr = this._f + "";
            this._sStr = this._s + "";
            if (this._f < 10)
            {
                this._fStr = "0" + this._f;
            }
            if (this._s < 10)
            {
                this._sStr = "0" + this._s;
            }
            var _loc_3:* = this._fStr + ":" + this._sStr;
            return _loc_3;
        }// end function

        public function get delayMessage() : Array
        {
            return this.ownData.delayMessage;
        }// end function

        public function get validateIdCard() : int
        {
            return this.ownData.validateIdCard;
        }// end function

        public function get againstWallowsNotify() : int
        {
            return this.ownData.againstWallowsNotify;
        }// end function

        public function get againstWallowsInfo() : int
        {
            return this.ownData.againstWallowsInfo;
        }// end function

        public function get isWeiChengNianOffLine() : Boolean
        {
            return this.ownData.isWeiChengNianOffLine;
        }// end function

        public function get onlineGiftTime() : int
        {
            var _loc_1:* = new Date().getTime() / 1000;
            return this.ownData.onlineGiftTime - _loc_1;
        }// end function

        public function get isGetOnlineGift() : int
        {
            return this.ownData.isGetOnlineGift;
        }// end function

        public function get onlineGift() : Object
        {
            return this.giftData(this.ownData.onlineGift);
        }// end function

        public function get nextOnlineGift() : Object
        {
            return this.giftData(this.ownData.nextOnlineGift);
        }// end function

        private function giftData(param1:Object) : Object
        {
            var _loc_2:Object = null;
            for each (_loc_2 in param1["online_gift_list"])
            {
                
                if (_loc_2["type"] == 5)
                {
                    _loc_2["item_info"] = {name:ItemType.getName(_loc_2["item_id"]), color:ItemType.getItemColor(_loc_2["item_id"])};
                }
            }
            return param1;
        }// end function

        public function get serverTime() : int
        {
            var _loc_1:* = new Date().getTime() / 1000;
            return _loc_1 - this.ownData.diffServerTime;
        }// end function

        public function get diffServerTime() : int
        {
            return this.ownData.diffServerTime;
        }// end function

        public function get isStartAccount() : Boolean
        {
            return this.ownData.startAccount == 1;
        }// end function

        public function get inSelfCampTown() : Boolean
        {
            var _loc_1:* = FactionType.campSign(this.campId);
            var _loc_2:* = TownType.getSign(this.mapId);
            var _loc_3:* = FactionType.campId(_loc_2);
            return _loc_1 == _loc_2;
        }// end function

        public function get inSelfTown() : Boolean
        {
            var _loc_1:* = FactionType.campSign(this.campId);
            var _loc_2:* = TownType.getSign(this.mapId);
            var _loc_3:* = FactionType.campId(_loc_2);
            return _loc_3 == 0 || _loc_1 == _loc_2;
        }// end function

        public function get isCampTown() : Boolean
        {
            var _loc_1:* = TownType.getSign(this.mapId);
            return FactionType.campId(_loc_1) > 0;
        }// end function

        public function removeNickNameSuffix(param1:String) : String
        {
            return this.ownData.removeNickNameSuffix(param1);
        }// end function

        public function get isChampion() : Boolean
        {
            return this.ownData.playerInfo.isChampion;
        }// end function

    }
}
