package com.protocols
{
    import com.*;

    public class Mod_Furnace extends Object
    {

        public function Mod_Furnace()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Furnace_Base.player_role_info, param1.furnaceMap.getRoles);
            param1.registerDataCallback(Mod_Furnace_Base.make_favor_item, param1.furnaceMap.makeFavorItem);
            param1.registerDataCallback(Mod_Furnace_Base.submit_favor_item, param1.furnaceMap.submitFavorItem);
            param1.registerDataCallback(Mod_Furnace_Base.role_level_up, param1.furnaceMap.roleLevelUp);
            param1.registerDataCallback(Mod_Furnace_Base.get_level_up_award, param1.furnaceMap.getlevelUpAward);
            return;
        }// end function

    }
}
