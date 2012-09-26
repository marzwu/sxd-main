package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.haloer.display.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class GetPeachView extends Base implements IView
    {
        private var _getPeach:IGetPeach;
        private var _autoList:Array;
        private var _isBattle:Boolean = false;
        private var _isShow:Boolean = false;
        private var _buttleData:Object;

        public function GetPeachView()
        {
            this._autoList = [];
            this._buttleData = {};
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
            if (_view.multiMission.inStageWithTip)
            {
                return;
            }
            if (_view.chooseMission.inStageWithTip)
            {
                return;
            }
            if (_view.heroMission.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            _inStageTipTitle = GetPeachViewLang.inStageTipTitle;
            this.peach_info();
            return;
        }// end function

        public function get_peach() : void
        {
            var callBack:Function;
            callBack = function (param1:Boolean) : void
            {
                if (param1)
                {
                    return;
                }
                _isBattle = true;
                _view.getPeachWar.requested = true;
                _data.call(Mod_GetPeach_Base.get_peach, getPeachCallback, []);
                return;
            }// end function
            ;
            this._view.toolbar.checkWarCdTime(callBack, WarCdTimeType.Peach);
            return;
        }// end function

        public function buyMonkeys() : void
        {
            _data.call(Mod_GetPeach_Base.buy_monkeys, this.buyMonkeysCallback, []);
            return;
        }// end function

        public function peach_info() : void
        {
            _data.call(Mod_GetPeach_Base.peach_info, this.peachInfoCallback, []);
            return;
        }// end function

        public function player_info() : void
        {
            _data.call(Mod_GetPeach_Base.player_info, this.playerInfoCallback, []);
            return;
        }// end function

        private function getPeachCallback() : void
        {
            this._isBattle = false;
            if (_ctrl.getPeach.warResult == Mod_GetPeach_Base.SUCCESS)
            {
                _view.getPeachWar.onClose = function (param1:Boolean) : void
            {
                _isShow = false;
                if (_ctrl.getPeach.warExp > 0)
                {
                    setTimeout(lostPlay, 500);
                    peach_info();
                    player_info();
                }
                if (param1 == false)
                {
                    _view.missionFailedTips.showPeach(_ctrl.getPeach.PeachLv);
                }
                _view.triggerDelayed(DelayType.LevelUp, DelayType.Experience, DelayType.PartnerUpgrade);
                return;
            }// end function
            ;
                _view.gameHelper.loader_first_info();
                _view.getPeachWar.warData = _ctrl.getPeach.warData;
                _view.getPeachWar.show();
            }
            else
            {
                _view.getPeachWar.requested = false;
                this.renderMsg(_ctrl.getPeach.warResult);
            }
            return;
        }// end function

        private function lostPlay() : void
        {
            this._buttleData.info = "+" + _ctrl.getPeach.warExp + GetPeachViewLang.GetExp;
            this._getPeach.buttenSuccess = this._buttleData;
            return;
        }// end function

        private function buyMonkeysCallback() : void
        {
            var _loc_1:* = _ctrl.getPeach.buyMonkeys;
            if (_loc_1.msg == Mod_GetPeach_Base.SUCCESS)
            {
                this.peach_info();
                this.player_info();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function peachInfoCallback() : void
        {
            var _loc_1:* = _ctrl.getPeach.peachInfo;
            if (_loc_1.peachNum <= 0)
            {
                _view.activities.removeActivity(FunctionType.GetPeach);
            }
            if (inStage)
            {
                this._getPeach.peachInfo(_loc_1, this._isShow, _ctrl.player.level >= 150);
            }
            else
            {
                loadAssets("GetPeach", this.render, GetPeachViewLang.LoadAssets);
            }
            return;
        }// end function

        private function playerInfoCallback() : void
        {
            if (inStage == false)
            {
                return;
            }
            var _loc_1:* = _ctrl.getPeach.playerInfo;
            this._getPeach.playerInfo = _loc_1;
            this._getPeach.summerWuKong = _loc_1.haveMonkeyNum;
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_GetPeach_Base.FAILURE:
                {
                    _view.showTip(GetPeachViewLang.NoIngot);
                    break;
                }
                case Mod_GetPeach_Base.NOT_ENOUGH_PEACH_COUNT:
                {
                    _view.showTip(GetPeachViewLang.NoEnoughPeachCount);
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
            this._getPeach = _view.getAssetsObject("GetPeach", "GetPeach") as IGetPeach;
            _popup.addView(this, this._getPeach.content);
            this._getPeach.tip = _view.tip.iTip;
            this._getPeach.drag = _view.drag.iDrag;
            _view.center(sign, this._getPeach.content);
            this._getPeach.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._getPeach.onTip = function (param1:String) : void
            {
                switch(param1)
                {
                    case GetPeachViewLang.noCountNum:
                    {
                        _view.showTip(GetPeachViewLang.noCountNum);
                        ;
                    }
                    case GetPeachViewLang.noRobeNum:
                    {
                        _view.showTip(GetPeachViewLang.noRobeNum);
                        ;
                    }
                    case GetPeachViewLang.userRobelRedirection:
                    {
                        _view.showTip(GetPeachViewLang.userRobelRedirection);
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
            this._getPeach.onGetPeach = function (param1:Object) : void
            {
                if (_isBattle)
                {
                    return;
                }
                _buttleData = param1;
                get_peach();
                return;
            }// end function
            ;
            this._getPeach.onBuyMonkeys = function () : void
            {
                var callback:Function;
                if (!_view.getCookie("GetPeachBuyMonkeys"))
                {
                    dialog.yesLabel = GetPeachViewLang.Sure;
                    dialog.cancelLabel = GetPeachViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        buyMonkeys();
                    }
                    if (dialog.checked)
                    {
                        _view.setCookie("GetPeachBuyMonkeys", true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(Lang.sprintf(GetPeachViewLang.GetPeachBuyMonkeys, HtmlText.yellow("50") + GetPeachViewLang.Ingot), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    buyMonkeys();
                }
                return;
            }// end function
            ;
            this._isShow = true;
            this.peachInfoCallback();
            this.player_info();
            this.addWuKong();
            this.addAnger();
            return;
        }// end function

        private function addWuKong() : void
        {
            var img:Image;
            img = new Image(URI.assetsUrl + "peach_wukong.swf");
            img.onComplete = function () : void
            {
                if (_getPeach == null)
                {
                    return;
                }
                _getPeach.addWuKong(img);
                return;
            }// end function
            ;
            return;
        }// end function

        private function addAnger() : void
        {
            var img:Image;
            img = new Image(URI.assetsUrl + "peach_anger.swf");
            img.onComplete = function () : void
            {
                if (_getPeach == null)
                {
                    return;
                }
                _getPeach.addAnger(img);
                return;
            }// end function
            ;
            return;
        }// end function

        public function close() : void
        {
            this._isBattle = false;
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._getPeach.clear();
            return;
        }// end function

    }
}
