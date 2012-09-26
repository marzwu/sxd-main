package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.serverFactionWar.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    final public class ServerFactionWarCupView extends Base implements IView
    {
        private var _info:ServerFactionWarInfo;
        private var _target:IServerFactionWarCup;
        private var _linkData:Array;
        private const _timerProcess:String = "ServerFactionWarCupView_timerProcess";
        private var _timeUpdate:int = 0;
        private var _date:Date;
        private var _ingotChange:ChangeColor;
        private var _coinChange:ChangeColor;
        private var _onWarTime:int = 0;

        public function ServerFactionWarCupView()
        {
            this._linkData = [];
            this._date = new Date();
            _inStageTipTitle = ServerFactionWarCupViewLang.ServerWarOpening;
            _inStageTipContent = "";
            return;
        }// end function

        public function show() : void
        {
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            if (_view.multiMission.inStageWithTip)
            {
                return;
            }
            this._info = _ctrl.serverFactionWar.info;
            this.get_race_list(this._info.groupCup);
            return;
        }// end function

        public function close() : void
        {
            if (this._target && this._target.content.parent == _popup)
            {
                _popup.removeChild(this._target.content);
            }
            _view.chat.resetDepth();
            _view.chat.changePoint = 0;
            _view.removeFromTimerProcessList(this._timerProcess);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function update() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._info = _ctrl.serverFactionWar.info;
            this.get_race_list(this._info.groupCup);
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._target && this._target.content && this._target.content.parent;
        }// end function

        private function loadComplete() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("ServerFactionWarCup", "MCWarCup") as IServerFactionWarCup;
                this._target.onClose = this.close;
                this._target.onRecord = this.onRecord;
                this._target.onSee = this.onSee;
                this._target.onLink = this.onLink;
                this._target.onBet = this.onBet;
                this._target.onTip = this.onTip;
                this._target.onDiBan = this.onDiBan;
                this._target.onTianBan = this.onTianBan;
                this._target.onDeploy = function () : void
            {
                _view.superDeploy.switchSelf();
                return;
            }// end function
            ;
                this._target.onResearch = function () : void
            {
                _view.research.switchSelf();
                return;
            }// end function
            ;
                this._target.onFate = function () : void
            {
                _view.fate.switchSelf();
                return;
            }// end function
            ;
                this._target.onSealSoul = function () : void
            {
                _view.sealSoul.switchSelf();
                return;
            }// end function
            ;
                this._target.onRoleMsg = function () : void
            {
                _view.roleMsg.switchSelf();
                return;
            }// end function
            ;
                this._target.onPack = function () : void
            {
                _view.pack.switchSelf();
                return;
            }// end function
            ;
                this._target.onUpgrade = function () : void
            {
                _view.upgrade.switchSelf();
                return;
            }// end function
            ;
            }
            if (this._target.content.parent == null)
            {
                _popup.closeAll();
                _popup.addChild(this._target.content);
                this._target.reset();
                _view.chat.changePoint = 1;
                _view.chat.parent = this._target.chatMark;
                this._target.chatMark.visible = false;
            }
            this._target.init(this._info);
            _view.addToTimerProcessList(this._timerProcess, this.timerProcessHandler);
            this.timerProcessHandler();
            this.onTip(this._target.tfTime, ServerFactionWarCupViewLang.ServerWarTime);
            this._target.tfCoins.text = this._ctrl.player.coinsString;
            this._target.tfIngot.text = this._ctrl.player.ingotString;
            this.onTip(this._target.tfCoins, ServerFactionWarCupViewLang.Coin + this._ctrl.player.coins);
            this.onTip(this._target.tfIngot, ServerFactionWarCupViewLang.Ingot + this._ctrl.player.ingot);
            return;
        }// end function

        private function timerProcessHandler() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._date.time = _ctrl.player.serverTime * 1000;
            var _loc_1:* = "" + this._date.hours;
            var _loc_2:* = "" + (this._date.minutes < 10 ? ("0" + this._date.minutes) : (this._date.minutes));
            var _loc_3:* = "" + (this._date.seconds < 10 ? ("0" + this._date.seconds) : (this._date.seconds));
            this._target.tfTime.text = _loc_1 + ":" + _loc_2 + ":" + _loc_3;
            if (this._timeUpdate + 30000 < getTimer())
            {
                this.update();
            }
            return;
        }// end function

        private function onTianBan(param1:int) : void
        {
            this.get_race_list(Mod_ServerFactionWar_Base.GROUP_TIAN_BANG);
            this._target.reset();
            return;
        }// end function

        private function onDiBan(param1:int) : void
        {
            this.get_race_list(Mod_ServerFactionWar_Base.GROUP_DI_BANG);
            this._target.reset();
            return;
        }// end function

        private function onRecord() : void
        {
            this.get_race_standings();
            return;
        }// end function

        private function onSee(param1:int, param2:int, param3:int) : void
        {
            switch(param3)
            {
                case 16:
                {
                    this.get_war_result_list(param1, param2, Mod_ServerFactionWar_Base.SERVER_WAR_16);
                    break;
                }
                case 8:
                {
                    this.get_war_result_list(param1, param2, Mod_ServerFactionWar_Base.SERVER_WAR_8);
                    break;
                }
                case 4:
                {
                    this.get_war_result_list(param1, param2, Mod_ServerFactionWar_Base.SERVER_WAR_4);
                    break;
                }
                case 2:
                {
                    this.get_war_result_list(param1, param2, Mod_ServerFactionWar_Base.SERVER_WAR_2);
                    break;
                }
                case 1:
                {
                    this.get_war_result_list(param1, param2, Mod_ServerFactionWar_Base.SERVER_WAR_1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onBet(param1:int, param2:int) : void
        {
            var id:* = param1;
            var num:* = param2;
            if (num == 0)
            {
                _view.showTip(ServerFactionWarCupViewLang.CanNoZero);
            }
            else if (_view.coinEnough(num) == true)
            {
                _view.alert.showYesNoMsg(Lang.sprintf(ServerFactionWarCupViewLang.BetTip, this._info.getUserData(id).name, HtmlText.yellow2("" + int(num / 10000))), ServerFactionWarCupViewLang.Yes, ServerFactionWarCupViewLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    bet(id, num);
                    _target.closeBet();
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2 = null) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (param2 == null || param2 == "")
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
            }
            return;
        }// end function

        public function set renderIngot(param1:Number) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._ingotChange = this._ingotChange || new ChangeColor();
            var _loc_2:* = this._target.tfIngot;
            this.onTip(_loc_2, ServerFactionWarCupViewLang.Ingot + param1);
            if (int(_loc_2.text) > param1)
            {
                this._ingotChange.textColorForIngot(_loc_2, param1, 65280, 16773632);
            }
            else
            {
                this._ingotChange.textColorForIngot(_loc_2, param1, 16711680, 16773632);
            }
            return;
        }// end function

        public function set renderCoins(param1:Number) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._coinChange = this._coinChange || new ChangeColor();
            var _loc_2:* = this._target.tfCoins;
            this.onTip(_loc_2, ServerFactionWarCupViewLang.Coin + param1);
            if (int(_loc_2.text) > param1)
            {
                this._coinChange.textColorForCoins(_loc_2, param1, 16711680);
            }
            else
            {
                this._coinChange.textColorForCoins(_loc_2, param1, 65280);
            }
            return;
        }// end function

        private function onWarClose(param1:Boolean = false) : void
        {
            _view.chat.changePoint = 1;
            _view.chat.parent = this._target.chatMark;
            this._onWarTime = getTimer();
            return;
        }// end function

        private function onLink(event:TextEvent) : void
        {
            var _loc_2:Array = null;
            var _loc_3:ClickTipList = null;
            this._linkData = event.text.split("_");
            if (this._linkData[0] == "war")
            {
                if (this._onWarTime > getTimer())
                {
                    return;
                }
                this._onWarTime = getTimer() + 15000;
                _view.chat.changePoint = 0;
                _view.chat.resetDepth();
                _view.strategyWar.isServerWar = this._info.isCrossService;
                _view.strategyWar.sameServer = this._info.isThisService;
                _view.strategyWar.warType = WarType.ServerFactionWar;
                _view.strategyWar.version = this._linkData[2];
                _view.strategyWar.reportId = int(this._linkData[1]);
                _view.strategyWar.onClose = this.onWarClose;
                _view.strategyWar.show();
            }
            else if (this._linkData[0] == "player")
            {
                if (_ctrl.player.playerId == int(this._linkData[1]))
                {
                    return;
                }
                _loc_2 = [ServerFactionWarCupViewLang.See, ServerFactionWarCupViewLang.Add, ServerFactionWarCupViewLang.Send, ServerFactionWarCupViewLang.Talk];
                _loc_3 = new ClickTipList(_loc_2, _loc_2, this.onTextClick);
                setTimeout(_view.tip.iTip.clickToOpen, 50, _loc_3);
            }
            return;
        }// end function

        private function onTextClick(param1:String) : void
        {
            var _loc_2:* = int(this._linkData[1]);
            var _loc_3:* = this._linkData[2];
            if (param1 == ServerFactionWarCupViewLang.See)
            {
                _view.otherRoleMsg.init(_loc_2, _loc_3);
                _view.otherRoleMsg.show();
            }
            else if (param1 == ServerFactionWarCupViewLang.Add)
            {
                _view.friendList.addFriend(_loc_3, _loc_2);
            }
            else if (param1 == ServerFactionWarCupViewLang.Talk)
            {
                this._view.friendChat.get_friendinfo_chatrecord_list(_loc_2);
            }
            else if (param1 == ServerFactionWarCupViewLang.Send)
            {
                this._view.sendFlower.sendPlayerID = _loc_2;
                this._view.sendFlower.show();
            }
            return;
        }// end function

        private function get_race_list(param1:int) : void
        {
            this._timeUpdate = getTimer();
            _data.call(Mod_ServerFactionWar_Base.get_player_bet, null, []);
            _data.call(Mod_ServerFactionWar_Base.get_race_list, this.get_race_list_back, [param1, Mod_ServerFactionWar_Base.WORLD_WAR_LEVEL_NULL]);
            _data.call(Mod_ServerFactionWar_Base.get_bet_coin_rank, null, []);
            return;
        }// end function

        private function get_race_list_back() : void
        {
            loadAssets("ServerFactionWarCup", null, ServerFactionWarCupViewLang.Loading, false, false, this.loadComplete);
            return;
        }// end function

        private function get_race_standings() : void
        {
            _data.call(Mod_ServerFactionWar_Base.get_race_standings, this.get_race_standings_back, []);
            return;
        }// end function

        private function get_race_standings_back() : void
        {
            if (this._info.cupRecordCount <= 0)
            {
                return;
            }
            this._target.showMineRecord(this._info);
            return;
        }// end function

        private function get_war_result_list(param1:int, param2:int, param3:int) : void
        {
            _data.call(Mod_ServerFactionWar_Base.get_war_result_list, this.get_war_result_list_back, [param1, param2, param3]);
            return;
        }// end function

        private function get_war_result_list_back() : void
        {
            this._target.showSeeRecord(this._info);
            return;
        }// end function

        private function bet(param1:int, param2:int) : void
        {
            _data.call(Mod_ServerFactionWar_Base.bet, this.bet_back, [this._info.betState, param1, param2]);
            return;
        }// end function

        private function bet_back() : void
        {
            switch(_ctrl.serverFactionWar.result)
            {
                case Mod_ServerFactionWar_Base.SUCCESS:
                {
                    _view.showTip(ServerFactionWarCupViewLang.BetSuccess, null, TipType.Success);
                    this.get_race_list(this._info.groupCup);
                    break;
                }
                case Mod_ServerFactionWar_Base.REBET:
                {
                    _view.showTip(ServerFactionWarCupViewLang.BetNoBet);
                    break;
                }
                case Mod_ServerFactionWar_Base.INVALID_RACE:
                {
                    _view.showTip(ServerFactionWarCupViewLang.BetError1);
                    break;
                }
                case Mod_ServerFactionWar_Base.NOT_ENOUGH_COIN:
                {
                    _view.showTip(ServerFactionWarCupViewLang.BetNoCoin);
                    break;
                }
                default:
                {
                    _view.showTip(ServerFactionWarCupViewLang.BetError2);
                    break;
                    break;
                }
            }
            return;
        }// end function

    }
}
