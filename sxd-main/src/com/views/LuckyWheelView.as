package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.toolbar.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class LuckyWheelView extends Base implements IView
    {
        private var _luckyWheel:ILuckyWheel;
        private var _itemUrl:String;
        private var _zongZiUrl:String;
        private var _baoZiUrl:String;
        public var isInJiHuiSuo:Boolean;
        private var _runInfo:Object;

        public function LuckyWheelView()
        {
            this._itemUrl = URI.goodsIconUrl + "382.png";
            this._zongZiUrl = URI.goodsIconUrl + "1444.png";
            this._baoZiUrl = URI.goodsIconUrl + "1488.png";
            return;
        }// end function

        public function enter() : void
        {
            var _loc_1:* = ActivityType.FactionLevel;
            if (!FunctionType.isOpened(FunctionType.Faction))
            {
                return;
            }
            if (!_view.townMap.inStage)
            {
                return;
            }
            var _loc_2:* = TownType.getSign(_ctrl.player.mapId);
            if (_loc_2 == TownType.JiHuiSuo)
            {
                if (this.isInJiHuiSuo)
                {
                    if (_loc_1 < 4)
                    {
                        _view.showTip(this.message(13));
                    }
                    else
                    {
                        this.show();
                    }
                }
            }
            this.isInJiHuiSuo = false;
            return;
        }// end function

        public function gotoJiHuiSuo() : void
        {
            this.isInJiHuiSuo = true;
            var _loc_1:* = TownType.getSign(_ctrl.player.mapId);
            if (_loc_1 != TownType.JiHuiSuo)
            {
                _view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
            }
            return;
        }// end function

        public function show() : void
        {
            this.openLuckyWheel();
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            this.clear();
            return;
        }// end function

        public function clear() : void
        {
            this._luckyWheel.clear();
            _view.toolbar.skillDelay = false;
            _view.toolbar.coinDelay = false;
            _view.triggerDelayed(DelayType.SkillDelay, DelayType.CoinDelay);
            return;
        }// end function

        private function openLuckyWheel() : void
        {
            _data.call(Mod_LuckyWheel_Base.open_lucky_wheel, this.openLuckyWheelCallBack, []);
            return;
        }// end function

        private function run() : void
        {
            if (_ctrl.player.packNum <= 0)
            {
                this.showMessage(14);
                return;
            }
            _view.toolbar.skillDelay = true;
            _view.toolbar.coinDelay = true;
            _data.call(Mod_LuckyWheel_Base.start_lucky_wheel, this.runCallBack, []);
            return;
        }// end function

        public function get isMovie() : Boolean
        {
            if (inStage)
            {
                return this._luckyWheel.isMovie;
            }
            return false;
        }// end function

        private function openLuckyWheelCallBack() : void
        {
            loadAssets("LuckyWheel", this.render, LuckyWheelViewLang.Open);
            return;
        }// end function

        private function runCallBack() : void
        {
            var _loc_1:* = _ctrl.luckyWheel.runState;
            var _loc_2:* = _ctrl.luckyWheel.runInfo;
            if (_loc_1 == Mod_LuckyWheel_Base.SUCCESS)
            {
                this._runInfo = _loc_2;
                this._luckyWheel.awardInfo = _loc_2;
                this._luckyWheel.movie();
            }
            else
            {
                _view.showTip(this.message(_loc_1));
            }
            return;
        }// end function

        private function render() : void
        {
            if (this._luckyWheel == null)
            {
                this._luckyWheel = _view.getAssetsObject("LuckyWheel", "LuckyWheel") as ILuckyWheel;
            }
            this._luckyWheel.tip = _view.tip.iTip;
            _popup.addView(this, this._luckyWheel.content);
            _view.center(sign, this._luckyWheel.content);
            this._luckyWheel.onClose = this.close;
            this._luckyWheel.onStart = this.run;
            this._luckyWheel.playerLevel = _ctrl.player.level;
            this._luckyWheel.state = _ctrl.luckyWheel.state;
            this._luckyWheel.openInfo = _ctrl.luckyWheel.openInfo;
            this._luckyWheel.showMessage = this.showMessage;
            this._luckyWheel.onShowChat = this.showChat;
            this._luckyWheel.onGetItem = this.getItem;
            this._luckyWheel.render();
            return;
        }// end function

        private function getItem(param1:int) : void
        {
            switch(param1)
            {
                case 1:
                {
                    _view.toolbar.playGoodsEffect(this._itemUrl);
                    break;
                }
                case 4:
                {
                    _view.toolbar.playGoodsEffect(this._zongZiUrl);
                    break;
                }
                case 8:
                {
                    _view.toolbar.playGoodsEffect(this._baoZiUrl);
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function showMessage(param1:int) : void
        {
            _view.showTip(this.message(param1));
            return;
        }// end function

        private function showChat(param1:int) : void
        {
            var _loc_3:String = null;
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            _view.toolbar.skillDelay = false;
            _view.toolbar.coinDelay = false;
            _view.triggerDelayed(DelayType.SkillDelay, DelayType.CoinDelay);
            var _loc_2:* = _ctrl.player.nickname;
            var _loc_4:* = param1 == 1 ? (this._runInfo.item_id) : (param1);
            _loc_3 = this.chat(_loc_4);
            _view.chat.receive(_loc_3, true);
            if (param1 == 1 || param1 == 4 || param1 == 5 || param1 == 8)
            {
                _loc_5 = "";
                _loc_6 = _ctrl.player.playerId;
                _loc_7 = "<font color=\"#fff200\">" + "<a href = \"event:" + TextLinkType.Player + "_" + _loc_6 + "_" + _loc_2 + "\">" + "<u>" + _ctrl.player.removeNickNameSuffix(_loc_2) + "</u>" + "</a>" + "</font>";
                _loc_5 = _loc_7 + LuckyWheelViewLang.ChatMessage + this.chat(_loc_4);
                _loc_3 = "<font color=\"#80c269\">[" + LuckyWheelViewLang.Faction + "]</font>" + _loc_5;
                _view.chat.receive(_loc_3, false, Mod_Chat_Base.FACTION);
            }
            return;
        }// end function

        private function chat(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case 1:
                {
                    _loc_2 = LuckyWheelViewLang.ChatScroll;
                    break;
                }
                case 2:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatSkill, 25000);
                    break;
                }
                case 3:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatCoin, 30000);
                    break;
                }
                case 4:
                {
                    _loc_2 = LuckyWheelViewLang.ChatZongZi;
                    break;
                }
                case 5:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatCoin, 500000);
                    break;
                }
                case 6:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatSkill, 6000);
                    break;
                }
                case 7:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatCoin, 280000);
                    break;
                }
                case 8:
                {
                    _loc_2 = LuckyWheelViewLang.ChatBaoZi;
                    break;
                }
                case 382:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.One + LuckyWheelViewLang.Power);
                    break;
                }
                case 395:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.One + LuckyWheelViewLang.Strunt);
                    break;
                }
                case 411:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.One + LuckyWheelViewLang.Magic);
                    break;
                }
                case 383:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Two + LuckyWheelViewLang.Power);
                    break;
                }
                case 397:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Two + LuckyWheelViewLang.Strunt);
                    break;
                }
                case 413:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Two + LuckyWheelViewLang.Magic);
                    break;
                }
                case 385:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Three + LuckyWheelViewLang.Power);
                    break;
                }
                case 390:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Three + LuckyWheelViewLang.Strunt);
                    break;
                }
                case 415:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Three + LuckyWheelViewLang.Magic);
                    break;
                }
                case 386:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Four + LuckyWheelViewLang.Power);
                    break;
                }
                case 401:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Four + LuckyWheelViewLang.Strunt);
                    break;
                }
                case 417:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Four + LuckyWheelViewLang.Magic);
                    break;
                }
                case 387:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Five + LuckyWheelViewLang.Power);
                    break;
                }
                case 403:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Five + LuckyWheelViewLang.Strunt);
                    break;
                }
                case 420:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Five + LuckyWheelViewLang.Magic);
                    break;
                }
                case 389:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Six + LuckyWheelViewLang.Power);
                    break;
                }
                case 405:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Six + LuckyWheelViewLang.Strunt);
                    break;
                }
                case 422:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Six + LuckyWheelViewLang.Magic);
                    break;
                }
                case 390:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Seven + LuckyWheelViewLang.Power);
                    break;
                }
                case 406:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Seven + LuckyWheelViewLang.Strunt);
                    break;
                }
                case 424:
                {
                    _loc_2 = Lang.sprintf(LuckyWheelViewLang.ChatScroll, LuckyWheelViewLang.Seven + LuckyWheelViewLang.Magic);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_LuckyWheel_Base.NO:
                {
                    _loc_2 = LuckyWheelViewLang.NO;
                    break;
                }
                case Mod_LuckyWheel_Base.NOT_ENOUGH_NUMBER:
                {
                    _loc_2 = LuckyWheelViewLang.NotEnoughtNumber;
                    break;
                }
                case Mod_LuckyWheel_Base.FAILED:
                {
                    _loc_2 = LuckyWheelViewLang.Failed;
                    break;
                }
                case 11:
                {
                    _loc_2 = LuckyWheelViewLang.IsMovie;
                    break;
                }
                case 12:
                {
                    _loc_2 = LuckyWheelViewLang.LingNumber;
                    break;
                }
                case 13:
                {
                    _loc_2 = LuckyWheelViewLang.FactionLevel;
                    break;
                }
                case 14:
                {
                    _loc_2 = LuckyWheelViewLang.BagFull;
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
