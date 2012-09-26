package com.protocols
{
    import com.*;

    public class Mod_RedEnvelopes extends Object
    {

        public function Mod_RedEnvelopes()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_RedEnvelopes_Base.get_envelopes_info, param1.redEnvelopes.get_envelopes_info);
            param1.registerDataCallback(Mod_RedEnvelopes_Base.get_envelope, param1.redEnvelopes.get_envelope);
            param1.registerDataCallback(Mod_RedEnvelopes_Base.get_date, param1.redEnvelopes.get_date);
            return;
        }// end function

    }
}
