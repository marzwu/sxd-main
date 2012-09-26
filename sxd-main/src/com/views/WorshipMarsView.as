package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class WorshipMarsView extends Base implements IView
    {
        private var _worshipMars:IWorshipMars;
        private var _intIncenseID:int;
        private var objIncenseColor:Object;

        public function WorshipMarsView()
        {
            this.objIncenseColor = {1:HtmlText.White, 2:44783, 3:HtmlText.Yellow};
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
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
            this._worshipMars.clear();
            this.dialog.hide();
            return;
        }// end function

        public function getBlessingTimesAndExpAdd() : void
        {
            if (FunctionType.isOpened(FunctionType.WorshipMars))
            {
                this.get_blessing_times_and_exp_add();
            }
            return;
        }// end function

        public function getRemainIncenseTimes() : void
        {
            if (FunctionType.isOpened(FunctionType.WorshipMars))
            {
                this.get_remain_incense_times();
                this.getBlessingTimesAndExpAdd();
            }
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._worshipMars.content);
            _view.center(sign, this._worshipMars.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._worshipMars == null)
            {
                this._worshipMars = _view.getAssetsObject("WorshipMars", "WorshipMars") as IWorshipMars;
            }
            this.init();
            this._worshipMars.render();
            this.marsInfoCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._worshipMars.tip = this._view.tip.iTip;
            this._worshipMars.drag = this._view.drag.iDrag;
            this._worshipMars.onCloseBtn = this.close;
            this._worshipMars.onTextLink = this._view.toolbar.onTextLink;
            this._worshipMars.onIncenseBtn = this.incense;
            return;
        }// end function

        private function getIncenseNameHtmlText(param1:String, param2:uint) : String
        {
            return HtmlText.format("[" + param1 + "]", param2);
        }// end function

        private function loadData() : void
        {
            this.mars_info(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("WorshipMars", this.render, WorshipMarsViewLang.LoadInfo);
            return;
        }// end function

        private function mars_info(param1:Function) : void
        {
            _data.call(Mod_WorshipMars_Base.mars_info, param1, [], false);
            return;
        }// end function

        private function marsInfoCallBack() : void
        {
            var _loc_1:* = this._ctrl.worshipMars.marsInfo;
            var _loc_2:* = this._ctrl.worshipMars.incenseLog;
            this._worshipMars.renderGod(_loc_1);
            this._worshipMars.renderRecordList(_loc_2);
            return;
        }// end function

        private function incense(param1:int) : void
        {
            var dialogCallBack:Function;
            var intIncenseId:* = param1;
            dialogCallBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    worshipMarsIncense();
                }
                return;
            }// end function
            ;
            var worshipMarsIncense:* = function () : void
            {
                if (!_view.ingotEnough(MarsType.getOfferingIngot(intIncenseId)))
                {
                    return;
                }
                _intIncenseID = intIncenseId;
                _data.call(Mod_WorshipMars_Base.incense, incenseCallBack, [intIncenseId], false);
                return;
            }// end function
            ;
            if (this._ctrl.worshipMars.marsInfo["is_cover"] == 1)
            {
                this.dialog.yesLabel = WorshipMarsViewLang.DialogYes;
                this.dialog.cancelLabel = WorshipMarsViewLang.DialogNo;
                this.dialog.show(WorshipMarsViewLang.IsCover, AlertButtonType.Yes | AlertButtonType.Cancel, dialogCallBack);
            }
            else
            {
                this.worshipMarsIncense();
            }
            return;
        }// end function

        private function incenseCallBack() : void
        {
            var strName:String;
            var intCount:int;
            var intExp:int;
            var intFame:int;
            var strTitle:String;
            var strMessage:String;
            var obj:* = this._ctrl.worshipMars.marsIncense;
            if (obj["result"] == Mod_WorshipMars_Base.SUCCESS)
            {
                var callBack:* = function (param1:uint) : void
            {
                mars_info(marsInfoCallBack);
                get_remain_incense_times();
                return;
            }// end function
            ;
                strName = MarsType.getOfferingName(this._intIncenseID);
                intCount = MarsType.getOfferingBlessingCount(this._intIncenseID);
                intExp = MarsType.getOfferingExp(this._intIncenseID);
                intFame = MarsType.getOfferingFame(this._intIncenseID);
                strTitle = Lang.sprintf(WorshipMarsViewLang.Incense, this.getIncenseNameHtmlText(strName, this.objIncenseColor[this._intIncenseID]));
                strMessage = Lang.sprintf(WorshipMarsViewLang.IncenseGetInfo, HtmlText.yellow(intCount.toString()), HtmlText.yellow("+" + intFame), HtmlText.yellow("+" + intExp));
                this._view.activities.showWinEffect();
                this._view.alert.confirm(strTitle + strMessage, callBack);
                _view.gameHelper.loader_first_info();
            }
            else
            {
                this._view.showTip(this.message(obj["result"]));
            }
            return;
        }// end function

        private function get_blessing_times_and_exp_add() : void
        {
            _data.call(Mod_WorshipMars_Base.get_blessing_times_and_exp_add, this.getBlessingTimesAndExpAddCountCallBack, []);
            return;
        }// end function

        private function getBlessingTimesAndExpAddCountCallBack() : void
        {
            var _loc_1:* = this._ctrl.worshipMars.getBlessingTimesAndExpAdd;
            this._view.toolbar.updateMarsBlessing(_loc_1);
            return;
        }// end function

        private function get_remain_incense_times() : void
        {
            _data.call(Mod_WorshipMars_Base.get_remain_incense_times, this.getRemainIncenseTimesCallBack, []);
            return;
        }// end function

        private function getRemainIncenseTimesCallBack() : void
        {
            var _loc_1:* = this._ctrl.worshipMars.getRemainIncenseTimes;
            if (_loc_1["remain_incense_times"] > 0)
            {
                this._view.activities.addActivity(FunctionType.WorshipMars);
            }
            else
            {
                this._view.activities.removeActivity(FunctionType.WorshipMars);
            }
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_WorshipMars_Base.SUCCESS:
                {
                    _loc_2 = WorshipMarsViewLang.Success;
                    break;
                }
                case Mod_WorshipMars_Base.OFFERINGS_NO_EXIST:
                {
                    _loc_2 = WorshipMarsViewLang.OfferingsNoExist;
                    break;
                }
                case Mod_WorshipMars_Base.COUNT_USED:
                {
                    _loc_2 = WorshipMarsViewLang.CountUsed;
                    break;
                }
                case Mod_WorshipMars_Base.INSUFFICIENT_INGOT:
                {
                    _loc_2 = WorshipMarsViewLang.InsufficientIngot;
                    break;
                }
                case Mod_WorshipMars_Base.INSUFFICIENT_SKILL:
                {
                    _loc_2 = WorshipMarsViewLang.InsufficientSkill;
                    break;
                }
                case Mod_WorshipMars_Base.NO_ENOUGTH_VIP:
                {
                    _loc_2 = WorshipMarsViewLang.NoEnougthVip;
                    break;
                }
                default:
                {
                    _loc_2 = WorshipMarsViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
