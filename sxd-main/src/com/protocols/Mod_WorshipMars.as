package com.protocols
{
    import com.*;

    public class Mod_WorshipMars extends Object
    {

        public function Mod_WorshipMars()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_WorshipMars_Base.mars_info, param1.worshipMars.mars_info);
            param1.registerDataCallback(Mod_WorshipMars_Base.incense, param1.worshipMars.incense);
            param1.registerDataCallback(Mod_WorshipMars_Base.get_blessing_times_and_exp_add, param1.worshipMars.get_blessing_times_and_exp_add);
            param1.registerDataCallback(Mod_WorshipMars_Base.blessing_times_and_exp_add_notify, param1.worshipMars.blessing_times_and_exp_add_notify);
            param1.registerDataCallback(Mod_WorshipMars_Base.get_remain_incense_times, param1.worshipMars.get_remain_incense_times);
            return;
        }// end function

    }
}
