package com.assist.server
{
    import com.lang.client.com.assist.server.source.*;

    public class SoulType extends Object
    {
        private static const QualityColor:Object = {0:2272312, 1:44783, 2:16711935, 3:16773376, 4:10747904};
        private static const jobType:Object = {1:[SoulTypeDataLang.Jian], 2:[SoulTypeDataLang.Gong], 3:[SoulTypeDataLang.Quan], 4:[SoulTypeDataLang.ChangBing], 5:[SoulTypeDataLang.Zhang]};
        private static const soulData:Object = {1:[{min:100, max:200}, {min:205, max:500}, {min:600, max:600}], 2:[{min:700, max:800}, {min:805, max:1000}, {min:1005, max:1200}, {min:1500, max:1500}], 3:[{min:1200, max:1400}, {min:1405, max:1600}, {min:1605, max:1800}, {min:1805, max:2000}, {min:2500, max:2500}]};
        private static const soulDataP:Object = {1:[{min:0.5, max:1}, {min:1.1, max:2.5}, {min:3, max:3}], 2:[{min:3.5, max:4}, {min:4.1, max:4.6}, {min:4.7, max:6}, {min:8, max:8}], 3:[{min:6, max:7}, {min:7.1, max:8}, {min:8.1, max:9}, {min:9.1, max:10}, {min:12, max:12}]};
        private static const soulForLife:Object = {1:[{min:1000, max:1500}, {min:1550, max:2500}, {min:3500, max:3500}], 2:[{min:3400, max:4000}, {min:4050, max:4600}, {min:4650, max:6000}, {min:8000, max:8000}], 3:[{min:6000, max:7000}, {min:7050, max:8000}, {min:8050, max:9000}, {min:9050, max:10000}, {min:15000, max:15000}]};
        private static const warAttributeData:Object = {1:{dataName:SoulTypeDataLang.Life, qualityColorData:soulForLife, isPercentage:false, info:SoulTypeDataLang.LifeInfo}, 2:{dataName:SoulTypeDataLang.Attack, qualityColorData:soulData, isPercentage:false, info:SoulTypeDataLang.AttackInfo}, 3:{dataName:SoulTypeDataLang.Defense, qualityColorData:soulData, isPercentage:false, info:SoulTypeDataLang.DefenseInfo}, 4:{dataName:SoulTypeDataLang.Spell, qualityColorData:soulData, isPercentage:false, info:SoulTypeDataLang.SpellInfo}, 5:{dataName:SoulTypeDataLang.SpellDef, qualityColorData:soulData, isPercentage:false, info:SoulTypeDataLang.SpellDefInfo}, 6:{dataName:SoulTypeDataLang.Stunt, qualityColorData:soulData, isPercentage:false, info:SoulTypeDataLang.StuntInfo}, 7:{dataName:SoulTypeDataLang.StuntDef, qualityColorData:soulData, isPercentage:false, info:SoulTypeDataLang.StuntDefInfo}, 8:{dataName:SoulTypeDataLang.Hit, qualityColorData:soulDataP, isPercentage:true, info:SoulTypeDataLang.HitInfo}, 9:{dataName:SoulTypeDataLang.Block, qualityColorData:soulDataP, isPercentage:true, info:SoulTypeDataLang.BlockInfo}, 10:{dataName:SoulTypeDataLang.Dodge, qualityColorData:soulDataP, isPercentage:true, info:SoulTypeDataLang.DodgeInfo}, 11:{dataName:SoulTypeDataLang.Crit, qualityColorData:soulDataP, isPercentage:true, info:SoulTypeDataLang.Crit}, 13:{dataName:SoulTypeDataLang.Wreck, qualityColorData:soulDataP, isPercentage:true, info:SoulTypeDataLang.WreckInfo}, 14:{dataName:SoulTypeDataLang.Toughness, qualityColorData:soulDataP, isPercentage:true, info:SoulTypeDataLang.ToughnessInfo}, 15:{dataName:SoulTypeDataLang.Kill, qualityColorData:soulDataP, isPercentage:true, info:SoulTypeDataLang.KillInfo}};
        private static const Type:Object = {1:["剑"], 2:["弓箭"], 3:["拳刃"], 4:["长兵"], 5:["法杖"]};
        private static const Location:Object = {1:["灵件1"], 2:["灵件2"], 3:["灵件3"], 4:["灵件4"], 5:["灵件5"], 6:["灵件6"]};
        private static const AllType:Object = {1:[1, 1, "灵件1"], 2:[1, 2, "灵件2"], 3:[1, 3, "灵件3"], 4:[2, 1, "箭头"], 5:[2, 2, "弓臂"], 6:[2, 3, "弓弦"], 7:[3, 1, "拳刃"], 8:[3, 2, "护手"], 9:[3, 3, "护臂"], 10:[4, 1, "锋刃"], 11:[4, 2, "长柄"], 12:[4, 3, "柄锥"], 13:[5, 1, "杖芯"], 14:[5, 2, "杖杆"], 15:[5, 3, "杖锥"], 16:[1, 4, "灵件4"], 17:[2, 4, "箭头2"], 18:[3, 4, "拳刃2"], 19:[4, 4, "锋刃2"], 20:[5, 4, "杖芯2"], 21:[1, 5, "灵件5"], 22:[2, 5, "弓臂2"], 23:[3, 5, "护手2"], 24:[4, 5, "长柄2"], 25:[5, 5, "杖杆2"], 26:[1, 6, "灵件6"], 27:[2, 6, "弓弦2"], 28:[3, 6, "护臂2"], 29:[4, 6, "柄锥2"], 30:[5, 6, "杖锥2"]};
        private static const Quality:Object = {1:["蓝色"], 2:["紫色"], 3:["金色"]};
        private static var _Soul:Object = null;
        private static const Attribute:Object = {1:[1, 1], 2:[1, 2], 3:[1, 3], 4:[2, 1], 5:[2, 2], 6:[2, 3], 7:[3, 1], 8:[3, 2], 9:[3, 3], 10:[4, 1], 11:[4, 2], 12:[4, 3], 13:[5, 1], 14:[5, 2], 15:[5, 3], 16:[6, 1], 17:[6, 2], 18:[6, 3], 19:[7, 1], 20:[7, 2], 21:[7, 3], 22:[8, 1], 23:[8, 2], 24:[8, 3], 25:[9, 1], 26:[9, 2], 27:[9, 3], 28:[10, 1], 29:[10, 2], 30:[10, 3], 31:[11, 1], 32:[11, 2], 33:[11, 3], 34:[13, 1], 35:[13, 2], 36:[13, 3], 37:[14, 1], 38:[14, 2], 39:[14, 3], 40:[15, 1], 41:[15, 2], 42:[15, 3]};
        public static var ItemToSoul:Object = {3:6, 6:6, 9:6, 12:6, 15:6, 18:6, 21:6, 24:6, 27:6, 30:6, 33:6, 36:6, 39:6, 42:6, 45:6, 48:6, 51:6, 54:6, 57:6, 60:6, 63:6, 66:6, 69:6, 72:6, 75:6, 78:6, 81:6, 84:6, 87:6, 90:6};

        public function SoulType()
        {
            return;
        }// end function

        public static function getJobNameToTypeId(param1:int) : String
        {
            return jobType[param1][0] || "";
        }// end function

        public static function getSoulQualityColor(param1:int) : uint
        {
            var _loc_2:* = getSoulQualityId(param1);
            return QualityColor[_loc_2] || 0;
        }// end function

        public static function getQualityColor(param1:int) : uint
        {
            return QualityColor[param1] || 0;
        }// end function

        public static function warAttributeIdToName(param1:int) : String
        {
            return warAttributeData[param1].dataName || "";
        }// end function

        public static function warAttributeIdToInfo(param1:int) : String
        {
            return warAttributeData[param1].info || "";
        }// end function

        public static function warValueChange(param1:int, param2:Number) : String
        {
            var _loc_3:* = int(param2).toString();
            if (warAttributeData[param1].isPercentage)
            {
                _loc_3 = int(param2 * 10).toString();
            }
            return _loc_3;
        }// end function

        public static function getDataColor(param1:int, param2:int, param3:Number) : Object
        {
            var _loc_9:Object = null;
            var _loc_4:* = warAttributeData[param1].qualityColorData;
            var _loc_5:* = warAttributeData[param1].qualityColorData[param2];
            var _loc_6:* = warAttributeData[param1].qualityColorData[param2].length;
            var _loc_7:int = 5;
            var _loc_8:int = 0;
            while (_loc_8 < _loc_6)
            {
                
                _loc_9 = _loc_5[_loc_8];
                if (param3 >= _loc_9.min && param3 <= _loc_9.max)
                {
                    _loc_7 = _loc_8;
                    break;
                }
                _loc_8++;
            }
            return {color:QualityColor[_loc_7], colorQuelity:_loc_7} || {};
        }// end function

        public static function isItemYellow(param1:Array) : Boolean
        {
            var _loc_4:Object = null;
            var _loc_5:Number = NaN;
            var _loc_6:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1[_loc_3];
                _loc_5 = _loc_4.value / 1000;
                _loc_6 = getDataColor(_loc_4.id, _loc_4.quality, _loc_5);
                if (_loc_6.colorQuelity >= 3)
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        public static function getDataRange(param1:int, param2:int, param3:Number) : String
        {
            var _loc_4:* = warAttributeData[param1].qualityColorData;
            var _loc_5:* = warAttributeData[param1].qualityColorData[param2];
            var _loc_6:Object = {};
            {}.min = _loc_5[0].min;
            _loc_6.max = _loc_5[(_loc_5.length - 1)].max;
            _loc_6.minInfo = warValueChange(param1, _loc_6.min);
            _loc_6.maxInfo = warValueChange(param1, _loc_6.max);
            var _loc_7:String = "";
            if (param3 == _loc_6.max)
            {
                _loc_7 = SoulTypeDataLang.Full;
            }
            else
            {
                _loc_7 = "(" + _loc_6.minInfo + "-" + _loc_6.maxInfo + ")";
            }
            return _loc_7;
        }// end function

        public static function getQualityForIDValue(param1:int, param2:int, param3:int) : int
        {
            var _loc_9:Object = null;
            var _loc_4:* = param3 / 1000;
            var _loc_5:* = warAttributeData[param1].qualityColorData;
            var _loc_6:* = warAttributeData[param1].qualityColorData[param2];
            var _loc_7:* = warAttributeData[param1].qualityColorData[param2].length;
            var _loc_8:int = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_9 = _loc_6[_loc_8];
                if (_loc_9.min <= _loc_4 && _loc_4 <= _loc_9.max)
                {
                    return (_loc_8 + 1);
                }
                _loc_8++;
            }
            return 0;
        }// end function

        public static function get Soul() : Object
        {
            if (_Soul == null)
            {
                throw new Error("还未赋值！");
            }
            return _Soul;
        }// end function

        public static function set Soul(param1:Object) : void
        {
            if (_Soul != null)
            {
                throw new Error("非法赋值");
            }
            _Soul = param1;
            return;
        }// end function

        public static function getTypeName(param1:int) : String
        {
            return Type[param1] ? (Type[param1][0]) : ("");
        }// end function

        public static function getSoulTypeIdByAllTypeId(param1:int) : int
        {
            return AllType[param1] ? (AllType[param1][0]) : (0);
        }// end function

        public static function getSubTypeNameByAllTypeId(param1:int) : String
        {
            return AllType[param1] ? (AllType[param1][2]) : ("");
        }// end function

        public static function getSubTypeName(param1:int, param2:int) : String
        {
            var _loc_3:String = null;
            for (_loc_3 in AllType)
            {
                
                if (AllType[_loc_3][0] == param1 && AllType[_loc_3][1] == param2)
                {
                    return AllType[_loc_3][2];
                }
            }
            return "";
        }// end function

        public static function getQualityName(param1:int) : String
        {
            return Quality[param1] ? (Quality[param1][0]) : ("");
        }// end function

        public static function getSoulSubTypeId(param1:int) : int
        {
            return Soul[param1] ? (Soul[param1][0]) : (0);
        }// end function

        public static function getSoulQualityId(param1:int) : int
        {
            return Soul[param1] ? (Soul[param1][1]) : (0);
        }// end function

        public static function getSoulName(param1:int) : String
        {
            var _loc_2:* = Soul[param1] ? (Soul[param1][2]) : ("");
            _loc_2 = _loc_2.split("_")[0];
            return _loc_2;
        }// end function

        public static function getSoulContent(param1:int) : String
        {
            return Soul[param1] ? (Soul[param1][3]) : ("");
        }// end function

        public static function getSoulSalePrice(param1:int) : int
        {
            return Soul[param1] ? (Soul[param1][4]) : (0);
        }// end function

        public static function getWarAttributeTypeId(param1:int) : int
        {
            return Attribute[param1] ? (Attribute[param1][0]) : (0);
        }// end function

        public static function getAttrQualityId(param1:int) : int
        {
            return Attribute[param1] ? (Attribute[param1][1]) : (0);
        }// end function

        public static function getSubTypeIdListByLocationId(param1:int) : Array
        {
            var _loc_3:String = null;
            var _loc_2:Array = [];
            for (_loc_3 in AllType)
            {
                
                if (AllType[_loc_3][1] == param1)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public static function getSoulIdList(param1:int, param2:int) : Array
        {
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_3:* = getSubTypeIdListByLocationId(param2);
            var _loc_4:* = _loc_3.length;
            var _loc_5:Array = [];
            for (_loc_7 in Soul)
            {
                
                _loc_6 = 0;
                while (_loc_6 < _loc_4)
                {
                    
                    if (Soul[_loc_7][0] == _loc_3[_loc_6] && Soul[_loc_7][1] == param1)
                    {
                        _loc_5.push({soulId:_loc_7, qualityId:param1});
                    }
                    _loc_6++;
                }
            }
            return _loc_5;
        }// end function

        public static function getItemNumBySoulId(param1:int) : int
        {
            return ItemToSoul[param1] || 0;
        }// end function

    }
}
