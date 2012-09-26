package com.assist.view.info
{
    import com.assist.server.*;

    public class NineRegionsInfo extends Object
    {
        public var isFrist:Boolean = false;
        public var curJie:int = 0;
        public var curLevel:int = 0;

        public function NineRegionsInfo()
        {
            return;
        }// end function

        public static function getMonsterInfoById(param1:int) : MonsterInfo
        {
            var _loc_2:* = new MonsterInfo();
            _loc_2.id = param1;
            _loc_2.name = NineRegionsType.getMonsterNameById(param1);
            _loc_2.sign = NineRegionsType.getMonsterSignById(param1);
            _loc_2.x = 970;
            _loc_2.y = 455;
            return _loc_2;
        }// end function

    }
}
