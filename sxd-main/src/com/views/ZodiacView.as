package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class ZodiacView extends Base implements IView
    {
        private var _zodiac:IZodiac;
        private var _blnInStartWar:Boolean = false;

        public function ZodiacView() : void
        {
            _inStageTipTitle = ZodiacViewLang.inStageTipTitle;
            _inStageTipContent = "";
            return;
        }// end function

        public function show() : void
        {
            if (_view.chooseMission.inStageWithTip)
            {
                return;
            }
            if (_view.heroMission.inStageWithTip)
            {
                return;
            }
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (_view.multiMission.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._zodiac.clear();
            return;
        }// end function

        private function loadData() : void
        {
            this.zodiac_info(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("Zodiac", this.render, ZodiacViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._zodiac.content);
            _view.center(sign, this._zodiac.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._zodiac == null)
            {
                this._zodiac = _view.getAssetsObject("Zodiac", "Zodiac") as IZodiac;
            }
            this.init();
            this.zodiacInfoCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._blnInStartWar = false;
            this._zodiac.tip = this._view.tip.iTip;
            this._zodiac.drag = this._view.drag.iDrag;
            this._zodiac.onClose = this.close;
            this._zodiac.onStartWar = this.challenge;
            this._zodiac.onGoldOilShop = this._view.goldOilShop.switchSelf;
            this._zodiac.init();
            return;
        }// end function

        private function zodiac_info(param1:Function) : void
        {
            _data.call(Mod_Zodiac_Base.zodiac_info, param1, []);
            return;
        }// end function

        private function zodiacInfoCallBack() : void
        {
            var _loc_1:* = this._ctrl.zodiac.zodiacInfo;
            this._zodiac.myLevel = this._ctrl.player.level;
            if (_loc_1["now_zodiac_level"] == 0 && _loc_1["now_barrier"] == 0)
            {
                if (!this._view.getCookie("NoFirstOpenZodiac"))
                {
                    this._zodiac.renderZodiacInfo(_loc_1, true);
                    _view.setCookie("NoFirstOpenZodiac", true);
                    return;
                }
            }
            this._zodiac.renderZodiacInfo(_loc_1);
            return;
        }// end function

        private function challenge() : void
        {
            var callBack:Function;
            callBack = function (param1:Boolean) : void
            {
                if (!param1)
                {
                    _blnInStartWar = true;
                    _view.zodiacWar.opened = true;
                    _data.call(Mod_Zodiac_Base.challenge, challengeCallBack, []);
                }
                return;
            }// end function
            ;
            if (this._blnInStartWar)
            {
                return;
            }
            this._view.toolbar.checkWarCdTime(callBack, WarCdTimeType.Zodiac);
            return;
        }// end function

        private function challengeCallBack() : void
        {
            var objChallenge:Object;
            var callBack:Function;
            callBack = function () : void
            {
                var _loc_1:* = _ctrl.zodiac.zodiacInfo;
                objChallenge["gold_oil_name"] = ItemType.getName(objChallenge["gold_oil_id"]);
                _zodiac.renderChallengeSuccess(_loc_1, objChallenge);
                return;
            }// end function
            ;
            objChallenge = this._ctrl.zodiac.challengeResult;
            if (objChallenge["result"] == Mod_Zodiac_Base.SUCCESS || objChallenge["result"] == Mod_Zodiac_Base.FAIL)
            {
                _view.zodiacWar.warData = _ctrl.zodiac.warData;
                _view.zodiacWar.onClose = function (param1:Boolean) : void
            {
                if (param1)
                {
                    zodiac_info(callBack);
                }
                _view.chat.resetDepth();
                return;
            }// end function
            ;
                _view.zodiacWar.show();
            }
            else
            {
                _view.zodiacWar.opened = false;
                this._view.showTip(this.message(objChallenge["result"]));
            }
            this._blnInStartWar = false;
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Zodiac_Base.SUCCESS:
                {
                    _loc_2 = ZodiacViewLang.Success;
                    break;
                }
                case Mod_Zodiac_Base.FAIL:
                {
                    _loc_2 = ZodiacViewLang.Fail;
                    break;
                }
                case Mod_Zodiac_Base.TOP_HEAVEN:
                {
                    _loc_2 = ZodiacViewLang.TopZodiacLevel;
                    break;
                }
                case Mod_Zodiac_Base.NOT_ENOUGTH_PLAYER_LEVEL:
                {
                    _loc_2 = ZodiacViewLang.NotEnougthPlayerLevel;
                    break;
                }
                case Mod_Zodiac_Base.BAG_FULL:
                {
                    _loc_2 = ZodiacViewLang.BagFull;
                    break;
                }
                case Mod_Zodiac_Base.CD_TIME:
                {
                    _loc_2 = ZodiacViewLang.CdTime;
                    break;
                }
                default:
                {
                    _loc_2 = ZodiacViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
