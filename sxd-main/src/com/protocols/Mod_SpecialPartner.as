﻿package com.protocols
{
    import com.*;

    public class Mod_SpecialPartner extends Object
    {

        public function Mod_SpecialPartner()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_SpecialPartner_Base.get_partner_info, param1.specialPartner.get_partner_info);
            param1.registerDataCallback(Mod_SpecialPartner_Base.get_mission_award, param1.specialPartner.get_mission_award);
            param1.registerDataCallback(Mod_SpecialPartner_Base.ingot_complete, param1.specialPartner.ingot_complete);
            param1.registerDataCallback(Mod_SpecialPartner_Base.invite_partner, param1.specialPartner.invite_partner);
            return;
        }// end function

    }
}
