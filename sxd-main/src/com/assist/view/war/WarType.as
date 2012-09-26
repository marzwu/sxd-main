package com.assist.view.war
{
    import com.assist.server.*;

    public class WarType extends Object
    {
        public static const War:String = "War";
        public static const MultiWar:String = "MultiWar";
        public static const SportWar:String = "SportWar";
        public static const PKWar:String = "PKWar";
        public static const DramaWar:String = "DramaWar";
        public static const CampWar:String = "CampWar";
        public static const WorldBossWar:String = "WorldBossWar";
        public static const SuperSportWar:String = "SuperSportWar";
        public static const FactionWar:String = "FactionWar";
        public static const TakeBibleWar:String = "TakeBibleWar";
        public static const MiniFactionWar:String = "MiniFactionWar";
        public static const TowerWar:String = "TowerWar";
        public static const DuJieWar:String = "DuJieWar";
        public static const ServerWar:String = "ServerWar";
        public static const ServerFactionWar:String = "ServerFactionWar";
        public static const GetPeachWar:String = "GetPeachWar";
        public static const HeroesWar:String = "HeroesWar";
        public static const ZodiacWar:String = "ZodiacWar";
        public static const DreamSectionWar:String = "DreamSectionWar";
        public static const HaloRoleWar:String = "HaloRoleWar";
        public static const WorldFactionWar:String = "WorldFactionWar";
        public static const BeelzebubTrialsWar:String = "BeelzebubTrialsWar";
        public static const NineRegionsWar:String = "NineRegionsWar";
        public static const NineRegionsHiddenWar:String = "NineRegionsHiddenWar";
        public static const TopWarWar:String = "TopWarWar";
        public static const FactionMonsterWar:String = "FactionMonsterWar";
        private static var warData:Object = {ShenMiJiaLouLuo:[RoleStunt.QiSiHuiSheng, 5, false], ShenMiShiPo:["", 5, true]};
        private static var warStuntData:Object = {QiSiHuiSheng:QiSiHuiShengFirst};
        public static const QiSiHuiShengFirst:String = "QiSiHuiShengFirst";

        public function WarType()
        {
            return;
        }// end function

        public static function hasMonster(param1:String) : Boolean
        {
            return War == param1 || MultiWar == param1 || DramaWar == param1 || WorldBossWar == param1 || TowerWar == param1 || DuJieWar == param1 || GetPeachWar == param1 || ZodiacWar == param1 || DreamSectionWar == param1 || HaloRoleWar == param1 || NineRegionsWar == param1 || BeelzebubTrialsWar == param1 || NineRegionsHiddenWar == param1 || FactionMonsterWar == param1;
        }// end function

        public static function hasStunt(param1:String) : Boolean
        {
            return CampWar != param1 && HeroesWar != param1 && FactionWar != param1 && MultiWar != param1 && MiniFactionWar != param1 && WorldBossWar != param1 && WorldFactionWar != param1;
        }// end function

        public static function getMiniSuffix(param1:String) : String
        {
            return MultiWar == param1 || FactionWar == param1 || MiniFactionWar == param1 || WorldFactionWar == param1 ? ("Mini") : ("");
        }// end function

        public static function getSpeed(param1:String) : int
        {
            return WorldFactionWar == param1 ? (2) : (1);
        }// end function

        public static function hasSportReport(param1:String) : Boolean
        {
            return hasMonster(param1) == false || WorldBossWar == param1 || TowerWar == param1 || DuJieWar == param1 || GetPeachWar == param1 || ZodiacWar == param1 || DreamSectionWar == param1 || HaloRoleWar == param1 || BeelzebubTrialsWar == param1 || NineRegionsWar == param1 || NineRegionsHiddenWar == param1 || FactionMonsterWar == param1;
        }// end function

        public static function warAdditionalEffect(param1:String) : String
        {
            var _loc_2:* = warData[param1];
            return _loc_2 == null ? ("") : (_loc_2[0]);
        }// end function

        public static function warAdditionalRound(param1:String) : int
        {
            var _loc_2:* = warData[param1];
            return _loc_2 == null ? (-1) : (_loc_2[1]);
        }// end function

        public static function warAdditionalShowRound(param1:String) : Boolean
        {
            var _loc_2:* = warData[param1];
            return _loc_2 == null ? (false) : (_loc_2[2]);
        }// end function

        public static function warStuntEffect(param1:String) : String
        {
            var _loc_2:* = warStuntData[param1];
            return _loc_2 || "";
        }// end function

    }
}
