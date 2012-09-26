package com.protocols
{
    import com.*;

    public class Mod_Inherit extends Object
    {

        public function Mod_Inherit()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Inherit_Base.role_list, param1.inherit.role_list);
            param1.registerDataCallback(Mod_Inherit_Base.role_attribute, param1.inherit.role_attribute);
            param1.registerDataCallback(Mod_Inherit_Base.attribute_after_inherit, param1.inherit.attribute_after_inherit);
            param1.registerDataCallback(Mod_Inherit_Base.inherit, param1.inherit.inherit);
            return;
        }// end function

    }
}
