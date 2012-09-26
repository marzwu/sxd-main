package com.assist.server
{

    public class WorldBossType extends Object
    {
        private static const Bosses:Object = {1:[10], 2:[11], 3:[12]};

        public function WorldBossType()
        {
            return;
        }// end function

        public static function getTownIdByBossId(param1:int) : int
        {
            return Bosses[param1] ? (Bosses[param1][0]) : (0);
        }// end function

        public static function getTownIdByBossSign(param1:String) : int
        {
            return TownType.getId(param1);
        }// end function

    }
}
