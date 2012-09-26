package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_RedEnvelopes_Base extends Object
    {
        public static const SUCCESS:int = 0;
        public static const TIME_ERROR:int = 1;
        public static const NO_GRID:int = 2;
        public static const ALREADY_GET:int = 3;
        public static const FAILURE:int = 4;
        public static const get_envelopes_info:Object = {module:124, action:232, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]]};
        public static const get_envelope:Object = {module:124, action:33, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const get_date:Object = {module:124, action:66, request:[], response:[Utils.IntUtil]};
        public static const Actions:Array = ["get_envelopes_info", "get_envelope", "get_date"];

        public function Mod_RedEnvelopes_Base()
        {
            return;
        }// end function

    }
}
