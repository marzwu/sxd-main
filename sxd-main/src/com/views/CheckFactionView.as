package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class CheckFactionView extends Base implements IView
    {
        private var _newMemberList:Array;
        private var _checkFaction:ICheckFaction;
        private var _seleteFaction:String = "";
        private var _seleteMaster:String = "";
        private var _listPageNum:int = 3;
        private var _listPage:int = 1;
        private var _applyStr:int = 0;
        private var _applyBool:Boolean = false;
        private var _isCheckOver:Boolean = true;
        private var _checkData:Object;

        public function CheckFactionView()
        {
            this._checkData = {};
            return;
        }// end function

        private function apply_faction(param1:int) : void
        {
            _data.call(Mod_Faction_Base.faction_request, this.applyFactionCallback, [param1]);
            return;
        }// end function

        public function member_list(param1:int) : void
        {
            _data.call(Mod_Faction_Base.member_list, this.memeberListCoinCallBack, [param1, ""]);
            return;
        }// end function

        private function applyFactionCallback() : void
        {
            var _loc_1:* = this._ctrl.faction.factionApply;
            if (_loc_1.msg == Mod_Faction_Base.ACTION_SUCCESS)
            {
            }
            else
            {
                this.renderMsg(_loc_1.msg);
            }
            return;
        }// end function

        private function memeberListCoinCallBack() : void
        {
            var _loc_1:Array = null;
            var _loc_2:Array = null;
            var _loc_3:Array = null;
            var _loc_4:Array = null;
            if (this.inStage == false)
            {
                loadAssets("CheckFaction", this.render, "查看帮派加载中");
            }
            else
            {
                this._isCheckOver = true;
                _loc_1 = this._ctrl.faction.memberList;
                _loc_2 = this.sortPosition(_loc_1, 1);
                _loc_3 = this.sortPosition(_loc_1, 2);
                _loc_4 = this.sortPosition(_loc_1, 0);
                _loc_2.sortOn("playerLevel", Array.NUMERIC | Array.DESCENDING);
                _loc_3.sortOn("playerLevel", Array.NUMERIC | Array.DESCENDING);
                _loc_4.sortOn("playerLevel", Array.NUMERIC | Array.DESCENDING);
                this._newMemberList = [];
                this.mergerList(_loc_2);
                this.mergerList(_loc_3);
                this.mergerList(_loc_4);
                this._checkFaction.getFactionPersonList = this._newMemberList;
            }
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
                case Mod_Faction_Base.NOT_FREE_PLAYER:
                {
                    _view.showTip(JoinFactionViewLang.NotFreePlayer);
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
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function show() : void
        {
            return;
        }// end function

        public function showCheckFaction(param1:int) : void
        {
            this.member_list(param1);
            return;
        }// end function

        public function render() : void
        {
            if (this._checkFaction == null)
            {
                this._checkFaction = _view.getAssetsObject("CheckFaction", "CheckFaction") as ICheckFaction;
                this._checkFaction.tip = _view.tip.iTip;
                this._checkFaction.drag = _view.drag.iDrag;
            }
            _popup.addView(this, this._checkFaction.content);
            _view.center(sign, this._checkFaction.content);
            this.memeberListCoinCallBack();
            this._checkFaction.joinFactionType = ActivityType.FactionLevel > 0;
            this._checkFaction.onApply = function (param1:int) : void
            {
                apply_faction(param1);
                return;
            }// end function
            ;
            this._checkFaction.onAddFriend = function (param1:Object) : void
            {
                if (param1.playerId == _ctrl.player.playerId)
                {
                    return;
                }
                _view.friendList.addFriend(param1.playerName);
                return;
            }// end function
            ;
            this._checkFaction.onSendMessige = function (param1:Object) : void
            {
                if (param1.playerId == _ctrl.player.playerId)
                {
                    return;
                }
                _view.friendChat.get_friendinfo_chatrecord_list(param1.playerId);
                return;
            }// end function
            ;
            this._checkFaction.onPersonCheck = function (param1:Object) : void
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
            this._checkFaction.onSendFlower = function (param1:Object) : void
            {
                _view.sendFlower.sendPlayerID = param1.playerId;
                _view.sendFlower.show();
                return;
            }// end function
            ;
            this._checkFaction.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            return;
        }// end function

        public function clear() : void
        {
            this._checkFaction.close();
            return;
        }// end function

        public function close() : void
        {
            this._isCheckOver = true;
            _popup.closeView(this);
            return;
        }// end function

    }
}
