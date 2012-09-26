package com.views
{
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class DelayMessageView extends Base
    {
        private var _delayMessage:IDelayMessage;

        public function DelayMessageView()
        {
            return;
        }// end function

        public function checkVisible(param1:Boolean = false) : void
        {
            this._delayMessage.content.visible = _view.townMap.inStage;
            if (param1)
            {
                _popup.addChild(this._delayMessage.content);
            }
            return;
        }// end function

        public function init() : void
        {
            this._delayMessage = _view.getAssetsObject("DelayMessage", "DelayMessage") as IDelayMessage;
            this._delayMessage.dialog = this._view.alert.iAlert;
            this._delayMessage.tip = this._view.tip.iTip;
            this._delayMessage.specialDelayMessage = this.specialDelayMessage;
            this._delayMessage.whenDelayMessageDialogShow = this.whenDelayMessageDialogShow;
            this._delayMessage.removeNickNameSuffix = this._ctrl.player.removeNickNameSuffix;
            this._delayMessage.init();
            this._delayMessage.addOverrideMessage(DelayNotifyType.SuperSport);
            this._delayMessage.addOverrideMessage(DelayNotifyType.Farm);
            this._delayMessage.addOverrideMessage(DelayNotifyType.JoinFactionWar);
            this._delayMessage.addOverrideMessage(DelayNotifyType.InvitJoinEat);
            this._delayMessage.addLimitMessage([DelayNotifyType.PkLose, DelayNotifyType.PkWin], 10);
            _popup.addChild(this._delayMessage.content);
            this.receive_player_delay_notify_message();
            return;
        }// end function

        public function addDelayMessage(param1:int, param2:String, param3:uint = 1, param4:Function = null) : void
        {
            var _loc_5:Object = {id:param1, message:param2, flags:param3, clickCallBack:param4};
            {id:param1, message:param2, flags:param3, clickCallBack:param4}["message"] = this.replaceString(_loc_5["message"]);
            this._delayMessage.addMessage(_loc_5);
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                this._delayMessage.reposition(Structure.stageWidth, Structure.stageHeight);
            }
            return;
        }// end function

        private function whenDelayMessageDialogShow(param1:int) : void
        {
            switch(param1)
            {
                case DelayNotifyType.TakeBibleSuccess:
                case DelayNotifyType.ReceiveSendFlower:
                {
                    _view.activities.showWinEffect();
                    break;
                }
                case DelayNotifyType.ReceiveTopFlower:
                {
                    _view.sendFlower.showFlowerCartoon();
                    _view.toolbar.playFlowerRain();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function specialDelayMessage(param1:SimpleButton) : void
        {
            var delayMessage:* = param1;
            switch(delayMessage["id"])
            {
                case DelayNotifyType.Farm:
                {
                    delayMessage["clickCallBack"] = this.farmClickCallBack;
                    break;
                }
                case DelayNotifyType.InvitJoinEat:
                {
                    delayMessage["flags"] = AlertButtonType.Yes | AlertButtonType.No;
                    delayMessage["clickCallBack"] = this.factionEatClickCallBack;
                    break;
                }
                case DelayNotifyType.AddFriend:
                {
                    delayMessage["flags"] = AlertButtonType.Yes | AlertButtonType.No;
                    delayMessage["yesLabel"] = DelayMessageViewLang.AddFriend;
                    delayMessage["noLabel"] = DelayMessageViewLang.Close;
                    delayMessage["clickCallBack"] = function (param1:uint) : void
            {
                addFriendClickCallBack(param1, delayMessage["message"]);
                return;
            }// end function
            ;
                    break;
                }
                case DelayNotifyType.ReceiveTopFlower:
                {
                    delayMessage["clickCallBack"] = function (param1:uint) : void
            {
                _view.sendFlower.clearFlowerCartoon();
                return;
            }// end function
            ;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function replaceString(param1:String) : String
        {
            var _loc_4:String = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_8:String = null;
            if (param1.indexOf("replace") < 0)
            {
                return param1;
            }
            var _loc_2:* = param1.split("[");
            var _loc_3:String = "";
            for each (_loc_4 in _loc_2)
            {
                
                _loc_5 = 0;
                _loc_6 = _loc_4.indexOf("]");
                if (_loc_6 != -1)
                {
                    _loc_7 = _loc_4.substr(_loc_5, _loc_6 - _loc_5 + 1);
                    if (_loc_7.slice(_loc_5, _loc_7.indexOf(",")) != "replace")
                    {
                        continue;
                    }
                    _loc_8 = _loc_7.slice((_loc_7.indexOf(",") + 1), (_loc_7.length - 1));
                    _loc_4 = _loc_4.replace(_loc_7, this.replace(_loc_8));
                }
                _loc_3 = _loc_3 + _loc_4;
            }
            return _loc_3;
        }// end function

        private function replace(param1:String) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case "1":
                {
                    _loc_2 = DelayMessageViewLang.Monday;
                    break;
                }
                case "2":
                {
                    _loc_2 = DelayMessageViewLang.Tuesday;
                    break;
                }
                case "3":
                {
                    _loc_2 = DelayMessageViewLang.Wednesday;
                    break;
                }
                case "4":
                {
                    _loc_2 = DelayMessageViewLang.Thursday;
                    break;
                }
                case "5":
                {
                    _loc_2 = DelayMessageViewLang.Friday;
                    break;
                }
                case "6":
                {
                    _loc_2 = DelayMessageViewLang.Saturday;
                    break;
                }
                case "7":
                {
                    _loc_2 = DelayMessageViewLang.Sunday;
                    break;
                }
                default:
                {
                    _loc_2 = "";
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function farmClickCallBack(param1:uint) : void
        {
            if (!_view.farm.inStage)
            {
                _view.farm.switchSelf();
            }
            return;
        }// end function

        private function factionEatClickCallBack(param1:uint) : void
        {
            if (AlertButtonType.Yes == param1)
            {
                _view.factionEat.factionEatClickCallBack();
            }
            return;
        }// end function

        private function addFriendClickCallBack(param1:uint, param2:String) : void
        {
            var _loc_3:* = param2.split("【");
            var _loc_4:* = _loc_3[1].split("】");
            var _loc_5:* = _loc_3[1].split("】")[0];
            if (AlertButtonType.Yes == param1)
            {
                this._view.friendList.addFriend(_loc_5);
            }
            return;
        }// end function

        private function receive_player_delay_notify_message() : void
        {
            this._data.call(Mod_Player_Base.receive_player_delay_notify_message, this.receivePlayerDelayNotifyMessageCallBack, []);
            this._data.patch(Mod_Player_Base.receive_player_delay_notify_message, this.receivePlayerDelayNotifyMessageCallBack);
            return;
        }// end function

        private function receivePlayerDelayNotifyMessageCallBack() : void
        {
            var _loc_1:SimpleButton = null;
            var _loc_3:Object = null;
            var _loc_4:String = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_8:int = 0;
            var _loc_9:String = null;
            var _loc_2:* = this._ctrl.player.delayMessage;
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3["id"] == DelayNotifyType.WorldFactionWarBetWin1 || _loc_3["id"] == DelayNotifyType.WorldFactionWarBetWin2 || _loc_3["id"] == DelayNotifyType.WorldFactionWarBetWin3 || _loc_3["id"] == DelayNotifyType.WorldFactionWarBetLose1 || _loc_3["id"] == DelayNotifyType.WorldFactionWarBetLose2 || _loc_3["id"] == DelayNotifyType.WorldFactionWarBetLose3)
                {
                    _loc_4 = _loc_3["message"];
                    _loc_5 = _loc_4.indexOf("coin");
                    _loc_4 = _loc_4.replace("coin", "");
                    _loc_6 = _loc_4.indexOf("&", _loc_5);
                    _loc_7 = _loc_4.substring(_loc_5, _loc_6);
                    _loc_8 = int(_loc_7);
                    _loc_9 = _loc_7;
                    if (_loc_8 >= 100000)
                    {
                        _loc_9 = _loc_8 / 10000 + DelayMessageViewLang.Wan;
                        _loc_4 = _loc_4.replace(_loc_7, _loc_9);
                    }
                    _loc_5 = _loc_4.indexOf("coin");
                    _loc_4 = _loc_4.replace("coin", "");
                    _loc_6 = _loc_4.indexOf("&", _loc_5);
                    _loc_7 = _loc_4.substring(_loc_5, _loc_6);
                    _loc_8 = int(_loc_7);
                    _loc_9 = _loc_7;
                    if (_loc_8 >= 100000)
                    {
                        _loc_9 = _loc_8 / 10000 + DelayMessageViewLang.Wan;
                        _loc_4 = _loc_4.replace(_loc_7, _loc_9);
                    }
                    _loc_3["message"] = _loc_4;
                }
                if (_loc_3["id"] == DelayNotifyType.Farm && _view.farm.inStage || _loc_3["id"] == DelayNotifyType.SealSatanAward && _view.factionSeal.inStage)
                {
                    continue;
                }
                _loc_3["message"] = this.replaceString(_loc_3["message"]);
                this._delayMessage.addMessage(_loc_3);
            }
            return;
        }// end function

    }
}
