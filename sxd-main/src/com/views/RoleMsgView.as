package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.guide.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.assist.view.pack.*;
    import com.assist.view.sound.*;
    import com.assist.view.toolbar.*;
    import com.controllers.*;
    import com.haloer.display.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;

    public class RoleMsgView extends Base implements IView
    {
        private var _target:IRoleMsg;
        private var _boxlist:Array;
        private var _boxTypeList:Array;
        private var _frameSprite:IFrameSprite;
        private var _autoEQ:Array;
        private var _tmpFollowRoleId:int = 0;
        private var _clickTime:int = 0;
        private var _clickBox:BoxGrid;
        private var _lockList:Array;
        private var _fireeId:int = 0;
        private var _dujieLei:Image;

        public function RoleMsgView()
        {
            this._boxlist = [];
            this._boxTypeList = [];
            this._autoEQ = [];
            this._lockList = [];
            return;
        }// end function

        public function show() : void
        {
            if (this.inStage)
            {
                return;
            }
            if (_view.luckyWheel.isMovie)
            {
                return;
            }
            if (_view.factionWarMap.isFactionWarStart == true)
            {
                return;
            }
            this.get_role_list();
            if (_view.pack.inStage == false)
            {
                _data.call(Mod_Item_Base.get_player_pack_item_list, null, [], false);
            }
            return;
        }// end function

        public function close() : void
        {
            _view.removeFromFrameProcessList(sign);
            _popup.closeView(this);
            BoxGrid.eqList = null;
            ItemInfo.roleJobId = 0;
            ItemInfo.roleLv = 0;
            _view.pack.changeRole(false);
            if (_view.training.inStage)
            {
                _view.training.close();
            }
            if (_view.immortalityMsg.inStage)
            {
                _view.immortalityMsg.close();
            }
            this._view.guide.closeRoleMsgGuides();
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function get item() : ItemController
        {
            return _ctrl.item;
        }// end function

        private function get rolemsg() : RoleMsgController
        {
            return _ctrl.rolemsg;
        }// end function

        private function get player() : PlayerController
        {
            return _ctrl.player;
        }// end function

        public function get playerRoleId() : int
        {
            if (this._target == null)
            {
                return 0;
            }
            return this._target.selected.playerRoleId;
        }// end function

        public function get roleJobId() : int
        {
            if (this._target == null)
            {
                return 0;
            }
            return this._target.selected.jobId;
        }// end function

        public function get roleName() : String
        {
            if (this._target == null)
            {
                return "";
            }
            return this._target.selected.name;
        }// end function

        public function get roleLv() : int
        {
            if (this._target == null)
            {
                return 0;
            }
            return this._target.selected.lv;
        }// end function

        public function get content() : Sprite
        {
            return this._target.content;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._target && this._target.content.stage != null;
        }// end function

        private function loadComplete() : void
        {
            var _loc_1:BoxGrid = null;
            var _loc_2:int = 0;
            var _loc_3:Array = null;
            var _loc_4:Array = null;
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("RoleMsg", "MCRoleMsg") as IRoleMsg;
                this._target.onClose = this.close;
                this._target.onLabel = this.onLabel;
                this._target.onTraining = this.onTraining;
                this._target.onFire = this.onFire;
                this._target.onTip = this.onTip;
                this._target.onFate = this.onFate;
                this._target.onGenSui = this.onGenSui;
                this._target.onDanYao = this.onDanYao;
                this._target.onFlower = this.onFlower;
                this._target.onChuanCheng = this.onChuanCheng;
                this._target.onSeeRoleInfo = this.onSeeRoleInfo;
                this._target.onDuJie = this.onDuJie;
                this._target.onDuJieAdd = this.onDuJieAdd;
                this._target.onYaoQing = this.onYaoQing;
                this._target.onPetShow = this.onPetShow;
                this._frameSprite = MapStatic.mapInstance.frame;
                this._target.bodyCanvas.addChild(this._frameSprite.content);
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
                _loc_4 = [RoleMsgViewLang.TouKui, RoleMsgViewLang.WuQi, RoleMsgViewLang.HunQi, RoleMsgViewLang.YiFu, RoleMsgViewLang.HuFu, RoleMsgViewLang.XieZi];
                _loc_3 = this._target.boxList;
                _loc_2 = 0;
                while (_loc_2 < 6)
                {
                    
                    _loc_1 = new BoxGrid(BoxGrid.idRole + _loc_2, BoxGrid.typeRole, _loc_3[_loc_2]);
                    _loc_1.onClick = this.boxClick;
                    _loc_1.onDoubleClick = this.boxDoubleClick;
                    _loc_1.onDrag = this.boxDrag;
                    _loc_1.onDragView = this.boxDragView;
                    _loc_1.can = [(_loc_2 + 1)];
                    _loc_1.defaultTips = _loc_4[_loc_2];
                    _loc_1.onEqUpdate = this.onEqUpdate;
                    _loc_1.onGoldUpdate = this.onGoldUpdate;
                    _view.tip.iTip.com.assist.view.interfaces:ITip::addTarget(_loc_1.btnUpdate, RoleMsgViewLang.UpdateEQ);
                    _view.tip.iTip.com.assist.view.interfaces:ITip::addTarget(_loc_1.btnGold, RoleMsgViewLang.UpdateGold);
                    this._boxlist[_loc_1.id] = _loc_1;
                    this._boxTypeList[(_loc_2 + 1)] = _loc_1;
                    _loc_2++;
                }
            }
            if (this.inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            this._target.initHeroNameList(this.rolemsg.roleList);
            this.onLabel();
            _view.addToFrameProcessList(String(this), this.enterFrameHandler);
            this._view.guide.trackTraining(2, this._target.content, this._target.btnTraining.x + 10, this._target.btnTraining.y + 8);
            this.now_and_next_Recommend_role_list();
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

        private function enterFrameHandler() : void
        {
            if (this.inStage == false)
            {
                _view.removeFromFrameProcessList(String(this));
                return;
            }
            this._frameSprite.pass(_view.time2);
            return;
        }// end function

        private function onLabel() : void
        {
            this._target.updateRoleMsg();
            this._frameSprite.initUrl(this._target.selected.sign, "stand");
            this._frameSprite.dir = 1;
            this._frameSprite.petLv = this._target.selected.petLv;
            switch(this._target.selected.sign)
            {
                case RoleType.SaFeiLuoSi:
                case RoleType.HeiYiFeiYu:
                {
                    this._frameSprite.content.y = 28;
                    break;
                }
                case RoleType.HeBo:
                {
                    this._frameSprite.content.y = 20;
                    break;
                }
                default:
                {
                    this._frameSprite.content.y = 0;
                    break;
                    break;
                }
            }
            if (_view.training.inStage)
            {
                _view.training.roleInfo = this._target.selected;
                _view.training.show();
            }
            if (_view.immortalityMsg.inStage)
            {
                _view.immortalityMsg.playerRoleId = this.playerRoleId;
                _view.immortalityMsg.roleName = this.roleName;
                _view.immortalityMsg.roleLv = this.roleLv;
                _view.immortalityMsg.show();
            }
            if (_view.roleDetailInfo.inStage)
            {
                this._view.roleDetailInfo.updateDetailInfo(this.playerRoleId, this.roleName);
            }
            if (_view.dujie.inStage)
            {
                _view.dujie.close();
            }
            BoxGrid.eqList = this._boxTypeList;
            ItemInfo.playerlv = this.player.level;
            ItemInfo.roleLv = this.roleLv;
            ItemInfo.roleJobId = this.roleJobId;
            this.updateDuJie();
            this.updateEquipList();
            this.updateFate();
            this._view.guide.setPoint(GuideType.Training, this._target.btnTraining.x + 10, this._target.btnTraining.y + 8);
            return;
        }// end function

        private function onFate() : void
        {
            if (_view.fate.inStage == false)
            {
                _view.fate.showRoleId = this.playerRoleId;
                _view.fate.show();
            }
            return;
        }// end function

        private function onTraining() : void
        {
            if (_view.training.inStage)
            {
                _view.training.close();
            }
            else
            {
                _view.training.roleInfo = this._target.selected;
                _view.training.show();
            }
            return;
        }// end function

        private function onFire() : void
        {
            _view.alert.showYesNoMsg(Lang.sprintf(RoleMsgViewLang.Leave, this.roleName), RoleMsgViewLang.Yes, RoleMsgViewLang.No, function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    down_partners();
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function onFlower() : void
        {
            this._view.myFlowerRecord.switchSelf();
            return;
        }// end function

        private function onChuanCheng() : void
        {
            this._view.inherit.playerRoleId = this.playerRoleId;
            this._view.inherit.show();
            return;
        }// end function

        private function onSeeRoleInfo() : void
        {
            if (_view.roleDetailInfo.inStage)
            {
                this._view.roleDetailInfo.updateDetailInfo(this.playerRoleId, this.roleName);
            }
            else
            {
                this._view.roleDetailInfo.playerRoleId = this.playerRoleId;
                this._view.roleDetailInfo.playerName = this.roleName;
                this._view.roleDetailInfo.show();
            }
            return;
        }// end function

        private function onDanYao() : void
        {
            if (_view.immortalityMsg.inStage)
            {
                _view.immortalityMsg.close();
            }
            else
            {
                _view.immortalityMsg.playerRoleId = this.playerRoleId;
                _view.immortalityMsg.roleName = this.roleName;
                _view.immortalityMsg.roleLv = this.roleLv;
                _view.immortalityMsg.show();
            }
            if (_view.otherRoleMsg.inStage)
            {
                _view.otherRoleMsg.close();
            }
            return;
        }// end function

        private function onGenSui() : void
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
            var _loc_1:* = this._target.selected;
            var _loc_3:* = _loc_1.isFollow ? (0) : (_loc_1.roleId);
            this.player.playerInfo.followRoleId = _loc_1.isFollow ? (0) : (_loc_1.roleId);
            var _loc_2:* = _loc_3;
            this._target.updateRoleMsg();
            this.player.playerInfo.followRoleId = 0;
            _view.missionMap.showFollow(this.player.playerId, _loc_2);
            this._tmpFollowRoleId = _loc_2;
            _data.call(Mod_Role_Base.set_follow_role, this.onGenSuiBack, [_loc_2 == 0 ? (0) : (_loc_1.playerRoleId)]);
            return;
        }// end function

        private function onGenSuiBack() : void
        {
            this.player.playerInfo.followRoleId = this._tmpFollowRoleId;
            return;
        }// end function

        private function onEqUpdate(param1:BoxGrid) : void
        {
            this._clickTime = getTimer() + 500;
            var _loc_2:* = this.item.hasReelList[param1.itemId];
            _view.refine.initdata(_loc_2.item_id, _loc_2.player_item_id, param1.item.goldId, param1.item.playerItemId, this.playerRoleId);
            _view.refine.show();
            return;
        }// end function

        private function onGoldUpdate(param1:BoxGrid) : void
        {
            this._clickTime = getTimer() + 500;
            var _loc_2:* = this.item.hasGoldList[param1.item.goldId];
            _view.armsGold.selectPlayerItemId = param1.playerItemId;
            _view.armsGold.goldId = _loc_2.item_id;
            _view.armsGold.playerItemId = _loc_2.player_item_id;
            _view.armsGold.show();
            return;
        }// end function

        private function boxClick(param1:BoxGrid) : void
        {
            if (this._clickTime > getTimer())
            {
                return;
            }
            if (param1.itemId != 0)
            {
                this.showClickTip(param1, [RoleMsgViewLang.Show, RoleMsgViewLang.Unload]);
            }
            else if (this._autoEQ[param1.id] != 0)
            {
                _view.pack.autoEQAtPlayerItemId(this._autoEQ[param1.id], this.playerRoleId);
            }
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
            this._lockList.push(this._clickBox);
            var _loc_3:* = new ClickTipList(param2, param2, this.onTextClick);
            _loc_3.onRemoveStage = this.releaseLock;
            _view.tip.iTip.clickToOpen(_loc_3);
            return;
        }// end function

        private function onTextClick(param1:String) : void
        {
            if (param1 == RoleMsgViewLang.Unload)
            {
                this.boxDoubleClick(this._clickBox);
            }
            else if (param1 == RoleMsgViewLang.Show)
            {
                _view.chat.showMsg([ChatMsgType.Item, this._clickBox.itemId, this._clickBox.item.upgradeLevel, this._clickBox.playerItemId, this._clickBox.item.goldId, this.player.nickname]);
            }
            return;
        }// end function

        private function boxDoubleClick(param1:BoxGrid) : void
        {
            this.remove_player_role_equipment(param1, null);
            if (_view.pack.inStage == false)
            {
                _view.pack.show();
            }
            return;
        }// end function

        private function boxDrag(param1:BoxGrid, param2:BoxGrid) : void
        {
            if (param2.isPackBox == false)
            {
                return;
            }
            this.remove_player_role_equipment(param1, param2);
            return;
        }// end function

        private function boxDragView(param1:BoxGrid, param2) : void
        {
            if (param2 === _view.pack.target)
            {
                this.remove_player_role_equipment(param1, null);
            }
            return;
        }// end function

        private function onDuJie() : void
        {
            var _loc_2:RoleInfo = null;
            var _loc_4:Object = null;
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
            var _loc_1:Array = [];
            var _loc_3:Object = {label:RoleMsgViewLang.SelectHelp, id:0, headUrl:"", lv:0};
            for each (_loc_2 in this.rolemsg.roleList)
            {
                
                if (_loc_2.playerRoleId != this.playerRoleId)
                {
                    _loc_4 = {id:_loc_2.playerRoleId, headUrl:_loc_2.headUrl, lv:_loc_2.lv};
                    _loc_4.label = Lang.sprintf(RoleMsgViewLang.LabelString, _loc_2.name, _loc_2.lv, RoleType.getJobName(_loc_2.jobId));
                    _loc_4.label = HtmlText.format(_loc_4.label, _loc_2.nameColor);
                    _loc_1.push(_loc_4);
                    if (_loc_3.lv < _loc_2.lv)
                    {
                        _loc_3 = _loc_4;
                    }
                }
            }
            _loc_2 = this._target.selected;
            _view.dujie.roleList = _loc_1;
            _view.dujie.defaultObj = _loc_3;
            _view.dujie.roleObj = {label:HtmlText.format(_loc_2.name, _loc_2.nameColor), id:_loc_2.playerRoleId, headUrl:_loc_2.headUrl};
            _view.dujie.show();
            return;
        }// end function

        private function onDuJieAdd() : void
        {
            this.add_player_role_state_point();
            return;
        }// end function

        private function onYaoQing() : void
        {
            _view.partnersNew.show();
            return;
        }// end function

        private function onPetShow() : void
        {
            _view.pet.show();
            return;
        }// end function

        private function updateGrids() : void
        {
            var _loc_2:BoxGrid = null;
            var _loc_3:ItemInfo = null;
            if (this.inStage == false)
            {
                return;
            }
            var _loc_1:* = this.item.gridsRole;
            for each (_loc_2 in this._boxlist)
            {
                
                _loc_2.item = _loc_1[_loc_2.id] as ItemInfo;
                this.updateEQBoxBtn(_loc_2);
                this._autoEQ[_loc_2.id] = 0;
                if (_loc_2.itemId == 0)
                {
                    _loc_3 = _view.pack.getBestEQ(_loc_2.can[0] || 0, this.roleLv, this.roleJobId);
                    if (_loc_3 != null)
                    {
                        this._autoEQ[_loc_2.id] = _loc_3.playerItemId;
                        _view.tip.iTip.addTarget(_loc_2.content, _loc_3.getTipsSprite1(HtmlText.format(RoleMsgViewLang.BestEQ, 8623050), HtmlText.format(RoleMsgViewLang.ClickEQ, 10066329)));
                    }
                }
            }
            if (this._target.selected.ismain)
            {
                _loc_2 = this._boxTypeList[ItemType.YiFu];
                if (!(this.player.playerInfo.signSuffix == "F0" || this.player.playerInfo.signSuffix == "F1"))
                {
                    this.player.playerInfo.signSuffix = ItemType.getItemSuffix(_loc_2.itemId);
                }
                _view.missionMap.change_equip_main();
            }
            return;
        }// end function

        private function updateEQBoxBtn(param1:BoxGrid) : void
        {
            var _loc_3:Boolean = false;
            param1.goldVisible = false;
            param1.eqUpdateVisible = _loc_3;
            var _loc_2:* = this.item.hasReelList[param1.itemId];
            if (_loc_2 != null && this.roleLv >= _loc_2.need_lv)
            {
                param1.eqUpdateVisible = true;
            }
            else
            {
                _loc_2 = this.item.hasGoldList[param1.item.goldId];
                if (_loc_2 != null && param1.item.basic.require >= _loc_2.require && param1.item.quality >= 4)
                {
                    param1.goldVisible = true;
                }
            }
            return;
        }// end function

        public function updateFate() : void
        {
            if (this.inStage == false || this._target == null)
            {
                return;
            }
            this.get_role_fate_list();
            return;
        }// end function

        public function updateEquipList() : void
        {
            if (this.inStage == false || this._target == null)
            {
                return;
            }
            this.player_reel_need_item();
            this.get_role_equip_list();
            this.get_role_list_simpe();
            return;
        }// end function

        public function updateDuJie() : void
        {
            if (this.inStage == false || this._target == null)
            {
                return;
            }
            this.dujie_info();
            return;
        }// end function

        public function updateSimpe() : void
        {
            if (this.inStage == false || this._target == null)
            {
                return;
            }
            this.get_role_list_simpe();
            return;
        }// end function

        public function equipLock(param1:int) : void
        {
            var _loc_2:* = ItemBasically.getBasic(param1);
            var _loc_3:* = this._boxTypeList[_loc_2.type_id];
            if (_loc_3 && _loc_2.jobArr[this.roleJobId] == 1)
            {
                _loc_3.lockLight = true;
                this._lockList.push(_loc_3);
            }
            return;
        }// end function

        public function releaseLock() : void
        {
            while (this._lockList.length)
            {
                
                (this._lockList.pop() as BoxGrid).lockLight = false;
            }
            return;
        }// end function

        private function get_role_list() : void
        {
            _data.call(Mod_Role_Base.get_role_list, this.get_role_list_back, [this.player.playerId], false);
            return;
        }// end function

        private function get_role_list_back() : void
        {
            loadAssets("RoleMsg", this.loadComplete, RoleMsgViewLang.LoadTip);
            return;
        }// end function

        private function get_role_equip_list() : void
        {
            _data.call(Mod_Item_Base.get_role_equip_list, this.get_role_equip_list_back, [this.playerRoleId]);
            return;
        }// end function

        private function get_role_equip_list_back() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this.updateGrids();
            _view.pack.changeRole(true);
            return;
        }// end function

        private function remove_player_role_equipment(param1:BoxGrid, param2:BoxGrid) : void
        {
            _data.call(Mod_Item_Base.remove_player_role_equipment, this.remove_player_role_equipment_back, [this.playerRoleId, param1.id, param2 == null ? (0) : (param2.id)]);
            this.item.pushRole(param1.id);
            param1.hideItem();
            return;
        }// end function

        private function remove_player_role_equipment_back() : void
        {
            this.updateGrids();
            if (this.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                this._view.toolbar.roleEquipChangeBack(this.playerRoleId);
                _view.pack.updateGrids();
                _view.pack.updateGridsTips();
                this.updateEquipList();
                SoundEffect.play(SoundEffect.Equip);
            }
            else if (this.item.result == Mod_Item_Base.UN_AVALIABLE_GRID)
            {
                _view.showTip(RoleMsgViewLang.PageFull);
            }
            else
            {
                _view.showTip(RoleMsgViewLang.UnloadFails);
            }
            return;
        }// end function

        private function down_partners() : void
        {
            this._fireeId = this.playerRoleId;
            _data.call(Mod_Role_Base.down_partners, this.down_partners_back, [this.playerRoleId]);
            return;
        }// end function

        private function down_partners_back() : void
        {
            var _loc_1:Array = null;
            var _loc_2:int = 0;
            var _loc_3:RoleInfo = null;
            if (this.rolemsg.result == Mod_Role_Base.SUCCEED)
            {
                this._view.toolbar.downPartnersBack(this.playerRoleId);
                _loc_1 = this.rolemsg.roleList;
                _loc_2 = 0;
                for each (_loc_3 in _loc_1)
                {
                    
                    if (_loc_3.playerRoleId == this._fireeId)
                    {
                        break;
                    }
                    _loc_2++;
                }
                if (_loc_3 != null)
                {
                    if (_loc_3.isFollow && !_view.beelzebubTrialsMap.inStageWithTip && !_view.nineRegionsMap.inStageWithTip && !_view.topWarMap.inStageWithTip)
                    {
                        this.player.playerInfo.followRoleId = 0;
                        _view.screen.currentMap.showFollow(this.player.playerId, 0);
                    }
                    _view.showTip(RoleMsgViewLang.UnloadSuccess, "", TipType.Success);
                    _loc_1.splice(_loc_2, 1);
                    this._target.initHeroNameList(_loc_1);
                    this.onLabel();
                    return;
                }
            }
            return;
        }// end function

        private function get_role_list_simpe() : void
        {
            _data.call(Mod_Role_Base.get_role_list_simpe, this.get_role_list_simpe_back, [this.playerRoleId]);
            return;
        }// end function

        private function get_role_list_simpe_back() : void
        {
            this._target.updateRoleMsg();
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
                _loc_1 = htmlFormat(RoleMsgViewLang.Fate + _ctrl.fate.roleFateData.fatePower, 14, 16777215) + _loc_1;
                _loc_1 = "<textformat leading=\'6\'>" + _loc_1 + "</textformat>";
                _loc_11 = new TextField();
                _loc_11.autoSize = TextFieldAutoSize.LEFT;
                _loc_11.htmlText = _loc_1;
                _loc_11.width = _loc_11.textWidth + 5;
                _loc_11.height = _loc_11.textHeight + 5;
                _view.tip.iTip.addTarget(this._target.mcFate, _loc_11);
                this._target.tfFate.text = _ctrl.fate.roleFateData.fatePower + "";
                this._target.mcFate.visible = true;
            }
            return;
        }// end function

        private function player_reel_need_item() : void
        {
            _data.call(Mod_Item_Base.player_reel_need_item, this.player_reel_need_item_back, []);
            return;
        }// end function

        private function player_reel_need_item_back() : void
        {
            var _loc_1:BoxGrid = null;
            if (this.inStage == false)
            {
                return;
            }
            for each (_loc_1 in this._boxTypeList)
            {
                
                this.updateEQBoxBtn(_loc_1);
            }
            return;
        }// end function

        private function dujie_info() : void
        {
            if (this._dujieLei && this._dujieLei.parent)
            {
                this._dujieLei.parent.removeChild(this._dujieLei);
            }
            if (_ctrl.dujie.playerRoleId != this.playerRoleId)
            {
                this._target.resetDuJie();
            }
            if (FunctionType.isOpened(FunctionType.DuJie) == false)
            {
                return;
            }
            _data.call(Mod_Dujie_Base.dujie_info, this.dujie_info_back, [this.playerRoleId]);
            return;
        }// end function

        private function dujie_info_back() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:String = null;
            var _loc_4:String = null;
            if (_ctrl.dujie.playerRoleId == this.playerRoleId)
            {
                _loc_1 = _ctrl.dujie.dujieState;
                _loc_2 = _ctrl.dujie.pointState;
                _loc_3 = _ctrl.dujie.dujieTip;
                _loc_4 = _ctrl.dujie.pointTip;
                if (_ctrl.dujie.playerRoleLv > this.roleLv)
                {
                    if (_loc_2 == 1)
                    {
                        _loc_2 = 2;
                    }
                    if (_loc_1 == 1)
                    {
                        _loc_1 = 2;
                    }
                    _loc_3 = HtmlText.red(RoleMsgViewLang.LvReq + _ctrl.dujie.playerRoleLv);
                    _loc_4 = HtmlText.red(RoleMsgViewLang.LvReq + _ctrl.dujie.playerRoleLv);
                }
                if ((_ctrl.dujie.nowStateLevel == 1 || _ctrl.dujie.nowStateLevel == 2) && _loc_1 == 1)
                {
                    _view.showTip(RoleMsgViewLang.StateSuccess, RoleMsgViewLang.Life + " +" + _ctrl.dujie.addLife, TipType.Success);
                    _data.call(Mod_Dujie_Base.go_dujie, this.go_dujie_back, [this.playerRoleId, 0, 0]);
                    _loc_1 = 0;
                }
                this._target.updateDuJie(_loc_1, _ctrl.dujie.dujieName, _loc_2);
                if (_loc_1 == 1)
                {
                    this._dujieLei = this._dujieLei || new Image(MapStatic.FolderEffects + "DuJieLei.swf");
                    this._dujieLei.x = -200;
                    this._dujieLei.y = -200;
                    this._target.bodyCanvas.addChild(this._dujieLei);
                    _loc_3 = RoleMsgViewLang.ClickDujie + _loc_3;
                }
                _view.tip.iTip.addTarget(this._target.btnDueJie, _loc_3);
                _view.tip.iTip.addTarget(this._target.btnPoint, _loc_4);
            }
            return;
        }// end function

        private function go_dujie_back() : void
        {
            this.dujie_info();
            this.get_role_list_simpe();
            return;
        }// end function

        private function add_player_role_state_point() : void
        {
            _data.call(Mod_Dujie_Base.add_player_role_state_point, this.add_player_role_state_point_back, [this.playerRoleId]);
            return;
        }// end function

        private function add_player_role_state_point_back() : void
        {
            if (_ctrl.dujie.result == Mod_Dujie_Base.SUCCESS)
            {
                this.dujie_info();
            }
            else if (_ctrl.dujie.result == Mod_Dujie_Base.ENOUGTH_PLAYER_ROLE_STATE_POINT)
            {
                _view.showTip(RoleMsgViewLang.StateFails);
            }
            else if (_ctrl.dujie.result == Mod_Dujie_Base.NOT_ENOGUTH_PLAYER_STATE_POINT)
            {
                _view.showTip(RoleMsgViewLang.StateLack);
            }
            return;
        }// end function

        private function now_and_next_Recommend_role_list() : void
        {
            _data.call(Mod_Partners_Base.now_and_next_Recommend_role_list, this.now_and_next_Recommend_role_list_back, []);
            return;
        }// end function

        private function now_and_next_Recommend_role_list_back() : void
        {
            var _loc_1:* = _ctrl.partners.recommend;
            if (_loc_1 == "")
            {
                _view.tip.iTip.removeTarget(this._target.tfFame);
            }
            else
            {
                _view.tip.iTip.addTarget(this._target.tfFame, _ctrl.partners.recommend);
            }
            return;
        }// end function

    }
}
