package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.assist.view.pack.*;
    import com.assist.view.toolbar.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.text.*;

    public class OtherRoleMsgView extends Base implements IView
    {
        private var _playerName:String = "";
        private var _playerid:int = 0;
        private var _target:IRoleMsgSee;
        private var _boxlist:Array;
        private var _frameSprite:IFrameSprite;
        public var onAfterOpened:Function;
        private var _clickBox:BoxGrid;

        public function OtherRoleMsgView()
        {
            this._boxlist = [];
            return;
        }// end function

        public function show() : void
        {
            this.get_role_list(this._playerid);
            if (_view.immortalityMsg.inStage)
            {
                _view.immortalityMsg.close();
            }
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            if (_view.immortalityMsg.inStage)
            {
                _view.immortalityMsg.close();
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function init(param1:int, param2:String) : void
        {
            this._playerid = param1;
            this._playerName = param2;
            if (param2 == null)
            {
                this._playerName = "";
            }
            return;
        }// end function

        private function loadComplete() : void
        {
            var _loc_1:BoxGrid = null;
            var _loc_2:int = 0;
            var _loc_3:Array = null;
            var _loc_4:RoleInfo = null;
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("RoleMsgSee", "MCRoleMsgSee") as IRoleMsgSee;
                this._target.onClose = this.close;
                this._target.onLabel = this.nameLabelClick;
                this._target.onSeeRoleInfo = this.onSeeRoleInfo;
                this._target.onStrength = this.onStrength;
                this._target.onFlowers = this.onFlowers;
                this._target.onTip = this.onTip;
                this._frameSprite = MapStatic.mapInstance.frame;
                this._target.bodyCanvas.addChild(this._frameSprite.content);
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
                _loc_3 = this._target.boxList;
                _loc_2 = 0;
                while (_loc_2 < 6)
                {
                    
                    _loc_1 = new BoxGrid(BoxGrid.idRole + _loc_2, BoxGrid.typeRole, _loc_3[_loc_2]);
                    _loc_1.onClick = this.boxClick;
                    this._boxlist[_loc_1.id] = _loc_1;
                    _loc_2++;
                }
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            _loc_3 = _ctrl.rolemsg.otherRoleList;
            for each (_loc_4 in _loc_3)
            {
                
                _loc_4.showOtherStrength = _view.toolbar.isShowPlayerInfo;
                _loc_4.showOtherFlowers = FunctionType.isOpened(FunctionType.SendFlower);
                if (_loc_4.ismain)
                {
                    this._playerName = _loc_4.name;
                }
            }
            this._target.initHeroNameList(_loc_3);
            this.nameLabelClick();
            _view.addToFrameProcessList(String(this), this.enterFrameHandler);
            if (this.onAfterOpened is Function)
            {
                this.onAfterOpened();
            }
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2 = null) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (param2 == null || param2 == "")
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
            }
            return;
        }// end function

        private function boxClick(param1:BoxGrid) : void
        {
            if (param1.itemId == 0)
            {
                return;
            }
            this.showClickTip(param1, [OtherRoleMsgViewLang.Show]);
            return;
        }// end function

        private function showClickTip(param1:BoxGrid, param2:Array) : void
        {
            if (param2.length == 0)
            {
                return;
            }
            this._clickBox = param1;
            this._clickBox.lockLight = true;
            var _loc_3:* = new ClickTipList(param2, param2, this.onTextClick);
            _loc_3.onRemoveStage = this.tipRemoveStageHandler;
            _view.tip.iTip.clickToOpen(_loc_3);
            return;
        }// end function

        private function onTextClick(param1:String) : void
        {
            _view.chat.showMsg([ChatMsgType.Item, this._clickBox.itemId, this._clickBox.item.upgradeLevel, this._clickBox.playerItemId, this._clickBox.item.goldId, this._playerName]);
            return;
        }// end function

        private function tipRemoveStageHandler() : void
        {
            this._clickBox.lockLight = false;
            return;
        }// end function

        private function enterFrameHandler() : void
        {
            if (inStage == false)
            {
                _view.removeFromFrameProcessList(String(this));
                return;
            }
            this._frameSprite.pass(_view.time2);
            return;
        }// end function

        private function nameLabelClick() : void
        {
            this._target.updateRoleMsg();
            this._frameSprite.initUrl(this._target.selected.sign, "stand");
            this._frameSprite.dir = 1;
            this._frameSprite.petLv = this._target.selected.petLv;
            if (_ctrl.rolemsg.flowersTips != "")
            {
                _view.tip.iTip.addTarget(this._target.mcFlowers, _ctrl.rolemsg.flowersTips);
            }
            else
            {
                _view.tip.iTip.removeTarget(this._target.mcFlowers);
            }
            if (_view.roleDetailInfo.inStage)
            {
                this._view.roleDetailInfo.updateDetailInfo(this._target.selected.playerRoleId, this._target.selected.name);
            }
            this.dujie_info(this.playerRoleId);
            this.get_player_role_equip_list(this._target.selected.playerRoleId);
            this.get_role_fate_list();
            return;
        }// end function

        private function onSeeRoleInfo() : void
        {
            if (_view.roleDetailInfo.inStage)
            {
                this._view.roleDetailInfo.updateDetailInfo(this._target.selected.playerRoleId, this._target.selected.name);
            }
            else
            {
                this._view.roleDetailInfo.playerRoleId = this._target.selected.playerRoleId;
                this._view.roleDetailInfo.playerName = this._target.selected.name;
                this._view.roleDetailInfo.show();
            }
            return;
        }// end function

        public function get playerRoleId() : int
        {
            if (this._target == null || inStage == false)
            {
                return 0;
            }
            return this._target.selected.playerRoleId;
        }// end function

        public function onStrength() : void
        {
            this._view.playerCompare.myPlayerId = this._ctrl.player.playerId;
            this._view.playerCompare.myName = this._ctrl.player.nickname;
            this._view.playerCompare.anotherPlayerId = this._playerid;
            this._view.playerCompare.anotherName = this._playerName;
            this._view.playerCompare.switchSelf();
            return;
        }// end function

        private function onFlowers() : void
        {
            this._view.sendFlower.sendPlayerID = this._playerid;
            this._view.sendFlower.switchSelf();
            return;
        }// end function

        private function get_player_role_equip_list(param1:int) : void
        {
            _data.call(Mod_Item_Base.get_player_role_equip_list, this.get_player_role_equip_list_back, [param1]);
            return;
        }// end function

        private function get_player_role_equip_list_back() : void
        {
            var _loc_2:BoxGrid = null;
            if (inStage == false)
            {
                return;
            }
            var _loc_1:* = _ctrl.item.gridsRoleOther;
            for each (_loc_2 in this._boxlist)
            {
                
                _loc_2.item = _loc_1[_loc_2.id];
            }
            return;
        }// end function

        private function get_role_list(param1:int) : void
        {
            _data.call(Mod_Role_Base.get_role_list, this.get_role_list_back, [param1]);
            return;
        }// end function

        private function get_role_list_back() : void
        {
            loadAssets("RoleMsgSee", null, OtherRoleMsgViewLang.LoadTip, false, false, this.loadComplete);
            return;
        }// end function

        private function get_role_fate_list() : void
        {
            _data.call(Mod_Fate_Base.get_role_fate_list, this.get_role_fate_list_back, [this.playerRoleId]);
            return;
        }// end function

        private function get_role_fate_list_back() : void
        {
            var _loc_4:Object = null;
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:String = null;
            var _loc_10:int = 0;
            var _loc_11:TextField = null;
            var _loc_1:String = "";
            var _loc_2:* = _ctrl.fate.roleFateData.fateList;
            var _loc_3:Array = [];
            for each (_loc_4 in _loc_2)
            {
                
                if (_loc_4.isEmpty == false)
                {
                    if (_loc_4.quality == 8)
                    {
                        _loc_5 = HtmlText.format("\n" + _loc_4.fateName + " Lv." + _loc_4.fateLevel + " ", _loc_4.color);
                        _loc_6 = _loc_4.activedFateList.length;
                        if (_loc_6 == 0)
                        {
                            continue;
                        }
                        _loc_7 = 0;
                        while (_loc_7 < _loc_6)
                        {
                            
                            _loc_8 = _loc_4.activedFateList[_loc_7];
                            _loc_9 = _loc_7 > 0 ? (FateViewLang.And) : ("");
                            _loc_10 = _ctrl.fate.renderAddValue(_loc_4, _loc_8);
                            _loc_5 = _loc_5 + HtmlText.format(_loc_9 + _ctrl.fate.renderFateAddValue(_loc_8, _loc_4.fateId, _loc_4.fateLevel, _loc_10), 16737792);
                            _loc_7++;
                        }
                        _loc_3.push({p:_loc_4.quality * 1000 + _loc_4.fateLevel, s:_loc_5});
                        continue;
                    }
                    _loc_1 = "\n" + HtmlText.format(_loc_4.fateName + "  Lv." + _loc_4.fateLevel, _loc_4.color) + "  " + HtmlText.format(_loc_4.info + _loc_4.addValue, 16737792);
                    _loc_3.push({p:_loc_4.quality * 1000 + _loc_4.fateLevel, s:_loc_1});
                }
            }
            _loc_3.sortOn("p", Array.NUMERIC | Array.DESCENDING);
            _loc_1 = "";
            for each (_loc_4 in _loc_3)
            {
                
                _loc_1 = _loc_1 + _loc_4.s;
            }
            if (_loc_1 == "")
            {
                this._target.mcFate.visible = false;
                _view.tip.iTip.removeTarget(this._target.mcFate);
            }
            else
            {
                _loc_1 = "<b><font size=\"14\" color=\"#ffffff\">" + OtherRoleMsgViewLang.Fate + _ctrl.fate.roleFateData.fatePower + "</font></b>" + _loc_1;
                _loc_1 = "<textformat leading=\'6\'>" + _loc_1 + "</textformat>";
                _loc_11 = new TextField();
                _loc_11.autoSize = TextFieldAutoSize.LEFT;
                _loc_11.htmlText = _loc_1;
                _loc_11.width = _loc_11.textWidth + 5;
                _loc_11.height = _loc_11.textHeight + 5;
                _view.tip.iTip.addTarget(this._target.mcFate, _loc_11);
                this._target.mcFateText.text = _ctrl.fate.roleFateData.fatePower + "";
                this._target.mcFate.visible = true;
            }
            return;
        }// end function

        private function dujie_info(param1:int) : void
        {
            this._target.tfDuJie.text = "";
            _data.call(Mod_Dujie_Base.dujie_info, this.dujie_info_back, [param1]);
            return;
        }// end function

        private function dujie_info_back() : void
        {
            if (_ctrl.dujie.playerRoleId == this.playerRoleId)
            {
                this._target.tfDuJie.htmlText = _ctrl.dujie.dujieName;
            }
            return;
        }// end function

    }
}
