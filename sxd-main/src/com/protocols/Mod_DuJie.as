package com.protocols
{
    import com.*;

    public class Mod_DuJie extends Object
    {

        public function Mod_DuJie()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Dujie_Base.dujie_info, param1.dujie.dujie_info);
            param1.registerDataCallback(Mod_Dujie_Base.add_player_role_state_point, param1.dujie.add_player_role_state_point);
            param1.registerDataCallback(Mod_Dujie_Base.role_list, param1.dujie.role_list);
            param1.registerDataCallback(Mod_Dujie_Base.go_dujie, param1.dujie.go_dujie);
            return;
        }// end function

    }
}
