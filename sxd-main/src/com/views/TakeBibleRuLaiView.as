package com.views
{
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class TakeBibleRuLaiView extends Base implements IView
    {
        private var _ruLai:ITakeBibleRuLai;
        private var _frameSpriteAry:Array;
        private var _canCallTimes:int;
        private var _sitPointAry:Array;

        public function TakeBibleRuLaiView()
        {
            this._frameSpriteAry = [];
            this._sitPointAry = [93, 310, 166, 380, 288, 406, 406, 380, 483, 310];
            return;
        }// end function

        public function show() : void
        {
            this.openRuLai();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            if (inStage)
            {
                _data.cancelPatch(Mod_TakeBible_Base.notify_call_rulai);
                _data.call(Mod_TakeBible_Base.close_call_rulai, null, []);
                _popup.closeView(this);
            }
            return;
        }// end function

        public function clear() : void
        {
            if (this._ruLai == null)
            {
                return;
            }
            this.clearPlayer();
            this._ruLai.clear();
            this.dialog.hide();
            this._view.removeFromFrameProcessList(String(this));
            return;
        }// end function

        private function clearPlayer() : void
        {
            var _loc_3:IFrameSprite = null;
            var _loc_1:* = this._frameSpriteAry.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._frameSpriteAry.pop();
                if (this._ruLai.content.contains(_loc_3.com.assist.view.interfaces.base:IContent::content))
                {
                    this._ruLai.content.removeChild(_loc_3.com.assist.view.interfaces.base:IContent::content);
                }
                _loc_3 = null;
                _loc_2++;
            }
            this._frameSpriteAry = [];
            return;
        }// end function

        private function openRuLai() : void
        {
            _data.call(Mod_TakeBible_Base.open_call_rulai, this.openRuLaiCallBack, []);
            return;
        }// end function

        private function call(param1:int) : void
        {
            _data.call(Mod_TakeBible_Base.call_rulai, this.callCallBack, [param1]);
            return;
        }// end function

        private function openRuLaiCallBack() : void
        {
            loadAssets("TakeBibleRuLai", this.render, TakeBibleRuLaiViewLang.Open);
            return;
        }// end function

        public function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        private function getTakeBibleUpdataData() : void
        {
            _data.call(Mod_TakeBible_Base.get_take_bible_updata_data, this.takeBibleUpdataDataCallBack, []);
            return;
        }// end function

        private function render() : void
        {
            if (this._ruLai == null)
            {
                this._ruLai = _view.getAssetsObject("TakeBibleRuLai", "TakeBibleRuLai") as ITakeBibleRuLai;
            }
            this._ruLai.tip = _view.tip.iTip;
            this._ruLai.showMessage = this.showMessage;
            this._ruLai.drag = _view.drag.iDrag;
            this._ruLai.onClose = this.close;
            this._ruLai.ingot = _ctrl.player.ingot;
            this._ruLai.onCall = function (param1:String, param2:int) : void
            {
                var callback:Function;
                var info:* = param1;
                var type:* = param2;
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.CanBaiRuLai))
                {
                    dialog.yesLabel = TakeBibleRuLaiViewLang.Sure;
                    dialog.cancelLabel = TakeBibleRuLaiViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        call(type);
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.CanBaiRuLai, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(info, AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    call(type);
                }
                return;
            }// end function
            ;
            this._ruLai.onZhaoHuan = function (param1:String, param2:int) : void
            {
                var callback:Function;
                var info:* = param1;
                var type:* = param2;
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.ZhaoHuanSanXian))
                {
                    dialog.yesLabel = TakeBibleRuLaiViewLang.Sure;
                    dialog.cancelLabel = TakeBibleRuLaiViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        call(type);
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.ZhaoHuanSanXian, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(info, AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    call(type);
                }
                return;
            }// end function
            ;
            _popup.addView(this, this._ruLai.content);
            _view.center(sign, this._ruLai.content);
            this.renderRuLai();
            this._ruLai.ruLaiData = this.renderCallList();
            this.getTakeBibleUpdataData();
            this._ruLai.render();
            _view.addToFrameProcessList(String(this), this.enterFrameHandler);
            _data.patch(Mod_TakeBible_Base.notify_call_rulai, this.notifyCallRuLaiCallBack);
            return;
        }// end function

        private function enterFrameHandler() : void
        {
            var _loc_3:IFrameSprite = null;
            if (inStage == false)
            {
                _view.removeFromFrameProcessList(String(this));
                return;
            }
            var _loc_1:* = this._frameSpriteAry.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._frameSpriteAry[_loc_2] as IFrameSprite;
                _loc_3.pass(_view.time2);
                _loc_2++;
            }
            return;
        }// end function

        private function renderCallList() : Array
        {
            var _loc_3:Object = null;
            var _loc_1:* = _ctrl.player.playerId;
            var _loc_2:* = _ctrl.TakeBible.callList;
            for each (_loc_3 in _loc_2)
            {
                
                _loc_3["isSelf"] = _loc_1 == _loc_3["player_id"];
            }
            return _loc_2;
        }// end function

        private function renderRuLai() : void
        {
            var _loc_2:Object = null;
            var _loc_1:* = _ctrl.TakeBible.openCallRuLai;
            this._ruLai.isCalled = this.checkCalled(_loc_1);
            for each (_loc_2 in _loc_1)
            {
                
                this._ruLai.awardstate = this.checkAwardState(_loc_1);
                this.addNewPlayer(_loc_2["isZhaoHuan"], _loc_2["sign"]);
            }
            this._ruLai.memberNum = _loc_1.length;
            return;
        }// end function

        public function checkAwardState(param1:Array) : Number
        {
            var _loc_6:Object = null;
            var _loc_2:Number = 0;
            var _loc_3:* = _ctrl.player.playerId;
            var _loc_4:* = param1.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = param1[_loc_5];
                if (_loc_6.player_id == _loc_3)
                {
                    _loc_2 = _loc_2 + 0.2;
                }
                _loc_5++;
            }
            if (_loc_2 != 0)
            {
                return _loc_2;
            }
            return 0.1;
        }// end function

        private function checkCalled(param1:Array) : Boolean
        {
            var _loc_3:Object = null;
            var _loc_2:* = _ctrl.player.playerId;
            for each (_loc_3 in param1)
            {
                
                if (_loc_2 == _loc_3["player_id"])
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function addNewPlayer(param1:int, param2:String) : void
        {
            var _loc_3:IFrameSprite = null;
            if (this._frameSpriteAry.length == 5)
            {
                return;
            }
            _loc_3 = MapStatic.mapInstance.frame;
            _loc_3.shadowVisible = false;
            if (param1 == Mod_TakeBible_Base.CT_HELPER)
            {
                _loc_3.initUrl(RoleType.SanXianDaZuo, "stand");
            }
            else if (param1 == Mod_TakeBible_Base.CT_SELF)
            {
                _loc_3.initUrl(param2, "seat");
            }
            _loc_3.pass(_view.time2);
            _loc_3.com.assist.view.interfaces.base:IContent::content.x = this._sitPointAry[this._frameSpriteAry.length * 2];
            _loc_3.com.assist.view.interfaces.base:IContent::content.y = this._sitPointAry[this._frameSpriteAry.length * 2 + 1];
            this._ruLai.content.addChild(_loc_3.com.assist.view.interfaces.base:IContent::content);
            this._frameSpriteAry.push(_loc_3);
            this._ruLai.memberNum = this._frameSpriteAry.length;
            return;
        }// end function

        private function callCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.callRulai;
            var _loc_2:* = _ctrl.TakeBible.callList;
            if (_loc_1 == Mod_TakeBible_Base.SUCCESS)
            {
                this._ruLai.isCalled = true;
            }
            else
            {
                this.showMessage(_loc_1);
            }
            return;
        }// end function

        private function notifyCallRuLaiCallBack() : void
        {
            var _loc_3:Object = null;
            var _loc_1:* = _ctrl.TakeBible.notifyCallRuLaiType;
            var _loc_2:* = _ctrl.TakeBible.notifyCallRuLai;
            this._ruLai.ruLaiData = this.renderCallList();
            if (_loc_1 == Mod_TakeBible_Base.PLAYER_CHANGE)
            {
                this.clearPlayer();
                for each (_loc_3 in _loc_2)
                {
                    
                    this.addNewPlayer(_loc_3["isZhaoHuan"], _loc_3["sign"]);
                }
                this._ruLai.awardstate = this.checkAwardState(_loc_2);
            }
            return;
        }// end function

        private function takeBibleUpdataDataCallBack() : void
        {
            var _loc_1:* = _ctrl.TakeBible.takeBibleUpdataData;
            if (this._ruLai != null)
            {
                this._ruLai.canCallruLaiTime = _loc_1.canCalruLaiTime;
            }
            return;
        }// end function

        private function showMessage(param1:int) : void
        {
            switch(param1)
            {
                case Mod_TakeBible_Base.CLOSE:
                {
                    _view.showTip(TakeBibleRuLaiViewLang.Close);
                    break;
                }
                case Mod_TakeBible_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(TakeBibleRuLaiViewLang.NotEnoughIngot);
                    break;
                }
                case Mod_TakeBible_Base.CALLED:
                {
                    _view.showTip(TakeBibleRuLaiViewLang.Called);
                    break;
                }
                case Mod_TakeBible_Base.REQUEST_VIP:
                {
                    _view.showTip(TakeBibleRuLaiViewLang.RequestVip);
                    break;
                }
                case Mod_TakeBible_Base.TIMEUSED:
                {
                    _view.showTip(TakeBibleRuLaiViewLang.TimeUsed);
                    break;
                }
                case Mod_TakeBible_Base.CALL_FAILED:
                {
                    _view.showTip(TakeBibleRuLaiViewLang.CallFailed);
                    break;
                }
                case Mod_TakeBible_Base.FULL:
                {
                    _view.showTip(TakeBibleRuLaiViewLang.Full);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
