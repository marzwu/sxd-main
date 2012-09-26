package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.pack.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    final public class ArmsRecastView extends Base implements IView
    {
        public var playerItemId:int = 0;
        private var _target:IArmsRecast;
        private var _select1:Object;
        private var _select2:Object;
        private var _tipSuccess:String = "";
        private var _toItem:ItemInfo;

        public function ArmsRecastView()
        {
            this._select1 = {};
            this._select2 = {};
            return;
        }// end function

        public function show() : void
        {
            if (_ctrl.player.packNum == 0)
            {
                _view.showTip(ArmsRecastViewLang.PageFull);
                return;
            }
            this.can_change_list();
            return;
        }// end function

        private function loadComplete() : void
        {
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:ItemInfo = null;
            var _loc_5:ItemBasically = null;
            var _loc_6:Object = null;
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("ArmsRecast", "ArmsRecastMC") as IArmsRecast;
                this._target.onClose = this.close;
                this._target.onOk = this.onOK;
                this._target.onSelect1 = this.onSelect1;
                this._target.onSelect2 = this.onSelect2;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            var _loc_7:* = {label:ArmsRecastViewLang.Select2, tip1:"", tip2:"", url:"", id:0, itemId:0};
            this._select2 = {label:ArmsRecastViewLang.Select2, tip1:"", tip2:"", url:"", id:0, itemId:0};
            this._select1 = _loc_7;
            var _loc_1:Array = [];
            for each (_loc_2 in _ctrl.item.recastList)
            {
                
                _loc_3 = _loc_2.pop();
                _loc_4 = new ItemInfo();
                _loc_4.parsePack(_loc_2);
                _loc_5 = _loc_4.basic;
                _loc_6 = {};
                if (_loc_3 > 0 && _loc_3 < 7)
                {
                    _loc_6.label = _loc_4.name + ArmsRecastViewLang.Main;
                    _loc_6.qualityRole = 100 - _loc_5.quality;
                }
                else if (_loc_3 > 6)
                {
                    _loc_6.label = _loc_4.name + "(" + RoleType.getRoleName(_loc_3) + ")";
                    _loc_6.qualityRole = 100 - _loc_5.quality;
                }
                else
                {
                    _loc_6.label = _loc_4.name;
                    _loc_6.qualityRole = 10000;
                }
                _loc_6.item = _loc_4;
                _loc_6.label = htmlFormat(_loc_6.label, 12, _loc_4.color);
                _loc_6.tip1 = htmlFormat(_loc_4.name, 12, _loc_4.color, true);
                _loc_6.tip2 = htmlFormat(ItemType.getItemUpgrade(_loc_4.upgradeLevel) + "\n" + _loc_5.jobs, 12, _loc_4.color);
                _loc_6.url = _loc_5.getImgUrl(_loc_4.goldId);
                _loc_6.upgrade = 1000 - _loc_4.upgradeLevel;
                _loc_6.require = 1000 - _loc_5.require;
                _loc_6.quality = 1000 - _loc_5.quality;
                _loc_6.roleid = uint(_loc_3);
                _loc_1.push(_loc_6);
            }
            _loc_1.sortOn(["qualityRole", "roleid", "quality", "require", "upgrade"], [Array.NUMERIC, Array.NUMERIC, Array.NUMERIC, Array.NUMERIC, Array.NUMERIC]);
            this._target.initdropList1(_loc_1, this._select1);
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function onOK() : void
        {
            var _loc_1:* = this._select1.item as ItemInfo;
            var _loc_2:* = this._select2.item as ItemInfo;
            if (_loc_1 == null || _loc_2 == null)
            {
                _view.showTip(ArmsRecastViewLang.Select1);
            }
            else
            {
                this._target.runAction();
                this._toItem = _loc_2;
                this._tipSuccess = Lang.sprintf(ArmsRecastViewLang.ChangeOK, this._select1.tip1, this._select2.tip1);
                setTimeout(this.change_attack_item, 1600, _loc_1.playerItemId, this.playerItemId, _loc_2.itemId);
            }
            return;
        }// end function

        private function onSelect1(param1:Object) : void
        {
            if (param1.item is ItemInfo == false)
            {
                return;
            }
            var _loc_2:* = param1.item;
            _view.tip.iTip.com.assist.view.interfaces:ITip::addTarget(this._target.box1, _loc_2.getTipsSprite1("", ""));
            this._select1 = param1;
            this.change_attack_info(_loc_2.playerItemId);
            return;
        }// end function

        private function onSelect2(param1:Object) : void
        {
            if (param1.item is ItemInfo == false)
            {
                return;
            }
            var _loc_2:* = param1.item;
            _view.tip.iTip.com.assist.view.interfaces:ITip::addTarget(this._target.box2, _loc_2.getTipsSprite1("", ""));
            this._select2 = param1;
            return;
        }// end function

        private function can_change_list() : void
        {
            _data.call(Mod_Item_Base.can_change_list, this.can_change_list_back, []);
            return;
        }// end function

        private function can_change_list_back() : void
        {
            if (_ctrl.item.recastList.length == 0)
            {
                _view.showTip(ArmsRecastViewLang.NotEQ);
                return;
            }
            loadAssets("ArmsRecast", null, ArmsRecastViewLang.Loading, false, false, this.loadComplete);
            return;
        }// end function

        private function change_attack_info(param1:int) : void
        {
            _data.call(Mod_Item_Base.change_attack_info, this.change_attack_info_back, [param1]);
            return;
        }// end function

        private function change_attack_info_back() : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            var _loc_4:ItemInfo = null;
            var _loc_5:ItemInfo = null;
            var _loc_6:ItemBasically = null;
            var _loc_1:Array = [];
            for each (_loc_3 in _ctrl.item.recastList)
            {
                
                var _loc_9:* = {};
                _loc_2 = {};
                _loc_1.push(_loc_9);
                _loc_4 = this._select1.item;
                _loc_5 = new ItemInfo();
                _loc_5.parseSee(_loc_3[0], _loc_3[1], _loc_4.goldId);
                _loc_5.playerItemId = _loc_4.playerItemId;
                _loc_6 = _loc_5.basic;
                _loc_2.item = _loc_5;
                _loc_2.label = _loc_5.name + " " + ItemType.getItemUpgrade(_loc_3[1]);
                _loc_2.label = htmlFormat(_loc_2.label, 12, _loc_5.color);
                _loc_2.tip1 = htmlFormat(_loc_5.name, 12, _loc_5.color, true);
                _loc_2.tip2 = htmlFormat(ItemType.getItemUpgrade(_loc_3[1]) + "\n" + _loc_6.jobs, 12, _loc_5.color);
                _loc_2.url = _loc_6.getImgUrl(_loc_5.goldId);
            }
            this._select2 = {label:ArmsRecastViewLang.Select1, tip1:"", tip2:"", url:""};
            if (_loc_1.length == 1)
            {
                this._select2 = _loc_1[0];
            }
            this._target.initdropList2(_loc_1, this._select2);
            return;
        }// end function

        private function change_attack_item(param1:int, param2:int, param3:int) : void
        {
            if (inStage == false)
            {
                return;
            }
            _data.call(Mod_Item_Base.change_attack_item, this.change_attack_item_back, [param1, param2, param3]);
            return;
        }// end function

        private function change_attack_item_back() : void
        {
            if (_ctrl.item.result == Mod_Item_Base.SUCCESS)
            {
                _view.alert.confirm(this._tipSuccess);
                _view.toolbar.playGoodsEffect(this._toItem.iconUrl);
                this.close();
            }
            else
            {
                _view.showTip(ArmsRecastViewLang.Error);
            }
            return;
        }// end function

    }
}
