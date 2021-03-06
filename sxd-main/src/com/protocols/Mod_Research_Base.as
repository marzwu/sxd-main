﻿package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Research_Base extends Object
    {
        public static const SUCCEED:int = 0;
        public static const FAILED:int = 1;
        public static const FULL:int = 2;
        public static const CDTIME:int = 3;
        public static const NOENOUGHSKILL:int = 4;
        public static const LIMITLEVELSTRUCT:int = 5;
        public static const NOENOUGHLEVEL:int = 6;
        public static const NOENOUGHINGOT:int = 7;
        public static const research_list:Object = {module:239, action:5, request:[Utils.IntUtil], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const research_upgrade:Object = {module:239, action:75, request:[Utils.IntUtil], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const clear_cd_time_show:Object = {module:239, action:12, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const clear_cd_time:Object = {module:239, action:98, request:[], response:[Utils.ByteUtil, Utils.IntUtil]};
        public static const research_add_list:Object = {module:239, action:208, request:[Utils.IntUtil], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const Actions:Array = ["research_list", "research_upgrade", "clear_cd_time_show", "clear_cd_time", "research_add_list"];

        public function Mod_Research_Base()
        {
            return;
        }// end function

    }
}
