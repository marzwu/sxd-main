package com.datas
{

    public class CatHuntData extends Base
    {
        public var AutoSearchBonus:Array;
        public var UseMapSearch:Array;

        public function CatHuntData()
        {
            return;
        }// end function

        public function auto_search_bonus(param1:Array) : void
        {
            this.AutoSearchBonus = param1;
            return;
        }// end function

        public function use_map_search(param1:Array) : void
        {
            this.UseMapSearch = param1;
            return;
        }// end function

    }
}
