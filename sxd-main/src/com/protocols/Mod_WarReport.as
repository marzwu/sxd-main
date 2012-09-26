package com.protocols
{
    import com.*;

    public class Mod_WarReport extends Object
    {

        public function Mod_WarReport()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_WarReport_Base.record_war_report, new Function());
            return;
        }// end function

    }
}
