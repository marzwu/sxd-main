package com.protocols
{
    import com.*;

    public class Mod_ServerWar extends Object
    {

        public function Mod_ServerWar()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_ServerWar_Base.get_race_step, param1.serverWar.get_race_step);
            param1.registerDataCallback(Mod_ServerWar_Base.get_standings, param1.serverWar.get_standings);
            param1.registerDataCallback(Mod_ServerWar_Base.get_race_list, param1.serverWar.get_race_list);
            param1.registerDataCallback(Mod_ServerWar_Base.get_war_result_list, param1.serverWar.get_war_result_list);
            param1.registerDataCallback(Mod_ServerWar_Base.get_race_standings, param1.serverWar.get_race_standings);
            param1.registerDataCallback(Mod_ServerWar_Base.apply, param1.serverWar.apply);
            param1.registerDataCallback(Mod_ServerWar_Base.get_player_bet, param1.serverWar.get_player_bet);
            param1.registerDataCallback(Mod_ServerWar_Base.bet, param1.serverWar.bet);
            param1.registerDataCallback(Mod_ServerWar_Base.get_bet_coin_rank, param1.serverWar.get_bet_coin_rank);
            return;
        }// end function

    }
}
