package com.datas
{
    import com.assist.data.mission.*;

    public class GetPeachData extends Base
    {
        private var _buyMonkeys:Array;
        private var _peachInfo:Array;
        private var _playerInfo:Array;
        public var warResult:int;
        public var warExp:int;
        public var warData:WarData;
        public var warAura:int;

        public function GetPeachData()
        {
            return;
        }// end function

        public function get buyMonkeys() : Array
        {
            return this._buyMonkeys;
        }// end function

        public function get peachInfo() : Array
        {
            return this._peachInfo;
        }// end function

        public function get playerInfo() : Array
        {
            return this._playerInfo;
        }// end function

        public function get_peach(param1:Array) : void
        {
            this.warResult = param1[0];
            this.warExp = param1[1];
            this.warData = new WarData();
            this.warData.format([0, 0, 0, [param1[2][0]]]);
            this.warAura = param1[3];
            return;
        }// end function

        public function buy_monkeys(param1:Array) : void
        {
            this._buyMonkeys = param1;
            return;
        }// end function

        public function peach_info(param1:Array) : void
        {
            this._peachInfo = param1;
            return;
        }// end function

        public function player_info(param1:Array) : void
        {
            this._playerInfo = param1;
            return;
        }// end function

    }
}
