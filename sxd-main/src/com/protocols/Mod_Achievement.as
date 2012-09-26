package com.protocols
{
    import com.*;

    public class Mod_Achievement extends Object
    {

        public function Mod_Achievement()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Achievement_Base.get_player_achievement_list, param1.achievement.get_player_achievement_list);
            param1.registerDataCallback(Mod_Achievement_Base.notify_complete_achievement, param1.achievement.notify_complete_achievement);
            param1.registerDataCallback(Mod_Achievement_Base.fate_achievement_completed, param1.achievement.fate_achievement_completed);
            return;
        }// end function

    }
}
