package com.datas
{

    public class WeekRankingData extends Base
    {
        public var GetWeekRanking:Array;
        public var rangkingOfType:int = 0;
        public var prestigeFirstList:Array;

        public function WeekRankingData()
        {
            this.prestigeFirstList = new Array();
            return;
        }// end function

        public function get_week_ranking(param1:Array) : void
        {
            this.GetWeekRanking = param1[0][0];
            return;
        }// end function

        public function get_First(param1:Array) : void
        {
            var _loc_3:String = null;
            while (this.prestigeFirstList.length > 0)
            {
                
                this.prestigeFirstList.pop();
            }
            this.rangkingOfType = param1[0];
            var _loc_2:* = param1[1];
            for (_loc_3 in _loc_2)
            {
                
                this.prestigeFirstList.push(_loc_2[_loc_3][0]);
            }
            return;
        }// end function

    }
}
