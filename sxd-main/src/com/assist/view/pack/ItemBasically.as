package com.assist.view.pack
{
    import com.assist.server.*;
    import com.assist.view.map.*;
    import com.lang.client.com.assist.view.pack.*;

    public class ItemBasically extends Object
    {
        public var color:int;
        public var name:String = "";
        public var tipProduce:String = "";
        public var desList:Array;
        public var quality:int;
        public var max:int;
        public var item_id:int = 0;
        public var type_id:int = 0;
        public var card_id:int;
        public var card_num:int;
        public var card_name:String;
        public var ingot:int = 0;
        public var price:int;
        public var require:int;
        public var jobs:String;
        public var jobArr:Array;
        public var jobId:int;
        public var strength:int;
        public var agile:int;
        public var intellect:int;
        private var Health:int;
        private var Health_up:int;
        private var PAttack:int;
        private var PAttack_up:int;
        private var PDefense:int;
        private var PDefense_up:int;
        private var SAttack:int;
        private var SAttack_up:int;
        private var SDefense:int;
        private var SDefense_up:int;
        private var MAttack:int;
        private var MAttack_up:int;
        private var MDefense:int;
        private var MDefense_up:int;
        private static var starNames:Array = [""];
        public static var empty:ItemBasically = new ItemBasically(0);
        private static var ShopIdxList:Array = [0, 2, 6, 1, 3, 5, 4];
        private static var cache:Array = [empty];

        public function ItemBasically(param1:int) : void
        {
            var _loc_4:int = 0;
            this.jobArr = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            if (param1 == 0)
            {
                return;
            }
            if (starNames.length == 1)
            {
                starNames[1203] = "";
                starNames[1204] = ItemBasicallyLang.Star2;
                starNames[1205] = ItemBasicallyLang.Star3;
                starNames[1206] = ItemBasicallyLang.Star4;
                starNames[1207] = ItemBasicallyLang.Star5;
                starNames[1208] = ItemBasicallyLang.Star6;
                starNames[1209] = ItemBasicallyLang.Star7;
                starNames[1210] = ItemBasicallyLang.Star8;
                starNames[1211] = ItemBasicallyLang.Star9;
            }
            var _loc_2:* = ItemType.getItemAllDatas(param1);
            this.item_id = param1;
            this.type_id = _loc_2.type_id;
            this.name = _loc_2.name;
            this.quality = _loc_2.quality;
            this.require = _loc_2.require_level;
            this.price = _loc_2.price;
            this.ingot = _loc_2.ingot;
            this.desList = _loc_2.descriptionList;
            this.card_id = _loc_2.item_card_id;
            this.card_num = _loc_2.item_card_num;
            this.Health = _loc_2.health;
            this.Health_up = _loc_2.health_up;
            this.PAttack = _loc_2.attack;
            this.PAttack_up = _loc_2.attack_up;
            this.PDefense = _loc_2.defense;
            this.PDefense_up = _loc_2.defense_up;
            this.SAttack = _loc_2.stunt_attack;
            this.SAttack_up = _loc_2.stunt_attack_up;
            this.SDefense = _loc_2.stunt_defense;
            this.SDefense_up = _loc_2.stunt_defense_up;
            this.MAttack = _loc_2.magic_attack;
            this.MAttack_up = _loc_2.magic_attack_up;
            this.MDefense = _loc_2.magic_defense;
            this.MDefense_up = _loc_2.magic_defense_up;
            this.strength = _loc_2.strength;
            this.agile = _loc_2.agile;
            this.intellect = _loc_2.intellect;
            this.tipProduce = _loc_2.tipProduce;
            this.color = ItemType.getItemColor(this.item_id);
            this.max = ItemType.getMaxRepeatNum(this.type_id);
            this.card_name = ItemType.getName(this.card_id);
            if (this.type_id == ItemType.ValuableItems)
            {
            }
            var _loc_3:* = ItemType.getEquipJob(this.item_id);
            this.jobId = int(_loc_3[0]);
            if (_loc_3.length == 0 || _loc_3.length >= 5)
            {
                this.jobs = ItemBasicallyLang.NotLimited;
                this.jobArr = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
            }
            else
            {
                this.jobs = "";
                for each (_loc_4 in _loc_3)
                {
                    
                    this.jobs = this.jobs + RoleType.getJobName(_loc_4) + " ";
                    this.jobArr[_loc_4] = 1;
                }
            }
            return;
        }// end function

        public function getImgUrl(param1:int) : String
        {
            if (this.item_id == 0)
            {
                return null;
            }
            if (param1 == 0)
            {
                return MapStatic.FolderItemIcon + this.item_id + ".png";
            }
            return MapStatic.FolderItemIcon + this.item_id + "_g.png";
        }// end function

        public function get isEquip() : Boolean
        {
            return ItemType.isEquip(this.type_id);
        }// end function

        public function get isStack() : Boolean
        {
            return this.max > 1;
        }// end function

        public function get isQuest() : Boolean
        {
            return this.type_id == ItemType.RenWuWuPin;
        }// end function

        public function get isBrand() : Boolean
        {
            return this.type_id == ItemType.YuPai;
        }// end function

        public function get isPackage() : Boolean
        {
            return this.type_id == ItemType.ChengZhangLiBao || this.type_id == ItemType.HuoDongLiBao || this.type_id == ItemType.SuperLiBao;
        }// end function

        public function get isMounts() : Boolean
        {
            return this.type_id == ItemType.ZuoJi;
        }// end function

        public function get isDanYao() : Boolean
        {
            return this.type_id == ItemType.WuLiDan || this.type_id == ItemType.JueJiDan || this.type_id == ItemType.FaShuDan;
        }// end function

        public function get isJuanZhou() : Boolean
        {
            return this.type_id == ItemType.LianDanJuanZhou || this.type_id == ItemType.LianQiJuanZhou;
        }// end function

        public function get isSkill() : Boolean
        {
            return this.type_id == ItemType.skill;
        }// end function

        public function get isChangeAttack() : Boolean
        {
            return this.type_id == ItemType.ChangeAttackItem;
        }// end function

        public function get isGoldOil() : Boolean
        {
            return this.type_id == ItemType.GoldOil;
        }// end function

        public function get isZaWu() : Boolean
        {
            return this.type_id == ItemType.ZaWu || this.type_id == ItemType.ValuableItems;
        }// end function

        public function get isBianShen() : Boolean
        {
            return this.type_id == ItemType.BianShen;
        }// end function

        public function get isXiHaoPin() : Boolean
        {
            return this.type_id == ItemType.XiHaoPin;
        }// end function

        public function get isCanUseing() : Boolean
        {
            var _loc_1:Boolean = true;
            switch(this.type_id)
            {
                case ItemType.ZaWu:
                case ItemType.RenWuWuPin:
                case ItemType.LingPai:
                case ItemType.YuPai:
                case ItemType.ValuableItems:
                case ItemType.XiHaoPin:
                {
                    _loc_1 = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        public function getItemName(param1:int) : String
        {
            if (this.isEquip == false)
            {
                return this.name;
            }
            return this.name + (starNames[param1] || "");
        }// end function

        public function getItemColor(param1:int) : int
        {
            if (param1 == 0 || this.isEquip == false)
            {
                return this.color;
            }
            return 16773632;
        }// end function

        public function getHealthValue(param1:int, param2:int = 0) : int
        {
            if (this.Health == 0)
            {
                return 0;
            }
            var _loc_3:* = this.Health_up;
            if (param2 != 0)
            {
                _loc_3 = _loc_3 + GoldOilType.getOilAttr(param2, this.type_id).healthUp;
            }
            return this.Health + (param1 - 1) * _loc_3;
        }// end function

        public function getHealth(param1:int, param2:int = 0) : String
        {
            if (this.Health == 0)
            {
                return "";
            }
            return "\n" + ItemBasicallyLang.AddLifeLimited + this.getHealthValue(param1, param2);
        }// end function

        public function getPAttackValue(param1:int, param2:int = 0) : int
        {
            if (this.PAttack == 0)
            {
                return 0;
            }
            var _loc_3:* = this.PAttack_up;
            if (param2 != 0)
            {
                _loc_3 = _loc_3 + GoldOilType.getOilAttr(param2, this.type_id, this.jobId).attackUp;
            }
            return this.PAttack + (param1 - 1) * _loc_3;
        }// end function

        public function getPAttack(param1:int, param2:int = 0) : String
        {
            if (this.PAttack == 0)
            {
                return "";
            }
            return "\n" + ItemBasicallyLang.AddNormalAttack + this.getPAttackValue(param1, param2);
        }// end function

        public function getPDefenseValue(param1:int, param2:int = 0) : int
        {
            if (this.PDefense == 0)
            {
                return 0;
            }
            var _loc_3:* = this.PDefense_up;
            if (param2 != 0)
            {
                _loc_3 = _loc_3 + GoldOilType.getOilAttr(param2, this.type_id).defenseUp;
            }
            return this.PDefense + (param1 - 1) * _loc_3;
        }// end function

        public function getPDefense(param1:int, param2:int = 0) : String
        {
            if (this.PDefense == 0)
            {
                return "";
            }
            return "\n" + ItemBasicallyLang.AddCommonDefense + this.getPDefenseValue(param1, param2);
        }// end function

        public function getSAttackValue(param1:int, param2:int = 0) : int
        {
            if (this.SAttack == 0)
            {
                return 0;
            }
            var _loc_3:* = this.SAttack_up;
            if (param2 != 0)
            {
                _loc_3 = _loc_3 + GoldOilType.getOilAttr(param2, this.type_id, this.jobId).stuntAttackUp;
            }
            return this.SAttack + (param1 - 1) * _loc_3;
        }// end function

        public function getSAttack(param1:int, param2:int = 0) : String
        {
            if (this.SAttack == 0)
            {
                return "";
            }
            return "\n" + ItemBasicallyLang.AddStuntAttack + this.getSAttackValue(param1, param2);
        }// end function

        public function getSDefenseValue(param1:int, param2:int = 0) : int
        {
            if (this.SDefense == 0)
            {
                return 0;
            }
            var _loc_3:* = this.SDefense_up;
            if (param2 != 0)
            {
                _loc_3 = _loc_3 + GoldOilType.getOilAttr(param2, this.type_id).stuntDefenseUp;
            }
            return this.SDefense + (param1 - 1) * _loc_3;
        }// end function

        public function getSDefense(param1:int, param2:int = 0) : String
        {
            if (this.SDefense == 0)
            {
                return "";
            }
            return "\n" + ItemBasicallyLang.AddStuntDefense + this.getSDefenseValue(param1, param2);
        }// end function

        public function getMAttackValue(param1:int, param2:int = 0) : int
        {
            if (this.MAttack == 0)
            {
                return 0;
            }
            var _loc_3:* = this.MAttack_up;
            if (param2 != 0)
            {
                _loc_3 = _loc_3 + GoldOilType.getOilAttr(param2, this.type_id, this.jobId).magicAttackUp;
            }
            return this.MAttack + (param1 - 1) * _loc_3;
        }// end function

        public function getMAttack(param1:int, param2:int = 0) : String
        {
            if (this.MAttack == 0)
            {
                return "";
            }
            return "\n" + ItemBasicallyLang.AddMagicAttack + this.getMAttackValue(param1, param2);
        }// end function

        public function getMDefenseValue(param1:int, param2:int = 0) : int
        {
            if (this.MDefense == 0)
            {
                return 0;
            }
            var _loc_3:* = this.MDefense_up;
            if (param2 != 0)
            {
                _loc_3 = _loc_3 + GoldOilType.getOilAttr(param2, this.type_id).magicDefenseUp;
            }
            return this.MDefense + (param1 - 1) * _loc_3;
        }// end function

        public function getMDefense(param1:int, param2:int = 0) : String
        {
            if (this.MDefense == 0)
            {
                return "";
            }
            return "\n" + ItemBasicallyLang.AddMagicDefense + this.getMDefenseValue(param1, param2);
        }// end function

        public static function getBasic(param1:int) : ItemBasically
        {
            if (cache[param1] is ItemBasically)
            {
                return cache[param1];
            }
            var _loc_3:* = new ItemBasically(param1);
            cache[param1] = new ItemBasically(param1);
            var _loc_2:* = _loc_3;
            return _loc_2;
        }// end function

    }
}
