package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_DreamSection_Base extends Object
    {
        public static const SUCCESS:int = 0;
        public static const FAILED:int = 1;
        public static const UNOPENFACTION:int = 2;
        public static const ERRSECTIONID:int = 3;
        public static const HASCHALLENGE:int = 4;
        public static const LOCKSECTION:int = 5;
        public static const NOPASS:int = 6;
        public static const NOENOUGHCAUSALPOINT:int = 7;
        public static const get_player_dream_section_info:Object = {module:189, action:199, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], Utils.IntUtil]};
        public static const challenge_section:Object = {module:189, action:94, request:[Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]]]};
        public static const recruit_partner:Object = {module:189, action:17, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const get_player_war_report:Object = {module:189, action:169, request:[], response:[Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]]};
        public static const Actions:Array = ["get_player_dream_section_info", "challenge_section", "recruit_partner", "get_player_war_report"];

        public function Mod_DreamSection_Base()
        {
            return;
        }// end function

    }
}
