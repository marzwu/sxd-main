package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.toolbar.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ChatView extends Base implements IView
    {
        private var _tempChatData:Object;
        public var serverOpenTime:int = 0;
        private var _postList:Array;
        private var _chat:IChat;
        public var chatType:int = 1;
        private var _showNum:int = 0;
        private var _shieldTackId:int = 0;
        private var _isShieldPlayer:Boolean = false;
        private var _disableTalkId:int = 0;
        public var onPassClick:Function;

        public function ChatView()
        {
            this.onPassClick = new Function();
            return;
        }// end function

        public function chat_with_players(param1:Object, param2:Function) : void
        {
            var _loc_3:String = null;
            if (param1.messageType == Mod_Chat_Base.ACTIVITY)
            {
                _loc_3 = TownType.getSign(_ctrl.player.mapId);
                if (_loc_3 == TownType.ZhuQueFactionWar || _loc_3 == TownType.XuanWuFactionWar || _loc_3 == TownType.QingLongFactionWar || _loc_3 == TownType.BaiHuFactionWar)
                {
                    param1.messageType = Mod_Chat_Base.FACTION_WAR;
                }
            }
            this._tempChatData = param1;
            _data.call(Mod_Chat_Base.chat_with_players, param2, [param1.messageType, param1.message, param1.eipNum, param1.eipIndex]);
            return;
        }// end function

        private function bro_to_players() : void
        {
            _data.patch(Mod_Chat_Base.bro_to_players, this.broToPlayersCallback);
            return;
        }// end function

        private function disable_player_talk(param1:int) : void
        {
            _data.call(Mod_Chat_Base.disable_player_talk, this.disableTalkCallback, [param1]);
            return;
        }// end function

        private function get_affiche_list() : void
        {
            _data.call(Mod_Player_Base.get_affiche_list, this.callbackPostData, []);
            _data.patch(Mod_Player_Base.get_affiche_list, this.callbackPostData);
            return;
        }// end function

        private function get_warning_affiche() : void
        {
            _data.call(Mod_Player_Base.get_warning_affiche, this.callbackWarningAffiche, []);
            _data.patch(Mod_Player_Base.get_warning_affiche, this.callbackWarningAffiche);
            return;
        }// end function

        public function resetPatchChat() : void
        {
            this.patchChat(this.broToPlayersCallback);
            return;
        }// end function

        public function patchChat(param1:Function) : void
        {
            _data.patch(Mod_Chat_Base.bro_to_players, param1);
            return;
        }// end function

        public function fav_friend_achievement_msg() : void
        {
            _data.patch(Mod_Chat_Base.fav_friend_achievement_msg, this.achievementMsgCallBack);
            return;
        }// end function

        public function send_all(param1:int, param2:String, param3:String = "", param4:String = "") : void
        {
            _data.call(Mod_Chat_Base.send_all, this.sendAllCallBack, [param1, param2, param3, param4]);
            return;
        }// end function

        public function send_all_message() : void
        {
            _data.patch(Mod_Chat_Base.send_all_message, this.sendAllMessageCallBack);
            return;
        }// end function

        public function sendAllCallBack() : void
        {
            var _loc_1:* = _ctrl.chat.sendAll;
            if (_loc_1 == Mod_Chat_Base.SUCCESS)
            {
                _view.showTip(ChatViewLang.inviteInfo, null, TipType.Success);
                _view.myFaction.invite_info();
            }
            else
            {
                _view.showTip(ChatViewLang.noIngot);
            }
            return;
        }// end function

        public function sendAllMessageCallBack() : void
        {
            var _loc_1:* = _ctrl.chat.sendAllMessage;
            if (this.inStage == false)
            {
                return;
            }
            if (_loc_1.result == Mod_Chat_Base.FACTION_INVITE)
            {
                if (FunctionType.isOpened(FunctionType.Faction) == false)
                {
                    return;
                }
            }
            this._chat.getLaBaData(_loc_1.chatData);
            return;
        }// end function

        private function chatWithPlayersCallback() : void
        {
            var _loc_1:Array = null;
            var _loc_2:String = null;
            var _loc_3:String = null;
            var _loc_4:Object = null;
            _loc_1 = this._ctrl.chat.chatWithPlayers;
            switch(_loc_1[1])
            {
                case Mod_Chat_Base.TIME_DIFF:
                {
                    _view.showTip(ChatViewLang.UnderTheRest);
                    break;
                }
                case Mod_Chat_Base.DISABLE:
                {
                    _loc_2 = TimeChange.mainTimerDate(_loc_1[0]);
                    _loc_3 = ChatViewLang.InGag;
                    _loc_4 = {};
                    _loc_4.eipIndex = this._tempChatData.eipIndex;
                    _loc_4.eipNum = this._tempChatData.eipNum;
                    _loc_4.msgTxt = this._tempChatData.message;
                    _loc_4.msgType = this._tempChatData.messageType;
                    _loc_4.playId = _ctrl.player.playerId;
                    _loc_4.playName = _ctrl.player.nickname;
                    _loc_4.showName = _ctrl.player.nickname;
                    _loc_4.serverTime = _ctrl.player.serverTime;
                    _loc_4.sex = RoleType.getRoleGender(_ctrl.player.mainRoleId);
                    _loc_4.nickNameSuffix = _ctrl.player.removeNickNameSuffix;
                    _loc_4.fileColor = _ctrl.player.playerInfo.starUser == 1 ? (191967) : (16777215);
                    this._chat.getChatData = [_loc_4];
                    this._chat.getTownPlaySay = [_loc_4];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function broToPlayersCallback() : void
        {
            var _loc_4:Array = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_1:* = this._ctrl.chat.message;
            var _loc_2:* = this.factionWar(_loc_1);
            if (_loc_2.length <= 0)
            {
                return;
            }
            var _loc_3:* = _loc_1[0];
            if (_loc_3.message.substr(0, 11) == TextLinkType.NineRegions)
            {
                _loc_4 = _loc_3.message.split("_");
                if (_loc_4.length == 7)
                {
                    _loc_5 = _view.nineRegionsMap.getChatViewStr(_loc_4);
                    this.sendInfo(_loc_5, false, Mod_Chat_Base.FACTION);
                    return;
                }
            }
            if (_loc_3.message.substr(0, 15) == TextLinkType.BeelzebubTrials)
            {
                _loc_4 = _loc_3.message.split("_");
                if (_loc_4.length == 6)
                {
                    _loc_6 = _view.beelzebubTrialsMap.getChatViewStr(_loc_4);
                    this.sendInfo(_loc_6, false, Mod_Chat_Base.FACTION);
                    return;
                }
            }
            if (AllChatLimit.forCN(_loc_3))
            {
                return;
            }
            this._chat.getChatData = _loc_2;
            this._chat.getTownPlaySay = _loc_2;
            return;
        }// end function

        private function factionWar(param1:Array) : Array
        {
            var _loc_3:int = 0;
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            var _loc_2:* = TownType.getSign(_ctrl.player.mapId);
            if (_loc_2 == TownType.ZhuQueFactionWar || _loc_2 == TownType.XuanWuFactionWar || _loc_2 == TownType.QingLongFactionWar || _loc_2 == TownType.BaiHuFactionWar)
            {
                _loc_3 = param1.length;
                _loc_4 = [];
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    _loc_6 = param1[_loc_5];
                    if (_loc_6.msgType != Mod_Chat_Base.ACTIVITY)
                    {
                        if (_loc_6.msgType == Mod_Chat_Base.FACTION_WAR)
                        {
                            _loc_6.msgType = Mod_Chat_Base.ACTIVITY;
                        }
                        _loc_4.push(_loc_6);
                    }
                    _loc_5++;
                }
                return _loc_4;
            }
            return param1;
        }// end function

        private function disableTalkCallback() : void
        {
            var _loc_1:* = this._ctrl.chat.disableTalk;
            if (_loc_1.msg == Mod_Chat_Base.SUCCESS)
            {
                _view.showTip(ChatViewLang.GagSuccess, null, TipType.Success);
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function callbackPostData() : void
        {
            var _loc_1:* = this._ctrl.player.afficheList;
            this._chat.getReceivePostList = _loc_1;
            this.reposition(false);
            return;
        }// end function

        private function callbackWarningAffiche() : void
        {
            var _loc_1:* = this._ctrl.player.warningAffiche;
            this.getPunishmentPost(_loc_1);
            this.abnormalTime();
            return;
        }// end function

        public function getPunishmentPost(param1:String) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._chat.getPunishmentPostList = param1;
            this.reposition(false);
            return;
        }// end function

        private function updateCallBack() : void
        {
            this.get_affiche_list();
            this.get_warning_affiche();
            return;
        }// end function

        public function set visiblePost(param1:Boolean) : void
        {
            if (this._chat == null)
            {
                return;
            }
            this._chat.visiblePost = param1;
            return;
        }// end function

        public function achievementMsgCallBack() : void
        {
            var _loc_1:* = _ctrl.chat.favFriendAchievementMsg;
            if (this.inStage == false)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.Achievement) == false)
            {
                return;
            }
            this._chat.getLaBaData(_loc_1);
            return;
        }// end function

        public function labaInfo(param1:String) : void
        {
            var _loc_2:Object = {};
            _loc_2.title = "";
            _loc_2.isHtml = true;
            _loc_2.name = param1;
            _loc_2.msg = "";
            _loc_2.nameIcon = [];
            _loc_2.icon = [];
            this._chat.getLaBaData(_loc_2);
            return;
        }// end function

        private function renderMsg(param1:Object) : void
        {
            switch(param1.msg)
            {
                case Mod_Chat_Base.NORIGHT:
                {
                    _view.showTip(ChatViewLang.NoRight);
                    break;
                }
                case Mod_Chat_Base.ISTESTER:
                {
                    _view.showTip(ChatViewLang.IsTester);
                    break;
                }
                case Mod_Chat_Base.DISABLED:
                {
                    _view.showTip(ChatViewLang.Disabled);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function changeChannel(param1:int = 99) : void
        {
            this._chat.changeChat = param1;
            return;
        }// end function

        public function showMsg(param1:Array) : void
        {
            var _loc_2:Object = {eipIndex:"", eipNum:"", message:param1.join("_"), messageType:Mod_Chat_Base.WORLD};
            if (this._showNum > 0)
            {
                _loc_2.messageType = 100;
                _loc_2.message = this._showNum + ChatViewLang.TimeOver;
                _loc_2.sex = RoleType.getRoleGender(this._ctrl.player.mainRoleId);
                this._chat.sendSelf = _loc_2;
            }
            else
            {
                this.chat_with_players(_loc_2, this.chatWithPlayersCallback);
                this._showNum = 10;
            }
            return;
        }// end function

        public function sendChatMsg(param1:String) : void
        {
            var _loc_2:Object = {eipIndex:"", eipNum:"", message:param1, messageType:Mod_Chat_Base.WORLD};
            this.chat_with_players(_loc_2, this.chatWithPlayersCallback);
            return;
        }// end function

        private function showTimerEvent() : void
        {
            if (this._showNum > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this._showNum - 1;
                _loc_1._showNum = _loc_2;
            }
            return;
        }// end function

        public function show() : void
        {
            this.render();
            return;
        }// end function

        public function render() : void
        {
            this.serverOpenTime = URI.openTime;
            this._chat = _view.getAssetsObject("Chat", "Chat") as IChat;
            _popup.addView(this, this._chat.content);
            this._chat.tip = _view.tip.iTip;
            _view.addToTimerProcessList(sign, this.showTimerEvent);
            this._chat.playerId = _ctrl.player.playerId;
            this._chat.nickName = _ctrl.player.nickname;
            var obj:Object;
            var _loc_2:* = _ctrl.player.removeNickNameSuffix;
            this._chat.getRemoveSuffixData = _ctrl.player.removeNickNameSuffix;
            obj.handler = _loc_2;
            this.bro_to_players();
            this.get_affiche_list();
            this.get_warning_affiche();
            this.fav_friend_achievement_msg();
            this.send_all_message();
            this.changeChannel();
            this._chat.onSendChat = function (param1:Object) : void
            {
                var _loc_2:String = null;
                if (Config.EnableDomainSelector == true)
                {
                    _loc_2 = param1.message;
                    if (_loc_2.indexOf("set drama ") == 0)
                    {
                        MissionMapView.dramaList.push(_loc_2.split(" ").pop());
                    }
                }
                if (/^MSG\d+""^MSG\d+/.test(param1.message))
                {
                    return;
                }
                chat_with_players(param1, chatWithPlayersCallback);
                return;
            }// end function
            ;
            this._chat.onOpenGm = function () : void
            {
                _view.gameMaster.switchSelf();
                return;
            }// end function
            ;
            this._chat.onSendTownFile = function (param1:Object) : void
            {
                if (param1.type != Mod_Chat_Base.ACTIVITY)
                {
                    return;
                }
                if (param1.iconLen == 0)
                {
                    _view.screen.currentMap.playerSay(param1.playerId, param1.info, param1.msgLen);
                }
                else
                {
                    _view.screen.currentMap.playerSay(param1.playerId, param1.file, param1.msgLen);
                }
                return;
            }// end function
            ;
            this._chat.onTextLink = function (event:TextEvent) : void
            {
                switch(event.text)
                {
                    case ActivityType.FactionSeal:
                    {
                        _view.factionSeal.switchSelf();
                        ;
                    }
                    default:
                    {
                        _view.toolbar.onTextLink(event);
                        ;
                        ;
                    }
                }
                return;
            }// end function
            ;
            this._chat.content.addEventListener(MouseEvent.MOUSE_DOWN, this.passThroughHandler);
            this.changePoint = 0;
            return;
        }// end function

        private function abnormalTime() : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_1:* = _ctrl.player.abnormalTime;
            if (_loc_1 > 0 && _ctrl.player.level >= 60)
            {
                _loc_2 = new Date(2012, 4, 31, 11).time / 1000;
                _loc_3 = new Date(2012, 4, 31, 13).time / 1000;
                _loc_4 = new Date(2012, 4, 31, 15).time / 1000;
                _loc_5 = new Date(2012, 4, 31, 16).time / 1000;
                _loc_6 = new Date(2012, 4, 31, 20).time / 1000;
                _loc_7 = new Date(2012, 4, 31, 21).time / 1000;
                _loc_8 = _ctrl.player.serverTime;
                if (_loc_8 >= _loc_2 && _loc_8 <= _loc_3 || _loc_8 >= _loc_4 && _loc_8 <= _loc_5 || _loc_8 >= _loc_6 && _loc_8 <= _loc_7)
                {
                    this.getPunishmentPost(ChatViewLang.abnormalTimeInfo);
                }
                else
                {
                    this.getPunishmentPost("");
                }
            }
            return;
        }// end function

        private function startTime() : void
        {
            var _loc_1:* = new Date(2012, 0, 18).time / 1000;
            var _loc_2:* = this._ctrl.player.serverTime;
            if (this._ctrl.player.serverTime >= _loc_1)
            {
            }
            return;
        }// end function

        public function chatOpenFunction() : void
        {
            var _loc_1:* = FunctionType.isOpened(FunctionType.MultiMission);
            this._chat.isOpenActivity = _loc_1;
            if (_loc_1)
            {
                this._chat.isOpenFaction = FunctionType.isOpened(FunctionType.Faction);
            }
            return;
        }// end function

        public function set isOpenActivity(param1:Boolean) : void
        {
            this._chat.isOpenActivity = param1;
            return;
        }// end function

        public function set isOpenFaction(param1:Boolean) : void
        {
            this._chat.isOpenFaction = param1;
            return;
        }// end function

        public function receive(param1:String, param2:Boolean = false, param3:int = 99, param4:Boolean = false) : void
        {
            if (this._chat == null)
            {
                return;
            }
            var _loc_5:* = "<font color=\"#ffffff\">" + param1 + "</font>";
            this.sendInfo(_loc_5, param2, param3, param4);
            return;
        }// end function

        private function sendInfo(param1:String, param2:Boolean, param3:int = 99, param4:Boolean = false) : void
        {
            if (param4 == false)
            {
                this._chat.directlyChatData(param1, param3, param2);
            }
            else
            {
                this._chat.addMainShow(param1, param3, param2);
            }
            return;
        }// end function

        public function get content() : Sprite
        {
            return this._chat.content;
        }// end function

        public function clear() : void
        {
            this._chat.clear();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            _data.cancelPatch(Mod_Player_Base.get_warning_affiche);
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._chat && this._chat.content.parent;
        }// end function

        public function updateDepth(param1:IView) : void
        {
            if (this.inStage && (param1 as WarView != null || param1 as SuperSportView != null || param1 as StrategyWarView != null || param1 as TakeBibleRoadView != null || param1 as StudyStuntView != null || param1 as WorldFactionWarCupView != null || param1 as FingerGuessView != null || param1 as TopWarCreateView != null || param1 as FindImmortalView != null || param1 as NewTopWarView != null || param1 as TopThroneView != null))
            {
                _popup.addView(this, this._chat.content);
            }
            return;
        }// end function

        public function resetDepth() : void
        {
            if (this.inStage)
            {
                _popup.addChildAt(this._chat.content, 0);
            }
            return;
        }// end function

        public function set parent(param1:Sprite) : void
        {
            param1.addChild(this._chat.content);
            return;
        }// end function

        public function set parentAsMc(param1:MovieClip) : void
        {
            param1.addChild(this._chat.content);
            return;
        }// end function

        public function isShieldPlayerTalk(param1:int, param2:String) : void
        {
            this._shieldTackId = param1;
            _view.alert.showYesNoMsg(Lang.sprintf(ChatViewLang.UserGag, param2), ChatViewLang.Sure, ChatViewLang.Cancel, this.onShieldTalk);
            return;
        }// end function

        public function shieldPlayerTalk(param1:int) : void
        {
            this._shieldTackId = param1;
            _view.showTip(ChatViewLang.ShieldPlayer, null, TipType.Success);
            AllChatLimit.checkShieldPlayerTalk(param1, _ctrl.player.serverTime);
            return;
        }// end function

        public function onShieldTalk(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    if (this._shieldTackId == 0)
                    {
                        _view.showTip(ChatViewLang.PlayerIdNo0);
                        return;
                    }
                    AllChatLimit.checkShieldPlayerTalk(this._shieldTackId, _ctrl.player.serverTime);
                    break;
                }
                case AlertButtonType.No:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function disableTalkPlayer(param1:int, param2:String) : void
        {
            this._disableTalkId = param1;
            _view.alert.showYesNoMsg(Lang.sprintf(ChatViewLang.UserGag, param2), ChatViewLang.Sure, ChatViewLang.Cancel, this.onDisableTalk);
            return;
        }// end function

        public function onDisableTalk(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    if (this._disableTalkId == 0)
                    {
                        _view.showTip(ChatViewLang.PlayerIdNo0);
                        return;
                    }
                    this.disable_player_talk(this._disableTalkId);
                    break;
                }
                case AlertButtonType.No:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function passThroughHandler(event:MouseEvent) : void
        {
            if (!this._chat.content.hitTestPoint(_view.stage.mouseX, _view.stage.mouseY))
            {
                return;
            }
            var _loc_2:* = new BitmapData(1, 1, true, 0);
            _loc_2.draw(this._chat.content, new Matrix(1, 0, 0, 1, -this._chat.content.mouseX, -this._chat.content.mouseY));
            var _loc_3:* = _loc_2.getPixel32(0, 0);
            if (_loc_3 == 1258291200)
            {
                this.onPassClick(event);
            }
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                this._chat.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

        public function set changePoint(param1:int) : void
        {
            if (this._chat == null)
            {
                return;
            }
            if (_view.serverWarCup.inStage || _view.worldFactionWarCup.inStage || _view.serverFactionWarCup.inStage)
            {
                this._chat.changePoint = param1;
                this.visiblePost = false;
            }
            else if (_view.lodge.inStage)
            {
                this._chat.changePoint = param1;
                this.visiblePost = false;
            }
            else
            {
                this._chat.changePoint = 0;
                this.visiblePost = true;
            }
            this.reposition(false);
            return;
        }// end function

        public function set chatVisible(param1:Boolean) : void
        {
            if (this._chat == null)
            {
                return;
            }
            this._chat.chatVisible = param1;
            return;
        }// end function

        public function get chatVisible() : Boolean
        {
            return this._chat.chatVisible;
        }// end function

        public function addSystemMessage(param1:String, param2:uint = 16777215) : void
        {
            var _loc_3:* = "<font color=\"#" + param2.toString(16) + "\">" + param1 + "</font>";
            this.receive(_loc_3, true);
            return;
        }// end function

    }
}
