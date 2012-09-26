package com.assist.view.info
{
    import flash.display.*;

    public class ImmortalityInfo extends Object
    {
        public var listWuli:Array;
        public var listJueJi:Array;
        public var listFaShu:Array;
        public var isSee:Boolean = false;
        public var inogteat:Boolean = false;
        public var inogteatLv6:Boolean = false;
        public var inogteatLv7:Boolean = false;
        public var roleLv:int = 0;
        public var roleName:String = "";
        private static var tipCache:Array = [];
        private static var idlist:Array = [null, [0, 380, 438, 440, 444, 448, 452, 454], [0, 463, 466, 468, 471, 473, 475, 480], [0, 488, 491, 493, 496, 499, 501, 503]];

        public function ImmortalityInfo()
        {
            this.listWuli = [];
            this.listJueJi = [];
            this.listFaShu = [];
            return;
        }// end function

        public static function getDanYaoTip(param1:int, param2:int, param3:int) : Sprite
        {
            var _loc_5:Array = null;
            var _loc_6:int = 0;
            var _loc_7:ItemInfo = null;
            var _loc_4:* = param1 << 8 | param2 << 4 | param3;
            if (tipCache[_loc_4] == null)
            {
                _loc_5 = idlist[param1] || [];
                _loc_6 = int(_loc_5[param2]);
                if (_loc_6 != 0)
                {
                    _loc_7 = new ItemInfo();
                    _loc_7.eatCount = param3;
                    _loc_7.parseSee(_loc_6);
                    tipCache[_loc_4] = _loc_7.getTipsSprite1("", "");
                }
                else
                {
                    tipCache[_loc_4] = new Sprite();
                }
            }
            return tipCache[_loc_4];
        }// end function

    }
}
