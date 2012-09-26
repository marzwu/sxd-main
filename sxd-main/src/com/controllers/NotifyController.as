package com.controllers
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.pack.*;
    import com.assist.view.toolbar.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class NotifyController extends Base
    {
        private var colorObj:Object;

        public function NotifyController()
        {
            this.colorObj = {1:10066329, 2:2272312, 3:44783, 4:16711935, 5:16773376, 6:16711680};
            return;
        }// end function

        public function get missionAwardList() : Array
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_1:Array = [];
            for each (_loc_2 in _data.notify.missionAwardList)
            {
                
                _loc_3 = [_loc_2.player_id];
                _loc_4 = MissionType.getMissionName(_loc_2.mission_id);
                _loc_4 = _loc_4.replace("(", "").replace(")", "");
                _loc_5 = "";
                if (MissionType.isHeroMission(_loc_2.mission_id))
                {
                    _loc_5 = "<font color=\"#fff200\">[" + NotifyControllerLang.Notice + "]</font>" + this.getLinkPlayer(_loc_2.player_id, _loc_2.nickname, _ctrl.player.removeNickNameSuffix(_loc_2.nickname)) + NotifyControllerLang.Beat + "<font color=\"#fff200\">" + _loc_4 + "</font>";
                }
                else
                {
                    _loc_5 = "<font color=\"#fff200\">[" + NotifyControllerLang.Notice + "]</font>" + this.getLinkPlayer(_loc_2.player_id, _loc_2.nickname, _ctrl.player.removeNickNameSuffix(_loc_2.nickname)) + NotifyControllerLang.Into + "<font color=\"#fff200\">" + _loc_4 + "</font>";
                }
                if (_loc_2.ingot != 0)
                {
                    _loc_3.push(_loc_5 + NotifyControllerLang.Get + "<font color=\"#fff200\">" + _loc_2.ingot + NotifyControllerLang.Ingot + "</font>");
                }
                if (_loc_2.item_id != 0)
                {
                    _loc_3.push(_loc_5 + NotifyControllerLang.Get + this.getLinkItem(_loc_2.item_id));
                }
                if (_loc_2.boss_id != 0)
                {
                    _loc_4 = MonsterType.getMonsterNameById(_loc_2.boss_id);
                    _loc_3.push(_loc_5 + NotifyControllerLang.Beat + "<font color=\"#fff200\">" + _loc_4 + "</font>");
                }
                _loc_1.push(_loc_3);
            }
            _data.notify.missionAwardList = [];
            return _loc_1;
        }// end function

        public function get giftList() : Array
        {
            return _data.notify.giftObjList;
        }// end function

        public function get reelList() : Array
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_1:Array = [];
            for each (_loc_2 in _data.notify.reelList)
            {
                
                _loc_3 = ItemType.getTypeId(_loc_2.reel_id);
                _loc_4 = ItemType.getName(_loc_2.item_id);
                _loc_5 = "<font color=\"#fff200\">[" + NotifyControllerLang.Notice + "]</font>" + this.getLinkPlayer(_loc_2.player_id, _loc_2.nickname, _ctrl.player.removeNickNameSuffix(_loc_2.nickname));
                if (_loc_3 == ItemType.LianDanJuanZhou)
                {
                    _loc_5 = Lang.sprintf(NotifyControllerLang.ReelInfo, _loc_5, _loc_4.charAt(0), this.getLinkItem(_loc_2.item_id));
                }
                else if (_loc_3 == ItemType.LianQiJuanZhou)
                {
                    _loc_5 = Lang.sprintf(NotifyControllerLang.ReeledInfo, _loc_5, this.getLinkItem(_loc_2.item_id, _loc_2.qlv, _loc_2.gold_id, _loc_2.playerItemid));
                }
                _loc_1.push(_loc_5);
            }
            _data.notify.reelList = [];
            return _loc_1;
        }// end function

        public function get pkAward() : String
        {
            var _loc_1:* = _data.notify.pkAward;
            var _loc_2:Object = {};
            _loc_2.id = _loc_1[0];
            _loc_2.nickName = _loc_1[1];
            _loc_2.awardType = _loc_1[2];
            _loc_2.awardId = _loc_1[3];
            _loc_2.num = _loc_1[4];
            _loc_2.site = NotifyControllerLang.SuperSport;
            var _loc_3:* = this.htmlReturn(_loc_2);
            return _loc_3;
        }// end function

        private function htmlReturn(param1:Object) : String
        {
            var _loc_3:String = null;
            var _loc_2:* = "<font color=\"#fff200\">[" + NotifyControllerLang.Notice + "]</font>" + this.getLinkPlayer(param1.id, param1.nickName, _ctrl.player.removeNickNameSuffix(param1.nickname)) + NotifyControllerLang.Into + "<font color=\"#fff200\">" + param1.site + "</font>";
            switch(param1.awardType)
            {
                case Mod_Notify_Base.COINS:
                {
                    param1.type = NotifyControllerLang.Coin;
                    _loc_2 = _loc_2 + (NotifyControllerLang.GetInfo + "<font color=\"#fff200\">" + param1.type + param1.num + "</font>");
                    break;
                }
                case Mod_Notify_Base.ITEM:
                {
                    param1.type = ItemType.getName(param1.awardId);
                    param1.num = "x" + param1.num;
                    _loc_2 = _loc_2 + (NotifyControllerLang.GetInfo + "<font color=\"#fff200\"><u><a href=\"event:" + TextLinkType.Item + "_" + param1.awardId + "\">" + param1.type + param1.num + "</a></u></font>");
                    break;
                }
                case Mod_Notify_Base.ROLE:
                {
                    _loc_3 = RoleType.getRoleName(param1.awardId);
                    param1.type = _loc_3;
                    param1.num = "";
                    _loc_2 = _loc_2 + (NotifyControllerLang.GetInfo + "<font color=\"#fff200\">" + param1.type + param1.num + "</font>");
                    break;
                }
                case Mod_Notify_Base.FAME:
                {
                    param1.type = NotifyControllerLang.Fram;
                    _loc_2 = _loc_2 + (NotifyControllerLang.GetInfo + "<font color=\"#fff200\">" + param1.type + param1.num + "</font>");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function getRoleCount() : int
        {
            return _data.notify.getRoleCount();
        }// end function

        public function getNewResearch() : Array
        {
            return _data.notify.getNewResearch();
        }// end function

        public function getNewPartnersId() : int
        {
            return _data.notify.getNewPartnersId();
        }// end function

        public function get eqPlayerId() : int
        {
            return _data.notify.eqPlayerId;
        }// end function

        public function get getGoodFate() : String
        {
            var _loc_1:* = _data.notify.getGoodFate;
            var _loc_2:* = _loc_1[2];
            var _loc_3:* = "<font color=\"#fff200\">[" + NotifyControllerLang.Notice + "]</font>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + _loc_1[0] + "_" + _loc_1[1] + "\">" + _ctrl.player.removeNickNameSuffix(_loc_1[1]) + "</a></u></font>" + "<font color=\"#ffffff\">" + NotifyControllerLang.GetFateInfo + "</font>" + "<font color=\"#" + this.colorObj[FateType.getFateQuality(_loc_2)].toString(16) + "\">" + "<u>" + "<a href=\"event:" + TextLinkType.Fate + "_" + _loc_2 + "\">" + FateType.getFateName(_loc_2) + "</a></u></font>";
            return _loc_3;
        }// end function

        public function getBuyGoodStuffInLuckyShop() : Object
        {
            var _loc_1:* = _data.notify.getBuyGoodStuffInLuckyShop;
            _loc_1["chat"] = "<font color=\"#fff200\">[" + NotifyControllerLang.Notice + "]</font>" + this.getPlayerNameHtmlText(_loc_1["player_id"], _loc_1["player_name"]) + htmlFormat(NotifyControllerLang.BuyGoodStuff, 12, 16777215) + this.getItemNameHtmlText(_loc_1["item_id"], ItemType.getName(_loc_1["item_id"]), ItemType.getItemColor(_loc_1["item_id"]));
            return _loc_1;
        }// end function

        private function getPlayerNameHtmlText(param1:int, param2:String) : String
        {
            var _loc_3:* = "<font color=\"#fff200\" size=\"12\"><a href=\"event:" + TextLinkType.Player + "_" + param1 + "_" + param2 + "\"><u>" + param2 + "</u></a></font>";
            return _loc_3;
        }// end function

        private function getItemNameHtmlText(param1:int, param2:String, param3:uint) : String
        {
            var _loc_4:* = "#" + param3.toString(16);
            var _loc_5:* = "<font color=\"" + _loc_4 + "\" size=\"12\"><a href=\"event:" + TextLinkType.Item + "_" + param1 + "\"><u>" + param2 + "</u></a></font>";
            return "<font color=\"" + _loc_4 + "\" size=\"12\"><a href=\"event:" + TextLinkType.Item + "_" + param1 + "\"><u>" + param2 + "</u></a></font>";
        }// end function

        private function getLinkPlayer(param1:int, param2:String, param3:String) : String
        {
            var _loc_4:* = TextLinkType.Player + "_" + param1 + "_" + param2;
            return "<font color=\"#fff200\"><a href=\"event:" + _loc_4 + "\"><u>" + param3 + "</u></a></font>";
        }// end function

        private function getLinkItem(param1:int, param2:int = 1, param3:int = 0, param4:int = 0) : String
        {
            var _loc_5:* = ItemBasically.getBasic(param1);
            var _loc_6:* = ItemBasically.getBasic(param1).getItemColor(param3).toString(16);
            var _loc_7:* = _loc_5.getItemName(param3);
            var _loc_8:* = [TextLinkType.Item, param1, param2, param4, param3].join("_");
            return "<font color=\"#" + _loc_6 + "\"><a href=\"event:" + _loc_8 + "\"><u>" + _loc_7 + "</u></a></font>";
        }// end function

        public function get takeBible() : Object
        {
            var _loc_1:* = _data.notify.takeBible;
            var _loc_2:Object = {};
            _loc_2.name = _loc_1[0];
            _loc_2.npc = this.protectionData(_loc_1[1]);
            _loc_2.info = Lang.sprintf(NotifyControllerLang.TakeBible, _ctrl.player.removeNickNameSuffix(_loc_2.name), _loc_2.npc);
            return _loc_2;
        }// end function

        public function get takeBibleBerobbed() : Object
        {
            var _loc_1:* = _data.notify.takeBibleBerobbed;
            var _loc_2:Object = {};
            _loc_2.robPlayerNickname = _ctrl.player.removeNickNameSuffix(_loc_1[0]);
            _loc_2.berobPlayerNickname = _ctrl.player.removeNickNameSuffix(_loc_1[1]);
            _loc_2.npc = this.protectionData(_loc_1[2]);
            _loc_2.info = Lang.sprintf(NotifyControllerLang.TakeBibleBerobbed, _loc_2.robPlayerNickname, _loc_2.berobPlayerNickname, _loc_2.npc);
            return _loc_2;
        }// end function

        private function protectionData(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_TakeBible_Base.TANG_SENG:
                {
                    _loc_2 = NotifyControllerLang.TS;
                    break;
                }
                case Mod_TakeBible_Base.SUN_WU_KONG:
                {
                    _loc_2 = NotifyControllerLang.SWK;
                    break;
                }
                case Mod_TakeBible_Base.ZHU_BA_JIE:
                {
                    _loc_2 = NotifyControllerLang.ZBJ;
                    break;
                }
                case Mod_TakeBible_Base.SHA_WU_JING:
                {
                    _loc_2 = NotifyControllerLang.SWJ;
                    break;
                }
                case Mod_TakeBible_Base.BAI_LONG_MA:
                {
                    _loc_2 = NotifyControllerLang.BLM;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function get gameTimer() : Object
        {
            return this._data.notify.gameTimer;
        }// end function

        public function get sendFlowerInfo() : Object
        {
            return this._data.notify.sendFlowerInfo;
        }// end function

        public function get flowerWeekNumberOne() : Object
        {
            return this._data.notify.flowerWeekNumberOne;
        }// end function

        public function get passTowerMsg() : Array
        {
            var _loc_1:* = this._data.notify.passTowerMsg;
            this._data.notify.passTowerMsg = [];
            return _loc_1;
        }// end function

        public function get rulaiStatus() : Object
        {
            var _loc_1:* = this._data.notify.RulaiStatus;
            var _loc_2:Object = {};
            _loc_2.type = _loc_1[0];
            if (_loc_1[1].length != 0)
            {
                _loc_2.rulaiPlayerId = _loc_1[1][0][0];
                _loc_2.rulaiNickName = _loc_1[1][0][1];
            }
            else
            {
                _loc_2.rulaiPlayerId = 0;
                _loc_2.rulaiNickName = "";
            }
            _loc_2.ruLaiPlayerAry = this.renderPlayerId(_loc_1[1]);
            var _loc_3:* = _loc_2.ruLaiPlayerAry.length > 1 ? (NotifyControllerLang.Member) : ("");
            _loc_2.time = _loc_1[2];
            _loc_2.awardFame = _loc_1[3];
            _loc_2.isSelf = _loc_2.rulaiPlayerId == _ctrl.player.playerId;
            _loc_2.info = Lang.sprintf(NotifyControllerLang.CallRuLai, _loc_2.rulaiNickName, _loc_3, _loc_2.awardFame);
            _loc_2.diffTime = _ctrl.player.diffServerTime;
            return _loc_2;
        }// end function

        private function renderPlayerId(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.player_id = param1[_loc_4][0];
                _loc_5.nickname = param1[_loc_4][1];
                _loc_5.isSelf = _loc_5.call_player_id == _ctrl.player.playerId;
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            _loc_2 = this.deleteSameName(_loc_2);
            return _loc_2;
        }// end function

        private function deleteSameName(param1:Array) : Array
        {
            var _loc_4:int = 0;
            var _loc_2:* = param1.length;
            var _loc_3:* = _loc_2 - 1;
            while (_loc_3 > 0)
            {
                
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    if (param1[_loc_4]["player_id"] == param1[_loc_3]["player_id"])
                    {
                        param1.splice(_loc_3, 1);
                        break;
                    }
                    _loc_4++;
                }
                _loc_3 = _loc_3 - 1;
            }
            return param1;
        }// end function

        public function get rollCakInfo() : Object
        {
            var _loc_1:* = this._data.notify.rollCake;
            var _loc_2:Object = {};
            _loc_2.playerId = _loc_1[0];
            _loc_2.nickname = _loc_1[1];
            _loc_2.type = _loc_1[2];
            _loc_2.typeName = RollCakeType.getRollCakeNickName(_loc_2.type);
            _loc_2.awardSkill = RollCakeType.getRollCakeSkill(_loc_2.type);
            _loc_2.statePoint = RollCakeType.getRollCakeStatePoint(_loc_2.type);
            _loc_2.coin = RollCakeType.getRollCakeCoin(_loc_2.type);
            if (_loc_2.coin == 0)
            {
                _loc_2.info = "<font color=\"#fff200\">[" + NotifyControllerLang.Notice + "]</font>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + _loc_2.playerId + "_" + _loc_2.nickname + "\">" + _ctrl.player.removeNickNameSuffix(_loc_2.nickname) + "</a></u></font>" + Lang.sprintf(NotifyControllerLang.RoleCake, _loc_2.typeName, HtmlText.yellow(_loc_2.awardSkill), HtmlText.yellow(_loc_2.statePoint));
            }
            else
            {
                _loc_2.info = "<font color=\"#fff200\">[" + NotifyControllerLang.Notice + "]</font>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + _loc_2.playerId + "_" + _loc_2.nickname + "\">" + _ctrl.player.removeNickNameSuffix(_loc_2.nickname) + "</a></u></font>" + Lang.sprintf(NotifyControllerLang.RoleCakeCoin, _loc_2.typeName, HtmlText.yellow(_loc_2.coin));
            }
            return _loc_2;
        }// end function

        public function get serverWarWinnerMsg() : String
        {
            return this._data.notify.serverWarWinnerMsg;
        }// end function

        public function get serverFactionWarWinnerMsg() : String
        {
            return _data.notify.serverFactionWarWinnerMsg;
        }// end function

        public function get firstLoginChat() : String
        {
            return this._data.notify.firstLoginChat;
        }// end function

        public function get firstLoginWorld() : String
        {
            return this._data.notify.firstLoginWorld;
        }// end function

        public function set firstLoginWorld(param1:String) : void
        {
            this._data.notify.firstLoginWorld = "";
            return;
        }// end function

        public function get zodiacEntryNotify() : Object
        {
            return this._data.notify.zodiacEntryNotify;
        }// end function

        public function get petBaoJi() : String
        {
            return this._data.notify.petBaoJi;
        }// end function

        public function get missionPracticeStatus() : Object
        {
            var _loc_1:* = _data.notify.MissionPracticeStatus;
            var _loc_2:Object = {};
            _loc_2.playerId = _loc_1[0];
            _loc_2.status = _loc_1[1];
            return _loc_2;
        }// end function

        public function get studyStuntNotify() : Object
        {
            return this._data.notify.studyStuntNotify;
        }// end function

        public function get catHuntGoldenBox() : String
        {
            var _loc_1:* = this._data.notify.catHuntGoldenBox;
            var _loc_2:* = _loc_1[0];
            var _loc_3:* = _loc_1[1];
            var _loc_4:* = _loc_1[2];
            var _loc_5:String = "";
            return "";
        }// end function

        public function get worldfactionWinner() : String
        {
            return this._data.notify.worldfactionWinner;
        }// end function

        public function get getWeekRanking() : String
        {
            var _loc_1:* = _data.notify.WeekRanking;
            var _loc_2:* = _loc_1[0];
            var _loc_3:String = "";
            var _loc_4:* = _loc_1[1];
            switch(_loc_2)
            {
                case Mod_WeekRanking_Base.RANKING_TYPE_FAME:
                {
                    _loc_3 = "[" + _loc_4 + "]" + NotifyControllerLang.RANKING_TYPE_FAME;
                    break;
                }
                case Mod_WeekRanking_Base.RANKING_TYPE_COIN:
                {
                    _loc_3 = "[" + _loc_4 + "]" + NotifyControllerLang.RANKING_TYPE_COIN;
                    break;
                }
                case Mod_WeekRanking_Base.RANKING_TYPE_MISSION:
                {
                    _loc_3 = "[" + _loc_4 + "]" + NotifyControllerLang.RANKING_TYPE_MISSION;
                    break;
                }
                case Mod_WeekRanking_Base.RANKING_TYPE_STATE_POINT:
                {
                    _loc_3 = "[" + _loc_4 + "]" + NotifyControllerLang.RANKING_TYPE_STATE_POINT;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function get specialResult() : int
        {
            return _data.notify.specialResult;
        }// end function

        public function get five() : Object
        {
            var _loc_1:* = _data.notify.five;
            var _loc_2:Object = {};
            _loc_2.player_id = _loc_1[0];
            _loc_2.nick_name = _loc_1[1];
            _loc_2.yuqiId = _loc_1[2];
            _loc_2.info = "<font color=\"#fff200\">[" + NotifyControllerLang.Notice + "]</font>" + "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + _loc_2.player_id + "_" + _loc_2.nick_name + "\">" + _ctrl.player.removeNickNameSuffix(_loc_2.nick_name) + "</a></u></font>" + Lang.sprintf(NotifyControllerLang.FindImmortalFive, this.changeColor(_loc_2.yuqiId));
            return _loc_2;
        }// end function

        private function changeColor(param1:int) : String
        {
            var _loc_2:String = "";
            if (param1 == 3)
            {
                _loc_2 = "紫色";
            }
            if (param1 == 4)
            {
                _loc_2 = "金色";
            }
            return _loc_2;
        }// end function

        public function get huLuWa() : Object
        {
            var _loc_1:* = _data.notify.huLuWa;
            var _loc_2:Object = {};
            _loc_2.player_id = _loc_1[0];
            _loc_2.nick_name = _loc_1[1];
            _loc_2.info = Lang.sprintf(NotifyControllerLang.FindImmortalHLW, _ctrl.player.removeNickNameSuffix(_loc_2.nick_name));
            return _loc_2;
        }// end function

        public function get unlockPartnerList() : Array
        {
            return _data.notify.unlockPartnerList;
        }// end function

        public function get topwarGifName() : String
        {
            return _data.notify.topwarGifName;
        }// end function

        public function get luckyWheelNotify() : String
        {
            var _loc_1:* = _data.notify.luckyWheelNotify;
            var _loc_2:* = this.medicineName(_loc_1.medicine_reel_id);
            var _loc_3:* = Lang.sprintf(NotifyControllerLang.LuckyWheel, _ctrl.player.removeNickNameSuffix(_loc_1.nick_name), _loc_2);
            return _loc_3;
        }// end function

        private function medicineName(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case 390:
                {
                    _loc_2 = NotifyControllerLang.WuLi;
                    break;
                }
                case 406:
                {
                    _loc_2 = NotifyControllerLang.JueJi;
                    break;
                }
                case 424:
                {
                    _loc_2 = NotifyControllerLang.FaShu;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
