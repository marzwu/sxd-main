package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_FingerGuess_Base extends Object
    {
        public static const START:int = 0;
        public static const RUN:int = 1;
        public static const STOP:int = 2;
        public static const WAIT:int = 3;
        public static const BEGIN:int = 4;
        public static const OFF:int = 5;
        public static const AT_ROOM:int = 6;
        public static const SUCCESS:int = 7;
        public static const FAILED:int = 8;
        public static const YES:int = 9;
        public static const NO:int = 10;
        public static const finger_guess_state:Object = {module:40, action:107, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.IntUtil, Utils.ByteUtil]]};
        public static const enter_room:Object = {module:40, action:86, request:[], response:[Utils.ByteUtil]};
        public static const fight:Object = {module:40, action:155, request:[Utils.ByteUtil], response:[Utils.ByteUtil]};
        public static const award:Object = {module:40, action:80, request:[], response:[Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil, Utils.ByteUtil]};
        public static const is_fight:Object = {module:40, action:92, request:[Utils.IntUtil], response:[Utils.ByteUtil]};
        public static const today_times:Object = {module:40, action:98, request:[], response:[Utils.IntUtil]};
        public static const Actions:Array = ["finger_guess_state", "enter_room", "fight", "award", "is_fight", "today_times"];

        public function Mod_FingerGuess_Base()
        {
            return;
        }// end function

    }
}
