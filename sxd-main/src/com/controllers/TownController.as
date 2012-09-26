package com.controllers
{
    import com.assist.view.info.*;
    import com.datas.*;

    public class TownController extends Base
    {

        public function TownController()
        {
            return;
        }// end function

        public function getPlayerInfo(param1:int) : PlayerInfo
        {
            return _data.town.getPlayerInfo(param1);
        }// end function

        public function get entownList() : Array
        {
            var _loc_1:* = _data.town.entownList;
            _data.town.entownList = [];
            return _loc_1;
        }// end function

        public function get moveList() : Array
        {
            var _loc_1:* = _data.town.moveList;
            _data.town.moveList = [];
            return _loc_1;
        }// end function

        public function get leaveList() : Array
        {
            var _loc_1:* = _data.town.leaveList;
            _data.town.leaveList = [];
            return _loc_1;
        }// end function

        public function get followList() : Array
        {
            var _loc_1:* = _data.town.followList;
            _data.town.followList = [];
            return _loc_1;
        }// end function

        public function get result() : int
        {
            return _data.town.result;
        }// end function

        public function get playercount() : int
        {
            return _data.town.playercount;
        }// end function

        public function get count() : int
        {
            return _data.town.count;
        }// end function

        public function clearPlayer() : void
        {
            _data.town.clearPlayer();
            return;
        }// end function

        public function set maxCount(param1:int) : void
        {
            TownData.maxCount = param1;
            return;
        }// end function

        public function get maxCount() : int
        {
            return TownData.maxCount;
        }// end function

        public function get followChangePlayerId() : int
        {
            return _data.town.followChangePlayerId;
        }// end function

    }
}
