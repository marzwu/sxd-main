package com.protocols
{
    import com.*;

    public class Mod_WeekRanking extends Object
    {

        public function Mod_WeekRanking()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_WeekRanking_Base.get_week_ranking, param1.weekRanking.get_week_ranking);
            param1.registerDataCallback(Mod_WeekRanking_Base.get_week_ranking_first_player, param1.weekRanking.get_First);
            return;
        }// end function

    }
}
