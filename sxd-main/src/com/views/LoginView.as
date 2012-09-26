package com.views
{
    import com.assist.*;
    import com.assist.view.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class LoginView extends Base implements IView
    {
        private var _first:Boolean;

        public function LoginView()
        {
            return;
        }// end function

        public function show() : void
        {
            var lr:* = new LoadResponder(this.login, function (param1:String, param2:int) : void
            {
                _view.showViewProcess(param1, param2);
                return;
            }// end function
            );
            _view.loadResources(["InitLoading" + _view.initLoading.logoSuffix, "Alert"], lr);
            return;
        }// end function

        private function login() : void
        {
            _view.initLoading.show();
            var _loc_1:* = URI.playerName || "test";
            var _loc_2:* = URI.hashCode || "I love you!";
            var _loc_3:* = URI.time || Math.floor(new Date().getTime() / 1000).toString();
            Helper.output(_loc_1, _loc_2);
            Helper.backtrace("Mod_Player_Base.login, 1");
            var _loc_4:* = URI.idCard;
            if (URI.nonKid)
            {
                _loc_4 = "";
            }
            _data.call(Mod_Player_Base.login, this.loginCallback, [_loc_1, _loc_2, _loc_3, URI.sourceUrl, URI.regdate, _loc_4]);
            URI.localConnection(_loc_1);
            return;
        }// end function

        private function loginCallback() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            var _loc_3:Date = null;
            var _loc_4:String = null;
            var _loc_5:String = null;
            Helper.backtrace("Mod_Player_Base.login, 0");
            _view.initLoading.jiekou_test();
            switch(_ctrl.player.logined)
            {
                case Mod_Player_Base.SUCCEED:
                {
                    this._first = false;
                    _view.initLoading.loadToolbar();
                    break;
                }
                case Mod_Player_Base.FIRST_TIME:
                {
                    this._first = true;
                    _view.firstLogin(true);
                    _view.initLoading.loadChooseRole();
                    break;
                }
                case Mod_Player_Base.DUPLICATED_NICKNAME:
                {
                    _view.alert.confirm(LoginViewLang.DuplicatedNickName);
                    break;
                }
                case Mod_Player_Base.DISABLE_LOGIN:
                {
                    if (_ctrl.player.enableType != 1)
                    {
                        _loc_1 = _ctrl.player.enableTime;
                        _loc_2 = _loc_1 * 1000;
                        _loc_3 = new Date(_loc_2);
                        _loc_4 = _loc_3.fullYear + LoginViewLang.fullYear + (_loc_3.month + 1) + LoginViewLang.month + _loc_3.date + LoginViewLang.day + _loc_3.hours + LoginViewLang.hours + _loc_3.minutes + LoginViewLang.minutes;
                        _loc_5 = LoginViewLang.DisableLogin + _loc_4;
                        if (_ctrl.player.abnormalTime <= 0)
                        {
                            _view.alert.confirm(_loc_5);
                        }
                        else
                        {
                            _loc_5 = _loc_5 + ("\n" + LoginViewLang.DisableLogin2);
                            _view.alert.confirm(_loc_5);
                        }
                    }
                    break;
                }
                default:
                {
                    _view.alert.confirm(LoginViewLang.DengLuFail);
                    break;
                }
            }
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function get first() : Boolean
        {
            return this._first;
        }// end function

    }
}
