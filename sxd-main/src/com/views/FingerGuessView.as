package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class FingerGuessView extends Base implements IView
    {
        private var _fingerGuessData:Object;
        private var _isGameStart:Boolean = true;
        private var _isEnterRoom:Boolean = false;
        private var _fingerGuess:IFingerGuess;

        public function FingerGuessView()
        {
            return;
        }// end function

        public function get_bag_list() : void
        {
            _data.call(Mod_FingerGuess_Base.finger_guess_state, this.fingerGuessStateCallBack, []);
            _data.patch(Mod_FingerGuess_Base.finger_guess_state, this.fingerGuessStateCallBack);
            return;
        }// end function

        public function enter_room() : void
        {
            _data.call(Mod_FingerGuess_Base.enter_room, this.enterRoomCallBack, []);
            return;
        }// end function

        private function fight(param1:int) : void
        {
            _data.call(Mod_FingerGuess_Base.fight, this.fightCallBack, [param1]);
            return;
        }// end function

        private function award() : void
        {
            _data.patch(Mod_FingerGuess_Base.award, this.awardCallBack);
            return;
        }// end function

        private function is_fight() : void
        {
            _data.patch(Mod_FingerGuess_Base.is_fight, this.isFightCallBack);
            return;
        }// end function

        public function today_times(param1:Function = null) : void
        {
            _data.call(Mod_FingerGuess_Base.today_times, param1, []);
            return;
        }// end function

        private function fingerGuessStateCallBack() : void
        {
            var data:Object;
            data = _ctrl.fingerGuess.FingerGuessState;
            var func:* = function () : void
            {
                showBtn(data);
                return;
            }// end function
            ;
            this.today_times(func);
            if (data.state == Mod_FingerGuess_Base.RUN)
            {
                this._isGameStart = data.playerList.length > 1;
                this._fingerGuessData = data;
                if (this.inStage == false)
                {
                    if (this._isEnterRoom)
                    {
                        this.show();
                    }
                    else
                    {
                        this.gotoRoom();
                    }
                }
                else
                {
                    this.render();
                }
            }
            this._isEnterRoom = false;
            return;
        }// end function

        private function gotoRoom() : void
        {
            this.dialog.yesLabel = FingerGuessViewLang.Yes;
            this.dialog.cancelLabel = FingerGuessViewLang.Cancel;
            var callback:* = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    show();
                }
                if (param1 == AlertButtonType.Cancel)
                {
                }
                return;
            }// end function
            ;
            this.dialog.show(FingerGuessViewLang.GoToRoom, AlertButtonType.Yes | AlertButtonType.Cancel, callback);
            return;
        }// end function

        private function showBtn(param1:Object) : void
        {
            var _loc_4:Boolean = false;
            var _loc_5:Date = null;
            var _loc_6:int = 0;
            var _loc_7:Number = NaN;
            var _loc_2:Object = {};
            var _loc_3:* = new Date(_ctrl.player.serverTime * 1000);
            if (param1.state == Mod_FingerGuess_Base.RUN || param1.state == Mod_FingerGuess_Base.START)
            {
                _loc_4 = _ctrl.fingerGuess.TodayTimes > 0;
                _loc_2.state = _loc_4 ? (1) : (2);
                _loc_2.info = _loc_4 ? (FingerGuessViewLang.isChangeTrue) : (FingerGuessViewLang.isChangeFalse);
                if (_loc_4 == false)
                {
                    _loc_2.info = HtmlText.format(_loc_2.info, 10066329);
                }
                _loc_2.showEffect = _loc_4;
                _view.activityDuanWu.caiQuanState(_loc_2);
                _view.activities.showActivityTitle(ActivityType.ActivityDuanWu, FingerGuessViewLang.caicaiquan);
                _view.activities.visibleBtnEffect(ActivityType.ActivityDuanWu, FingerGuessViewLang.caicaiquan, _loc_4);
            }
            else
            {
                _loc_5 = new Date(2012, 6, 22);
                _loc_6 = this._ctrl.player.serverTime;
                _loc_7 = _loc_5.time / 1000;
                if (_loc_7 <= _loc_6)
                {
                    _loc_2.info = _loc_3.hours < 22 ? (FingerGuessViewLang.hoursTrue) : (FingerGuessViewLang.hoursFalse);
                }
                else
                {
                    _loc_2.info = FingerGuessViewLang.hoursTrue;
                }
                _loc_2.info = HtmlText.format(_loc_2.info, 10066329);
                _loc_2.state = 2;
                _loc_2.showEffect = false;
                _view.activityDuanWu.caiQuanState(_loc_2);
                _view.activities.visibleBtnEffect(ActivityType.ActivityDuanWu, FingerGuessViewLang.caicaiquan, false);
                _view.activities.hideActivityTimer(ActivityType.ActivityDuanWu, FingerGuessViewLang.caicaiquan);
            }
            return;
        }// end function

        private function enterRoomCallBack() : void
        {
            var _loc_2:Object = null;
            var _loc_1:* = _ctrl.fingerGuess.EnterRoom;
            this._isEnterRoom = true;
            if (_loc_1.state == Mod_FingerGuess_Base.WAIT)
            {
                this._fingerGuessData = {};
                _loc_2 = {};
                _loc_2.playerId = _ctrl.player.playerId;
                _loc_2.isPlayer = true;
                _loc_2.nickName = _ctrl.player.nickname;
                _loc_2.zongZhi = 0;
                _loc_2.isLandlord = true;
                _loc_2.roleId = _ctrl.player.mainRoleId;
                _loc_2.roleSign = RoleType.getRoleSign(_loc_2.roleId);
                _loc_2.roleSign = _loc_2.roleSign + _ctrl.player.signSuffix;
                _loc_2.roleUrl = URI.warRolesUrl + _loc_2.roleSign + ".swf";
                _loc_2.isFight = false;
                this._fingerGuessData.playerList = [_loc_2];
                this._isGameStart = false;
                if (this.inStage)
                {
                    this.render();
                }
                else
                {
                    this.show();
                }
            }
            else if (_loc_1.state == Mod_FingerGuess_Base.AT_ROOM)
            {
                this.get_bag_list();
            }
            else
            {
                this.renderMsg(_loc_1.state);
            }
            return;
        }// end function

        private function fightCallBack() : void
        {
            var _loc_1:* = _ctrl.fingerGuess.Fight;
            if (_loc_1.state == Mod_FingerGuess_Base.SUCCESS)
            {
                this._fingerGuess.MainChuQuanSuccess();
            }
            return;
        }// end function

        private function awardCallBack() : void
        {
            var _loc_1:* = _ctrl.fingerGuess.Award;
            this._fingerGuess.getAward(_loc_1);
            return;
        }// end function

        private function isFightCallBack() : void
        {
            var _loc_1:* = _ctrl.fingerGuess.IsFight;
            if (_loc_1.result == Mod_FingerGuess_Base.YES)
            {
                this._fingerGuess.OtherChuQuan2Success();
            }
            return;
        }// end function

        private function renderMsg(param1:String) : void
        {
            switch(param1)
            {
                case Mod_FingerGuess_Base.OFF:
                {
                    _view.showTip(FingerGuessViewLang.OFF);
                    break;
                }
                case Mod_FingerGuess_Base.AT_ROOM:
                {
                    _view.showTip(FingerGuessViewLang.AT_ROOM);
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
            loadAssets("FingerGuess", this.render, FingerGuessViewLang.LoadAssets);
            return;
        }// end function

        private function render() : void
        {
            if (this._fingerGuess == null)
            {
                this._fingerGuess = _view.getAssetsObject("FingerGuess", "FingerGuess") as IFingerGuess;
                this._fingerGuess.tip = _view.tip.iTip;
                this._fingerGuess.drag = _view.drag.iDrag;
            }
            _popup.addView(this, this._fingerGuess.content);
            this._fingerGuess.onClose = function () : void
            {
                if (_isGameStart)
                {
                    gameQuit();
                }
                else
                {
                    close();
                }
                return;
            }// end function
            ;
            this._fingerGuess.onChuQuan = function (param1:int) : void
            {
                fight(param1);
                return;
            }// end function
            ;
            this._fingerGuess.onGameEnd = function (param1:int, param2:int) : void
            {
                var _loc_3:* = _ctrl.fingerGuess.TodayTimes;
                if (_loc_3 > 0)
                {
                    gameEndTip(param1, _loc_3);
                }
                else
                {
                    gameEndTip1(param1);
                }
                return;
            }// end function
            ;
            this._fingerGuess.init();
            this._fingerGuess.fingerGuessData(this._fingerGuessData);
            this.award();
            this.is_fight();
            this.reposition();
            _view.chat.updateDepth(this);
            _view.closeEvent();
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        public function gameEndTip(param1:int, param2:int) : void
        {
            var zzNum:* = param1;
            var lostNum:* = param2;
            this.dialog.yesLabel = FingerGuessViewLang.jiXu;
            this.dialog.cancelLabel = FingerGuessViewLang.Quit;
            var callback:* = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    clear();
                    enter_room();
                }
                if (param1 == AlertButtonType.Cancel)
                {
                    close();
                }
                return;
            }// end function
            ;
            this.dialog.show(Lang.sprintf(FingerGuessViewLang.gameEndTip, zzNum, lostNum), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
            return;
        }// end function

        public function gameEndTip1(param1:int) : void
        {
            var zzNum:* = param1;
            this.dialog.yesLabel = FingerGuessViewLang.Quit;
            var callback:* = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    close();
                }
                return;
            }// end function
            ;
            this.dialog.show(Lang.sprintf(FingerGuessViewLang.gameEndTip1, zzNum), AlertButtonType.Yes, callback);
            return;
        }// end function

        public function gameQuit() : void
        {
            this.dialog.yesLabel = FingerGuessViewLang.Yes;
            this.dialog.cancelLabel = FingerGuessViewLang.Cancel;
            var callback:* = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    close();
                }
                if (param1 == AlertButtonType.Cancel)
                {
                }
                return;
            }// end function
            ;
            this.dialog.show(FingerGuessViewLang.gameQuit, AlertButtonType.Yes | AlertButtonType.Cancel, callback);
            return;
        }// end function

        public function clear() : void
        {
            this._fingerGuess.clear();
            return;
        }// end function

        public function close() : void
        {
            _view.openEvent();
            this._isEnterRoom = false;
            this.clear();
            _data.cancelPatch(Mod_FingerGuess_Base.award);
            _data.cancelPatch(Mod_FingerGuess_Base.is_fight);
            _popup.closeView(this);
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
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
                this._fingerGuess.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

    }
}
