package com.assist.server
{
    import com.assist.server.source.*;
    import com.lang.client.com.datas.*;

    public class NineRegionsType extends Object
    {
        public static const MaxLevel:int = 3;
        public static const openLevel:int = 101;
        public static const TeamFull:int = 3;
        private static var nrName:Array;

        public function NineRegionsType()
        {
            return;
        }// end function

        public static function getNames() : Array
        {
            var _loc_3:Array = null;
            if (nrName)
            {
                return nrName;
            }
            nrName = new Array();
            var _loc_1:* = NineRegionsTypeData.NineRegions;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = _loc_1[_loc_2];
                nrName.push(_loc_3[1]);
                _loc_2++;
            }
            return nrName;
        }// end function

        public static function getNameByIdx(param1:int) : String
        {
            var _loc_4:Array = null;
            var _loc_2:* = NineRegionsTypeData.NineRegions;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4[0] == param1)
                {
                    return _loc_4[1];
                }
                _loc_3++;
            }
            return "";
        }// end function

        public static function getNextLvByIdx(param1:int) : int
        {
            var _loc_4:Array = null;
            var _loc_2:* = NineRegionsTypeData.NineRegions;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4[0] > param1)
                {
                    return _loc_4[2];
                }
                _loc_3++;
            }
            return 999;
        }// end function

        public static function getBlessNameByIdx(param1:int) : String
        {
            var _loc_4:Array = null;
            var _loc_2:* = NineRegionsTypeData.NineRegions;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4[0] == param1)
                {
                    return _loc_4[3];
                }
                _loc_3++;
            }
            return "";
        }// end function

        public static function getBlessAddValue(param1:int, param2:int) : int
        {
            var _loc_6:Array = null;
            var _loc_3:* = NineRegionsTypeData.NineRegions;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                _loc_6 = _loc_3[_loc_5];
                if (_loc_6[4] == param1)
                {
                    switch(param2)
                    {
                        case 3:
                        {
                            _loc_4 = _loc_6[5];
                            break;
                        }
                        case 4:
                        {
                            _loc_4 = _loc_6[6];
                            break;
                        }
                        case 5:
                        {
                            _loc_4 = _loc_6[7];
                            break;
                        }
                        case 6:
                        {
                            _loc_4 = _loc_6[8];
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public static function getMonsterId(param1:int, param2:int) : int
        {
            var _loc_5:Array = null;
            var _loc_3:* = NineRegionsTypeData.NineRegionsMonster;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4];
                if (_loc_5[0] == param1 && _loc_5[1] == param2)
                {
                    return _loc_5[2];
                }
                _loc_4++;
            }
            return 0;
        }// end function

        public static function getMonsterSignById(param1:int) : String
        {
            var _loc_4:Array = null;
            var _loc_2:* = NineRegionsTypeData.NineRegionsMonster;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4[2] == param1)
                {
                    return _loc_4[3];
                }
                _loc_3++;
            }
            return "";
        }// end function

        public static function getMonsterNameById(param1:int) : String
        {
            var _loc_4:Array = null;
            var _loc_2:* = NineRegionsTypeData.NineRegionsMonster;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4[2] == param1)
                {
                    return _loc_4[4];
                }
                _loc_3++;
            }
            return "";
        }// end function

        public static function getAward(param1:int, param2:int) : Array
        {
            var _loc_6:Array = null;
            var _loc_3:Array = [0, 0];
            var _loc_4:* = NineRegionsTypeData.NineRegionsMonster;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_6 = _loc_4[_loc_5];
                if (_loc_6[0] == param1 && _loc_6[1] == param2)
                {
                    _loc_3 = [_loc_6[6], _loc_6[7]];
                }
                _loc_5++;
            }
            return _loc_3;
        }// end function

        public static function getMonsterTalkById(param1:int) : Array
        {
            var _loc_4:Array = null;
            var _loc_5:String = null;
            var _loc_2:* = NineRegionsTypeData.NineRegionsMonster;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4[2] == param1)
                {
                    _loc_5 = _loc_4[8];
                }
                _loc_3++;
            }
            return _loc_5.split("|");
        }// end function

        public static function getSoulAdd(param1:int, param2:int, param3:int = 0) : Array
        {
            var _loc_7:Array = null;
            var _loc_8:int = 0;
            var _loc_4:Array = ["", 0, 0];
            var _loc_5:* = NineRegionsTypeData.NineRegions;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                _loc_7 = _loc_5[_loc_6];
                if (_loc_7[4] == param1 && param3 >= _loc_7[0])
                {
                    if (param2 >= 3)
                    {
                        _loc_8 = _loc_7[5 + param2 - 3];
                        if (param1 == 8 || param1 == 9 || param1 == 11 || param1 == 13)
                        {
                            _loc_8 = _loc_8 * 10;
                        }
                        var _loc_9:* = [_loc_7[3], _loc_8, _loc_7[0]];
                        _loc_4 = [_loc_7[3], _loc_8, _loc_7[0]];
                        return _loc_9;
                    }
                }
                _loc_6++;
            }
            return _loc_4;
        }// end function

        public static function getHiddenInfoById(param1:int) : Array
        {
            var _loc_4:Array = null;
            var _loc_2:* = NineRegionsTypeData.HiddenLevel;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4[0] == param1)
                {
                    return [_loc_4[1], _loc_4[2], _loc_4[3], _loc_4[4]];
                }
                _loc_3++;
            }
            return ["", 0, 0, ""];
        }// end function

        public static function coinsString(param1:Number) : String
        {
            if (param1 >= 1000000000)
            {
                return int(param1 / 100000000) + NineRegionsDataLang.Yi;
            }
            if (param1 >= 100000)
            {
                return int(param1 / 10000) + NineRegionsDataLang.Wang;
            }
            return param1 + "";
        }// end function

    }
}
