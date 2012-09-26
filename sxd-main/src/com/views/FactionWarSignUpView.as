package com.views
{
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.factionWar.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.text.*;
    import flash.utils.*;

    public class FactionWarSignUpView extends Base implements IView
    {
        private var _target:IFactionWarSignUp;

        public function FactionWarSignUpView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (inStage)
            {
                return;
            }
            this.get_faction_war_list();
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

        private function loadComplete() : void
        {
            var _loc_1:TextField = null;
            var _loc_2:TextField = null;
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("FactionWarSignUp", "FactionWarSignUp") as IFactionWarSignUp;
                this._target.onSignUp = this.onSignUp;
                this._target.onSee = this.onSee;
                this._target.onClose = this.close;
                _loc_1 = new TextField();
                _loc_1.textColor = 16777215;
                _loc_1.wordWrap = true;
                _loc_1.width = 150;
                _loc_1.htmlText = FactionWarSignUpViewLang.AwardTip1;
                _loc_1.height = _loc_1.textHeight + 5;
                _view.tip.iTip.addTarget(this._target.btnWin1, _loc_1);
                _loc_2 = new TextField();
                _loc_2.textColor = 16777215;
                _loc_2.wordWrap = true;
                _loc_2.width = 150;
                _loc_2.htmlText = FactionWarSignUpViewLang.AwardTip2;
                _loc_2.height = _loc_2.textHeight + 5;
                _view.tip.iTip.addTarget(this._target.btnWin2, _loc_2);
                _view.drag.iDrag.com.assist.view.interfaces:IDrag::addTarget(this._target.dragTitleBar, this._target.content);
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            this._target.btnSignUpVisible = _ctrl.factionWarMap.canSignup == 1 && _ctrl.factionWarMap.isSignup == 0;
            this._target.TFNumMsg = _ctrl.factionWarMap.signupTip;
            return;
        }// end function

        private function onSignUp() : void
        {
            _view.alert.showYesNoMsg(FactionWarSignUpViewLang.AskSignUp, FactionWarSignUpViewLang.Yes, FactionWarSignUpViewLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    sign_up(1);
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function onSee() : void
        {
            this.sign_up_list(1);
            return;
        }// end function

        private function get_faction_war_list() : void
        {
            _data.call(Mod_FactionWar_Base.get_faction_war_list, this.get_faction_war_list_back, []);
            return;
        }// end function

        private function get_faction_war_list_back() : void
        {
            loadAssets("FactionWarSignUp", null, FactionWarSignUpViewLang.Loading, true, false, this.loadComplete);
            return;
        }// end function

        private function sign_up(param1:int) : void
        {
            _data.call(Mod_FactionWar_Base.sign_up, this.sign_up_back, [param1], false);
            return;
        }// end function

        private function sign_up_back() : void
        {
            if (_ctrl.factionWarMap.result == Mod_FactionWar_Base.ACTION_SUCCESS)
            {
                _view.showTip(FactionWarSignUpViewLang.SignUpSuccess, "", TipType.Success);
            }
            else if (_ctrl.factionWarMap.result == Mod_FactionWar_Base.NOT_ENOUGH_COINS)
            {
                _view.showTip(FactionWarSignUpViewLang.CoinLack);
            }
            else
            {
                _view.showTip(FactionWarSignUpViewLang.SignUpFails);
            }
            setTimeout(this.get_faction_war_list, 200);
            return;
        }// end function

        private function sign_up_list(param1:int) : void
        {
            _data.call(Mod_FactionWar_Base.sign_up_list, this.sign_up_list_back, [param1], false);
            return;
        }// end function

        private function sign_up_list_back() : void
        {
            _view.factionWarSignUpList.show();
            return;
        }// end function

    }
}
