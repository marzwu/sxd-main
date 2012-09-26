package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class TravelEventView extends Base implements IView
    {
        public var onActivityInfo:Function;
        private var _cdIngot:int = 0;
        private var _answerValue:Array;
        private var _cdTime:int = 0;
        private var _lastIngot:int = 120;
        private var _travelEvent:ITravelEvent;
        private var _autoClearCdBool:Boolean = false;

        public function TravelEventView()
        {
            this.onActivityInfo = new Function();
            return;
        }// end function

        public function get_activity_info() : void
        {
            if (FunctionType.isOpened(FunctionType.TravelEvent) == false)
            {
                return;
            }
            _data.call(Mod_TravelEvent_Base.get_activity_info, this.activityInfoCallBack, []);
            return;
        }// end function

        private function get_event_and_answer() : void
        {
            _data.call(Mod_TravelEvent_Base.get_event_and_answer, this.eventCallBack, []);
            return;
        }// end function

        private function answer_travel_event(param1:int, param2:int) : void
        {
            _data.call(Mod_TravelEvent_Base.answer_travel_event, this.answerCallBack, [param1, param2]);
            return;
        }// end function

        public function cancel_cd() : void
        {
            _data.call(Mod_TravelEvent_Base.cancel_cd, this.cancelCdCallBack, []);
            return;
        }// end function

        private function activityInfoCallBack() : void
        {
            var _loc_1:* = this._ctrl.travelEvent.activityInfo;
            this.onActivityInfo(_loc_1);
            this.leftQuickly(_loc_1);
            return;
        }// end function

        private function eventCallBack() : void
        {
            var _loc_1:* = this._ctrl.travelEvent.eventAndAnswer;
            if (_loc_1.msg == Mod_TravelEvent_Base.SUCCESS)
            {
                this._travelEvent.eventInfo = _loc_1;
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function answerCallBack() : void
        {
            var _loc_1:* = this._ctrl.travelEvent.answer;
            this._answerValue = [];
            this._answerValue = _loc_1.answerValue;
            this._travelEvent.awardInfo = _loc_1.answer;
            this.onActivityInfo(_loc_1.activityInfo);
            this.leftQuickly(_loc_1.activityInfo);
            if (this._autoClearCdBool)
            {
                this.cancel_cd();
            }
            return;
        }// end function

        private function leftQuickly(param1:Object) : void
        {
            var _loc_2:* = param1.joinCount % 10;
            this._lastIngot = Math.ceil((120 + _loc_2 * 180) / 60);
            var _loc_3:* = param1.joinCount < (param1.totalCount - 1);
            if (param1.joinCount >= param1.totalCount)
            {
                this._autoClearCdBool = false;
                this._lastIngot = 0;
            }
            if (this.inStage)
            {
                this._travelEvent.getClearIngo = this._lastIngot;
                this._travelEvent.visibleIngot = _loc_3;
            }
            var _loc_4:* = param1.cdTimer * 1000;
            this._view.toolbar.travelEventEndTime = new Date().time + _loc_4;
            this._view.toolbar.travelEventJoinCount = param1.joinCount;
            this._view.toolbar.travelEventTotalCount = param1.totalCount;
            this._view.toolbar.renderTravelEventTip(param1.cdIngot);
            this._view.toolbar.setFunctionLinkPoint();
            this._cdIngot = param1.cdIngot;
            this._cdTime = param1.cdTimer;
            return;
        }// end function

        private function downTime() : void
        {
            if (this._cdTime > 0)
            {
                var _loc_1:String = this;
                var _loc_2:* = this._cdTime - 1;
                _loc_1._cdTime = _loc_2;
            }
            return;
        }// end function

        private function cancelCdCallBack() : void
        {
            var _loc_1:* = this._ctrl.travelEvent.cancelCd;
            if (_loc_1.msg == Mod_TravelEvent_Base.SUCCESS)
            {
                this.get_activity_info();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_TravelEvent_Base.CD_TIME:
                {
                    if (this._autoClearCdBool)
                    {
                        this.cancel_cd();
                    }
                    else
                    {
                        this.close();
                        _view.showTip(TravelEventViewLang.CdTime);
                    }
                    break;
                }
                case Mod_TravelEvent_Base.REACH_MAX_COUNT:
                {
                    _view.showTip(TravelEventViewLang.ReachMaxCount);
                    this.close();
                    break;
                }
                case Mod_TravelEvent_Base.NO_INGOT:
                {
                    _view.showTip(TravelEventViewLang.NoIngot);
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function show() : void
        {
            loadAssets("TravelEvent", this.render, TravelEventViewLang.LoadAssets);
            return;
        }// end function

        public function render() : void
        {
            this._travelEvent = _view.getAssetsObject("TravelEvent", "TravelEvent") as ITravelEvent;
            _popup.addView(this, this._travelEvent.content);
            _view.center(sign, this._travelEvent.content);
            this.get_event_and_answer();
            this._travelEvent.onSureClick = function (param1:int, param2:int) : void
            {
                answer_travel_event(param1, param2);
                return;
            }// end function
            ;
            this._travelEvent.onAutoClear = function (param1:Boolean) : void
            {
                _autoClearCdBool = param1;
                return;
            }// end function
            ;
            this._travelEvent.onClose = function () : void
            {
                if (_autoClearCdBool)
                {
                    get_event_and_answer();
                }
                else
                {
                    close();
                }
                _view.activities.playOpenFunctionMc();
                return;
            }// end function
            ;
            this._autoClearCdBool = false;
            this.get_activity_info();
            return;
        }// end function

        public function refreshTravelInfo() : void
        {
            this.get_activity_info();
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        public function cancelCd() : void
        {
            var callback:Function;
            if (_view.vipEnabled == false)
            {
                return;
            }
            var timer:* = _view.toolbar.travelEventCdTime;
            this._cdIngot = Math.ceil(timer / 60);
            if (this._cdIngot <= 0 || _view.ingotEnough(this._cdIngot) == false)
            {
                return;
            }
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.TravelEventCD))
            {
                this.dialog.yesLabel = TravelEventViewLang.Sure;
                this.dialog.cancelLabel = TravelEventViewLang.Cancel;
                this.dialog.hasCheckbox = true;
                callback = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    cancel_cd();
                }
                if (dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.TravelEventCD, true);
                }
                return;
            }// end function
            ;
                this.dialog.show(Lang.sprintf(TravelEventViewLang.ClearCd, HtmlText.yellow(this._cdIngot + TravelEventViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
            }
            else
            {
                this.cancel_cd();
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            this._travelEvent.close();
            this._answerValue = [];
            return;
        }// end function

    }
}
