package com.assist.server
{
    import com.assist.server.source.*;

    public class FactionMonsterType extends Object
    {

        public function FactionMonsterType()
        {
            return;
        }// end function

        public static function getMonsterSignById(param1:int) : String
        {
            var _loc_4:Array = null;
            var _loc_2:* = FactionMonsterTypeData.FactionMonserList;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4[0] == param1)
                {
                    if (_loc_4[2] != 0)
                    {
                        return MonsterType.getMonsterSign(_loc_4[2]);
                    }
                    return MonsterType.getMonsterSign(_loc_4[1]);
                }
                _loc_3++;
            }
            return "";
        }// end function

        public static function getMonsterNameById(param1:int) : String
        {
            var _loc_4:Array = null;
            var _loc_2:* = FactionMonsterTypeData.FactionMonserList;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4[0] == param1)
                {
                    return MonsterType.getMonsterNameById(_loc_4[1]);
                }
                _loc_3++;
            }
            return "";
        }// end function

    }
}
