package com.assist.server
{
    import com.lang.client.com.assist.server.*;

    public class ProcessTipsType extends Object
    {
        public static const PartnersCount:int = 1;
        public static const Research:int = 2;
        public static const Partners:int = 3;
        public static const Gift:int = 6;
        public static const Equipment:int = 7;
        public static const Deplay:int = 8;
        public static const Practice:int = 9;
        public static const CoinsInsufficient:int = 10;
        public static const LuckyShop:int = 11;
        public static const SuperDeploy:int = 12;
        public static const StudyStunt:int = 13;
        public static const TianDiYuPai:int = 14;
        private static var _tips:Object = {};

        public function ProcessTipsType()
        {
            return;
        }// end function

        public static function getTip(param1:int) : Object
        {
            var _loc_2:* = _tips[param1] || {};
            return {type:param1, icon:_loc_2["icon"] || "", title:_loc_2["title"] || "", content:_loc_2["content"] || "", action:_loc_2["action"] || "", prior:_loc_2["prior"] || 0};
        }// end function

        public static function init() : void
        {
            addTip(PartnersCount, "PartnersCount.swf", ProcessTipsTypeLang.PartnersCountTitle, ProcessTipsTypeLang.PartnersCountContent, ProcessTipsTypeLang.PartnersCountAction, 4);
            addTip(Research, "Research.swf", ProcessTipsTypeLang.ResearchTitle, ProcessTipsTypeLang.ResearchContent, ProcessTipsTypeLang.ResearchAction, 5);
            addTip(Partners, "Partners.swf", ProcessTipsTypeLang.PartnersTitle, ProcessTipsTypeLang.PartnersContent, ProcessTipsTypeLang.PartnersAction, 3);
            addTip(Gift, "Gift.swf", ProcessTipsTypeLang.GiftTitle, ProcessTipsTypeLang.GiftContent, ProcessTipsTypeLang.GiftAction, 2);
            addTip(Equipment, "Equipment.swf", ProcessTipsTypeLang.EquipmentTitle, ProcessTipsTypeLang.EquipmentContent, ProcessTipsTypeLang.EquipmentAction, 6);
            addTip(Deplay, "Deplay.swf", ProcessTipsTypeLang.DeplayTitle, ProcessTipsTypeLang.DeplayContent, ProcessTipsTypeLang.DeplayAction, 7);
            addTip(Practice, "Practice.swf", ProcessTipsTypeLang.PracticeTitle, ProcessTipsTypeLang.PracticeContent, ProcessTipsTypeLang.PracticeAction, 8);
            addTip(CoinsInsufficient, "Rune.swf", ProcessTipsTypeLang.RuneTitle, ProcessTipsTypeLang.RuneContent, ProcessTipsTypeLang.RuneAction, 9);
            addTip(LuckyShop, "LuckyShop.swf", ProcessTipsTypeLang.LuckyShopTitle, ProcessTipsTypeLang.LuckyShopContent, ProcessTipsTypeLang.LuckyShopAction, 10);
            addTip(SuperDeploy, "SuperDeploy.swf", ProcessTipsTypeLang.SuperDeployTitle, ProcessTipsTypeLang.SuperDeployContent, ProcessTipsTypeLang.SuperDeployAction, 11);
            addTip(StudyStunt, "StudyStunt.swf", ProcessTipsTypeLang.StudyStuntTitle, ProcessTipsTypeLang.StudyStuntContent, ProcessTipsTypeLang.StudyStuntAction, 12);
            addTip(TianDiYuPai, "TianDiYuPai.swf", ProcessTipsTypeLang.TianDiYuPaiTitle, ProcessTipsTypeLang.TianDiYuPaiContent, ProcessTipsTypeLang.TianDiYuPaiAction, 13);
            return;
        }// end function

        private static function addTip(param1:int, param2:String, param3:String, param4:String, param5:String, param6:Number) : void
        {
            _tips[param1] = {icon:param2, title:param3, content:param4, action:param5, prior:param6};
            return;
        }// end function

    }
}
