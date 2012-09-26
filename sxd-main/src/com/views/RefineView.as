package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.pack.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class RefineView extends Base implements IView
    {
        private var _target:IRefine;
        public var reelItemId:int;
        public var reelPlayerItemId:int;
        public var eqGoldId:int;
        public var eqPlayerItemId:int;
        private var eqPlayerRoleId:int;
        private var outItem:ItemInfo;
        private var cookieId:int = 0;
        private var isAuto:Boolean = false;
        private var materialList:Array;
        private var reelIngot:int = 0;
        private var reelMaterialEnough:Boolean = false;

        public function RefineView()
        {
            this.materialList = [];
            return;
        }// end function

        public function initdata(param1:int, param2:int, param3:int, param4:int, param5:int = -1) : void
        {
            this.reelItemId = param1;
            this.reelPlayerItemId = param2;
            this.eqGoldId = param3;
            this.eqPlayerItemId = param4;
            this.eqPlayerRoleId = param5;
            return;
        }// end function

        public function close() : void
        {
            var _loc_1:int = 0;
            this.eqPlayerItemId = 0;
            var _loc_1:* = _loc_1;
            this.eqGoldId = _loc_1;
            var _loc_1:* = _loc_1;
            this.reelPlayerItemId = _loc_1;
            this.reelItemId = _loc_1;
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function show() : void
        {
            this.isAuto = false;
            this.get_facture_reel_data(this.reelItemId);
            return;
        }// end function

        public function autoMerge() : void
        {
            this.isAuto = true;
            this.get_facture_reel_data(this.reelItemId);
            return;
        }// end function

        private function loadComplete() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("Refine", "MCRefine") as IRefine;
                this._target.onClose = this.close;
                this._target.onLianZhi = this.onLianZhi;
                this._target.onAutoMission = this.onAutoMission;
                this._target.onTip = this.onTip;
                this._target.updateItemLv = this.updateItemLv;
                this._target.onSetCookie(this.onSetCookie);
                this._target.onGetCookie(this.onGetCookie);
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            var _loc_1:* = this.reelIngot > 0 ? (Lang.sprintf(RefineViewLang.SpendIngot, HtmlText.yellow2(this.reelIngot + ""))) : ("");
            this._target.initList(this.materialList, _loc_1);
            this._target.itemUrl = this.outItem.iconUrl;
            this._target.itemMsg = this.outItem.easyMsg;
            this._target.itemNum = this.outItem.num;
            if (this.outItem.basic.type_id == ItemType.LianDanJuanZhou)
            {
                this._target.showLianDan();
            }
            else if (this.outItem.basic.type_id == ItemType.LianQiJuanZhou)
            {
                this._target.showLianZhi();
            }
            var _loc_2:* = ItemType.getRequireLevel(this.outItem.basic.item_id);
            this._target.itemLv = _loc_2 >= 100;
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (param2 == "" || param2 == null)
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
            }
            return;
        }// end function

        private function updateItemLv(param1:Boolean) : void
        {
            var _loc_4:int = 0;
            var _loc_2:* = _ctrl.item.reelData;
            if (this.eqPlayerItemId != 0)
            {
                _loc_2[6] = this.eqPlayerItemId;
                _loc_2[7] = this.eqGoldId;
            }
            var _loc_3:* = new ItemInfo();
            if (param1)
            {
                _loc_3.parseSee(_loc_2[1], _loc_2[2], _loc_2[7]);
            }
            else
            {
                _loc_4 = 1;
                if (_loc_2[2] > 5)
                {
                    _loc_4 = _loc_2[2] - 5;
                }
                _loc_3.parseSee(_loc_2[1], _loc_4, _loc_2[7]);
            }
            this._target.itemMsg = _loc_3.easyMsg;
            _view.tip.iTip.addTarget(this._target.itemBox, _loc_3.getTipsSprite1("", ""));
            return;
        }// end function

        private function parseData(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            var _loc_5:ItemBasically = null;
            this.reelIngot = param1[5];
            if (this.eqPlayerItemId != 0)
            {
                param1[6] = this.eqPlayerItemId;
                param1[7] = this.eqGoldId;
            }
            this.outItem = new ItemInfo();
            this.outItem.parseSee(param1[1], param1[2], param1[7]);
            this.outItem.num = param1[3];
            this.outItem.playerItemId = param1[6];
            var _loc_2:* = param1[7];
            this.materialList = [];
            this.reelMaterialEnough = true;
            for each (_loc_3 in param1[4])
            {
                
                _loc_4 = {};
                _loc_5 = ItemBasically.getBasic(_loc_3[0]);
                _loc_4.max = _loc_3[1];
                _loc_4.num = _loc_3[4];
                _loc_4.itemid = _loc_5.item_id;
                if (_loc_5.isEquip)
                {
                    _loc_4.url = _loc_5.getImgUrl(_loc_2);
                    _loc_4.des = HtmlText.format(_loc_5.getItemName(_loc_2), _loc_5.getItemColor(_loc_2)) + "\n";
                    if (this.eqPlayerItemId != 0)
                    {
                        _loc_4.num = 1;
                    }
                }
                else
                {
                    _loc_4.url = _loc_5.getImgUrl(0);
                    _loc_4.des = HtmlText.format(_loc_5.getItemName(0), _loc_5.getItemColor(0)) + "\n";
                }
                _loc_4.tip = _loc_5.getItemName(_loc_2) + " " + _loc_4.num + "/" + _loc_4.max;
                if (_loc_4.num >= _loc_4.max)
                {
                    _loc_4.num = _loc_4.max;
                    _loc_4.tip = HtmlText.format(_loc_4.tip, 65280);
                }
                else
                {
                    this.reelMaterialEnough = false;
                    _loc_4.tip = HtmlText.format(_loc_4.tip, 15658734);
                }
                this.materialList.push(_loc_4);
                _loc_4.mission = int(_loc_3[3]);
                _loc_4.town = MissionType.getTownIdByMissionId(_loc_4.mission);
                if (_loc_4.town != 0)
                {
                    _loc_4.des = _loc_4.des + TownType.getName(_loc_4.town) + _loc_3[2] + "\n" + HtmlText.format(RefineViewLang.AutoPathfinding, 8947848);
                    continue;
                }
                _loc_4.des = _loc_4.des + _loc_3[2];
            }
            return;
        }// end function

        private function onLianZhi(param1:int, param2:Boolean = false) : void
        {
            var type:* = param1;
            var keep_lv:* = param2;
            if (keep_lv && _ctrl.player.ingot < 50)
            {
                _view.showTip(RefineViewLang.NotEnoughtInog, "", TipType.Question);
                return;
            }
            if (type == 0)
            {
                this.player_use_grid_reel(0, keep_lv);
            }
            else if (_view.ingotEnough(this.reelIngot))
            {
                this.checkBoxSelect(this.cookieId, Lang.sprintf(RefineViewLang.AskJuanZhou, HtmlText.yellow(this.reelIngot + RefineViewLang.Ingot)), function () : void
            {
                player_use_grid_reel(type, keep_lv);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function onAutoMission(param1:int, param2:int) : void
        {
            if (param1 == 0 || param2 == 0)
            {
                return;
            }
            if (_view.townMap.inStage == false)
            {
                _view.showTip(RefineViewLang.MustGoToTown);
                return;
            }
            var _loc_3:* = MissionType.getMissionLock(param2);
            if (_ctrl.player.missionKey < _loc_3)
            {
                this._view.showTip(RefineViewLang.MissionNotOpen);
                return;
            }
            if (MissionType.isHeroMission(param2))
            {
                _view.heroMission.autoMissionId(param1, param2, RefineViewLang.MaterialsFalling);
                _view.heroMission.show();
            }
            else
            {
                _view.chooseMission.autoMissionId(param2, RefineViewLang.MaterialsFalling);
                _view.chooseMission.showTownMission = param1;
            }
            return;
        }// end function

        private function checkBoxSelect(param1:int, param2:String, param3:Function) : void
        {
            var cookieId:* = param1;
            var msg:* = param2;
            var callback:* = param3;
            if (_view.consumeAlertSetting.isAlert(cookieId))
            {
                this.callback();
            }
            else
            {
                _view.alert.iAlert.hasCheckbox = true;
                _view.alert.showYesNoMsg(msg, RefineViewLang.Yes, RefineViewLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    callback();
                    if (_view.alert.iAlert.checked == true)
                    {
                        _view.consumeAlertSetting.saveSetting(cookieId, true);
                    }
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function get_facture_reel_data(param1:int) : void
        {
            this.cookieId = ItemBasically.getBasic(param1).type_id == 1001 ? (ConsumeAlertSetType.RefineZhiZhuo1001) : (ConsumeAlertSetType.RefineZhiZhuo1002);
            if (this.eqPlayerItemId == 0)
            {
                _data.call(Mod_Item_Base.get_facture_reel_data, this.get_facture_reel_data_back, [param1]);
            }
            else
            {
                _data.call(Mod_Item_Base.get_player_item_facture_reel_data, this.get_facture_reel_data_back, [this.eqPlayerItemId, param1]);
            }
            return;
        }// end function

        private function get_facture_reel_data_back() : void
        {
            this.parseData(_ctrl.item.reelData);
            if (this.isAuto)
            {
                if (this.reelIngot > 0)
                {
                    if (_view.ingotEnough(this.reelIngot))
                    {
                        this.checkBoxSelect(this.cookieId, Lang.sprintf(RefineViewLang.AskJuanZhou, HtmlText.yellow(this.reelIngot + RefineViewLang.Ingot)), function () : void
            {
                player_use_grid_reel(1);
                return;
            }// end function
            );
                    }
                }
                else if (this.reelMaterialEnough == true)
                {
                    this.player_use_grid_reel(0);
                }
                else
                {
                    _view.showTip(RefineViewLang.ShortageMaterials);
                }
            }
            else
            {
                loadAssets("Refine", null, RefineViewLang.LaodingRefineTip, false, false, this.loadComplete);
            }
            return;
        }// end function

        private function player_use_grid_reel(param1:int, param2:Boolean = false) : void
        {
            var _loc_3:int = 0;
            if (param2)
            {
                _loc_3 = 1;
            }
            if (this.eqPlayerItemId != 0)
            {
                _data.call(Mod_Item_Base.player_equip_use_reel, this.player_use_grid_reel_back, [this.eqPlayerItemId, this.reelPlayerItemId, param1, _loc_3]);
            }
            else
            {
                _data.call(Mod_Item_Base.player_use_grid_reel, this.player_use_grid_reel_back, [this.reelPlayerItemId, param1, _loc_3]);
            }
            return;
        }// end function

        private function player_use_grid_reel_back() : void
        {
            var _loc_1:String = null;
            if (_ctrl.item.result == Mod_Item_Base.ACTION_SUCCESS)
            {
                _loc_1 = "";
                _loc_1 = Lang.sprintf(RefineViewLang.Synthesis, HtmlText.format(this.outItem.name, this.outItem.color, 12, "", true));
                _view.showTip(_loc_1, "", TipType.Success);
                if (this.eqPlayerItemId != 0)
                {
                    _view.roleMsg.updateEquipList();
                    this._view.toolbar.roleEquipChangeBack(this.eqPlayerRoleId);
                }
                else
                {
                    _view.toolbar.playGoodsEffect(this.outItem.iconUrl);
                    _view.pack.updateGrids();
                }
                this.close();
            }
            else if (_ctrl.item.result == Mod_Item_Base.MATERIAL_NOT_ENOUGH)
            {
                _view.showTip(RefineViewLang.ShortageMaterials);
            }
            else if (_ctrl.item.result == Mod_Item_Base.PACK_FULL)
            {
                _view.showTip(RefineViewLang.PageBoxLack);
            }
            else
            {
                _view.showTip(RefineViewLang.SynthesisFailure);
            }
            return;
        }// end function

        private function onSetCookie(param1:Object) : void
        {
            _view.setCookie("ReFineViewKeepLevel", param1);
            return;
        }// end function

        private function onGetCookie() : Object
        {
            return _view.getCookie("ReFineViewKeepLevel");
        }// end function

    }
}
