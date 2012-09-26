package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.utils.*;

    public class TowerView extends Base implements IView
    {
        private var _target:ITower;
        private var _info:TowerInfo;
        private var _body:IFrameSprite;
        private var _noticeTips:Array;
        private var _warTime:int = 0;
        private var lastHideId:int = 0;

        public function TowerView()
        {
            _inStageTipTitle = TowerViewLang.TowerOpening;
            _inStageTipContent = "";
            return;
        }// end function

        public function show() : void
        {
            if (inStage)
            {
                return;
            }
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
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            this.get_tower_info();
            return;
        }// end function

        public function close() : void
        {
            if (_view.towerWar.opened == true)
            {
                return;
            }
            _popup.closeView(this);
            _data.cancelPatch(Mod_Tower_Base.notify_auto_challenge_report);
            this.stop_auto_challenge();
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function loadComplete() : void
        {
            if (this._target == null)
            {
                this._body = MapStatic.mapInstance.frame;
                this._body.content.mouseChildren = false;
                this._body.content.mouseEnabled = false;
                this._body.content.scaleX = 0.5;
                this._body.content.scaleY = 0.5;
                this._info = _ctrl.tower.towerInfo;
                this._info.roleDisplay = this._body;
                this._target = _view.getAssetsObject("Tower", "MCTower") as ITower;
                this._target.onClose = this.close;
                this._target.onWar = this.onWar;
                this._target.onAuto = this.onAuto;
                this._target.onReset = this.onReset;
                this._target.onStop = this.onStop;
                this._target.onTip = this.onTip;
                this._target.onGoToNext = this.onGoToNext;
                this._target.onTownClick = this.onShowSoulShop;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
                _view.center(sign, this._target.content);
            }
            this._info.sign = _ctrl.player.playerInfo.sign + _ctrl.player.playerInfo.signSuffix;
            this._target.initData(this._info);
            _data.patch(Mod_Tower_Base.notify_auto_challenge_report, this.notify_auto_challenge_report_back);
            return;
        }// end function

        private function onGoToNext() : void
        {
            if (this._info.layer == 6 && this._info.sequenceWar == 26)
            {
                if (this._info.hideId == 0 || this._info.hideId > 6)
                {
                    this._view.activities.removeActivity(FunctionType.Tower);
                }
                return;
            }
            this.get_tower_info2();
            return;
        }// end function

        private function onShowSoulShop() : void
        {
            this._view.sealStoneShop.switchSelf();
            return;
        }// end function

        private function onWar(param1:int = 0) : void
        {
            var idx:* = param1;
            this._info.isHideWar = idx == 0 ? (true) : (false);
            if (this._info.layderTip != "" && idx != 0)
            {
                _view.showTip(this._info.layderTip);
            }
            if (this._info.layderTip != "" && idx != 0)
            {
                return;
            }
            if (getTimer() < this._warTime)
            {
                return;
            }
            this._warTime = getTimer() + 1000;
            if (this._info.bagNum == 0)
            {
                _view.alert.confirm(TowerViewLang.SoulPageFull);
                return;
            }
            if (this._info.inAuto == true)
            {
                _view.showTip(TowerViewLang.Autoing);
                return;
            }
            _view.toolbar.checkWarCdTime(function (param1:Boolean) : void
            {
                if (param1 == false)
                {
                    start_challenge(idx);
                }
                return;
            }// end function
            , WarCdTimeType.Tower);
            return;
        }// end function

        private function onAuto() : void
        {
            this.start_auto_challenge();
            return;
        }// end function

        private function onReset() : void
        {
            if (this._info.sequenceWar == 1 || this._info.resetNum == 0)
            {
                _view.showTip(this._info.resetTip);
            }
            else if (this._info.resetIngot == 0)
            {
                this.reset_layer();
            }
            else
            {
                this.checkBoxSelect(ConsumeAlertSetType.TowerViewReset, Lang.sprintf(TowerViewLang.AskReset, HtmlText.yellow(this._info.resetIngot + TowerViewLang.Ingot)), this.reset_layer);
            }
            return;
        }// end function

        private function onStop() : void
        {
            this.stop_auto_challenge();
            this._target.updateInfo(0);
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2 = null) : void
        {
            if (param2 == "" || param2 == null)
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
            }
            return;
        }// end function

        private function onWarClose(param1:Boolean) : void
        {
            if (_ctrl.tower.isPass)
            {
                if (this._info.bagNum == 0)
                {
                    _view.alert.confirm(TowerViewLang.SoulPageFull);
                }
                this._target.updateInfo(2);
            }
            if (this._info.layer == 6 && this._info.sequenceWar == 26 && this._info.isHideWar && this._info.hideId > 6 && param1)
            {
            }
            else
            {
                _popup.addView(this, this._target.content);
                if (param1 == false)
                {
                    _view.missionFailedTips.showTower(this._info.layer, this._info.sequenceWar);
                }
            }
            this.updateNotice(this._noticeTips);
            return;
        }// end function

        private function checkBoxSelect(param1:int, param2:String, param3:Function) : void
        {
            var cookie:* = param1;
            var msg:* = param2;
            var callback:* = param3;
            var checked:* = _view.consumeAlertSetting.isAlert(cookie);
            if (checked)
            {
                this.callback();
            }
            else
            {
                _view.alert.iAlert.hasCheckbox = true;
                _view.alert.showYesNoMsg(msg, TowerViewLang.Yes, TowerViewLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    callback();
                    if (_view.alert.iAlert.checked == true)
                    {
                        _view.consumeAlertSetting.saveSetting(cookie, true);
                    }
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function updateBagNum(param1:int) : void
        {
            if (inStage && this._target != null)
            {
                this._info.bagNum = param1;
                this._target.updateInfo();
            }
            return;
        }// end function

        public function updateNotice(param1:Array) : void
        {
            var _loc_2:String = null;
            this._noticeTips = param1;
            if (param1 && _view.towerWar.opened == false)
            {
                for each (_loc_2 in param1)
                {
                    
                    this._view.worldNotice.showMessage(_loc_2);
                }
                this._noticeTips = null;
            }
            return;
        }// end function

        private function get_tower_info() : void
        {
            _data.call(Mod_Tower_Base.get_tower_info, this.get_tower_info_back, []);
            return;
        }// end function

        private function get_tower_info_back() : void
        {
            loadAssets("Tower", null, TowerViewLang.TowerLoading, false, false, this.loadComplete);
            return;
        }// end function

        private function get_tower_info2() : void
        {
            _data.call(Mod_Tower_Base.get_tower_info, this.get_tower_info_back2, []);
            return;
        }// end function

        private function get_tower_info_back2() : void
        {
            this._target.updateInfo(1);
            return;
        }// end function

        public function get_tower_info3() : void
        {
            _data.call(Mod_Tower_Base.get_tower_info, this.get_tower_info_back3, []);
            return;
        }// end function

        private function get_tower_info_back3() : void
        {
            this._info = _ctrl.tower.towerInfo;
            if (this._info.layer > 3 || this._info.layer == 3 && this._info.sequenceWar == 26)
            {
                this._view.activities.addActivity(ActivityType.NineRegions);
                if (_ctrl.player.level >= 101)
                {
                    _ctrl.nineRegions.bOpenNineRegions = true;
                    this._data.call(Mod_NineRegions_Base.get_player_bless_level, new Function(), []);
                }
            }
            if (this._info.layer == 6 && this._info.sequenceWar == 26 && (this._info.hideId == 0 || this._info.hideId > 6))
            {
                this._view.activities.removeActivity(FunctionType.Tower);
            }
            else
            {
                this._view.activities.addActivity(FunctionType.Tower);
            }
            return;
        }// end function

        private function start_challenge(param1:int) : void
        {
            _view.towerWar.opened = true;
            this._info.warIdx = param1;
            _data.call(Mod_Tower_Base.start_challenge, this.start_challenge_back, [param1, this._target.autoSellL, this._target.autoSellZ]);
            return;
        }// end function

        private function start_challenge_back() : void
        {
            if (_ctrl.tower.result == Mod_Tower_Base.SUCCESS)
            {
                _view.towerWar.warData = _ctrl.tower.warData;
                _view.towerWar.background = new BitmapData(1, 1, true, 0);
                _view.towerWar.onClose = this.onWarClose;
                _view.towerWar.autoSellL = this._target.autoSellL;
                _view.towerWar.autoSellZ = this._target.autoSellZ;
                _view.towerWar.show();
                if (this._info.layer == 6 && this._info.sequenceWar == 26 && _ctrl.tower.isPass)
                {
                    this.get_tower_info3();
                }
                if (this._info.layer == 3 && this._info.sequenceWar == 26 && _ctrl.tower.isPass)
                {
                    this._view.activities.addActivity(ActivityType.NineRegions);
                    if (_ctrl.player.level >= 101)
                    {
                        this._data.call(Mod_NineRegions_Base.get_player_bless_level, new Function(), []);
                    }
                }
            }
            else if (_ctrl.tower.result == Mod_Tower_Base.INVALID_LAYER)
            {
                _view.towerWar.opened = false;
                _view.showTip(TowerViewLang.InvalidLayder);
            }
            else if (_ctrl.tower.result == Mod_Tower_Base.WAR_CD)
            {
                _view.towerWar.opened = false;
                _view.toolbar.checkWarCdTime(new Function(), WarCdTimeType.Tower);
            }
            return;
        }// end function

        private function reset_layer() : void
        {
            _data.call(Mod_Tower_Base.reset_layer, this.reset_layer_back, []);
            return;
        }// end function

        private function reset_layer_back() : void
        {
            switch(_ctrl.tower.result)
            {
                case Mod_Tower_Base.SUCCESS:
                {
                    this._target.updateInfo(1);
                    if (this._info.hideId != 0 && this._info.hideId != this.lastHideId)
                    {
                        _view.alert.confirm(Lang.sprintf(TowerViewLang.OpenHideTip, this._info.hideTowerName));
                    }
                    this.lastHideId = this._info.hideId;
                    break;
                }
                case Mod_Tower_Base.NOT_ENOUGH_INGOT:
                {
                    _view.showTip(TowerViewLang.IngotLack);
                    break;
                }
                case Mod_Tower_Base.FULL_TIMES:
                {
                    _view.showTip(TowerViewLang.NotResetCount);
                    break;
                }
                case Mod_Tower_Base.INVALID_LAYER:
                {
                    _view.showTip(TowerViewLang.InvalidLayder);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function start_auto_challenge() : void
        {
            this._info.autoSellL = this._target.autoSellL;
            this._info.autoSellZ = this._target.autoSellZ;
            _data.call(Mod_Tower_Base.start_auto_challenge, this.start_auto_challenge_back, [this._target.autoSellL, this._target.autoSellZ]);
            return;
        }// end function

        private function start_auto_challenge_back() : void
        {
            if (_ctrl.tower.result == Mod_Tower_Base.SUCCESS)
            {
                this.quickly_auto_challenge();
            }
            else if (_ctrl.tower.result == Mod_Tower_Base.INVALID_LAYER)
            {
                _view.showTip(TowerViewLang.InvalidLayder);
            }
            return;
        }// end function

        private function stop_auto_challenge() : void
        {
            _data.call(Mod_Tower_Base.stop_auto_challenge, null, []);
            this._info.inAuto = false;
            this._info.awardAutoTip2 = TowerViewLang.StopAutoWar;
            return;
        }// end function

        private function quickly_auto_challenge() : void
        {
            this._info.autoSellL = this._target.autoSellL;
            this._info.autoSellZ = this._target.autoSellZ;
            _data.call(Mod_Tower_Base.quickly_auto_challenge, null, [this._target.autoSellL, this._target.autoSellZ]);
            return;
        }// end function

        private function notify_auto_challenge_report_back() : void
        {
            if (_ctrl.tower.result == Mod_Tower_Base.SUCCESS)
            {
            }
            else if (_ctrl.tower.result == Mod_Tower_Base.NOT_ENOUGH_INGOT)
            {
                _view.showTip(TowerViewLang.IngotLack);
            }
            else if (_ctrl.tower.result == Mod_Tower_Base.FULL_BAG)
            {
                _view.alert.showYesNoMsg(TowerViewLang.AskOpenSoul, TowerViewLang.Open, TowerViewLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    _view.sealSoul.show();
                }
                return;
            }// end function
            );
            }
            this._target.updateInfo(0);
            return;
        }// end function

    }
}
