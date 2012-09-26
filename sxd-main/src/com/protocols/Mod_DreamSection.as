package com.protocols
{
    import com.*;

    public class Mod_DreamSection extends Object
    {

        public function Mod_DreamSection()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_DreamSection_Base.get_player_dream_section_info, param1.dreamSection.getRoleInfo);
            param1.registerDataCallback(Mod_DreamSection_Base.challenge_section, param1.dreamSection.getChallengeSection);
            param1.registerDataCallback(Mod_DreamSection_Base.recruit_partner, param1.dreamSection.recruitPartner);
            return;
        }// end function

    }
}
