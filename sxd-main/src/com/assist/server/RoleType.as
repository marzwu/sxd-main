package com.assist.server
{
    import com.adobe.serialization.json.*;
    import com.assist.*;
    import com.assist.view.*;
    import com.haloer.net.*;

    public class RoleType extends Object
    {
        private static var _jobLevelData:Object;
        private static const Roles:Object = {1:[JianLingNan, "剑灵男", 2, 0, 0, 60, 50, 50, 0, 1, 1, ""], 2:[JianLingNv, "剑灵女", 2, 0, 0, 60, 50, 50, 0, 1, 1, ""], 3:[WuShengNan, "武圣男", 1, 0, 0, 60, 50, 50, 0, 5, 1, ""], 4:[WuShengNv, "武圣女", 1, 0, 0, 60, 50, 50, 0, 5, 1, ""], 5:[FeiYuNan, "飞羽男", 3, 0, 0, 60, 50, 50, 0, 6, 1, ""], 6:[FeiYuNv, "飞羽女", 3, 0, 0, 60, 50, 50, 0, 6, 1, ""], 8:[JiangChen, "将臣", 5, 0, 10, 70, 50, 50, 0, 71, 1, "生前乃战功赫赫之大将军，死后受控于法力强大的赤鬼王，实力大受折损，却拥有更为强悍之灵魂，生前一代枭雄，死后亦为鬼雄，唯有重情重义之人方能够与之结交。"], 9:[ChuChu, "楚楚", 2, 0, 0, 60, 60, 50, 0, 7, 1, "武林一霸林天南之爱女，纤弱的身躯中拥有着极为倔强的韧性，爱闯荡，爱行侠仗义；个性张扬的楚楚绝对看不起畏缩胆小之人，有胆识之人方敢与她一同行走天下，除魔卫道。"], 10:[JinMingCheng, "金明成", 3, 0, 100, 65, 55, 60, 0, 8, 1, "爱憎分明，对分内之事义不容辞，追求完美；擅用弓箭，练得一手好箭术，百步穿杨，敌人闻之胆寒，总之英俊小生的打扮，却压制不了那爆动的箭。"], 11:[TianQi, "天泣", 2, 0, 5000, 80, 70, 50, 500, 9, 1, "玄阴十二剑，帅气的大招，冷俊的面容，一往无前的气势，往往让敌人不寒而栗；百年前盛名一时的天下第一剑士，拥有着无可比拟的高傲。"], 12:[JuMang, "句芒", 3, 0, 5000, 70, 80, 50, 500, 10, 1, "中国古代神话中的天神。太阳每天早上从扶桑上升起，神树扶桑归句芒管，太阳升起的那片地方也归句芒管。他的本来面目是鸟——鸟身人面，乘两龙，拥有巨大的双翼，神力无边。"], 13:[ChengXianKuang, "程仙狂", 6, 0, 0, 50, 50, 60, 0, 11, 1, "来自没落修仙门派的弟子，为了追求成仙大道，不断搜罗天下奇物帮助自己修炼；天赋极高，不断修习法术，终于小有悟道；只求能修炼成仙，不管凡俗之事，素有“成仙狂”之外号。"], 14:[XiaoShiMei, "小师妹", 1, 0, 20000, 100, 80, 50, 1000, 12, 1, "清新脱俗，却因为从小娇生惯养而蛮横霸道，不可一世；个性好强的她，由于天赋极高，倒也颇有成就；在门派中地位极高，被众多师兄弟追捧着，有她的地方便会有骚动。"], 15:[MoWangXingTian, "魔王刑天", 2, 0, 20000, 120, 60, 50, 1000, 13, 1, "中国古代神话传说中的人物。又称形天。据《山海经·海外西经》记载：“刑天与天帝争神，帝断其首，葬之常羊之山。乃刑天以乳为目，以脐为口，操干戚以舞。”"], 16:[MoNvYeMei, "魔女夜魅", 5, 0, 20000, 90, 90, 50, 1000, 72, 1, "冷艳的眼神，妖艳的身材，妖魔级别的实力；她却又有柔情的一面，哥哥魔将武罗是她入魔以后仍然记得的一个；不得不提的是她对有恩于她的万妖皇的绝对忠心，哪怕只是受了万妖皇一点恩。"], 17:[MoJiangWuLuo, "魔将武罗", 1, 0, 60000, 110, 90, 50, 1500, 14, 1, "个性狂霸直接，喜动武不爱讲话，招式霸道，追求一击杀敌；魔女夜魅之兄，因魔海之心而丧失理智，幸好亲情犹在；数百年前，曾大战天将于大漠之中，只为与心爱之人在一起。"], 18:[YaoRao, "妖娆", 6, 0, 100000, 100, 100, 100, 2000, 15, 1, "说不尽万种妖娆，画不出千般艳冶，一把多情扇，柔煞多少男儿；魔将武罗兄妹的至交，当年武罗失踪之时，曾经踏遍各界寻找，却始终未果，后来愤而投奔妖界，斩断三千青丝。"], 19:[YingLong, "应龙", 6, 0, 100000, 50, 100, 150, 2000, 16, 1, "《辞源》说“应龙”是有翅膀的千年龙，五百年的被称为角龙；龙是不凡之物，寿命奇长，应龙更是龙中之贵；当年大禹治水的得力助手，镇守一方，保境安民，受万民爱戴。"], 20:[MengPo, "孟婆", 6, 0, 150000, 50, 200, 100, 3000, 17, 1, "因看透世间恩怨情仇，于是来到忘川河边，在奈何桥的桥头立起一口大锅，将世人放不下的思绪炼化成了孟婆汤让阴魂喝下，忘记生前，卸下包袱，走入下一个轮回。"], 22:[ZhangMaZi, "张麻子", 2, 0, 0, 60, 50, 50, 0, 70, 1, "一时义愤，怒杀贪官，为百姓所敬仰，却无奈落草为寇的当世豪杰，专练外功，肉体强悍非常，眉目间自有一股浩然之气，并笃信正义长存。"], 23:[XiaoXianTong, "小仙童", 6, 0, 1000, 60, 60, 60, 250, 16, 1, "灵气十足之仙童，自幼跟随得道散仙修习高深法术，练就一身本领；法力虽强，却涉世未深，战斗经验少，常吃亏于此；怀着一颗赤子之心方是其修炼速度神速的最大原由。"], 24:[NieXiaoQian, "聂小倩", 6, 0, 60000, 50, 120, 80, 1500, 78, 1, "百媚回眸，苍颜易逝，本以为注定孤独一生的她，却在寺庙东角那片幽静的竹林邂逅了宁采臣；这个她要花一生来爱的男子，只为了宁采臣的一句话“你让我感受到了存在的意义！”"], 25:[NingCaiChen, "宁采臣", 6, 0, 60000, 50, 80, 120, 1500, 75, 1, "他常常对人说：“我一生中没有爱过第二个女人。” ；没错，聂小倩便是他这一生最爱的女子；本是书生的他，为了守护心爱的女子，弃学从术，修习强大的法术来保护小倩。"], 26:[WanYaoHuang, "万妖皇", 5, 0, 100000, 160, 90, 50, 2500, 73, 1, "众妖之皇，凭借自身强大妖气而修炼成为万妖之主；率领众妖与各大高手经过七七四十九天的激战之后，最终因蜀山掌门联合两派精英之力施展“仙束”大阵，将其封印与炼妖塔之中。"], 27:[CaiShen, "财神", 6, 0, 120000, 50, 50, 60, 0, 77, 1, ""], 28:[JiuXianWeng, "酒仙翁", 6, 0, 70000, 50, 50, 60, 0, 76, 1, ""], 29:[AKuan, "阿宽", 1, 0, 100, 60, 60, 60, 0, 74, 1, "体型肥硕似熊，憨态可掬，头圆尾短，重视肉体与气之修炼，经常能够爆发出绝强的招式；喜爱呆在幽静清新的竹林，崇尚自然，无牵无挂，静而能动，颇有隐世高手的风范。"], 30:[RanKui, "燃魁", 1, 0, 5000, 70, 70, 60, 500, 79, 1, "栖息于岩溶洞窟中的岩浆生物，全身由火炎组成，每日靠吞噬岩浆为生；炙热的岩浆衍生出的怪物极具火炎之爆破力。"], 31:[LuoChaJianShen, "罗刹剑神", 2, 0, 50000, 100, 100, 50, 1500, 80, 1, "罗刹，远古八部魔之一，冷酷的外表之下，使他们在月光之下拥有神秘力量；作为罗刹的守护者，在他们眼中，没有好坏之分，只有敌我之分；"], 32:[XiaoLongNv, "小龙女", 6, 0, 150000, 80, 120, 150, 3000, 81, 1, "深处龙宫的她偶然听到了世界上最动听的曲子“玉箫神曲”，她出宫寻找曲声来源，吹奏此曲之人早已远去，固执的她会穷其一生来寻找“玉箫神曲”的主人。"], 33:[WuDaoJiangJun, "五道将军", 5, 0, 150000, 180, 120, 50, 3000, 72, 1, "传为东岳大帝手下属神和重要助手，掌管世人间生死、荣禄，是阴间的大神，地位比阎罗王前的判官都高。五道将军具有监督阎王、判官，或纠正其不公行为的莫大权利。"], 34:[LeiZhenZi, "雷震子", 3, 0, 200000, 120, 180, 100, 4000, 82, 1, "传闻乃道门中云中子的爱徒，面如青靛，发似朱砂，眼睛暴湛，牙齿横生，出于脣外，身躯长有二丈；嫉恶如仇，手持罚雷法器，可上诛天神，下铲奸恶。"], 35:[YangJian, "杨戬", 5, 0, 200000, 220, 100, 80, 4000, 73, 1, "杨戬也被人们称为&quot;二郎神&quot;，人神混血，法术无边，撒豆成兵，通晓七十三般变化，阙庭有神眼，手持二万五千二百斤的三尖两刃戟三尖两刃枪为女娲补天的五彩石炼成，座下有神兽哮天犬。"], 36:[LuoHuWang, "罗虎王", 1, 0, 260000, 200, 150, 100, 5000, 83, 1, "虎族之王，盘踞于巴蜀之中，为一方霸主；虎族拥有强大的肉体力量，群居的习性，形成了一个强大族群；追求极限和崇尚武力是虎族的信仰和强大的秘密。"], 37:[MeiYingYaoShu, "魅影", 6, 0, 260000, 100, 150, 200, 5000, 84, 1, "南蛮巫师相信万物有灵，而且可以通过精神感召祖巫降临，并能召唤各种生灵助战，修行传说中的通零术，不需具备强横的力量，讲求一种精神信仰和精神力修为，成效极快。"], 38:[ShiRenMoZuZhang, "龅牙", 5, 0, 330000, 300, 100, 100, 6000, 71, 1, "是丑陋又贪婪的大型人型生物，属于天性邪恶的生物之一。他们既懒惰又凶暴，会出现在各种陆地、水域、地下洞穴，为了掠食的方便，通常会住在目标受害生物聚落附近。"], 39:[HeiYiFeiYu, "黑羽", 3, 0, 330000, 200, 200, 100, 6000, 85, 1, "白天，他们展开双翼，面向阳光，吸收奇迹之树的灵力，自由的在空中嬉戏翱翔；夜间，当灵力耗尽，他们收起双翼，回到奇迹森林，在夜色中沉沉睡去。"], 40:[SaFeiLuoSi, "萨菲罗斯", 2, 0, 400000, 350, 100, 100, 7000, 86, 1, "伙伴原型是经典角色扮演单机游戏最终幻想7正传的终极大反派；最后的BOSS。从前是神罗公司最强大的战士，在杰诺瓦计划的人体试验里、体内被注入杰诺瓦的细胞。"], 41:[JiuFeng, "九凤", 2, 0, 400000, 200, 200, 150, 7000, 87, 1, "九头鸟形象的出现，最早源于楚人的九凤神鸟。《山海经·大荒北经》中说：&quot;大荒之中，有山名曰北极柜。海水北注焉。有神九首，人面鸟身，句曰九凤&quot;。"], 42:[DaDaDaoZhang, "达达道长", 6, 2, 1500000, 250, 300, 400, 60000, 92, 1, ""], 43:[ShuShengXian, "书生贤", 6, 2, 1500000, 250, 400, 300, 60000, 93, 1, ""], 44:[HuaShiYan, "画师燕", 6, 2, 1500000, 250, 350, 350, 60000, 94, 1, ""], 45:[MuTingTao, "大魔王", 1, 2, 1600000, 600, 200, 200, 60000, 95, 1, ""], 46:[JiaLinXianRen, "加林仙人", 3, 2, 1600000, 400, 300, 300, 60000, 96, 1, ""], 47:[ZhiLinXianRen, "志林仙人", 2, 2, 1600000, 300, 400, 300, 60000, 97, 1, ""], 48:[MuDanXianZi, "牡丹仙子", 6, 0, 480000, 100, 100, 400, 8000, 100, 1, "花宗宗主，率领全宗守护着圣地醉花荫，与世人无争，清新脱俗，长得貌美如花的牡丹仙子是花宗百年以来最强的宗主。"], 49:[HeBo, "河伯", 6, 0, 480000, 150, 150, 300, 8000, 101, 1, "冰晶族族长，族人冰寒的特性，让他们难以离开号称千年寒地的冰晶河。河伯自继任族长以来，兢兢业业，公正不阿，率族中高手内安族民，外抗强敌。"], 50:[HongHaiEr, "红孩儿", 5, 0, 560000, 200, 250, 200, 10000, 102, 1, "牛魔王和铁扇公主之子，号圣婴大王，住在号山枯松涧火云洞。红孩儿是他的乳名.他使用一杆八丈火尖枪，在火焰山修练三百年，练成三昧真火，十分了得。"], 51:[TieShanGongZhu, "铁扇公主", 6, 0, 560000, 200, 200, 250, 10000, 103, 1, "又叫罗刹女，是女妖中十分厉害的一个，长得漂亮俊俏，与牛魔王是夫妻。中国古典名著《西游记》中人物，住在翠云山芭蕉洞。"], 52:[NiuMoWang, "牛魔王", 5, 0, 560000, 400, 150, 100, 10000, 104, 1, "&quot;号称“大力牛魔王”，乃齐天大圣孙悟空的结拜兄弟，手使一根混铁棍，坐骑辟水金睛兽，神通广大，法力无边，妻子是铁扇公主，儿子红孩儿。"], 53:[ABo, "阿波", 1, 0, 640000, 300, 300, 100, 12000, 105, 1, "阿波和阿宽是一对兄弟，阿波是哥哥，他们同出一师门，后阿波为追求更高武道，违背门规，被逐出师门，从此浪迹天涯，四处挑战强者！"], 54:[JuLingShen, "巨灵神", 5, 0, 700000, 500, 200, 50, 14000, 106, 1, "巨灵神力大无穷，可举高山，劈大石。古时人间洪水泛滥，世人疾苦不堪，天帝乃命巨灵神下凡，一夜之间搬走阻拦水流的群山，疏通水道，解救万民。"], 55:[GongBenWuZang, "宫本武藏", 2, 0, 800000, 500, 200, 100, 16000, 107, 1, "宫本武藏，日本厉害的剑术家，与佐佐木小次郎决战而一举成名。依靠不断的战斗来提升剑道，向死而生，百折不屈，这便是他武士的精神。"], 56:[HaiRen, "海人", 1, 2, 1700000, 500, 300, 200, 60000, 98, 1, ""], 57:[AFei, "阿飞", 2, 2, 1700000, 400, 400, 400, 60000, 99, 1, ""], 58:[QiTianDaSheng, "齐天大圣", 5, 0, 1000000, 500, 250, 100, 20000, 108, 1, "齐天大圣，即孙悟空，会七十二变，有一双火眼金睛；一个筋斗能翻十万八千里；保护唐僧西天取经，历经九九八十一难，取回真经终成正果，被封为斗战胜佛。"], 59:[HouYi, "后羿", 3, 0, 1200000, 500, 300, 100, 24000, 110, 1, "在古老的中国神话中，后羿是一个盖世英雄——他先后射下九个太阳，使气候风调雨顺；杀死众多吃人的猛禽恶兽，使人类安居乐业。"], 60:[ChangE, "嫦娥", 6, 0, 1300000, 100, 100, 450, 30000, 123, 1, "后羿妻子，在道教中，嫦娥为月神，又称太阴星君，道教以月为阴之精，尊称为月宫黄华素曜元精圣后太阴元君，或称月宫太阴皇君孝道明王，作女神像。"], 61:[NieXiaoQian1, "仙聂小倩", 6, 1, 60000, 80, 130, 150, 3000, 124, 4, "百媚回眸，苍颜易逝，本以为注定孤独一生的她，却在寺庙东角那片幽静的竹林邂逅了宁采臣；这个她要花一生来爱的男子，只为了宁采臣的一句话“你让我感受到了存在的意义！”"], 62:[YangJian1, "仙杨戬", 5, 1, 200000, 300, 110, 100, 6000, 125, 4, "杨戬也被人们称为&quot;二郎神&quot;，人神混血，法术无边，撒豆成兵，通晓七十三般变化，阙庭有神眼，手持二万五千二百斤的三尖两刃戟三尖两刃枪为女娲补天的五彩石炼成，座下有神兽哮天犬。"], 63:[TieShanGongZhu1, "仙铁扇公主", 6, 1, 560000, 250, 250, 350, 20000, 126, 4, "又叫罗刹女，是女妖中十分厉害的一个，长得漂亮俊俏，与牛魔王是夫妻。中国古典名著《西游记》中人物，住在翠云山芭蕉洞。"], 64:[MoWangXingTian1, "仙魔王刑天", 2, 1, 20000, 150, 100, 60, 2000, 127, 4, "中国古代神话传说中的人物。又称形天。据《山海经·海外西经》记载：“刑天与天帝争神，帝断其首，葬之常羊之山。乃刑天以乳为目，以脐为口，操干戚以舞。”"], 65:[XianMengPo, "仙孟婆", 6, 1, 150000, 100, 210, 200, 5000, 128, 4, "因看透世间恩怨情仇，于是来到忘川河边，在奈何桥的桥头立起一口大锅，将世人放不下的思绪炼化成了孟婆汤让阴魂喝下，忘记生前，卸下包袱，走入下一个轮回。"], 66:[XianWanYaoHuang, "仙万妖皇", 5, 1, 100000, 180, 120, 50, 3000, 141, 4, "众妖之皇，凭借自身强大妖气而修炼成为万妖之主；率领众妖与各大高手经过七七四十九天的激战之后，最终因蜀山掌门联合两派精英之力施展“仙束”大阵，将其封印与炼妖塔之中。"], 67:[JiuTianXianNv, "九天仙女", 6, 0, 700000, 150, 150, 350, 14000, 142, 1, "后羿携手嫦娥私奔之后，原本爱慕嫦娥的天蓬心碎离开仙界，而偷偷爱恋着天蓬的九天仙女目睹心上人伤心离开之后，自己也黯然离去。"], 68:[WangMu, "王母娘娘", 6, 0, 1300000, 150, 150, 450, 20000, 143, 1, "是掌管灾疫和刑罚的大神，后于流传过程中逐渐女性化与温和化，而成为慈祥的女神。相传王母住在昆仑仙岛，王母的瑶池蟠桃园，园里种有蟠桃，食之可长生不老。"], 69:[TianPengYuanShuai, "天蓬元帅", 5, 0, 1600000, 600, 300, 150, 40000, 144, 1, "玉皇大帝座下的天蓬元帅，主管天河。因醉酒调戏嫦娥被逐出天界，到人间投胎，却又错投猪胎，嘴脸与猪相似。他会点变身术，能腾云驾雾，使用的兵器是九齿钉钯。"], 70:[ShenYangJian, "神杨戬", 5, 3, 200000, 400, 250, 150, 10000, 147, 4, "杨戬也被人们称为&quot;二郎神&quot;，人神混血，法术无边，撒豆成兵，通晓七十三般变化，阙庭有神眼，手持二万五千二百斤的三尖两刃戟三尖两刃枪为女娲补天的五彩石炼成，座下有神兽哮天犬。"], 71:[HuangFeiHu, "黄飞虎", 5, 0, 800000, 600, 250, 100, 18000, 148, 1, "为雪商纣王调戏并逼死其夫人之耻辱，黄飞虎经过了五关，他亲率一千家将，偕同二弟、三子、四友投降姜尚讨伐纣王，被封武成王，与姜子牙率兵直逼朝歌。"], 72:[ShenMiJiaLouLuo, "神秘迦楼罗", 9, 0, 1000, 10, 10, 10, 100, 2, 1, ""], 73:[ShenMiShiPo, "神秘湿婆", 10, 0, 111, 10, 110, 10, 100, 149, 1, ""], 74:[SanXianDaZuo, "大罗金仙", 2, 0, 10, 10, 10, 10, 100, 1, 1, ""], 75:[ChenXiang, "仙沉香", 6, 1, 0, 200, 200, 400, 25000, 154, 2, "神话传说人物，三圣母之子，二郎神的外甥。其母因私通凡人被杨戬压于华山下，沉香成人后，寻母华山，遇何仙姑授以仙法，又窃得萱花神斧，与其舅二郎神大战于华山，救出母亲。"], 76:[HuLuWa, "葫芦娃", 1, 0, 1000000, 600, 350, 200, 25000, 153, 1, "七只神奇的葫芦，七个本领超群的兄弟，为救亲人前赴后继，大显奇能，与法力无边的妖精进行了一场场扣人心弦较量。"], 77:[ZhuBaJie, "仙猪八戒", 5, 1, 0, 150, 150, 150, 4000, 156, 2, "猪八戒性格温和，憨厚单纯，力气大，但是好吃懒做，爱占小便宜，爱贪图女色，经常被妖怪所迷，对师兄的话算得上言听计从，一同护送唐僧西天取经。"], 78:[LvDongBin, "吕洞宾", 2, 0, 640000, 550, 350, 100, 30000, 155, 1, "八仙中最仙风道骨的剑仙，酷好酒，剑法超凡入圣，传闻他用剑只为它能斩断世间一切烦恼。"], 79:[HeXianGu, "何仙姑", 6, 0, 1000000, 200, 200, 400, 20000, 157, 1, "某日，偶遇剑仙吕洞宾，被他点化，开始踏上修仙之路，颇有悟性，对吕仙身怀感激，不知所起。"]};
        public static const JianLingNan:String = "JianLingNan";
        public static const JianLingNv:String = "JianLingNv";
        public static const WuShengNan:String = "WuShengNan";
        public static const WuShengNv:String = "WuShengNv";
        public static const FeiYuNan:String = "FeiYuNan";
        public static const FeiYuNv:String = "FeiYuNv";
        public static const JiangChen:String = "JiangChen";
        public static const ChuChu:String = "ChuChu";
        public static const JinMingCheng:String = "JinMingCheng";
        public static const TianQi:String = "TianQi";
        public static const JuMang:String = "JuMang";
        public static const ChengXianKuang:String = "ChengXianKuang";
        public static const XiaoShiMei:String = "XiaoShiMei";
        public static const MoWangXingTian:String = "MoWangXingTian";
        public static const MoNvYeMei:String = "MoNvYeMei";
        public static const MoJiangWuLuo:String = "MoJiangWuLuo";
        public static const YaoRao:String = "YaoRao";
        public static const YingLong:String = "YingLong";
        public static const MengPo:String = "MengPo";
        public static const ZhangMaZi:String = "ZhangMaZi";
        public static const XiaoXianTong:String = "XiaoXianTong";
        public static const NieXiaoQian:String = "NieXiaoQian";
        public static const NingCaiChen:String = "NingCaiChen";
        public static const WanYaoHuang:String = "WanYaoHuang";
        public static const CaiShen:String = "CaiShen";
        public static const JiuXianWeng:String = "JiuXianWeng";
        public static const AKuan:String = "AKuan";
        public static const RanKui:String = "RanKui";
        public static const LuoChaJianShen:String = "LuoChaJianShen";
        public static const XiaoLongNv:String = "XiaoLongNv";
        public static const WuDaoJiangJun:String = "WuDaoJiangJun";
        public static const LeiZhenZi:String = "LeiZhenZi";
        public static const YangJian:String = "YangJian";
        public static const LuoHuWang:String = "LuoHuWang";
        public static const MeiYingYaoShu:String = "MeiYingYaoShu";
        public static const ShiRenMoZuZhang:String = "ShiRenMoZuZhang";
        public static const HeiYiFeiYu:String = "HeiYiFeiYu";
        public static const SaFeiLuoSi:String = "SaFeiLuoSi";
        public static const JiuFeng:String = "JiuFeng";
        public static const DaDaDaoZhang:String = "DaDaDaoZhang";
        public static const ShuShengXian:String = "ShuShengXian";
        public static const HuaShiYan:String = "HuaShiYan";
        public static const MuTingTao:String = "MuTingTao";
        public static const JiaLinXianRen:String = "JiaLinXianRen";
        public static const ZhiLinXianRen:String = "ZhiLinXianRen";
        public static const MuDanXianZi:String = "MuDanXianZi";
        public static const HeBo:String = "HeBo";
        public static const HongHaiEr:String = "HongHaiEr";
        public static const TieShanGongZhu:String = "TieShanGongZhu";
        public static const NiuMoWang:String = "NiuMoWang";
        public static const ABo:String = "ABo";
        public static const JuLingShen:String = "JuLingShen";
        public static const GongBenWuZang:String = "GongBenWuZang";
        public static const HaiRen:String = "HaiRen";
        public static const AFei:String = "AFei";
        public static const QiTianDaSheng:String = "QiTianDaSheng";
        public static const HouYi:String = "HouYi";
        public static const ChangE:String = "ChangE";
        public static const NieXiaoQian1:String = "NieXiaoQian1";
        public static const YangJian1:String = "YangJian1";
        public static const TieShanGongZhu1:String = "TieShanGongZhu1";
        public static const MoWangXingTian1:String = "MoWangXingTian1";
        public static const XianMengPo:String = "XianMengPo";
        public static const XianWanYaoHuang:String = "XianWanYaoHuang";
        public static const JiuTianXianNv:String = "JiuTianXianNv";
        public static const WangMu:String = "WangMu";
        public static const TianPengYuanShuai:String = "TianPengYuanShuai";
        public static const ShenYangJian:String = "ShenYangJian";
        public static const HuangFeiHu:String = "HuangFeiHu";
        public static const ShenMiJiaLouLuo:String = "ShenMiJiaLouLuo";
        public static const ShenMiShiPo:String = "ShenMiShiPo";
        public static const SanXianDaZuo:String = "SanXianDaZuo";
        public static const ChenXiang:String = "ChenXiang";
        public static const HuLuWa:String = "HuLuWa";
        public static const ZhuBaJie:String = "ZhuBaJie";
        public static const LvDongBin:String = "LvDongBin";
        public static const HeXianGu:String = "HeXianGu";
        private static const Jobs:Object = {1:[WuSheng, "武圣", 0, 0, 0, 25, 0, 20, 0], 2:[JianLing, "剑灵", 15, 20, 15, 0, 0, 0, 0], 3:[FeiYu, "飞羽", 30, 5, 0, 0, 0, 0, 10], 5:[JiangXing, "将星", 10, 0, 15, 0, 0, 0, 0], 6:[ShuShi, "术士", 25, 0, 0, 0, 0, 0, 0], 7:[FangShi, "方士", 0, 15, 0, 10, 0, 0, 0], 8:[MT, "MT", undefined, undefined, undefined, undefined, undefined, undefined], 9:[DPS, "DPS", undefined, undefined, undefined, undefined, undefined, undefined], 10:[FaShu, "法术", undefined, undefined, undefined, undefined, undefined, undefined], 11:[GongJian, "弓箭", undefined, undefined, undefined, undefined, undefined, undefined]};
        public static const WuSheng:String = "WuSheng";
        public static const JianLing:String = "JianLing";
        public static const FeiYu:String = "FeiYu";
        public static const JiangXing:String = "JiangXing";
        public static const ShuShi:String = "ShuShi";
        public static const FangShi:String = "FangShi";
        public static const MT:String = "MT";
        public static const DPS:String = "DPS";
        public static const FaShu:String = "FaShu";
        public static const GongJian:String = "GongJian";
        public static const RoleUnlockMod0:int = 1;
        public static const RoleUnlockMod1:int = 2;
        public static const RoleUnlockMod2:int = 3;
        public static const RoleUnlockMod3:int = 4;
        public static const Nan:String = "Nan";
        public static const Nv:String = "Nv";

        public function RoleType()
        {
            return;
        }// end function

        public static function loadJobLevelData(param1:Function, param2:Function = null) : void
        {
            var callback:* = param1;
            var error:* = param2;
            if (_jobLevelData)
            {
                RoleType.callback();
                return;
            }
            var url:* = URI.assetsUrl + "templet/role/role_job_level_data.txt";
            url = url + ("?v=" + URI.getVersion(url));
            var http:* = new HTTP();
            http.onComplete = function (param1:String) : void
            {
                formatData(JSON.decode(param1));
                callback();
                return;
            }// end function
            ;
            http.load(url);
            return;
        }// end function

        private static function formatData(param1:Object) : void
        {
            _jobLevelData = param1;
            return;
        }// end function

        public static function getJobExp(param1:int, param2:int) : int
        {
            return _jobLevelData[param1] ? (_jobLevelData[param1][(param2 - 1)] || 0) : (0);
        }// end function

        public static function getJobMaxLevel(param1:int) : int
        {
            var _loc_2:* = _jobLevelData[param1] ? (_jobLevelData[param1].length) : (0);
            return _loc_2;
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

        public static function getJobSign(param1:int) : String
        {
            return Jobs[param1] ? (Jobs[param1][0]) : ("");
        }// end function

        public static function getJobSignByRoleId(param1:int) : String
        {
            var _loc_2:* = getJobIdByRoleId(param1);
            return getJobSign(_loc_2);
        }// end function

        public static function getJobName(param1:int) : String
        {
            return Jobs[param1] ? (Jobs[param1][1]) : ("");
        }// end function

        public static function getRoleFame(param1:int) : int
        {
            return Roles[param1] ? (Roles[param1][4]) : (0);
        }// end function

        public static function getJobIdByRoleSign(param1:String) : int
        {
            var _loc_2:* = getRoleId(param1);
            return getJobIdByRoleId(_loc_2);
        }// end function

        public static function getJobIdByJobSign(param1:String) : int
        {
            var _loc_2:Object = null;
            for (_loc_2 in Jobs)
            {
                
                if (Jobs[_loc_2][0] == param1)
                {
                    return _loc_2 as int;
                }
            }
            return 0;
        }// end function

        public static function getJobNameByRoleSign(param1:String) : String
        {
            var _loc_2:* = getJobIdByRoleSign(param1);
            return getJobName(_loc_2);
        }// end function

        public static function isMainRole(param1:String) : Boolean
        {
            return JianLingNan == param1 || JianLingNv == param1 || WuShengNan == param1 || WuShengNv == param1 || FeiYuNan == param1 || FeiYuNv == param1;
        }// end function

        public static function getRoleGender(param1:int) : String
        {
            var _loc_2:* = getRoleSign(param1);
            return /Nan$""Nan$/.test(_loc_2) ? (Nan) : (Nv);
        }// end function

        public static function getRoleType(param1:int) : int
        {
            if (Roles[param1])
            {
                return Roles[param1][3];
            }
            return 0;
        }// end function

        public static function isPurpleRole(param1:int) : Boolean
        {
            return getRoleType(param1) == 1;
        }// end function

        public static function getRoleStrength(param1:int) : int
        {
            return Roles[param1] ? (Roles[param1][5]) : (0);
        }// end function

        public static function getRoleAgile(param1:int) : int
        {
            return Roles[param1] ? (Roles[param1][6]) : (0);
        }// end function

        public static function getRoleIntellect(param1:int) : int
        {
            return Roles[param1] ? (Roles[param1][7]) : (0);
        }// end function

        public static function getRoleInitialHealth(param1:int) : int
        {
            return Roles[param1] ? (Roles[param1][8]) : (0);
        }// end function

        public static function getRoleStuntId(param1:int) : int
        {
            return Roles[param1] ? (Roles[param1][9]) : (0);
        }// end function

        public static function getJobCritical(param1:int) : int
        {
            return Jobs[param1] ? (Jobs[param1][2]) : (0);
        }// end function

        public static function getJobDodge(param1:int) : int
        {
            return Jobs[param1] ? (Jobs[param1][3]) : (0);
        }// end function

        public static function getJobHit(param1:int) : int
        {
            return Jobs[param1] ? (Jobs[param1][4]) : (0);
        }// end function

        public static function getJobBlock(param1:int) : int
        {
            return Jobs[param1] ? (Jobs[param1][5]) : (0);
        }// end function

        public static function getJobBreakBlock(param1:int) : int
        {
            return Jobs[param1] ? (Jobs[param1][6]) : (0);
        }// end function

        public static function getJobBreakCritical(param1:int) : int
        {
            return Jobs[param1] ? (Jobs[param1][7]) : (0);
        }// end function

        public static function getJobKill(param1:int) : int
        {
            return Jobs[param1] ? (Jobs[param1][8]) : (0);
        }// end function

        public static function getRoleInfo(param1:int) : String
        {
            return Roles[param1] ? (Roles[param1][11]) : ("");
        }// end function

        public static function getRoleColorById(param1:int) : uint
        {
            var _loc_2:* = getRoleType(param1);
            if (_loc_2 == 1)
            {
                return HtmlText.Purple;
            }
            if (_loc_2 == 3)
            {
                return HtmlText.Yellow;
            }
            return HtmlText.White;
        }// end function

        public static function checkSuperRole(param1:int) : Boolean
        {
            var _loc_2:* = Roles[param1];
            var _loc_3:* = _loc_2[10];
            if (_loc_3 == RoleUnlockMod1 || _loc_3 == RoleUnlockMod2)
            {
                return true;
            }
            return false;
        }// end function

        public static function getRoleListForUnlock(param1:int) : Array
        {
            var _loc_3:String = null;
            var _loc_4:Array = null;
            var _loc_2:Array = [];
            for (_loc_3 in Roles)
            {
                
                _loc_4 = Roles[_loc_3];
                if (_loc_4[10] == param1)
                {
                    _loc_2.push(_loc_4);
                }
            }
            return _loc_2;
        }// end function

        public static function getRoleUnlockMod(param1:int) : int
        {
            return Roles[param1] ? (Roles[param1][10]) : (0);
        }// end function

    }
}
