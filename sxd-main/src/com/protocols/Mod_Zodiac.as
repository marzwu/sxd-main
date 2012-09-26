package com.protocols
{
    import com.*;

    public class Mod_Zodiac extends Object
    {

        public function Mod_Zodiac()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Zodiac_Base.zodiac_info, param1.zodiac.zodiac_info);
            param1.registerDataCallback(Mod_Zodiac_Base.challenge, param1.zodiac.challenge);
            return;
        }// end function

    }
}
