package com.views
{
    import com.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class WorldFactionWarSignUpView extends Base implements IView
    {
        private var _target:IWorldFactionWarSignUp;
        private var _date:Date;
        private var _info:WorldFactionWarInfo;

        public function WorldFactionWarSignUpView()
        {
            this._date = new Date();
            return;
        }// end function

        public function show() : void
        {
            if (inStage)
            {
                return;
            }
            this._info = _ctrl.worldFactionWar.info;
            this.get_race_step();
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
            var str:String;
            var tf:TextField;
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("WorldFactionwarSignup", "MCSignUpClass") as IWorldFactionWarSignUp;
                this._target.onClose = this.close;
                this._target.onSee = this.onSee;
                this._target.onSignUp = this.onSignUp;
                this._target.onSeeWorld = this.onSeeWorld;
                this._target.ruleMsg = HtmlText.format(WorldFactionWarSignUpViewLang.Rule, 9992004, 14, "", true) + "\n" + this.ruleSignUp;
                this._target.tfGift.htmlText = WorldFactionWarSignUpViewLang.WinGift + "<u><a href=\'event:aa\'>" + HtmlText.yellow2(WorldFactionWarSignUpViewLang.GoldGift) + "</a></u>";
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
                str;
                var _loc_2:* = WorldFactionWarSignUpViewLang;
                with (WorldFactionWarSignUpViewLang)
                {
                    str = [HtmlText.purple(AwardFame), HtmlText.yellow(AwardCoin), HtmlText.yellow(AwardLingShi), HtmlText.yellow(AwardJinJie), QiPinDanYaoJuan, HtmlText.yellow(AwardCloth)].join("、") + "。";
                }
                tf = new TextField();
                tf.textColor = 16777215;
                tf.wordWrap = true;
                tf.width = 200;
                tf.htmlText = HtmlText.yellow2(WorldFactionWarSignUpViewLang.WarWinGift) + "\n" + WorldFactionWarSignUpViewLang.OpenHas + " " + str;
                tf.height = tf.textHeight + 5;
                this.onTip(this._target.tfGift, tf);
            }
            this.update();
            _popup.addView(this, this._target.content);
            return;
        }// end function

        public function update() : void
        {
            this.sign_faction_list2();
            if (_ctrl.worldFactionWar.info.stateServer != Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_SIGN_UP)
            {
                return;
            }
            if (_ctrl.worldFactionWar.signUpType == 2)
            {
                this._target.signUpVisible = false;
            }
            return;
        }// end function

        private function onSee() : void
        {
            _view.worldFactionWarSignUpList.show();
            return;
        }// end function

        private function onSignUp() : void
        {
            _data.call(Mod_WorldFactionWar_Base.sign_up, this.onSignUpBack, []);
            return;
        }// end function

        private function onSignUpBack() : void
        {
            switch(_ctrl.worldFactionWar.result)
            {
                case Mod_WorldFactionWar_Base.SUCCESS:
                {
                    _view.showTip(WorldFactionWarSignUpViewLang.SignUpSuccess, "", TipType.Success);
                    this._target.signUpVisible = false;
                    break;
                }
                case Mod_WorldFactionWar_Base.SIGN_UP_NO_OPEN:
                {
                    _view.showTip(WorldFactionWarSignUpViewLang.SignUpUnOpen);
                    break;
                }
                case Mod_WorldFactionWar_Base.REQUIRE_LEVEL:
                {
                    _view.showTip(WorldFactionWarSignUpViewLang.SignUpMasterNoLeve);
                    break;
                }
                case Mod_WorldFactionWar_Base.ERROR:
                {
                    _view.showTip(WorldFactionWarSignUpViewLang.UnKonwnErr);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onSeeWorld() : void
        {
            this._target.showSeeWorld(this._info.zoneName, this._info.serverNameList, _popup);
            return;
        }// end function

        private function onLink(event:TextEvent) : void
        {
            if (event.text == "SeeWorld")
            {
                this._target.showSeeWorld(this._info.zoneName, this._info.serverNameList, _popup);
            }
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

        private function get ruleSignUp() : String
        {
            var _loc_1:Array = [];
            _loc_1.push(Lang.sprintf(WorldFactionWarSignUpViewLang.SignUpRule1, this.getTime_MDHI(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_APPLY)));
            _loc_1.push(Lang.sprintf(WorldFactionWarSignUpViewLang.SignUpRule2, this.getTime_MDHI(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_TIANBANG)));
            _loc_1.push(WorldFactionWarSignUpViewLang.SignUpRule3);
            _loc_1.push(Lang.sprintf(WorldFactionWarSignUpViewLang.SignUpRule4, this.getTime_MD(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4), this.getTime_MDHI(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4, 3)));
            _loc_1.push(Lang.sprintf(WorldFactionWarSignUpViewLang.SignUpRule5, this.getTime_MDHI(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_2)));
            _loc_1.push(Lang.sprintf(WorldFactionWarSignUpViewLang.SignUpRule7, this.getTime_MDHI(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_1)));
            _loc_1.push(WorldFactionWarSignUpViewLang.SignUpRule8);
            _loc_1.push(WorldFactionWarSignUpViewLang.SignUpRule9);
            return _loc_1.join("\n");
        }// end function

        private function getTime_MDHI(param1:int, param2:int = 0) : String
        {
            var _loc_3:int = 86400000;
            var _loc_4:* = this.getDateArray(this._info.getRoundTime(param1) + param2 * _loc_3);
            var _loc_5:* = new Date();
            if (int(_loc_5.date) == int(_loc_4[1]))
            {
                Lang.sprintf(WorldFactionWarSignUpViewLang.DateTodayHI, _loc_4[2], _loc_4[3]);
            }
            _loc_5.time = _loc_5.time + _loc_3;
            if (int(_loc_5.date) == int(_loc_4[1]))
            {
                Lang.sprintf(WorldFactionWarSignUpViewLang.DateTomorrowHI, _loc_4[2], _loc_4[3]);
            }
            return Lang.sprintf(WorldFactionWarSignUpViewLang.DateMDHI, _loc_4[0], _loc_4[1], _loc_4[2], _loc_4[3]);
        }// end function

        private function getTime_MD(param1:int, param2:int = 0) : String
        {
            var _loc_3:int = 86400000;
            var _loc_4:* = this.getDateArray(this._info.getRoundTime(param1) + param2 * _loc_3);
            return Lang.sprintf(WorldFactionWarSignUpViewLang.DateMD, _loc_4[0], _loc_4[1]);
        }// end function

        private function getDateArray(param1:Number) : Array
        {
            this._date.time = param1;
            var _loc_2:* = "" + this._date.hours;
            var _loc_3:* = "" + (this._date.minutes < 10 ? ("0" + this._date.minutes) : (this._date.minutes));
            var _loc_4:* = "" + (this._date.seconds < 10 ? ("0" + this._date.seconds) : (this._date.seconds));
            return [(this._date.month + 1), this._date.date, _loc_2, _loc_3, _loc_4, this._date.fullYear];
        }// end function

        private function get_race_step() : void
        {
            this._data.call(Mod_WorldFactionWar_Base.get_race_step, this.get_race_step_back, []);
            return;
        }// end function

        private function get_race_step_back() : void
        {
            loadAssets("WorldFactionwarSignup", null, WorldFactionWarSignUpViewLang.Loading, false, false, this.loadComplete);
            return;
        }// end function

        private function sign_faction_list2() : void
        {
            switch(_ctrl.worldFactionWar.info.stateServer)
            {
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_SIGN_UP:
                {
                    this._target.btnVisible = true;
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_SIGN_UP_COMPLETE:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_PREPARE:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_APPLY:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_SIGN_UP_COMPLETE:
                {
                    this._target.btnVisible = true;
                    this._target.signUpVisible = false;
                    break;
                }
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_TIANBANG:
                case Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_DIBANG:
                {
                    this._target.btnVisible = false;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

    }
}
