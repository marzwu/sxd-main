package com.views
{
    import com.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class WorldFactionWarCupView extends Base implements IView
    {
        private var _target:IWorldFactionWarCup;
        private var _info:WorldFactionWarInfo;
        private var _date:Date;
        private var _ingotChange:ChangeColor;
        private var _coinChange:ChangeColor;
        private var _seeId:int = 0;
        private var _clickWarTime:int = 0;

        public function WorldFactionWarCupView()
        {
            this._date = new Date();
            return;
        }// end function

        public function show() : void
        {
            if (this.inStage)
            {
                return;
            }
            this._info = _ctrl.worldFactionWar.info;
            this.get_race_list();
            return;
        }// end function

        public function close() : void
        {
            if (this._target && this._target.content.parent == _popup)
            {
                _popup.removeChild(this._target.content);
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._target && this._target.content.stage != null;
        }// end function

        private function loadComplete() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("WorldFactionwarCup", "MCCupClass") as IWorldFactionWarCup;
                this._target.onClose = this.close;
                this._target.onLink = this.onLink;
                this._target.onTianBang = this.onTianBang;
                this._target.onDiBang = this.onDiBang;
                this._target.onTip = this.onTip;
                this._target.onBet = this.onBet;
                this._target.onSee = this.onSee;
                this._target.onRecord = this.onRecord;
            }
            if (this._target.content.parent == null)
            {
                _popup.closeAll();
                _popup.addChild(this._target.content);
                this._target.reset();
            }
            this._info.getCookie = _view.getCookie;
            this._info.setCookie = _view.setCookie;
            this._target.init(this._info);
            this._target.tfCoins.text = this._ctrl.player.coinsString;
            this._target.tfIngot.text = this._ctrl.player.ingotString;
            this.onTip(this._target.tfCoins, WorldFactionWarCupViewLang.Coin + this._ctrl.player.coins);
            this.onTip(this._target.tfIngot, WorldFactionWarCupViewLang.Ingot + this._ctrl.player.ingot);
            _view.chat.updateDepth(this);
            return;
        }// end function

        private function onTianBang() : void
        {
            this.get_race_list();
            return;
        }// end function

        private function onDiBang() : void
        {
            this.get_race_list();
            return;
        }// end function

        private function onLink(event:TextEvent) : void
        {
            var _loc_2:* = event.text.split("_");
            if (_loc_2[0] == "faction")
            {
                this.fight_member_list(int(_loc_2[1]));
            }
            if (_loc_2[0] == "war" && this._clickWarTime < getTimer())
            {
                _view.stage.focus = null;
                this._clickWarTime = getTimer() + 3000;
                _data.call(Mod_WorldFactionWar_Base.world_faction_war_report, this.showWar, [_loc_2[1], _loc_2[2], _loc_2[3], _loc_2[4]]);
            }
            return;
        }// end function

        private function showWar() : void
        {
            _view.strategyWar.warType = WarType.WorldFactionWar;
            _view.strategyWar.wfWarData = _ctrl.worldFactionWar.warData;
            _view.strategyWar.onWarClose = this.onWarClose;
            _view.strategyWar.show();
            return;
        }// end function

        private function onWarClose() : void
        {
            this.get_race_list();
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

        private function onBet(param1:int, param2:int, param3:int, param4:int) : void
        {
            var id:* = param1;
            var lv:* = param2;
            var team:* = param3;
            var coin:* = param4;
            if (_view.coinEnough(coin) == false)
            {
                return;
            }
            var str:* = Lang.sprintf(WorldFactionWarCupViewLang.BetAsk, this._info.getFaction(id).name, HtmlText.yellow2(int(coin / 10000) + ""));
            _view.alert.showYesNoMsg(str, WorldFactionWarCupViewLang.Yes, WorldFactionWarCupViewLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    switch(lv)
                    {
                        case 4:
                        {
                            bet(id, Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4, team, coin);
                            break;
                        }
                        case 2:
                        {
                            bet(id, Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2, team, coin);
                            break;
                        }
                        case 1:
                        {
                            bet(id, Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1, team, coin);
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
            );
            return;
        }// end function

        private function onSee(param1:int, param2:int, param3:int) : void
        {
            switch(param3)
            {
                case 4:
                {
                    this.get_war_result_list(param1, param2, Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4);
                    break;
                }
                case 2:
                {
                    this.get_war_result_list(param1, param2, Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2);
                    break;
                }
                case 1:
                {
                    this.get_war_result_list(param1, param2, Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onRecord() : void
        {
            this.get_race_standings();
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
            this.onTip(_loc_2, WorldFactionWarCupViewLang.Ingot + param1);
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
            this.onTip(_loc_2, WorldFactionWarCupViewLang.Coin + param1);
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

        public function update() : void
        {
            this.get_race_list();
            return;
        }// end function

        private function get_race_list() : void
        {
            if (_view.chooseMission.inStageWithTip)
            {
                return;
            }
            if (_view.heroMission.inStageWithTip)
            {
                return;
            }
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (_view.multiMission.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            if (_view.strategyWar.opened == true)
            {
                return;
            }
            _data.call(Mod_WorldFactionWar_Base.get_player_bet, null, []);
            _data.call(Mod_WorldFactionWar_Base.get_race_list, this.get_race_list_back, [Mod_WorldFactionWar_Base.GROUP_TIAN_BANG]);
            return;
        }// end function

        private function get_race_list_back() : void
        {
            if (this._target == null)
            {
                _view.showLoading(WorldFactionWarCupViewLang.Loading, 1);
                loadAssets("WorldFactionwarCup", this.loadComplete, WorldFactionWarCupViewLang.Loading);
            }
            else
            {
                this.loadComplete();
            }
            return;
        }// end function

        private function fight_member_list(param1:int) : void
        {
            _data.call(Mod_WorldFactionWar_Base.fight_member_list, this.fight_member_list_back, [param1]);
            this._seeId = param1;
            return;
        }// end function

        private function fight_member_list_back() : void
        {
            this._target.showMember(_ctrl.worldFactionWar.memberList, this._seeId);
            return;
        }// end function

        private function bet(param1:int, param2:int, param3:int, param4:int) : void
        {
            _data.call(Mod_WorldFactionWar_Base.bet, this.bet_back, [param2, param3, param1, param4]);
            return;
        }// end function

        private function bet_back() : void
        {
            switch(_ctrl.worldFactionWar.result)
            {
                case Mod_WorldFactionWar_Base.SUCCESS:
                {
                    _view.showTip(WorldFactionWarCupViewLang.BetOk, null, TipType.Success);
                    this._target.closeBet();
                    this.get_race_list();
                    break;
                }
                case Mod_WorldFactionWar_Base.REBET:
                {
                    _view.showTip(WorldFactionWarCupViewLang.BetRepeat);
                    break;
                }
                case Mod_WorldFactionWar_Base.INVALID_RACE:
                {
                    _view.showTip(WorldFactionWarCupViewLang.BetInvalid);
                    break;
                }
                case Mod_WorldFactionWar_Base.NOT_ENOUGH_COIN:
                {
                    _view.showTip(WorldFactionWarCupViewLang.EnoughCoin);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function get_war_result_list(param1:int, param2:int, param3:int) : void
        {
            _data.call(Mod_WorldFactionWar_Base.get_war_result_list, this.get_war_result_list_back, [param1, param2, param3]);
            return;
        }// end function

        private function get_war_result_list_back() : void
        {
            this._target.showSeeRecord(_ctrl.worldFactionWar.seeRecordList);
            return;
        }// end function

        private function get_race_standings() : void
        {
            _data.call(Mod_WorldFactionWar_Base.get_race_standings, this.get_race_standings_back, []);
            return;
        }// end function

        private function get_race_standings_back() : void
        {
            this._target.showRecord(_ctrl.worldFactionWar.recordList, _ctrl.worldFactionWar.recordTip);
            return;
        }// end function

    }
}
