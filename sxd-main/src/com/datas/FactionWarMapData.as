package com.datas
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.assist.view.toolbar.*;
    import com.lang.client.com.datas.*;
    import flash.utils.*;

    public class FactionWarMapData extends Base
    {
        public var result:int = 0;
        public var canSignup:int = 0;
        public var isSignup:int = 0;
        public var signupTip:String = "";
        public var signupState:int = 0;
        public var signupCoins:int = 100000;
        public var signupNum:int = 0;
        public var signupList:Array;
        public var warId:int = 1;
        public var warTownId:int = 17;
        public var intoCan:int = 0;
        public var intoTime:int = 0;
        public var warTime:int = 0;
        public var warCount:int = 0;
        public var warRound:int = 0;
        public var warStatusList:Array;
        public var warMapList:Array;
        public var id1:int = 0;
        public var id2:int = 0;
        public var id:int = 0;
        public var killRank:Array;
        public var killTip:String = "";
        public var winId:int = 0;
        public var heroRank:Array;
        public var heroRankTip:String = "";
        public var cupObj:Object;
        public var warWinPlayerId:int;
        public var warDataList:Array;
        public var warAwardList:Array;
        public var overWorldMsg:String = "";
        public var overChatMsg:String = "";
        public var giftList:Array;
        public var chatWorld:Array;
        public var chatFaction:Array;
        public var worldNotice:Array;

        public function FactionWarMapData()
        {
            this.signupList = [];
            this.warStatusList = [];
            this.warMapList = [];
            this.killRank = [];
            this.heroRank = [];
            this.cupObj = {};
            this.warDataList = [];
            this.warAwardList = [];
            this.giftList = [];
            this.chatWorld = [];
            this.chatFaction = [];
            this.worldNotice = [];
            return;
        }// end function

        public function notify_status(param1:Array) : void
        {
            this.signupState = param1[0];
            return;
        }// end function

        public function get_faction_war_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.canSignup = param1[0];
            this.isSignup = param1[1];
            for each (_loc_2 in param1[2])
            {
                
                if (_loc_2[2] == 1)
                {
                    this.warId = _loc_2[0];
                    this.warTownId = _loc_2[1];
                    this.signupCoins = _loc_2[3];
                    this.signupNum = _loc_2[4];
                    break;
                }
            }
            if (this.isSignup != 0)
            {
                this.signupTip = Lang.sprintf(FactionWarMapDataLang.SignUpNum, this.signupNum) + HtmlText.green(FactionWarMapDataLang.SignUpYes);
            }
            else
            {
                this.signupTip = Lang.sprintf(FactionWarMapDataLang.SignUpNum, this.signupNum) + FactionWarMapDataLang.SignUpNo;
            }
            return;
        }// end function

        public function sign_up(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function sign_up_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            this.id = param1[0];
            this.signupList = [];
            for each (_loc_2 in param1[1])
            {
                
                _loc_3 = {};
                _loc_3.id = _loc_2[0];
                _loc_3.name = _data.player.removeNickNameSuffix(_loc_2[1]);
                _loc_3.lv = _loc_2[2];
                _loc_3.num = _loc_2[4];
                _loc_3.fame = _loc_2[5];
                _loc_3.isb = _loc_2[0] == this.id;
                this.signupList.push(_loc_3);
            }
            this.signupList.sortOn("fame", Array.NUMERIC | Array.DESCENDING);
            return;
        }// end function

        public function notify_open_faction_war(param1:Array) : void
        {
            this.signupState = 4;
            this.warTime = 0;
            this.warCount = param1[1];
            this.warRound = param1[2];
            this.warTownId = param1[3];
            return;
        }// end function

        public function cup_list(param1:Array) : void
        {
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            this.cupObj.g8 = [];
            this.cupObj.g4 = [];
            this.cupObj.g2 = [];
            this.cupObj.g1 = [];
            this.cupObj.has = [];
            this.cupObj.out = [];
            this.cupObj.win = [];
            this.cupObj.names = [""];
            this.cupObj.count = this.getRoundWar(param1[1], param1[2]);
            this.cupObj.state = param1[4];
            this.cupObj.time = param1[5] * 1000 + getTimer();
            this.cupObj.factionId = _data.player.playerInfo.factionId;
            this.cupObj.round = param1[2];
            var _loc_2:* = "g" + this.getRoundWar(param1[1], 1);
            for each (_loc_4 in param1[6])
            {
                
                _loc_3 = {};
                _loc_3.id1 = _loc_4[0];
                _loc_3.id2 = _loc_4[2];
                _loc_3.group = _loc_4[4];
                _loc_3.round = _loc_4[5];
                _loc_3.winner = _loc_4[6];
                if (_loc_3.round == 1)
                {
                    this.cupObj[_loc_2][_loc_3.group] = _loc_3;
                    this.cupObj.names[_loc_3.id1] = _data.player.removeNickNameSuffix(_loc_4[1]);
                    this.cupObj.names[_loc_3.id2] = _data.player.removeNickNameSuffix(_loc_4[3]);
                }
                else
                {
                    var _loc_7:* = _loc_3.winner;
                    this.cupObj.win[_loc_3.id2 + "&" + _loc_3.id1] = _loc_3.winner;
                    this.cupObj.win[_loc_3.id1 + "&" + _loc_3.id2] = _loc_7;
                }
                if (_loc_3.winner == 0)
                {
                    this.cupObj.has[_loc_3.id1] = 1;
                    this.cupObj.has[_loc_3.id2] = 1;
                    continue;
                }
                if (this.cupObj.id1 != 0 && this.cupObj.id2 != 0)
                {
                    this.cupObj.has[_loc_3.winner] = 1;
                    if (_loc_3.winner == _loc_3.id1)
                    {
                        this.cupObj.out[_loc_3.id2] = 1;
                        continue;
                    }
                    if (_loc_3.winner == _loc_3.id2)
                    {
                        this.cupObj.out[_loc_3.id1] = 1;
                    }
                }
            }
            return;
        }// end function

        public function get_faction_war_info(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            this.warMapList = [];
            for each (_loc_2 in param1[2])
            {
                
                _loc_3 = {};
                _loc_3.fid = _loc_2[0];
                _loc_3.mid = _loc_2[1];
                _loc_3.name = _data.player.removeNickNameSuffix(_loc_2[2]);
                _loc_3.lv = _loc_2[3];
                this.warMapList.push(_loc_3);
            }
            this.warStatusList = [];
            this.warRound = param1[1];
            this.warCount = param1[0];
            if (this.warMapList.length < 2)
            {
                this.warMapList.push({fid:0, mid:0, name:"", lv:0});
            }
            return;
        }// end function

        public function notify_begin_faction_war(param1:Array) : void
        {
            this.signupState = 4;
            this.intoTime = 0;
            this.warCount = param1[1];
            this.warRound = param1[2];
            this.warTime = param1[3] * 1000 + getTimer();
            return;
        }// end function

        public function fight_player(param1:Array) : void
        {
            return;
        }// end function

        public function notify_versus_fighting(param1:Array) : void
        {
            var _loc_2:Object = {};
            _loc_2.aInfo = _data.town.getPlayerInfo(param1[0]);
            _loc_2.bInfo = _data.town.getPlayerInfo(param1[1]);
            _loc_2.aSate = 2;
            _loc_2.bSate = 2;
            _loc_2.msg = "";
            _loc_2.idx = 0;
            this.warStatusList.push(_loc_2);
            return;
        }// end function

        public function notify_versus_fight_over(param1:Array) : void
        {
            var _loc_2:* = _data.town.getPlayerInfo(param1[0]);
            var _loc_3:* = htmlFormat(_loc_2.name, -1, _loc_2.nameColor);
            var _loc_4:* = _data.town.getPlayerInfo(param1[1]);
            var _loc_5:* = htmlFormat(_loc_4.name, -1, _loc_4.nameColor);
            var _loc_6:Object = {};
            {}.aInfo = _loc_2;
            _loc_6.bInfo = _loc_4;
            _loc_6.time = param1[3];
            if (param1[2] == 0)
            {
                _loc_6.msg = Lang.sprintf(FactionWarMapDataLang.WarTo, _loc_5, _loc_3);
                _loc_6.aSate = 1;
                _loc_6.bSate = 0;
            }
            else
            {
                _loc_6.msg = Lang.sprintf(FactionWarMapDataLang.WarTo, _loc_3, _loc_5);
                _loc_6.aSate = 0;
                _loc_6.bSate = 1;
            }
            this.warStatusList.push(_loc_6);
            return;
        }// end function

        public function send_versus_fight_data(param1:Array) : void
        {
            var _loc_4:Array = null;
            this.warWinPlayerId = param1[0];
            var _loc_2:* = new WarData();
            _loc_2.format([0, 0, 0, [param1[1][0]]]);
            this.warDataList.push(_loc_2);
            var _loc_3:Array = [0, 0, 0];
            for each (_loc_4 in param1[2])
            {
                
                _loc_3[_loc_4[0]] = _loc_4[1];
            }
            this.warAwardList.push(_loc_3);
            return;
        }// end function

        public function notify_round_over(param1:Array) : void
        {
            var _loc_3:Object = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Array = null;
            var _loc_7:Array = null;
            this.winId = param1[0];
            this.killRank = [];
            this.killTip = "";
            var _loc_2:Array = [];
            for each (_loc_3 in this.warMapList)
            {
                
                _loc_2[_loc_3.fid] = _loc_3.name;
                if (_loc_3.fid == this.winId)
                {
                    this.killTip = Lang.sprintf(FactionWarMapDataLang.WarOverWinTip, _data.player.removeNickNameSuffix(_loc_3.name));
                }
            }
            _loc_4 = _data.player.playerInfo.factionId;
            _loc_5 = _data.player.playerInfo.id;
            _loc_6 = ["", "", "", "", ""];
            _loc_6[1] = FactionWarMapDataLang.BangZhu;
            for each (_loc_7 in param1[1])
            {
                
                _loc_3 = {};
                _loc_3.kill = _loc_7[4];
                _loc_3.fame = _loc_7[6];
                _loc_3.coin = _loc_7[5];
                _loc_3.name = _data.player.removeNickNameSuffix(_loc_7[3]) + _loc_6[_loc_7[2]];
                _loc_3.factionName = _loc_2[_loc_7[1]];
                if (_loc_7[0] == _loc_5)
                {
                    _loc_3.color = 15964160;
                    _loc_3.isb = true;
                }
                else
                {
                    _loc_3.color = _loc_4 != _loc_7[1] ? (16711680) : (16777215);
                    _loc_3.isb = false;
                }
                this.killRank.push(_loc_3);
                _loc_3.sort = _loc_3.kill * 100000 + _loc_3.fame;
            }
            this.killRank.sortOn("sort", Array.NUMERIC | Array.DESCENDING);
            return;
        }// end function

        public function notify_faction_war_over(param1:Array) : void
        {
            this.overWorldMsg = Lang.sprintf(FactionWarMapDataLang.FactionWarWinTip, "<b>" + _data.player.removeNickNameSuffix(param1[2]) + "</b>");
            this.overChatMsg = "";
            if (param1[1] == _data.player.playerInfo.factionId)
            {
                this.overChatMsg = HtmlText.yellow2(FactionWarMapDataLang.Notice) + FactionWarMapDataLang.FactionWarWinTipChat;
            }
            return;
        }// end function

        public function notify_faction_war_gift(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function get_faction_war_gift_detail(param1:Array) : void
        {
            var _loc_2:Array = null;
            this.giftList = param1[2];
            for each (_loc_2 in this.giftList)
            {
                
                _loc_2[1] = _data.player.removeNickNameSuffix(_loc_2[1]);
            }
            return;
        }// end function

        public function give_faction_war_gift(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function notify_good_faction_war_gift(param1:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_4:String = null;
            var _loc_2:Array = [];
            for each (_loc_3 in param1[4])
            {
                
                _loc_2.push(this.getLinkItem(_loc_3));
                if (_loc_3 == 1055)
                {
                    this.worldNotice.push(Lang.sprintf(FactionWarMapDataLang.OpenBaiHu, param1[2]));
                }
            }
            _loc_4 = Lang.sprintf(FactionWarMapDataLang.OpenAward, this.getLinkPlayer(param1[0], param1[2]), this.getLinkItem(param1[3]), _loc_2.join("，"));
            this.chatWorld.push(htmlFormat(FactionWarMapDataLang.Notice, 12, 16773632) + _loc_4);
            if (param1[1] == _data.player.playerInfo.factionId)
            {
                this.chatFaction.push(htmlFormat(FactionWarMapDataLang.Faction, 12, 8438377) + _loc_4);
            }
            return;
        }// end function

        public function get_versus_rank_list(param1:Array) : void
        {
            var _loc_4:Object = null;
            var _loc_6:Array = null;
            this.heroRank = [];
            var _loc_2:Array = ["", FactionWarMapDataLang.BangZhu, ""];
            var _loc_3:* = param1[0];
            var _loc_5:* = _data.player.playerInfo.id;
            for each (_loc_6 in param1[2])
            {
                
                _loc_4 = {};
                _loc_4.pId = _loc_6[0];
                _loc_4.fId = _loc_6[1];
                _loc_4.kill = _loc_6[5];
                _loc_4.name = this.getLinkPlayer2(_loc_6[0], _data.player.removeNickNameSuffix(_loc_6[4]) + _loc_2[_loc_6[3]], _loc_6[4]);
                _loc_4.factionName = _loc_6[2];
                _loc_4.coin = _loc_6[6];
                _loc_4.fame = _loc_6[7];
                _loc_4.sort = _loc_4.kill * 100000 + _loc_4.fame;
                if (_loc_3 == 0)
                {
                    _loc_3 = _loc_4.fId;
                }
                if (_loc_4.pId == _loc_5)
                {
                    _loc_4.color = 15964160;
                    _loc_4.isb = true;
                }
                else
                {
                    _loc_4.color = _loc_3 != _loc_4.fId ? (16711680) : (16777215);
                    _loc_4.isb = false;
                }
                this.heroRank.push(_loc_4);
            }
            this.heroRank.sortOn("sort", Array.NUMERIC | Array.DESCENDING);
            if (param1[1] == "")
            {
                this.heroRankTip = FactionWarMapDataLang.Waring;
            }
            else
            {
                this.heroRankTip = Lang.sprintf(FactionWarMapDataLang.WinTip, param1[1]);
            }
            return;
        }// end function

        public function notify_give_faction_war_gift(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_2:* = htmlFormat(FactionWarMapDataLang.Faction, 12, 8438377);
            for each (_loc_3 in param1[1])
            {
                
                this.chatFaction.push(_loc_2 + Lang.sprintf(FactionWarMapDataLang.GetAward, this.getLinkPlayer(_loc_3[0], _loc_3[1]), this.getLinkItem(param1[0], 1)));
            }
            return;
        }// end function

        public function get_my_faction_war(param1:Array) : void
        {
            if (param1[0] == 1)
            {
                this.signupState = 4;
                this.intoTime = getTimer() + param1[1] * 1000;
            }
            return;
        }// end function

        private function getLinkPlayer(param1:int, param2:String) : String
        {
            var _loc_3:* = TextLinkType.Player + "_" + param1 + "_" + param2;
            return "<a href=\"event:" + _loc_3 + "\"><font color=\"#fff200\"><u>" + _data.player.removeNickNameSuffix(param2) + "</u></font></a>";
        }// end function

        private function getLinkPlayer2(param1:int, param2:String, param3:String) : String
        {
            var _loc_4:* = TextLinkType.Player + "_" + param1 + "_" + param3;
            return "<a href=\"event:" + _loc_4 + "\"><u>" + param2 + "</u></a>";
        }// end function

        private function getLinkItem(param1:int, param2:int = 1) : String
        {
            var _loc_3:* = ItemType.getItemColor(param1).toString(16);
            var _loc_4:* = ItemType.getName(param1);
            var _loc_5:* = TextLinkType.Item + "_" + param1 + "_" + param2;
            return "<font color=\"#" + _loc_3 + "\"><a href=\"event:" + _loc_5 + "\"><u>" + _loc_4 + "</u></a></font>";
        }// end function

        public function get roundWarIdx() : int
        {
            return this.getRoundWar(this.warCount, this.warRound);
        }// end function

        public function get roundWarName() : String
        {
            var _loc_1:* = this.roundWarIdx;
            if (_loc_1 == 1)
            {
                return FactionWarMapDataLang.War1;
            }
            if (_loc_1 == 2)
            {
                return FactionWarMapDataLang.War2;
            }
            if (_loc_1 == 4)
            {
                return FactionWarMapDataLang.War4;
            }
            if (_loc_1 == 8)
            {
                return FactionWarMapDataLang.War8;
            }
            return "";
        }// end function

        public function getRoundWar(param1:int, param2:int) : int
        {
            while (param2 > 0)
            {
                
                if (param1 > 8)
                {
                    param1 = 8;
                }
                else if (param1 > 4)
                {
                    param1 = 4;
                }
                else if (param1 > 2)
                {
                    param1 = 2;
                }
                else if (param1 > 1)
                {
                    param1 = 1;
                }
                param2 = param2 - 1;
            }
            return param1;
        }// end function

    }
}
