package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class FactionBlessingView extends Base implements IView
    {
        private var _factionBlessing:IFactionBlessing;
        private var _intIncenseID:int;
        private var objIncenseColor:Object;

        public function FactionBlessingView()
        {
            this.objIncenseColor = {1:HtmlText.White, 2:44783, 3:16776960};
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
            this._factionBlessing.clear();
            this.dialog.hide();
            return;
        }// end function

        public function checkIncense() : void
        {
            if (!this._view.townMap.inStage)
            {
                return;
            }
            var _loc_1:* = TownType.getTownNPCIdByFunc(_ctrl.player.mapId, NPCType.FactionGodNPC);
            if (_loc_1 != 0)
            {
                _view.townMap.setBuildGetVisible(1, _ctrl.player.canIncenseCount > 0);
            }
            this.getBlessingCount();
            return;
        }// end function

        public function getBlessingCount() : void
        {
            this.get_blessing_count();
            return;
        }// end function

        public function gotoFactionBlessing() : void
        {
            var _loc_1:* = TownType.getTownNPCIdByFunc(_ctrl.player.mapId, NPCType.FactionGodNPC);
            if (_loc_1 == 0)
            {
                _view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
            }
            this.showFactionBlessing();
            return;
        }// end function

        public function getFactionBlessingCount() : void
        {
            var _loc_1:Object = {sign:ActivityType.FactionBlessing, isStart:_ctrl.player.canIncenseCount > 0 ? (1) : (2), isShowTimer:false, explain:Lang.sprintf(FactionBlessingViewLang.EverydayBlessingTimes, _ctrl.player.canIncenseCount), isShowBtnEffic:false, btnInfo:_ctrl.player.canIncenseCount > 0 ? (FactionBlessingViewLang.ImmeJoin) : (""), btnType:1};
            this._view.factionWindow.getActivityState(_loc_1);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._factionBlessing.content);
            _view.center(sign, this._factionBlessing.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._factionBlessing == null)
            {
                this._factionBlessing = _view.getAssetsObject("FactionBlessing", "FactionBlessing") as IFactionBlessing;
            }
            this.init();
            this._factionBlessing.render();
            this.factionGodInfoCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._factionBlessing.tip = this._view.tip.iTip;
            this._factionBlessing.drag = this._view.drag.iDrag;
            this._factionBlessing.onCloseBtn = this.close;
            this._factionBlessing.onTextLink = this._view.toolbar.onTextLink;
            this._factionBlessing.onIncenseBtn = this.incense;
            return;
        }// end function

        private function getIncenseNameHtmlText(param1:String, param2:uint) : String
        {
            return HtmlText.format("[" + param1 + "]", param2);
        }// end function

        private function showFactionBlessing() : void
        {
            if (_view.initLoading.inStage)
            {
                setTimeout(this.showFactionBlessing, 500);
            }
            else
            {
                _view.factionBlessing.show();
            }
            return;
        }// end function

        private function loadData() : void
        {
            _data.call(Mod_Faction_Base.faction_god_info, this.loadDataCallBack, [], false);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("FactionBlessing", this.render, FactionBlessingViewLang.Loadinfo);
            return;
        }// end function

        private function faction_god_info() : void
        {
            _data.call(Mod_Faction_Base.faction_god_info, this.factionGodInfoCallBack, [], false);
            return;
        }// end function

        private function factionGodInfoCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.godInfo;
            var _loc_2:* = this._ctrl.faction.incenseLog;
            this._factionBlessing.renderGod(_loc_1);
            this._factionBlessing.renderRecordList(_loc_2);
            return;
        }// end function

        private function incense(param1:int) : void
        {
            var callBack:Function;
            var intIncenseId:* = param1;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    factionIncense();
                }
                return;
            }// end function
            ;
            var factionIncense:* = function () : void
            {
                if (!_view.ingotEnough(FactionType.getOfferIngot(intIncenseId)))
                {
                    return;
                }
                _intIncenseID = intIncenseId;
                _data.call(Mod_Faction_Base.incense, incenseCallBack, [intIncenseId], false);
                return;
            }// end function
            ;
            if (this._ctrl.faction.godInfo["is_cover"] == 1)
            {
                this.dialog.yesLabel = FactionBlessingViewLang.DialogYes;
                this.dialog.cancelLabel = FactionBlessingViewLang.DialogNo;
                this.dialog.show(FactionBlessingViewLang.IsCover, AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            }
            else
            {
                this.factionIncense();
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
            var obj:* = this._ctrl.faction.incense;
            if (obj["result"] == Mod_Faction_Base.SUCCESS)
            {
                var callBack:* = function (param1:uint) : void
            {
                faction_god_info();
                return;
            }// end function
            ;
                strName = FactionType.getOfferName(this._intIncenseID);
                intCount = FactionType.getOfferBlessingCount(this._intIncenseID);
                intExp = FactionType.getOfferExp(this._intIncenseID);
                intFame = FactionType.getOfferFame(this._intIncenseID);
                strTitle = Lang.sprintf(FactionBlessingViewLang.Incense, this.getIncenseNameHtmlText(strName, this.objIncenseColor[this._intIncenseID]));
                strMessage = Lang.sprintf(FactionBlessingViewLang.IncenseGetInfo, HtmlText.yellow(intCount.toString()), HtmlText.yellow("+" + intFame), HtmlText.yellow("+" + intExp));
                this.dialog.yesLabel = FactionBlessingViewLang.DialogYes;
                this.dialog.show(strTitle + strMessage, AlertButtonType.Yes, callBack);
                this._view.activities.showWinEffect();
                this._view.gameHelper.loader_first_info();
            }
            else
            {
                this._view.showTip(this.message(obj["result"]));
            }
            return;
        }// end function

        private function get_blessing_count() : void
        {
            _data.call(Mod_Faction_Base.get_blessing_count, this.getBlessingCountCallBack, []);
            return;
        }// end function

        private function getBlessingCountCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.blessingCount;
            this._view.toolbar.updateFactionBlessing(_loc_1);
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Faction_Base.SUCCESS:
                {
                    _loc_2 = FactionBlessingViewLang.Success;
                    break;
                }
                case Mod_Faction_Base.MEMBER_NO_EXIST:
                {
                    _loc_2 = FactionBlessingViewLang.MemberNoExist;
                    break;
                }
                case Mod_Faction_Base.FACTION_NO_EXIST:
                {
                    _loc_2 = FactionBlessingViewLang.FactionNoExist;
                    break;
                }
                case Mod_Faction_Base.OFFERINGS_NO_EXIST:
                {
                    _loc_2 = FactionBlessingViewLang.OfferingsNoExist;
                    break;
                }
                case Mod_Faction_Base.COUNT_USED:
                {
                    _loc_2 = FactionBlessingViewLang.CountUsed;
                    break;
                }
                case Mod_Faction_Base.INSUFFICIENT_INGOT:
                {
                    _loc_2 = FactionBlessingViewLang.InsufficientIngot;
                    break;
                }
                case Mod_Faction_Base.INSUFFICIENT_SKILL:
                {
                    _loc_2 = FactionBlessingViewLang.InsufficientSkill;
                    break;
                }
                default:
                {
                    _loc_2 = FactionBlessingViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
