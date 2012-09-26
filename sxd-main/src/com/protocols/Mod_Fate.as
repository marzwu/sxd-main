package com.protocols
{
    import com.*;

    public class Mod_Fate extends Object
    {

        public function Mod_Fate()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Fate_Base.get_fate_npc, param1.fate.get_fate_npc);
            param1.registerDataCallback(Mod_Fate_Base.get_temp_fate, param1.fate.get_temp_fate);
            param1.registerDataCallback(Mod_Fate_Base.pickup_fate, param1.fate.pickup_fate);
            param1.registerDataCallback(Mod_Fate_Base.sale_temp_fate, param1.fate.sale_temp_fate);
            param1.registerDataCallback(Mod_Fate_Base.get_bag_list, param1.fate.get_bag_list);
            param1.registerDataCallback(Mod_Fate_Base.buy_bag_grid, param1.fate.buy_bag_grid);
            param1.registerDataCallback(Mod_Fate_Base.get_role_fate_list, param1.fate.get_role_fate_list);
            param1.registerDataCallback(Mod_Fate_Base.wear_on, param1.fate.wear_on);
            param1.registerDataCallback(Mod_Fate_Base.wear_off_fate, param1.fate.wear_off_fate);
            param1.registerDataCallback(Mod_Fate_Base.discard_fate, param1.fate.discard_fate);
            param1.registerDataCallback(Mod_Fate_Base.appoint_fate_npc, param1.fate.appoint_fate_npc);
            param1.registerDataCallback(Mod_Fate_Base.change_fate_grid, param1.fate.change_fate_grid);
            param1.registerDataCallback(Mod_Fate_Base.merge, param1.fate.merge_fate);
            param1.registerDataCallback(Mod_Fate_Base.change_position, param1.fate.change_position);
            param1.registerDataCallback(Mod_Fate_Base.get_player_role_fate_power, param1.fate.get_player_role_fate_power);
            param1.registerDataCallback(Mod_Fate_Base.get_merge_data, param1.fate.get_merge_data);
            param1.registerDataCallback(Mod_Fate_Base.merge_all_in_bag, param1.fate.merge_all_in_bag);
            param1.registerDataCallback(Mod_Fate_Base.buy_fate_npc, param1.fate.buy_fate_npc);
            param1.registerDataCallback(Mod_Fate_Base.exchange_fate, param1.fate.exchange_fate);
            param1.registerDataCallback(Mod_Fate_Base.get_scrap_amount, param1.fate.get_scrap_amount);
            param1.registerDataCallback(Mod_Fate_Base.merge_all_normal_in_bag, param1.fate.merge_all_normal_in_bag);
            return;
        }// end function

    }
}
