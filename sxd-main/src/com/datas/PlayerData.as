package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.haloer.data.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;
    import flash.utils.*;

    public class PlayerData extends Base
    {
        public var playerInfo:PlayerInfo;
        public var logined:int = 1;
        public var playerId:int;
        public var isMinorAccount:int;
        public var enableTime:int;
        public var enableType:int;
        public var abnormalTime:int;
        public var createdRole:int;
        public var nickname:String;
        public var originNickName:String;
        public var level:int;
        public var ingot:int;
        public var ingotChange:int;
        public var coins:Number;
        public var coinChange:Number;
        public var skill:int;
        public var skillChange:int;
        public var health:int;
        public var maxHealth:int;
        public var power:int;
        public var experience:Number;
        public var maxExperience:Number;
        public var tester:int;
        public var missionKey:int;
        public var lastPlayVersion:int;
        public var mapId:int;
        public var townMapId:int;
        public var jihuisuoId:int;
        public var huzhongjieId:int;
        public var bossMapId:int;
        public var vipLevel:int;
        public var avatar:int = 0;
        public var avatarCD:int = 0;
        public var mainPlayerRoleId:int;
        public var mainRoleId:int;
        public var campId:int;
        public var townKey:int;
        public var mounts:int = -1;
        public var packNum:int = 1;
        public var upRoleList:Array;
        public var statePoint:int = 0;
        public var totalStatePoint:int = 0;
        public var flagNum:int = 0;
        public var giftItemId:int = 0;
        public var otherPlayerLv:int = 0;
        public var BlessLevel:int = 0;
        public var signSuffix:String = "";
        public var webInfo:String = "";
        public var oldDatas:Object;
        public var updatePlayerDataForTownList:Array;
        private var _buyPower:Array;
        private var _buyPowerData:Array;
        public var hasNewFunction:Boolean = false;
        public var functionLock:int = 0;
        public var functionList:Array;
        public var delayMessage:Array;
        public var campResult:int;
        public var hasQuestState:Boolean;
        public var campSalaryEnabled:Boolean;
        public var campSalaryStatus:int;
        public var campSalaryCoin:int;
        public var getPlayerCampSalary:int;
        public var onlineGift:Object;
        public var nextOnlineGift:Object;
        public var isGetOnlineGift:int = -2;
        public var onlineGiftTime:int;
        public var fame:int;
        public var fameChange:int;
        public var fameLevel:int;
        public var extraPower:int;
        public var maxExtraPower:int;
        public var validateIdCard:int;
        public var againstWallowsNotify:int;
        public var againstWallowsInfo:int;
        public var isWeiChengNianOffLine:Boolean;
        public var diffServerTime:int;
        public var warCdTime:int;
        public var dayQuestState:int;
        public var finishDayQuest:int = 1;
        public var canIncenseCount:int;
        private var _afficheList:Array;
        private var _warningAffiche:Array;
        public var startAccount:int;
        public var getGameAssistantInfo:Object;
        public var backTimesResult:Object;
        public var isSendIngotReceiveShowVip:Boolean;
        public var playerInfoContrastData:Object;
        public var GetPlayerInfoByUserName:Object;
        public var practiceChangeList:Array;

        public function PlayerData()
        {
            this.playerInfo = new PlayerInfo(true);
            this.upRoleList = [];
            this.oldDatas = {};
            this.updatePlayerDataForTownList = [];
            this.functionList = [];
            this.delayMessage = [];
            this.onlineGift = {};
            this.nextOnlineGift = {};
            this.getGameAssistantInfo = {};
            this.backTimesResult = {};
            this.practiceChangeList = [];
            return;
        }// end function

        public function get buyPower() : Array
        {
            return this._buyPower;
        }// end function

        public function get buyPowerData() : Array
        {
            return this._buyPowerData;
        }// end function

        public function get afficheList() : Array
        {
            return this._afficheList;
        }// end function

        public function get warningAffiche() : Array
        {
            return this._warningAffiche;
        }// end function

        public function login(param1:Array) : void
        {
            this.logined = param1[0];
            this.playerId = param1[1];
            this.playerInfo.id = this.playerId;
            this.enableTime = param1[3] || 0;
            this.enableType = param1[4] || 0;
            return;
        }// end function

        public function get_player_info(param1:Array) : void
        {
            this.format_player_info(param1);
            return;
        }// end function

        public function player_first_init(param1:Array) : void
        {
            this.createdRole = param1[0];
            return;
        }// end function

        public function update_player_data(param1:Array) : void
        {
            this.format_player_data(param1[0]);
            return;
        }// end function

        public function update_player_data_for_town(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            this.updatePlayerDataForTownList = [];
            param1 = param1[0];
            for each (_loc_2 in param1)
            {
                
                _loc_3 = {id:_loc_2[0], type:_loc_2[1], value:_loc_2[2]};
                this.updatePlayerDataForTownList.push(_loc_3);
            }
            return;
        }// end function

        public function buy_power(param1:Array) : void
        {
            this._buyPower = param1;
            return;
        }// end function

        public function get_buy_power_data(param1:Array) : void
        {
            this._buyPowerData = param1;
            return;
        }// end function

        public function get_player_function(param1:Array) : void
        {
            this.functionList = this.format_get_player_function(param1);
            return;
        }// end function

        public function sign_play_player_function(param1:Array) : void
        {
            this.format_sign_play_player_function(param1);
            return;
        }// end function

        public function receive_player_delay_notify_message(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_4:Array = null;
            this.delayMessage = [];
            var _loc_3:* = new Date();
            if ((param1[0] as Array).length > 0)
            {
                for each (_loc_4 in param1[0])
                {
                    
                    _loc_2 = {};
                    oObject.list(_loc_4, _loc_2, ["message", "id"]);
                    _loc_2["message"] = (_loc_2["message"] as String).replace(/&lt;""&lt;/g, "<");
                    _loc_2["message"] = (_loc_2["message"] as String).replace(/&gt;""&gt;/g, ">");
                    _loc_2["message"] = (_loc_2["message"] as String).replace(/&amp;""&amp;/g, "&");
                    this.delayMessage.push(_loc_2);
                }
            }
            return;
        }// end function

        public function set_player_camp(param1:Array) : void
        {
            this.campResult = param1[0];
            return;
        }// end function

        public function validate_id_card(param1:Array) : void
        {
            this.validateIdCard = param1[0];
            return;
        }// end function

        public function against_wallows_notify(param1:Array) : void
        {
            this.againstWallowsNotify = param1[0];
            return;
        }// end function

        public function against_wallows_info(param1:Array) : void
        {
            this.againstWallowsInfo = param1[0];
            this.isMinorAccount = param1[1];
            return;
        }// end function

        public function is_weichengnian(param1:Array) : void
        {
            this.isWeiChengNianOffLine = param1[0] == 1;
            return;
        }// end function

        public function server_time(param1:Array) : void
        {
            var _loc_2:* = new Date().getTime() / 1000;
            this.diffServerTime = _loc_2 - param1[0];
            return;
        }// end function

        public function get_other_player_info(param1:Array) : void
        {
            this.otherPlayerLv = param1[0];
            return;
        }// end function

        public function get_player_camp_salary(param1:Array) : void
        {
            this.campSalaryStatus = param1[0];
            this.getPlayerCampSalary = param1[1];
            return;
        }// end function

        public function player_get_online_gift(param1:Array) : void
        {
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            var _loc_2:Array = [];
            for each (_loc_4 in param1[1])
            {
                
                _loc_3 = {};
                oObject.list(_loc_4, _loc_3, ["type", "item_id", "value"]);
                _loc_2.push(_loc_3);
            }
            this.onlineGift["result"] = param1[0];
            this.onlineGift["online_gift_list"] = _loc_2;
            this.onlineGift["next_time_stamp"] = param1[2];
            return;
        }// end function

        public function get_player_current_online_gift(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            var _loc_2:Array = [];
            for each (_loc_3 in param1[1])
            {
                
                _loc_4 = {};
                oObject.list(_loc_3, _loc_4, ["type", "item_id", "value"]);
                _loc_2.push(_loc_4);
            }
            this.nextOnlineGift["time_stamp"] = param1[0];
            this.nextOnlineGift["online_gift_list"] = _loc_2;
            return;
        }// end function

        public function get_affiche_list(param1:Array) : void
        {
            this._afficheList = param1;
            return;
        }// end function

        public function get_warning_affiche(param1:Array) : void
        {
            this._warningAffiche = param1;
            return;
        }// end function

        public function player_info_contrast(param1:Array) : void
        {
            var _loc_2:* = param1[0][0];
            var _loc_3:Object = {};
            _loc_3.playerId = _loc_2[0];
            _loc_3.rankIng = _loc_2[1];
            _loc_3.factionName = _loc_2[2];
            _loc_3.combat = _loc_2[3];
            _loc_3.fame = _loc_2[4];
            _loc_3.skill = _loc_2[5];
            _loc_3.achievmentPoints = _loc_2[6];
            _loc_3.firstAttack = _loc_2[7];
            _loc_3.statePoint = _loc_2[8];
            _loc_3.flowerCount = _loc_2[9];
            this.playerInfoContrastData = _loc_3;
            return;
        }// end function

        public function get_player_info_by_username(param1:Array) : void
        {
            var _loc_2:* = param1;
            var _loc_3:Object = {};
            _loc_3.result = _loc_2[0];
            _loc_3.playerId = _loc_2[1];
            _loc_3.nickName = _loc_2[2];
            this.GetPlayerInfoByUserName = _loc_3;
            return;
        }// end function

        public function player_follow_setting(param1:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_2:* = param1[0];
            if (_loc_2 == Mod_Player_Base.SET_SUCCESS)
            {
                _loc_3 = param1[1];
                _loc_4 = param1[2];
                switch(_loc_3)
                {
                    case Mod_Player_Base.OBJ_PARTNER:
                    {
                        this.playerInfo.is_role_follow = _loc_4 == 1;
                        break;
                    }
                    case Mod_Player_Base.OBJ_PET:
                    {
                        this.playerInfo.is_pet_follow = _loc_4 == 1;
                        break;
                    }
                    case Mod_Player_Base.OBJ_CAT:
                    {
                        this.playerInfo.is_cat_follow = _loc_4 == 1;
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

        private function format_player_info(param1:Array) : void
        {
            oObject.list(param1, this, ["nickname", "level", "ingot", "coins", "health", "maxHealth", "power", "experience", "maxExperience", "townMapId", "bossMapId", "jihuisuoId", "mounts", "vipLevel", "avatar", "avatarCD", "mainPlayerRoleId", "mainRoleId", "campId", "townKey", "fame", "fameLevel", "extraPower", "maxExtraPower", "tester", "lastPlayVersion", "missionKey", "startAccount"]);
            this.originNickName = this.nickname;
            this.nickname = this.removeNickNameSuffix(this.nickname);
            this.avatarCD = this.avatarCD * 1000 + getTimer();
            _data.town.setPlayerMount(this.mounts, this.playerId);
            _data.town.setPlayerAvatar(this.avatar, this.playerId);
            if (URI.vipHidden)
            {
                this.vipLevel = -1;
            }
            VIPType.level = this.vipLevel;
            MissionType.lock = this.missionKey;
            TownType.lock = this.townKey;
            TownType.campSign = FactionType.campSign(this.campId);
            return;
        }// end function

        private function format_player_data(param1:Array) : void
        {
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.updatePlayerData(param1[_loc_3][0], param1[_loc_3][1]);
                _loc_3++;
            }
            return;
        }// end function

        private function updatePlayerData(param1:int, param2:Number) : void
        {
            var _loc_3:int = 0;
            switch(param1)
            {
                case Mod_Player_Base.PLAYER_LEVEL:
                {
                    this.oldDatas[param1] = this.level;
                    this.level = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_INGOT:
                {
                    this.oldDatas[param1] = this.ingot;
                    this.ingotChange = param2 - this.ingot;
                    this.ingot = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_COINS:
                {
                    this.oldDatas[param1] = this.coins;
                    this.coinChange = param2 - this.coins;
                    this.coins = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_HEALTH:
                {
                    this.oldDatas[param1] = this.health;
                    this.health = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_MAX_HEALTH:
                {
                    this.oldDatas[param1] = this.maxHealth;
                    this.maxHealth = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_POWER:
                {
                    this.oldDatas[param1] = this.power;
                    this.power = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_EXPERIENCE:
                {
                    this.oldDatas[param1] = this.experience;
                    this.experience = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_MAX_EXPERIENCE:
                {
                    this.oldDatas[param1] = this.maxExperience;
                    this.maxExperience = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_TRANSPORT:
                {
                    this.oldDatas[param1] = this.mounts;
                    this.mounts = param2;
                    _data.town.setPlayerMount(this.mounts, this.playerId);
                    break;
                }
                case Mod_Player_Base.PLAYER_AVATAR:
                {
                    this.oldDatas[param1] = this.avatar;
                    this.avatar = param2;
                    _data.town.setPlayerAvatar(this.avatar, this.playerId);
                    break;
                }
                case Mod_Player_Base.PLAYER_AVATAR_CD:
                {
                    this.oldDatas[param1] = this.avatarCD;
                    this.avatarCD = param2 * 1000 + getTimer();
                    break;
                }
                case Mod_Player_Base.PLAYER_PACK_EMPTY_NUM:
                {
                    this.oldDatas[param1] = this.packNum;
                    this.packNum = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_FUNCTION:
                {
                    this.hasNewFunction = true;
                    this.functionLock = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_QUEST_STATE:
                {
                    this.hasQuestState = true;
                    break;
                }
                case Mod_Player_Base.PLAYER_ROLE_LEVEL:
                {
                    this.upRoleList[param2] = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_TOWN_KEY:
                {
                    this.oldDatas[param1] = this.townKey;
                    this.townKey = param2;
                    TownType.lock = param2;
                    break;
                }
                case Mod_Player_Base.CAMP_SALARY:
                {
                    this.campSalaryEnabled = param2 > 0;
                    this.oldDatas[param1] = this.campSalaryCoin;
                    this.campSalaryCoin = param2;
                    break;
                }
                case Mod_Player_Base.FAME:
                {
                    this.oldDatas[param1] = this.fame;
                    this.fameChange = param2 - this.fame;
                    this.fame = param2;
                    break;
                }
                case Mod_Player_Base.FAME_LEVEL:
                {
                    this.fameLevel = param2;
                    break;
                }
                case Mod_Player_Base.EXTRA_POWER:
                {
                    this.extraPower = param2;
                    break;
                }
                case Mod_Player_Base.MAX_EXTRA_POWER:
                {
                    this.maxExtraPower = param2;
                    break;
                }
                case Mod_Player_Base.ONLINE_GIFT:
                {
                    _loc_3 = new Date().getTime() / 1000;
                    this.oldDatas[param1] = this.onlineGiftTime;
                    this.onlineGiftTime = param2 + _loc_3;
                    break;
                }
                case Mod_Player_Base.GET_ONLINE_GIFT:
                {
                    this.oldDatas[param1] = this.isGetOnlineGift;
                    this.isGetOnlineGift = param2;
                    break;
                }
                case Mod_Player_Base.VIP_LEVEL:
                {
                    if (URI.vipHidden == false)
                    {
                        this.oldDatas[param1] = this.vipLevel;
                        this.vipLevel = param2;
                        VIPType.level = this.vipLevel;
                    }
                    break;
                }
                case Mod_Player_Base.PLAYER_DAY_QUEST:
                {
                    this.oldDatas[param1] = this.dayQuestState;
                    this.dayQuestState = param2;
                    break;
                }
                case Mod_Player_Base.FINISH_DAY_QUEST:
                {
                    this.oldDatas[param1] = this.finishDayQuest;
                    this.finishDayQuest = param2;
                    break;
                }
                case Mod_Player_Base.CAN_INCENSE_COUNT:
                {
                    this.oldDatas[param1] = this.canIncenseCount;
                    this.canIncenseCount = param2;
                    break;
                }
                case Mod_Player_Base.PLAYER_SKILL:
                {
                    this.oldDatas[param1] = this.skill;
                    this.skillChange = param2 - this.skill;
                    this.skill = param2;
                    break;
                }
                case Mod_Player_Base.MAX_MISSION_LOCK:
                {
                    this.missionKey = param2;
                    MissionType.lock = param2;
                    break;
                }
                case Mod_Player_Base.STATE_POINT:
                {
                    this.oldDatas[param1] = this.statePoint;
                    this.statePoint = param2;
                    RollCakeType.statePoint = param2;
                    break;
                }
                case Mod_Player_Base.TOTAL_STATE_POINT:
                {
                    this.oldDatas[param1] = this.totalStatePoint;
                    this.totalStatePoint = param2;
                    RollCakeType.totalStatePoint = param2;
                    break;
                }
                case Mod_Player_Base.QUEST_GIFT_BAG:
                {
                    this.giftItemId = param2;
                    break;
                }
                case Mod_Player_Base.BUY_NUMBER:
                {
                    this.oldDatas[param1] = this.flagNum;
                    this.flagNum = param2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function format_get_player_function(param1:Array) : Array
        {
            var _loc_3:String = null;
            var _loc_4:Object = null;
            param1 = param1[0];
            var _loc_2:Array = [];
            for (_loc_3 in param1)
            {
                
                _loc_4 = {};
                oObject.list(param1[_loc_3], _loc_4, ["id", "isPlayed"]);
                _loc_2.push(_loc_4);
            }
            return _loc_2;
        }// end function

        private function format_sign_play_player_function(param1:Array) : Array
        {
            return [];
        }// end function

        public function practice_notify(param1:Array) : void
        {
            var _loc_3:PlayerInfo = null;
            var _loc_2:Object = {notify_type:param1[0], data:param1[1]};
            if (param1[0] == Mod_Player_Base.UPDATE_PRACTICE)
            {
                if (param1[1] > 0)
                {
                    this.playerInfo.practice = Mod_Town_Base.ON_PRACTICE;
                    this.playerInfo.practiceExp = this.playerInfo.practiceExp + param1[1];
                    this.practiceChangeList.push(this.playerInfo);
                }
            }
            else
            {
                _loc_3 = _data.town.getPlayerInfo(param1[1]);
                this.practiceChangeList.push(_loc_3);
                if (param1[0] == Mod_Player_Base.START_PRACTICE)
                {
                    _loc_3.practice = Mod_Town_Base.ON_PRACTICE;
                }
                else if (param1[0] == Mod_Player_Base.FINISHED_PRACTICE)
                {
                    _loc_3.practice = Mod_Town_Base.FINISHED_PRACTICE;
                }
                else
                {
                    _loc_3.practice = Mod_Town_Base.OFF_PRACTICE;
                }
            }
            return;
        }// end function

        public function get_practice_data(param1:Array) : void
        {
            this.playerInfo.practiceTime = getTimer() + param1[2] * 1000;
            this.playerInfo.practiceWar = param1[3];
            this.playerInfo.practiceExp = param1[4];
            this.playerInfo.practiceSpeedNum = param1[5];
            this.playerInfo.practiceExpOne = param1[6];
            return;
        }// end function

        public function get_player_war_cd_time(param1:Array) : void
        {
            this.warCdTime = param1[0];
            return;
        }// end function

        public function get_game_assistant_info(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Array = null;
            var _loc_5:Array = null;
            var _loc_6:Object = null;
            this.getGameAssistantInfo = {};
            oObject.list(param1, this.getGameAssistantInfo, ["sports_rank", "combat", "fame", "skill", "role_number", "max_role_number", "day_quest_number", "day_quest_finish", "buy_power_chance", "buy_power_value", "buy_power_ingot", "ingot_rune_chance", "camp_salary", "is_get_camp_salary", "free_fate_chance", "incense_chance", "super_sports_chance", "super_sports_cd_time", "takebible_chance", "takebible_arrival_remain", "send_flower_chance", "free_reset_chance", "coin_tree_chance", "buy_coin_tree_count_chance", "achievement_points", "state_point", "roll_cake_count", "worship_mars_times", "buy_fate_npc_times", "peach_times", "is_can_get_stone", "get_stone_state", "pet_animal_times"]);
            this.showWebInfo(this.getGameAssistantInfo);
            var _loc_2:Array = [];
            for each (_loc_3 in param1[param1.length - 2] as Array)
            {
                
                _loc_6 = {};
                oObject.list(_loc_3, _loc_6, ["back_times_type", "ingot", "is_can_back"]);
                _loc_6["is_can_back"] = _loc_6["is_can_back"] == 0 ? (true) : (false);
                _loc_2.push(_loc_6);
            }
            _loc_4 = [];
            for each (_loc_5 in param1[(param1.length - 1)] as Array)
            {
                
                _loc_6 = {};
                oObject.list(_loc_5, _loc_6, ["active_degree_type", "cur_times", "max_times"]);
                _loc_4.push(_loc_6);
            }
            this.getGameAssistantInfo["pet_full"] = _data.pet.info.isFull;
            this.getGameAssistantInfo["back_times_type"] = _loc_2;
            this.getGameAssistantInfo["active_degree_list"] = _loc_4;
            return;
        }// end function

        private function showWebInfo(param1:Object) : void
        {
            var _loc_3:String = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_2:Array = [];
            for (_loc_3 in param1)
            {
                
                _loc_4 = param1[_loc_3];
                if (_loc_4 <= 0)
                {
                    continue;
                }
                _loc_5 = _loc_2.length + 1;
                switch(_loc_3)
                {
                    case "camp_salary":
                    {
                        if (param1["is_get_camp_salary"] != 1)
                        {
                            _loc_2.push(_loc_5 + "." + PlayerDataLang.camp_salary + " " + _loc_4);
                        }
                        break;
                    }
                    case "send_flower_chance":
                    {
                        _loc_2.push(_loc_5 + "." + PlayerDataLang.send_flower_chance + " " + _loc_4 + PlayerDataLang.num);
                        break;
                    }
                    case "incense_chance":
                    {
                        _loc_2.push(_loc_5 + "." + PlayerDataLang.incense_chance + " " + _loc_4 + PlayerDataLang.num);
                        break;
                    }
                    case "takebible_chance":
                    {
                        _loc_2.push(_loc_5 + "." + PlayerDataLang.takebible_chance + " " + _loc_4 + PlayerDataLang.num);
                        break;
                    }
                    case "worship_mars_times":
                    {
                        _loc_2.push(_loc_5 + "." + PlayerDataLang.worship_mars_times + " " + _loc_4 + PlayerDataLang.num);
                        break;
                    }
                    case "coin_tree_chance":
                    {
                        _loc_2.push(_loc_5 + "." + PlayerDataLang.coin_tree_chance + " " + _loc_4 + PlayerDataLang.num);
                        break;
                    }
                    case "pet_animal_times":
                    {
                        if (!_data.pet.info.isFull)
                        {
                            _loc_2.push(_loc_5 + "." + PlayerDataLang.pet_animal_times + " " + _loc_4 + PlayerDataLang.num);
                        }
                        break;
                    }
                    case "peach_times":
                    {
                        _loc_2.push(_loc_5 + "." + PlayerDataLang.peach_times + " " + _loc_4 + PlayerDataLang.num);
                        break;
                    }
                    case "roll_cake_count":
                    {
                        _loc_2.push(_loc_5 + "." + PlayerDataLang.roll_cake_count + " " + _loc_4 + PlayerDataLang.num);
                        break;
                    }
                    case "super_sports_chance":
                    {
                        _loc_2.push(_loc_5 + "." + PlayerDataLang.super_sports_chance + " " + _loc_4 + PlayerDataLang.num);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (_loc_2.length > 0)
            {
                this.webInfo = _loc_2.join("\n") + "\n\n\n  是否确定离开此页";
            }
            return;
        }// end function

        public function back_times(param1:Array) : void
        {
            oObject.list(param1, this.backTimesResult, ["result", "back_times_type"]);
            return;
        }// end function

        public function send_ingot_receive_show_vip(param1:Array) : void
        {
            this.isSendIngotReceiveShowVip = param1[0] == Mod_Player_Base.YES;
            return;
        }// end function

        public function removeNickNameSuffix(param1:String) : String
        {
            return param1.replace(new RegExp(URI.nickNameSuffix(true) + "$"), "");
        }// end function

    }
}
