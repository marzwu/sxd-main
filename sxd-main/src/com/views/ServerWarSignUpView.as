package com.views
{
    import com.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.serverWar.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class ServerWarSignUpView extends Base implements IView
    {
        private var _target:IServerWarSignUp;
        private var _info:ServerWarInfo;
        private var _date:Date;

        public function ServerWarSignUpView()
        {
            this._date = new Date();
            return;
        }// end function

        public function show() : void
        {
            this._info = _ctrl.serverWar.info;
            loadAssets("ServerWarSignUp", null, ServerWarSignUpViewLang.Loadding, false, false, this.loadComplete);
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
            this._info = _ctrl.serverWar.info;
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
                this._target = _view.getAssetsObject("ServerWarSignUp", "MCSignUp") as IServerWarSignUp;
                this._target.onSignUp = this.onSignUp;
                this._target.onClose = this.close;
                this._target.onSeeWorld = this.onSeeWorld;
                this._target.onTip = this.onTip;
                this._target.giftMsg = "<u><a href=\'event:aaa\'>" + ServerWarSignUpViewLang.Page + "</a></u>";
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
                case Mod_ServerWar_Base.SERVER_WAR_PREPARE:
                {
                    if (this._info.isThisService)
                    {
                        this._target.signUpMsg = HtmlText.red(ServerWarSignUpViewLang.SignUpNoStart);
                    }
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_APPLY:
                {
                    if (this._info.statePlayer == Mod_ServerWar_Base.SERVER_WAR_APPLY)
                    {
                        this._target.signUpMsg = HtmlText.green(ServerWarSignUpViewLang.SignUpComplete);
                    }
                    else if (this._info.isThisService)
                    {
                        this._target.signupBtnVisible = true;
                    }
                    break;
                }
                case Mod_ServerWar_Base.SERVER_WAR_TIANBANG:
                case Mod_ServerWar_Base.SERVER_WAR_DIBANG:
                {
                    this._target.signUpMsg = _ctrl.serverWar.dieoutTip;
                    break;
                }
                default:
                {
                    if (this._info.isCrossService)
                    {
                        this._target.signUpMsg = "";
                    }
                    else if (this._info.statePlayer == Mod_ServerWar_Base.SERVER_WAR_APPLY)
                    {
                        this._target.signUpMsg = HtmlText.green(ServerWarSignUpViewLang.SignUpComplete);
                    }
                    else
                    {
                        this._target.signUpMsg = HtmlText.red(ServerWarSignUpViewLang.SignUpStop);
                    }
                    break;
                    break;
                }
            }
            var _loc_1:String = "";
            if (this._info.isThisService)
            {
                _loc_1 = HtmlText.yellow2(ServerWarSignUpViewLang.AwardTip1) + "\n";
                _loc_1 = _loc_1 + Lang.sprintf(ServerWarSignUpViewLang.AwardTip3, HtmlText.purple(ServerWarSignUpViewLang.Award20000Fame), HtmlText.green(ServerWarSignUpViewLang.Award1000Coin), HtmlText.yellow2(ServerWarSignUpViewLang.AwardMount1));
                this._target.giftTip = _loc_1;
                this._target.seeWorldMsg = "";
                this._target.titleMsg = "<b>" + ServerWarSignUpViewLang.WarNameServer + "</b>";
                this._target.ruleMsg = HtmlText.format(ServerWarSignUpViewLang.RuleServer, 9992004, 14, "", true) + "\n" + HtmlText.format(this.ruleServer, 9992004, 12);
            }
            else
            {
                _loc_1 = HtmlText.yellow2(ServerWarSignUpViewLang.AwardTip2) + "\n";
                _loc_1 = _loc_1 + Lang.sprintf(ServerWarSignUpViewLang.AwardTip4, HtmlText.purple(ServerWarSignUpViewLang.Award60000Fame), HtmlText.green(ServerWarSignUpViewLang.Award8000Coin), HtmlText.yellow2(ServerWarSignUpViewLang.QiPinJuanZhou), HtmlText.yellow2(ServerWarSignUpViewLang.AwardYuPai18), HtmlText.yellow2(ServerWarSignUpViewLang.AwardMount2), HtmlText.yellow2(ServerWarSignUpViewLang.Star), HtmlText.yellow2(ServerWarSignUpViewLang.InLine), HtmlText.yellow2(ServerWarSignUpViewLang.WorldFirst));
                this._target.giftTip = _loc_1;
                this._target.seeWorldMsg = HtmlText.blue("<u><a href=\'event:aaa\'>" + ServerWarSignUpViewLang.SeeWorld + "</a></u>");
                this._target.titleMsg = "<b>" + ServerWarSignUpViewLang.WarNameWorld + "</b>";
                this._target.ruleMsg = HtmlText.format(ServerWarSignUpViewLang.RuleWorld, 9992004, 14, "", true) + "\n" + HtmlText.format(this.ruleWorld, 9992004, 12);
            }
            return;
        }// end function

        private function get ruleWorld() : String
        {
            var _loc_1:Array = [];
            var _loc_2:int = 0;
            _loc_1.push(++_loc_2 + "、" + ServerWarSignUpViewLang.SignUpTip11);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_PREPARE) + ServerWarSignUpViewLang.ToReadyTime);
            _loc_1.push(++_loc_2 + "、" + ServerWarSignUpViewLang.ReadyTime);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_TIANBANG) + ServerWarSignUpViewLang.WarTianBang);
            _loc_1.push(++_loc_2 + "、" + this.getTime_MD(Mod_ServerWar_Base.SERVER_WAR_TIANBANG) + ServerWarSignUpViewLang.WarDiBang);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_16) + ServerWarSignUpViewLang.War16);
            _loc_1.push(++_loc_2 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_8) + ServerWarSignUpViewLang.War8);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_4) + ServerWarSignUpViewLang.War4);
            _loc_1.push(++_loc_2 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_2) + ServerWarSignUpViewLang.War2);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_1) + ServerWarSignUpViewLang.War1);
            return _loc_1.join("\n");
        }// end function

        private function get ruleServer() : String
        {
            var _loc_1:Array = [];
            var _loc_2:int = 0;
            _loc_1.push(++_loc_2 + "、" + ServerWarSignUpViewLang.SignUpLeveReq);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + Lang.sprintf(ServerWarSignUpViewLang.SignUpTime, this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_APPLY), this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_APPLY_COMPLETE)));
            _loc_1.push(++_loc_2 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_TIANBANG) + ServerWarSignUpViewLang.WarTianBang);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MD(Mod_ServerWar_Base.SERVER_WAR_TIANBANG) + ServerWarSignUpViewLang.WarDiBang);
            _loc_1.push(++_loc_2 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_16) + ServerWarSignUpViewLang.War16);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_8) + ServerWarSignUpViewLang.War8);
            _loc_1.push(++_loc_2 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_4) + ServerWarSignUpViewLang.War4);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_2) + ServerWarSignUpViewLang.War2);
            _loc_1.push(++_loc_2 + "、" + this.getTime_MDHI(Mod_ServerWar_Base.SERVER_WAR_1) + ServerWarSignUpViewLang.War1);
            _loc_2 = ++_loc_2 + 1;
            _loc_1.push(++_loc_2 + 1 + "、" + ServerWarSignUpViewLang.SignUpTip10);
            return _loc_1.join("\n");
        }// end function

        private function getTime_MDHI(param1:int) : String
        {
            var _loc_2:* = this._info.getRoundTime(param1) * 1000;
            var _loc_3:* = this.getDateArray(_loc_2);
            var _loc_4:* = new Date();
            if (new Date().date == _loc_3[1])
            {
                return ServerWarSignUpViewLang.Today + _loc_3[2] + ":" + _loc_3[3];
            }
            _loc_4.time = _loc_4.time + 24 * 3600000;
            if (_loc_4.date == _loc_3[1])
            {
                return ServerWarSignUpViewLang.Tomorrow + _loc_3[2] + ":" + _loc_3[3];
            }
            return _loc_3[0] + ServerWarSignUpViewLang.Moth + _loc_3[1] + ServerWarSignUpViewLang.Day + " " + _loc_3[2] + ":" + _loc_3[3];
        }// end function

        private function getTime_MD(param1:int) : String
        {
            var _loc_2:* = this._info.getRoundTime(param1) * 1000;
            var _loc_3:* = this.getDateArray(_loc_2);
            var _loc_4:* = new Date();
            if (new Date().date == _loc_3[1])
            {
                return ServerWarSignUpViewLang.Today;
            }
            _loc_4.time = _loc_4.time + 24 * 3600000;
            if (_loc_4.date == _loc_3[1])
            {
                return ServerWarSignUpViewLang.Tomorrow;
            }
            return _loc_3[0] + ServerWarSignUpViewLang.Moth + _loc_3[1] + ServerWarSignUpViewLang.Day;
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
            _data.call(Mod_ServerWar_Base.apply, this.apply_back, []);
            return;
        }// end function

        private function apply_back() : void
        {
            switch(_ctrl.serverWar.signupState)
            {
                case Mod_ServerWar_Base.SUCCESS:
                {
                    _view.showTip(ServerWarSignUpViewLang.SignUpSuccess, null, TipType.Success);
                    break;
                }
                case Mod_ServerWar_Base.REQUEST_LEVEL:
                {
                    _view.showTip(ServerWarSignUpViewLang.SignUpLeve);
                    break;
                }
                default:
                {
                    _view.showTip(ServerWarSignUpViewLang.SignUpFails);
                    break;
                    break;
                }
            }
            _view.activities.serverInit();
            return;
        }// end function

    }
}
