package com.controllers
{
    import com.assist.*;
    import com.assist.server.*;
    import com.datas.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class FriendController extends Base
    {
        public var ownData:FriendData;
        private var _friendList:Array;
        public var showChatId:int = 0;
        private var _getListeners:Object;
        private var _sendColor:uint = 39423;

        public function FriendController()
        {
            return;
        }// end function

        public function addFriend() : Object
        {
            var _loc_1:* = this.ownData.addFriend;
            return this.renderAddFriend(_loc_1);
        }// end function

        public function addBlack() : Object
        {
            var _loc_1:* = this.ownData.addBlack;
            return this.renderAddFriend(_loc_1);
        }// end function

        public function deleteFriend() : Object
        {
            var _loc_1:* = this.ownData.deleteFriend;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get getGroup() : Object
        {
            var _loc_1:* = this.ownData.getGroup;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function moveFriend() : Object
        {
            var _loc_1:* = this.ownData.moveFriend;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function updateSignature() : Object
        {
            var _loc_1:* = this.ownData.updateSignature;
            return _loc_1;
        }// end function

        public function getFriendList() : Array
        {
            var _loc_1:* = this.ownData.getFriendList;
            return this.renderFriendList(_loc_1[0]);
        }// end function

        public function getFriendInfo() : Object
        {
            var _loc_1:* = this.ownData.getFriendInfo;
            var _loc_2:Object = {};
            _loc_2.humor = _loc_1[0];
            _loc_2.level = _loc_1[1] + FriendControllerLang.Ji;
            _loc_2.job = _loc_1[2];
            _loc_2.roleId = RoleType.getRoleId(_loc_2.job);
            _loc_2.signUrl = URI.getRoleIconUrl(_loc_2.job);
            _loc_2.fation = _loc_1[3];
            _loc_2.camp = _loc_1[4];
            _loc_2.id = _loc_1[5];
            _loc_2.AudienceNum = _loc_1[6];
            return _loc_2;
        }// end function

        public function getPlayerInfo() : Object
        {
            var _loc_1:* = this.ownData.getPlayerinfo;
            return this.renderPlayerInfo(_loc_1);
        }// end function

        public function messageCount() : Object
        {
            var _loc_1:* = this.ownData.messageCount;
            var _loc_2:Object = {};
            _loc_2.id = _loc_1[0];
            _loc_2.msgNum = _loc_1[1];
            return _loc_2;
        }// end function

        public function onlineState() : Object
        {
            var _loc_1:* = this.ownData.onlineState;
            var _loc_2:Object = {};
            _loc_2.id = _loc_1[0];
            if (_loc_1[1] == Mod_Friend_Base.ENTRY)
            {
                _loc_2.isOnLine = true;
            }
            else
            {
                _loc_2.isOnLine = false;
            }
            return _loc_2;
        }// end function

        private function renderPlayerInfo(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.name = _ctrl.player.nickname;
            _loc_2.job = param1[1];
            var _loc_3:* = MissionType.getMissionDataByMissionId(param1[2]);
            _loc_2.mission = _loc_3["townName"] + _loc_3["minTownNum"];
            _loc_2.signUrl = URI.getRoleIconUrl(_loc_2.job);
            _loc_2.AudienceNum = param1[3];
            return _loc_2;
        }// end function

        private function renderAddFriend(param1:Array) : Object
        {
            var _loc_2:Object = {};
            var _loc_3:String = "";
            _loc_2.bool = false;
            switch(param1[0])
            {
                case Mod_Friend_Base.ADD_SUCCESS:
                {
                    _loc_2.bool = true;
                    _loc_3 = FriendControllerLang.AddSuccess;
                    break;
                }
                case Mod_Friend_Base.FRIEND_NOT_FOUND:
                {
                    _loc_3 = FriendControllerLang.FriendNotFound;
                    break;
                }
                case Mod_Friend_Base.ADD_SELF:
                {
                    _loc_3 = FriendControllerLang.AddSelf;
                    break;
                }
                case Mod_Friend_Base.EXIST_IN_FRIENDGROUP:
                {
                    _loc_3 = FriendControllerLang.ExistInFriendFroup;
                    break;
                }
                case Mod_Friend_Base.EXIST_IN_BLACKLISTGROUP:
                {
                    _loc_3 = FriendControllerLang.ExistInBlackListgroup;
                    break;
                }
                case Mod_Friend_Base.FRIENDGROUP_GT_UPPER_LIMIT:
                {
                    _loc_3 = FriendControllerLang.FriendGroupGtUpperLimit;
                    break;
                }
                case Mod_Friend_Base.FUNCTION_NO_OPEN:
                {
                    _loc_3 = FriendControllerLang.FunctionNoOpen;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2.info = _loc_3;
            _loc_2.msg = param1[0];
            return _loc_2;
        }// end function

        private function renderFriendList(param1:Array) : Array
        {
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            this._friendList = [];
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = {};
                _loc_4.id = param1[_loc_3][0];
                _loc_4.msgNum = param1[_loc_3][2];
                if (_loc_4.msgNum > 0 && this.showChatId == 0)
                {
                    this.showChatId = _loc_4.id;
                    _loc_4.msgNum = 0;
                }
                _loc_4.name = param1[_loc_3][1];
                _loc_4.showName = _ctrl.player.removeNickNameSuffix(_loc_4.name);
                if (param1[_loc_3][3] == Mod_Friend_Base.ONLINE)
                {
                    _loc_4.onLine = true;
                    _loc_4.tempOnLine = true;
                }
                else
                {
                    if (_loc_4.msgNum > 0)
                    {
                        _loc_4.onLine = true;
                    }
                    else
                    {
                        _loc_4.onLine = false;
                    }
                    _loc_4.tempOnLine = false;
                }
                _loc_4.missionId = param1[_loc_3][4];
                if (param1[_loc_3][4] <= 0)
                {
                    _loc_4.missionId = 1;
                }
                _loc_5 = MissionType.getMissionDataByMissionId(_loc_4.missionId);
                _loc_4.mission = "(" + _loc_5["townName"] + _loc_5["minTownNum"] + ")";
                _loc_4.lock = _loc_5["lock"];
                _loc_4.isGm = param1[5] == 3;
                _loc_4.isStart = param1[6] == 1;
                _loc_4.msgColor = _loc_4.isStart == true ? (191967) : (16777215);
                if (_loc_4.isGm)
                {
                    _loc_4.nameColor = 16773376;
                    _loc_4.missionColor = 16773376;
                    _loc_4.mission = "(GM)";
                }
                else
                {
                    if (_loc_4.onLine == false)
                    {
                        _loc_4.nameColor = 10066329;
                    }
                    else
                    {
                        _loc_4.nameColor = 16777215;
                    }
                    _loc_4.missionColor = 16737843;
                }
                _loc_4.vipLevel = param1[_loc_3][7];
                _loc_4.sex = RoleType.getRoleGender(param1[_loc_3][8]);
                _loc_4.isFavourite = param1[_loc_3][9] == 1;
                this._friendList.push(_loc_4);
                _loc_3++;
            }
            return this._friendList;
        }// end function

        public function get getListeners() : Object
        {
            var _loc_1:* = this.ownData.getListeners;
            var _loc_2:Object = {};
            _loc_2.totalPage = _loc_1[0];
            _loc_2.pageCurrent = _loc_1[1];
            _loc_2.listenerList = this.renderListenersList(_loc_1[2]);
            return _loc_2;
        }// end function

        private function renderListenersList(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = {};
                _loc_5.id = param1[_loc_4][0];
                _loc_5.name = param1[_loc_4][1];
                _loc_5.showName = _ctrl.player.removeNickNameSuffix(_loc_5.name);
                _loc_5.msgNum = param1[_loc_4][2];
                if (param1[_loc_4][3] == Mod_Friend_Base.ONLINE)
                {
                    _loc_5.onLine = true;
                    _loc_5.tempOnLine = true;
                }
                else
                {
                    if (_loc_5.msgNum > 0)
                    {
                        _loc_5.onLine = true;
                    }
                    else
                    {
                        _loc_5.onLine = false;
                    }
                    _loc_5.tempOnLine = false;
                }
                _loc_5.missionId = param1[_loc_4][4];
                if (param1[_loc_4][4] <= 0)
                {
                    _loc_5.missionId = 1;
                }
                _loc_6 = MissionType.getMissionDataByMissionId(_loc_5.missionId);
                _loc_5.mission = "(" + _loc_6["townName"] + _loc_6["minTownNum"] + ")";
                _loc_5.lock = _loc_6["lock"];
                _loc_5.nameColor = 16777215;
                _loc_5.missionColor = 16737843;
                _loc_5.sex = RoleType.getRoleGender(param1[_loc_4][5]);
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function get getFriendinfoChatrecordList() : Object
        {
            var _loc_1:* = this.ownData.getFriendinfoChatrecordList;
            var _loc_2:* = this.renderPlayerData(_loc_1);
            return _loc_2;
        }// end function

        private function renderPlayerData(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.playerId = param1[0];
            _loc_2.level = param1[1];
            _loc_2.name = param1[2];
            _loc_2.showName = _ctrl.player.removeNickNameSuffix(_loc_2.name);
            _loc_2.mission = param1[3];
            _loc_2.roleSign = param1[4];
            _loc_2.onLine = param1[5] == Mod_Friend_Base.ONLINE;
            _loc_2.tempOnLine = _loc_2.onLine;
            _loc_2.isGm = PlayerType.isGM(param1[6]);
            _loc_2.isStartFriend = PlayerType.isStar(param1[7]);
            _loc_2.isStart = _ctrl.player.isStartAccount;
            _loc_2.chatRecordList = this.renderChatRecord(param1[8], param1[2], _loc_2.isStart, _loc_2.isStartFriend);
            if (_loc_2.isGm)
            {
                _loc_2.url = URI.getRoleIconUrl("GM");
            }
            else
            {
                _loc_2.url = URI.getRoleIconUrl(_loc_2.roleSign);
            }
            return _loc_2;
        }// end function

        private function renderChatRecord(param1:Array, param2:String, param3:Boolean, param4:Boolean) : Array
        {
            var _loc_8:Object = null;
            var _loc_5:Array = [];
            var _loc_6:* = param1.length;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_8 = {};
                _loc_8.id = param1[_loc_7][0];
                _loc_8.playerId = _loc_8.id;
                _loc_8.serverTime = _ctrl.player.serverTime;
                if (_loc_8.id == _data.player.playerId)
                {
                    _loc_8.color = "0xF39800";
                    _loc_8.name = _data.player.nickname;
                    _loc_8.msgColor = param3 == true ? (191967) : (16777215);
                    _loc_8.isPlayer = true;
                }
                else
                {
                    _loc_8.color = this._sendColor;
                    _loc_8.name = param2;
                    _loc_8.msgColor = param4 == true ? (191967) : (16777215);
                    _loc_8.isPlayer = false;
                }
                _loc_8.showName = _ctrl.player.removeNickNameSuffix(_loc_8.name);
                _loc_8.message = param1[_loc_7][1];
                _loc_8.eipNum = param1[_loc_7][2];
                _loc_8.eipIndex = param1[_loc_7][3];
                _loc_8.timeStamp = param1[_loc_7][4];
                _loc_8.favMsgData = this.renderFavMsg([param1[_loc_7][5], param1[_loc_7][6]]);
                _loc_8.isAchievement = _loc_8.favMsgData.type == Mod_Friend_Base.ACHIEVEMENT;
                if (_loc_8.isAchievement)
                {
                    _loc_8.message = _loc_8.favMsgData.msg;
                }
                _loc_8.diffTime = _ctrl.player.serverTime - _loc_8.timeStamp;
                _loc_5.push(_loc_8);
                _loc_7++;
            }
            return _loc_5;
        }// end function

        public function get sendMessageToFriend() : Object
        {
            var _loc_1:* = this.ownData.sendMessageToFriend;
            var _loc_2:* = this.renderSendMessage(_loc_1);
            return _loc_2;
        }// end function

        private function renderSendMessage(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.msg = param1[0];
            _loc_2.id = param1[1];
            if (_loc_2.id == _data.player.playerId)
            {
                _loc_2.color = "0xF39800";
                _loc_2.isPlayer = true;
            }
            else
            {
                _loc_2.color = this._sendColor;
                _loc_2.isPlayer = false;
            }
            _loc_2.name = param1[2];
            _loc_2.showName = _ctrl.player.removeNickNameSuffix(_loc_2.name);
            _loc_2.isStart = _ctrl.player.isStartAccount;
            _loc_2.msgColor = _loc_2.isStart == true ? (191967) : (16777215);
            _loc_2.playerId = param1[3];
            _loc_2.message = param1[4];
            _loc_2.eipNum = param1[5];
            _loc_2.eipIndex = param1[6];
            _loc_2.timeStamp = param1[7];
            _loc_2.serverTime = _ctrl.player.serverTime;
            _loc_2.favMsgData = this.renderFavMsg([param1[8], param1[9]]);
            _loc_2.isAchievement = _loc_2.favMsgData.type == Mod_Friend_Base.ACHIEVEMENT;
            if (_loc_2.isAchievement)
            {
                _loc_2.message = _loc_2.favMsgData.msg;
            }
            return _loc_2;
        }// end function

        private function renderFavMsg(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.type = param1[0];
            _loc_2.msgId = param1[1];
            _loc_2.msg = "";
            if (_loc_2.type == Mod_Friend_Base.ACHIEVEMENT)
            {
                _loc_2.sign = AchievementType.getName(_loc_2.msgId);
                _loc_2.msg = "【" + _loc_2.sign + "】";
            }
            return _loc_2;
        }// end function

        private function formatSendmsg(param1:Array) : Object
        {
            var _loc_2:Object = {fromId:param1[1], label:param1[2], msg:param1[3], eNum:param1[4], eIndex:param1[5]};
            return _loc_2;
        }// end function

        public function get receiveMessageFromFriend() : Object
        {
            var _loc_1:* = this.ownData.receiveMessageFromFriend;
            var _loc_2:* = this.renderReceiveMessage(_loc_1);
            return _loc_2;
        }// end function

        private function renderReceiveMessage(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.playerId = param1[0];
            if (_loc_2.playerId == _data.player.playerId)
            {
                _loc_2.isPlayer = true;
            }
            else
            {
                _loc_2.isPlayer = false;
            }
            _loc_2.name = param1[1];
            _loc_2.isGm = PlayerType.isGM(param1[2]);
            _loc_2.isStart = PlayerType.isStar(param1[3]);
            _loc_2.msgColor = _loc_2.isStart == true ? (191967) : (16777215);
            _loc_2.showName = _ctrl.player.removeNickNameSuffix(_loc_2.name);
            _loc_2.color = this._sendColor;
            _loc_2.message = param1[4];
            _loc_2.serverTime = _ctrl.player.serverTime;
            _loc_2.eipNum = param1[5];
            _loc_2.eipIndex = param1[6];
            _loc_2.timeStamp = param1[7];
            _loc_2.favMsgData = this.renderFavMsg([param1[8], param1[9]]);
            _loc_2.isAchievement = _loc_2.favMsgData.type == Mod_Friend_Base.ACHIEVEMENT;
            if (_loc_2.isAchievement)
            {
                _loc_2.message = _loc_2.favMsgData.msg;
            }
            return _loc_2;
        }// end function

        public function checkMsg() : Object
        {
            var _loc_1:* = this.ownData.checkReceiveMessage;
            return _loc_1;
        }// end function

        public function get getUnreceiveFriendList() : Array
        {
            return this.ownData.getUnreceiveFriendList;
        }// end function

        public function set clearPlayerId(param1:int) : void
        {
            this.ownData.clearUnreceiveId = param1;
            return;
        }// end function

        public function get messageBoxList() : Array
        {
            var _loc_5:Object = null;
            var _loc_1:* = _data.friend.messageBoxList;
            var _loc_2:Array = [];
            var _loc_3:* = _loc_1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = this.renderReceiveMessage(_loc_1[_loc_4]);
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get receiveFriendEnterState() : Object
        {
            var _loc_1:* = this.ownData.receiveFriendEnterState;
            var _loc_2:Object = {};
            _loc_2.friendId = _loc_1[0];
            _loc_2.state = _loc_1[1];
            return _loc_2;
        }// end function

        public function get addFriendById() : Object
        {
            var _loc_1:* = this.ownData.addFriendById;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get addFavouriteFriend() : int
        {
            var _loc_1:* = this.ownData.addFavouriteFriend;
            return _loc_1[0];
        }// end function

        public function get cancelFavouriteFriend() : int
        {
            var _loc_1:* = this.ownData.cancelFavouriteFriend;
            return _loc_1[0];
        }// end function

    }
}
