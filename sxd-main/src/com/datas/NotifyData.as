package com.datas
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.assist.view.toolbar.*;
    import com.haloer.data.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;

    public class NotifyData extends Base
    {
        private var _pkAward:Array;
        private var _getGoodFate:Array;
        public var missionAwardList:Array;
        public var reelList:Array;
        private var intRoleCount:int;
        private var aryResearch:Array;
        private var intRoleID:int;
        public var getBuyGoodStuffInLuckyShop:Object;
        public var giftObjList:Array;
        public var eqPlayerId:int;
        public var eqItemId:int;
        public var MissionPracticeStatus:Array;
        private var reg1:RegExp;
        private var reg2:RegExp;
        private var _takeBible:Array;
        private var _takeBibleBerobbed:Array;
        public var gameTimer:Object;
        public var sendFlowerInfo:Object;
        public var flowerWeekNumberOne:Object;
        public var passTowerMsg:Array;
        public var RulaiStatus:Array;
        public var rollCake:Array;
        public var serverWarWinnerMsg:String = "";
        public var serverFactionWarWinnerMsg:String = "";
        public var firstLoginChat:String = "";
        public var firstLoginWorld:String = "";
        public var petBaoJi:String = "";
        public var zodiacEntryNotify:Object;
        public var studyStuntNotify:Object;
        public var catHuntGoldenBox:Array;
        public var worldfactionWinner:String = "";
        public var WeekRanking:Array;
        public var specialResult:int = 0;
        public var five:Array;
        public var huLuWa:Array;
        public var unlockPartnerList:Array;
        public var topwarGifName:String = "";
        public var luckyWheelNotify:Object;

        public function NotifyData()
        {
            this.missionAwardList = [];
            this.reelList = [];
            this.aryResearch = [];
            this.getBuyGoodStuffInLuckyShop = {};
            this.giftObjList = [];
            this.reg1 = /\[(.+?)\]""\[(.+?)\]/g;
            this.reg2 = /\<(.+?)\>""\<(.+?)\>/g;
            this.gameTimer = {};
            this.sendFlowerInfo = {};
            this.flowerWeekNumberOne = {};
            this.passTowerMsg = [];
            this.zodiacEntryNotify = {};
            this.studyStuntNotify = {};
            return;
        }// end function

        public function get pkAward() : Array
        {
            return this._pkAward;
        }// end function

        public function get getGoodFate() : Array
        {
            return this._getGoodFate;
        }// end function

        public function mission_award(param1:Array) : void
        {
            var _loc_2:Object = {};
            this.missionAwardList.push(_loc_2);
            _loc_2.player_id = param1[0];
            _loc_2.nickname = _data.player.removeNickNameSuffix(param1[1]);
            _loc_2.mission_id = param1[2];
            _loc_2.item_id = param1[3];
            _loc_2.ingot = param1[4];
            _loc_2.boss_id = param1[5];
            return;
        }// end function

        public function pk_award(param1:Array) : void
        {
            this._pkAward = param1;
            return;
        }// end function

        public function complete_reel_production(param1:Array) : void
        {
            var _loc_2:Object = {};
            this.reelList.push(_loc_2);
            _loc_2.player_id = param1[0];
            _loc_2.nickname = _data.player.removeNickNameSuffix(param1[1]);
            _loc_2.reel_id = param1[2];
            _loc_2.item_id = param1[3];
            _loc_2.qlv = param1[4];
            _loc_2.gold_id = param1[5];
            _loc_2.playerItemid = int(param1[6]);
            return;
        }// end function

        public function role_num_notify(param1:Array) : void
        {
            this.intRoleCount = param1[0];
            return;
        }// end function

        public function getRoleCount() : int
        {
            return this.intRoleCount;
        }// end function

        public function new_research_notify(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this.aryResearch = [];
            for each (_loc_3 in param1[0])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["id", "name"]);
                this.aryResearch.push(_loc_2);
            }
            return;
        }// end function

        public function getNewResearch() : Array
        {
            return this.aryResearch;
        }// end function

        public function new_partners_notify(param1:Array) : void
        {
            this.intRoleID = param1[0];
            return;
        }// end function

        public function getNewPartnersId() : int
        {
            return this.intRoleID;
        }// end function

        public function update_lucky_shop_item(param1:Array) : void
        {
            return;
        }// end function

        public function buy_good_stuff_in_lucky_shop(param1:Array) : void
        {
            this.getBuyGoodStuffInLuckyShop = {};
            oObject.list(param1, this.getBuyGoodStuffInLuckyShop, ["player_id", "player_name", "item_id"]);
            return;
        }// end function

        public function update_player_super_gift(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            this.giftObjList = [];
            for each (_loc_2 in param1[0])
            {
                
                _loc_3 = {};
                oObject.list(_loc_2, _loc_3, ["player_gift_id", "type", "gift_id", "message"]);
                _loc_3.sign = ActivityType.GiftList[(_loc_3.type - 1)];
                if (_loc_3.sign == ActivityType.Gift25)
                {
                    _loc_3.message = _loc_3.message.replace(this.reg2, this.regfun3);
                }
                else
                {
                    _loc_3.message = _loc_3.message.replace(this.reg2, this.regfun2);
                }
                _loc_3.message = _loc_3.message.replace(this.reg1, this.regfun1);
                _loc_3.message = HtmlText.white(_loc_3.message);
                this.giftObjList[_loc_3.sign] = _loc_3;
            }
            return;
        }// end function

        public function notify_get_good_fate(param1:Array) : void
        {
            this._getGoodFate = param1;
            return;
        }// end function

        public function change_equip(param1:Array) : void
        {
            this.eqPlayerId = param1[0];
            this.eqItemId = param1[1];
            var _loc_2:* = _data.town.getPlayerInfo(this.eqPlayerId);
            _loc_2.signSuffix = ItemType.getItemSuffix(this.eqItemId);
            if (_loc_2.isMine)
            {
                _data.player.signSuffix = _loc_2.signSuffix;
            }
            if (_loc_2.signSuffix == "F0" || _loc_2.signSuffix == "F1")
            {
                _loc_2.bPutOnClothes = true;
            }
            else
            {
                _loc_2.bPutOnClothes = false;
            }
            return;
        }// end function

        public function disband_faction_notify(param1:Array) : void
        {
            return;
        }// end function

        public function kickout_member_notify(param1:Array) : void
        {
            return;
        }// end function

        public function notify_player_mission_practice_status(param1:Array) : void
        {
            this.MissionPracticeStatus = param1;
            return;
        }// end function

        private function regfun1(... args) : String
        {
            args = args[1];
            var _loc_3:String = "";
            var _loc_4:* = args.split(",");
            if (args.split(",").length > 1)
            {
                _loc_3 = _loc_4.pop();
                if (_loc_3.charAt(0) != "\"" || _loc_3.charAt(1) != "#" || _loc_3.charAt((_loc_3.length - 1)) != "\"")
                {
                    _loc_4.push(_loc_3);
                    _loc_3 = "";
                }
                args = _loc_4.join(",");
            }
            if (_loc_3 == "")
            {
                return "<font color=\"#fff200\">" + args + "</font>";
            }
            return "<font color=" + _loc_3 + ">" + args + "</font>";
        }// end function

        private function regfun2(... args) : String
        {
            args = args[1];
            var _loc_3:String = "";
            var _loc_4:* = args.split("_");
            _loc_3 = this.getServerWar(int(_loc_4[0]), int(_loc_4[1]), int(_loc_4[2]), int(_loc_4[3]));
            return _loc_3;
        }// end function

        private function regfun3(... args) : String
        {
            args = args[1];
            var _loc_3:String = "";
            var _loc_4:* = args.split("_");
            _loc_3 = this.getServerFactionWar(int(_loc_4[0]), int(_loc_4[1]), int(_loc_4[2]), int(_loc_4[3]));
            return _loc_3;
        }// end function

        private function getServerWar(param1:int, param2:int, param3:int, param4:int) : String
        {
            var _loc_5:* = _data.serverWar.info.getGroupName(param3);
            if (param1 == Mod_ServerWar_Base.RACE_TYPE_STAGE_SELECT_RACE)
            {
                _loc_5 = NotifyDataLang.ServerWarType1 + _loc_5;
            }
            else if (param1 == Mod_ServerWar_Base.RACE_TYPE_STAGE_RACE)
            {
                _loc_5 = NotifyDataLang.ServerWarType2 + _loc_5;
            }
            if (param4 == Mod_ServerWar_Base.SERVER_WAR_16)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page32;
            }
            else if (param4 == Mod_ServerWar_Base.SERVER_WAR_8)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page16;
            }
            else if (param4 == Mod_ServerWar_Base.SERVER_WAR_4)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page8;
            }
            else if (param4 == Mod_ServerWar_Base.SERVER_WAR_2)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page4;
            }
            else if (param4 == Mod_ServerWar_Base.SERVER_WAR_1)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page2;
            }
            else if (param4 == Mod_ServerWar_Base.SERVER_WAR_1_COMPLETE)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page1;
            }
            return Lang.sprintf(NotifyDataLang.CongratulationPage, HtmlText.yellow2("【" + _loc_5 + "】"));
        }// end function

        private function getServerFactionWar(param1:int, param2:int, param3:int, param4:int) : String
        {
            var _loc_5:* = _data.serverFactionWar.info.getGroupName(param3);
            if (param1 == Mod_ServerWar_Base.RACE_TYPE_STAGE_SELECT_RACE)
            {
                _loc_5 = NotifyDataLang.serverFactionWar + _loc_5;
            }
            else if (param1 == Mod_ServerWar_Base.RACE_TYPE_STAGE_RACE)
            {
                _loc_5 = NotifyDataLang.serverFactionWar + _loc_5;
            }
            if (param4 == Mod_ServerWar_Base.SERVER_WAR_16)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page32;
            }
            else if (param4 == Mod_ServerWar_Base.SERVER_WAR_8)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page16;
            }
            else if (param4 == Mod_ServerWar_Base.SERVER_WAR_4)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page8;
            }
            else if (param4 == Mod_ServerWar_Base.SERVER_WAR_2)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page4;
            }
            else if (param4 == Mod_ServerWar_Base.SERVER_WAR_1)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page2;
            }
            else if (param4 == Mod_ServerWar_Base.SERVER_WAR_1_COMPLETE)
            {
                _loc_5 = _loc_5 + NotifyDataLang.Page1;
            }
            return Lang.sprintf(NotifyDataLang.CongratulationPage, HtmlText.yellow2("【" + _loc_5 + "】"));
        }// end function

        private function getLinkPlayer(param1:int, param2:String) : String
        {
            var _loc_3:* = TextLinkType.Player + "_" + param1 + "_" + param2;
            return "<font color=\"#fff200\"><a href=\"event:" + _loc_3 + "\"><u>" + param2 + "</u></a></font>";
        }// end function

        public function get takeBible() : Array
        {
            return this._takeBible;
        }// end function

        public function get takeBibleBerobbed() : Array
        {
            return this._takeBibleBerobbed;
        }// end function

        public function player_take_bible(param1:Array) : void
        {
            this._takeBible = param1;
            return;
        }// end function

        public function player_take_bible_berobbed(param1:Array) : void
        {
            this._takeBibleBerobbed = param1;
            return;
        }// end function

        public function game_timer(param1:Array) : void
        {
            this.gameTimer = {};
            oObject.list(param1, this.gameTimer, ["timer_type"]);
            return;
        }// end function

        public function send_flower(param1:Array) : void
        {
            this.sendFlowerInfo = {};
            oObject.list(param1, this.sendFlowerInfo, ["send_player_nickname", "receive_player_nickname", "flower_count", "award_fame", "receive_player_sex"]);
            this.sendFlowerInfo["send_player_nickname"] = this._data.player.removeNickNameSuffix(this.sendFlowerInfo["send_player_nickname"]);
            this.sendFlowerInfo["receive_player_nickname"] = this._data.player.removeNickNameSuffix(this.sendFlowerInfo["receive_player_nickname"]);
            return;
        }// end function

        public function flower_week_number_one(param1:Array) : void
        {
            this.flowerWeekNumberOne = {};
            oObject.list(param1, this.flowerWeekNumberOne, ["player_nickname"]);
            this.flowerWeekNumberOne["player_nickname"] = this._data.player.removeNickNameSuffix(this.flowerWeekNumberOne["player_nickname"]);
            return;
        }// end function

        public function pass_tower(param1:Array) : void
        {
            var _loc_2:String = null;
            if (param1[2] == 1)
            {
                _loc_2 = Lang.sprintf(NotifyDataLang.PassTower, _data.player.removeNickNameSuffix(param1[0]), _data.tower.info.daoName[param1[1]], int(param1[1]) * 10);
                this.passTowerMsg.push(HtmlText.format(_loc_2, 16773632, 24, "", true));
            }
            return;
        }// end function

        public function update_rulai_status(param1:Array) : void
        {
            this.RulaiStatus = param1;
            return;
        }// end function

        public function roll_cake(param1:Array) : void
        {
            this.rollCake = param1;
            return;
        }// end function

        public function update_server_war_step(param1:Array) : void
        {
            _data.serverWar.info.stateServer = param1[0];
            return;
        }// end function

        public function have_new_server_war_report(param1:Array) : void
        {
            return;
        }// end function

        public function server_war_winner(param1:Array) : void
        {
            var _loc_2:* = "【" + _data.player.removeNickNameSuffix(param1[3]) + "】";
            if (param1[0] == Mod_ServerWar_Base.RACE_TYPE_STAGE_SELECT_RACE)
            {
                this.serverWarWinnerMsg = HtmlText.format(Lang.sprintf(NotifyDataLang.CongratulationWinType1, _loc_2), 16773632, 25);
            }
            else
            {
                _loc_2 = param1[1] + param1[2] + _loc_2;
                this.serverWarWinnerMsg = HtmlText.format(Lang.sprintf(NotifyDataLang.CongratulationWinType2, _loc_2), 16773632, 25);
            }
            return;
        }// end function

        public function server_faction_war_winner(param1:Array) : void
        {
            var _loc_2:* = "【" + _data.player.removeNickNameSuffix(param1[0]) + "】";
            this.serverFactionWarWinnerMsg = HtmlText.format(Lang.sprintf(NotifyDataLang.ServerFactionWinner, _loc_2), 16773632, 25);
            return;
        }// end function

        public function world_war_top_login(param1:Array) : void
        {
            var _loc_2:* = "【" + _data.player.removeNickNameSuffix(param1[0]) + "】";
            _loc_2 = Lang.sprintf(NotifyDataLang.OnlineNotification, _loc_2);
            this.firstLoginChat = HtmlText.yellow2(_loc_2);
            this.firstLoginWorld = HtmlText.format(_loc_2, 16773632, 24, "", true);
            return;
        }// end function

        public function get_pet_animal_exp(param1:Array) : void
        {
            this.petBaoJi = Lang.sprintf(NotifyDataLang.PetBaoJi, param1[0]);
            this.petBaoJi = HtmlText.format(this.petBaoJi, 16773632, 26);
            return;
        }// end function

        public function zodiac_entry_notify(param1:Array) : void
        {
            this.zodiacEntryNotify = {};
            oObject.list(param1, this.zodiacEntryNotify, ["nickname", "zodiac_leve"]);
            this.zodiacEntryNotify["nickname"] = this._data.player.removeNickNameSuffix(this.zodiacEntryNotify["nickname"]);
            return;
        }// end function

        public function study_stunt_notify(param1:Array) : void
        {
            this.studyStuntNotify = {};
            oObject.list(param1, this.studyStuntNotify, ["nickname", "stunt_id"]);
            this.studyStuntNotify["nickname"] = this._data.player.removeNickNameSuffix(this.studyStuntNotify["nickname"]);
            this.studyStuntNotify["stunt_name"] = StudyStuntType.getName(this.studyStuntNotify["stunt_id"]);
            return;
        }// end function

        public function cat_hunt_golden_box(param1:Array) : void
        {
            this.catHuntGoldenBox = param1;
            return;
        }// end function

        public function update_world_faction_war_step(param1:Array) : void
        {
            return;
        }// end function

        public function update_world_faction_war_team(param1:Array) : void
        {
            return;
        }// end function

        public function world_faction_war_winner(param1:Array) : void
        {
            this.worldfactionWinner = Lang.sprintf(NotifyDataLang.WorldFactionWarTip, param1[0] + " " + param1[1], param1[2]);
            this.worldfactionWinner = HtmlText.format(this.worldfactionWinner, 16773632, 24, "", true);
            return;
        }// end function

        public function have_new_world_faction_war_report(param1:Array) : void
        {
            return;
        }// end function

        public function week_ranking(param1:Array) : void
        {
            this.WeekRanking = param1;
            return;
        }// end function

        public function special_notify(param1:Array) : void
        {
            this.specialResult = param1[0];
            return;
        }// end function

        public function find_immortal_five_notify(param1:Array) : void
        {
            this.five = param1;
            return;
        }// end function

        public function exchange_hu_lu_wa_notify(param1:Array) : void
        {
            this.huLuWa = param1;
            return;
        }// end function

        public function unlock_special_partner(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:Object = null;
            this.unlockPartnerList = [];
            for each (_loc_2 in param1[0])
            {
                
                _loc_3 = {};
                this.unlockPartnerList.push(_loc_2);
            }
            return;
        }// end function

        public function world_top_war_gift_has_white_tiger(param1:Array) : void
        {
            this.topwarGifName = param1[1];
            return;
        }// end function

        public function lucky_wheel_award_seven_medicine_reel(param1:Array) : void
        {
            this.luckyWheelNotify = {};
            this.luckyWheelNotify.player_id = param1[0];
            this.luckyWheelNotify.nick_name = param1[1];
            this.luckyWheelNotify.medicine_reel_id = param1[2];
            return;
        }// end function

        public function update_server_faction_war_step(param1:Array) : void
        {
            _data.serverFactionWar.info.stateServer = param1[0];
            return;
        }// end function

        public function have_new_server_faction_war_report(param1:Array) : void
        {
            return;
        }// end function

    }
}
