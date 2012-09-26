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

    public class FactionSealView extends Base implements IView
    {
        private var _factionSeal:IFactionSeal;
        private var _intMaxJoinCont:int;
        private var _intIsCompleteSeal:int;
        private var _intIsInSeal:int;
        private var _imgSealedCartoon:Image;
        private var _blnIsJoined:Boolean = false;
        private var _blnInCallNpc:Boolean = false;

        public function FactionSealView()
        {
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        public function show() : void
        {
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionSeal) > ActivityType.FactionLevel)
            {
                return;
            }
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.close_seal_satan();
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._data.cancelPatch(Mod_Faction_Base.seal_satan_join_notify);
            this._data.cancelPatch(Mod_Faction_Base.seal_satan_award_notify);
            this._factionSeal.clear();
            this.dialog.hide();
            this._imgSealedCartoon = null;
            Helper.gc();
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._factionSeal.content);
            _view.center(sign, this._factionSeal.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._factionSeal == null)
            {
                this._factionSeal = _view.getAssetsObject("FactionSeal", "FactionSeal") as IFactionSeal;
            }
            this.init();
            this._factionSeal.render();
            this.sealSatanMemberListCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._blnIsJoined = false;
            this._factionSeal.tip = this._view.tip.iTip;
            this._factionSeal.drag = this._view.drag.iDrag;
            this._factionSeal.playerID = this._ctrl.player.playerId;
            this._factionSeal.onCloseBtn = this.close;
            this._factionSeal.onCallPlayerBtn = this.seal_satan_call_faction_member;
            this._factionSeal.onCallNpcBtn = this.callNpc;
            this._factionSeal.onJoinBtn = this.join_seal_satan;
            this.loadSealingCartoon();
            return;
        }// end function

        private function callNpc() : void
        {
            if (!_view.consumeAlertSetting.isAlert(ConsumeAlertSetType.FactionSealCallNpc))
            {
                var callBack:* = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    seal_satan_call_npc();
                }
                if (dialog.checked)
                {
                    _view.consumeAlertSetting.saveSetting(ConsumeAlertSetType.FactionSealCallNpc, true);
                }
                return;
            }// end function
            ;
                this.dialog.yesLabel = FactionSealViewLang.DialogYes;
                this.dialog.noLabel = FactionSealViewLang.DialogNo;
                this.dialog.hasCheckbox = true;
                this.dialog.show(Lang.sprintf(FactionSealViewLang.CallNpc, HtmlText.yellow("5" + FactionSealViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.No, callBack);
            }
            else
            {
                this.seal_satan_call_npc();
            }
            return;
        }// end function

        private function updateFactionSealActivity(param1:Object) : void
        {
            var _loc_2:String = "";
            var _loc_3:String = "";
            var _loc_4:Boolean = false;
            var _loc_5:String = "";
            if (this._intIsInSeal == Mod_Faction_Base.YES)
            {
                _loc_2 = Lang.sprintf(FactionSealViewLang.NumberOfPeople, param1["join_member_count"], param1["max_join_count"]) + HtmlText.green(FactionSealViewLang.Sealing);
                _loc_3 = FactionSealViewLang.Query;
            }
            else
            {
                _loc_2 = Lang.sprintf(FactionSealViewLang.NumberOfPeople, param1["join_member_count"], param1["max_join_count"]);
                _loc_3 = FactionSealViewLang.ImmeJoin;
            }
            if (this._intIsCompleteSeal == Mod_Faction_Base.YES)
            {
                _loc_2 = Lang.sprintf(FactionSealViewLang.NumberOfPeople, param1["join_member_count"], param1["max_join_count"]) + HtmlText.green(FactionSealViewLang.Joined);
            }
            var _loc_6:* = this._ctrl.faction.isCanJoinActivity;
            if (this._ctrl.faction.isCanJoinActivity["result"] == Mod_Faction_Base.YES)
            {
                _loc_4 = false;
            }
            else
            {
                _loc_4 = true;
                _loc_5 = FactionSealViewLang.NewMember;
            }
            var _loc_7:Object = {sign:ActivityType.FactionSeal, isStart:1, isShowTimer:false, isShowBtnEffic:false, explain:_loc_2, btnInfo:_loc_3, btnType:1, isFilter:_loc_4, btnTipInfo:_loc_5};
            this._view.factionWindow.getActivityState(_loc_7);
            return;
        }// end function

        private function loadSealingCartoon() : void
        {
            var img:Image;
            img = new Image(URI.assetsUrl + "faction_sealing_cartoon.swf");
            img.onComplete = function () : void
            {
                _factionSeal.renderSealingCartoon(img);
                loadSealedCartoon();
                return;
            }// end function
            ;
            return;
        }// end function

        private function loadSealedCartoon() : void
        {
            var img:Image;
            img = new Image(URI.assetsUrl + "faction_sealed_cartoon.swf");
            img.onComplete = function () : void
            {
                _imgSealedCartoon = img;
                return;
            }// end function
            ;
            return;
        }// end function

        private function joinSealAward() : void
        {
            var cartoonCallBack:Function;
            var callBack:Function;
            cartoonCallBack = function () : void
            {
                var _loc_1:* = _ctrl.faction.sealSatanAwardNotify;
                var _loc_2:String = "";
                if (_loc_1["result"] == Mod_Faction_Base.AWARD)
                {
                    _loc_2 = Lang.sprintf(FactionSealViewLang.SealAward, HtmlText.yellow(_loc_1["award_fame"] + FactionSealViewLang.Fame));
                }
                else if (_loc_1["result"] == Mod_Faction_Base.HELP)
                {
                    _loc_2 = FactionSealViewLang.SealHelp;
                }
                dialog.yesLabel = FactionSealViewLang.DialogYes;
                dialog.show(_loc_2, AlertButtonType.Yes, callBack);
                return;
            }// end function
            ;
            callBack = function (param1:uint) : void
            {
                close();
                return;
            }// end function
            ;
            if (this._imgSealedCartoon != null)
            {
                this._factionSeal.renderSealedCartoon(this._imgSealedCartoon, cartoonCallBack);
            }
            else
            {
                setTimeout(this.joinSealAward, 100);
                return;
            }
            return;
        }// end function

        private function unJoinSealAward() : void
        {
            var callBack:Function;
            callBack = function (param1:uint) : void
            {
                seal_satan_member_list();
                return;
            }// end function
            ;
            this.dialog.yesLabel = FactionSealViewLang.DialogYes;
            this.dialog.show(FactionSealViewLang.SealFinish, AlertButtonType.Yes, callBack);
            return;
        }// end function

        private function renderFactionSealInfo(param1:Array) : void
        {
            var _loc_2:Object = null;
            this._blnIsJoined = false;
            for each (_loc_2 in param1)
            {
                
                if (_loc_2["id"] == this._ctrl.player.playerId)
                {
                    this._blnIsJoined = true;
                    break;
                }
            }
            this._factionSeal.renderFactionSealInfo(param1, this._intMaxJoinCont, this._blnIsJoined);
            return;
        }// end function

        private function renderSealSatanInfo(param1:Object) : void
        {
            if (param1["is_complete_seal"] != Mod_Faction_Base.KEEP)
            {
                this._intIsCompleteSeal = param1["is_complete_seal"];
            }
            if (param1["is_in_seal"] != Mod_Faction_Base.KEEP)
            {
                this._intIsInSeal = param1["is_in_seal"];
            }
            if (param1["join_member_count"] == 0 && (param1["is_complete_seal"] == Mod_Faction_Base.KEEP || this._intIsInSeal == Mod_Faction_Base.KEEP))
            {
                this.seal_satan_info();
                return;
            }
            this.updateFactionSealActivity(param1);
            this._intMaxJoinCont = param1["max_join_count"];
            return;
        }// end function

        private function loadData() : void
        {
            var callBack:Function;
            callBack = function () : void
            {
                if (_ctrl.faction.isCanJoinActivity["result"] == Mod_Faction_Base.YES)
                {
                    _data.call(Mod_Faction_Base.seal_satan_member_list, loadDataCallBack, []);
                }
                else
                {
                    _view.alert.confirm(FactionSealViewLang.NewMember);
                }
                return;
            }// end function
            ;
            this._data.call(Mod_Faction_Base.is_can_join_activity, callBack, []);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("FactionSeal", this.render, FactionSealViewLang.LoadInfo);
            return;
        }// end function

        public function seal_satan_member_list() : void
        {
            this._data.call(Mod_Faction_Base.seal_satan_member_list, this.sealSatanMemberListCallBack, []);
            return;
        }// end function

        private function sealSatanMemberListCallBack() : void
        {
            this.seal_satan_join_notify();
            this.seal_satan_award_notify();
            this.renderFactionSealInfo(this._ctrl.faction.sealSatanMemberList);
            return;
        }// end function

        private function close_seal_satan() : void
        {
            this._data.call(Mod_Faction_Base.close_seal_satan, null, []);
            return;
        }// end function

        private function join_seal_satan() : void
        {
            this._data.call(Mod_Faction_Base.join_seal_satan, this.joinSealSatanCallBack, []);
            return;
        }// end function

        private function joinSealSatanCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.joinSealSatan;
            if (_loc_1["result"] == Mod_Faction_Base.JOIN_SUCCESS)
            {
                this._view.showTip(this.message(_loc_1["result"]), null, TipType.Success);
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            return;
        }// end function

        private function seal_satan_call_npc() : void
        {
            if (this._blnInCallNpc)
            {
                return;
            }
            this._blnInCallNpc = true;
            this._data.call(Mod_Faction_Base.seal_satan_call_npc, this.sealSatanCallNpcCallBack, []);
            return;
        }// end function

        private function sealSatanCallNpcCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.sealSatanCallNpc;
            if (_loc_1["result"] == Mod_Faction_Base.CALL_SUCCESS)
            {
                this._view.showTip(this.message(_loc_1["result"]), null, TipType.Success);
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            this._blnInCallNpc = false;
            return;
        }// end function

        private function seal_satan_join_notify() : void
        {
            this._data.patch(Mod_Faction_Base.seal_satan_join_notify, this.sealSatanJoinNotifyCallBack);
            return;
        }// end function

        private function sealSatanJoinNotifyCallBack() : void
        {
            this.renderFactionSealInfo(this._ctrl.faction.sealSatanJoinNotify);
            return;
        }// end function

        private function seal_satan_award_notify() : void
        {
            this._data.patch(Mod_Faction_Base.seal_satan_award_notify, this.sealSatanAwardNotifyCallBack);
            return;
        }// end function

        private function sealSatanAwardNotifyCallBack() : void
        {
            this._data.cancelPatch(Mod_Faction_Base.seal_satan_join_notify);
            this._data.cancelPatch(Mod_Faction_Base.seal_satan_award_notify);
            if (this._blnIsJoined)
            {
                this.joinSealAward();
            }
            else
            {
                this.unJoinSealAward();
            }
            return;
        }// end function

        private function seal_satan_call_faction_member() : void
        {
            this._data.call(Mod_Faction_Base.seal_satan_call_faction_member, this.sealSatanCallFactionMemberCallBack, [], false);
            return;
        }// end function

        private function sealSatanCallFactionMemberCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.sealSatanCallFactionMember;
            if (_loc_1["result"] == Mod_Faction_Base.SUCCESS)
            {
                this._view.chat.changeChannel(Mod_Chat_Base.FACTION);
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            return;
        }// end function

        public function seal_satan_info() : void
        {
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionSeal) > ActivityType.FactionLevel)
            {
                return;
            }
            this._data.call(Mod_Faction_Base.seal_satan_info, this.sealSatanInfoCallBack, []);
            return;
        }// end function

        public function sealSatanInfoCallBack() : void
        {
            this.renderSealSatanInfo(this._ctrl.faction.sealSatanInfo);
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Faction_Base.CALL_SUCCESS:
                {
                    _loc_2 = FactionSealViewLang.CallSuccess;
                    break;
                }
                case Mod_Faction_Base.IS_JOIN:
                {
                    _loc_2 = FactionSealViewLang.IsJoin;
                    break;
                }
                case Mod_Faction_Base.NOT_JOIN:
                {
                    _loc_2 = FactionSealViewLang.NotJoin;
                    break;
                }
                case Mod_Faction_Base.TEAM_EXPIRED:
                {
                    _loc_2 = FactionSealViewLang.TeamExpired;
                    break;
                }
                case Mod_Faction_Base.INSUFFICIENT_INGOT:
                {
                    _loc_2 = FactionSealViewLang.InsufficientIngot;
                    break;
                }
                case Mod_Faction_Base.JOIN_SUCCESS:
                {
                    _loc_2 = FactionSealViewLang.JoinSuccess;
                    break;
                }
                case Mod_Faction_Base.FULL_MEMBER:
                {
                    _loc_2 = FactionSealViewLang.FullMember;
                    break;
                }
                case Mod_Faction_Base.FULL_NPC:
                {
                    _loc_2 = FactionSealViewLang.FullNpc;
                    break;
                }
                case Mod_Faction_Base.ERROR:
                {
                    _loc_2 = FactionSealViewLang.Error1;
                    break;
                }
                default:
                {
                    _loc_2 = FactionSealViewLang.Error2 + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
