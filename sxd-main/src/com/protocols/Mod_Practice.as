package com.protocols
{
    import com.*;

    public class Mod_Practice extends Object
    {

        public function Mod_Practice()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Practice_Base.quickly, param1.practice.quickly);
            param1.registerDataCallback(Mod_Practice_Base.quickly_all, param1.practice.quickly_all);
            return;
        }// end function

    }
}
