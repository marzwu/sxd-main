package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_StudyStunt_Base extends Object
    {
        public static const FULL_LEVEL:int = 0;
        public static const NO_FULL_LEVEL:int = 1;
        public static const STUDY_SUCCESS:int = 2;
        public static const NOENOUGH_AURA:int = 3;
        public static const INVALID_ELEMENT:int = 4;
        public static const INVALID_STUNT_LEVEL:int = 5;
        public static const INVALID_PLAYER_LEVEL:int = 6;
        public static const INVALID_FUNCTION:int = 7;
        public static const player_stunt_info:Object = {module:95, action:82, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const player_study_stunt:Object = {module:95, action:92, request:[Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil]};
        public static const player_use_role_stunt_id:Object = {module:95, action:223, request:[[Utils.IntUtil]], response:[[Utils.IntUtil, Utils.ShortUtil]]};
        public static const player_can_study_stunt:Object = {module:95, action:40, request:[], response:[Utils.IntUtil, Utils.IntUtil]};
        public static const Actions:Array = ["player_stunt_info", "player_study_stunt", "player_use_role_stunt_id", "player_can_study_stunt"];

        public function Mod_StudyStunt_Base()
        {
            return;
        }// end function

    }
}
