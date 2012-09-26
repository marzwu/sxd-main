package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.events.*;

    public class MyFactionView extends Base implements IView
    {
        private var _factionId:int = 0;
        private var _myFactionData:Object;
        private var _newMemberList:Array;
        private var _applyList:Array;
        private var _myFaction:IMyFaction;
        private var _showType:String = "member";
        private var _InvitationId:int = 0;
        private var _InvitationName:String = "";
        private var _invitationNum:int = 0;
        private var _isInviation:Boolean = false;
        private var _lostTime:int = 0;
        private var _InvitationTime:int = 0;
        private var _kickoutMemberData:Object;

        public function MyFactionView()
        {
            return;
        }// end function

        private function my_faction_info() : void
        {
            _data.call(Mod_Faction_Base.my_faction_info, this.myFactionInfoCallback, []);
            return;
        }// end function

        private function member_list() : void
        {
            _data.call(Mod_Faction_Base.member_list, this.memberListCallback, [this._factionId, ""]);
            return;
        }// end function

        private function request_list() : void
        {
            _data.call(Mod_Faction_Base.request_list, this.applyListCallback, [this._factionId]);
            return;
        }// end function

        public function accept_request(param1:int) : void
        {
            _data.call(Mod_Faction_Base.accept_request, this.acceptRequestCallback, [param1]);
            return;
        }// end function

        public function quit_faction() : void
        {
            _data.call(Mod_Faction_Base.quit_faction, this.quitFactionCallback, []);
            return;
        }// end function

        public function deny_request(param1:int) : void
        {
            _data.call(Mod_Faction_Base.deny_request, this.denyRequestCallback, [param1], false);
            return;
        }// end function

        public function appoint_job(param1:int) : void
        {
            _data.call(Mod_Faction_Base.appoint_job, this.appointJobCallback, [param1]);
            return;
        }// end function

        public function kickout_member(param1:int) : void
        {
            _data.call(Mod_Faction_Base.kickout_member, this.kickoutMemberCallback, [param1]);
            return;
        }// end function

        public function dismiss_job(param1:int) : void
        {
            _data.call(Mod_Faction_Base.dismiss_job, this.dismissJobCallback, [param1]);
            return;
        }// end function

        public function master_transfer(param1:int) : void
        {
            _data.call(Mod_Faction_Base.master_transfer, this.masterTransferJobCallback, [param1]);
            return;
        }// end function

        private function modify_notice(param1:String) : void
        {
            _data.call(Mod_Faction_Base.modify_faction_notice, this.modifyNoticeCallBack, [this._factionId, param1]);
            return;
        }// end function

        private function modify_desc(param1:String) : void
        {
            _data.call(Mod_Faction_Base.modify_faction_desc, this.modifyDescCallBack, [this._factionId, param1]);
            return;
        }// end function

        private function disband_faction() : void
        {
            _data.call(Mod_Faction_Base.disband_faction, this.disbandFactionCallBack, [this._factionId]);
            return;
        }// end function

        private function modify_group_number(param1:String) : void
        {
            _data.call(Mod_Faction_Base.modify_group_number, this.groupNumberCallBack, [this._factionId, param1]);
            return;
        }// end function

        private function faction_contribution_list() : void
        {
            _data.call(Mod_Faction_Base.faction_contribution_list, this.contributionListCallBack, []);
            return;
        }// end function

        private function clean_faction_request() : void
        {
            _data.call(Mod_Faction_Base.clean_faction_request, this.cleanFactionRequestCallBack, [this._factionId]);
            return;
        }// end function

        private function get_faction_master_trace() : void
        {
            _data.call(Mod_Faction_Base.get_faction_master_trace, this.factionMasterTraceCallBack, []);
            return;
        }// end function

        private function seize_the_throne() : void
        {
            _data.call(Mod_Faction_Base.seize_the_throne, this.seizeTheThroneCallBack, []);
            return;
        }// end function

        public function invite_info() : void
        {
            _data.call(Mod_Faction_Base.invite_info, this.inviteInfoCallBack, []);
            return;
        }// end function

        private function invite_info_ed() : void
        {
            _data.call(Mod_Faction_Base.invite_info, this.inviteInfoEdCallBack, []);
            return;
        }// end function

        private function myFactionInfoCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.myFactionInfo;
            if (_loc_1.msg == "myFaction")
            {
                this._myFactionData = _loc_1.factionData;
                this._factionId = _loc_1.factionData.factionId;
                this._ctrl.player.playerInfo.factionId = _loc_1.factionData.factionId;
                this._ctrl.player.playerInfo.factionName = _loc_1.factionData.factionName;
                if (this.inStage)
                {
                    this._myFaction.getFactionData = _loc_1.factionData;
                }
                else
                {
                    loadAssets("MyFaction", this.render, MyFactionViewLang.LoadAssets);
                }
            }
            else
            {
                _view.joinFaction.switchSelf();
            }
            return;
        }// end function

        private function memberListCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.memberList;
            var _loc_2:* = this.sortPosition(_loc_1, 1);
            var _loc_3:* = this.sortPosition(_loc_1, 2);
            var _loc_4:* = this.sortPosition(_loc_1, 0);
            _loc_2.sortOn("contribution", Array.NUMERIC | Array.DESCENDING);
            _loc_3.sortOn("contribution", Array.NUMERIC | Array.DESCENDING);
            _loc_4.sortOn("contribution", Array.NUMERIC | Array.DESCENDING);
            this._newMemberList = [];
            this.mergerList(_loc_2);
            this.mergerList(_loc_3);
            this.mergerList(_loc_4);
            this._myFaction.getFactionPersonList = this._newMemberList;
            return;
        }// end function

        private function sortPosition(param1:Array, param2:int) : Array
        {
            var _loc_6:Object = null;
            var _loc_3:* = param1.length;
            var _loc_4:Array = [];
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = param1[_loc_5];
                if (_loc_6.positionNum == param2)
                {
                    _loc_4.push(_loc_6);
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        private function mergerList(param1:Array) : void
        {
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                this._newMemberList.push(param1[_loc_3]);
                _loc_3++;
            }
            return;
        }// end function

        private function kickoutMemberCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.kickoutMember;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                this.member_list();
                this.my_faction_info();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function applyListCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.applyList;
            this._myFaction.getFactionApplyList = _loc_1;
            return;
        }// end function

        private function joinPlayer(param1:String) : void
        {
            var _loc_4:Object = null;
            var _loc_2:* = this._applyList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._applyList[_loc_3];
                if (param1 == _loc_4.name)
                {
                    this.accept_request(_loc_4.applyId);
                    return;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function acceptRequestCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.acceptApply;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                this.request_list();
                this.my_faction_info();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function quitFactionCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.quitFaction;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                this.close();
                _view.townMap.quitJiHuiSuo();
                _ctrl.player.playerInfo.factionId = 0;
                _ctrl.player.playerInfo.factionName = "";
                this._view.toolbar.renderFactionRollCakeLink(0);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function denyRequestCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.denyApply;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                this.request_list();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function cleanFactionRequestCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.cleanFactionRequest;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                this.request_list();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function appointJobCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.appointJob;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                this.member_list();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function dismissJobCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.dismissJob;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                this.member_list();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function modifyNoticeCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.modifyNotice;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                this._myFaction.getFactionData = _loc_1.factionData;
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function modifyDescCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.modifyInfo;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                _view.showTip(MyFactionViewLang.SubmitSuccess, MyFactionViewLang.SystemInfo, TipType.Success);
                this._myFaction.getFactionData = _loc_1.factionData;
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        public function masterTransferJobCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.transfer;
            switch(this._showType)
            {
                case "log":
                {
                    break;
                }
                case "member":
                case "audit":
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

        private function disbandFactionCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.disbandFaction;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                _view.showTip(MyFactionViewLang.DisbandSuccess, MyFactionViewLang.SystemInfo, TipType.Success);
                _view.joinFaction.switchSelf();
                _view.townMap.quitJiHuiSuo();
                this._view.toolbar.renderFactionRollCakeLink(0);
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function groupNumberCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.groupNumber;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                this._myFaction.getFactionData = _loc_1.factionData;
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function contributionListCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.contributionList;
            this._myFaction.getFactionLogList = _loc_1;
            return;
        }// end function

        private function factionMasterTraceCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.factionMasterTracel;
            return;
        }// end function

        private function seizeTheThroneCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.seizeTheThrone;
            switch(this._showType)
            {
                case "log":
                {
                    break;
                }
                case "member":
                {
                    break;
                }
                case "audit":
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

        private function inviteInfoCallBack() : void
        {
            var _loc_1:* = _ctrl.faction.inviteInfo;
            this._myFaction.getInviteInfo(_loc_1);
            return;
        }// end function

        private function inviteInfoEdCallBack() : void
        {
            var _loc_1:* = _ctrl.faction.inviteInfo;
            this._myFaction.getInviteInfo(_loc_1);
            this.sendInvitation(_loc_1);
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_Faction_Base.CAMP_ERR:
                {
                    _view.showTip(MyFactionViewLang.CampErr);
                    break;
                }
                case Mod_Faction_Base.INSUFFICIENT_COIN:
                {
                    _view.showTip(MyFactionViewLang.InsufficientCoin);
                    break;
                }
                case Mod_Faction_Base.NOT_FREE_PLAYER:
                {
                    _view.showTip(MyFactionViewLang.NoFreePlayer);
                    break;
                }
                case Mod_Faction_Base.FOUND_ONE_FACTION:
                {
                    _view.showTip(MyFactionViewLang.FoundOneFaction);
                    break;
                }
                case Mod_Faction_Base.NOT_FACTION_MASTER:
                {
                    _view.showTip(MyFactionViewLang.NotFactionMaster);
                    break;
                }
                case Mod_Faction_Base.FACTION_NAME_EXISTED:
                {
                    _view.showTip(MyFactionViewLang.FactionNameExisted);
                    break;
                }
                case Mod_Faction_Base.FACTION_NAME_INVALID:
                {
                    _view.showTip(MyFactionViewLang.FactionNameInvalid);
                    break;
                }
                case Mod_Faction_Base.FACTION_DESC_INVALID:
                {
                    _view.showTip(MyFactionViewLang.FactionDescInvalid);
                    break;
                }
                case Mod_Faction_Base.FACTION_NOT_EXIST:
                {
                    _view.showTip(MyFactionViewLang.FactionNotExist);
                    break;
                }
                case Mod_Faction_Base.NOT_FREE_PLAYER:
                {
                    _view.showTip(MyFactionViewLang.NotFreePlayer);
                    break;
                }
                case Mod_Faction_Base.REQUEST_NUM_LIMIT:
                {
                    _view.showTip(MyFactionViewLang.RequestNumLimit);
                    break;
                }
                case Mod_Faction_Base.REQUEST_NOT_EXIST:
                {
                    _view.showTip(MyFactionViewLang.RequestNotExist);
                    break;
                }
                case Mod_Faction_Base.NO_FACTION_JOB:
                {
                    _view.showTip(MyFactionViewLang.NoFactionJob);
                    break;
                }
                case Mod_Faction_Base.IN_FACTION_WAR:
                {
                    _view.showTip(MyFactionViewLang.InFactionWar);
                    break;
                }
                case Mod_Faction_Base.MANAGER_NUM_LIMIT:
                {
                    _view.showTip(MyFactionViewLang.ManagerNumLimit);
                    break;
                }
                case Mod_Faction_Base.INSUFFICIENT_INGOT:
                {
                    _view.showTip(MyFactionViewLang.InsufficientIngot);
                    break;
                }
                case Mod_Faction_Base.FAIL:
                {
                    _view.showTip(MyFactionViewLang.Fail);
                    break;
                }
                case Mod_Faction_Base.IS_MASTER:
                {
                    _view.showTip(MyFactionViewLang.IsMaster);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            if (_view.factionWarMap.isFactionWarStart == true)
            {
                return;
            }
            this.my_faction_info();
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        public function render() : void
        {
            this._myFaction = _view.getAssetsObject("MyFaction", "MyFaction") as IMyFaction;
            _popup.addView(this, this._myFaction.content);
            _view.center(sign, this._myFaction.content);
            this._myFaction.tip = _view.tip.iTip;
            this._myFaction.drag = _view.drag.iDrag;
            this._myFaction.getFactionData = this._myFactionData;
            this.member_list();
            this.get_faction_master_trace();
            this._myFaction.isInAssembly = _ctrl.player.jihuisuoId != 0;
            this._myFaction.onAddFriend = function (param1:Object) : void
            {
                if (param1.playerId == _ctrl.player.playerId)
                {
                    return;
                }
                _view.friendList.addFriend(param1.playerName);
                return;
            }// end function
            ;
            this._myFaction.onAppointJob = function (param1:Object) : void
            {
                appoint_job(param1.memberId);
                return;
            }// end function
            ;
            this._myFaction.onDismissJob = function (param1:Object) : void
            {
                dismiss_job(param1.factionJobId);
                return;
            }// end function
            ;
            this._myFaction.onTanHe = function () : void
            {
                if (_view.vipEnabled == false || _view.ingotEnough(100) == false)
                {
                    return;
                }
                var _loc_1:* = Lang.sprintf(MyFactionViewLang.TanHeInfo, HtmlText.yellow("100") + MyFactionViewLang.Ingot);
                _view.alert.showYesNoMsg(_loc_1, MyFactionViewLang.Sure, MyFactionViewLang.Cancel, onTanHe);
                return;
            }// end function
            ;
            this._myFaction.onkickoutMember = function (param1:Object) : void
            {
                _kickoutMemberData = param1;
                _view.alert.showYesNoMsg(Lang.sprintf(MyFactionViewLang.KickoutMember, param1.showName), MyFactionViewLang.Sure, MyFactionViewLang.Cancel, onKickoutFaction);
                return;
            }// end function
            ;
            this._myFaction.onOpenJoinFaction = function () : void
            {
                _view.joinFaction.joinFactionType = true;
                _view.joinFaction.show();
                return;
            }// end function
            ;
            this._myFaction.onOpenSsembly = function () : void
            {
                if (_view.nineRegionsMap.inStageWithTip)
                {
                    return;
                }
                if (_view.beelzebubTrialsMap.inStageWithTip)
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
                if (_view.topWarMap.inStageWithTip)
                {
                    return;
                }
                _view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
                return;
            }// end function
            ;
            this._myFaction.onPk = function (param1:Object) : void
            {
                _view.pkWar.defenderPlayerId = param1.playerId;
                _view.pkWar.show();
                return;
            }// end function
            ;
            this._myFaction.onQuit = function () : void
            {
                _view.alert.showYesNoMsg(MyFactionViewLang.QuitFaction, MyFactionViewLang.Sure, MyFactionViewLang.Cancel, onQuitFaction);
                return;
            }// end function
            ;
            this._myFaction.onSendMessige = function (param1:Object) : void
            {
                if (param1.playerId == _ctrl.player.playerId)
                {
                    return;
                }
                _view.friendChat.get_friendinfo_chatrecord_list(param1.playerId);
                return;
            }// end function
            ;
            this._myFaction.onSendFlower = function (param1:Object) : void
            {
                _view.sendFlower.sendPlayerID = param1.playerId;
                _view.sendFlower.show();
                return;
            }// end function
            ;
            this._myFaction.onPersonCheck = function (param1:Object) : void
            {
                if (param1.playerId == _ctrl.player.playerId)
                {
                    return;
                }
                if (_view.otherRoleMsg.inStage)
                {
                    _view.otherRoleMsg.close();
                }
                _view.otherRoleMsg.init(param1.playerId, param1.name);
                _view.otherRoleMsg.show();
                return;
            }// end function
            ;
            this._myFaction.onRefuse = function (param1:Object) : void
            {
                deny_request(param1.applyId);
                return;
            }// end function
            ;
            this._myFaction.onThrough = function (param1:Object, param2:Boolean) : void
            {
                if (param2 == false)
                {
                    _view.showTip(MyFactionViewLang.FactionFull);
                    return;
                }
                accept_request(param1.applyId);
                return;
            }// end function
            ;
            this._myFaction.onShowAudit = function () : void
            {
                request_list();
                _showType = "audit";
                return;
            }// end function
            ;
            this._myFaction.onShowLog = function () : void
            {
                faction_contribution_list();
                _showType = "log";
                return;
            }// end function
            ;
            this._myFaction.onShowPerson = function () : void
            {
                member_list();
                _showType = "member";
                return;
            }// end function
            ;
            this._myFaction.onTextLink = function (event:TextEvent) : void
            {
                _view.toolbar.onTextLink(event);
                return;
            }// end function
            ;
            this._myFaction.onTransferFaction = function (param1:Object) : void
            {
                master_transfer(param1.factionJobId);
                return;
            }// end function
            ;
            this._myFaction.onDismissSure = function (param1:String) : void
            {
                _view.alert.showYesNoMsg(MyFactionViewLang.DismissSure, MyFactionViewLang.Sure, MyFactionViewLang.Cancel, onDismissFaction);
                return;
            }// end function
            ;
            this._myFaction.onNoticeInfo = function (param1:String) : void
            {
                modify_notice(param1);
                return;
            }// end function
            ;
            this._myFaction.onDescInfo = function (param1:String) : void
            {
                modify_desc(param1);
                return;
            }// end function
            ;
            this._myFaction.onGroupNumber = function (param1:String) : void
            {
                modify_group_number(param1);
                return;
            }// end function
            ;
            this._myFaction.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._myFaction.onReturnTown = function () : void
            {
                if (_view.nineRegionsMap.inStageWithTip)
                {
                    return;
                }
                if (_view.beelzebubTrialsMap.inStageWithTip)
                {
                    return;
                }
                if (_view.topWarMap.inStageWithTip)
                {
                    return;
                }
                _view.townMap.quitJiHuiSuo();
                return;
            }// end function
            ;
            this._myFaction.onAllRefuse = function (param1:int) : void
            {
                if (param1 <= 0)
                {
                    _view.showTip(MyFactionViewLang.AllRefuse);
                }
                else
                {
                    clean_faction_request();
                }
                return;
            }// end function
            ;
            this._myFaction.onInvitation = function (param1:int, param2:String) : void
            {
                _InvitationId = param1;
                _InvitationName = param2;
                invite_info_ed();
                return;
            }// end function
            ;
            return;
        }// end function

        private function sendInvitation(param1:Object) : void
        {
            if (_ctrl.player.ingot < param1.needIngot)
            {
                _view.showTip(MyFactionViewLang.InsufficientIngot);
                return;
            }
            var _loc_2:String = "";
            if (param1.needIngot > 0)
            {
                _loc_2 = _loc_2 + (MyFactionViewLang.User + HtmlText.yellow(param1.needIngot + MyFactionViewLang.Ingot));
            }
            else
            {
                _loc_2 = _loc_2 + MyFactionViewLang.NoIngot;
            }
            _loc_2 = _loc_2 + Lang.sprintf(MyFactionViewLang.sendInvitation, param1.inviteTimes);
            this._invitationNum = param1.inviteTimes;
            _view.alert.showYesNoMsg(_loc_2, MyFactionViewLang.Sure, MyFactionViewLang.Cancel, this.callJoinFaction);
            return;
        }// end function

        private function callJoinFaction(param1:uint) : void
        {
            var _loc_2:String = null;
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    _loc_2 = this._InvitationId + "_" + this._InvitationName + "_" + int((this._invitationNum + 1));
                    _view.chat.send_all(Mod_Chat_Base.FACTION_INVITE, _loc_2);
                    this._isInviation = true;
                    this._InvitationTime = _ctrl.player.serverTime;
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

        private function resultTime() : void
        {
            var _loc_1:* = _ctrl.player.serverTime;
            this._lostTime = _loc_1 - this._InvitationTime;
            this._isInviation = this._lostTime < 60;
            return;
        }// end function

        public function onQuitFaction(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.quit_faction();
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

        public function onDismissFaction(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.disband_faction();
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

        public function onKickoutFaction(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.kickout_member(this._kickoutMemberData.memberId);
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

        public function onTanHe(param1:uint) : void
        {
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    this.seize_the_throne();
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

        public function clear() : void
        {
            this._myFaction.clear();
            return;
        }// end function

        public function close() : void
        {
            this._showType = "member";
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

    }
}
