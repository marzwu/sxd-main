package com.protocols
{
    import com.*;

    public class Mod_Partners extends Object
    {

        public function Mod_Partners()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Partners_Base.partners_list, param1.partners.partners_list);
            param1.registerDataCallback(Mod_Partners_Base.partners_invite, param1.partners.partners_invite);
            param1.registerDataCallback(Mod_Partners_Base.now_and_next_Recommend_role_list, param1.partners.now_and_next_Recommend_role_list);
            return;
        }// end function

    }
}
