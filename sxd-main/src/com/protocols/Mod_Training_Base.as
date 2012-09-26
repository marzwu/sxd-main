package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Training_Base extends Object
    {
        public static const GENERAL:int = 0;
        public static const STRENGTHEN:int = 1;
        public static const PLATINUM:int = 2;
        public static const DIAMOND:int = 3;
        public static const EXTREME:int = 4;
        public static const FAVORITEM:int = 5;
        public static const SUCCEED:int = 6;
        public static const FAILED:int = 7;
        public static const NOENOUGHCOINS:int = 8;
        public static const NOENOUGHINGOT:int = 9;
        public static const NOENOUGHITEM:int = 10;
        public static const NOTRAINING:int = 11;
        public static const panel_show:Object = {module:33, action:127, request:[Utils.IntUtil], response:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const training:Object = {module:33, action:64, request:[Utils.IntUtil, Utils.ByteUtil], response:[Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const modify_role_data:Object = {module:33, action:211, request:[Utils.IntUtil], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const Actions:Array = ["panel_show", "training", "modify_role_data"];

        public function Mod_Training_Base()
        {
            return;
        }// end function

    }
}
