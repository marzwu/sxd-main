package com.views
{
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class RedEnvelopesView extends Base implements IView
    {
        private var _redEnvelopes:IRedEnvelopes;
        private var _showLen:int = 0;

        public function RedEnvelopesView()
        {
            return;
        }// end function

        public function show() : void
        {
            _inStageTipTitle = "";
            this.get_envelopes_info();
            return;
        }// end function

        private function renderShow() : void
        {
            loadAssets("RedEnvelopes", this.render, RedEnvelopesViewLang.LoadAssets);
            return;
        }// end function

        public function get_envelopes_info() : void
        {
            _data.call(Mod_RedEnvelopes_Base.get_envelopes_info, this.getEnvelopesCallBack, []);
            return;
        }// end function

        public function envelopesList() : void
        {
            _data.call(Mod_RedEnvelopes_Base.get_envelopes_info, this.showEnvelopesCallBack, []);
            return;
        }// end function

        public function getDate() : void
        {
            this._data.call(Mod_RedEnvelopes_Base.get_date, this.getDateCallBack, []);
            return;
        }// end function

        public function get_envelope(param1:int) : void
        {
            _data.call(Mod_RedEnvelopes_Base.get_envelope, this.getEnvelopeCallBack, [param1]);
            return;
        }// end function

        private function getEnvelopesCallBack() : void
        {
            var _loc_1:Array = null;
            if (this.inStage)
            {
                _loc_1 = _ctrl.redEnvelopes.getEnvelopsList;
                this._showLen = _loc_1.length;
                this._redEnvelopes.getPackedList(_loc_1);
                this._redEnvelopes.lostTimeInfo = _ctrl.redEnvelopes.showTime;
            }
            else
            {
                this.renderShow();
            }
            return;
        }// end function

        private function showEnvelopesCallBack() : void
        {
            var _loc_1:* = _ctrl.redEnvelopes.getEnvelopsList;
            var _loc_2:* = new Date(2012, 0, 27);
            var _loc_3:* = _loc_2.time / 1000;
            if (_loc_1.length > 0 || _ctrl.player.serverTime < _loc_3)
            {
                _view.activities.addActivity(ActivityType.RedEnvelopes);
            }
            return;
        }// end function

        private function getEnvelopeCallBack() : void
        {
            var _loc_1:* = _ctrl.redEnvelopes.GetEnvelope;
            if (_loc_1.msg == Mod_RedEnvelopes_Base.SUCCESS)
            {
                _view.showTip(RedEnvelopesViewLang.GetSuccess, "", TipType.Success);
                this.get_envelopes_info();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function getDateCallBack() : void
        {
            var _loc_1:* = _ctrl.redEnvelopes.GetDate;
            this.envelopesList();
            return;
        }// end function

        private function renderMsg(param1:Object) : void
        {
            switch(param1.msg)
            {
                case Mod_RedEnvelopes_Base.SUCCESS:
                {
                    break;
                }
                case Mod_RedEnvelopes_Base.TIME_ERROR:
                {
                    _view.showTip(RedEnvelopesViewLang.TimeError);
                    break;
                }
                case Mod_RedEnvelopes_Base.NO_GRID:
                {
                    _view.showTip(RedEnvelopesViewLang.NoGrid);
                    break;
                }
                case Mod_RedEnvelopes_Base.FAILURE:
                {
                    _view.showTip(RedEnvelopesViewLang.Failure);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        private function render() : void
        {
            this._redEnvelopes = _view.getAssetsObject("RedEnvelopes", "RedEnvelopes") as IRedEnvelopes;
            _popup.addView(this, this._redEnvelopes.content);
            this._redEnvelopes.tip = _view.tip.iTip;
            this._redEnvelopes.drag = _view.drag.iDrag;
            _view.center(sign, this._redEnvelopes.content);
            this._redEnvelopes.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._redEnvelopes.onTip = function (param1:String) : void
            {
                return;
            }// end function
            ;
            this._redEnvelopes.onGetEnvelope = function (param1:int) : void
            {
                get_envelope(param1);
                return;
            }// end function
            ;
            this.getEnvelopesCallBack();
            return;
        }// end function

        public function close() : void
        {
            var _loc_1:* = new Date(2012, 0, 27);
            var _loc_2:* = _loc_1.time / 1000;
            if (this._showLen <= 0 && _ctrl.player.serverTime > _loc_2)
            {
                _view.activities.removeActivity(ActivityType.RedEnvelopes);
            }
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._redEnvelopes.clear();
            return;
        }// end function

    }
}
