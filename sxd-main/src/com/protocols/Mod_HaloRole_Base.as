package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_HaloRole_Base extends Object
    {
        public static const OPEN:int = 0;
        public static const CLOSE:int = 1;
        public static const COMPLETE_CHALLENGED:int = 2;
        public static const WIN:int = 3;
        public static const LOSE:int = 4;
        public static const INVALID_PARAM:int = 5;
        public static const get_challenge_info:Object = {module:45, action:180, request:[], response:[Utils.ByteUtil, Utils.ShortUtil, Utils.IntUtil]};
        public static const start_challenge:Object = {module:45, action:243, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, [Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.ByteUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil], [[Utils.IntUtil, Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.ShortUtil, [Utils.ShortUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.StringUtil]]]], Utils.ByteUtil, Utils.IntUtil]};
        public static const Actions:Array = ["get_challenge_info", "start_challenge"];

        public function Mod_HaloRole_Base()
        {
            return;
        }// end function

    }
}
