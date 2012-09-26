package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_SuperDeploy_Base extends Object
    {
        public static const SUCCEED:int = 0;
        public static const NOT_MY_ROLE:int = 1;
        public static const LEAVE_TEAM:int = 2;
        public static const NOT_ENOUGTH_LEVEL:int = 3;
        public static const CAN_NOT_DOWN_MAIN_ROLE:int = 4;
        public static const SPECIAL_ROLE:int = 5;
        public static const FULL_DEPLOY:int = 6;
        public static const super_deploy_list:Object = {module:2, action:242, request:[], response:[[Utils.IntUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil], [Utils.ByteUtil, Utils.IntUtil]]};
        public static const up_deploy:Object = {module:2, action:8, request:[Utils.IntUtil, Utils.ByteUtil], response:[Utils.ByteUtil]};
        public static const down_deploy:Object = {module:2, action:172, request:[Utils.ByteUtil], response:[Utils.ByteUtil]};
        public static const deploy_research_and_first_attack:Object = {module:2, action:111, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const new_deploy_grid_open_notify:Object = {module:2, action:208, request:[], response:[[Utils.ByteUtil]]};
        public static const Actions:Array = ["super_deploy_list", "up_deploy", "down_deploy", "deploy_research_and_first_attack", "new_deploy_grid_open_notify"];

        public function Mod_SuperDeploy_Base()
        {
            return;
        }// end function

    }
}
