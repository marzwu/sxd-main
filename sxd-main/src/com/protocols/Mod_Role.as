package com.protocols
{
    import com.*;

    public class Mod_Role extends Object
    {

        public function Mod_Role()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Role_Base.get_role_list, param1.rolemsg.get_role_list);
            param1.registerDataCallback(Mod_Role_Base.get_role_list_simpe, param1.rolemsg.get_role_list_simpe);
            param1.registerDataCallback(Mod_Role_Base.down_partners, param1.rolemsg.down_partners);
            param1.registerDataCallback(Mod_Role_Base.set_follow_role, param1.rolemsg.set_follow_role);
            param1.registerDataCallback(Mod_Training_Base.panel_show, param1.rolemsg.panel_show);
            param1.registerDataCallback(Mod_Training_Base.training, param1.rolemsg.training);
            param1.registerDataCallback(Mod_Training_Base.modify_role_data, param1.rolemsg.modify_role_data);
            param1.registerDataCallback(Mod_Role_Base.get_role_id_list, param1.rolemsg.get_role_id_list);
            param1.registerDataCallback(Mod_Role_Base.exp_change_notify, param1.rolemsg.exp_change_notify);
            param1.registerDataCallback(Mod_Role_Base.get_simple_role_list, param1.rolemsg.get_simple_role_list);
            param1.registerDataCallback(Mod_Role_Base.get_role_war_attribute, param1.rolemsg.get_role_war_attribute);
            param1.registerDataCallback(Mod_Role_Base.get_default_deploy_first_attack, param1.rolemsg.get_default_deploy_first_attack);
            return;
        }// end function

    }
}
