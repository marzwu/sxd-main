package com.assist.view.info
{
    import com.protocols.*;

    public class WorldFactionWarGroupClass extends Object
    {
        public var idA:int = 0;
        public var idB:int = 0;
        public var win:int = 0;
        public var lv:int;
        public var idx:int;
        public var childA:WorldFactionWarGroupClass;
        public var childB:WorldFactionWarGroupClass;
        public var parent:WorldFactionWarGroupClass;
        public var warTime:Number = 0;
        private static var winList:Array = [];
        private static var max:int = 8;
        public static var info:WorldFactionWarInfo;
        public static var list:Array = [];
        private static var group11:WorldFactionWarGroupClass;

        public function WorldFactionWarGroupClass(param1:int = 1, param2:int = 1)
        {
            this.lv = param1;
            this.idx = param2;
            list[param1] = list[param1] || [];
            list[param1][param2] = this;
            param1 = param1 << 1;
            if (param1 <= max)
            {
                this.childA = new WorldFactionWarGroupClass(param1, param2 * 2 - 1);
                this.childB = new WorldFactionWarGroupClass(param1, param2 * 2);
                var _loc_3:String = this;
                this.childB.parent = this;
                this.childA.parent = _loc_3;
            }
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:int = 0;
            this.win = 0;
            var _loc_1:* = _loc_1;
            this.idB = _loc_1;
            this.idA = _loc_1;
            if (this.childA)
            {
                this.childA.reset();
            }
            if (this.childB)
            {
                this.childB.reset();
            }
            this.warTime = 0;
            return;
        }// end function

        public function calculateWin(param1:int = 0, param2:int = 0) : void
        {
            this.idA = param1 || this.childA.win;
            this.idB = param2 || this.childB.win;
            if (winList[this.lv].indexOf(this.idA) != -1)
            {
                this.win = this.idA;
                info.getFaction(this.idB).isLost = true;
            }
            else if (winList[this.lv].indexOf(this.idB) != -1)
            {
                this.win = this.idB;
                info.getFaction(this.idA).isLost = true;
            }
            return;
        }// end function

        public function calculateChild() : void
        {
            if (this.parent.childA == this && this.parent.idA != 0)
            {
                var _loc_1:* = this.parent.idA;
                this.win = this.parent.idA;
                this.idA = _loc_1;
            }
            else if (this.parent.childB == this && this.parent.idB != 0)
            {
                var _loc_1:* = this.parent.idB;
                this.win = this.parent.idB;
                this.idB = _loc_1;
            }
            return;
        }// end function

        public function get lostA() : Boolean
        {
            if (this.win != 0 && this.win != this.idA)
            {
                return true;
            }
            if (this.win == 0)
            {
                return false;
            }
            if (this.parent == null)
            {
                return false;
            }
            if (this.parent.childA == this)
            {
                return this.parent.lostA;
            }
            if (this.parent.childB == this)
            {
                return this.parent.lostB;
            }
            return false;
        }// end function

        public function get lostB() : Boolean
        {
            if (this.win != 0 && this.win != this.idB)
            {
                return true;
            }
            if (this.win == 0)
            {
                return false;
            }
            if (this.parent == null)
            {
                return false;
            }
            if (this.parent.childA == this)
            {
                return this.parent.lostA;
            }
            if (this.parent.childB == this)
            {
                return this.parent.lostB;
            }
            return false;
        }// end function

        public function get lost() : int
        {
            if (this.win == 0)
            {
                return 0;
            }
            if (this.win == this.idA)
            {
                return this.idB;
            }
            return this.idA;
        }// end function

        public function get warState() : int
        {
            if (this.idA == 0 || this.idB == 0)
            {
                return 0;
            }
            if (info.serverTime < this.warTime)
            {
                return 2;
            }
            if (this.win == 0)
            {
                return 1;
            }
            return 3;
        }// end function

        public function updateWarTime() : void
        {
            var _loc_1:int = 86400000;
            var _loc_2:* = info.getRoundTime(Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_4);
            if (this.lv == 4)
            {
                this.warTime = _loc_2 + (this.idx - 1) * _loc_1;
            }
            if (this.lv == 2)
            {
                this.warTime = _loc_2 + _loc_1 * 4 + (this.idx - 1) * _loc_1;
            }
            if (this.lv == 1)
            {
                this.warTime = _loc_2 + _loc_1 * 6 + (this.idx - 1) * _loc_1;
            }
            return;
        }// end function

        public static function resetGroup(param1:Array, param2:Array, param3:Array, param4:Array) : void
        {
            var _loc_6:WorldFactionWarGroupClass = null;
            var _loc_7:int = 0;
            var _loc_8:Array = null;
            winList[4] = param2;
            winList[2] = param3;
            winList[1] = param4;
            group11 = group11 || new WorldFactionWarGroupClass;
            group11.reset();
            var _loc_5:* = (param1.length - 1) || 1;
            for each (_loc_6 in list[_loc_5])
            {
                
                _loc_8 = param1[_loc_6.idx] || [0, 0];
                _loc_6.calculateWin(_loc_8[0], _loc_8[1]);
            }
            _loc_7 = _loc_5;
            while (_loc_7 > 1)
            {
                
                _loc_7 = _loc_7 >> 1;
                for each (_loc_6 in list[_loc_7])
                {
                    
                    _loc_6.calculateWin();
                }
            }
            _loc_7 = _loc_5;
            while (_loc_7 < 4)
            {
                
                _loc_7 = _loc_7 << 1;
                for each (_loc_6 in list[_loc_7])
                {
                    
                    _loc_6.calculateChild();
                }
            }
            for each (_loc_6 in list[4])
            {
                
                _loc_6.updateWarTime();
            }
            for each (_loc_6 in list[2])
            {
                
                _loc_6.updateWarTime();
            }
            for each (_loc_6 in list[1])
            {
                
                _loc_6.updateWarTime();
            }
            return;
        }// end function

    }
}
