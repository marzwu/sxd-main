package com.protocols
{
    import com.*;

    public class Mod_Research extends Object
    {

        public function Mod_Research()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Research_Base.research_list, param1.research.research_list);
            param1.registerDataCallback(Mod_Research_Base.research_upgrade, param1.research.research_upgrade);
            param1.registerDataCallback(Mod_Research_Base.clear_cd_time_show, param1.research.clear_cd_time_show);
            param1.registerDataCallback(Mod_Research_Base.clear_cd_time, param1.research.clear_cd_time);
            param1.registerDataCallback(Mod_Research_Base.research_add_list, param1.research.research_add_list);
            return;
        }// end function

    }
}
