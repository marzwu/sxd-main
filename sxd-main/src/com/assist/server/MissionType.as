package com.assist.server
{
    import com.*;
    import com.adobe.serialization.json.*;
    import com.assist.*;
    import com.haloer.net.*;
    import com.lang.client.com.assist.server.source.*;
    import flash.geom.*;

    public class MissionType extends Object
    {
        public static const XianLingDao:String = "XianLingDao";
        public static const ShiLiPo:String = "ShiLiPo";
        public static const ChenXiDong:String = "ChenXiDong";
        public static const YinLongKu:String = "YinLongKu";
        public static const ZhuYinShan:String = "ZhuYinShan";
        public static const LuanZangGang:String = "LuanZangGang";
        public static const YouHuaLin:String = "YouHuaLin";
        public static const QingQiuShan:String = "QingQiuShan";
        public static const HuangGong:String = "HuangGong";
        public static const XuYuHuanJing_1:String = "XuYuHuanJing_1";
        public static const ZangJianGu_1:String = "ZangJianGu_1";
        public static const FengShenLing_1:String = "FengShenLing_1";
        public static const XuYuHuanJing_2:String = "XuYuHuanJing_2";
        public static const ZangJianGu_2:String = "ZangJianGu_2";
        public static const FengShenLing_2:String = "FengShenLing_2";
        public static const LieYanDong:String = "LieYanDong";
        public static const LingShan:String = "LingShan";
        public static const LianYaoTa:String = "LianYaoTa";
        public static const DaMoHuangCheng:String = "DaMoHuangCheng";
        public static const YuDuFeng:String = "YuDuFeng";
        public static const XuanMingJie:String = "XuanMingJie";
        public static const ShuiXiaGongDian:String = "ShuiXiaGongDian";
        public static const YouMingDiFu:String = "YouMingDiFu";
        public static const XuTianDian:String = "XuTianDian";
        public static const ShuShanMiDao:String = "ShuShanMiDao";
        public static const DaLieGu:String = "DaLieGu";
        public static const FuSangShenShu:String = "FuSangShenShu";
        public static const BiWuChang:String = "BiWuChang";
        public static const ZuiHuaYin:String = "ZuiHuaYin";
        public static const LuoGongDian:String = "LuoGongDian";
        public static const KunYuZhiFu:String = "KunYuZhiFu";
        public static const BingJingHe:String = "BingJingHe";
        public static const HuoYanShan:String = "HuoYanShan";
        public static const XuanJingSi:String = "XuanJingSi";
        public static const DieShuiYa:String = "DieShuiYa";
        public static const TianJing:String = "TianJing";
        public static const DongYing:String = "DongYing";
        public static const ShuiLuDaoChang:String = "ShuiLuDaoChang";
        public static const NaiHeQiao:String = "NaiHeQiao";
        public static const QinShiHuangLing:String = "QinShiHuangLing";
        public static const ManHuangCongLin:String = "ManHuangCongLin";
        public static const TianCangCaoYuan:String = "TianCangCaoYuan";
        public static const GuChengFeiXu:String = "GuChengFeiXu";
        public static const GaoLiWangGong:String = "GaoLiWangGong";
        public static const HeiAnMuFu:String = "HeiAnMuFu";
        public static const HeiAnHuangCheng:String = "HeiAnHuangCheng";
        public static const MoDuAnXiang:String = "MoDuAnXiang";
        public static const XiuLuoTa:String = "XiuLuoTa";
        public static const ShenMoZhanChang:String = "ShenMoZhanChang";
        public static const BeiLin:String = "BeiLin";
        public static const ZhenLongQiJu:String = "ZhenLongQiJu";
        public static const ShuiMoDanQing:String = "ShuiMoDanQing";
        public static const XingYueMiGong:String = "XingYueMiGong";
        public static const ManZuShengDi:String = "ManZuShengDi";
        public static const ShenMoZhiJing:String = "ShenMoZhiJing";
        public static const JiuChongXianChi:String = "JiuChongXianChi";
        public static const JiuChongYunXiao:String = "JiuChongYunXiao";
        public static const JiuChongLongDian:String = "JiuChongLongDian";
        private static var _Sections:Object = null;
        private static var _Missions:Object = null;
        private static const Scenes:Object = {};
        private static var _MissionItems:Object = null;
        private static var Indexes:Object = {1:"一", 2:"二", 3:"三", 4:"四", 5:"五", 6:"六", 7:"七", 8:"八", 9:"九", 10:"十"};
        private static const NORMAL:int = 0;
        private static const HERO:int = 1;
        private static const BOSS:int = 2;
        private static var _lock:int = 0;
        private static var _missionList:Object = {};
        private static var _missions:Object = {};

        public function MissionType()
        {
            return;
        }// end function

        public static function get Sections() : Object
        {
            if (_Sections == null)
            {
                throw new Error("还未赋值！");
            }
            return _Sections;
        }// end function

        public static function set Sections(param1:Object) : void
        {
            if (_Sections != null)
            {
                throw new Error("非法赋值");
            }
            _Sections = param1;
            return;
        }// end function

        public static function get Missions() : Object
        {
            if (_Missions == null)
            {
                throw new Error("还未赋值！");
            }
            return _Missions;
        }// end function

        public static function set Missions(param1:Object) : void
        {
            if (_Missions != null)
            {
                throw new Error("非法赋值");
            }
            _Missions = param1;
            return;
        }// end function

        public static function get MissionItems() : Object
        {
            if (_MissionItems == null)
            {
                throw new Error("还未赋值！");
            }
            return _MissionItems;
        }// end function

        public static function set MissionItems(param1:Object) : void
        {
            if (_MissionItems != null)
            {
                throw new Error("非法赋值");
            }
            _MissionItems = param1;
            return;
        }// end function

        public static function set lock(param1:int) : void
        {
            _lock = param1;
            return;
        }// end function

        public static function getSectionSign(param1:int) : String
        {
            return Sections[param1] ? (Sections[param1][0]) : ("");
        }// end function

        public static function getSectionIdByMissionId(param1:int) : int
        {
            return Missions[param1] ? (Missions[param1][0]) : (0);
        }// end function

        public static function getSectionSignByMissionId(param1:int) : String
        {
            var _loc_2:* = getSectionIdByMissionId(param1);
            return getSectionSign(_loc_2).replace(/(_\d+)+$""(_\d+)+$/, "");
        }// end function

        public static function getTownIdBySectionId(param1:int) : int
        {
            return Sections[param1] ? (Sections[param1][2]) : (0);
        }// end function

        public static function getTownIdByMissionId(param1:int) : int
        {
            var _loc_2:* = getSectionIdByMissionId(param1);
            return getTownIdBySectionId(_loc_2);
        }// end function

        public static function getSectionName(param1:int) : String
        {
            return Sections[param1] ? (Sections[param1][3]) : ("");
        }// end function

        public static function getSectionNameBySign(param1:String) : String
        {
            var _loc_2:Object = null;
            for each (_loc_2 in Sections)
            {
                
                if (_loc_2[0] == param1)
                {
                    return _loc_2[3];
                }
            }
            return "";
        }// end function

        public static function getMissionSign(param1:int) : String
        {
            return getSectionSignByMissionId(param1);
        }// end function

        public static function getMissionLock(param1:int) : int
        {
            return Missions[param1] ? (Missions[param1][1]) : (0);
        }// end function

        public static function getMissionPower(param1:int) : int
        {
            return Missions[param1] ? (Missions[param1][2]) : (0);
        }// end function

        public static function getMissionAwardCoins(param1:int) : int
        {
            return Missions[param1] ? (Missions[param1][3]) : (0);
        }// end function

        public static function getMissionAwardSkill(param1:int) : int
        {
            return Missions[param1] ? (Missions[param1][4]) : (0);
        }// end function

        public static function getMissionAwardExp(param1:int) : int
        {
            return Missions[param1] ? (Missions[param1][5]) : (0);
        }// end function

        public static function getMissionMonsterId(param1:int) : int
        {
            return Missions[param1] ? (Missions[param1][6]) : (0);
        }// end function

        public static function getMissionName(param1:int) : String
        {
            return Missions[param1] ? (Missions[param1][7]) : ("");
        }// end function

        public static function isOpenedByMissionId(param1:int) : Boolean
        {
            var _loc_2:* = getMissionLock(param1);
            return _lock >= _loc_2;
        }// end function

        public static function getLocalMissionName(param1:int) : String
        {
            var _loc_2:* = Missions[param1] ? (Missions[param1][7]) : ("");
            var _loc_3:* = /(\d+)""(\d+)/.exec(_loc_2);
            if (_loc_3 && _loc_3.length > 1)
            {
                _loc_2 = _loc_2.replace(_loc_3[1], numberToChs(_loc_3[1]));
            }
            return _loc_2;
        }// end function

        public static function getMissionType(param1:int) : int
        {
            return Missions[param1] ? (Missions[param1][8]) : (0);
        }// end function

        public static function isNormalMission(param1:int) : Boolean
        {
            return getMissionType(param1) == NORMAL;
        }// end function

        public static function isHeroMission(param1:int) : Boolean
        {
            return getMissionType(param1) == HERO;
        }// end function

        public static function isBossMission(param1:int) : Boolean
        {
            return Missions[param1] ? (Missions[param1][9] == 1) : (false);
        }// end function

        public static function getMissionAwardItems(param1:int) : Array
        {
            return MissionItems[param1] ? (MissionItems[param1]) : ([]);
        }// end function

        public static function getMissionOrder(param1:int) : int
        {
            var _loc_2:* = getMissionName(param1);
            return parseInt(_loc_2.replace(/[^\d]""[^\d]/g, ""));
        }// end function

        public static function getSectionIdsByTownId(param1:int) : Array
        {
            var _loc_3:String = null;
            var _loc_4:int = 0;
            var _loc_2:Array = [];
            for (_loc_3 in Sections)
            {
                
                _loc_4 = Sections[_loc_3][2];
                if (_loc_4 == param1)
                {
                    _loc_2.push(parseInt(_loc_3));
                }
            }
            return _loc_2;
        }// end function

        public static function getMissionIdsByTownId(param1:int) : Array
        {
            var _loc_4:Object = null;
            var _loc_5:Array = null;
            var _loc_2:Array = [];
            var _loc_3:* = getSectionIdsByTownId(param1);
            for (_loc_4 in Missions)
            {
                
                _loc_5 = Missions[_loc_4];
                if (_loc_3.indexOf(_loc_5[0]) > -1)
                {
                    _loc_2.push(_loc_4);
                }
            }
            return _loc_2;
        }// end function

        public static function getMissionDataByMissionId(param1:int) : Object
        {
            var _loc_6:Object = null;
            var _loc_2:* = getMissionType(param1);
            var _loc_3:* = getTownIdByMissionId(param1);
            var _loc_4:* = getMissionListByTownId(_loc_3, _loc_2);
            var _loc_5:Object = {};
            for each (_loc_6 in _loc_4)
            {
                
                if (_loc_6["id"] == param1)
                {
                    _loc_5 = _loc_6;
                    break;
                }
            }
            return _loc_5;
        }// end function

        public static function getNormalMissionListByTownId(param1:int) : Array
        {
            return getMissionListByTownId(param1, NORMAL);
        }// end function

        public static function getHeroMissionListByTownId(param1:int) : Array
        {
            return getMissionListByTownId(param1, HERO);
        }// end function

        public static function getBossMissionListByTownId(param1:int) : Array
        {
            return getMissionListByTownId(param1, BOSS);
        }// end function

        public static function getMissionListByTownId(param1:int, param2:int) : Array
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:Object = null;
            var _loc_9:int = 0;
            var _loc_10:Array = null;
            var _loc_11:Array = null;
            var _loc_12:Array = null;
            var _loc_13:Array = null;
            var _loc_14:Object = null;
            if (!_missionList[param1])
            {
                _missionList[param1] = {};
            }
            var _loc_3:* = _missionList[param1][param2];
            if (_loc_3)
            {
                return _loc_3;
            }
            var _loc_4:Array = [];
            var _loc_5:* = getSectionIdsByTownId(param1);
            for (_loc_8 in Missions)
            {
                
                _loc_9 = _loc_8 as int;
                _loc_10 = Missions[_loc_9];
                if (getMissionType(_loc_9) != param2)
                {
                    continue;
                }
                _loc_11 = getMissionAwardItems(_loc_9);
                _loc_12 = [];
                _loc_13 = [];
                _loc_7 = _loc_11.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_7)
                {
                    
                    _loc_12.push(ItemType.getName(_loc_11[_loc_6]));
                    _loc_13.push(ItemType.getItemColor(_loc_11[_loc_6]));
                    _loc_6++;
                }
                if (_loc_5.indexOf(_loc_10[0]) > -1)
                {
                    _loc_14 = {award:_loc_12, color:_loc_13, coin:getMissionAwardCoins(_loc_9), id:_loc_9, lock:getMissionLock(_loc_9), mainName:getMissionName(_loc_9).replace(/\(.+?\)""\(.+?\)/, ""), minTownNum:0, missionNum:numberToChs(getMissionOrder(_loc_9)), name:getLocalMissionName(_loc_9), power:getMissionPower(_loc_9), skill:getMissionAwardSkill(_loc_9), townMissionNum:"", townName:TownType.getName(param1)};
                    _loc_4.push(_loc_14);
                }
            }
            _loc_4.sortOn("lock", Array.NUMERIC);
            _loc_7 = _loc_4.length;
            _loc_6 = 0;
            while (_loc_6 < _loc_7)
            {
                
                _loc_4[_loc_6]["minTownNum"] = _loc_6 + 1;
                _loc_4[_loc_6]["townMissionNum"] = numberToChs((_loc_6 + 1));
                _loc_6++;
            }
            _missionList[param1][param2] = _loc_4;
            return _loc_4;
        }// end function

        private static function numberToChs(param1:int) : String
        {
            return param1 + "";
            return _loc_4.join("十");
        }// end function

        public static function get startTeleport() : Point
        {
            return new Point(150, 450);
        }// end function

        public static function get endTeleport() : Point
        {
            return new Point(2250, 450);
        }// end function

        public static function loadMissionData(param1:int, param2:Function, param3:Function = null) : void
        {
            var missionId:* = param1;
            var callback:* = param2;
            var error:* = param3;
            if (_missions[missionId])
            {
                MissionType.callback();
                return;
            }
            var url:* = URI.assetsUrl + "templet/mission/" + missionId + ".txt";
            url = url + ("?v=" + URI.getVersion(url));
            var http:* = new HTTP();
            http.onComplete = function (param1:String) : void
            {
                formatMissionData(missionId, param1);
                callback();
                return;
            }// end function
            ;
            http.load(url);
            return;
        }// end function

        private static function formatMissionData(param1:int, param2:String) : void
        {
            var _loc_7:Array = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_3:* = JSON.decode(param2);
            _missions[param1] = _loc_3;
            var _loc_4:* = _loc_3["scenes"];
            var _loc_5:* = _loc_3["scenes"].length;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = _loc_4[_loc_6]["monsters"];
                _loc_8 = _loc_7.length;
                _loc_9 = 0;
                while (_loc_9 < _loc_8)
                {
                    
                    _loc_7[_loc_9]["monster_sign"] = MonsterType.sameResource(MonsterType.getMonsterSign(_loc_7[_loc_9]["monster_id"]));
                    _loc_7[_loc_9]["monster_name"] = MonsterType.getMonsterNameById(_loc_7[_loc_9]["monster_id"]);
                    _loc_9++;
                }
                _loc_6++;
            }
            return;
        }// end function

        private static function checkMission(param1:int) : void
        {
            if (!_missions[param1])
            {
                throw new Error(Lang.sprintf(MissionTypeDataLang.CheckMission, param1));
            }
            return;
        }// end function

        public static function getSences(param1:int) : Array
        {
            checkMission(param1);
            return _missions[param1]["scenes"];
        }// end function

        public static function getMissionMonsterList(param1:int) : Array
        {
            var _loc_4:Object = null;
            checkMission(param1);
            var _loc_2:Array = [];
            var _loc_3:* = _missions[param1]["monster_list"];
            for (_loc_4 in _loc_3)
            {
                
                _loc_2.push(MonsterType.getMonsterSign(_loc_4 as int));
            }
            return _loc_2;
        }// end function

        public static function getVideoLock(param1:int, param2:int) : int
        {
            var _loc_7:Array = null;
            var _loc_8:int = 0;
            var _loc_9:Object = null;
            var _loc_3:* = _missions[param1];
            if (_loc_3 && _loc_3["video_id"] == param2)
            {
                return _loc_3["video_lock"];
            }
            var _loc_4:* = getSences(param1);
            var _loc_5:* = getSences(param1).length;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = _loc_4[_loc_6]["monsters"];
                _loc_8 = 0;
                while (_loc_8 < _loc_7.length)
                {
                    
                    _loc_9 = _loc_7[_loc_8];
                    if (_loc_9["start_video_id"] == param2)
                    {
                        return _loc_9["start_video_lock"];
                    }
                    if (_loc_9["end_video_id"] == param2)
                    {
                        return _loc_9["end_video_lock"];
                    }
                    _loc_8++;
                }
                _loc_6++;
            }
            return 0;
        }// end function

        public static function getVideoId(param1:int) : int
        {
            checkMission(param1);
            return int(_missions[param1]["video_id"]);
        }// end function

        public static function getVideoFile(param1:int) : String
        {
            checkMission(param1);
            return _missions[param1]["video_file"];
        }// end function

    }
}
