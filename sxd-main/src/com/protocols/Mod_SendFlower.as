package com.protocols
{
    import com.*;

    public class Mod_SendFlower extends Object
    {

        public function Mod_SendFlower()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_SendFlower_Base.player_send_flower_info, param1.sendFlower.player_send_flower_info);
            param1.registerDataCallback(Mod_SendFlower_Base.send_player_flower, param1.sendFlower.send_player_flower);
            param1.registerDataCallback(Mod_SendFlower_Base.send_flower_ranking, param1.sendFlower.send_flower_ranking);
            param1.registerDataCallback(Mod_SendFlower_Base.get_send_flower_ranking_week, param1.sendFlower.get_send_flower_ranking_week);
            return;
        }// end function

    }
}
