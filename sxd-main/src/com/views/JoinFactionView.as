package com.views
{
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class JoinFactionView extends Base implements IView
    {
        private var _factionData:Object;
        private var _newMemberList:Array;
        private var _joinFaction:IJoinFaction;
        private var _seleteFaction:String = "";
        private var _seleteMaster:String = "";
        private var _listPageNum:int = 3;
        private var _listPage:int = 1;
        private var _applyStr:int = 0;
        private var _applyBool:Boolean = false;
        private var _isCheckOver:Boolean = true;
        private var _checkData:Object;
        private var _factionType:Boolean = false;

        public function JoinFactionView()
        {
            this._checkData = {};
            return;
        }// end function

        private function faction_List() : void
        {
            _data.call(Mod_Faction_Base.faction_list, this.factionListCallback, [this._seleteFaction, this._seleteMaster, this._applyStr, this._listPage]);
            return;
        }// end function

        private function create_faction(param1:String) : void
        {
            _data.call(Mod_Faction_Base.found_faction, this.createFactionCallback, [param1, ""]);
            return;
        }// end function

        public function apply_faction(param1:int) : void
        {
            _data.call(Mod_Faction_Base.faction_request, this.applyFactionCallback, [param1]);
            return;
        }// end function

        private function cancel_apply(param1:int) : void
        {
            _data.call(Mod_Faction_Base.cancel_request, this.cancelApplyCallback, [param1]);
            return;
        }// end function

        public function found_faction_coin() : void
        {
            _data.call(Mod_Faction_Base.found_faction_coin, this.foundFactionCoinCallBack, []);
            return;
        }// end function

        public function member_list(param1:int) : void
        {
            _data.call(Mod_Faction_Base.member_list, this.memeberListCoinCallBack, [param1, ""]);
            return;
        }// end function

        private function factionListCallback() : void
        {
            this._factionData = this._ctrl.faction.factionList;
            this._listPageNum = this._factionData.allPage;
            this._listPage = this._factionData.page;
            if (this.inStage)
            {
                this.joinFactionInfo(this._factionData.list);
            }
            else
            {
                loadAssets("JoinFaction", this.render, JoinFactionViewLang.LoadAssets);
            }
            return;
        }// end function

        private function createFactionCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.createFaction;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                _view.showTip(JoinFactionViewLang.CreateFactionSuccess, null, TipType.Success);
                _view.myFaction.switchSelf();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function applyFactionCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.factionApply;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                if (this.inStage)
                {
                    this.faction_List();
                }
                else
                {
                    _view.showTip(JoinFactionViewLang.ShengQingSuccess, null, TipType.Success);
                    this._applyStr = 1;
                    this._applyBool = true;
                    this.show();
                }
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function cancelApplyCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.cancelApply;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
                this.faction_List();
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function foundFactionCoinCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.foundFactionCoin;
            this._joinFaction.foundFactionCoin = _loc_1.coin;
            return;
        }// end function

        private function memeberListCoinCallBack() : void
        {
            this._isCheckOver = true;
            var _loc_1:* = this._ctrl.faction.memberList;
            this._joinFaction.checkFactionData = this._checkData;
            var _loc_2:* = this.sortPosition(_loc_1, 1);
            var _loc_3:* = this.sortPosition(_loc_1, 2);
            var _loc_4:* = this.sortPosition(_loc_1, 0);
            _loc_2.sortOn("playerLevel", Array.NUMERIC | Array.DESCENDING);
            _loc_3.sortOn("playerLevel", Array.NUMERIC | Array.DESCENDING);
            _loc_4.sortOn("playerLevel", Array.NUMERIC | Array.DESCENDING);
            this._newMemberList = [];
            this.mergerList(_loc_2);
            this.mergerList(_loc_3);
            this.mergerList(_loc_4);
            this._joinFaction.getFactionPersonList = this._newMemberList;
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

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_Faction_Base.CAMP_ERR:
                {
                    _view.showTip(JoinFactionViewLang.CampErr);
                    break;
                }
                case Mod_Faction_Base.INSUFFICIENT_COIN:
                {
                    _view.showTip(JoinFactionViewLang.InsuffictentCoin);
                    break;
                }
                case Mod_Faction_Base.NOT_FREE_PLAYER:
                {
                    _view.showTip(JoinFactionViewLang.NotFreePlayer);
                    break;
                }
                case Mod_Faction_Base.FOUND_ONE_FACTION:
                {
                    _view.showTip(JoinFactionViewLang.FoundOneFaction);
                    break;
                }
                case Mod_Faction_Base.FACTION_NAME_EXISTED:
                {
                    _view.showTip(JoinFactionViewLang.FactionNameExisted);
                    break;
                }
                case Mod_Faction_Base.FACTION_NAME_INVALID:
                {
                    _view.showTip(JoinFactionViewLang.FactionNameInvalid);
                    break;
                }
                case Mod_Faction_Base.FACTION_DESC_INVALID:
                {
                    _view.showTip(JoinFactionViewLang.FactionDescInvalid);
                    break;
                }
                case Mod_Faction_Base.FACTION_NOT_EXIST:
                {
                    _view.showTip(JoinFactionViewLang.FactionNotExist);
                    break;
                }
                case Mod_Faction_Base.REQUEST_NUM_LIMIT:
                {
                    _view.showTip(JoinFactionViewLang.RequestNumLimit);
                    break;
                }
                case Mod_Faction_Base.REQUEST_NOT_EXIST:
                {
                    _view.showTip(JoinFactionViewLang.RequestNumLimit);
                    break;
                }
                case Mod_Faction_Base.FACTION_REQUESTING:
                {
                    _view.showTip(JoinFactionViewLang.RequestNumLimit);
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
            this.faction_List();
            return;
        }// end function

        public function render() : void
        {
            this._joinFaction = _view.getAssetsObject("JoinFaction", "JoinFaction") as IJoinFaction;
            _popup.addView(this, this._joinFaction.content);
            _view.center(sign, this._joinFaction.content);
            this.found_faction_coin();
            this._joinFaction.tip = _view.tip.iTip;
            this._joinFaction.drag = _view.drag.iDrag;
            this._joinFaction.joinFactionType = this._factionType;
            this.joinFactionInfo(this._factionData.list);
            this._joinFaction.onApply = function (param1:int) : void
            {
                apply_faction(param1);
                return;
            }// end function
            ;
            this._joinFaction.onRevok = function (param1:int) : void
            {
                cancel_apply(param1);
                return;
            }// end function
            ;
            this._joinFaction.onPage = function (param1:int) : void
            {
                _listPage = param1;
                _seleteFaction = "";
                _seleteMaster = "";
                faction_List();
                return;
            }// end function
            ;
            this._joinFaction.onAddFriend = function (param1:Object) : void
            {
                if (param1.playerId == _ctrl.player.playerId)
                {
                    return;
                }
                _view.friendList.addFriend(param1.playerName);
                return;
            }// end function
            ;
            this._joinFaction.onPk = function (param1:Object) : void
            {
                _view.pkWar.defenderPlayerId = param1.playerId;
                _view.pkWar.show();
                return;
            }// end function
            ;
            this._joinFaction.onSendMessige = function (param1:Object) : void
            {
                if (param1.playerId == _ctrl.player.playerId)
                {
                    return;
                }
                _view.friendChat.get_friendinfo_chatrecord_list(param1.playerId);
                return;
            }// end function
            ;
            this._joinFaction.onPersonCheck = function (param1:Object) : void
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
            this._joinFaction.onSelect = function (param1:String, param2:String) : void
            {
                _seleteFaction = param1;
                _seleteMaster = param2;
                if (param1 != "" && param2 != "")
                {
                    _seleteFaction = param1;
                    _seleteMaster = "";
                }
                faction_List();
                return;
            }// end function
            ;
            this._joinFaction.onCreate = function (param1:String, param2:String) : void
            {
                create_faction(param1);
                return;
            }// end function
            ;
            this._joinFaction.onApplyIng = function (param1:Boolean) : void
            {
                if (param1)
                {
                    _applyStr = 1;
                }
                else
                {
                    _applyStr = 0;
                }
                _applyBool = param1;
                _seleteFaction = "";
                _seleteMaster = "";
                faction_List();
                return;
            }// end function
            ;
            this._joinFaction.onCheckFaction = function (param1:Object) : void
            {
                if (_isCheckOver == false)
                {
                    return;
                }
                _isCheckOver = false;
                _checkData = param1;
                member_list(param1.id);
                return;
            }// end function
            ;
            this._joinFaction.onSendFlower = function (param1:Object) : void
            {
                _view.sendFlower.sendPlayerID = param1.playerId;
                _view.sendFlower.show();
                return;
            }// end function
            ;
            this._joinFaction.onClose = function (param1:Boolean) : void
            {
                if (param1)
                {
                    _view.myFaction.switchSelf();
                }
                else
                {
                    close();
                }
                return;
            }// end function
            ;
            return;
        }// end function

        private function joinFactionInfo(param1:Array) : void
        {
            this._joinFaction.factionData(param1, this._listPageNum, this._listPage, _ctrl.player.nickname, this._applyBool);
            return;
        }// end function

        public function set joinFactionType(param1:Boolean) : void
        {
            this._factionType = param1;
            return;
        }// end function

        public function clear() : void
        {
            this._isCheckOver = true;
            this._joinFaction.close();
            return;
        }// end function

        public function close() : void
        {
            this._seleteFaction = "";
            this._seleteMaster = "";
            this._factionType = false;
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

    }
}
