package com.controllers
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.toolbar.*;
    import com.datas.*;
    import com.haloer.data.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class FactionController extends Base
    {
        public var ownData:FactionData;
        private var _lastMainPositionTime:int = 0;
        private var _contributionList:Array;
        private var _tanHeTime:int = 604800;
        private var _isShowTanHe:Boolean = false;
        public var needIngot:int = 0;
        public var inviteTimes:int = 0;
        private var jobData:Object;
        private var objIncenseColor:Object;

        public function FactionController()
        {
            this.jobData = {0:FactionControllerLang.Position, 1:FactionControllerLang.Leader, 2:FactionControllerLang.DeputyLeader};
            this.objIncenseColor = {1:16777215, 2:44783, 3:16776960};
            return;
        }// end function

        public function get factionList() : Object
        {
            var _loc_1:* = this.ownData.factionList;
            var _loc_2:Object = {};
            _loc_2.page = _loc_1[1];
            _loc_2.allPage = _loc_1[0];
            _loc_2.list = this.renderFactionList(_loc_1[2], _loc_2.page);
            return _loc_2;
        }// end function

        public function get createFaction() : Object
        {
            var _loc_1:* = this.ownData.createFaction;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.list = _loc_1[1];
            return _loc_2;
        }// end function

        public function get factionApply() : Object
        {
            var _loc_1:* = this.ownData.factionApply;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.list = _loc_1[1];
            return _loc_2;
        }// end function

        public function get cancelApply() : Object
        {
            var _loc_1:* = this.ownData.cancelApply;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.applyId = _loc_1[1];
            return _loc_2;
        }// end function

        public function get myFactionInfo() : Object
        {
            var _loc_1:* = this._data.faction.myFactionInfo;
            var _loc_2:* = _loc_1[0].length;
            var _loc_3:Object = {};
            if (_loc_2 > 0)
            {
                _loc_3.msg = "myFaction";
                _loc_3.factionData = this.renderMyFaction(_loc_1[0][0]);
            }
            else
            {
                _loc_3.msg = "joinFaction";
            }
            return _loc_3;
        }// end function

        public function get memberList() : Array
        {
            var _loc_5:Array = null;
            var _loc_6:Object = null;
            var _loc_7:int = 0;
            var _loc_1:* = this._data.faction.memberList;
            var _loc_2:* = _loc_1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = _loc_1[_loc_4];
                _loc_6 = {};
                _loc_6.memberId = _loc_5[0];
                _loc_6.playerId = _loc_5[1];
                _loc_6.isPlayer = _loc_6.playerId == _ctrl.player.playerId;
                _loc_6.playerName = _loc_5[2];
                _loc_6.showName = _ctrl.player.removeNickNameSuffix(_loc_6.playerName);
                _loc_6.playerLevel = _loc_5[3];
                _loc_6.factionJobId = _loc_5[4];
                _loc_6.position = this.renderJob(_loc_5[5]);
                _loc_6.positionNum = _loc_5[5];
                _loc_6.contribution = _loc_5[6];
                _loc_6.todayContribution = _loc_5[7];
                _loc_6.lastLoginTime = TimeChange.timerInfo(_loc_5[8], _ctrl.player.serverTime);
                _loc_6.lastMainLoginTime = 0;
                if (_loc_6.position == FactionControllerLang.Leader)
                {
                    _loc_7 = _ctrl.player.serverTime - _loc_5[8];
                    _loc_6.lastMainLoginTime = this._tanHeTime - _loc_7;
                }
                if (_loc_5[9] == Mod_Faction_Base.YES)
                {
                    _loc_6.isOnline = 2;
                }
                else
                {
                    _loc_6.isOnline = 1;
                }
                _loc_6.sex = RoleType.getRoleGender(_loc_5[10]);
                _loc_6.sportRank = _loc_5[11];
                _loc_3.push(_loc_6);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function get applyList() : Array
        {
            var _loc_5:Array = null;
            var _loc_6:Object = null;
            var _loc_1:* = this._data.faction.applyList;
            var _loc_2:* = _loc_1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = _loc_1[_loc_4];
                _loc_6 = {};
                _loc_6.rank = _loc_4 + 1;
                _loc_6.applyId = _loc_5[0];
                _loc_6.playerId = _loc_5[1];
                _loc_6.playerName = _loc_5[2];
                _loc_6.showName = _ctrl.player.removeNickNameSuffix(_loc_6.playerName);
                _loc_6.factionId = _loc_5[3];
                _loc_6.playerLevel = _loc_5[4];
                _loc_6.reqTime = TimeChange.timerInfo(_loc_5[5], _ctrl.player.serverTime);
                _loc_6.sex = RoleType.getRoleGender(_loc_5[6]);
                _loc_6.sportRank = _loc_5[7];
                _loc_3.push(_loc_6);
                _loc_4++;
            }
            _loc_3.sortOn("playerLevel", Array.NUMERIC | Array.DESCENDING);
            return _loc_3;
        }// end function

        public function get acceptApply() : Object
        {
            var _loc_1:* = this._data.faction.acceptApply;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get kickoutMember() : Object
        {
            var _loc_1:* = this._data.faction.kickoutMember;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get denyApply() : Object
        {
            var _loc_1:* = this._data.faction.denyApply;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get cleanFactionRequest() : Object
        {
            var _loc_1:* = this._data.faction.cleanFactionRequest;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get appointJob() : Object
        {
            var _loc_1:* = this._data.faction.appointJob;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get dismissJob() : Object
        {
            var _loc_1:* = this._data.faction.dismissJob;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get transfer() : Object
        {
            var _loc_1:* = this._data.faction.transfer;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get modifyNotice() : Object
        {
            var _loc_1:* = this._data.faction.modifyNotice;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.factionData = this.renderMyFaction(_loc_1[1][0]);
            return _loc_2;
        }// end function

        public function get modifyInfo() : Object
        {
            var _loc_1:* = this._data.faction.modifyInfo;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.factionData = this.renderMyFaction(_loc_1[1][0]);
            return _loc_2;
        }// end function

        public function get disbandFaction() : Object
        {
            var _loc_1:* = this._data.faction.disbandFaction;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.id = _loc_1[1];
            return _loc_2;
        }// end function

        public function get quitFaction() : Object
        {
            var _loc_1:* = this._data.faction.quitFaction;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get foundFactionCoin() : Object
        {
            var _loc_1:* = this._data.faction.foundFactionCoin;
            var _loc_2:Object = {};
            _loc_2.coin = Lang.sprintf(FactionControllerLang.CreateFaction, _loc_1[0]);
            return _loc_2;
        }// end function

        public function get groupNumber() : Object
        {
            var _loc_1:* = this._data.faction.groupNumber;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.factionData = this.renderMyFaction(_loc_1[1][0]);
            return _loc_2;
        }// end function

        public function get contributionList() : Array
        {
            var _loc_5:Object = null;
            var _loc_6:int = 0;
            var _loc_1:Array = [];
            var _loc_2:* = this._data.faction.contributionList;
            this.sortTime(_loc_2);
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.playerId = _loc_2[_loc_4][0];
                _loc_5.nickName = _loc_2[_loc_4][1];
                _loc_5.showName = _ctrl.player.removeNickNameSuffix(_loc_5.nickName);
                _loc_5.value = _loc_2[_loc_4][2];
                _loc_6 = _loc_2[_loc_4][2];
                if (_loc_6 > 10000)
                {
                    _loc_5.value = int(_loc_6 / 10000) + FactionControllerLang.Wan;
                }
                _loc_5.time = TimeChange.timerInfo(_loc_2[_loc_4][3], _ctrl.player.serverTime);
                _loc_5.info = "<font color=\"#fff200\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + _loc_5.playerId + "_" + _loc_5.nickName + "\">" + _loc_5.showName + "</a></u></font>" + "<font color=\"#ffffff\"> " + FactionControllerLang.Get + "</font>" + "<font color=\"#00ff00\">" + _loc_5.value + FactionControllerLang.Fram + "</font>" + "<font color=\"#ffffff\">，" + FactionControllerLang.UserFram + "</font>" + "<font color=\"#00ff00\">" + _loc_5.value + FactionControllerLang.Exp + "</font>";
                _loc_1.push(_loc_5);
                _loc_4++;
            }
            return _loc_1;
        }// end function

        private function sortTime(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 1;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = 0;
                while (_loc_4 < (_loc_2 - 1))
                {
                    
                    if (param1[_loc_4][3] < param1[(_loc_4 + 1)][3])
                    {
                        _loc_5 = param1[_loc_4];
                        param1[_loc_4] = param1[(_loc_4 + 1)];
                        param1[(_loc_4 + 1)] = _loc_5;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function get factionMessage() : Object
        {
            var _loc_5:String = null;
            var _loc_1:* = _data.faction.factionMessage;
            var _loc_2:Object = {};
            _loc_2.type = _loc_1[0];
            _loc_2.playerId = _loc_1[1];
            _loc_2.nickName = _loc_1[2];
            _loc_2.showName = _ctrl.player.removeNickNameSuffix(_loc_2.nickName);
            _loc_2.offeringsId = _loc_1[3];
            _loc_2.remCount = _loc_1[4];
            _loc_2.eatFame = _loc_1[5];
            _loc_2.power = _loc_1[6];
            _loc_2.eatCount = _loc_1[7];
            _loc_2.offerings = FactionType.getOfferName(_loc_2.offeringsId);
            _loc_2.fame = FactionType.getOfferFame(_loc_2.offeringsId);
            _loc_2.color = this.objIncenseColor[_loc_2.offeringsId];
            var _loc_3:String = "";
            var _loc_4:* = "<font color=\"#fff200\">" + "<a href = \"event:" + TextLinkType.Player + "_" + _loc_2.playerId + "_" + _loc_2.nickName + "\">" + "<u>" + _loc_2.showName + "</u>" + "</a>" + "</font>";
            switch(_loc_1[0])
            {
                case Mod_Faction_Base.NEW_MEMBER:
                {
                    _loc_3 = _loc_4 + "<font color=\"#ffffff\">" + FactionControllerLang.NewMember + "</font>";
                    break;
                }
                case Mod_Faction_Base.QUIT_FACTION:
                {
                    _loc_3 = _loc_4 + "<font color=\"#ffffff\">" + FactionControllerLang.QuitFaction + "</font>";
                    break;
                }
                case Mod_Faction_Base.KICKOUT_MEMBER:
                {
                    _loc_3 = _loc_4 + "<font color=\"#ffffff\">" + FactionControllerLang.KickoutMember + "</font>";
                    break;
                }
                case Mod_Faction_Base.MASTER_TRANSFER:
                {
                    _loc_3 = _loc_4 + "<font color=\"#ffffff\">" + FactionControllerLang.MasterTransfer + "</font>";
                    break;
                }
                case Mod_Faction_Base.DISMISS_JOB:
                {
                    _loc_3 = _loc_4 + "<font color=\"#ffffff\">" + FactionControllerLang.DismissJob + "</font>";
                    break;
                }
                case Mod_Faction_Base.INCENSE:
                {
                    _loc_3 = _loc_4 + Lang.sprintf(FactionControllerLang.INCENSE, "<font color=\"#" + _loc_2.color.toString(16) + "\">" + _loc_2.offerings + "</font>", _loc_2.fame);
                    break;
                }
                case Mod_Faction_Base.APPOINT_JOB:
                {
                    _loc_3 = _loc_4 + "<font color=\"#ffffff\">" + FactionControllerLang.AppointJob + "</font>";
                    break;
                }
                case Mod_Faction_Base.CALL_SEAL_SATAN:
                {
                    _loc_5 = "<font color=\"#ffff00\">" + "<a href = \"event:" + ActivityType.FactionSeal + "\">" + "<u>" + FactionControllerLang.CallSealSatan + "</u>" + "</a>" + "</font>";
                    _loc_3 = _loc_4 + HtmlText.yellow(Lang.sprintf(FactionControllerLang.CallSealSatan1, _loc_2.remCount)) + _loc_5;
                    break;
                }
                case Mod_Faction_Base.CALL_EAT:
                {
                    _loc_3 = _loc_4 + HtmlText.white(FactionControllerLang.Summer) + HtmlText.yellow(FactionControllerLang.FactionEat) + HtmlText.white(FactionControllerLang.Get) + HtmlText.yellow(_loc_2.eatFame + FactionControllerLang.Fram);
                    break;
                }
                case Mod_Faction_Base.JOIN_EAT:
                {
                    _loc_3 = _loc_4 + HtmlText.white(FactionControllerLang.JoinEat) + HtmlText.yellow(_loc_2.power + FactionControllerLang.Power) + HtmlText.white(FactionControllerLang.And) + HtmlText.yellow(_loc_2.eatFame + FactionControllerLang.Fram);
                    break;
                }
                case Mod_Faction_Base.CALL_EAT_AEARD:
                {
                    _loc_3 = HtmlText.white(FactionControllerLang.CallEatAeard) + HtmlText.yellow(_loc_2.eatCount + FactionControllerLang.Pepore) + HtmlText.white(FactionControllerLang.Join) + "\n" + _loc_4 + HtmlText.white(FactionControllerLang.Additional) + HtmlText.yellow(_loc_2.eatFame + FactionControllerLang.Fram);
                    break;
                }
                case Mod_Faction_Base.FACTION_ROLL_CAKE:
                {
                    _loc_2.rollCakeType = _loc_1[8];
                    _loc_2.typeName = RollCakeType.getRollCakeNickName(_loc_2.rollCakeType);
                    _loc_2.score = _loc_1[9];
                    _loc_2.coin = RollCakeType.getRollCakeCoin(_loc_2.rollCakeType);
                    if (_loc_2.coin == 0)
                    {
                        _loc_3 = _loc_4 + HtmlText.white(Lang.sprintf(FactionControllerLang.RollCakeInfo, HtmlText.yellow(_loc_2.typeName), HtmlText.yellow(_loc_2.score)));
                    }
                    else
                    {
                        _loc_3 = _loc_4 + HtmlText.white(Lang.sprintf(FactionControllerLang.RollCakeInfoCoin, HtmlText.yellow(_loc_2.typeName), HtmlText.yellow(_loc_2.coin)));
                    }
                    break;
                }
                case Mod_Faction_Base.FACTION_ROLL_CAKE_SCORE_AWARD:
                {
                    _loc_2.scoreAwardStand = _loc_1[10];
                    _loc_2.scoreAward = _loc_1[11];
                    _loc_3 = Lang.sprintf(FactionControllerLang.ScoreAward, HtmlText.yellow(_loc_2.scoreAwardStand + FactionControllerLang.Score), HtmlText.yellow(_loc_2.scoreAward + FactionControllerLang.Coin));
                    break;
                }
                case Mod_Faction_Base.FACTION_ROLL_CAKE_JOIN_COUNT_AWARD:
                {
                    _loc_2.rollCakeJoinCount = _loc_1[12];
                    _loc_2.rollCakeJoinCountAwardFame = _loc_1[13];
                    _loc_3 = Lang.sprintf(FactionControllerLang.JoinCountAward, HtmlText.yellow(_loc_2.rollCakeJoinCount), HtmlText.yellow(_loc_2.rollCakeJoinCountAwardFame + FactionControllerLang.Fram));
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2.info = "<font color=\"#80c269\">[" + FactionControllerLang.Faction + "]</font>" + _loc_3;
            return _loc_2;
        }// end function

        public function get godInfo() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._data.faction.godInfo, _loc_1, ["faction_god_level", "faction_god_exp", "require_exp", "incense_count", "total_count", "is_cover"]);
            return _loc_1;
        }// end function

        public function get incenseLog() : Array
        {
            var _loc_1:Object = null;
            var _loc_3:Array = null;
            var _loc_2:Array = [];
            for each (_loc_3 in this._data.faction.godInfo[(this._data.faction.godInfo.length - 1)])
            {
                
                _loc_1 = {};
                oObject.list(_loc_3, _loc_1, ["player_id", "player_name", "incense_id", "exp", "time"]);
                _loc_1["player_name"] = this._ctrl.player.removeNickNameSuffix(_loc_1["player_name"]);
                _loc_1["incense_name"] = FactionType.getOfferName(_loc_1["incense_id"]);
                _loc_1["color"] = this.objIncenseColor[_loc_1["incense_id"]];
                _loc_1["chinese_time"] = DateTime.formatFromSecond2(_loc_1["time"], this._ctrl.player.serverTime);
                _loc_2.push(_loc_1);
            }
            _loc_2.sort(this.sortByTime);
            return _loc_2;
        }// end function

        public function get incense() : Object
        {
            var _loc_1:Object = {result:this._data.faction.factionIncense};
            return _loc_1;
        }// end function

        public function get blessingCount() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._data.faction.blessingCount, _loc_1, ["count", "coin_add"]);
            return _loc_1;
        }// end function

        private function sortByTime(param1:Object, param2:Object) : int
        {
            var _loc_3:* = param1["time"];
            var _loc_4:* = param2["time"];
            if (_loc_3 < _loc_4)
            {
                return 1;
            }
            if (_loc_3 > _loc_4)
            {
                return -1;
            }
            return 0;
        }// end function

        public function get joinSealSatan() : Object
        {
            var _loc_1:Object = {result:this._data.faction.joinSealSatan[0]};
            return _loc_1;
        }// end function

        public function get sealSatanCallNpc() : Object
        {
            var _loc_1:Object = {result:this._data.faction.sealSatanCallNpc[0]};
            return _loc_1;
        }// end function

        public function get sealSatanJoinNotify() : Array
        {
            return this.setSealMemberList(this._data.faction.sealSatanJoinNotify[0]);
        }// end function

        public function get sealSatanCallFactionMember() : Object
        {
            var _loc_1:Object = {result:this._data.faction.sealSatanCallFactionMember[0]};
            return _loc_1;
        }// end function

        public function get sealSatanInfo() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._data.faction.sealSatanInfo, _loc_1, ["is_complete_seal", "is_in_seal", "join_member_count", "max_join_count"]);
            return _loc_1;
        }// end function

        public function get sealSatanAwardNotify() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._data.faction.sealSatanAwardNotify, _loc_1, ["result", "award_fame"]);
            return _loc_1;
        }// end function

        public function get sealSatanMemberList() : Array
        {
            return this.setSealMemberList(this._data.faction.sealSatanMemberList[0]);
        }// end function

        private function setSealMemberList(param1:Array) : Array
        {
            var _loc_2:Object = null;
            var _loc_4:Array = null;
            var _loc_3:Array = [];
            for each (_loc_4 in param1)
            {
                
                _loc_2 = {};
                oObject.list(_loc_4, _loc_2, ["id", "name", "role_id", "join_time", "is_joined"]);
                _loc_2["name"] = this._ctrl.player.removeNickNameSuffix(_loc_2["name"]);
                _loc_2["url"] = URI.iconsUrl + RoleType.getRoleSign(_loc_2["role_id"]) + ".png";
                _loc_3.push(_loc_2);
            }
            _loc_3.sortOn("join_time", Array.NUMERIC);
            return _loc_3;
        }// end function

        public function get callEatInfo() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._data.faction.callEatInfo, _loc_1, ["is_join", "rem_count", "rem_time"]);
            return _loc_1;
        }// end function

        public function get callEat() : Object
        {
            var _loc_1:Object = {result:this._data.faction.callEat[0]};
            return _loc_1;
        }// end function

        public function get callEatDetailedInfo() : Object
        {
            var _loc_1:Object = {};
            oObject.list(this._data.faction.callEatDetailedInfo, _loc_1, ["player_id", "nick_name", "rem_time", "is_join"]);
            _loc_1["nick_name"] = this._ctrl.player.removeNickNameSuffix(_loc_1["nick_name"]);
            return _loc_1;
        }// end function

        public function get joinEat() : Object
        {
            var _loc_1:Object = {result:this._data.faction.joinEat[0]};
            return _loc_1;
        }// end function

        public function get isCanJoinActivity() : Object
        {
            var _loc_1:Object = {result:this._data.faction.isCanJoinActivity[0]};
            return _loc_1;
        }// end function

        public function get factionMasterTracel() : Object
        {
            var _loc_1:* = _data.faction.factionMasterTracel;
            var _loc_2:Object = {};
            _loc_2.loginTime = _loc_1[0];
            _loc_2.offineTime = _loc_1[1];
            _loc_2.nowTime = _loc_1[2];
            _loc_2.isOnline = _loc_1[3];
            _loc_2.showTanHe = this._isShowTanHe;
            if (_loc_2.isOnline == Mod_Faction_Base.NO && _loc_2.nowTime - _loc_2.offineTime >= this._tanHeTime && _loc_2.nowTime - _loc_2.loginTime >= this._tanHeTime)
            {
            }
            return _loc_2;
        }// end function

        public function get seizeTheThrone() : Object
        {
            var _loc_1:* = _data.faction.seizeTheThrone;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        private function renderFactionList(param1:Array, param2:int) : Array
        {
            var _loc_6:Object = null;
            var _loc_3:Array = [];
            var _loc_4:* = param1.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = {};
                _loc_6.id = param1[_loc_5][0];
                _loc_6.name = param1[_loc_5][1];
                _loc_6.masterId = param1[_loc_5][2];
                _loc_6.master = param1[_loc_5][3];
                _loc_6.level = param1[_loc_5][4];
                _loc_6.maxPerson = param1[_loc_5][5];
                _loc_6.minPerson = param1[_loc_5][6];
                _loc_6.exp = param1[_loc_5][7];
                _loc_6.requireExp = param1[_loc_5][8];
                _loc_6.info = param1[_loc_5][9];
                _loc_6.applyId = param1[_loc_5][10];
                _loc_6.rank = _loc_5 + 1;
                if (_loc_6.applyId != 0)
                {
                    _loc_6.applyBool = true;
                }
                else
                {
                    _loc_6.applyBool = false;
                }
                _loc_3.push(_loc_6);
                _loc_5++;
            }
            return _loc_3;
        }// end function

        private function renderMyFaction(param1:Array) : Object
        {
            if (param1 == null)
            {
                return {};
            }
            var _loc_2:Object = {};
            _loc_2.factionId = param1[0];
            _loc_2.factionName = param1[1];
            _loc_2.masterId = param1[2];
            _loc_2.master = param1[3];
            _loc_2.level = param1[4];
            _loc_2.maxPerson = param1[5];
            _loc_2.minPerson = param1[6];
            _loc_2.exp = param1[7];
            _loc_2.requireExp = param1[8];
            _loc_2.desc = param1[9];
            _loc_2.notice = param1[10];
            _loc_2.position = this.renderJob(param1[11]);
            _loc_2.groupNumber = param1[12];
            _loc_2.rank = param1[13];
            _loc_2.nowWeekCon = param1[14];
            return _loc_2;
        }// end function

        public function get rollCakeReamain() : Object
        {
            var _loc_1:* = _data.faction.RollCakeReamain;
            var _loc_2:Object = {};
            _loc_2.remainTimes = _loc_1[0];
            return _loc_2;
        }// end function

        public function get rollCakeInfo() : Object
        {
            var _loc_1:* = _data.faction.RollCakeInfo;
            var _loc_2:Object = {};
            _loc_2.weekBestScore = _loc_1[0];
            _loc_2.todayBestScore = _loc_1[1];
            _loc_2.remainTimes = _loc_1[2];
            _loc_2.factionScore = _loc_1[3];
            _loc_2.factionRCInfo = this.renderFactionRollCakeInfo(_loc_1[4]);
            return _loc_2;
        }// end function

        private function renderFactionRollCakeInfo(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = {};
                _loc_5.playerId = param1[_loc_4][0];
                _loc_5.isMain = _loc_5.playerId == _ctrl.player.playerId;
                _loc_5.color = _loc_5.isMain == true ? (HtmlText.Orange) : (HtmlText.White);
                _loc_5.nickName = _ctrl.player.removeNickNameSuffix(param1[_loc_4][1]);
                _loc_5.score = param1[_loc_4][2];
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function get RollCake() : Object
        {
            var _loc_6:Object = null;
            var _loc_1:* = _data.faction.RollCake;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.type = _loc_1[1];
            _loc_2.typeName = RollCakeType.getRollCakeNickName(_loc_2.type);
            _loc_2.coin = RollCakeType.getRollCakeCoin(_loc_2.type);
            _loc_2.score = _loc_1[2];
            _loc_2.todayScore = _loc_1[3];
            _loc_2.numList = [];
            var _loc_3:* = _loc_1[4];
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = {};
                _loc_6.id = _loc_5 + 1;
                _loc_6.num = _loc_3[_loc_5][0];
                _loc_2.numList.push(_loc_6);
                _loc_5++;
            }
            this.sortSZNum(_loc_2.numList);
            return _loc_2;
        }// end function

        private function sortSZNum(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 1;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = 0;
                while (_loc_4 < (_loc_2 - 1))
                {
                    
                    if (param1[_loc_4]["num"] < param1[(_loc_4 + 1)]["num"])
                    {
                        _loc_5 = param1[_loc_4];
                        param1[_loc_4] = param1[(_loc_4 + 1)];
                        param1[(_loc_4 + 1)] = _loc_5;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function get getFactionLevel() : int
        {
            var _loc_1:* = _data.faction.getFactionLevel;
            var _loc_2:* = _loc_1[0];
            return _loc_2;
        }// end function

        public function get inviteInfo() : Object
        {
            var _loc_1:* = _data.faction.InviteInfo;
            var _loc_2:Object = {};
            _loc_2.factionId = _loc_1[0];
            _loc_2.inviteTimes = _loc_1[1];
            _loc_2.needIngot = _loc_1[2];
            this.needIngot = _loc_2.needIngot;
            this.inviteTimes = _loc_2.inviteTimes;
            return _loc_2;
        }// end function

        private function renderJob(param1:int) : String
        {
            var _loc_2:String = "";
            _loc_2 = this.jobData[param1];
            return _loc_2;
        }// end function

    }
}
