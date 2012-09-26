package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.sound.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.utils.*;

    public class RollCakeView extends Base implements IView
    {
        private var _rollCake:IRollCake;
        private var _autoList:Array;
        private var _rollNum:int = 0;
        private var _count:int = 0;
        private var _isEnd:Boolean = false;
        private var _reollIngot:int = 0;
        private var _userIngotNum:int = 0;
        private var _userIngot:int = 0;
        private var _isCanFree:Boolean = false;
        private var _isPlaySound:Boolean = false;
        private var _isAutoReroll:Boolean = false;
        private var _noMoneyNum:int = 0;
        private var _rerollIngot:int = 0;
        public var endTownId:int = 0;

        public function RollCakeView()
        {
            this._autoList = [];
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
            _inStageTipTitle = RollCakeViewLang.inStageTipTitle;
            _inStageTipContent = "";
            RollCakeType.loadData(this.loadRender);
            return;
        }// end function

        private function loadRender() : void
        {
            this.get_state();
            return;
        }// end function

        public function roll() : void
        {
            _data.call(Mod_RollCake_Base.roll, this.rollCallback, []);
            return;
        }// end function

        public function get_count() : void
        {
            if (FunctionType.isOpened(FunctionType.RollCake) == false)
            {
                return;
            }
            _data.call(Mod_RollCake_Base.get_count, this.getCountCallback, []);
            return;
        }// end function

        public function reroll(param1:int) : void
        {
            this._rollCake.allszAgain();
            _data.call(Mod_RollCake_Base.reroll, this.rerollCallback, []);
            return;
        }// end function

        public function get_award() : void
        {
            _data.call(Mod_RollCake_Base.get_award, this.getAwardCallback, []);
            return;
        }// end function

        public function get_state() : void
        {
            _data.call(Mod_RollCake_Base.get_state, this.getStateCallback, []);
            return;
        }// end function

        public function show_road() : void
        {
            _data.call(Mod_RollCake_Base.get_state, this.showRoadCallback, []);
            return;
        }// end function

        public function is_auto() : void
        {
            _data.call(Mod_RollCake_Base.is_auto, this.isAutoCallback, []);
            return;
        }// end function

        public function set_auto(param1:int) : void
        {
            _data.call(Mod_RollCake_Base.set_auto, this.setAutoCallback, [param1]);
            return;
        }// end function

        public function loadRollCakeData() : void
        {
            RollCakeType.loadData(this.show_road);
            return;
        }// end function

        private function getStateCallback() : void
        {
            var _loc_1:Object = null;
            if (inStage)
            {
                _loc_1 = _ctrl.rollCake.getState;
                if (_loc_1.msg == Mod_RollCake_Base.HAVE_RECORD)
                {
                    this._rollCake.getMainSzData(_loc_1, true);
                }
            }
            else
            {
                loadAssets("RollCake", this.render, RollCakeViewLang.LoadAssets);
            }
            return;
        }// end function

        private function showRoadCallback() : void
        {
            var _loc_5:Object = null;
            var _loc_1:* = _ctrl.rollCake.getState;
            var _loc_2:* = _loc_1.numList;
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2[_loc_4];
                if (_loc_5.num == 0)
                {
                    return;
                }
                _loc_4++;
            }
            this.addRollCakeActivity();
            return;
        }// end function

        private function rollCallback() : void
        {
            var _loc_1:* = _ctrl.rollCake.rollData;
            if (_loc_1.msg == Mod_RollCake_Base.SUCCESS)
            {
                _view.gameHelper.loader_first_info();
                this.get_count();
                if (this.inStage)
                {
                    this._rollCake.getMainSzData(_loc_1, false);
                }
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function isAutoCallback() : void
        {
            var _loc_1:* = _ctrl.rollCake.isAuto;
            this._isAutoReroll = _loc_1 == 1;
            this._rollCake.isAuto = this._isAutoReroll;
            return;
        }// end function

        private function setAutoCallback() : void
        {
            var _loc_1:* = _ctrl.rollCake.setAuto;
            if (_loc_1 == Mod_RollCake_Base.FAILURE)
            {
                _view.showTip(RollCakeViewLang.SET_FAILURE);
            }
            return;
        }// end function

        private function addCountCallback() : void
        {
            return;
        }// end function

        private function getCountCallback() : void
        {
            var _loc_1:* = _ctrl.rollCake.getCount;
            this._count = _loc_1.count;
            if (this.inStage)
            {
                this._rollCake.getCountNum = _loc_1.count;
                this._rollCake.getFreeRobeNum = _loc_1.freeRobeNum;
                this._rollCake.getRobeMaxNum = _loc_1.robeMaxNum;
            }
            else if (_loc_1.count <= 0)
            {
                this.loadRollCakeData();
            }
            else
            {
                this.addRollCakeActivity();
            }
            return;
        }// end function

        private function addRollCakeActivity() : void
        {
            this._view.activities.addActivity(FunctionType.RollCake);
            return;
        }// end function

        private function removeRollCakeActivity() : void
        {
            this._view.activities.removeActivity(FunctionType.RollCake);
            return;
        }// end function

        private function rerollCallback() : void
        {
            var _loc_1:* = _ctrl.rollCake.rerollData;
            if (_loc_1.msg == Mod_RollCake_Base.SUCCESS)
            {
                if (this.inStage)
                {
                    var _loc_2:String = this;
                    var _loc_3:* = this._rollNum + 1;
                    _loc_2._rollNum = _loc_3;
                    if (this._isAutoReroll && this._rollNum <= 9 && _ctrl.player.ingot >= _ctrl.rollCake.reollIngot && this.isALLJi(_loc_1.numList) == false)
                    {
                        this._isCanFree = _loc_1.canFree > 0;
                        if (this._isCanFree == false && this._rollNum <= 9)
                        {
                            this._userIngot = this._userIngot + _ctrl.rollCake.reollIngot;
                        }
                        this._isPlaySound = false;
                        this.reroll(0);
                    }
                    else
                    {
                        this._rollNum = 0;
                        if (this._isAutoReroll)
                        {
                            this._rerollIngot = this._rerollIngot + this._userIngot;
                            this._rollCake.sureTip = Lang.sprintf(RollCakeViewLang.AllRedirection, this._rerollIngot);
                        }
                    }
                    this._rollCake.getMainSzData(_loc_1, false);
                    this.get_count();
                }
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function isALLJi(param1:Array) : Boolean
        {
            var _loc_4:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1[_loc_3];
                if (_loc_4.num != 4)
                {
                    return false;
                }
                _loc_3++;
            }
            return true;
        }// end function

        private function getAwardCallback() : void
        {
            var _loc_1:* = _ctrl.rollCake.getAward;
            if (_loc_1.msg == Mod_RollCake_Base.SUCCESS)
            {
                _view.setCookie("rollcakeType", {type:0});
                this._isEnd = this._count <= 0;
                setTimeout(this.upPlayerDataCallBack, 1000);
                setTimeout(this.roleCakeExp, 1000);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function upPlayerDataCallBack() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._rollCake.getSkill = _ctrl.player.skill;
            this._rollCake.getStatePoing = _ctrl.player.statePoint;
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_RollCake_Base.FAILURE:
                {
                    _view.showTip(RollCakeViewLang.Fail);
                    break;
                }
                case Mod_RollCake_Base.NO_RECORD:
                {
                    _view.showTip(RollCakeViewLang.NoRecoRd);
                    break;
                }
                case Mod_RollCake_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(RollCakeViewLang.InsufficientIngot);
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
            this._rollCake = _view.getAssetsObject("RollCake", "RollCake") as IRollCake;
            _popup.addView(this, this._rollCake.content);
            this._rollCake.tip = _view.tip.iTip;
            this._rollCake.drag = _view.drag.iDrag;
            this._rollCake.getSkill = _ctrl.player.skill;
            this._rollCake.getStatePoing = _ctrl.player.statePoint;
            this._rollCake.isVip4 = VIPType.check(VIPType.Level0);
            this._rollCake.isVip10 = VIPType.check(VIPType.Level10);
            this.roleCakeExp();
            var obj:* = _view.getCookie("rollcakeType");
            this._rollCake.saveState = obj == null ? (0) : (obj.type);
            this._rollCake.isFirst = !_view.getCookie("rollCakeFirst");
            _view.setCookie("rollCakeFirst", true);
            this.getStateCallback();
            this._rollCake.onGetRoll = function () : void
            {
                _isPlaySound = true;
                roll();
                return;
            }// end function
            ;
            this._rollCake.onRobelRedirection = function (param1:int, param2:Boolean, param3:int) : void
            {
                var callback:Function;
                var szId:* = param1;
                var bool:* = param2;
                var rerollIngot:* = param3;
                _isPlaySound = true;
                _userIngot = 0;
                _rerollIngot = bool == true ? (0) : (rerollIngot);
                _isCanFree = bool;
                if (_ctrl.player.ingot < rerollIngot && bool == false)
                {
                    _view.showTip(RollCakeViewLang.InsufficientIngot);
                    return;
                }
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.RobelRedirection) && bool == false)
                {
                    dialog.yesLabel = RollCakeViewLang.Sure;
                    dialog.cancelLabel = RollCakeViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        reroll(szId);
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.RobelRedirection, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(Lang.sprintf(RollCakeViewLang.RobelRedirection, HtmlText.yellow(_ctrl.rollCake.reollIngot + RollCakeViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    reroll(szId);
                }
                return;
            }// end function
            ;
            this._rollCake.onUserRobel = function () : void
            {
                return;
            }// end function
            ;
            this._rollCake.onSound = function (param1:Sound) : void
            {
                if (_isPlaySound == true)
                {
                    SoundManage.playGameSound(param1);
                }
                return;
            }// end function
            ;
            this._rollCake.onSaveState = function (param1:int) : void
            {
                _view.setCookie("rollcakeType", {type:param1});
                return;
            }// end function
            ;
            this._rollCake.onSureAward = function () : void
            {
                get_award();
                return;
            }// end function
            ;
            this._rollCake.onClose = function () : void
            {
                _isPlaySound = true;
                close();
                return;
            }// end function
            ;
            this._rollCake.onTip = function (param1:String) : void
            {
                switch(param1)
                {
                    case "noCountNum":
                    {
                        _view.showTip(RollCakeViewLang.NoCountNum);
                        ;
                    }
                    case "noRobeNum":
                    {
                        _view.showTip(RollCakeViewLang.NoRobeNum);
                        ;
                    }
                    case "userRobelRedirection":
                    {
                        _view.showTip(RollCakeViewLang.UserRobelRedirection);
                        ;
                    }
                    default:
                    {
                        ;
                    }
                }
                return;
            }// end function
            ;
            this._rollCake.onShowMouse = function (param1:Boolean) : void
            {
                if (param1)
                {
                    MouseCursor.hide();
                }
                else
                {
                    MouseCursor.show();
                }
                return;
            }// end function
            ;
            this._rollCake.onAuto = function (param1:Boolean) : void
            {
                _isAutoReroll = param1;
                return;
            }// end function
            ;
            this._rollCake.init();
            this.is_auto();
            this.get_count();
            this.reposition();
            _view.closeEvent();
            return;
        }// end function

        public function roleCakeExp() : void
        {
            if (this.inStage == false || this._rollCake == null)
            {
                return;
            }
            var _loc_1:* = _ctrl.player.totalStatePoint * 10;
            var _loc_2:* = RollCakeType.expForLevelData(_loc_1);
            this._rollCake.getPointLevel = _loc_2.level;
            this._rollCake.getPoinExp(_loc_2.mainExp, _loc_2.minExp, _loc_2.maxExp);
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            var _loc_2:Point = null;
            if (inStage == false)
            {
                return;
            }
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                _loc_2 = Structure.stageOffset;
                this._rollCake.reposition(_loc_2);
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._isEnd)
            {
                this.removeRollCakeActivity();
            }
            this._rollNum = 0;
            _view.openEvent();
            MouseCursor.show();
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._rollCake.clear();
            return;
        }// end function

    }
}
