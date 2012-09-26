﻿package com.assist.server
{

    public class MonsterType extends Object
    {
        private static var _Monsters:Object = null;
        public static const GrassDemon:String = "GrassDemon";
        public static const TreeDemon:String = "TreeDemon";
        public static const LiChiLang:String = "LiChiLang";
        public static const WolfDemonBoss:String = "WolfDemonBoss";
        public static const ShanZei:String = "ShanZei";
        public static const WildPig:String = "WildPig";
        public static const XueSeBianFu:String = "XueSeBianFu";
        public static const ZhangMaZi:String = "ZhangMaZi";
        public static const ZhuHa:String = "ZhuHa";
        public static const FeiYi:String = "FeiYi";
        public static const ShuangDaoXieZi:String = "ShuangDaoXieZi";
        public static const LiYi:String = "LiYi";
        public static const QingZhuSheYao:String = "QingZhuSheYao";
        public static const ZiDianShe:String = "ZiDianShe";
        public static const SheYaoNan:String = "SheYaoNan";
        public static const HongSheYao:String = "HongSheYao";
        public static const LuShiHuoChan:String = "LuShiHuoChan";
        public static const LuShiBingChan:String = "LuShiBingChan";
        public static const JinChan:String = "JinChan";
        public static const QingHuoJiangShi:String = "QingHuoJiangShi";
        public static const PuTongJiangShi:String = "PuTongJiangShi";
        public static const YouGuei:String = "YouGuei";
        public static const JiangChen:String = "JiangChen";
        public static const SheYaoMengNan:String = "SheYaoMengNan";
        public static const FeiTouMan:String = "FeiTouMan";
        public static const ChiGuiWang:String = "ChiGuiWang";
        public static const HuaYao:String = "HuaYao";
        public static const DieJing:String = "DieJing";
        public static const WuCaiZhiZhu:String = "WuCaiZhiZhu";
        public static const KuangBaoZhiZhu:String = "KuangBaoZhiZhu";
        public static const ZhiZhuJing:String = "ZhiZhuJing";
        public static const LingHu:String = "LingHu";
        public static const LiuWeiLingHu:String = "LiuWeiLingHu";
        public static const XuanNiao:String = "XuanNiao";
        public static const JiuWeiYaoHu:String = "JiuWeiYaoHu";
        public static const LanLingShiWei:String = "LanLingShiWei";
        public static const DaNeiShiWei:String = "DaNeiShiWei";
        public static const DuTong:String = "DuTong";
        public static const YaoHuaTongLing:String = "YaoHuaTongLing";
        public static const BaoNuJiuWei:String = "BaoNuJiuWei";
        public static const SanXianJia:String = "SanXianJia";
        public static const SanXianYi:String = "SanXianYi";
        public static const SanXianBing:String = "SanXianBing";
        public static const JiuXianWeng:String = "JiuXianWeng";
        public static const ChenYu:String = "ChenYu";
        public static const LuoYan:String = "LuoYan";
        public static const DongShi:String = "DongShi";
        public static const BaoXiang:String = "BaoXiang";
        public static const CaiShen:String = "CaiShen";
        public static const RuYi:String = "RuYi";
        public static const JiXiangRuYi:String = "JiXiangRuYi";
        public static const YuanBao:String = "YuanBao";
        public static const YaYi:String = "YaYi";
        public static const BuKuai:String = "BuKuai";
        public static const XianGuan:String = "XianGuan";
        public static const XieJian:String = "XieJian";
        public static const ShiXueJian:String = "ShiXueJian";
        public static const HanYuJian:String = "HanYuJian";
        public static const TianQi:String = "TianQi";
        public static const DiHun:String = "DiHun";
        public static const XianBeiYinHun:String = "XianBeiYinHun";
        public static const ZhangMenYuanShi:String = "ZhangMenYuanShi";
        public static const ZhanHun:String = "ZhanHun";
        public static const JianHun:String = "JianHun";
        public static const MoJian:String = "MoJian";
        public static const TianBingShouWei:String = "TianBingShouWei";
        public static const FengShenShouGuan:String = "FengShenShouGuan";
        public static const DianShou:String = "DianShou";
        public static const YouNianYaZi:String = "YouNianYaZi";
        public static const ChengNianYaZi:String = "ChengNianYaZi";
        public static const XiangLongShou:String = "XiangLongShou";
        public static const HuanShouYaZi:String = "HuanShouYaZi";
        public static const ShenShouYaZi:String = "ShenShouYaZi";
        public static const XuanWuShenShou:String = "XuanWuShenShou";
        public static const JuMang:String = "JuMang";
        public static const ChiHuoXieZi:String = "ChiHuoXieZi";
        public static const HuoYanShou:String = "HuoYanShou";
        public static const ChiYanShou:String = "ChiYanShou";
        public static const YanJiangShou:String = "YanJiangShou";
        public static const ChiQuan:String = "ChiQuan";
        public static const RanKui:String = "RanKui";
        public static const HuoKui:String = "HuoKui";
        public static const XiaoQiLing:String = "XiaoQiLing";
        public static const HuoQiLing:String = "HuoQiLing";
        public static const QianNianShuYao:String = "QianNianShuYao";
        public static const LuYao:String = "LuYao";
        public static const YouNianBaiZe:String = "YouNianBaiZe";
        public static const ChengNianBaiZe:String = "ChengNianBaiZe";
        public static const HuanShouBaiZe:String = "HuanShouBaiZe";
        public static const ShenShouBaiZe:String = "ShenShouBaiZe";
        public static const KuangBaoShanZhu:String = "KuangBaoShanZhu";
        public static const CiBeiShanZhu:String = "CiBeiShanZhu";
        public static const TaiGuYuanJun:String = "TaiGuYuanJun";
        public static const FengXieShou:String = "FengXieShou";
        public static const HeiHuJing:String = "HeiHuJing";
        public static const XiaoFengHuang:String = "XiaoFengHuang";
        public static const JinChiFengHuang:String = "JinChiFengHuang";
        public static const ChangQiangJiaoYao:String = "ChangQiangJiaoYao";
        public static const DaoDunJiaoYao:String = "DaoDunJiaoYao";
        public static const YaoZhouShuShi:String = "YaoZhouShuShi";
        public static const YaoGuJiaoYao:String = "YaoGuJiaoYao";
        public static const MoNvYeMei:String = "MoNvYeMei";
        public static const JuChuiShuYao:String = "JuChuiShuYao";
        public static const JuDunShuYao:String = "JuDunShuYao";
        public static const DuanTouYao:String = "DuanTouYao";
        public static const MoWangXingTian:String = "MoWangXingTian";
        public static const ChenSiGui:String = "ChenSiGui";
        public static const ChiTouMan:String = "ChiTouMan";
        public static const MoGu:String = "MoGu";
        public static const ChiGui:String = "ChiGui";
        public static const WanYaoHuang:String = "WanYaoHuang";
        public static const XianRenZhang:String = "XianRenZhang";
        public static const ShaChong:String = "ShaChong";
        public static const KongNiao:String = "KongNiao";
        public static const WanDaoShaYao:String = "WanDaoShaYao";
        public static const MuDunShaYao:String = "MuDunShaYao";
        public static const AnYingShaYao:String = "AnYingShaYao";
        public static const ShaBaoShuShi:String = "ShaBaoShuShi";
        public static const ShaYaoWang:String = "ShaYaoWang";
        public static const ShuangRenXiYi:String = "ShuangRenXiYi";
        public static const JuDuXiYi:String = "JuDuXiYi";
        public static const DengShen:String = "DengShen";
        public static const LuoChaJianShen:String = "LuoChaJianShen";
        public static const LuoChaDaoSheng:String = "LuoChaDaoSheng";
        public static const MoJiangWuLuo:String = "MoJiangWuLuo";
        public static const XueLangYao:String = "XueLangYao";
        public static const TuYao:String = "TuYao";
        public static const HuoBaoTuYao:String = "HuoBaoTuYao";
        public static const BingHeFeiYu:String = "BingHeFeiYu";
        public static const BingHeYongShi:String = "BingHeYongShi";
        public static const BingHeShuShi:String = "BingHeShuShi";
        public static const BingJingFengHuang:String = "BingJingFengHuang";
        public static const XueShanJuYuan:String = "XueShanJuYuan";
        public static const BaiSeZhanXiong:String = "BaiSeZhanXiong";
        public static const TieJiaZhanXiong:String = "TieJiaZhanXiong";
        public static const HuangJinZhanXiong:String = "HuangJinZhanXiong";
        public static const FeiChiBingJingShou:String = "FeiChiBingJingShou";
        public static const BingJingShou:String = "BingJingShou";
        public static const YingLong:String = "YingLong";
        public static const YaoQi:String = "YaoQi";
        public static const GuiMianPo:String = "GuiMianPo";
        public static const KaiMingShou:String = "KaiMingShou";
        public static const TieJiaKaiMingShou:String = "TieJiaKaiMingShou";
        public static const YeChaQuan:String = "YeChaQuan";
        public static const YaoGu:String = "YaoGu";
        public static const GuiYan:String = "GuiYan";
        public static const YaoRao:String = "YaoRao";
        public static const ZhenMuShou:String = "ZhenMuShou";
        public static const XuanMingYaoZu:String = "XuanMingYaoZu";
        public static const XuanMingYaoJiang:String = "XuanMingYaoJiang";
        public static const DongHuangTaiYi:String = "DongHuangTaiYi";
        public static const XiaBing:String = "XiaBing";
        public static const XieJiang:String = "XieJiang";
        public static const HuSha:String = "HuSha";
        public static const GuiChengXiang:String = "GuiChengXiang";
        public static const BangJing:String = "BangJing";
        public static const LiYuJing:String = "LiYuJing";
        public static const XiaoLongNv:String = "XiaoLongNv";
        public static const SanChaJiaoRen:String = "SanChaJiaoRen";
        public static const CiBeiJiaoRen:String = "CiBeiJiaoRen";
        public static const KuangBaoJiaoRen:String = "KuangBaoJiaoRen";
        public static const JiaoRenShuShi:String = "JiaoRenShuShi";
        public static const NieHaiKuangJiao:String = "NieHaiKuangJiao";
        public static const ShuangQiangGuiZu:String = "ShuangQiangGuiZu";
        public static const YeChaGuiZu:String = "YeChaGuiZu";
        public static const GuiWang:String = "GuiWang";
        public static const GuiChai:String = "GuiChai";
        public static const CuiMingPanGuan:String = "CuiMingPanGuan";
        public static const RiYou:String = "RiYou";
        public static const YeYou:String = "YeYou";
        public static const NiuTou:String = "NiuTou";
        public static const MaMian:String = "MaMian";
        public static const MengPo:String = "MengPo";
        public static const WuDaoJiangJun:String = "WuDaoJiangJun";
        public static const BaiWuChang:String = "BaiWuChang";
        public static const HeiWuChang:String = "HeiWuChang";
        public static const YanLuoWang:String = "YanLuoWang";
        public static const ShuangJianTianBing:String = "ShuangJianTianBing";
        public static const ChangJiTianBing:String = "ChangJiTianBing";
        public static const TianJiang:String = "TianJiang";
        public static const HengJiangZhengLun:String = "HengJiangZhengLun";
        public static const HengJiangChenQi:String = "HengJiangChenQi";
        public static const QingYiXianNv:String = "QingYiXianNv";
        public static const ZiXiaXianZi:String = "ZiXiaXianZi";
        public static const LeiZhenZi:String = "LeiZhenZi";
        public static const ChiGuaTianWang:String = "ChiGuaTianWang";
        public static const ZengZhangTianWang:String = "ZengZhangTianWang";
        public static const GuangMuTianWang:String = "GuangMuTianWang";
        public static const DuoWenTianWang:String = "DuoWenTianWang";
        public static const YangJian:String = "YangJian";
        public static const HuoGui:String = "HuoGui";
        public static const ChiYanJinNiShou:String = "ChiYanJinNiShou";
        public static const BossChiYanShou:String = "BossChiYanShou";
        public static const DengShenKaiSeLin:String = "DengShenKaiSeLin";
        public static const JinGang:String = "JinGang";
        public static const DiLingGuiMu:String = "DiLingGuiMu";
        public static const DaoDunGuiZu:String = "DaoDunGuiZu";
        public static const ShuangRenShuYao:String = "ShuangRenShuYao";
        public static const DuRenShuYao:String = "DuRenShuYao";
        public static const ChangQiangShuYao:String = "ChangQiangShuYao";
        public static const MeiYingYaoShu:String = "MeiYingYaoShu";
        public static const ShuYaoWang:String = "ShuYaoWang";
        public static const LuoHuWang:String = "LuoHuWang";
        public static const JuFuShuYao:String = "JuFuShuYao";
        public static const WuDuJaoZhu:String = "WuDuJaoZhu";
        public static const JuDuYaoShu:String = "JuDuYaoShu";
        public static const YunYing:String = "YunYing";
        public static const YuZuFeiYu:String = "YuZuFeiYu";
        public static const YuZuJianLing:String = "YuZuJianLing";
        public static const JiaNiu:String = "JiaNiu";
        public static const YuZuTongLing:String = "YuZuTongLing";
        public static const JiGuanWangHu:String = "JiGuanWangHu";
        public static const RenShe:String = "RenShe";
        public static const KongSangXianZi:String = "KongSangXianZi";
        public static const MoJiaLeiShu:String = "MoJiaLeiShu";
        public static const HuanYingTaNu:String = "HuanYingTaNu";
        public static const JiGuanJiongRen:String = "JiGuanJiongRen";
        public static const HeiYiFeiYu:String = "HeiYiFeiYu";
        public static const CaoMaoJiaRen:String = "CaoMaoJiaRen";
        public static const YuZuLeiJiSi:String = "YuZuLeiJiSi";
        public static const JiuFeng:String = "JiuFeng";
        public static const TianXiDaoRen:String = "TianXiDaoRen";
        public static const JuFuShiRenMo:String = "JuFuShiRenMo";
        public static const YuZuZuZhang:String = "YuZuZuZhang";
        public static const SaFeiLuoSi:String = "SaFeiLuoSi";
        public static const KuangBaoShiRenMo:String = "KuangBaoShiRenMo";
        public static const ShiRenMoZuZhang:String = "ShiRenMoZuZhang";
        public static const DaoDunChaiLang:String = "DaoDunChaiLang";
        public static const CaiLangFengZhouShi:String = "CaiLangFengZhouShi";
        public static const BiMengJuShou:String = "BiMengJuShou";
        public static const ChaiLangDuanDao:String = "ChaiLangDuanDao";
        public static const ChaiLangLieRen:String = "ChaiLangLieRen";
        public static const ChaiLangZuZhang:String = "ChaiLangZuZhang";
        public static const XiaoTianQuanYing:String = "XiaoTianQuanYing";
        public static const DaDaDaoZhang:String = "DaDaDaoZhang";
        public static const ShuShengXian:String = "ShuShengXian";
        public static const HuaShiYan:String = "HuaShiYan";
        public static const MuTingTao:String = "MuTingTao";
        public static const HuangFeng:String = "HuangFeng";
        public static const HuTouFeng:String = "HuTouFeng";
        public static const FengWang:String = "FengWang";
        public static const TangLang:String = "TangLang";
        public static const WuCaiDieJing:String = "WuCaiDieJing";
        public static const HuaTangLang:String = "HuaTangLang";
        public static const FengBaoHuaYao:String = "FengBaoHuaYao";
        public static const CiTengHuaYao:String = "CiTengHuaYao";
        public static const LingBaoDieJing:String = "LingBaoDieJing";
        public static const MuDanXianZi:String = "MuDanXianZi";
        public static const ShuangRenHaiMa:String = "ShuangRenHaiMa";
        public static const FuShouHaiMa:String = "FuShouHaiMa";
        public static const HaiMaJiangJun:String = "HaiMaJiangJun";
        public static const ShuangTouShe:String = "ShuangTouShe";
        public static const YingWuLuoGongZhu:String = "YingWuLuoGongZhu";
        public static const HaiLongShou:String = "HaiLongShou";
        public static const HaiLongWang:String = "HaiLongWang";
        public static const BaoZiQiangBing:String = "BaoZiQiangBing";
        public static const BaoZiLieRen:String = "BaoZiLieRen";
        public static const BaoZiJuRen:String = "BaoZiJuRen";
        public static const BaoZiDaoBing:String = "BaoZiDaoBing";
        public static const BaoZiWuShi:String = "BaoZiWuShi";
        public static const BaoZiWang:String = "BaoZiWang";
        public static const KunShen:String = "KunShen";
        public static const BossQingTianMu:String = "BossQingTianMu";
        public static const BossDaoBaTu:String = "BossDaoBaTu";
        public static const DaoBaTu:String = "DaoBaTu";
        public static const YuanGuBingJingShou:String = "YuanGuBingJingShou";
        public static const BingKui:String = "BingKui";
        public static const HeBo:String = "HeBo";
        public static const HeiYanLangYao:String = "HeiYanLangYao";
        public static const HongHaiEr:String = "HongHaiEr";
        public static const TieShanGongZhu:String = "TieShanGongZhu";
        public static const NiuMoWang:String = "NiuMoWang";
        public static const LuoHanGunWuNeng:String = "LuoHanGunWuNeng";
        public static const ZhiZhangSengJieSe:String = "ZhiZhangSengJieSe";
        public static const JieLvYuanShouZuo:String = "JieLvYuanShouZuo";
        public static const ShaoDiSengDaoYuan:String = "ShaoDiSengDaoYuan";
        public static const LuoYeSengHuiXin:String = "LuoYeSengHuiXin";
        public static const XuanJingFangZhang:String = "XuanJingFangZhang";
        public static const FuHuLuoHan:String = "FuHuLuoHan";
        public static const XiangLongLuoHan:String = "XiangLongLuoHan";
        public static const QianShouBaiYeFo:String = "QianShouBaiYeFo";
        public static const ABo:String = "ABo";
        public static const HeiHu:String = "HeiHu";
        public static const GuiXianRen:String = "GuiXianRen";
        public static const HouJing:String = "HouJing";
        public static const HuoBaoHouJing:String = "HuoBaoHouJing";
        public static const QiTianDaSheng:String = "QiTianDaSheng";
        public static const HuanYingRenZhe:String = "HuanYingRenZhe";
        public static const FengYingRenZhe:String = "FengYingRenZhe";
        public static const LeiYingRenZhe:String = "LeiYingRenZhe";
        public static const FuBuBanZang:String = "FuBuBanZang";
        public static const AnHeiYinYangShi:String = "AnHeiYinYangShi";
        public static const HuanShuYinYangShi:String = "HuanShuYinYangShi";
        public static const CuiMianYinYangShi:String = "CuiMianYinYangShi";
        public static const AnPeiQingMing:String = "AnPeiQingMing";
        public static const ZhiMingWuShi:String = "ZhiMingWuShi";
        public static const HeiYingWuShi:String = "HeiYingWuShi";
        public static const ShuangDaoWuShi:String = "ShuangDaoWuShi";
        public static const GongBenWuZang:String = "GongBenWuZang";
        public static const JuLingShen:String = "JuLingShen";
        public static const NeZha:String = "NeZha";
        public static const TuoTaTianWang:String = "TuoTaTianWang";
        public static const MoHuaDuNiangZi:String = "MoHuaDuNiangZi";
        public static const LianYuChiGuiWang:String = "LianYuChiGuiWang";
        public static const MoDaoLiYi:String = "MoDaoLiYi";
        public static const WuMingYong:String = "WuMingYong";
        public static const JiangJunYong:String = "JiangJunYong";
        public static const QinShiHuang:String = "QinShiHuang";
        public static const XuFu:String = "XuFu";
        public static const LiBai:String = "LiBai";
        public static const DuFu:String = "DuFu";
        public static const YouMingYiZhiHua:String = "YouMingYiZhiHua";
        public static const ZhiLinXianRen:String = "ZhiLinXianRen";
        public static const AFei:String = "AFei";
        public static const JiaLinXianRen:String = "JiaLinXianRen";
        public static const HaiRen:String = "HaiRen";
        public static const TianLei:String = "TianLei";
        public static const FenNuDePanTao:String = "FenNuDePanTao";
        public static const WangMuNiangNiang:String = "WangMuNiangNiang";
        public static const ZhaoZeJuShou:String = "ZhaoZeJuShou";
        public static const JinCanWang:String = "JinCanWang";
        public static const TaoYao:String = "TaoYao";
        public static const TuTengShouYing:String = "TuTengShouYing";
        public static const TuTengShouLang:String = "TuTengShouLang";
        public static const TuoBaLie:String = "TuoBaLie";
        public static const BoYaZiQi:String = "BoYaZiQi";
        public static const JinMingCheng:String = "JinMingCheng";
        public static const ChuChu:String = "ChuChu";
        public static const NingCaiChen:String = "NingCaiChen";
        public static const NieXiaoQian:String = "NieXiaoQian";
        public static const ChengXianKuang:String = "ChengXianKuang";
        public static const XiaoShiMei:String = "XiaoShiMei";
        public static const ZiShu:String = "ZiShu";
        public static const ChouNiu:String = "ChouNiu";
        public static const YinHu:String = "YinHu";
        public static const MaoTu:String = "MaoTu";
        public static const SiShe:String = "SiShe";
        public static const WuMa:String = "WuMa";
        public static const WeiYang:String = "WeiYang";
        public static const ShenHou:String = "ShenHou";
        public static const YouJi:String = "YouJi";
        public static const XuGou:String = "XuGou";
        public static const HaiZhu:String = "HaiZhu";
        public static const HouYi:String = "HouYi";
        public static const HuaLangZaiXi:String = "HuaLangZaiXi";
        public static const HuaLangZhiShun:String = "HuaLangZhiShun";
        public static const JinTaiQuan:String = "JinTaiQuan";
        public static const XiaoLianGuiBing:String = "XiaoLianGuiBing";
        public static const KuLianGuiBing:String = "KuLianGuiBing";
        public static const AnXingYuShi:String = "AnXingYuShi";
        public static const FuWenShi1:String = "FuWenShi1";
        public static const FuWenShi2:String = "FuWenShi2";
        public static const TianYuZhi:String = "TianYuZhi";
        public static const ChangGongKaiShi:String = "ChangGongKaiShi";
        public static const GuiMoJiang:String = "GuiMoJiang";
        public static const TiDaoKaiShi:String = "TiDaoKaiShi";
        public static const DuMoJiang:String = "DuMoJiang";
        public static const KuangDaoKaiShi:String = "KuangDaoKaiShi";
        public static const HuanMoJiang:String = "HuanMoJiang";
        public static const AnMoJiang:String = "AnMoJiang";
        public static const GuoXinJuShi:String = "GuoXinJuShi";
        public static const HeiAnHuiHuangDi:String = "HeiAnHuiHuangDi";
        public static const YanLong:String = "YanLong";
        public static const LeiLuoHou:String = "LeiLuoHou";
        public static const FengLuoHou:String = "FengLuoHou";
        public static const LuoHouShou:String = "LuoHouShou";
        public static const BingLuoHou:String = "BingLuoHou";
        public static const MeiMo:String = "MeiMo";
        public static const LuoHouMoJiang:String = "LuoHouMoJiang";
        public static const ZhanXiuLuoZhanShi:String = "ZhanXiuLuoZhanShi";
        public static const LeiXiuLuoShuShi:String = "LeiXiuLuoShuShi";
        public static const ZhenXiuLuoMoJiang:String = "ZhenXiuLuoMoJiang";
        public static const LieXiuLuoZhanShi:String = "LieXiuLuoZhanShi";
        public static const XiuLuoWang:String = "XiuLuoWang";
        public static const FengBoYuShi:String = "FengBoYuShi";
        public static const HanBa:String = "HanBa";
        public static const ChiYou:String = "ChiYou";
        public static const NieXiaoQian2:String = "NieXiaoQian2";
        public static const FengZhiXiuXingZhe:String = "FengZhiXiuXingZhe";
        public static const JianWuHen:String = "JianWuHen";
        public static const DaShu:String = "DaShu";
        public static const KongMengXun:String = "KongMengXun";
        public static const LingBaiZi:String = "LingBaiZi";
        public static const ShiHeiZi:String = "ShiHeiZi";
        public static const QiDuanQiShi:String = "QiDuanQiShi";
        public static const JiuDuanShengShou:String = "JiuDuanShengShou";
        public static const WuYaZi:String = "WuYaZi";
        public static const HuanShouLiNiu:String = "HuanShouLiNiu";
        public static const TangBoHu:String = "TangBoHu";
        public static const HuanShouYunYing:String = "HuanShouYunYing";
        public static const DaFenQi:String = "DaFenQi";
        public static const HuanShouLingShi:String = "HuanShouLingShi";
        public static const JiuPingJiong:String = "JiuPingJiong";
        public static const ShiTouJiong:String = "ShiTouJiong";
        public static const QianBiJiong:String = "QianBiJiong";
        public static const ChenLong:String = "ChenLong";
        public static const DaMoWangBoss:String = "DaMoWangBoss";
        public static const DongHuangTaiYiBoss:String = "DongHuangTaiYiBoss";
        public static const MoWangChiYouBoss:String = "MoWangChiYouBoss";
        public static const ShiPo:String = "ShiPo";
        public static const BaoNuShiPo:String = "BaoNuShiPo";
        public static const FanTian:String = "FanTian";
        public static const BaoNuFanTian:String = "BaoNuFanTian";
        public static const BaoZiWangBoss:String = "BaoZiWangBoss";
        public static const ChiGuiWangBoss:String = "ChiGuiWangBoss";
        public static const BaoYaBoss:String = "BaoYaBoss";
        public static const NanJiangGongShou:String = "NanJiangGongShou";
        public static const NanJiangWuBing:String = "NanJiangWuBing";
        public static const WeiZhuang:String = "WeiZhuang";
        public static const ShaoSiMing:String = "ShaoSiMing";
        public static const LvGuiChen:String = "LvGuiChen";
        public static const ManZuTengJiaBing:String = "ManZuTengJiaBing";
        public static const ManZuXiangBing:String = "ManZuXiangBing";
        public static const ManZuBaoBing:String = "ManZuBaoBing";
        public static const ManHuangShenWu:String = "ManHuangShenWu";
        public static const NanManWang:String = "NanManWang";
        public static const ShaoYu:String = "ShaoYu";
        public static const LeiLing:String = "LeiLing";
        public static const HuoLing:String = "HuoLing";
        public static const DuLing:String = "DuLing";
        public static const GuiMian:String = "GuiMian";
        public static const ChiTong:String = "ChiTong";
        public static const HuoShen:String = "HuoShen";
        public static const NanJiangYingZiDaoKe:String = "NanJiangYingZiDaoKe";
        public static const NanJiangWuDuGongShou:String = "NanJiangWuDuGongShou";
        public static const NanJiangChongFengLiShi:String = "NanJiangChongFengLiShi";
        public static const JingYingXiangBing:String = "JingYingXiangBing";
        public static const PiShiNu:String = "PiShiNu";
        public static const BaoNuPiShiNu:String = "BaoNuPiShiNu";
        public static const JiaLouLuo:String = "JiaLouLuo";
        public static const BaoNuJiaLouLuo:String = "BaoNuJiaLouLuo";
        public static const AXiuLuo:String = "AXiuLuo";
        public static const BaoNuAXiuLuo:String = "BaoNuAXiuLuo";
        public static const SuMo:String = "SuMo";
        public static const BaoNuSuMo:String = "BaoNuSuMo";
        public static const FeiTianShenLong:String = "FeiTianShenLong";
        public static const JinChiShenLong:String = "JinChiShenLong";
        public static const MuLong:String = "MuLong";
        public static const ZhenTianFeiLong:String = "ZhenTianFeiLong";
        public static const ShuiLong:String = "ShuiLong";
        public static const JuFuLongWang:String = "JuFuLongWang";
        public static const HuoLong:String = "HuoLong";
        public static const LangYaXieLong:String = "LangYaXieLong";
        public static const FengLong:String = "FengLong";
        public static const DaDaoELong:String = "DaDaoELong";
        public static const LeiLong:String = "LeiLong";
        public static const ChangJiLongBing:String = "ChangJiLongBing";
        public static const BingLong:String = "BingLong";
        public static const DaDaoLongBing:String = "DaDaoLongBing";
        public static const FeiLong:String = "FeiLong";
        public static const LieYanLongBing:String = "LieYanLongBing";
        public static const HeiLong:String = "HeiLong";
        private static var _Same:Object = null;

        public function MonsterType()
        {
            return;
        }// end function

        public static function get Monsters() : Object
        {
            if (_Monsters == null)
            {
                throw new Error("还未赋值！");
            }
            return _Monsters;
        }// end function

        public static function set Monsters(param1:Object) : void
        {
            if (_Monsters != null)
            {
                throw new Error("非法赋值");
            }
            _Monsters = param1;
            return;
        }// end function

        public static function get Same() : Object
        {
            if (_Same == null)
            {
                throw new Error("还未赋值！");
            }
            return _Same;
        }// end function

        public static function set Same(param1:Object) : void
        {
            if (_Same != null)
            {
                throw new Error("非法赋值");
            }
            _Same = param1;
            return;
        }// end function

        public static function getMonsterSign(param1:int) : String
        {
            var _loc_3:String = null;
            var _loc_2:String = "";
            for (_loc_3 in Monsters)
            {
                
                if (Monsters[_loc_3][0] == param1)
                {
                    _loc_2 = _loc_3;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getMonsterName(param1:String) : String
        {
            return Monsters[param1] ? (Monsters[param1][1]) : ("");
        }// end function

        public static function getMonsterNameById(param1:int) : String
        {
            return getMonsterName(getMonsterSign(param1));
        }// end function

        public static function getMonsterIdByName(param1:String) : int
        {
            var _loc_2:String = null;
            for (_loc_2 in Monsters)
            {
                
                if (Monsters[_loc_2][1] == param1)
                {
                    return Monsters[_loc_2][0];
                }
            }
            return 0;
        }// end function

        public static function words(param1:String) : String
        {
            var _loc_2:* = Monsters[param1];
            if (_loc_2 == null)
            {
                return "";
            }
            return _loc_2[2];
        }// end function

        public static function sameResource(param1:String) : String
        {
            return Same[param1] || param1;
        }// end function

    }
}
