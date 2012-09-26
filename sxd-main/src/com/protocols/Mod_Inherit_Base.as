﻿package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Inherit_Base extends Object
    {
        public static const SUCCESS:int = 0;
        public static const NO_COIN:int = 1;
        public static const NO_SKILL:int = 2;
        public static const NO_INGOT:int = 3;
        public static const CAN_NOT_INHERIT:int = 4;
        public static const role_list:Object = {module:71, action:180, request:[Utils.IntUtil], response:[[Utils.IntUtil, Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const role_attribute:Object = {module:71, action:219, request:[Utils.IntUtil], response:[Utils.ByteUtil, Utils.ByteUtil, [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const attribute_after_inherit:Object = {module:71, action:227, request:[Utils.IntUtil, Utils.IntUtil], response:[[Utils.ByteUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, [Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil], [Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]]};
        public static const inherit:Object = {module:71, action:84, request:[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil], response:[Utils.ByteUtil]};
        public static const Actions:Array = ["role_list", "role_attribute", "attribute_after_inherit", "inherit"];

        public function Mod_Inherit_Base()
        {
            return;
        }// end function

    }
}
