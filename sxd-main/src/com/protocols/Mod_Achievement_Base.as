package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Achievement_Base extends Object
    {
        public static const get_player_achievement_list:Object = {module:102, action:148, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const notify_complete_achievement:Object = {module:102, action:142, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil]};
        public static const fate_achievement_completed:Object = {module:102, action:10, request:[], response:[Utils.IntUtil, Utils.ByteUtil]};
        public static const Actions:Array = ["get_player_achievement_list", "notify_complete_achievement", "fate_achievement_completed"];

        public function Mod_Achievement_Base()
        {
            return;
        }// end function

    }
}
