package com.views
{
    import com.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.serverFactionWar.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class ServerFactionWarSignUpView extends Base implements IView
    {
        private var _target:IServerFactionWarSignUp;
        private var _info:ServerFactionWarInfo;
        private var _date:Date;

        public function ServerFactionWarSignUpView()
        {
            this._date = new Date();
            return;
        }// end function

        public function show() : void
        {
            this._info = _ctrl.serverFactionWar.info;
            loadAssets("ServerFactionWarSignUp", null, ServerFactionWarSignUpViewLang.Loadding, false, false, this.loadComplete);
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
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
            this.loadComplete();
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._target != null && this._target.content.stage != null;
        }// end function

        public function loadComplete() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("ServerFactionWarSignUp", "MCSignUp") as IServerFactionWarSignUp;
                this._target.onSignUp = this.onSignUp;
                this._target.onClose = this.close;
                this._target.onSeeWorld = this.onSeeWorld;
                this._target.onTip = this.onTip;
                this._target.giftMsg = "<u><a href=\'event:aaa\'>" + ServerFactionWarSignUpViewLang.Page + "</a></u>";
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            if (this.inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            this._target.signupBtnVisible = false;
            this._target.signUpMsg = "";
            switch(this._info.stateServer)
            {
                case Mod_ServerFactionWar_Base.SERVER_WAR_PREPARE:
                {
                    if (this._info.isThisService)
                    {
                        this._target.signUpMsg = HtmlText.red(ServerFactionWarSignUpViewLang.SignUpNoStart);
                    }
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_APPLY:
                {
                    if (this._info.statePlayer == Mod_ServerFactionWar_Base.SERVER_WAR_APPLY)
                    {
                        this._target.signUpMsg = HtmlText.green(ServerFactionWarSignUpViewLang.SignUpComplete);
                    }
                    else if (this._info.isThisService)
                    {
                        this._target.signupBtnVisible = true;
                    }
                    break;
                }
                case Mod_ServerFactionWar_Base.SERVER_WAR_TIANBANG:
                case Mod_ServerFactionWar_Base.SERVER_WAR_DIBANG:
                {
                    this._target.signUpMsg = _ctrl.serverFactionWar.dieoutTip;
                    break;
                }
                default:
                {
                    if (this._info.isCrossService)
                    {
                        this._target.signUpMsg = "";
                    }
                    else if (this._info.statePlayer == Mod_ServerFactionWar_Base.SERVER_WAR_APPLY)
                    {
                        this._target.signUpMsg = HtmlText.green(ServerFactionWarSignUpViewLang.SingTimeOut) + HtmlText.green(ServerFactionWarSignUpViewLang.SignUpComplete);
                    }
                    else
                    {
                        this._target.signUpMsg = HtmlText.red(ServerFactionWarSignUpViewLang.SignUpStop);
                    }
                    break;
                    break;
                }
            }
            var _loc_1:String = "";
            if (this._info.isThisService)
            {
                _loc_1 = HtmlText.yellow2(ServerFactionWarSignUpViewLang.AwardTip1) + "\n";
                _loc_1 = _loc_1 + Lang.sprintf(ServerFactionWarSignUpViewLang.AwardTip3, HtmlText.purple(ServerFactionWarSignUpViewLang.Award20000Fame), HtmlText.green(ServerFactionWarSignUpViewLang.Award1000Coin), HtmlText.yellow(ServerFactionWarSignUpViewLang.AwardCloth));
                this._target.giftTip = _loc_1;
                this._target.seeWorldMsg = "";
                this._target.titleMsg = "<b>" + ServerFactionWarSignUpViewLang.WarNameServer + "</b>";
                this._target.ruleMsg = HtmlText.format(ServerFactionWarSignUpViewLang.RuleServer, 9992004, 14, "", true) + "\n" + HtmlText.format(this.ruleServer, 9992004, 12);
            }
            return;
        }// end function

        private function get ruleServer() : String
        {
            var _loc_1:Array = [];
            var _loc_2:int = 0;
            _loc_1.push(++_loc_2 + "、" + ServerFactionWarSignUpViewLang.SignUpHasLv70);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + ServerFactionWarSignUpViewLang.SignUpLeveReq);
            _loc_1.push(++_loc_2 + "、" + Lang.sprintf(ServerFactionWarSignUpViewLang.SignUpTime, this.getTime_MDHI(Mod_ServerFactionWar_Base.SERVER_WAR_APPLY), this.getTime_MDHI(Mod_ServerFactionWar_Base.SERVER_WAR_APPLY_COMPLETE)));
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MDHI(Mod_ServerFactionWar_Base.SERVER_WAR_TIANBANG) + ServerFactionWarSignUpViewLang.WarTianBang);
            _loc_1.push(++_loc_2 + "、" + this.getTime_MDHI(Mod_ServerFactionWar_Base.SERVER_WAR_16) + ServerFactionWarSignUpViewLang.War16);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MDHI(Mod_ServerFactionWar_Base.SERVER_WAR_8) + ServerFactionWarSignUpViewLang.War8);
            _loc_1.push(++_loc_2 + "、" + this.getTime_MDHI(Mod_ServerFactionWar_Base.SERVER_WAR_4) + ServerFactionWarSignUpViewLang.War4);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MDHI(Mod_ServerFactionWar_Base.SERVER_WAR_2) + ServerFactionWarSignUpViewLang.War2);
            _loc_1.push(++_loc_2 + "、" + this.getTime_MDHI(Mod_ServerFactionWar_Base.SERVER_WAR_1) + ServerFactionWarSignUpViewLang.War1);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + ServerFactionWarSignUpViewLang.SignUpTip10);
            return _loc_1.join("\n");
        }// end function

        private function getTime_MDHI(param1:int) : String
        {
            var _loc_2:* = this._info.getRoundTime(param1) * 1000;
            var _loc_3:* = this.getDateArray(_loc_2);
            var _loc_4:* = new Date();
            if (new Date().date == _loc_3[1])
            {
                return ServerFactionWarSignUpViewLang.Today + _loc_3[2] + ":" + _loc_3[3];
            }
            _loc_4.time = _loc_4.time + 24 * 3600000;
            if (_loc_4.date == _loc_3[1])
            {
                return ServerFactionWarSignUpViewLang.Tomorrow + _loc_3[2] + ":" + _loc_3[3];
            }
            return _loc_3[0] + ServerFactionWarSignUpViewLang.Moth + _loc_3[1] + ServerFactionWarSignUpViewLang.Day + " " + _loc_3[2] + ":" + _loc_3[3];
        }// end function

        private function getTime_MD(param1:int) : String
        {
            var _loc_2:* = this._info.getRoundTime(param1) * 1000;
            var _loc_3:* = this.getDateArray(_loc_2);
            var _loc_4:* = new Date();
            if (new Date().date == _loc_3[1])
            {
                return ServerFactionWarSignUpViewLang.Today;
            }
            _loc_4.time = _loc_4.time + 24 * 3600000;
            if (_loc_4.date == _loc_3[1])
            {
                return ServerFactionWarSignUpViewLang.Tomorrow;
            }
            return _loc_3[0] + ServerFactionWarSignUpViewLang.Moth + _loc_3[1] + ServerFactionWarSignUpViewLang.Day;
        }// end function

        private function getDateArray(param1:Number) : Array
        {
            this._date.time = param1;
            var _loc_2:* = "" + this._date.hours;
            var _loc_3:* = "" + (this._date.minutes < 10 ? ("0" + this._date.minutes) : (this._date.minutes));
            var _loc_4:* = "" + (this._date.seconds < 10 ? ("0" + this._date.seconds) : (this._date.seconds));
            return [(this._date.month + 1), this._date.date, _loc_2, _loc_3, _loc_4, this._date.fullYear];
        }// end function

        private function onSeeWorld() : void
        {
            this._target.initSeeWorld(this._info.worldZone, this._info.serverNameList, _popup);
            return;
        }// end function

        public function onSignUp() : void
        {
            this.apply();
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

        private function apply() : void
        {
            this._target.signupBtnVisible = false;
            if (_ctrl.player.level < 70)
            {
                _view.showTip(ServerFactionWarSignUpViewLang.SignUpLeve);
            }
            _data.call(Mod_ServerFactionWar_Base.apply, this.apply_back, []);
            return;
        }// end function

        private function apply_back() : void
        {
            switch(_ctrl.serverFactionWar.signupState)
            {
                case Mod_ServerFactionWar_Base.SUCCESS:
                {
                    _view.showTip(ServerFactionWarSignUpViewLang.SignUpSuccess, null, TipType.Success);
                    break;
                }
                case Mod_ServerFactionWar_Base.REQUEST_LEVEL:
                {
                    _view.showTip(ServerFactionWarSignUpViewLang.SignUpLeve);
                    break;
                }
                default:
                {
                    _view.showTip(ServerFactionWarSignUpViewLang.SignUpFails);
                    break;
                    break;
                }
            }
            _view.activities.serverFactionInit();
            return;
        }// end function

    }
}
