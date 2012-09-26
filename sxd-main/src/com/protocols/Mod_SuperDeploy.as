package com.protocols
{
    import com.*;

    public class Mod_SuperDeploy extends Object
    {

        public function Mod_SuperDeploy()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_SuperDeploy_Base.super_deploy_list, param1.superDeploy.super_deploy_list);
            param1.registerDataCallback(Mod_SuperDeploy_Base.up_deploy, param1.superDeploy.up_deploy);
            param1.registerDataCallback(Mod_SuperDeploy_Base.down_deploy, param1.superDeploy.down_deploy);
            param1.registerDataCallback(Mod_SuperDeploy_Base.deploy_research_and_first_attack, param1.superDeploy.deploy_research_and_first_attack);
            param1.registerDataCallback(Mod_SuperDeploy_Base.new_deploy_grid_open_notify, param1.superDeploy.new_deploy_grid_open_notify);
            return;
        }// end function

    }
}
