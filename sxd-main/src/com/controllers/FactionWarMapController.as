package com.controllers
{
    import com.assist.data.mission.*;
    import flash.utils.*;

    public class FactionWarMapController extends Base
    {

        public function FactionWarMapController()
        {
            return;
        }// end function

        public function get result() : int
        {
            return _data.factionWarMap.result;
        }// end function

        public function get signupState() : int
        {
            return _data.factionWarMap.signupState;
        }// end function

        public function get intoTime() : int
        {
            var _loc_1:* = int((_data.factionWarMap.intoTime - getTimer()) / 1000);
            return _loc_1;
        }// end function

        public function get warTime() : int
        {
            var _loc_1:* = int((_data.factionWarMap.warTime - getTimer()) / 1000);
            if (_loc_1 < 0)
            {
                _loc_1 = 0;
                ;
            }
            return _loc_1;
        }// end function

        public function get heroRank() : Array
        {
            return _data.factionWarMap.heroRank;
        }// end function

        public function get heroRankTip() : String
        {
            return _data.factionWarMap.heroRankTip;
        }// end function

        public function get canSignup() : int
        {
            return _data.factionWarMap.canSignup;
        }// end function

        public function get isSignup() : int
        {
            return _data.factionWarMap.isSignup;
        }// end function

        public function get signupTip() : String
        {
            return _data.factionWarMap.signupTip;
        }// end function

        public function get signupList() : Array
        {
            return _data.factionWarMap.signupList;
        }// end function

        public function get warTownId() : int
        {
            return _data.factionWarMap.warTownId;
        }// end function

        public function get warMapList() : Array
        {
            return _data.factionWarMap.warMapList;
        }// end function

        public function get roundWarIdx() : int
        {
            return _data.factionWarMap.roundWarIdx;
        }// end function

        public function get roundWarName() : String
        {
            return _data.factionWarMap.roundWarName;
        }// end function

        public function get warStatusList() : Array
        {
            var _loc_1:* = _data.factionWarMap.warStatusList;
            _data.factionWarMap.warStatusList = [];
            return _loc_1;
        }// end function

        public function get killRank() : Array
        {
            return _data.factionWarMap.killRank;
        }// end function

        public function get winId() : int
        {
            return _data.factionWarMap.winId;
        }// end function

        public function get cupObj() : Object
        {
            return _data.factionWarMap.cupObj;
        }// end function

        public function get overChatMsg() : String
        {
            return _data.factionWarMap.overChatMsg;
        }// end function

        public function get overWorldMsg() : String
        {
            return _data.factionWarMap.overWorldMsg;
        }// end function

        public function get giftList() : Array
        {
            var _loc_2:Array = null;
            var _loc_1:Array = [];
            for each (_loc_2 in _data.factionWarMap.giftList)
            {
                
                _loc_1.push(_loc_2[1]);
            }
            return _loc_1;
        }// end function

        public function getGiftIdForName(param1:String) : int
        {
            var _loc_2:Array = null;
            for each (_loc_2 in _data.factionWarMap.giftList)
            {
                
                if (_loc_2[1] == param1)
                {
                    return _loc_2[0];
                }
            }
            return 0;
        }// end function

        public function get showWorld() : Array
        {
            var _loc_1:* = _data.factionWarMap.worldNotice;
            _data.factionWarMap.worldNotice = [];
            return _loc_1;
        }// end function

        public function get chatWorld() : Array
        {
            var _loc_1:* = _data.factionWarMap.chatWorld;
            _data.factionWarMap.chatWorld = [];
            return _loc_1;
        }// end function

        public function get chatFaction() : Array
        {
            var _loc_1:* = _data.factionWarMap.chatFaction;
            _data.factionWarMap.chatFaction = [];
            return _loc_1;
        }// end function

        public function get winWinPlayerId() : int
        {
            return _data.factionWarMap.warWinPlayerId;
        }// end function

        public function get warData() : WarData
        {
            var _loc_1:* = _data.factionWarMap.warDataList.shift();
            return _loc_1;
        }// end function

        public function get awardData() : Array
        {
            var _loc_1:* = _data.factionWarMap.warAwardList.shift();
            return _loc_1;
        }// end function

        public function get hasWarData() : Boolean
        {
            return _data.factionWarMap.warDataList.length > 0;
        }// end function

    }
}
