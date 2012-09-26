package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.haloer.display.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.events.*;
    import flash.utils.*;

    public class SendFlowerView extends Base implements IView
    {
        private var _sendFlower:ISendFlower;
        private var _dialog:IAlert = null;
        public var sendPlayerID:int;
        private var _imgFlowerCartoon:Image;
        private var _intFlowerCartoonTime:int = 0;
        private var _timer:Timer;
        private var _blnInLoadFlowerCartoon:Boolean = false;

        public function SendFlowerView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (!FunctionType.isOpened(FunctionType.SendFlower))
            {
                return;
            }
            if (this.inStage)
            {
                this.update();
            }
            else
            {
                this.loadData();
            }
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._dialog.hide();
            this._sendFlower.clear();
            this._view.removeFromTimerProcessList(sign);
            this.clearFlowerCartoon();
            return;
        }// end function

        public function showFlowerCartoon() : void
        {
            if (this._imgFlowerCartoon != null)
            {
                return;
            }
            this._blnInLoadFlowerCartoon = true;
            this._imgFlowerCartoon = new Image(URI.assetsUrl + "flower_cartoon.swf");
            this._imgFlowerCartoon.onComplete = function () : void
            {
                _imgFlowerCartoon.x = (_view.stage.stageWidth - 136) / 2;
                _imgFlowerCartoon.y = (_view.stage.stageHeight - 128) / 2;
                _view.stage.addChild(_imgFlowerCartoon);
                _timer = new Timer(100);
                _timer.addEventListener(TimerEvent.TIMER, onTimer);
                _timer.start();
                _blnInLoadFlowerCartoon = false;
                return;
            }// end function
            ;
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else if (this._imgFlowerCartoon != null)
            {
                this._imgFlowerCartoon.x = (_view.stage.stageWidth - 136) / 2;
                this._imgFlowerCartoon.y = (_view.stage.stageHeight - 128) / 2;
            }
            return;
        }// end function

        public function clearFlowerCartoon() : void
        {
            if (this._blnInLoadFlowerCartoon)
            {
                setTimeout(this.clearFlowerCartoon, 500);
                return;
            }
            if (this._imgFlowerCartoon != null)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
                if (this._view.stage.contains(this._imgFlowerCartoon))
                {
                    this._view.stage.removeChild(this._imgFlowerCartoon);
                }
                this._intFlowerCartoonTime = 0;
                this._imgFlowerCartoon = null;
                this._timer = null;
            }
            return;
        }// end function

        public function update() : void
        {
            if (this.inStage)
            {
                this.player_send_flower_info();
            }
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._sendFlower.content);
            _view.center(sign, this._sendFlower.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._sendFlower == null)
            {
                this._sendFlower = _view.getAssetsObject("SendFlower", "SendFlower") as ISendFlower;
            }
            this.init();
            this._sendFlower.init();
            this.playerSendFlowerInfoCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._sendFlower.tip = this._view.tip.iTip;
            this._sendFlower.drag = this._view.drag.iDrag;
            this._dialog = _view.alert.iAlert;
            this._sendFlower.onClose = this.close;
            this._sendFlower.onTextLink = _view.toolbar.onTextLink;
            this._sendFlower.onQueryFlower = this.send_flower_ranking;
            this._sendFlower.onSendFlower = this.sendPlayerFlower;
            this._sendFlower.onIsValentineDay = this.isValentineDay;
            return;
        }// end function

        private function sendPlayerFlower(param1:uint, param2:String) : void
        {
            var callBack:Function;
            var uintFlowerType:* = param1;
            var strNickName:* = param2;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    send_player_flower(uintFlowerType);
                }
                return;
            }// end function
            ;
            this._dialog.yesLabel = SendFlowerViewLang.DialogYes;
            this._dialog.noLabel = SendFlowerViewLang.DialogNo;
            var strHtml:* = Lang.sprintf(SendFlowerViewLang.SendFlower, this.getFlowerIngotString(uintFlowerType), strNickName, HtmlText.yellow(this.getFlowerNumber(uintFlowerType)));
            this._dialog.show(strHtml, AlertButtonType.Yes | AlertButtonType.No, callBack);
            return;
        }// end function

        private function getFlowerNumber(param1:uint) : String
        {
            var _loc_2:Object = {1:1, 2:9, 3:99};
            return _loc_2[param1];
        }// end function

        private function getFlowerFame(param1:uint) : String
        {
            var _loc_2:Object = {};
            if (this.isValentineDay())
            {
                _loc_2 = {1:20, 2:60, 3:1314};
            }
            else
            {
                _loc_2 = {1:10, 2:20, 3:520};
            }
            return _loc_2[param1];
        }// end function

        private function getFlowerIngotString(param1:uint) : String
        {
            var _loc_2:Object = {1:HtmlText.yellow("1000") + SendFlowerViewLang.Coin, 2:HtmlText.yellow("9") + SendFlowerViewLang.Ingot, 3:HtmlText.yellow("99") + SendFlowerViewLang.Ingot};
            return _loc_2[param1];
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            if (this._intFlowerCartoonTime >= 40)
            {
                this._imgFlowerCartoon.alpha = this._imgFlowerCartoon.alpha - 0.1;
                if (this._imgFlowerCartoon.alpha <= 0)
                {
                    this.clearFlowerCartoon();
                }
            }
            else
            {
                var _loc_2:String = this;
                var _loc_3:* = this._intFlowerCartoonTime + 1;
                _loc_2._intFlowerCartoonTime = _loc_3;
            }
            return;
        }// end function

        private function isValentineDay() : Boolean
        {
            var _loc_1:* = new Date(this._ctrl.player.serverTime * 1000);
            var _loc_2:* = _loc_1.month == 1 && (_loc_1.date >= 13 && _loc_1.date <= 15);
            return false;
        }// end function

        private function loadData() : void
        {
            _data.call(Mod_SendFlower_Base.player_send_flower_info, this.loadDataCallBack, [this.sendPlayerID]);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            var _loc_1:* = this._ctrl.sendFlower.sendFlowerInfo();
            if (_loc_1["result"] != Mod_SendFlower_Base.SUCCESS)
            {
                this._view.showTip(this.message(_loc_1["result"]));
                return;
            }
            if (_loc_1["is_can_send"] == Mod_SendFlower_Base.NO)
            {
                this._view.showTip(SendFlowerViewLang.OnlyOne);
                return;
            }
            loadAssets("SendFlower", this.render, SendFlowerViewLang.LoadInfo);
            return;
        }// end function

        private function player_send_flower_info() : void
        {
            _data.call(Mod_SendFlower_Base.player_send_flower_info, this.playerSendFlowerInfoCallBack, [this.sendPlayerID]);
            return;
        }// end function

        private function playerSendFlowerInfoCallBack() : void
        {
            var _loc_1:* = this._ctrl.sendFlower.sendFlowerInfo();
            if (_loc_1["result"] != Mod_SendFlower_Base.SUCCESS)
            {
                this._view.showTip(this.message(_loc_1["result"]));
                return;
            }
            if (_loc_1["is_can_send"] == Mod_SendFlower_Base.NO)
            {
                this._view.showTip(SendFlowerViewLang.OnlyOne);
                return;
            }
            var _loc_2:* = this._ctrl.sendFlower.sendFlowerRecord();
            this._sendFlower.renderSendFlowerInfo(_loc_1, _loc_2);
            return;
        }// end function

        private function send_player_flower(param1:uint) : void
        {
            var callBack:Function;
            var uintFlowerType:* = param1;
            callBack = function () : void
            {
                sendPlayerFlowerCallBack(uintFlowerType);
                return;
            }// end function
            ;
            _data.call(Mod_SendFlower_Base.send_player_flower, callBack, [this.sendPlayerID, uintFlowerType]);
            return;
        }// end function

        private function sendPlayerFlowerCallBack(param1:uint) : void
        {
            var callBack:Function;
            var uintFlowerType:* = param1;
            callBack = function (param1:uint) : void
            {
                close();
                return;
            }// end function
            ;
            var obj:* = this._ctrl.sendFlower.sendPlayerFlower();
            if (obj["result"] == Mod_SendFlower_Base.SUCCESS)
            {
                _view.gameHelper.loader_first_info();
                this._view.activities.showWinEffect();
                this._dialog.yesLabel = SendFlowerViewLang.DialogYes;
                this._dialog.show(Lang.sprintf(SendFlowerViewLang.GetFame, this.getFlowerNumber(uintFlowerType), HtmlText.yellow(this.getFlowerFame(uintFlowerType))), AlertButtonType.Yes, callBack);
            }
            else
            {
                this._view.showTip(this.message(obj["result"]));
            }
            return;
        }// end function

        private function send_flower_ranking() : void
        {
            _data.call(Mod_SendFlower_Base.send_flower_ranking, this.sendFlowerRankingCallBack, []);
            return;
        }// end function

        private function sendFlowerRankingCallBack() : void
        {
            var _loc_1:* = this._ctrl.sendFlower.sendFlowerRanking();
            this._sendFlower.renderSendFlowerRanking(_loc_1);
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_SendFlower_Base.SUCCESS:
                {
                    _loc_2 = SendFlowerViewLang.Success;
                    break;
                }
                case Mod_SendFlower_Base.FUN_OPENED:
                {
                    _loc_2 = SendFlowerViewLang.FunOpened;
                    break;
                }
                case Mod_SendFlower_Base.NOT_ENOUGH_INGOT:
                {
                    _loc_2 = SendFlowerViewLang.NotEnoughIngot;
                    break;
                }
                case Mod_SendFlower_Base.NOT_ENOUGH_COIN:
                {
                    _loc_2 = SendFlowerViewLang.NotEnoughCoin;
                    break;
                }
                case Mod_SendFlower_Base.SAME_SEX:
                {
                    _loc_2 = SendFlowerViewLang.SameSex;
                    break;
                }
                case Mod_SendFlower_Base.SEND_SELF:
                {
                    _loc_2 = SendFlowerViewLang.SendSelf;
                    break;
                }
                default:
                {
                    _loc_2 = SendFlowerViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
