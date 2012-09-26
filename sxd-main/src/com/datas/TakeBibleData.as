package com.datas
{
    import com.assist.server.*;
    import com.haloer.data.*;
    import com.protocols.*;

    public class TakeBibleData extends Base
    {
        private var _openTakeBible:Array;
        private var _closeTakeBible:Array;
        private var _getTakeBibleInfo:Array;
        private var _applyFriend:Array;
        private var _cancelApplyFriend:Array;
        private var _approveApply:Array;
        private var _rejectApply:Array;
        private var _buyProtection:Array;
        private var _refresh:Array;
        private var _playerTakeBible:Array;
        private var _startTakeBible:Array;
        private var _rob:Array;
        private var _notify:Array;
        private var _notifyGlobal:Array;
        private var _quickly:Array;
        private var _takeBibleUpdataData:Array;
        private var _takeBibleCdTime:Array;
        private var _clearTakeBibleCdTime:Array;
        public var buyBless:Array;
        public var callRuLai:Array;
        private var _openCallRuLai:Array;
        public var callList:Array;
        private var _notifyCallRuLai:Array;
        public var getRulaiOpenTime:Array;
        public var canRobTimes:int = 0;
        public var canProtectTimes:int = 0;
        public var canTakeBibleTimes:int = 0;
        public var quicklyTimes:int = 0;

        public function TakeBibleData()
        {
            this._playerTakeBible = [];
            this.buyBless = [];
            this.callRuLai = [];
            return;
        }// end function

        public function get openTakeBible() : Array
        {
            return this._openTakeBible;
        }// end function

        public function get closeTakeBible() : Array
        {
            return this._closeTakeBible;
        }// end function

        public function get getTakeBibleInfo() : Array
        {
            return this._getTakeBibleInfo;
        }// end function

        public function get applyFriend() : Array
        {
            return this._applyFriend;
        }// end function

        public function get cancelApplyFriend() : Array
        {
            return this._cancelApplyFriend;
        }// end function

        public function get approveApply() : Array
        {
            return this._approveApply;
        }// end function

        public function get rejectApply() : Array
        {
            return this._rejectApply;
        }// end function

        public function get buyProtection() : Array
        {
            return this._buyProtection;
        }// end function

        public function get refreshData() : Array
        {
            return this._refresh;
        }// end function

        public function get playerTakeBible() : Array
        {
            return this._playerTakeBible;
        }// end function

        public function get startTakeBible() : Array
        {
            return this._startTakeBible;
        }// end function

        public function get robData() : Array
        {
            return this._rob;
        }// end function

        public function get notifyData() : Array
        {
            return this._notify;
        }// end function

        public function get notifyGlobal() : Array
        {
            return this._notifyGlobal;
        }// end function

        public function get quicklyData() : Array
        {
            return this._quickly;
        }// end function

        public function get takeBibleUpdataData() : Array
        {
            return this._takeBibleUpdataData;
        }// end function

        public function get takeBibleCdTime() : Array
        {
            return this._takeBibleCdTime;
        }// end function

        public function get clearTakeBibleCdTime() : Array
        {
            return this._clearTakeBibleCdTime;
        }// end function

        public function get openCallRuLai() : Array
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            var _loc_1:Array = [];
            this.callList = [];
            var _loc_2:int = -1;
            for each (_loc_3 in this._openCallRuLai[0])
            {
                
                _loc_2++;
                _loc_6 = {};
                oObject.list(_loc_3, _loc_6, ["player_id", "nickname", "role_id", "suit_id"]);
                _loc_6["playerSign"] = RoleType.getRoleSign(_loc_6.role_id);
                _loc_6["sign"] = _loc_6.playerSign + ItemType.getItemSuffix(_loc_6.suit_id);
                _loc_1.push(_loc_6);
                this.callList.push(_loc_6);
            }
            _loc_4 = this.callList.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                this.callList[_loc_5]["isZhaoHuan"] = this.checkZhaoHuan(_loc_5, this.callList);
                _loc_5++;
            }
            return _loc_1;
        }// end function

        private function checkZhaoHuan(param1:int, param2:Array) : int
        {
            if (param1 == 0)
            {
                return Mod_TakeBible_Base.CT_SELF;
            }
            var _loc_3:* = this.callList.length - 1;
            var _loc_4:* = Math.min(param1, _loc_3);
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (param2[_loc_5]["player_id"] == param2[_loc_4]["player_id"])
                {
                    return Mod_TakeBible_Base.CT_HELPER;
                }
                _loc_5++;
            }
            return Mod_TakeBible_Base.CT_SELF;
        }// end function

        public function get notifyCallRuLaiType() : int
        {
            return this._notifyCallRuLai[0];
        }// end function

        public function get notifyCallRuLai() : Array
        {
            return this.callList;
        }// end function

        public function open_take_bible(param1:Array) : void
        {
            this._openTakeBible = param1;
            return;
        }// end function

        public function close_take_bible(param1:Array) : void
        {
            this._closeTakeBible = param1;
            return;
        }// end function

        public function get_take_bible_info(param1:Array) : void
        {
            this._getTakeBibleInfo = param1;
            return;
        }// end function

        public function apply_friend(param1:Array) : void
        {
            this._applyFriend = param1;
            return;
        }// end function

        public function cancel_apply_friend(param1:Array) : void
        {
            this._cancelApplyFriend = param1;
            return;
        }// end function

        public function approve_apply(param1:Array) : void
        {
            this._approveApply = param1;
            return;
        }// end function

        public function reject_apply(param1:Array) : void
        {
            this._rejectApply = param1;
            return;
        }// end function

        public function buy_protection(param1:Array) : void
        {
            this._buyProtection = param1;
            return;
        }// end function

        public function refresh(param1:Array) : void
        {
            this._refresh = param1;
            return;
        }// end function

        public function get_player_take_bible(param1:Array) : void
        {
            this.savePlyareTakBible(param1);
            return;
        }// end function

        private function savePlyareTakBible(param1:Array) : void
        {
            var _loc_2:* = this._playerTakeBible.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._playerTakeBible[_loc_3][0] == param1[0])
                {
                    this._playerTakeBible[_loc_3] = param1;
                    return;
                }
                _loc_3++;
            }
            this._playerTakeBible.push(param1);
            return;
        }// end function

        public function start_take_bible(param1:Array) : void
        {
            this._startTakeBible = param1;
            return;
        }// end function

        public function rob(param1:Array) : void
        {
            this._rob = param1;
            return;
        }// end function

        public function notify(param1:Array) : void
        {
            this._notify = param1;
            return;
        }// end function

        public function notify_global(param1:Array) : void
        {
            this._notifyGlobal = param1;
            return;
        }// end function

        public function quickly(param1:Array) : void
        {
            this._quickly = param1;
            return;
        }// end function

        public function get_take_bible_updata_data(param1:Array) : void
        {
            this._takeBibleUpdataData = param1;
            return;
        }// end function

        public function get_rob_take_bible_cd_time(param1:Array) : void
        {
            this._takeBibleCdTime = param1;
            return;
        }// end function

        public function clear_rob_take_bible_cd_time(param1:Array) : void
        {
            this._clearTakeBibleCdTime = param1;
            return;
        }// end function

        public function buy_bless(param1:Array) : void
        {
            this.buyBless = param1;
            return;
        }// end function

        public function call_rulai(param1:Array) : void
        {
            this.callRuLai = param1;
            return;
        }// end function

        public function get_rulai_open_time(param1:Array) : void
        {
            this.getRulaiOpenTime = param1;
            return;
        }// end function

        public function take_bible_info(param1:Array) : void
        {
            this.canRobTimes = param1[0];
            this.canProtectTimes = param1[1];
            this.canTakeBibleTimes = param1[2];
            this.quicklyTimes = param1[3];
            return;
        }// end function

        public function open_call_rulai(param1:Array) : void
        {
            this._openCallRuLai = param1;
            return;
        }// end function

        public function notify_call_rulai(param1:Array) : void
        {
            this._notifyCallRuLai = param1;
            var _loc_2:Object = {};
            oObject.list(this._notifyCallRuLai[1][0], _loc_2, ["index", "player_id", "nickname", "role_id", "suit_id"]);
            _loc_2["playerSign"] = RoleType.getRoleSign(_loc_2.role_id);
            _loc_2["sign"] = _loc_2.playerSign + ItemType.getItemSuffix(_loc_2.suit_id);
            this.callList.push(_loc_2);
            _loc_2["isZhaoHuan"] = this.checkZhaoHuan((this.callList.length - 1), this.callList);
            return;
        }// end function

    }
}
