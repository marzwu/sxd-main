package com.protocols
{
    import com.*;

    public class Mod_Town extends Object
    {

        public function Mod_Town()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Town_Base.enter_town, param1.town.enter_town);
            param1.registerDataCallback(Mod_Town_Base.leave_town, param1.town.leave_town);
            param1.registerDataCallback(Mod_Town_Base.move_to, param1.town.move_to);
            param1.registerDataCallback(Mod_Town_Base.get_players, param1.town.get_players);
            param1.registerDataCallback(Mod_Town_Base.player_follow_role_change, param1.town.player_follow_role_change);
            param1.registerDataCallback(Mod_Town_Base.player_follow_setting_change, param1.town.player_follow_setting_change);
            param1.registerDataCallback(Mod_Town_Base.player_count, param1.town.player_count);
            return;
        }// end function

    }
}
