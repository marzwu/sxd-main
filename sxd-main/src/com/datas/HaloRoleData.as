package com.datas
{
    import com.assist.data.mission.*;

    public class HaloRoleData extends Base
    {
        public var getChallengeInfo:Array;
        public var startChallenge:Array;
        public var warStatus:int;
        public var warData:WarData;
        public var isFirstChallenge:Boolean;
        public var aura:uint;

        public function HaloRoleData()
        {
            return;
        }// end function

        public function get_challenge_info(param1:Array) : void
        {
            this.getChallengeInfo = param1;
            return;
        }// end function

        public function start_challenge(param1:Array) : void
        {
            this.warStatus = param1[0];
            this.warData = new WarData();
            this.warData.format([0, 0, 0, [param1[1][0]]]);
            this.isFirstChallenge = param1[2];
            this.aura = param1[3];
            return;
        }// end function

    }
}
