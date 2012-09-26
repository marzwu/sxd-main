package com.protocols
{
    import com.*;

    public class Mod_Tower extends Object
    {

        public function Mod_Tower()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Tower_Base.get_tower_info, param1.tower.get_tower_info);
            param1.registerDataCallback(Mod_Tower_Base.start_challenge, param1.tower.start_challenge);
            param1.registerDataCallback(Mod_Tower_Base.reset_layer, param1.tower.reset_layer);
            param1.registerDataCallback(Mod_Tower_Base.start_auto_challenge, param1.tower.start_auto_challenge);
            param1.registerDataCallback(Mod_Tower_Base.stop_auto_challenge, param1.tower.stop_auto_challenge);
            param1.registerDataCallback(Mod_Tower_Base.notify_auto_challenge_report, param1.tower.notify_auto_challenge_report);
            param1.registerDataCallback(Mod_Tower_Base.quickly_auto_challenge, param1.tower.quickly_auto_challenge);
            param1.registerDataCallback(Mod_Tower_Base.complete, param1.tower.complete);
            return;
        }// end function

    }
}
