package com.assist.server
{
    import com.haloer.data.*;

    public class TownType extends Object
    {
        public static var MaxOldMap:int = 29;
        private static var _Towns:Object;
        public static const XiaoYuCun:String = "XiaoYuCun";
        public static const SuZhou:String = "SuZhou";
        public static const JingCheng:String = "JingCheng";
        public static const ShuShanCheng:String = "ShuShanCheng";
        public static const KunLunCheng:String = "KunLunCheng";
        public static const GuDaoCheng:String = "GuDaoCheng";
        public static const YuXuCheng:String = "YuXuCheng";
        public static const JiMo:String = "JiMo";
        public static const BossQingTianMu:String = "BossQingTianMu";
        public static const BossChiYanShou:String = "BossChiYanShou";
        public static const BossDaoBaTu:String = "BossDaoBaTu";
        public static const LiShuShan:String = "LiShuShan";
        public static const YangZhouCheng:String = "YangZhouCheng";
        public static const YueYaCheng:String = "YueYaCheng";
        public static const JiHuiSuo:String = "JiHuiSuo";
        public static const BaiHuFactionWar:String = "BaiHuFactionWar";
        public static const XuanWuFactionWar:String = "XuanWuFactionWar";
        public static const ZhuQueFactionWar:String = "ZhuQueFactionWar";
        public static const QingLongFactionWar:String = "QingLongFactionWar";
        public static const PengLaiCheng:String = "PengLaiCheng";
        public static const ChangAnCheng:String = "ChangAnCheng";
        public static const TaiYiCheng:String = "TaiYiCheng";
        public static const GaoLiCheng:String = "GaoLiCheng";
        public static const MoDu:String = "MoDu";
        public static const BaiLuShuYuan:String = "BaiLuShuYuan";
        public static const MoWangShiLian:String = "MoWangShiLian";
        public static const DaLiCheng:String = "DaLiCheng";
        public static const JiuKongWuJie:String = "JiuKongWuJie";
        public static const DianFengDuiJue:String = "DianFengDuiJue";
        public static const WoLongCheng:String = "WoLongCheng";
        public static const DaLi:String = "DaLi";
        public static const ZhengZhou:String = "ZhengZhou";
        public static const MultiMission:String = "MultiMission";
        public static const HorseRace:String = "HorseRace";
        public static const DailyQuest:String = "DailyQuest";
        public static const Sport:String = "Sport";
        public static const OfflineExp:String = "OfflineExp";
        public static const PreventIndulge:String = "PreventIndulge";
        public static const OnlineGift:String = "OnlineGift";
        public static const CampWar:String = "CampWar";
        public static const SendIngot:String = "SendIngot";
        public static const CampSalary:String = "CampSalary";
        public static const All:String = "All";
        private static var _lock:int = 0;
        private static var _campSign:String = "";
        public static const AllTown:Boolean = true;

        public function TownType()
        {
            return;
        }// end function

        public static function get Towns() : Object
        {
            if (_Towns == null)
            {
                throw new Error("还未赋值！");
            }
            return _Towns;
        }// end function

        public static function set Towns(param1:Object) : void
        {
            if (_Towns != null)
            {
                throw new Error("非法赋值");
            }
            _Towns = param1;
            return;
        }// end function

        public static function set lock(param1:int) : void
        {
            _lock = param1;
            return;
        }// end function

        public static function set campSign(param1:String) : void
        {
            _campSign = param1;
            return;
        }// end function

        public static function getId(param1:String) : int
        {
            var _loc_3:Object = null;
            var _loc_2:int = 0;
            for (_loc_3 in Towns)
            {
                
                if (Towns[_loc_3][0] == param1)
                {
                    _loc_2 = _loc_3 as int;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getIdByTownNPCId(param1:int) : int
        {
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            var _loc_4:Object = null;
            for (_loc_2 in Towns)
            {
                
                _loc_3 = Towns[_loc_2][2];
                for each (_loc_4 in _loc_3)
                {
                    
                    if (param1 == _loc_4[0])
                    {
                        return _loc_2 as int;
                    }
                }
            }
            return 0;
        }// end function

        public static function getSign(param1:int) : String
        {
            return Towns[param1] ? (Towns[param1][0]) : ("");
        }// end function

        public static function getName(param1:int) : String
        {
            return Towns[param1] ? (Towns[param1][1]) : ("");
        }// end function

        public static function getNameBySign(param1:String) : String
        {
            var _loc_2:* = getId(param1);
            return getName(_loc_2);
        }// end function

        public static function getLock(param1:int) : int
        {
            return Towns[param1] ? (Towns[param1][3]) : (0);
        }// end function

        public static function getOpenedTownSigns(param1:Boolean = false) : Array
        {
            var _loc_2:* = getOpenedTownIds(param1);
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2[_loc_4] = Towns[_loc_2[_loc_4]][0];
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public static function getNewOpenedTownSigns() : Array
        {
            var _loc_1:* = new Array();
            var _loc_2:* = getOpenedTownIds(true);
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2[_loc_4] > MaxOldMap)
                {
                    _loc_1.push(Towns[_loc_2[_loc_4]][0]);
                }
                _loc_4++;
            }
            return _loc_1;
        }// end function

        public static function getOldOpenedTownSigns() : Array
        {
            var _loc_1:* = new Array();
            var _loc_2:* = getOpenedTownIds(true);
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2[_loc_4] <= MaxOldMap)
                {
                    _loc_1.push(Towns[_loc_2[_loc_4]][0]);
                }
                _loc_4++;
            }
            return _loc_1;
        }// end function

        public static function getOpenedTownIds(param1:Boolean = false) : Array
        {
            var _loc_7:Object = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:Object = null;
            var _loc_12:int = 0;
            var _loc_2:Array = [];
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:* = TownType.getId(_campSign);
            var _loc_6:* = TownType.getLock(_loc_5);
            for (_loc_7 in Towns)
            {
                
                _loc_10 = _loc_7 as int;
                _loc_11 = Towns[_loc_10];
                _loc_12 = _loc_11[3];
                if (param1 == false && _loc_12 == _loc_6 && _loc_5 != _loc_10)
                {
                    continue;
                }
                if (_loc_12 <= _lock && isTownById(_loc_10))
                {
                    _loc_2.push({id:_loc_10, lock:_loc_12});
                }
            }
            _loc_2.sortOn("lock", Array.NUMERIC);
            _loc_8 = _loc_2.length;
            _loc_9 = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_2[_loc_9] = _loc_2[_loc_9]["id"];
                _loc_9++;
            }
            return _loc_2;
        }// end function

        public static function getOpenedTownInfo() : Array
        {
            var _loc_2:Array = null;
            var _loc_1:Array = [];
            for each (_loc_2 in Towns)
            {
                
                if (_loc_2[3] > _lock || isTownBySign(_loc_2[0]) == false)
                {
                    continue;
                }
                _loc_1.push({name:_loc_2[0], info:_loc_2[4], level:""});
            }
            return _loc_1;
        }// end function

        public static function getMaxTownId() : int
        {
            var _loc_5:Object = null;
            var _loc_6:int = 0;
            var _loc_7:Object = null;
            var _loc_8:int = 0;
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:* = TownType.getId(_campSign);
            var _loc_4:* = TownType.getLock(_loc_3);
            for (_loc_5 in Towns)
            {
                
                _loc_6 = _loc_5 as int;
                _loc_7 = Towns[_loc_6];
                _loc_8 = _loc_7[3];
                if (_loc_8 == _loc_4 && _loc_3 != _loc_6)
                {
                    continue;
                }
                if (_loc_8 <= _lock && _loc_8 > _loc_1)
                {
                    _loc_1 = _loc_8;
                    _loc_2 = _loc_6;
                }
            }
            return _loc_2;
        }// end function

        public static function getPrevTownIdByTownId(param1:int) : int
        {
            var _loc_7:Object = null;
            var _loc_8:Object = null;
            var _loc_9:int = 0;
            var _loc_2:* = getLock(param1);
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:* = TownType.getId(_campSign);
            var _loc_6:* = TownType.getLock(_loc_5);
            for (_loc_7 in Towns)
            {
                
                param1 = _loc_7 as int;
                _loc_8 = Towns[param1];
                _loc_9 = _loc_8[3];
                if (_loc_9 == _loc_6 && _loc_5 != param1)
                {
                    continue;
                }
                if (_loc_9 < _loc_2 && _loc_9 > _loc_3)
                {
                    _loc_3 = _loc_9;
                    _loc_4 = param1;
                }
            }
            return _loc_4;
        }// end function

        public static function getNextTownIdByTownId(param1:int) : int
        {
            var _loc_7:Object = null;
            var _loc_8:Object = null;
            var _loc_9:int = 0;
            var _loc_2:* = getLock(param1);
            var _loc_3:int = 10000000;
            var _loc_4:int = 0;
            var _loc_5:* = TownType.getId(_campSign);
            var _loc_6:* = TownType.getLock(_loc_5);
            for (_loc_7 in Towns)
            {
                
                param1 = _loc_7 as int;
                _loc_8 = Towns[param1];
                _loc_9 = _loc_8[3];
                if (_loc_9 == _loc_6 && _loc_5 != param1)
                {
                    continue;
                }
                if (_loc_9 > _loc_2 && _loc_9 < _loc_3)
                {
                    _loc_3 = _loc_9;
                    _loc_4 = param1;
                }
            }
            return _loc_4;
        }// end function

        public static function isTownBySign(param1:String) : Boolean
        {
            return param1 != BossChiYanShou && param1 != BossQingTianMu && param1 != BossDaoBaTu && param1 != JiHuiSuo && param1 != BaiHuFactionWar && param1 != XuanWuFactionWar && param1 != ZhuQueFactionWar && param1 != QingLongFactionWar;
        }// end function

        public static function isTownById(param1:int) : Boolean
        {
            return isTownBySign(getSign(param1));
        }// end function

        public static function isOpened(param1:String) : Boolean
        {
            var _loc_2:* = getId(param1);
            var _loc_3:* = getLock(_loc_2);
            return _lock >= _loc_3;
        }// end function

        public static function isOpenedByTownId(param1:int) : Boolean
        {
            var _loc_2:* = getLock(param1);
            return _lock >= _loc_2;
        }// end function

        public static function getTownIdByLock(param1:int) : int
        {
            var _loc_3:Object = null;
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_2:int = 0;
            for (_loc_3 in Towns)
            {
                
                _loc_4 = Towns[_loc_3];
                _loc_5 = _loc_4[3];
                if (_loc_5 <= param1 && isTownById(_loc_3 as int))
                {
                    _loc_2 = Math.max(_loc_3 as int, _loc_2);
                }
            }
            return _loc_2;
        }// end function

        private static function getTownInfo(param1:int) : Array
        {
            var _loc_2:* = Towns[param1];
            if (!_loc_2)
            {
                throw new Error("不存在townId为的 " + param1 + " 城镇！");
            }
            return _loc_2;
        }// end function

        public static function getNPCSignByTownNPCId(param1:int) : String
        {
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            var _loc_4:String = null;
            for each (_loc_2 in Towns)
            {
                
                _loc_3 = _loc_2[2];
                for (_loc_4 in _loc_3)
                {
                    
                    if (_loc_3[_loc_4][0] == param1)
                    {
                        return _loc_4;
                    }
                }
            }
            return "";
        }// end function

        public static function getTownNPCId(param1:int, param2:String) : int
        {
            var _loc_3:* = getTownInfo(param1);
            if (!_loc_3[2][param2])
            {
                throw new Error(_loc_3[1] + "不存在npc:" + param2);
            }
            return _loc_3[2][param2][0];
        }// end function

        public static function getTownNPCIdByFunc(param1:int, param2:int) : int
        {
            var _loc_5:String = null;
            var _loc_3:* = getTownInfo(param1);
            var _loc_4:int = 0;
            for (_loc_5 in _loc_3[2])
            {
                
                if (NPCType.getFunctionBySign(_loc_5) == param2)
                {
                    _loc_4 = _loc_3[2][_loc_5][0];
                    break;
                }
            }
            return _loc_4;
        }// end function

        public static function hasNPCInTown(param1:int, param2:String) : Boolean
        {
            var _loc_3:* = getTownInfo(param1);
            return _loc_3[2][param2];
        }// end function

        public static function getNPCSign(param1:int, param2:int) : String
        {
            var _loc_5:String = null;
            var _loc_3:* = getTownInfo(param1);
            var _loc_4:String = "";
            for (_loc_5 in _loc_3[2])
            {
                
                if (_loc_3[2][_loc_5][0] == param2)
                {
                    _loc_4 = _loc_5;
                }
            }
            if (_loc_4 == "")
            {
                throw new Error(_loc_3[1] + "不存在towNPCId:" + param2);
            }
            return _loc_4;
        }// end function

        public static function getNPCList(param1:int) : Object
        {
            var _loc_5:String = null;
            var _loc_2:Object = {};
            var _loc_3:* = getTownInfo(param1);
            var _loc_4:* = _loc_3[2];
            for (_loc_5 in _loc_4)
            {
                
                if (_loc_2[_loc_5] == null)
                {
                    _loc_2[_loc_5] = {};
                }
                oObject.list(_loc_4[_loc_5], _loc_2[_loc_5], ["id", "x", "y", "lock"]);
                _loc_2[_loc_5]["name"] = NPCType.getNameBySign(_loc_5);
                _loc_2[_loc_5]["type"] = NPCType.getFunctionBySign(_loc_5);
            }
            return _loc_2;
        }// end function

    }
}
