package com.protocols
{
    import com.*;

    public class Mod_Chat extends Object
    {

        public function Mod_Chat()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Chat_Base.chat_with_players, param1.chat.chat_with_players);
            param1.registerDataCallback(Mod_Chat_Base.bro_to_players, param1.chat.bro_to_player);
            param1.registerDataCallback(Mod_Chat_Base.disable_player_talk, param1.chat.disable_player_talk);
            param1.registerDataCallback(Mod_Chat_Base.shield_player_talk, param1.chat.shield_player_talk);
            param1.registerDataCallback(Mod_Chat_Base.shield_player_list, param1.chat.shield_player_list);
            param1.registerDataCallback(Mod_Chat_Base.fav_friend_achievement_msg, param1.chat.fav_friend_achievement_msg);
            param1.registerDataCallback(Mod_Chat_Base.send_all, param1.chat.send_all);
            param1.registerDataCallback(Mod_Chat_Base.send_all_message, param1.chat.send_all_message);
            return;
        }// end function

    }
}
