package com.assist.view.war.roles
{
    import com.assist.server.*;
    import com.assist.view.war.*;

    public class RoleAction extends Object
    {
        public static const LEFT:String = "left";
        public static const RIGHT:String = "right";
        private static var _list:Object = {};
        private static var _faces:Object = {};
        private static var _addonEffects:Object = {};
        private static var _sameStunts:Object = {};
        private static var _owns:Object = {};
        private static var _regPoints:Object = {};
        private static var _middleTriggers:Array = [];
        public static const bothEffect:Object = [RoleStunt.ChengTianZaiWu, RoleStunt.QiShiErBian, RoleStunt.YingXi, RoleStunt.ZhenSheShu, RoleStunt.DaFenQiMiMa, RoleStunt.XingYanBao, RoleStunt.JianYingWuHen, RoleStunt.MoYing, RoleStunt.BaiZiJueSha, RoleStunt.ShengShouQiHun];

        public function RoleAction()
        {
            return;
        }// end function

        public static function get stuntList() : Array
        {
            var _loc_2:String = null;
            var _loc_1:Array = [];
            for (_loc_2 in _list)
            {
                
                if (MonsterType.BossChiYanShou == _loc_2 || MonsterType.BossDaoBaTu == _loc_2 || MonsterType.BossQingTianMu == _loc_2 || MonsterType.DongHuangTaiYiBoss == _loc_2 || MonsterType.DaMoWangBoss == _loc_2 || MonsterType.MoWangChiYouBoss == _loc_2 || MonsterType.BaoZiWangBoss == _loc_2 || MonsterType.ChiGuiWangBoss == _loc_2 || MonsterType.BaoYaBoss == _loc_2 || _loc_2 == "WorldBossMomentum")
                {
                    continue;
                }
                _loc_1.push(_loc_2);
            }
            return _loc_1;
        }// end function

        public static function isStunt(param1:String) : Boolean
        {
            return _list[param1] != null;
        }// end function

        public static function isBMD(param1:String) : Boolean
        {
            return _list[param1] == 1;
        }// end function

        public static function isMC(param1:String) : Boolean
        {
            return _list[param1] == 0;
        }// end function

        public static function isExists(param1:String) : void
        {
            if (_list[param1] == null)
            {
                throw new Error(param1 + "不存在！");
            }
            return;
        }// end function

        public static function face(param1:String) : String
        {
            return _faces[param1] || "";
        }// end function

        public static function addonEffect(param1:String) : String
        {
            return _addonEffects[param1] || "";
        }// end function

        public static function sameStunt(param1:String) : String
        {
            return _sameStunts[param1] || param1;
        }// end function

        public static function isOwn(param1:String) : Boolean
        {
            return _owns[param1] || false;
        }// end function

        public static function isRegPoint(param1:String) : Boolean
        {
            return _regPoints[param1] || false;
        }// end function

        public static function isMiddleTrigger(param1:String) : Boolean
        {
            return _middleTriggers.indexOf(param1) > -1;
        }// end function

        public static function affectSelf(param1:String) : Boolean
        {
            return isOwn(param1) == true && RoleStunt.KuangBao != param1 && RoleStunt.ZiBao != param1 && RoleStunt.HuiChun != param1 && RoleStunt.YinShen != param1 || RoleStunt.GuWuShu == param1;
        }// end function

        public static function init() : void
        {
            addBMD(RoleStunt.YuJianShu, RoleStunt.MengJi, RoleStunt.BengJing, RoleStunt.FeiYuJian);
            addMC(RoleStunt.AXiuLuoBaWangQuan, RoleStunt.BaiLianHengJiang, RoleStunt.BaoYanLiuXingQun, RoleStunt.BeiCi, RoleStunt.BingJingZhou, RoleStunt.BaiZiJueSha, RoleStunt.ChaNaFangHua, RoleStunt.ChangHongGuanRi, RoleStunt.ChengTianZaiWu, RoleStunt.ChuiMian, RoleStunt.ChengTianZaiWu, RoleStunt.DaHuoYanZhou, RoleStunt.DingShenZhou, RoleStunt.DuWu, RoleStunt.DuZhou, RoleStunt.DaFenQiMiMa, RoleStunt.ErDuanJi, RoleStunt.FengHuoLiaoYuan, RoleStunt.FengJuanCanYun, RoleStunt.FengJuanChenSheng, RoleStunt.FengShenJian, RoleStunt.FengXueBingTian, RoleStunt.FengZhou, RoleStunt.HongLianQiang, RoleStunt.HuaiZhongBaoMeiSha, RoleStunt.HuanYing, RoleStunt.HuoYanZhou, RoleStunt.HunDunZhiLi, RoleStunt.HunLuan, RoleStunt.JianLiuYun, RoleStunt.JingLeiShan, RoleStunt.JiuTianShenLei, RoleStunt.JueDuiFangYu, RoleStunt.JueDuiLingDu, RoleStunt.JianYingWuHen, RoleStunt.LeiTingJue, RoleStunt.LeiTingYiJi, RoleStunt.LeiZhou, RoleStunt.LingBao, RoleStunt.LingBaoDanMu, RoleStunt.LuoXingShi, RoleStunt.MoYing, RoleStunt.MoYingAnMie, RoleStunt.GuangMangWanZhang, RoleStunt.GuWuShu, RoleStunt.HuanMing, RoleStunt.HuanShu, RoleStunt.HuiChun, RoleStunt.JiuSiYiSheng, RoleStunt.JuHun, RoleStunt.KuangBao, RoleStunt.LiZhiBaTi, RoleStunt.NuZhiBaTi, RoleStunt.MengPoTang, RoleStunt.QianNianLunHui, RoleStunt.NianYa, RoleStunt.NiShuiHan, RoleStunt.QianBeiBuZui, RoleStunt.QianJunNuJi, RoleStunt.QiShiErBian, RoleStunt.Reel, RoleStunt.NuYanLianTao, RoleStunt.SanMeiZhenHuo, RoleStunt.SanQianShiJie, RoleStunt.SenLuoWanXiang, RoleStunt.ShenZhiBaTi, RoleStunt.ShiFangJieSha, RoleStunt.ShiHun, RoleStunt.ShuiMuTianHua, RoleStunt.SiYao, RoleStunt.ShengShouQiHun, RoleStunt.TaiJi, RoleStunt.TianHuoFenYan, RoleStunt.TianHuoLiaoYuan, RoleStunt.TianJian, RoleStunt.TianJiangHengCai, RoleStunt.TianShiFuFa, RoleStunt.TianShuangQuan, RoleStunt.TianXuanWuYin, RoleStunt.TianZhiBaTi, RoleStunt.TuiMoJi, RoleStunt.TuZhou, RoleStunt.TianMoWangSheng, RoleStunt.WuHui, RoleStunt.WuZhiBaTi, RoleStunt.XingYun, RoleStunt.XiXue, RoleStunt.XuanYinJian, RoleStunt.XingYanBao, RoleStunt.YeManChongZhuang, RoleStunt.YeQiuQuan, RoleStunt.YeWuFeiRen, RoleStunt.YingXi, RoleStunt.YingZhiBaTi, RoleStunt.YinShen, RoleStunt.YiShan, RoleStunt.YueShi, RoleStunt.YueShiMark, RoleStunt.YunShiLieDi, RoleStunt.ZhenSheShu, RoleStunt.ZhenYeQiuQuan, RoleStunt.ZhiLiao, RoleStunt.ZhiSheng, RoleStunt.ZiBao, RoleStunt.ZiDianShenGuang, RoleStunt.TianZhan, RoleStunt.QianGuDaRu, RoleStunt.ShuiMoHuaYing, RoleStunt.LingLongQiJing, RoleStunt.ZhiMingYiJi, RoleStunt.HunFeiPoSan, RoleStunt.DunQiang, MonsterType.BossChiYanShou, MonsterType.BossQingTianMu, MonsterType.BossDaoBaTu, BeelzeBubTrialsBossType.DaMoWangBoss, BeelzeBubTrialsBossType.DongHuangTaiYiBoss, BeelzeBubTrialsBossType.MoWangChiYouBoss, BeelzeBubTrialsBossType.BaoYaBoss, BeelzeBubTrialsBossType.BaoZiWangBoss, BeelzeBubTrialsBossType.ChiGuiWangBoss, RoleStunt.TianMei, RoleStunt.TianMeiMark, RoleStunt.TaiMeiDeShangTong, RoleStunt.LieYanChuanXin, RoleStunt.TaiMeiDeShangTongMark, RoleStunt.YaoShouAnYing, RoleStunt.KuangShouZhiLi, RoleStunt.QiSiHuiSheng, WarType.QiSiHuiShengFirst, RoleStunt.MiaoShouHuiChun, RoleStunt.NuZhiBaTi, RoleStunt.TianShaGuXing, RoleStunt.TianShaGuXingMark, RoleStunt.ShengZhiBaTi, RoleStunt.RiShi, RoleStunt.RiShiMark, RoleStunt.LongShenZhiNu, RoleStunt.TianGangHuTi, RoleStunt.LingHunSuoLian, RoleStunt.DaoDaYiPa, RoleStunt.QingNianHuaShu, RoleStunt.ZuiXianJiuHen, "WorldBossMomentum");
            addFace(RoleStunt.AXiuLuoBaWangQuan, RIGHT, RoleStunt.BaiLianHengJiang, LEFT, RoleStunt.BeiCi, LEFT, RoleStunt.BengJing, RIGHT, RoleStunt.BaoYanLiuXingQun, RIGHT, RoleStunt.ChangHongGuanRi, LEFT, RoleStunt.DaHuoYanZhou, LEFT, RoleStunt.ErDuanJi, LEFT, RoleStunt.FengHuoLiaoYuan, LEFT, RoleStunt.FengShenJian, RIGHT, RoleStunt.FengZhou, LEFT, RoleStunt.GuangMangWanZhang, RIGHT, RoleStunt.HongLianQiang, LEFT, RoleStunt.JianLiuYun, RIGHT, RoleStunt.JiuSiYiSheng, RIGHT, RoleStunt.JueDuiFangYu, RIGHT, RoleStunt.LuoXingShi, RIGHT, RoleStunt.MengPoTang, RIGHT, RoleStunt.QianNianLunHui, RIGHT, RoleStunt.NiShuiHan, LEFT, RoleStunt.NuYanLianTao, RIGHT, RoleStunt.QiShiErBian, LEFT, RoleStunt.QianBeiBuZui, RIGHT, RoleStunt.SanQianShiJie, RIGHT, RoleStunt.ShaShengJian, RIGHT, RoleStunt.TianJian, RIGHT, RoleStunt.TuiMoJi, RIGHT, RoleStunt.ShiFangJieSha, RIGHT, RoleStunt.SiYao, LEFT, RoleStunt.TianShuangQuan, RIGHT, RoleStunt.XuanYinJian, RIGHT, RoleStunt.YeManChongZhuang, LEFT, RoleStunt.YingXi, LEFT, RoleStunt.YiShan, LEFT, RoleStunt.ZhenYeQiuQuan, LEFT, RoleStunt.ZhiSheng, RIGHT, RoleStunt.ShengShouQiHun, RIGHT, RoleStunt.BaiZiJueSha, RIGHT, RoleStunt.JianYingWuHen, RIGHT, RoleStunt.XingYanBao, RIGHT, RoleStunt.DaFenQiMiMa, RIGHT, RoleStunt.MoYing, RIGHT, RoleStunt.ZhiMingYiJi, RIGHT, RoleStunt.DunQiang, LEFT, RoleStunt.LieYanChuanXin, RIGHT, RoleStunt.YaoShouAnYing, RIGHT, RoleStunt.KuangShouZhiLi, RIGHT, RoleStunt.TianMei, RIGHT, WarType.QiSiHuiShengFirst, LEFT, RoleStunt.DaoDaYiPa, RIGHT, RoleStunt.ZuiXianJiuHen, RIGHT);
            addAddonEffect(RoleStunt.BeiCi, RoleStunt.Reel, RoleStunt.BingJingZhou, RoleStunt.Reel, RoleStunt.DongJie, RoleStunt.Reel, RoleStunt.FengHuoLiaoYuan, RoleStunt.Reel, RoleStunt.FengJuanChenSheng, RoleStunt.Reel, RoleStunt.FengZhou, RoleStunt.Reel, RoleStunt.FengXueBingTian, RoleStunt.Reel, RoleStunt.JianLiuYun, RoleStunt.Reel, RoleStunt.JingLeiShan, RoleStunt.Reel, RoleStunt.JiuTianShenLei, RoleStunt.Reel, RoleStunt.KuangFengJianJue, RoleStunt.Reel, RoleStunt.LeiDongJiuTian, RoleStunt.Reel, RoleStunt.LeiTingJue, RoleStunt.Reel, RoleStunt.LeiZhou, RoleStunt.Reel, RoleStunt.LuoShi, RoleStunt.Reel, RoleStunt.MengPoTang, RoleStunt.Reel, RoleStunt.QianNianLunHui, RoleStunt.Reel, RoleStunt.ShanDian, RoleStunt.Reel, RoleStunt.TianHuoFenYan, RoleStunt.Reel, RoleStunt.TianJiangHengCai, RoleStunt.Reel, RoleStunt.TianLeiHong, RoleStunt.Reel, RoleStunt.TianShuangQuan, RoleStunt.Reel, RoleStunt.TuZhou, RoleStunt.Reel, RoleStunt.XuanFeng, RoleStunt.Reel, RoleStunt.XingChenDiDong, RoleStunt.Reel, RoleStunt.YeManChongZhuang, RoleStunt.Reel, RoleStunt.YingXi, RoleStunt.Reel, RoleStunt.HunDunZhiLi, RoleStunt.Reel, RoleStunt.DaoDaYiPa, RoleStunt.Reel, RoleStunt.ShengShouQiHun, RoleStunt.Reel, RoleStunt.DaFenQiMiMa, RoleStunt.Reel, RoleStunt.ShuiMoHuaYing, RoleStunt.Reel, RoleStunt.LieYanChuanXin, RoleStunt.Reel, RoleStunt.DuZhou, RoleStunt.DuWu, RoleStunt.SiYao, RoleStunt.DuWu, RoleStunt.XiXue, RoleStunt.ZhiLiao, RoleStunt.TianJingZhou, RoleStunt.ChuiMian, RoleStunt.MengYin, RoleStunt.ChuiMian, RoleStunt.LingBaoDanMu, RoleStunt.ChuiMian, RoleStunt.WuHui, RoleStunt.ChuiMian, RoleStunt.YueShi, RoleStunt.YueShiMark, RoleStunt.RiShi, RoleStunt.RiShiMark, RoleStunt.TaiMeiDeShangTong, RoleStunt.TaiMeiDeShangTongMark, RoleStunt.TianMei, RoleStunt.TianMeiMark, RoleStunt.TianShaGuXing, RoleStunt.TianShaGuXingMark);
            addSameStunts(RoleStunt.BaFangBaoLie, RoleStunt.BaiLianHengJiang, RoleStunt.FengJuanChenSheng, RoleStunt.FengZhou, RoleStunt.LeiDongJiuTian, RoleStunt.LeiZhou, RoleStunt.LianYuHuoHai, RoleStunt.HuoYanZhou, RoleStunt.XingChenDiDong, RoleStunt.TuZhou, RoleStunt.LuoShi, RoleStunt.TuZhou, RoleStunt.ShanDian, RoleStunt.LeiZhou, RoleStunt.XuanFeng, RoleStunt.FengZhou, RoleStunt.HuoZhu, RoleStunt.HuoYanZhou, RoleStunt.DongJie, RoleStunt.BingJingZhou, RoleStunt.DuWu, RoleStunt.DuZhou, RoleStunt.LingHeBao, RoleStunt.LingBao, RoleStunt.LingLiChongJi, RoleStunt.LingBao, RoleStunt.LeiQie, RoleStunt.LeiZhou, RoleStunt.DaFengZhou, RoleStunt.FengZhou, RoleStunt.HuXiao, RoleStunt.TuiMoJi, RoleStunt.KongHe, RoleStunt.ZhenSheShu, RoleStunt.KuangFengJianJue, RoleStunt.FengJuanChenSheng, RoleStunt.JiuYinJiuYang, RoleStunt.XuanYinJian, RoleStunt.MengYin, RoleStunt.LingBaoDanMu, RoleStunt.ShaShengJian, RoleStunt.TianJian, RoleStunt.TianJingZhou, RoleStunt.FengXueBingTian, RoleStunt.TianLeiHong, RoleStunt.LeiTingJue, RoleStunt.XueShenZuZhou, RoleStunt.TianMoWangSheng, RoleStunt.ZhuoReChongJi, RoleStunt.SanMeiZhenHuo);
            addOwn(RoleStunt.HuanMing, RoleStunt.HuanYing, RoleStunt.HuiChun, RoleStunt.JueDuiFangYu, RoleStunt.DunQiang, RoleStunt.KuangBao, RoleStunt.MiaoShouHuiChun, RoleStunt.YinShen, RoleStunt.ZhiLiao, RoleStunt.ZiBao);
            addToRegPoint(RoleStunt.BaiLianHengJiang, RoleStunt.BaoYanLiuXingQun, RoleStunt.ChaNaFangHua, RoleStunt.ChengTianZaiWu, RoleStunt.DaHuoYanZhou, RoleStunt.DuZhou, RoleStunt.FengHuoLiaoYuan, RoleStunt.FengJuanCanYun, RoleStunt.FengJuanChenSheng, RoleStunt.FengXueBingTian, RoleStunt.FengZhou, RoleStunt.GuWuShu, RoleStunt.HongLianQiang, RoleStunt.HuaiZhongBaoMeiSha, RoleStunt.HuoYanZhou, RoleStunt.HuanMing, RoleStunt.HuanShu, RoleStunt.HuanYing, RoleStunt.HuiChun, RoleStunt.HunDunZhiLi, RoleStunt.HunLuan, RoleStunt.JingLeiShan, RoleStunt.JiuSiYiSheng, RoleStunt.JiuTianShenLei, RoleStunt.JueDuiFangYu, RoleStunt.JueDuiLingDu, RoleStunt.JuHun, RoleStunt.LeiTingJue, RoleStunt.LeiTingYiJi, RoleStunt.LeiZhou, RoleStunt.LiZhiBaTi, RoleStunt.NuZhiBaTi, RoleStunt.LuoXingShi, RoleStunt.MengPoTang, RoleStunt.QianNianLunHui, RoleStunt.MoYingAnMie, RoleStunt.NianYa, RoleStunt.NiShuiHan, RoleStunt.NuYanLianTao, RoleStunt.QianBeiBuZui, RoleStunt.QianJunNuJi, RoleStunt.QiShiErBian, RoleStunt.SanMeiZhenHuo, RoleStunt.SanQianShiJie, RoleStunt.SenLuoWanXiang, RoleStunt.ShenZhiBaTi, RoleStunt.ShiHun, RoleStunt.ShuiMuTianHua, RoleStunt.TaiJi, RoleStunt.TianHuoFenYan, RoleStunt.TianHuoLiaoYuan, RoleStunt.TianJian, RoleStunt.TianJiangHengCai, RoleStunt.TianMoWangSheng, RoleStunt.TianXuanWuYin, RoleStunt.TianZhiBaTi, RoleStunt.TuiMoJi, RoleStunt.TuZhou, RoleStunt.WuHui, RoleStunt.WuZhiBaTi, RoleStunt.XingYun, RoleStunt.YeManChongZhuang, RoleStunt.YeWuFeiRen, RoleStunt.YingXi, RoleStunt.YingZhiBaTi, RoleStunt.YinShen, RoleStunt.YiShan, RoleStunt.YueShi, RoleStunt.YunShiLieDi, RoleStunt.ZhenSheShu, RoleStunt.ZhenYeQiuQuan, RoleStunt.ZhiLiao, RoleStunt.ZhiSheng, RoleStunt.ZiDianShenGuang, RoleStunt.ShengShouQiHun, RoleStunt.BaiZiJueSha, RoleStunt.JianYingWuHen, RoleStunt.XingYanBao, RoleStunt.DaFenQiMiMa, RoleStunt.QianGuDaRu, RoleStunt.ShuiMoHuaYing, RoleStunt.LingLongQiJing, RoleStunt.MoYing, RoleStunt.ZhiMingYiJi, RoleStunt.HunFeiPoSan, RoleStunt.DunQiang, RoleStunt.TianMei, RoleStunt.LieYanChuanXin, RoleStunt.TaiMeiDeShangTong, RoleStunt.YaoShouAnYing, RoleStunt.KuangShouZhiLi, RoleStunt.QiSiHuiSheng, WarType.QiSiHuiShengFirst, RoleStunt.MiaoShouHuiChun, RoleStunt.NuZhiBaTi, RoleStunt.ShengZhiBaTi, RoleStunt.TianShaGuXing, RoleStunt.TianShaGuXingMark, RoleStunt.RiShi, RoleStunt.RiShiMark, RoleStunt.LongShenZhiNu, RoleStunt.TianGangHuTi, RoleStunt.LingHunSuoLian, RoleStunt.DaoDaYiPa, RoleStunt.QingNianHuaShu, RoleStunt.ZuiXianJiuHen);
            _middleTriggers = [RoleStunt.JiuSiYiSheng, RoleStunt.TianShiFuFa, RoleStunt.QianBeiBuZui, RoleStunt.XingYun, RoleStunt.YeManChongZhuang, RoleStunt.YeQiuQuan, RoleStunt.QianNianLunHui, RoleStunt.ZhiMingYiJi, RoleStunt.LieYanChuanXin, RoleStunt.YaoShouAnYing, RoleStunt.KuangShouZhiLi, RoleStunt.DaoDaYiPa, RoleStunt.RiShi, RoleStunt.ZuiXianJiuHen, RoleStunt.LingLongQiJing, RoleStunt.ShuiMoHuaYing, RoleStunt.QianGuDaRu, RoleStunt.TianMei];
            return;
        }// end function

        private static function addBMD(... args) : void
        {
            addRole(1, args);
            return;
        }// end function

        private static function addMC(... args) : void
        {
            addRole(0, args);
            return;
        }// end function

        private static function addRole(param1:int, param2:Array) : void
        {
            var _loc_3:* = param2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _list[param2[_loc_4]] = param1;
                _loc_4++;
            }
            return;
        }// end function

        private static function addFace(... args) : void
        {
            addKeyValue(args, _faces);
            return;
        }// end function

        private static function addAddonEffect(... args) : void
        {
            addKeyValue(args, _addonEffects);
            return;
        }// end function

        private static function addSameStunts(... args) : void
        {
            addKeyValue(args, _sameStunts);
            return;
        }// end function

        private static function addKeyValue(param1:Array, param2:Object) : void
        {
            if (param1.length % 2 != 0)
            {
                throw new Error("参数数目不对。");
            }
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                param2[param1[_loc_4]] = param1[(_loc_4 + 1)];
                _loc_4 = _loc_4 + 2;
            }
            return;
        }// end function

        private static function addOwn(... args) : void
        {
            args = args.length;
            var _loc_3:int = 0;
            while (_loc_3 < args)
            {
                
                _owns[args[_loc_3]] = true;
                _loc_3++;
            }
            return;
        }// end function

        private static function addToRegPoint(... args) : void
        {
            args = args.length;
            var _loc_3:int = 0;
            while (_loc_3 < args)
            {
                
                _regPoints[args[_loc_3]] = true;
                _loc_3++;
            }
            return;
        }// end function

        init();
    }
}
