package com.assist.server
{

    public class ItemType extends Object
    {
        public static const QuestItemTypeId:int = 10004;
        private static var reg:RegExp = /\[(.+?)\]""\[(.+?)\]/g;
        public static var yuPaiObj:Object = {4:[3, 4, 7], 4:[8, 9], 4:[13], 4:[14, 15], 4:[0], 19:[0]};
        public static const TouKui:int = 1;
        public static const WuQi:int = 2;
        public static const HunQi:int = 3;
        public static const YiFu:int = 4;
        public static const HuFu:int = 5;
        public static const XieZi:int = 6;
        public static const ZuoJi:int = 7;
        public static const LianDanJuanZhou:int = 1001;
        public static const LianQiJuanZhou:int = 1002;
        public static const HongYao:int = 10001;
        public static const ZaWu:int = 10003;
        public static const RenWuWuPin:int = 10004;
        public static const BianShen:int = 10005;
        public static const YuPai:int = 10006;
        public static const ChengZhangLiBao:int = 10007;
        public static const HuoDongLiBao:int = 10009;
        public static const SuperLiBao:int = 10010;
        public static const WuLiDan:int = 11001;
        public static const JueJiDan:int = 11002;
        public static const FaShuDan:int = 11003;
        public static const LingPai:int = 11004;
        public static const skill:int = 12000;
        public static const RedEnvelopes:int = 13000;
        public static const ChangeAttackItem:int = 14000;
        public static const GoldOil:int = 15000;
        public static const ValuableItems:int = 16000;
        public static const Clothes:int = 17000;
        public static const XiHaoPin:int = 18000;
        public static const TongQianDai:int = 19000;
        public static const Power:int = 20000;
        public static const TeShuWuPin:int = 21000;
        public static const LatestFashion:int = 22000;
        public static const Ingot:int = 99998;
        public static const Coin:int = 99999;
        private static var _Types:Object = null;
        private static var _Items:Object = null;
        private static var _Qualitys:Object = null;
        private static var _EquipJob:Object = null;
        private static var _AvatarItemMonster:Object = null;
        private static var _ItemUpgrade:Object = null;
        private static var colors:Object = {1:16777215, 2:2272312, 3:44783, 4:16711935, 5:16773376};

        public function ItemType()
        {
            return;
        }// end function

        public static function getItemAllDatas(param1:int) : Object
        {
            var _loc_5:Array = null;
            var _loc_6:int = 0;
            var _loc_2:* = Items[param1] || ["", 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            var _loc_3:Array = [];
            var _loc_4:String = "";
            if (_loc_2[3] != "")
            {
                _loc_5 = _loc_2[3].split("||");
                if (_loc_5.length > 1)
                {
                    _loc_4 = _loc_5[1].split("|").join("\n");
                }
                _loc_2[3] = _loc_5[0];
                _loc_2[3] = _loc_2[3].split("[-n]").join("\n");
                _loc_3 = _loc_2[3].split("[--]");
                _loc_6 = _loc_3.length;
                while (_loc_6 > 0)
                {
                    
                    _loc_6 = _loc_6 - 1;
                    _loc_3[_loc_6] = _loc_3[_loc_6].replace(reg, regMsg);
                }
                _loc_2[3] = _loc_3[0];
            }
            return {name:_loc_2[0], type_id:_loc_2[1], description:_loc_2[3], descriptionList:_loc_3, quality:_loc_2[4], require_level:_loc_2[5], attack:_loc_2[6], attack_up:_loc_2[7], defense:_loc_2[8], defense_up:_loc_2[9], stunt_attack:_loc_2[10], stunt_attack_up:_loc_2[11], stunt_defense:_loc_2[12], stunt_defense_up:_loc_2[13], magic_attack:_loc_2[14], magic_attack_up:_loc_2[15], magic_defense:_loc_2[16], magic_defense_up:_loc_2[17], health:_loc_2[18], health_up:_loc_2[19], strength:_loc_2[20], agile:_loc_2[21], intellect:_loc_2[22], price:_loc_2[23], ingot:_loc_2[24], item_card_id:_loc_2[25], item_card_num:_loc_2[26], tipProduce:_loc_4};
        }// end function

        private static function regMsg(... args) : String
        {
            args = args[1].split(",");
            var _loc_3:* = args.pop();
            return "<font color=\'#" + _loc_3 + "\'>" + args.join(",") + "</font>";
        }// end function

        public static function getItemSuffix(param1:int) : String
        {
            if (param1 == 1403)
            {
                return "F0";
            }
            if (param1 == 1404)
            {
                return "F1";
            }
            var _loc_2:* = getTypeId(param1);
            if (_loc_2 != YiFu)
            {
                return "";
            }
            var _loc_3:* = getRequireLevel(param1);
            var _loc_4:* = getItemQualityById(param1);
            if (getItemQualityById(param1) >= 3)
            {
                if (_loc_3 < 40)
                {
                    _loc_3 = 1;
                }
                else if (_loc_3 < 60)
                {
                    _loc_3 = 2;
                }
                else if (_loc_3 < 70)
                {
                    _loc_3 = 3;
                }
                else if (_loc_3 < 100)
                {
                    _loc_3 = 4;
                }
                else if (_loc_3 < 110)
                {
                    _loc_3 = 5;
                }
                else if (_loc_3 < 120)
                {
                    _loc_3 = 6;
                }
                else
                {
                    _loc_3 = 6;
                }
                return "T" + _loc_3 + "Q" + 3;
            }
            return "";
        }// end function

        public static function getTownIdByYuPai(param1:int, param2:int) : int
        {
            if (param1 == 347 || param1 == 1197)
            {
                return param2;
            }
            var _loc_3:* = yuPaiObj[param1];
            if (!_loc_3)
            {
                return param2;
            }
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = _loc_3[(_loc_4 - 1)];
            if (param2 <= _loc_5)
            {
                return param2;
            }
            return _loc_5;
        }// end function

        public static function get Types() : Object
        {
            if (_Types == null)
            {
                throw new Error("还未赋值！");
            }
            return _Types;
        }// end function

        public static function set Types(param1:Object) : void
        {
            if (_Types != null)
            {
                throw new Error("非法赋值");
            }
            _Types = param1;
            return;
        }// end function

        public static function get Items() : Object
        {
            if (_Items == null)
            {
                throw new Error("还未赋值！");
            }
            return _Items;
        }// end function

        public static function set Items(param1:Object) : void
        {
            if (_Items != null)
            {
                throw new Error("非法赋值");
            }
            _Items = param1;
            return;
        }// end function

        public static function get Qualitys() : Object
        {
            if (_Qualitys == null)
            {
                throw new Error("还未赋值！");
            }
            return _Qualitys;
        }// end function

        public static function set Qualitys(param1:Object) : void
        {
            if (_Qualitys != null)
            {
                throw new Error("非法赋值");
            }
            _Qualitys = param1;
            return;
        }// end function

        public static function get EquipJob() : Object
        {
            if (_EquipJob == null)
            {
                throw new Error("还未赋值！");
            }
            return _EquipJob;
        }// end function

        public static function set EquipJob(param1:Object) : void
        {
            if (_EquipJob != null)
            {
                throw new Error("非法赋值");
            }
            _EquipJob = param1;
            return;
        }// end function

        public static function get AvatarItemMonster() : Object
        {
            if (_AvatarItemMonster == null)
            {
                throw new Error("还未赋值！");
            }
            return _AvatarItemMonster;
        }// end function

        public static function set AvatarItemMonster(param1:Object) : void
        {
            if (_AvatarItemMonster != null)
            {
                throw new Error("非法赋值");
            }
            _AvatarItemMonster = param1;
            return;
        }// end function

        public static function get ItemUpgrade() : Object
        {
            if (_ItemUpgrade == null)
            {
                throw new Error("还未赋值！");
            }
            return _ItemUpgrade;
        }// end function

        public static function set ItemUpgrade(param1:Object) : void
        {
            if (_ItemUpgrade != null)
            {
                throw new Error("非法赋值");
            }
            _ItemUpgrade = param1;
            return;
        }// end function

        public static function getItemIdByName(param1:String) : int
        {
            var _loc_2:String = null;
            for (_loc_2 in Items)
            {
                
                if (Items[_loc_2][0] == param1)
                {
                    return parseInt(_loc_2);
                }
            }
            return 0;
        }// end function

        public static function getMaxRepeatNum(param1:int) : int
        {
            return Types[param1] ? (Types[param1][1]) : (0);
        }// end function

        public static function getItemQualityById(param1:int) : int
        {
            return (Items[param1] ? (Items[param1][4]) : (0)) || 0;
        }// end function

        public static function getItemQualityByName(param1:String) : int
        {
            var _loc_3:String = null;
            var _loc_2:int = 0;
            for (_loc_3 in Items)
            {
                
                if (Items[_loc_3][0] == param1)
                {
                    _loc_2 = Items[_loc_3][4];
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getItemQualityNameById(param1:int) : String
        {
            return (Items[param1] ? (Qualitys[getItemQualityById(param1)]) : ("")) || "";
        }// end function

        public static function getItemQualityNameByName(param1:String) : String
        {
            var _loc_2:int = 0;
            var _loc_3:String = null;
            for (_loc_3 in Items)
            {
                
                if (Items[_loc_3][0] == param1)
                {
                    _loc_2 = parseInt(_loc_3);
                    break;
                }
            }
            return getItemQualityNameById(_loc_2);
        }// end function

        public static function getRequireLevel(param1:int) : int
        {
            return Items[param1] ? (Items[param1][5]) : (0);
        }// end function

        public static function getTypeId(param1:int) : int
        {
            return Items[param1] ? (Items[param1][1]) : (0);
        }// end function

        public static function getItemAttr(param1:int) : Object
        {
            var _loc_2:* = Items[param1];
            return {attack:_loc_2[6] || 0, attackUp:_loc_2[7] || 0, defense:_loc_2[8] || 0, defenseUp:_loc_2[9] || 0, stuntAttack:_loc_2[10] || 0, stuntAttackUp:_loc_2[11] || 0, stuntDefense:_loc_2[12] || 0, stuntDefenseUp:_loc_2[13] || 0, magicAttack:_loc_2[14] || 0, magicAttackUp:_loc_2[15] || 0, magicDefense:_loc_2[16] || 0, magicDefenseUp:_loc_2[17] || 0, health:_loc_2[18] || 0, healthUp:_loc_2[19] || 0, strength:_loc_2[20] || 0, agile:_loc_2[21] || 0, intellect:_loc_2[22] || 0};
        }// end function

        public static function getEquipJob(param1:int) : Array
        {
            return EquipJob[param1] || [];
        }// end function

        public static function getName(param1:int) : String
        {
            return Items[param1] ? (Items[param1][0]) : ("");
        }// end function

        public static function getDescription(param1:int) : String
        {
            var _loc_2:* = Items[param1] ? (Items[param1][3]) : ("");
            if (_loc_2 != "")
            {
                _loc_2 = _loc_2.replace(reg, regMsg);
            }
            return _loc_2;
        }// end function

        public static function getMonsterId(param1:int) : int
        {
            return AvatarItemMonster[param1] || 0;
        }// end function

        public static function getItemUpgrade(param1:int) : String
        {
            return ItemUpgrade[param1] || "";
        }// end function

        public static function getItemColor(param1:int) : uint
        {
            var _loc_2:* = getItemQualityById(param1);
            return _loc_2 ? (colors[_loc_2]) : (16777215);
        }// end function

        public static function isEquip(param1:int) : Boolean
        {
            return TouKui == param1 || WuQi == param1 || HunQi == param1 || YiFu == param1 || HuFu == param1 || XieZi == param1;
        }// end function

        public static function isMoney(param1:int) : Boolean
        {
            return param1 == Coin || param1 == Ingot;
        }// end function

        public static function isStack(param1:int) : Boolean
        {
            return param1 > 10000;
        }// end function

    }
}
