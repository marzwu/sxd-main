package com.controllers
{
    import com.datas.*;

    public class VipController extends Base
    {
        public var ownData:VipData;

        public function VipController()
        {
            return;
        }// end function

        public function get playerVipLevel() : int
        {
            return this.ownData.playerVipLevel;
        }// end function

        public function get moneyToNextLevel() : int
        {
            return this.ownData.moneyToNextLevel;
        }// end function

    }
}
