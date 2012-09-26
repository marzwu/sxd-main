package com.protocols
{
    import com.*;

    public class Mod_LuckyWheel extends Object
    {

        public function Mod_LuckyWheel()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_LuckyWheel_Base.open_lucky_wheel, param1.luckyWheel.open_lucky_wheel);
            param1.registerDataCallback(Mod_LuckyWheel_Base.start_lucky_wheel, param1.luckyWheel.start_lucky_wheel);
            return;
        }// end function

    }
}
