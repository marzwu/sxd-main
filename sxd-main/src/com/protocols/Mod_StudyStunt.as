package com.protocols
{
    import com.*;

    public class Mod_StudyStunt extends Object
    {

        public function Mod_StudyStunt()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_StudyStunt_Base.player_stunt_info, param1.studyStunt.player_stunt_info);
            param1.registerDataCallback(Mod_StudyStunt_Base.player_study_stunt, param1.studyStunt.player_study_stunt);
            param1.registerDataCallback(Mod_StudyStunt_Base.player_use_role_stunt_id, param1.studyStunt.player_use_role_stunt_id);
            param1.registerDataCallback(Mod_StudyStunt_Base.player_can_study_stunt, param1.studyStunt.player_can_study_stunt);
            return;
        }// end function

    }
}
