package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.pack.*;
    import com.haloer.data.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.utils.*;

    public class ArmsGoldView extends Base implements IView
    {
        public var playerItemId:int = 0;
        public var goldId:int = 0;
        public var selectPlayerItemId:int = 0;
        private var _canList:Array;
        private var _target:IArmsGold;
        private var _selectObj:Object;
        private var _effectTime:int = 0;

        public function ArmsGoldView()
        {
            this._canList = [];
            return;
        }// end function

        public function show() : void
        {
            if (getTimer() < this._effectTime)
            {
                return;
            }
            this.can_use_gold_info();
            return;
        }// end function

        public function close() : void
        {
            this.selectPlayerItemId = 0;
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function loadComplete() : void
        {
            var _loc_2:Object = null;
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("ArmsGold", "MCGoldArmsClass") as IArmsGold;
                this._target.onClose = this.close;
                this._target.onOk = this.onOK;
                this._target.onSelect = this.onSelect;
                this._target.onTip = this.onTip;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
                _view.tip.iTip.com.assist.view.interfaces:ITip::addTarget(this._target.btnHelp, ArmsGoldViewLang.HelpTip);
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            var _loc_1:* = this._canList[0];
            if (this.selectPlayerItemId != 0)
            {
                for each (_loc_2 in this._canList)
                {
                    
                    if (_loc_2.player_item_id == this.selectPlayerItemId)
                    {
                        _loc_1 = _loc_2;
                        break;
                    }
                }
            }
            this._target.initDropList(this._canList, _loc_1);
            return;
        }// end function

        private function onOK() : void
        {
            this.use_gold_oil();
            return;
        }// end function

        private function onSelect(param1:Object) : void
        {
            this._selectObj = param1;
            var _loc_2:* = new ItemInfo();
            _loc_2.parseSee(param1.item_id, param1.player_item_lv, GoldOilType.getPrevOilItemId(this.goldId));
            _loc_2.playerItemId = param1.player_item_id;
            _view.tip.iTip.com.assist.view.interfaces:ITip::addTarget(this._target.mcBox, _loc_2.getTipsSprite1("", ""));
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2) : void
        {
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

        private function can_use_gold_info() : void
        {
            _data.call(Mod_Item_Base.can_use_gold_info, this.can_use_gold_info_back, [this.goldId]);
            return;
        }// end function

        private function can_use_gold_info_back() : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            var _loc_5:ItemBasically = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:Array = null;
            var _loc_9:String = null;
            var _loc_10:String = null;
            this._canList = [];
            var _loc_1:* = GoldOilType.getPrevOilItemId(this.goldId);
            var _loc_2:* = Lang.sprintf(ArmsGoldViewLang.GoldUseCoin, int(GoldOilType.getUseCoin(this.goldId) / 10000));
            for each (_loc_3 in _ctrl.item.cangoldList)
            {
                
                _loc_4 = {};
                oObject.list(_loc_3, _loc_4, ["player_item_id", "item_id", "player_item_lv", "item_attack_up", "item_defense_up", "item_stunt_attack_up", "item_stunt_defense_up", "item_magic_attack_up", "item_magic_defense_up", "item_health_up", "to_item_attack_up", "to_item_defense_up", "to_item_stunt_attack_up", "to_item_stunt_defense_up", "to_item_magic_attack_up", "to_item_magic_defense_up", "to_item_health_up", "role_id"]);
                _loc_5 = ItemBasically.getBasic(_loc_4.item_id);
                _loc_6 = _loc_5.getItemColor(_loc_1);
                _loc_7 = _loc_4.player_item_lv;
                _loc_4.iconUrl1 = _loc_5.getImgUrl(_loc_1);
                _loc_4.iconUrl2 = _loc_5.getImgUrl(this.goldId);
                _loc_4.msg = _loc_2;
                _loc_4.name1 = HtmlText.format(_loc_5.getItemName(_loc_1), _loc_6);
                _loc_4.name2 = HtmlText.format(_loc_5.getItemName(this.goldId), 16773632);
                _loc_4.label = _loc_4.name1;
                if (_loc_4.role_id > 0 && _loc_4.role_id < 7)
                {
                    _loc_4.label = _loc_4.label + HtmlText.format(ArmsGoldViewLang.Main, _loc_6);
                }
                else if (_loc_4.role_id >= 7)
                {
                    _loc_4.label = _loc_4.label + HtmlText.format("(" + RoleType.getRoleName(_loc_4.role_id) + ")", _loc_6);
                }
                _loc_4.lv1 = HtmlText.format(ItemType.getItemUpgrade(_loc_7), _loc_6);
                _loc_4.lv2 = HtmlText.format(ItemType.getItemUpgrade(_loc_7), 16773632);
                _loc_8 = ["", "", "", "", "", "", "", "", "", "", "", ""];
                _loc_9 = "";
                _loc_10 = "";
                if (_loc_4.item_health_up > 0)
                {
                    _loc_9 = ArmsGoldViewLang.HealthEach + (_loc_5.getHealthValue(2, _loc_1) - _loc_5.getHealthValue(1, _loc_1));
                    _loc_10 = ArmsGoldViewLang.HealthEach + (_loc_5.getHealthValue(2, this.goldId) - _loc_5.getHealthValue(1, this.goldId));
                    _loc_8.push(_loc_10, _loc_9, ArmsGoldViewLang.Health, "+" + _loc_4.item_health_up, "+" + _loc_4.to_item_health_up);
                }
                if (_loc_4.item_magic_defense_up > 0)
                {
                    _loc_9 = ArmsGoldViewLang.MDefenseEach + (_loc_5.getMDefenseValue(2, _loc_1) - _loc_5.getMDefenseValue(1, _loc_1));
                    _loc_10 = ArmsGoldViewLang.MDefenseEach + (_loc_5.getMDefenseValue(2, this.goldId) - _loc_5.getMDefenseValue(1, this.goldId));
                    _loc_8.push(_loc_10, _loc_9, ArmsGoldViewLang.MDefense, "+" + _loc_4.item_magic_defense_up, "+" + _loc_4.to_item_magic_defense_up);
                }
                if (_loc_4.item_magic_attack_up > 0)
                {
                    _loc_9 = ArmsGoldViewLang.MAttackEach + (_loc_5.getMAttackValue(2, _loc_1) - _loc_5.getMAttackValue(1, _loc_1));
                    _loc_10 = ArmsGoldViewLang.MAttackEach + (_loc_5.getMAttackValue(2, this.goldId) - _loc_5.getMAttackValue(1, this.goldId));
                    _loc_8.push(_loc_10, _loc_9, ArmsGoldViewLang.MAttack, "+" + _loc_4.item_magic_attack_up, "+" + _loc_4.to_item_magic_attack_up);
                }
                if (_loc_4.item_stunt_defense_up > 0)
                {
                    _loc_9 = ArmsGoldViewLang.SDefenseEach + (_loc_5.getSDefenseValue(2, _loc_1) - _loc_5.getSDefenseValue(1, _loc_1));
                    _loc_10 = ArmsGoldViewLang.SDefenseEach + (_loc_5.getSDefenseValue(2, this.goldId) - _loc_5.getSDefenseValue(1, this.goldId));
                    _loc_8.push(_loc_10, _loc_9, ArmsGoldViewLang.SDefense, "+" + _loc_4.item_stunt_defense_up, "+" + _loc_4.to_item_stunt_defense_up);
                }
                if (_loc_4.item_stunt_attack_up > 0)
                {
                    _loc_9 = ArmsGoldViewLang.SAttackEach + (_loc_5.getSAttackValue(2, _loc_1) - _loc_5.getSAttackValue(1, _loc_1));
                    _loc_10 = ArmsGoldViewLang.SAttackEach + (_loc_5.getSAttackValue(2, this.goldId) - _loc_5.getSAttackValue(1, this.goldId));
                    _loc_8.push(_loc_10, _loc_9, ArmsGoldViewLang.SAttack, "+" + _loc_4.item_stunt_attack_up, "+" + _loc_4.to_item_stunt_attack_up);
                }
                if (_loc_4.item_defense_up > 0)
                {
                    _loc_9 = ArmsGoldViewLang.PDefenseEach + (_loc_5.getPDefenseValue(2, _loc_1) - _loc_5.getPDefenseValue(1, _loc_1));
                    _loc_10 = ArmsGoldViewLang.PDefenseEach + (_loc_5.getPDefenseValue(2, this.goldId) - _loc_5.getPDefenseValue(1, this.goldId));
                    _loc_8.push(_loc_10, _loc_9, ArmsGoldViewLang.PDefense, "+" + _loc_4.item_defense_up, "+" + _loc_4.to_item_defense_up);
                }
                if (_loc_4.item_attack_up > 0)
                {
                    _loc_9 = ArmsGoldViewLang.PAttackEach + (_loc_5.getPAttackValue(2, _loc_1) - _loc_5.getPAttackValue(1, _loc_1));
                    _loc_10 = ArmsGoldViewLang.PAttackEach + (_loc_5.getPAttackValue(2, this.goldId) - _loc_5.getPAttackValue(1, this.goldId));
                    _loc_8.push(_loc_10, _loc_9, ArmsGoldViewLang.PAttack, "+" + _loc_4.item_attack_up, "+" + _loc_4.to_item_attack_up);
                }
                _loc_4.add2 = HtmlText.format(_loc_8.pop(), 16773632);
                _loc_4.add1 = HtmlText.format(_loc_8.pop(), _loc_6);
                _loc_4.addName1 = _loc_8.pop();
                _loc_4.tip1 = _loc_8.pop();
                _loc_4.tip2 = _loc_8.pop();
                _loc_4.add4 = HtmlText.format(_loc_8.pop(), 16773632);
                _loc_4.add3 = HtmlText.format(_loc_8.pop(), _loc_6);
                _loc_4.addName2 = _loc_8.pop();
                _loc_4.tip3 = _loc_8.pop();
                _loc_4.tip4 = _loc_8.pop();
                _loc_4.quality = 1000 - _loc_5.quality;
                _loc_4.require = 1000 - _loc_5.require;
                _loc_4.upgrade = 1000 - _loc_4.player_item_lv;
                _loc_4.roleid = _loc_4.role_id <= 0 ? (10000) : (_loc_4.role_id);
                this._canList.push(_loc_4);
            }
            if (this._canList.length == 0)
            {
                switch(this.goldId)
                {
                    case 1203:
                    {
                        _view.showTip(ArmsGoldViewLang.Need90);
                        break;
                    }
                    case 1204:
                    {
                        _view.showTip(ArmsGoldViewLang.Need100);
                        break;
                    }
                    case 1205:
                    {
                        _view.showTip(ArmsGoldViewLang.Need110);
                        break;
                    }
                    case 1206:
                    {
                        _view.showTip(ArmsGoldViewLang.Need120);
                        break;
                    }
                    case 1207:
                    {
                        _view.showTip(ArmsGoldViewLang.Need130);
                        break;
                    }
                    case 1208:
                    {
                        _view.showTip(ArmsGoldViewLang.Need140);
                        break;
                    }
                    case 1209:
                    {
                        _view.showTip(ArmsGoldViewLang.Need150);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }
            this._canList.sortOn(["roleid", "quality", "require", "upgrade"], [Array.NUMERIC, Array.NUMERIC, Array.NUMERIC, Array.NUMERIC]);
            loadAssets("ArmsGold", null, ArmsGoldViewLang.Loading, false, false, this.loadComplete);
            return;
        }// end function

        public function use_gold_oil() : void
        {
            if (_view.coinEnough(GoldOilType.getUseCoin(this.goldId)) == false)
            {
                return;
            }
            _data.call(Mod_Item_Base.use_gold_oil, this.use_gold_oil_back, [this._selectObj.player_item_id, this.playerItemId], true);
            return;
        }// end function

        public function use_gold_oil_back() : void
        {
            switch(_ctrl.item.result)
            {
                case Mod_Item_Base.SUCCESS:
                {
                    this._target.playEffect();
                    _view.pack.updateGrids();
                    _view.roleMsg.updateEquipList();
                    setTimeout(_view.showTip, 800, ArmsGoldViewLang.Success, null, TipType.Success);
                    setTimeout(this.close, 2700);
                    this._effectTime = getTimer() + 2700;
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_STATE_POINT:
                {
                    _view.showTip(ArmsGoldViewLang.NOT_ENOUGH_STATE_POINT);
                    break;
                }
                case Mod_Item_Base.UN_AVALIABLE_GRID:
                {
                    _view.showTip(ArmsGoldViewLang.UN_AVALIABLE_GRID);
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_ITEM:
                {
                    _view.showTip(ArmsGoldViewLang.NOT_ENOUGH_ITEM);
                    break;
                }
                case Mod_Item_Base.NOT_ENOUGH_COIN:
                {
                    _view.showTip(ArmsGoldViewLang.NOT_ENOUGH_COIN);
                    break;
                }
                default:
                {
                    _view.showTip(ArmsGoldViewLang.Error);
                    break;
                    break;
                }
            }
            return;
        }// end function

    }
}
