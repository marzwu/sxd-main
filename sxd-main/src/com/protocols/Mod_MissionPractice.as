package com.protocols
{
    import com.*;

    public class Mod_MissionPractice extends Object
    {

        public function Mod_MissionPractice()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_MissionPractice_Base.get_practice_info, param1.missionPractice.get_practice_info);
            param1.registerDataCallback(Mod_MissionPractice_Base.start_practice, param1.missionPractice.start_practice);
            param1.registerDataCallback(Mod_MissionPractice_Base.cancel_practice, param1.missionPractice.cancel_practice);
            param1.registerDataCallback(Mod_MissionPractice_Base.quickly, param1.missionPractice.quickly);
            param1.registerDataCallback(Mod_MissionPractice_Base.notify, param1.missionPractice.notify);
            param1.registerDataCallback(Mod_MissionPractice_Base.get_continue_practice_info, param1.missionPractice.get_continue_practice_info);
            param1.registerDataCallback(Mod_MissionPractice_Base.continue_practice, param1.missionPractice.continue_practice);
            param1.registerDataCallback(Mod_MissionPractice_Base.set_auto_sale_item, param1.missionPractice.set_auto_sale_item);
            param1.registerDataCallback(Mod_MissionPractice_Base.cancel_auto_sale_item, param1.missionPractice.cancel_auto_sale_item);
            return;
        }// end function

    }
}
