package com.datas
{

    public class FactionData extends Base
    {
        private var _factionList:Array;
        private var _createFaction:Array;
        private var _factionApply:Array;
        private var _cancelApply:Array;
        private var _memberList:Array;
        private var _applyList:Array;
        private var _acceptApply:Array;
        private var _denyApply:Array;
        private var _modifyInfo:Array;
        private var _modifyNotice:Array;
        private var _appointJob:Array;
        private var _dismissJob:Array;
        private var _kickoutMember:Array;
        private var _transfer:Array;
        private var _quitFaction:Array;
        private var _disbandFaction:Array;
        private var _myFactionInfo:Array;
        private var _foundFactionCoin:Array;
        private var _groupNumber:Array;
        private var _contributionList:Array;
        private var _godInfo:Array;
        private var _incense:Array;
        private var _blessingCount:Array;
        private var _joinSealSatan:Array;
        private var _sealSatanCallNpc:Array;
        private var _sealSatanJoinNotify:Array;
        private var _sealSatanCallFactionMember:Array;
        private var _sealSatanInfo:Array;
        private var _sealSatanAwardNotify:Array;
        private var _sealSatanMemberList:Array;
        private var _callEatInfo:Array;
        private var _callEat:Array;
        private var _callEatDetailedInfo:Array;
        private var _joinEat:Array;
        private var _isCanJoinActivity:Array;
        private var _factionMessage:Array;
        private var _cleanFactionRequest:Array;
        private var _getFactionLevel:Array;
        private var _factionMasterTracel:Array;
        private var _seizeTheThrone:Array;
        public var RollCakeReamain:Array;
        public var RollCakeInfo:Array;
        public var RollCake:Array;
        public var InviteInfo:Array;

        public function FactionData()
        {
            return;
        }// end function

        public function get factionList() : Array
        {
            return this._factionList;
        }// end function

        public function get createFaction() : Array
        {
            return this._createFaction;
        }// end function

        public function get factionApply() : Array
        {
            return this._factionApply;
        }// end function

        public function get cancelApply() : Array
        {
            return this._cancelApply;
        }// end function

        public function get memberList() : Array
        {
            return this._memberList;
        }// end function

        public function get applyList() : Array
        {
            return this._applyList;
        }// end function

        public function get acceptApply() : Array
        {
            return this._acceptApply;
        }// end function

        public function get denyApply() : Array
        {
            return this._denyApply;
        }// end function

        public function get modifyInfo() : Array
        {
            return this._modifyInfo;
        }// end function

        public function get modifyNotice() : Array
        {
            return this._modifyNotice;
        }// end function

        public function get appointJob() : Array
        {
            return this._appointJob;
        }// end function

        public function get dismissJob() : Array
        {
            return this._dismissJob;
        }// end function

        public function get kickoutMember() : Array
        {
            return this._kickoutMember;
        }// end function

        public function get transfer() : Array
        {
            return this._transfer;
        }// end function

        public function get quitFaction() : Array
        {
            return this._quitFaction;
        }// end function

        public function get disbandFaction() : Array
        {
            return this._disbandFaction;
        }// end function

        public function get myFactionInfo() : Array
        {
            return this._myFactionInfo;
        }// end function

        public function get foundFactionCoin() : Array
        {
            return this._foundFactionCoin;
        }// end function

        public function get groupNumber() : Array
        {
            return this._groupNumber;
        }// end function

        public function get contributionList() : Array
        {
            return this._contributionList;
        }// end function

        public function get godInfo() : Array
        {
            return this._godInfo;
        }// end function

        public function get factionIncense() : Array
        {
            return this._incense;
        }// end function

        public function get blessingCount() : Array
        {
            return this._blessingCount;
        }// end function

        public function get joinSealSatan() : Array
        {
            return this._joinSealSatan;
        }// end function

        public function get sealSatanCallNpc() : Array
        {
            return this._sealSatanCallNpc;
        }// end function

        public function get sealSatanJoinNotify() : Array
        {
            return this._sealSatanJoinNotify;
        }// end function

        public function get sealSatanCallFactionMember() : Array
        {
            return this._sealSatanCallFactionMember;
        }// end function

        public function get sealSatanInfo() : Array
        {
            return this._sealSatanInfo;
        }// end function

        public function get sealSatanAwardNotify() : Array
        {
            return this._sealSatanAwardNotify;
        }// end function

        public function get sealSatanMemberList() : Array
        {
            return this._sealSatanMemberList;
        }// end function

        public function get callEatInfo() : Array
        {
            return this._callEatInfo;
        }// end function

        public function get callEat() : Array
        {
            return this._callEat;
        }// end function

        public function get callEatDetailedInfo() : Array
        {
            return this._callEatDetailedInfo;
        }// end function

        public function get joinEat() : Array
        {
            return this._joinEat;
        }// end function

        public function get isCanJoinActivity() : Array
        {
            return this._isCanJoinActivity;
        }// end function

        public function get factionMessage() : Array
        {
            return this._factionMessage;
        }// end function

        public function get cleanFactionRequest() : Array
        {
            return this._cleanFactionRequest;
        }// end function

        public function get getFactionLevel() : Array
        {
            return this._getFactionLevel;
        }// end function

        public function get factionMasterTracel() : Array
        {
            return this._factionMasterTracel;
        }// end function

        public function get seizeTheThrone() : Array
        {
            return this._seizeTheThrone;
        }// end function

        public function faction_list(param1:Array) : void
        {
            this._factionList = param1;
            return;
        }// end function

        public function found_faction(param1:Array) : void
        {
            this._createFaction = param1;
            return;
        }// end function

        public function faction_request(param1:Array) : void
        {
            this._factionApply = param1;
            return;
        }// end function

        public function cancel_request(param1:Array) : void
        {
            this._cancelApply = param1;
            return;
        }// end function

        public function member_List(param1:Array) : void
        {
            this._memberList = param1[0];
            return;
        }// end function

        public function request_list(param1:Array) : void
        {
            this._applyList = param1[0];
            return;
        }// end function

        public function accept_request(param1:Array) : void
        {
            this._acceptApply = param1;
            return;
        }// end function

        public function deny_request(param1:Array) : void
        {
            this._denyApply = param1;
            return;
        }// end function

        public function modify_faction_desc(param1:Array) : void
        {
            this._modifyInfo = param1;
            return;
        }// end function

        public function modify_faction_notice(param1:Array) : void
        {
            this._modifyNotice = param1;
            return;
        }// end function

        public function appoint_job(param1:Array) : void
        {
            this._appointJob = param1;
            return;
        }// end function

        public function dismiss_job(param1:Array) : void
        {
            this._dismissJob = param1;
            return;
        }// end function

        public function kickout_member(param1:Array) : void
        {
            this._kickoutMember = param1;
            return;
        }// end function

        public function master_transfer(param1:Array) : void
        {
            this._transfer = param1;
            return;
        }// end function

        public function quit_faction(param1:Array) : void
        {
            this._quitFaction = param1;
            return;
        }// end function

        public function disband_faction(param1:Array) : void
        {
            this._disbandFaction = param1;
            return;
        }// end function

        public function my_faction_info(param1:Array) : void
        {
            this._myFactionInfo = param1;
            return;
        }// end function

        public function found_faction_coin(param1:Array) : void
        {
            this._foundFactionCoin = param1;
            return;
        }// end function

        public function modify_group_number(param1:Array) : void
        {
            this._groupNumber = param1;
            return;
        }// end function

        public function faction_contribution_list(param1:Array) : void
        {
            this._contributionList = param1[0];
            return;
        }// end function

        public function faction_god_info(param1:Array) : void
        {
            this._godInfo = param1;
            return;
        }// end function

        public function incense(param1:Array) : void
        {
            this._incense = param1;
            return;
        }// end function

        public function get_blessing_count(param1:Array) : void
        {
            this._blessingCount = param1;
            return;
        }// end function

        public function blessing_count_change(param1:Array) : void
        {
            return;
        }// end function

        public function faction_message_notify(param1:Array) : void
        {
            this._factionMessage = param1;
            return;
        }// end function

        public function join_seal_satan(param1:Array) : void
        {
            this._joinSealSatan = param1;
            return;
        }// end function

        public function seal_satan_call_npc(param1:Array) : void
        {
            this._sealSatanCallNpc = param1;
            return;
        }// end function

        public function seal_satan_join_notify(param1:Array) : void
        {
            this._sealSatanJoinNotify = param1;
            return;
        }// end function

        public function seal_satan_call_faction_member(param1:Array) : void
        {
            this._sealSatanCallFactionMember = param1;
            return;
        }// end function

        public function seal_satan_info(param1:Array) : void
        {
            this._sealSatanInfo = param1;
            return;
        }// end function

        public function seal_satan_award_notify(param1:Array) : void
        {
            this._sealSatanAwardNotify = param1;
            return;
        }// end function

        public function seal_satan_member_list(param1:Array) : void
        {
            this._sealSatanMemberList = param1;
            return;
        }// end function

        public function close_seal_satan(param1:Array) : void
        {
            return;
        }// end function

        public function call_eat_info(param1:Array) : void
        {
            this._callEatInfo = param1;
            return;
        }// end function

        public function call_eat(param1:Array) : void
        {
            this._callEat = param1;
            return;
        }// end function

        public function call_eat_detailed_info(param1:Array) : void
        {
            this._callEatDetailedInfo = param1;
            return;
        }// end function

        public function join_eat(param1:Array) : void
        {
            this._joinEat = param1;
            return;
        }// end function

        public function is_can_join_activity(param1:Array) : void
        {
            this._isCanJoinActivity = param1;
            return;
        }// end function

        public function clean_faction_request(param1:Array) : void
        {
            this._cleanFactionRequest = param1;
            return;
        }// end function

        public function get_faction_level(param1:Array) : void
        {
            this._getFactionLevel = param1;
            return;
        }// end function

        public function get_faction_master_trace(param1:Array) : void
        {
            this._factionMasterTracel = param1;
            return;
        }// end function

        public function seize_the_throne(param1:Array) : void
        {
            this._seizeTheThrone = param1;
            return;
        }// end function

        public function faction_roll_cake_remain_times(param1:Array) : void
        {
            this.RollCakeReamain = param1;
            return;
        }// end function

        public function faction_roll_cake_info(param1:Array) : void
        {
            this.RollCakeInfo = param1;
            return;
        }// end function

        public function roll_cake(param1:Array) : void
        {
            this.RollCake = param1;
            return;
        }// end function

        public function invite_info(param1:Array) : void
        {
            this.InviteInfo = param1;
            return;
        }// end function

    }
}
