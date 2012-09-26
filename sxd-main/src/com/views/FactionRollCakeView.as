package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.sound.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.geom.*;
    import flash.media.*;

    public class FactionRollCakeView extends Base implements IView
    {
        private var _factionRollCake:IFactionRollCake;
        private var _autoList:Array;
        private var _isIntoJiHuiSuo:Boolean = false;
        private var _isAutoReroll:Boolean = false;
        private var _noMoneyNum:int = 0;
        private var _rerollIngot:int = 0;
        public var endTownId:int = 0;

        public function FactionRollCakeView()
        {
            this._autoList = [];
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
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            _inStageTipTitle = RollCakeViewLang.inStageTipTitle;
            _inStageTipContent = "";
            RollCakeType.loadData(this.loadRender);
            return;
        }// end function

        private function loadRender() : void
        {
            this.faction_roll_cake_info();
            return;
        }// end function

        public function faction_roll_cake_remain_times() : void
        {
            _data.call(Mod_Faction_Base.faction_roll_cake_remain_times, this.rollCakeRemainTimes, []);
            return;
        }// end function

        public function faction_roll_cake_info() : void
        {
            _data.call(Mod_Faction_Base.faction_roll_cake_info, this.rollCakeInfoCallback, []);
            return;
        }// end function

        public function roll_cake() : void
        {
            _data.call(Mod_Faction_Base.roll_cake, this.rollCakeCallback, []);
            return;
        }// end function

        private function rollCakeRemainTimes() : void
        {
            var _loc_1:* = _ctrl.faction.rollCakeReamain;
            var _loc_2:Object = {};
            if (_loc_1.remainTimes > 0)
            {
                _loc_2.btnInfo = FactionRollCakeViewLang.JoinRollCake;
            }
            else
            {
                _loc_2.btnInfo = FactionRollCakeViewLang.CheckNum;
            }
            _loc_2.explain = Lang.sprintf(FactionRollCakeViewLang.RemainTimes, _loc_1.remainTimes);
            _loc_2.sign = ActivityType.FactionRollCake;
            _loc_2.isStart = 1;
            _loc_2.btnType = 1;
            _view.toolbar.renderFactionRollCakeLink(_loc_1.remainTimes);
            _view.factionWindow.getActivityState(_loc_2);
            return;
        }// end function

        private function rollCakeInfoCallback() : void
        {
            var _loc_1:Object = null;
            if (inStage)
            {
                _loc_1 = _ctrl.faction.rollCakeInfo;
                this._factionRollCake.getFactionRollCakeInfo = _loc_1;
                this._view.toolbar.renderFactionRollCakeLink(_loc_1.remainTimes);
            }
            else
            {
                loadAssets("FactionRollCake", this.render, FactionRollCakeViewLang.LoadAssets);
            }
            return;
        }// end function

        private function rollCakeCallback() : void
        {
            var _loc_1:* = _ctrl.faction.RollCake;
            if (_loc_1.msg == Mod_Faction_Base.SUCCESS)
            {
                this.faction_roll_cake_info();
                this._factionRollCake.getMainSzData(_loc_1, false);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_Faction_Base.NO_ENOUGH_TIMES:
                {
                    _view.showTip(FactionRollCakeViewLang.NoEnoughTimes);
                    break;
                }
                case Mod_Faction_Base.AWARDING_ROLL_CAKE:
                {
                    _view.showTip(FactionRollCakeViewLang.AwardingRollCake);
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

        public function showRollCake() : void
        {
            if (!FunctionType.isOpened(FunctionType.Faction))
            {
                return;
            }
            if (!_view.townMap.inStage)
            {
                return;
            }
            var _loc_1:* = TownType.getSign(_ctrl.player.mapId);
            if (_loc_1 == TownType.JiHuiSuo)
            {
                _view.townMap.getBuildTarget(3).visible = ActivityType.FactionLevel >= 5;
                if (_view.factionWindow.inStage)
                {
                    _view.factionWindow.close();
                }
                if (this._isIntoJiHuiSuo)
                {
                    this.show();
                }
            }
            this._isIntoJiHuiSuo = false;
            return;
        }// end function

        public function gotoJiHueiSuo() : void
        {
            this._isIntoJiHuiSuo = true;
            var _loc_1:* = TownType.getSign(_ctrl.player.mapId);
            if (_loc_1 != TownType.JiHuiSuo)
            {
                _view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
            }
            if (_view.factionWindow.inStage)
            {
                _view.factionWindow.close();
            }
            return;
        }// end function

        private function render() : void
        {
            this._factionRollCake = _view.getAssetsObject("FactionRollCake", "FactionRollCake") as IFactionRollCake;
            _popup.addView(this, this._factionRollCake.content);
            this._factionRollCake.tip = _view.tip.iTip;
            this._factionRollCake.drag = _view.drag.iDrag;
            this._factionRollCake.onGetRoll = function () : void
            {
                roll_cake();
                return;
            }// end function
            ;
            this._factionRollCake.onSound = function (param1:Sound) : void
            {
                SoundManage.playGameSound(param1);
                return;
            }// end function
            ;
            this._factionRollCake.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._factionRollCake.onTip = function (param1:String) : void
            {
                switch(param1)
                {
                    case "noCountNum":
                    {
                        _view.showTip(RollCakeViewLang.NoCountNum);
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
            this._factionRollCake.onShowMouse = function (param1:Boolean) : void
            {
                if (param1)
                {
                    MouseCursor.hide();
                }
                else
                {
                    MouseCursor.show();
                }
                return;
            }// end function
            ;
            this._factionRollCake.init();
            this.rollCakeInfoCallback();
            this.faction_roll_cake_remain_times();
            this.reposition();
            _view.closeEvent();
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            var _loc_2:Point = null;
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
                _loc_2 = Structure.stageOffset;
                this._factionRollCake.reposition(_loc_2);
            }
            return;
        }// end function

        public function close() : void
        {
            _view.openEvent();
            MouseCursor.show();
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._factionRollCake.clear();
            return;
        }// end function

    }
}
