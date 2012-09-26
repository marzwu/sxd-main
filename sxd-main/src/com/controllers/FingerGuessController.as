package com.controllers
{
    import com.assist.*;
    import com.assist.server.*;

    public class FingerGuessController extends Base
    {

        public function FingerGuessController()
        {
            return;
        }// end function

        public function get FingerGuessState() : Object
        {
            var _loc_1:* = _data.fingerGuess.FingerGuessState;
            var _loc_2:Object = {};
            _loc_2.state = _loc_1[0];
            _loc_2.playerList = this.renderPlayer(_loc_1[1]);
            return _loc_2;
        }// end function

        private function renderPlayer(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_6:String = null;
            var _loc_2:* = param1.length;
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = {};
                _loc_5.playerId = param1[_loc_4][0];
                _loc_5.isPlayer = _loc_5.playerId == _ctrl.player.playerId;
                _loc_5.scorId = _loc_5.playerId == _ctrl.player.playerId ? (0) : (1);
                _loc_5.nickName = param1[_loc_4][1];
                _loc_5.zongZhi = param1[_loc_4][2];
                _loc_5.isLandlord = param1[_loc_4][3] == 0;
                _loc_5.roleId = param1[_loc_4][4];
                _loc_5.itemId = param1[_loc_4][5];
                _loc_5.isFight = param1[_loc_4][6] == 1;
                _loc_5.roleSign = RoleType.getRoleSign(_loc_5.roleId);
                _loc_6 = ItemType.getItemSuffix(_loc_5.itemId);
                _loc_5.roleSign = _loc_5.roleSign + _loc_6;
                _loc_5.roleUrl = URI.warRolesUrl + _loc_5.roleSign + ".swf";
                _loc_3.push(_loc_5);
                _loc_4++;
            }
            _loc_3.sortOn("scorId");
            return _loc_3;
        }// end function

        public function get EnterRoom() : Object
        {
            var _loc_1:* = _data.fingerGuess.EnterRoom;
            var _loc_2:Object = {};
            _loc_2.state = _loc_1[0];
            return _loc_2;
        }// end function

        public function get Fight() : Object
        {
            var _loc_1:* = _data.fingerGuess.Fight;
            var _loc_2:Object = {};
            _loc_2.state = _loc_1[0];
            return _loc_2;
        }// end function

        public function get Award() : Object
        {
            var _loc_1:* = _data.fingerGuess.Award;
            var _loc_2:Object = {};
            _loc_2.playerId = _loc_1[0];
            if (_loc_2.playerId == _ctrl.player.playerId)
            {
                _loc_2.winType = 1;
            }
            else if (_loc_2.playerId == 0)
            {
                _loc_2.winType = 2;
            }
            else
            {
                _loc_2.winType = 3;
            }
            _loc_2.zhongzhi = _loc_1[1];
            _loc_2.fingerA = _loc_1[2];
            _loc_2.fingerB = _loc_1[3];
            _loc_2.zhongzhiA = _loc_1[4];
            _loc_2.zhongzhiB = _loc_1[5];
            return _loc_2;
        }// end function

        public function get IsFight() : Object
        {
            var _loc_1:* = _data.fingerGuess.IsFight;
            var _loc_2:Object = {};
            _loc_2.result = _loc_1[0];
            return _loc_2;
        }// end function

        public function get TodayTimes() : int
        {
            var _loc_1:* = _data.fingerGuess.TodayTimes;
            return _loc_1[0];
        }// end function

    }
}
