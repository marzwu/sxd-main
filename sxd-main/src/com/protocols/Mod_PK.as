package com.protocols
{
    import com.*;

    public class Mod_PK extends Object
    {

        public function Mod_PK()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Pk_Base.start_war, param1.pkWar.start_war);
            return;
        }// end function

    }
}
