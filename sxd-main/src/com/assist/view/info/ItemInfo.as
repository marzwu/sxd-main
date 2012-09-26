package com.assist.view.info
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.pack.*;
    import com.lang.client.com.assist.view.info.*;

    public class ItemInfo extends Object
    {
        private var _tipSP1:ItemTipSprite;
        private var _tipSP2:ItemTipSprite;
        private var _seeType:int;
        public var gridId:int = 0;
        public var playerItemId:int = 0;
        public var itemId:int;
        public var typeId:int;
        public var quality:int;
        public var ingot:int = 0;
        public var num:int = 0;
        public var goldId:int = 0;
        public var isCardBuy:Boolean = false;
        public var upgradeLevel:int = 0;
        public var price:int = 0;
        public var totalprice:int = 0;
        public var useing:int = 0;
        public var basic:ItemBasically;
        public var eatCount:int = 0;
        public var nameTip:String;
        public var desTipList:Array;
        public var addTip:String;
        public var lastTip:String;
        public var name:String;
        public var iconUrl:String;
        public var color:int;
        public var endTime:int = 0;
        public static var playerlv:int;
        public static var roleLv:int = 0;
        public static var roleJobId:int = 0;
        private static var _date:Date = new Date();

        public function ItemInfo()
        {
            this.reset();
            return;
        }// end function

        public function reset() : void
        {
            this.isCardBuy = false;
            var _loc_1:int = 0;
            this.endTime = 0;
            var _loc_1:* = _loc_1;
            this.color = _loc_1;
            var _loc_1:* = _loc_1;
            this.ingot = _loc_1;
            var _loc_1:* = _loc_1;
            this.quality = _loc_1;
            var _loc_1:* = _loc_1;
            this.useing = _loc_1;
            var _loc_1:* = _loc_1;
            this.typeId = _loc_1;
            var _loc_1:* = _loc_1;
            this.price = _loc_1;
            var _loc_1:* = _loc_1;
            this.goldId = _loc_1;
            var _loc_1:* = _loc_1;
            this.totalprice = _loc_1;
            var _loc_1:* = _loc_1;
            this.num = _loc_1;
            var _loc_1:* = _loc_1;
            this.itemId = _loc_1;
            this.playerItemId = _loc_1;
            this.basic = ItemBasically.empty;
            this.upgradeLevel = 1;
            var _loc_1:String = "";
            this.lastTip = "";
            var _loc_1:* = _loc_1;
            this.addTip = _loc_1;
            var _loc_1:* = _loc_1;
            this.iconUrl = _loc_1;
            var _loc_1:* = _loc_1;
            this.name = _loc_1;
            this.nameTip = _loc_1;
            this.desTipList = [];
            return;
        }// end function

        private function get reqTip() : String
        {
            var _loc_3:uint = 0;
            var _loc_4:uint = 0;
            var _loc_5:uint = 0;
            var _loc_1:String = "";
            var _loc_2:* = this.basic.require;
            if (this.basic.isEquip)
            {
                _loc_3 = roleLv == 0 || roleLv >= _loc_2 ? (15658734) : (16711680);
                _loc_4 = this.basic.jobArr[roleJobId] == 1 ? (15658734) : (16711680);
                _loc_1 = htmlFormat(ItemInfoLang.EquipReq, 12, 15658734);
                _loc_1 = _loc_1 + "\n" + htmlFormat(Lang.sprintf(ItemInfoLang.EquipRoleLV, _loc_2), 12, _loc_3);
                _loc_1 = _loc_1 + "\n" + htmlFormat(Lang.sprintf(ItemInfoLang.EquipJob, this.basic.jobs), 12, _loc_4);
            }
            else if (this.basic.type_id == ItemType.ChengZhangLiBao)
            {
                _loc_5 = playerlv >= _loc_2 ? (15425792) : (16711680);
                _loc_1 = htmlFormat(Lang.sprintf(ItemInfoLang.ItemRoleLv, _loc_2), 12, _loc_5);
            }
            return _loc_1;
        }// end function

        public function getTipsSprite1(param1:String, param2:String) : ItemTipSprite
        {
            this._tipSP1 = this._tipSP1 || new ItemTipSprite();
            this._tipSP1.topString = param1;
            this._tipSP1.bottomString = param2;
            this.updateTipSprite(this._tipSP1);
            return this._tipSP1;
        }// end function

        public function getTipsSprite2(param1:String, param2:String) : ItemTipSprite
        {
            this._tipSP2 = this._tipSP2 || new ItemTipSprite();
            this._tipSP2.topString = param1;
            this._tipSP2.bottomString = param2;
            this.updateTipSprite(this._tipSP2);
            return this._tipSP2;
        }// end function

        private function updateTipSprite(param1:ItemTipSprite) : void
        {
            if (param1 == null)
            {
                return;
            }
            param1.basic = this.basic;
            param1.playerItemId = this.playerItemId;
            param1.goldId = this.goldId;
            var _loc_2:Array = [];
            if (this.addTip != "")
            {
                _loc_2.push(this.addTip);
                ;
            }
            if (this.reqTip != "")
            {
                _loc_2.push(this.reqTip);
                ;
            }
            _loc_2 = _loc_2.concat(this.desTipList);
            if (this.lastTip != "")
            {
                _loc_2.push(this.lastTip);
                ;
            }
            param1.updateTip(this.nameTip, _loc_2);
            return;
        }// end function

        private function resetTipSprite(param1:ItemTipSprite) : void
        {
            if (param1 == null)
            {
                return;
            }
            param1.reset();
            return;
        }// end function

        public function parseShop(param1:int, param2:int = 1, param3:Boolean = false) : void
        {
            this.reset();
            this.itemId = param1;
            this._seeType = 2;
            this.num = 1;
            this.upgradeLevel = param2;
            this.isCardBuy = param3;
            this.parse();
            return;
        }// end function

        public function parseRecycle(param1:Array) : void
        {
            this.reset();
            this.playerItemId = param1[0];
            this.itemId = param1[1];
            this.upgradeLevel = param1[2];
            this.price = param1[3];
            this.num = param1[4];
            this.goldId = param1[6];
            this.totalprice = this.price * this.num;
            this._seeType = 3;
            this.parse();
            return;
        }// end function

        public function parseSee(param1:int, param2:int = 1, param3:int = 0) : void
        {
            this.reset();
            this.itemId = param1;
            this._seeType = 4;
            this.upgradeLevel = param2;
            this.goldId = param3;
            this.parse();
            return;
        }// end function

        public function parsePack(param1:Array) : void
        {
            this.reset();
            this.playerItemId = param1[0];
            this.itemId = param1[1];
            this.gridId = param1[2];
            this.upgradeLevel = param1[3];
            this.price = param1[4];
            this.num = param1[5];
            this.useing = param1[6];
            this.goldId = param1[7];
            this.endTime = param1[8];
            this.totalprice = this.price * this.num;
            this._seeType = 1;
            this.parse();
            return;
        }// end function

        private function parse() : void
        {
            var _loc_1:String = null;
            this.resetTipSprite(this._tipSP1);
            this.resetTipSprite(this._tipSP2);
            if (this.itemId == 0)
            {
                this.reset();
                return;
            }
            this.basic = ItemBasically.getBasic(this.itemId);
            this.typeId = this.basic.type_id;
            this.quality = this.basic.quality;
            this.ingot = this.basic.ingot;
            if (this._seeType == 2)
            {
                var _loc_2:* = this.basic.price;
                this.price = this.basic.price;
                this.totalprice = _loc_2;
            }
            this.desTipList = [];
            for each (_loc_1 in this.basic.desList)
            {
                
                this.desTipList.push(htmlFormat(_loc_1, 12, 15658734));
            }
            this.name = this.basic.getItemName(this.goldId);
            this.color = this.basic.getItemColor(this.goldId);
            this.iconUrl = this.basic.getImgUrl(this.goldId);
            this.nameTip = htmlFormat(this.name, 16, this.color, true);
            if (this.basic.isEquip)
            {
                this.addTip = Lang.sprintf(ItemInfoLang.EquipStrengthenLv, ItemType.getItemUpgrade(this.upgradeLevel));
                this.addTip = this.addTip + this.basic.getPAttack(this.upgradeLevel, this.goldId);
                this.addTip = this.addTip + this.basic.getPDefense(this.upgradeLevel, this.goldId);
                this.addTip = this.addTip + this.basic.getSAttack(this.upgradeLevel, this.goldId);
                this.addTip = this.addTip + this.basic.getSDefense(this.upgradeLevel, this.goldId);
                this.addTip = this.addTip + this.basic.getMAttack(this.upgradeLevel, this.goldId);
                this.addTip = this.addTip + this.basic.getMDefense(this.upgradeLevel, this.goldId);
                this.addTip = this.addTip + this.basic.getHealth(this.upgradeLevel, this.goldId);
                this.addTip = htmlFormat(this.addTip, 12, 15425792);
            }
            else if (this.basic.isDanYao)
            {
                if (this.basic.strength != 0)
                {
                    _loc_1 = ItemInfoLang.AddWuLi + (this.basic.strength - this.eatCount * 5);
                }
                else if (this.basic.agile != 0)
                {
                    _loc_1 = ItemInfoLang.AddJueJi + (this.basic.agile - this.eatCount * 5);
                }
                else if (this.basic.intellect != 0)
                {
                    _loc_1 = ItemInfoLang.AddFaShu + (this.basic.intellect - this.eatCount * 5);
                }
                this.desTipList[0] = htmlFormat(_loc_1, 12, 15425792) + "\n" + this.desTipList[0];
            }
            if (this.isCardBuy)
            {
                this.lastTip = htmlFormat(this.basic.card_name + ": " + this.basic.card_num, 12, 14077494);
            }
            else if (this.basic.isQuest)
            {
                this.desTipList[(this.desTipList.length - 1)] = this.desTipList[(this.desTipList.length - 1)] + "\n" + htmlFormat(ItemInfoLang.ItemQuest, 12, 14077494);
            }
            else if (this.totalprice > 0)
            {
                if (this.basic.isBianShen || this.basic.isMounts || this.basic.isDanYao)
                {
                    this.desTipList[(this.desTipList.length - 1)] = this.desTipList[(this.desTipList.length - 1)] + "\n" + htmlFormat(ItemInfoLang.Prace + ": " + this.totalprice, 12, 14077494);
                }
                else
                {
                    this.lastTip = htmlFormat(ItemInfoLang.Prace + ": " + this.totalprice, 12, 14077494);
                }
            }
            else if (this.basic.type_id == 10006)
            {
                this.lastTip = htmlFormat(ItemInfoLang.OpenLuWu, 12, 8947848);
            }
            if (this.endTime > 0)
            {
                _date.time = this.endTime * 1000;
                _loc_1 = htmlFormat(Lang.sprintf(ItemInfoLang.TimeFormat, _date.fullYear, (_date.month + 1), _date.date, _date.hours), 12, 14077494);
                if (this.lastTip != "")
                {
                    this.lastTip = this.lastTip + "\n" + _loc_1;
                }
                else
                {
                    this.desTipList[(this.desTipList.length - 1)] = this.desTipList[(this.desTipList.length - 1)] + "\n" + _loc_1;
                }
            }
            this.updateTipSprite(this._tipSP1);
            this.updateTipSprite(this._tipSP2);
            return;
        }// end function

        public function get easyMsg() : String
        {
            if (this.desTipList[0] == null)
            {
                return this.nameTip + "\n" + this.addTip;
            }
            return this.nameTip + "\n" + this.addTip + "\n" + this.desTipList[0];
        }// end function

        public function get addSum() : int
        {
            var _loc_1:int = 0;
            _loc_1 = _loc_1 + this.basic.getPAttackValue(this.upgradeLevel, this.goldId);
            _loc_1 = _loc_1 + this.basic.getPDefenseValue(this.upgradeLevel, this.goldId);
            _loc_1 = _loc_1 + this.basic.getSAttackValue(this.upgradeLevel, this.goldId);
            _loc_1 = _loc_1 + this.basic.getSDefenseValue(this.upgradeLevel, this.goldId);
            _loc_1 = _loc_1 + this.basic.getMAttackValue(this.upgradeLevel, this.goldId);
            _loc_1 = _loc_1 + this.basic.getMDefenseValue(this.upgradeLevel, this.goldId);
            _loc_1 = _loc_1 + this.basic.getHealthValue(this.upgradeLevel, this.goldId);
            return _loc_1;
        }// end function

        public function clone() : ItemInfo
        {
            var _loc_1:* = new ItemInfo();
            _loc_1.parseSee(this.itemId, this.upgradeLevel, this.goldId);
            _loc_1.playerItemId = this.playerItemId;
            _loc_1.gridId = this.gridId;
            return _loc_1;
        }// end function

    }
}
