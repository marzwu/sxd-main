package com.protocols
{
    import com.*;

    public class Mod_Vip extends Object
    {

        public function Mod_Vip()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Vip_Base.get_player_vip_info, param1.vip.get_player_vip_info);
            return;
        }// end function

    }
}
