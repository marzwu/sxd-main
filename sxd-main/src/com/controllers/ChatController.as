package com.controllers
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.toolbar.*;
    import com.datas.*;
    import com.haloer.data.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class ChatController extends Base
    {
        public var ownData:ChatData;

        public function ChatController()
        {
            return;
        }// end function

        public function get message() : Array
        {
            var _loc_6:int = 0;
            var _loc_1:* = this.ownData.message;
            var _loc_2:Array = [];
            var _loc_3:* = _ctrl.player.serverTime;
            var _loc_4:* = _loc_1.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_2[_loc_5] = {};
                oObject.list(_loc_1[_loc_5], _loc_2[_loc_5], ["playId", "playName", "isTester", "isStar", "msgType", "msgTxt", "eipNum", "eipIndex"]);
                _loc_6 = _loc_1[_loc_5][8];
                _loc_2[_loc_5].townKey = _loc_1[_loc_5][9];
                _loc_2[_loc_5].playerId = _loc_2[_loc_5].playId;
                _loc_2[_loc_5].serverTime = _loc_3;
                _loc_2[_loc_5].sex = RoleType.getRoleGender(_loc_6);
                _loc_2[_loc_5].showName = _ctrl.player.removeNickNameSuffix(_loc_2[_loc_5].playName);
                _loc_2[_loc_5].nickNameSuffix = _ctrl.player.removeNickNameSuffix;
                _loc_2[_loc_5].mainPlayerId = _ctrl.player.playerId;
                _loc_2[_loc_5].fileColor = _loc_2[_loc_5].isStar == 1 ? (191967) : (16777215);
                _loc_2[_loc_5].message = _loc_2[_loc_5].msgTxt;
                _loc_5++;
            }
            return _loc_2;
        }// end function

        public function get chatWithPlayers() : Array
        {
            var _loc_1:* = this.ownData.chatWithPlayers;
            return _loc_1;
        }// end function

        public function get disableTalk() : Object
        {
            var _loc_1:* = this.ownData.disableTalk;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

        public function get shieldPlayerList() : Array
        {
            var _loc_1:* = this.ownData.shieldPlayerList;
            var _loc_2:* = this.renderShieldList(_loc_1);
            return _loc_2;
        }// end function

        public function renderShieldList(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = {};
                _loc_5.playId = param1[_loc_4][0];
                _loc_5.addTime = param1[_loc_4][1];
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function get favFriendAchievementMsg() : Object
        {
            var _loc_1:* = _data.chat.favFriendAchievementMsg;
            var _loc_2:* = this.renderAchievementMsg(_loc_1);
            return _loc_2;
        }// end function

        public function get sendAll() : int
        {
            var _loc_1:* = this.ownData.SendAll;
            return _loc_1[0];
        }// end function

        public function get sendAllMessage() : Object
        {
            var _loc_1:* = this.ownData.sendAllMessage;
            var _loc_2:Object = {};
            _loc_2.result = _loc_1[0];
            _loc_2.chatData = {};
            switch(_loc_2.result)
            {
                case Mod_Chat_Base.FACTION_INVITE:
                {
                    _loc_2.chatData = this.renderInvite(_loc_1[1]);
                    break;
                }
                case Mod_Chat_Base.SPEAKER:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function renderAchievementMsg(param1:Array) : Object
        {
            var _loc_2:Object = {};
            var _loc_3:* = param1[0];
            var _loc_4:* = param1[1];
            var _loc_5:* = param1[3];
            _loc_2.title = "<font color=\"#fff200\">[" + ChatControllerLang.msg + "]</font>";
            _loc_2.isHtml = true;
            _loc_2.name = "<font color=\"#ffffff\">" + "<u>" + "<a href=\"event:" + TextLinkType.Player + "_" + _loc_3 + "_" + _loc_4 + "\">" + HtmlText.yellow(_loc_4) + "</a>" + "</u>" + ChatControllerLang.AchievementEnd + "<u>" + "<a href=\"event:" + TextLinkType.Achievement + "_" + _loc_5 + "\">" + HtmlText.yellow("【" + AchievementType.getName(_loc_5) + "】") + "</a>" + "</u>" + "</font>";
            _loc_2.msg = "";
            _loc_2.nameIcon = [];
            _loc_2.icon = [];
            return _loc_2;
        }// end function

        private function renderInvite(param1:String) : Object
        {
            var _loc_2:Object = {};
            var _loc_3:* = param1.split("_");
            var _loc_4:* = _loc_3[1];
            var _loc_5:* = _loc_3[0];
            var _loc_6:* = _loc_3[2];
            _loc_2.title = "<font color=\"#fff200\">[" + ChatControllerLang.msg + "]</font>";
            _loc_2.isHtml = true;
            _loc_2.isLostIcon = [{icon:"eip16", index:0, x:260, y:18}];
            _loc_2.name = "<font color=\"#ffffff\">" + ChatControllerLang.Faction + HtmlText.yellow("【" + _loc_4 + "】") + Lang.sprintf(ChatControllerLang.invitationNum, _loc_6) + "<u>" + "<a href=\"event:" + TextLinkType.Faction + "_" + _loc_5 + "_" + _loc_4 + "\">" + HtmlText.yellow(ChatControllerLang.Join) + "</a>" + "</u>" + "</font>";
            _loc_2.msg = "";
            _loc_2.nameIcon = [];
            _loc_2.icon = [];
            return _loc_2;
        }// end function

    }
}
