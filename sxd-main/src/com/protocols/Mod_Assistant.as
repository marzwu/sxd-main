package com.protocols
{
    import com.*;

    public class Mod_Assistant extends Object
    {

        public function Mod_Assistant()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Assistant_Base.info, param1.assistant.info);
            param1.registerDataCallback(Mod_Assistant_Base.get_award, param1.assistant.get_award);
            param1.registerDataCallback(Mod_Assistant_Base.complete_number, param1.assistant.complete_number);
            return;
        }// end function

    }
}
