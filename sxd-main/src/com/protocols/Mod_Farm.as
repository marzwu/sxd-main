package com.protocols
{
    import com.*;

    public class Mod_Farm extends Object
    {

        public function Mod_Farm()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Farm_Base.get_farmlandinfo_list, param1.farm.get_farmlandinfo_list);
            param1.registerDataCallback(Mod_Farm_Base.get_player_roleinfo_list, param1.farm.get_player_roleinfo_list);
            param1.registerDataCallback(Mod_Farm_Base.get_herbs_seed, param1.farm.get_herbs_seed);
            param1.registerDataCallback(Mod_Farm_Base.refresh_herbs_seed, param1.farm.refresh_herbs_seed);
            param1.registerDataCallback(Mod_Farm_Base.get_top_herbs_seed, param1.farm.get_top_herbs_seed);
            param1.registerDataCallback(Mod_Farm_Base.plant_herbs, param1.farm.plant_herbs);
            param1.registerDataCallback(Mod_Farm_Base.reclamation, param1.farm.reclamation);
            param1.registerDataCallback(Mod_Farm_Base.harvest, param1.farm.harvest);
            param1.registerDataCallback(Mod_Farm_Base.check_role_state, param1.farm.check_role_state);
            param1.registerDataCallback(Mod_Farm_Base.get_simple_farmlandinfo, param1.farm.get_simple_farmlandinfo);
            param1.registerDataCallback(Mod_Farm_Base.clear_farmland_cd, param1.farm.clear_farmland_cd);
            param1.registerDataCallback(Mod_Farm_Base.buy_coin_tree_count_info, param1.farm.buy_coin_tree_count_info);
            param1.registerDataCallback(Mod_Farm_Base.buy_coin_tree_count, param1.farm.buy_coin_tree_count);
            param1.registerDataCallback(Mod_Farm_Base.coin_tree_count_notify, param1.farm.coin_tree_count_notify);
            param1.registerDataCallback(Mod_Farm_Base.ingot_for_farmland, param1.farm.ingot_for_farmland);
            param1.registerDataCallback(Mod_Farm_Base.up_farmland_level, param1.farm.up_farmland_level);
            return;
        }// end function

    }
}
