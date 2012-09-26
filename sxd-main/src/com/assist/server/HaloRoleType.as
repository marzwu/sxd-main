package com.assist.server
{

    public class HaloRoleType extends Object
    {
        private static const Roles:Object = {45:[MuTingTao, "大魔王", 1, 5010], 44:[HuaShiYan, "画师燕", 6, 5020], 47:[ZhiLinXianRen, "志林仙人", 2, 5025], 42:[DaDaDaoZhang, "达达道长", 6, 5030], 43:[ShuShengXian, "书生贤", 6, 5040], 46:[JiaLinXianRen, "加林仙人", 3, 5050], 56:[HaiRen, "海人", 1, 5060], 57:[AFei, "阿飞", 2, 5070]};
        public static const MuTingTao:String = "MuTingTao";
        public static const HuaShiYan:String = "HuaShiYan";
        public static const ZhiLinXianRen:String = "ZhiLinXianRen";
        public static const DaDaDaoZhang:String = "DaDaDaoZhang";
        public static const ShuShengXian:String = "ShuShengXian";
        public static const JiaLinXianRen:String = "JiaLinXianRen";
        public static const HaiRen:String = "HaiRen";
        public static const AFei:String = "AFei";
        public static const ButtleList:Array = ["MuTingTao", "HuaShiYan", "ZhiLinXianRen", "DaDaDaoZhang", "ShuShengXian", "JiaLinXianRen", "HaiRen", "AFei"];
        public static const DramaData:Object = {42:{start:"ZhouNianJuQing7.xml", end:"ZhouNianJuQing8.xml"}, 43:{start:"ZhouNianJuQing9.xml", end:"ZhouNianJuQing10.xml"}, 44:{start:"ZhouNianJuQing3.xml", end:"ZhouNianJuQing4.xml"}, 45:{start:"ZhouNianJuQing1.xml", end:"ZhouNianJuQing2.xml"}, 46:{start:"ZhouNianJuQing11.xml", end:"ZhouNianJuQing12.xml"}, 47:{start:"ZhouNianJuQing5.xml", end:"ZhouNianJuQing6.xml"}, 56:{start:"ZhouNianJuQing13.xml", end:"ZhouNianJuQing14.xml"}, 57:{start:"ZhouNianJuQing15.xml", end:"ZhouNianJuQing16.xml"}};

        public function HaloRoleType()
        {
            return;
        }// end function

        public static function getRoleIdByMix(param1:String, param2:String) : int
        {
            var _loc_3:* = param2 + param1;
            return getRoleId(_loc_3);
        }// end function

        public static function getRoleId(param1:String) : int
        {
            var _loc_2:Object = null;
            for (_loc_2 in Roles)
            {
                
                if (Roles[_loc_2][0] == param1)
                {
                    return _loc_2 as int;
                }
            }
            return 0;
        }// end function

        public static function getRoleSign(param1:int) : String
        {
            if (Roles[param1])
            {
                return Roles[param1][0];
            }
            return "";
        }// end function

        public static function getRoleSigns(param1:Array) : Array
        {
            var _loc_3:Object = null;
            var _loc_4:String = null;
            var _loc_2:Array = [];
            for each (_loc_3 in param1)
            {
                
                _loc_4 = getRoleSign(_loc_3 as int);
                if (_loc_4)
                {
                    _loc_2.push(_loc_4);
                }
            }
            return _loc_2;
        }// end function

        public static function getRoleName(param1:int) : String
        {
            return Roles[param1] ? (Roles[param1][1]) : ("");
        }// end function

        public static function getRoleNameByRoleSign(param1:String) : String
        {
            var _loc_3:Array = null;
            var _loc_2:String = "";
            for each (_loc_3 in Roles)
            {
                
                if (_loc_3[0] == param1)
                {
                    return _loc_3[1];
                }
            }
            return _loc_2;
        }// end function

        public static function getRoleSignByRoleName(param1:String) : String
        {
            var _loc_2:Array = null;
            for each (_loc_2 in Roles)
            {
                
                if (_loc_2[1] == param1)
                {
                    return _loc_2[0];
                }
            }
            return "";
        }// end function

        public static function getJobIdByRoleId(param1:int) : int
        {
            return Roles[param1] ? (Roles[param1][2]) : (0);
        }// end function

        public static function getLockByRoleId(param1:int) : int
        {
            return Roles[param1] ? (Roles[param1][3]) : (0);
        }// end function

        public static function getRankByLock(param1:int) : int
        {
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_2:* = ButtleList.length;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = ButtleList[_loc_4];
                _loc_6 = getRoleId(_loc_5);
                _loc_7 = getLockByRoleId(_loc_6);
                if (_loc_7 == param1)
                {
                    _loc_3 = _loc_4 + 1;
                    break;
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public static function getStartDrama(param1:int) : String
        {
            return DramaData[param1].start;
        }// end function

        public static function getEndDrama(param1:int) : String
        {
            return DramaData[param1].end;
        }// end function

    }
}
