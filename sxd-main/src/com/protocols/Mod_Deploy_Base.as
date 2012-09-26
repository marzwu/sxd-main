package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Deploy_Base extends Object
    {
        public static const SUCCEED:int = 0;
        public static const IS_PLANT:int = 1;
        public static const FAILED:int = 2;
        public static const deploy_list:Object = {module:139, action:15, request:[Utils.IntUtil], response:[[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, [Utils.IntUtil, Utils.IntUtil], [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const up_deploy:Object = {module:139, action:121, request:[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const down_deploy:Object = {module:139, action:176, request:[Utils.IntUtil, Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const all_down_deploy:Object = {module:139, action:206, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const set_defaut_deploy:Object = {module:139, action:94, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const Actions:Array = ["deploy_list", "up_deploy", "down_deploy", "all_down_deploy", "set_defaut_deploy"];

        public function Mod_Deploy_Base()
        {
            return;
        }// end function

    }
}
