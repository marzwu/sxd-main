package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class DailyQuestView extends Base implements IView
    {
        private var _dailyQuest:IDailyQuest;
        private var _dialog:IAlert = null;
        private var _inRefreshQuest:Boolean = false;
        private var _intFullStarIngot:int;

        public function DailyQuestView()
        {
            return;
        }// end function

        public function show() : void
        {
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
            this._dialog.hide();
            this._dailyQuest.clear();
            return;
        }// end function

        private function loadData() : void
        {
            _data.call(Mod_Quest_Base.day_quest_list, this.loadDataCallBack, [], false);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            var callBack:* = function () : void
            {
                render();
                dayQuestListCallBack();
                showUI();
                return;
            }// end function
            ;
            loadAssets("DailyQuest", callBack, DailyQuestViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._dailyQuest.content);
            _view.center(sign, this._dailyQuest.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._dailyQuest == null)
            {
                this._dailyQuest = _view.getAssetsObject("DailyQuest", "DailyQuest") as IDailyQuest;
            }
            this._dailyQuest.onCloseBtn = this.close;
            this.init();
            this._dailyQuest.render();
            return;
        }// end function

        private function init() : void
        {
            this._dialog = this._view.alert.iAlert;
            this._dailyQuest.tip = this._view.tip.iTip;
            this._dailyQuest.drag = this._view.drag.iDrag;
            this._dailyQuest.onCloseBtn = this.close;
            this._dailyQuest.onAbortBtn = this.day_giveup_quest;
            this._dailyQuest.onAcceptBtn = this.day_accept_quest;
            this._dailyQuest.onCompleteBtn = this.day_get_award;
            this._dailyQuest.onImmeCompleteBtn = this.day_now_complete;
            this._dailyQuest.onRefreshBtn = this.dayQuestRefresh;
            this._dailyQuest.onFullStarBtn = this.day_quest_refresh_star;
            this._dailyQuest.serverTime = this._ctrl.player.serverTime;
            return;
        }// end function

        private function renderDialuQuestInfo(param1:Object) : void
        {
            this._dailyQuest.serverTime = this._ctrl.player.serverTime;
            if (param1["result"] == Mod_Quest_Base.SUCCEED)
            {
                this._dailyQuest.renderDailyQuestInfo(param1);
            }
            else
            {
                _view.showTip(this.message(param1["result"]));
            }
            return;
        }// end function

        private function dayQuestRefresh() : void
        {
            if (!_view.ingotEnough(10))
            {
                return;
            }
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.RefreshDailyQuest))
            {
                var callBack:* = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    day_quest_refresh();
                }
                if (_dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.RefreshDailyQuest, true);
                }
                return;
            }// end function
            ;
                this._dialog.yesLabel = DailyQuestViewLang.DialogYes;
                this._dialog.cancelLabel = DailyQuestViewLang.DialogCancel;
                this._dialog.hasCheckbox = true;
                this._dialog.show(Lang.sprintf(DailyQuestViewLang.RefreshQuest, HtmlText.yellow("10" + DailyQuestViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            }
            else
            {
                this.day_quest_refresh();
            }
            return;
        }// end function

        private function funllStarIngot() : int
        {
            var _loc_1:* = new Date(this._ctrl.player.serverTime * 1000).day;
            if (_loc_1 == 0)
            {
                _loc_1 = 7;
            }
            return 350 / 7 * (7 - _loc_1 + 1);
        }// end function

        private function day_quest_list() : void
        {
            this._data.call(Mod_Quest_Base.day_quest_list, this.dayQuestListCallBack, [], false);
            return;
        }// end function

        private function dayQuestListCallBack() : void
        {
            var _loc_1:* = this._ctrl.dailyQuest.getDayQuestList();
            this._dailyQuest.renderDailyQuestInfo(_loc_1);
            return;
        }// end function

        private function day_accept_quest() : void
        {
            this._data.call(Mod_Quest_Base.day_accept_quest, this.dayAcceptQuestCallBack, [this._dailyQuest.questID], false);
            return;
        }// end function

        private function dayAcceptQuestCallBack() : void
        {
            var _loc_1:* = this._ctrl.dailyQuest.acceptDayQuest();
            this.renderDialuQuestInfo(_loc_1);
            return;
        }// end function

        private function day_giveup_quest() : void
        {
            this._data.call(Mod_Quest_Base.day_giveup_quest, this.dayGiveupQuestCallBack, [this._dailyQuest.questID], false);
            return;
        }// end function

        private function dayGiveupQuestCallBack() : void
        {
            var _loc_1:* = this._ctrl.dailyQuest.giveupDayQuest();
            this.renderDialuQuestInfo(_loc_1);
            return;
        }// end function

        private function day_quest_refresh() : void
        {
            if (this._inRefreshQuest)
            {
                return;
            }
            this._inRefreshQuest = true;
            _data.call(Mod_Quest_Base.day_quest_refresh, this.dayQuestRefreshCallBack, []);
            return;
        }// end function

        private function dayQuestRefreshCallBack() : void
        {
            var _loc_1:* = this._ctrl.dailyQuest.refreshDayQuest();
            this.renderDialuQuestInfo(_loc_1);
            this._inRefreshQuest = false;
            return;
        }// end function

        private function day_now_complete() : void
        {
            if (!_view.ingotEnough(20))
            {
                return;
            }
            this._data.call(Mod_Quest_Base.day_now_complete, this.dayNowCompleteCallBack, [this._dailyQuest.questID], false);
            return;
        }// end function

        private function dayNowCompleteCallBack() : void
        {
            var _loc_1:* = this._ctrl.dailyQuest.nowCompleteDay();
            this.renderDialuQuestInfo(_loc_1);
            this.finish_all_day_quest();
            _view.gameHelper.updateGameAssistant();
            _view.liveness.updateInfo();
            return;
        }// end function

        private function day_get_award() : void
        {
            this._data.call(Mod_Quest_Base.day_get_award, this.dayGetAwardCallBack, [this._dailyQuest.questID], false);
            return;
        }// end function

        private function dayGetAwardCallBack() : void
        {
            var _loc_1:* = this._ctrl.dailyQuest.getAwardDay();
            this.renderDialuQuestInfo(_loc_1);
            this.finish_all_day_quest();
            _view.gameHelper.updateGameAssistant();
            _view.liveness.updateInfo();
            return;
        }// end function

        private function day_quest_refresh_star() : void
        {
            var callBack:Function;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    _data.call(Mod_Quest_Base.day_quest_refresh_star, dayQuestRefreshStarCallBack, [], false);
                }
                return;
            }// end function
            ;
            if (!_view.ingotEnough(this.funllStarIngot()))
            {
                return;
            }
            this._dialog.yesLabel = DailyQuestViewLang.DialogYes;
            this._dialog.cancelLabel = DailyQuestViewLang.DialogCancel;
            this._dialog.show(Lang.sprintf(DailyQuestViewLang.FullStar, HtmlText.yellow(this.funllStarIngot().toString())), AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            return;
        }// end function

        private function dayQuestRefreshStarCallBack() : void
        {
            var _loc_1:* = this._ctrl.dailyQuest.refreshStarDayQuest();
            this.renderDialuQuestInfo(_loc_1);
            return;
        }// end function

        public function finish_all_day_quest() : void
        {
            return;
        }// end function

        private function finishAllDayQuestCallBack() : void
        {
            var _loc_1:* = this._ctrl.dailyQuest.finishAllDayQuest;
            if (_loc_1["state"] == 1)
            {
                this._view.activities.removeActivity(FunctionType.DailyQuest);
            }
            else if (_loc_1["state"] == 0 && FunctionType.isOpened(FunctionType.DailyQuest))
            {
                this._view.activities.addActivity(FunctionType.DailyQuest);
            }
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Quest_Base.SUCCEED:
                {
                    _loc_2 = DailyQuestViewLang.Succeed;
                    break;
                }
                case Mod_Quest_Base.FAILED:
                {
                    _loc_2 = DailyQuestViewLang.Failed;
                    break;
                }
                case Mod_Quest_Base.EXITSQUEST:
                {
                    _loc_2 = DailyQuestViewLang.ExitsQuest;
                    break;
                }
                case Mod_Quest_Base.NOENOUGHLEVEL:
                {
                    _loc_2 = DailyQuestViewLang.NoEnoughLevel;
                    break;
                }
                case Mod_Quest_Base.NOENOUGHINGOT:
                {
                    _loc_2 = DailyQuestViewLang.NoEnoughIngot;
                    break;
                }
                case Mod_Quest_Base.COMPLETELIMIT:
                {
                    _loc_2 = DailyQuestViewLang.CompleteLimit;
                    break;
                }
                case Mod_Quest_Base.PACK_FULL:
                {
                    _loc_2 = DailyQuestViewLang.PackFull;
                    break;
                }
                default:
                {
                    _loc_2 = DailyQuestViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
