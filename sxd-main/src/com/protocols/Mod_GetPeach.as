package com.protocols
{
    import com.*;

    public class Mod_GetPeach extends Object
    {

        public function Mod_GetPeach()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_GetPeach_Base.get_peach, param1.getPeach.get_peach);
            param1.registerDataCallback(Mod_GetPeach_Base.buy_monkeys, param1.getPeach.buy_monkeys);
            param1.registerDataCallback(Mod_GetPeach_Base.peach_info, param1.getPeach.peach_info);
            param1.registerDataCallback(Mod_GetPeach_Base.player_info, param1.getPeach.player_info);
            return;
        }// end function

    }
}
