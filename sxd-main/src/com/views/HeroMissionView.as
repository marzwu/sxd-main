package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class HeroMissionView extends Base implements IView
    {
        private var _heroMission:IHeroMission;
        private var _alert:IAlert;
        private var _campName:String = "";
        private var _showTownId:int = 0;
        private var _missionId:int = 0;
        private var _isUser:Boolean = false;
        private var _autoMissionId:int = 0;
        private var _autoMissionLock:int = 0;
        private var _autoMissionInfo:String = "";
        public var mainMissionInfo:String = "MainMissionInfo";
        private var _autoType:int = 0;

        public function HeroMissionView() : void
        {
            _inStageTipTitle = HeroMissionViewLang.inStageTipTitle;
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:int = 0;
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
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (_view.getPeach.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.HeroMission) == false)
            {
                _view.showTip(HeroMissionViewLang.MissionOpen);
                return;
            }
            if (this._showTownId == 0)
            {
                _loc_1 = TownType.getMaxTownId();
                this._showTownId = _loc_1;
            }
            this.get_hero_mission_list(this._showTownId);
            return;
        }// end function

        public function set alert(param1:IAlert) : void
        {
            this._alert = param1;
            return;
        }// end function

        public function checkCampAndLoad() : void
        {
            var _loc_1:String = null;
            var _loc_2:String = null;
            this._campName = FactionType.campName(_ctrl.player.campId);
            if (_ctrl.player.inSelfTown)
            {
                if (this._showTownId == 0)
                {
                    this._showTownId = _ctrl.player.mapId;
                }
                this.get_hero_mission_list(this._showTownId);
            }
            else
            {
                _loc_1 = TownType.getName(_ctrl.player.mapId);
                _loc_2 = Lang.sprintf(HeroMissionViewLang.CampLimit, this._campName, _loc_1);
                _view.alert.confirm(_loc_2);
            }
            return;
        }// end function

        private function get_hero_mission_list(param1:int) : void
        {
            _data.call(Mod_HeroMission_Base.get_hero_mission_list, this.heroMissionListCallBack, [param1]);
            return;
        }// end function

        private function buy_hero_challenge() : void
        {
            this._isUser = true;
            _data.call(Mod_HeroMission_Base.buy_hero_challenge, this.buyHeroChallengeCallBack, [this._showTownId]);
            return;
        }// end function

        private function heroMissionListCallBack() : void
        {
            var _loc_1:Array = null;
            var _loc_2:Object = null;
            if (this.inStage)
            {
                _loc_1 = _ctrl.heroMission.renderTownHeroMission(this._showTownId);
                _loc_2 = _ctrl.heroMission.openHeroMission;
                this._heroMission.getRefreshData = _loc_2;
                this._heroMission.townHeroMission = _loc_1;
                this._heroMission.openHeroMission = _loc_2.heroList;
            }
            else
            {
                loadAssets("HeroMission", this.render, HeroMissionViewLang.LoadAssets);
            }
            return;
        }// end function

        private function buyHeroChallengeCallBack() : void
        {
            this._isUser = false;
            var _loc_1:* = _ctrl.heroMission.buyHeroChallenge;
            switch(_loc_1.msg)
            {
                case Mod_HeroMission_Base.SUCCESS:
                {
                    _view.showTip(HeroMissionViewLang.RefreshSuccess, null, TipType.Success);
                    this.get_hero_mission_list(this._showTownId);
                    break;
                }
                case Mod_HeroMission_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(HeroMissionViewLang.NotEnoughIngot);
                    break;
                }
                case Mod_HeroMission_Base.FULL_BUY_TIMES:
                {
                    _view.showTip(HeroMissionViewLang.FullBuyTimes);
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
            this._heroMission = _view.getAssetsObject("HeroMission", "HeroMission") as IHeroMission;
            _popup.addView(this, this._heroMission.content);
            _view.center(sign, this._heroMission.content);
            this._heroMission.tip = _view.tip.iTip;
            this._heroMission.drag = _view.drag.iDrag;
            this.alert = _view.alert.iAlert;
            var isHeroPractice:* = FunctionType.isOpened(FunctionType.HeroMissionPractice);
            this._heroMission.isShowPractice = isHeroPractice;
            this.heroMissionListCallBack();
            if (this._autoMissionLock != 0)
            {
                this._heroMission.autoMissionId(this._autoMissionLock, this._autoMissionInfo, this._autoType);
            }
            this._heroMission.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._heroMission.onRefresh = function (param1:int) : void
            {
                var callback:Function;
                var buyPrice:* = param1;
                if (_isUser)
                {
                    _isUser = false;
                    return;
                }
                var str:String;
                if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.BuyHeroChallenge))
                {
                    dialog.yesLabel = HeroMissionViewLang.Sure;
                    dialog.cancelLabel = HeroMissionViewLang.Cancel;
                    dialog.hasCheckbox = true;
                    callback = function (param1:uint) : void
                {
                    if (param1 == AlertButtonType.Yes)
                    {
                        buy_hero_challenge();
                    }
                    if (dialog.checked)
                    {
                        _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.BuyHeroChallenge, true);
                    }
                    return;
                }// end function
                ;
                    dialog.show(Lang.sprintf(HeroMissionViewLang.BuyHeroChallenge, HtmlText.yellow(buyPrice + HeroMissionViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callback);
                }
                else
                {
                    buy_hero_challenge();
                }
                return;
            }// end function
            ;
            this._heroMission.onChangeTown = function (param1:int) : void
            {
                _showTownId = param1;
                get_hero_mission_list(param1);
                townInfo(param1);
                return;
            }// end function
            ;
            this._heroMission.onStartMission = function (param1:Object) : void
            {
                _view.missionMap.gotoMissionAtId(param1.id);
                close();
                return;
            }// end function
            ;
            this._heroMission.onPractice = function (param1:Array) : void
            {
                if (FunctionType.isOpened(FunctionType.HeroMissionPractice))
                {
                    _view.heroPractice.showTownId = _showTownId;
                    _view.heroPractice.getHeroPracticeList = param1;
                }
                else
                {
                    _view.showTip(HeroMissionViewLang.FunctionNoOpen);
                }
                return;
            }// end function
            ;
            this._heroMission.onRefreshHeroMission = function (param1:Object) : void
            {
                _missionId = param1.id;
                if (param1.buyStatus == 1)
                {
                }
                else
                {
                    _view.showTip(HeroMissionViewLang.CantRefresh);
                }
                return;
            }// end function
            ;
            var townIdList:* = TownType.getOpenedTownIds();
            this._heroMission.getTownIdList = townIdList;
            this.townInfo(this._showTownId);
            return;
        }// end function

        public function changeTownKey() : void
        {
            this._showTownId = 0;
            return;
        }// end function

        private function townInfo(param1:int) : void
        {
            var _loc_2:Object = {};
            _loc_2.townName = TownType.getName(param1);
            _loc_2.townId = param1;
            _loc_2.nextId = TownType.getNextTownIdByTownId(param1);
            _loc_2.nextTownName = TownType.getName(_loc_2.nextId);
            _loc_2.prevId = TownType.getPrevTownIdByTownId(param1);
            _loc_2.prevTownName = TownType.getName(_loc_2.prevId);
            this._heroMission.getTownInfo = _loc_2;
            return;
        }// end function

        public function onBuyPriceHandler(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.buy_hero_challenge();
                    break;
                }
                case AlertButtonType.No:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function autoMissionId(param1:int, param2:int, param3:String = "MainMissionInfo") : void
        {
            this._showTownId = param1;
            this._autoMissionId = param2;
            this._autoMissionInfo = param3;
            if (param3 == this.mainMissionInfo)
            {
                this._autoMissionInfo = HeroMissionViewLang.MainMission;
                this._autoType = 0;
            }
            else
            {
                this._autoType = 1;
            }
            this._autoMissionLock = MissionType.getMissionLock(this._autoMissionId);
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
            this._isUser = false;
            this._heroMission.clear();
            this._autoMissionId = 0;
            this._autoMissionLock = 0;
            this._heroMission = null;
            return;
        }// end function

    }
}
