package com.protocols
{
    import com.*;

    public class Mod_HaloRole extends Object
    {

        public function Mod_HaloRole()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_HaloRole_Base.get_challenge_info, param1.haloRole.get_challenge_info);
            param1.registerDataCallback(Mod_HaloRole_Base.start_challenge, param1.haloRole.start_challenge);
            return;
        }// end function

    }
}
