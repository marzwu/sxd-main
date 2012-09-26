package com.controllers
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.haloer.data.*;

    public class HeroesWarController extends Base
    {

        public function HeroesWarController()
        {
            return;
        }// end function

        public function openHeroesWar() : Object
        {
            return this._data.heroesWar.openHeroesWar();
        }// end function

        public function getCurrentHeroesOpenTime() : Object
        {
            var _loc_1:* = this._data.heroesWar.getHeroesOpenTime();
            var _loc_2:Object = {start_time:0, end_time:0};
            var _loc_3:* = _ctrl.player.serverTime;
            var _loc_4:Boolean = false;
            var _loc_5:Object = {};
            for each (_loc_5 in _loc_1)
            {
                
                if (_loc_5["start_time"] <= _loc_3 && _loc_5["end_time"] >= _loc_3)
                {
                    _loc_2["start_time"] = _loc_5["start_time"] - _loc_3;
                    _loc_2["end_time"] = _loc_5["end_time"] - _loc_3;
                    _loc_4 = true;
                    break;
                }
            }
            if (!_loc_4)
            {
                for each (_loc_5 in _loc_1)
                {
                    
                    if (_loc_3 <= _loc_5["start_time"])
                    {
                        _loc_2["start_time"] = _loc_5["start_time"] - _loc_3;
                        _loc_2["end_time"] = _loc_5["end_time"] - _loc_3;
                        _loc_4 = true;
                        break;
                    }
                }
            }
            if (!_loc_4 && _loc_1.length > 0)
            {
                _loc_5 = _loc_1[0] as Object;
                _loc_2["start_time"] = _loc_5["start_time"] - _loc_3;
                _loc_2["end_time"] = _loc_5["end_time"] - _loc_3;
            }
            return _loc_2;
        }// end function

        public function getHeroesOpenTime() : Array
        {
            var _loc_3:Object = null;
            var _loc_1:* = this._data.heroesWar.getHeroesOpenTime();
            var _loc_2:* = this._ctrl.player.serverTime;
            for each (_loc_3 in _loc_1)
            {
                
                _loc_3["start_time"] = _loc_3["start_time"] - _loc_2;
                _loc_3["end_time"] = _loc_3["end_time"] - _loc_2;
            }
            Helper.output(_loc_2);
            Helper.output(Dumper(_loc_1));
            return _loc_1;
        }// end function

        public function getIsOpenHeroesWar() : int
        {
            var _loc_6:Object = null;
            var _loc_1:* = this._data.heroesWar.getIsOpenHeroesWar();
            if (_loc_1 == 1)
            {
                return _loc_1;
            }
            var _loc_2:* = this._data.heroesWar.getHeroesOpenTime();
            var _loc_3:Boolean = true;
            var _loc_4:Boolean = true;
            var _loc_5:* = this._ctrl.player.serverTime;
            for each (_loc_6 in _loc_2)
            {
                
                if (_loc_6["start_time"] < _loc_5)
                {
                    _loc_3 = false;
                }
                if (_loc_6["end_time"] > _loc_5)
                {
                    _loc_4 = false;
                }
            }
            if (_loc_3)
            {
                var _loc_7:int = 0;
                _loc_1 = 0;
                return _loc_7;
            }
            if (_loc_4)
            {
                var _loc_7:int = 2;
                _loc_1 = 2;
                return _loc_7;
            }
            return _loc_1;
        }// end function

        public function getHeroesPlayer() : Array
        {
            return this._data.heroesWar.getHeroesPlayer();
        }// end function

        public function getHeroesLevelArea() : Array
        {
            return this._data.heroesWar.getHeroesLevelArea();
        }// end function

        public function getJoinHeroesWar() : Object
        {
            return this._data.heroesWar.getJoinHeroesWar();
        }// end function

        public function get warResult() : WarData
        {
            return this._data.heroesWar.getWarResult();
        }// end function

        public function get warDetail() : Object
        {
            return _data.heroesWar.getWarDetail();
        }// end function

        public function get awardFame() : int
        {
            return _data.heroesWar.getAwardFame();
        }// end function

        public function get awardCoin() : int
        {
            return _data.heroesWar.getAwardCoin();
        }// end function

        public function getNotifyType() : Object
        {
            return this._data.heroesWar.getNotifyType();
        }// end function

        public function getWarReport() : Array
        {
            return this._data.heroesWar.getWarReport();
        }// end function

        public function getNotifyTopWinner() : Array
        {
            return this._data.heroesWar.getNotifyTopWinner();
        }// end function

        public function getNotifyIntegral() : Object
        {
            return this._data.campWar.getNotifyIntegral();
        }// end function

        public function getNotifyPlayerHeroesInfo() : Object
        {
            return this._data.heroesWar.getNotifyPlayerHeroesInfo();
        }// end function

        public function get getWarReportLength() : int
        {
            return this._data.heroesWar.getWarReportLength;
        }// end function

        public function get getPlayerStatusDataLength() : int
        {
            return this._data.heroesWar.getPlayerStatusDataLength;
        }// end function

        public function getPlayerStatusData() : Array
        {
            return this._data.heroesWar.getPlayerStatusData();
        }// end function

        public function buyBuff() : Object
        {
            return this._data.heroesWar.buyBuff();
        }// end function

        public function getBuff() : Object
        {
            return this._data.heroesWar.getBuff();
        }// end function

        public function setRobot() : Object
        {
            return this._data.heroesWar.setRobot();
        }// end function

        public function getRobotStatus() : Object
        {
            return this._data.heroesWar.getRobotStatus();
        }// end function

        public function get getWarMode() : Object
        {
            return this._data.heroesWar.getWarMode();
        }// end function

        public function get notifyFirstOpenHeroesWar() : Object
        {
            return this._data.heroesWar.notifyFirstOpenHeroesWar();
        }// end function

    }
}
