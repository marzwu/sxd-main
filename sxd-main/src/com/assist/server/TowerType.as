package com.assist.server
{

    public class TowerType extends Object
    {
        private static var _Layer:Array = null;
        private static var _LayerSoul:Array = null;

        public function TowerType()
        {
            return;
        }// end function

        public static function get Layer() : Array
        {
            if (_Layer == null)
            {
                throw new Error("还未赋值！");
            }
            return _Layer;
        }// end function

        public static function set Layer(param1:Array) : void
        {
            if (_Layer != null)
            {
                throw new Error("非法赋值");
            }
            _Layer = param1;
            return;
        }// end function

        public static function get LayerSoul() : Array
        {
            if (_LayerSoul == null)
            {
                throw new Error("还未赋值！");
            }
            return _LayerSoul;
        }// end function

        public static function set LayerSoul(param1:Array) : void
        {
            if (_LayerSoul != null)
            {
                throw new Error("非法赋值");
            }
            _LayerSoul = param1;
            return;
        }// end function

        private static function getLayerItem(param1:int, param2:int) : Array
        {
            var _loc_3:Array = null;
            var _loc_4:* = Layer.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (Layer[_loc_5][0] == param1 && Layer[_loc_5][1] == param2)
                {
                    _loc_3 = Layer[_loc_5];
                    break;
                }
                _loc_5++;
            }
            return _loc_3;
        }// end function

        private static function getLayerSoulItem(param1:int, param2:int) : Array
        {
            var _loc_3:Array = [];
            var _loc_4:* = LayerSoul.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (LayerSoul[_loc_5][0] == param1 && LayerSoul[_loc_5][1] == param2)
                {
                    _loc_3.push(LayerSoul[_loc_5]);
                }
                _loc_5++;
            }
            return _loc_3;
        }// end function

        public static function getMonsterTeamId(param1:int, param2:int) : int
        {
            var _loc_3:* = getLayerItem(param1, param2);
            return _loc_3 ? (_loc_3[2]) : (0);
        }// end function

        public static function getMonsterId(param1:int, param2:int) : int
        {
            var _loc_3:* = getLayerItem(param1, param2);
            return _loc_3 ? (_loc_3[3]) : (0);
        }// end function

        public static function getAwardExp(param1:int, param2:int) : int
        {
            var _loc_3:* = getLayerItem(param1, param2);
            return _loc_3 ? (_loc_3[4]) : (0);
        }// end function

        public static function getSoulIdList(param1:int, param2:int) : Array
        {
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_3:Array = [];
            var _loc_4:* = getLayerSoulItem(param1, param2);
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_7 = _loc_4[_loc_5][2];
                _loc_8 = _loc_4[_loc_5][3];
                _loc_3 = _loc_3.concat(SoulType.getSoulIdList(_loc_7, _loc_8));
                _loc_5++;
            }
            var _loc_6:Array = [];
            _loc_3 = _loc_3.sortOn("qualityId", Array.NUMERIC | Array.DESCENDING);
            _loc_5 = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                _loc_6.push(_loc_3[_loc_5]["soulId"]);
                _loc_5++;
            }
            return _loc_6;
        }// end function

    }
}
