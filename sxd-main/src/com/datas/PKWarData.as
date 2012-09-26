package com.datas
{
    import com.assist.data.mission.*;

    public class PKWarData extends Base
    {
        public var warData:WarData;
        public var reportId:int;

        public function PKWarData()
        {
            return;
        }// end function

        public function start_war(param1:Array) : void
        {
            this.reportId = param1.pop();
            var _loc_2:Array = [0, 0, 0, [param1]];
            this.warData = new WarData();
            this.warData.format(_loc_2);
            return;
        }// end function

    }
}
