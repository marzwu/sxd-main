package com.protocols
{
    import com.*;

    public class Mod_FindImmortal extends Object
    {

        public function Mod_FindImmortal()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_FindImmortal_Base.open_find_immortal, param1.findImmortal.open_find_immortal);
            param1.registerDataCallback(Mod_FindImmortal_Base.start_find_immortal, param1.findImmortal.start_find_immortal);
            param1.registerDataCallback(Mod_FindImmortal_Base.goad, param1.findImmortal.goad);
            param1.registerDataCallback(Mod_FindImmortal_Base.pickup_award, param1.findImmortal.pickup_award);
            param1.registerDataCallback(Mod_FindImmortal_Base.get_xun_xian_ling_number, param1.findImmortal.get_xun_xian_ling_number);
            return;
        }// end function

    }
}
