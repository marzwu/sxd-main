package com.assist.server
{
    import com.assist.view.war.roles.*;

    public class RoleStunt extends Object
    {
        private static var _Stunts:Object = null;
        public static const YuJianShu:String = "YuJianShu";
        public static const MengJi:String = "MengJi";
        public static const BengJing:String = "BengJing";
        public static const FeiYuJian:String = "FeiYuJian";
        public static const JianLiuYun:String = "JianLiuYun";
        public static const LuoXingShi:String = "LuoXingShi";
        public static const XuanYinJian:String = "XuanYinJian";
        public static const GuangMangWanZhang:String = "GuangMangWanZhang";
        public static const SanMeiZhenHuo:String = "SanMeiZhenHuo";
        public static const TianShuangQuan:String = "TianShuangQuan";
        public static const ShiFangJieSha:String = "ShiFangJieSha";
        public static const AXiuLuoBaWangQuan:String = "AXiuLuoBaWangQuan";
        public static const TianXuanWuYin:String = "TianXuanWuYin";
        public static const JingLeiShan:String = "JingLeiShan";
        public static const MengPoTang:String = "MengPoTang";
        public static const GuiYuHuanShen:String = "GuiYuHuanShen";
        public static const ErDuanJi:String = "ErDuanJi";
        public static const TianShiFuFa:String = "TianShiFuFa";
        public static const LeiZhou:String = "LeiZhou";
        public static const FengZhou:String = "FengZhou";
        public static const HuoYanZhou:String = "HuoYanZhou";
        public static const BingJingZhou:String = "BingJingZhou";
        public static const JuHun:String = "JuHun";
        public static const ZiBao:String = "ZiBao";
        public static const SiYao:String = "SiYao";
        public static const NianYa:String = "NianYa";
        public static const BeiCi:String = "BeiCi";
        public static const BaiLianHengJiang:String = "BaiLianHengJiang";
        public static const ChangHongGuanRi:String = "ChangHongGuanRi";
        public static const BaFangBaoLie:String = "BaFangBaoLie";
        public static const KuangBao:String = "KuangBao";
        public static const DuZhou:String = "DuZhou";
        public static const DuWu:String = "DuWu";
        public static const DingShenZhou:String = "DingShenZhou";
        public static const ChuiMian:String = "ChuiMian";
        public static const ZhenSheShu:String = "ZhenSheShu";
        public static const GuWuShu:String = "GuWuShu";
        public static const HuanShu:String = "HuanShu";
        public static const HunLuan:String = "HunLuan";
        public static const JueDuiFangYu:String = "JueDuiFangYu";
        public static const HuanYing:String = "HuanYing";
        public static const YinShen:String = "YinShen";
        public static const HuiChun:String = "HuiChun";
        public static const ZhiLiao:String = "ZhiLiao";
        public static const XiXue:String = "XiXue";
        public static const WuJueJi:String = "WuJueJi";
        public static const YingXi:String = "YingXi";
        public static const TuZhou:String = "TuZhou";
        public static const XingChenDiDong:String = "XingChenDiDong";
        public static const LeiDongJiuTian:String = "LeiDongJiuTian";
        public static const FengJuanChenSheng:String = "FengJuanChenSheng";
        public static const LianYuHuoHai:String = "LianYuHuoHai";
        public static const FengXueBingTian:String = "FengXueBingTian";
        public static const LingBao:String = "LingBao";
        public static const LingLiChongJi:String = "LingLiChongJi";
        public static const LingBaoDanMu:String = "LingBaoDanMu";
        public static const LingHeBao:String = "LingHeBao";
        public static const LuoShi:String = "LuoShi";
        public static const ShanDian:String = "ShanDian";
        public static const XuanFeng:String = "XuanFeng";
        public static const HuoZhu:String = "HuoZhu";
        public static const DongJie:String = "DongJie";
        public static const HuanMing:String = "HuanMing";
        public static const BaTi:String = "BaTi";
        public static const LeiQie:String = "LeiQie";
        public static const DaFengZhou:String = "DaFengZhou";
        public static const DaHuoYanZhou:String = "DaHuoYanZhou";
        public static const KongHe:String = "KongHe";
        public static const WuZhiBaTi:String = "WuZhiBaTi";
        public static const YingZhiBaTi:String = "YingZhiBaTi";
        public static const LiZhiBaTi:String = "LiZhiBaTi";
        public static const YeQiuQuan:String = "YeQiuQuan";
        public static const XingYun:String = "XingYun";
        public static const QianBeiBuZui:String = "QianBeiBuZui";
        public static const TianJiangHengCai:String = "TianJiangHengCai";
        public static const MengYin:String = "MengYin";
        public static const ZhuoReChongJi:String = "ZhuoReChongJi";
        public static const KuangFengJianJue:String = "KuangFengJianJue";
        public static const TianJingZhou:String = "TianJingZhou";
        public static const TianLeiHong:String = "TianLeiHong";
        public static const HuXiao:String = "HuXiao";
        public static const XueShenZuZhou:String = "XueShenZuZhou";
        public static const FengShenJian:String = "FengShenJian";
        public static const ShaShengJian:String = "ShaShengJian";
        public static const JiuYinJiuYang:String = "JiuYinJiuYang";
        public static const TuiMoJi:String = "TuiMoJi";
        public static const LeiTingJue:String = "LeiTingJue";
        public static const TianMoWangSheng:String = "TianMoWangSheng";
        public static const TianJian:String = "TianJian";
        public static const HuaiZhongBaoMeiSha:String = "HuaiZhongBaoMeiSha";
        public static const ShiHun:String = "ShiHun";
        public static const SenLuoWanXiang:String = "SenLuoWanXiang";
        public static const NuYanLianTao:String = "NuYanLianTao";
        public static const BaoYanLiuXingQun:String = "BaoYanLiuXingQun";
        public static const SanQianShiJie:String = "SanQianShiJie";
        public static const TaiJi:String = "TaiJi";
        public static const ZhiSheng:String = "ZhiSheng";
        public static const ChengTianZaiWu:String = "ChengTianZaiWu";
        public static const NiShuiHan:String = "NiShuiHan";
        public static const HongLianQiang:String = "HongLianQiang";
        public static const FengHuoLiaoYuan:String = "FengHuoLiaoYuan";
        public static const YeManChongZhuang:String = "YeManChongZhuang";
        public static const ZhenYeQiuQuan:String = "ZhenYeQiuQuan";
        public static const TianZhiBaTi:String = "TianZhiBaTi";
        public static const YiShan:String = "YiShan";
        public static const QiShiErBian:String = "QiShiErBian";
        public static const JiuTianShenLei:String = "JiuTianShenLei";
        public static const JiuSiYiSheng:String = "JiuSiYiSheng";
        public static const TianHuoLiaoYuan:String = "TianHuoLiaoYuan";
        public static const YunShiLieDi:String = "YunShiLieDi";
        public static const QianJunNuJi:String = "QianJunNuJi";
        public static const ShuiMuTianHua:String = "ShuiMuTianHua";
        public static const YeWuFeiRen:String = "YeWuFeiRen";
        public static const FengJuanCanYun:String = "FengJuanCanYun";
        public static const JueDuiLingDu:String = "JueDuiLingDu";
        public static const LeiTingYiJi:String = "LeiTingYiJi";
        public static const MoYingAnMie:String = "MoYingAnMie";
        public static const ZiDianShenGuang:String = "ZiDianShenGuang";
        public static const ChaNaFangHua:String = "ChaNaFangHua";
        public static const HunDunZhiLi:String = "HunDunZhiLi";
        public static const YueShi:String = "YueShi";
        public static const WuHui:String = "WuHui";
        public static const ShenZhiBaTi:String = "ShenZhiBaTi";
        public static const TianHuoFenYan:String = "TianHuoFenYan";
        public static const TianZhan:String = "TianZhan";
        public static const QianNianLunHui:String = "QianNianLunHui";
        public static const JianYingWuHen:String = "JianYingWuHen";
        public static const QianGuDaRu:String = "QianGuDaRu";
        public static const ShengShouQiHun:String = "ShengShouQiHun";
        public static const LingLongQiJing:String = "LingLongQiJing";
        public static const DaFenQiMiMa:String = "DaFenQiMiMa";
        public static const XingYanBao:String = "XingYanBao";
        public static const BaiZiJueSha:String = "BaiZiJueSha";
        public static const MoYing:String = "MoYing";
        public static const ShuiMoHuaYing:String = "ShuiMoHuaYing";
        public static const ZhiMingYiJi:String = "ZhiMingYiJi";
        public static const HunFeiPoSan:String = "HunFeiPoSan";
        public static const DunQiang:String = "DunQiang";
        public static const NuZhiBaTi:String = "NuZhiBaTi";
        public static const TianMei:String = "TianMei";
        public static const TaiMeiDeShangTong:String = "TaiMeiDeShangTong";
        public static const LieYanChuanXin:String = "LieYanChuanXin";
        public static const KuangShouZhiLi:String = "KuangShouZhiLi";
        public static const YaoShouAnYing:String = "YaoShouAnYing";
        public static const ShengZhiBaTi:String = "ShengZhiBaTi";
        public static const TianShaGuXing:String = "TianShaGuXing";
        public static const MiaoShouHuiChun:String = "MiaoShouHuiChun";
        public static const QiSiHuiSheng:String = "QiSiHuiSheng";
        public static const LongShenZhiNu:String = "LongShenZhiNu";
        public static const RiShi:String = "RiShi";
        public static const TianGangHuTi:String = "TianGangHuTi";
        public static const LingHunSuoLian:String = "LingHunSuoLian";
        public static const ZuiXianJiuHen:String = "ZuiXianJiuHen";
        public static const DaoDaYiPa:String = "DaoDaYiPa";
        public static const QingNianHuaShu:String = "QingNianHuaShu";
        public static const Reel:String = "Reel";
        public static const YueShiMark:String = "YueShiMark";
        public static const TaiMeiDeShangTongMark:String = "TaiMeiDeShangTongMark";
        public static const TianMeiMark:String = "TianMeiMark";
        public static const TianShaGuXingMark:String = "TianShaGuXingMark";
        public static const RiShiMark:String = "RiShiMark";
        private static var _RoleWithStunt:Object = null;

        public function RoleStunt()
        {
            return;
        }// end function

        public static function get Stunts() : Object
        {
            if (_Stunts == null)
            {
                throw new Error("还未赋值！");
            }
            return _Stunts;
        }// end function

        public static function set Stunts(param1:Object) : void
        {
            if (_Stunts != null)
            {
                throw new Error("非法赋值");
            }
            _Stunts = param1;
            return;
        }// end function

        public static function get RoleWithStunt() : Object
        {
            if (_RoleWithStunt == null)
            {
                throw new Error("还未赋值！");
            }
            return _RoleWithStunt;
        }// end function

        public static function set RoleWithStunt(param1:Object) : void
        {
            if (_RoleWithStunt != null)
            {
                throw new Error("非法赋值");
            }
            _RoleWithStunt = param1;
            return;
        }// end function

        public static function getStuntSign(param1:int) : String
        {
            return _Stunts[param1] ? (_Stunts[param1][0]) : ("");
        }// end function

        public static function getStuntName(param1:String) : String
        {
            var _loc_3:Object = null;
            var _loc_2:String = "";
            for each (_loc_3 in _Stunts)
            {
                
                if (_loc_3[0] == param1)
                {
                    _loc_2 = _loc_3[1];
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getStuntDescription(param1:int) : String
        {
            return _Stunts[param1] ? (_Stunts[param1][2]) : ("");
        }// end function

        public static function getRoleStunt(param1:String) : String
        {
            var _loc_2:* = RoleWithStunt[param1][0];
            return _loc_2 ? (Stunts[_loc_2][0]) : ("");
        }// end function

        public static function getMonsterStunt(param1:String) : String
        {
            var _loc_2:* = RoleWithStunt[param1][1];
            return _loc_2 ? (Stunts[_loc_2][0]) : ("");
        }// end function

        public static function getRoleStunts(param1:Array) : Array
        {
            var _loc_2:* = getStuntsBase(param1, 0);
            return _loc_2;
        }// end function

        public static function getMonsterStunts(param1:Array) : Array
        {
            if (FunctionType.isOpened(FunctionType.Stunt) == false)
            {
                return [];
            }
            return getStuntsBase(param1, 1);
        }// end function

        private static function getStuntsBase(param1:Array, param2:int) : Array
        {
            var _loc_7:int = 0;
            var _loc_8:String = null;
            var _loc_9:String = null;
            var _loc_3:Array = [];
            var _loc_4:Object = {};
            var _loc_5:* = param1.length;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = RoleWithStunt[param1[_loc_6]][param2];
                if (_loc_7)
                {
                    _loc_8 = Stunts[_loc_7][0];
                    if (!_loc_4[_loc_8])
                    {
                        _loc_9 = RoleAction.addonEffect(_loc_8);
                        if (_loc_9 != "" && _loc_3.indexOf(_loc_9) == -1)
                        {
                            _loc_3.push(_loc_9);
                        }
                        _loc_8 = RoleAction.sameStunt(_loc_8);
                        _loc_4[_loc_8] = true;
                        _loc_3.push(_loc_8);
                        _loc_9 = RoleAction.addonEffect(_loc_8);
                        if (_loc_9 != "" && _loc_3.indexOf(_loc_9) == -1)
                        {
                            _loc_3.push(_loc_9);
                        }
                    }
                }
                _loc_6++;
            }
            return _loc_3;
        }// end function

        public static function addonRoleStunts() : Array
        {
            return [MengJi];
        }// end function

    }
}
