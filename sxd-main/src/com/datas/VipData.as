package com.datas
{

    public class VipData extends Base
    {
        private var _playerVipLevel:int;
        private var _moneyToNextLevel:int;

        public function VipData()
        {
            return;
        }// end function

        public function get moneyToNextLevel() : int
        {
            return this._moneyToNextLevel;
        }// end function

        public function get playerVipLevel() : int
        {
            return this._playerVipLevel;
        }// end function

        public function get_player_vip_info(param1:Array) : void
        {
            this._playerVipLevel = param1[0];
            this._moneyToNextLevel = param1[1];
            return;
        }// end function

    }
}
