package com.controllers
{
    import com.assist.data.mission.*;
    import com.assist.view.info.*;

    public class WorldBossMapController extends Base
    {

        public function WorldBossMapController()
        {
            return;
        }// end function

        public function get bossList() : Array
        {
            return _data.worldBoss.bossList;
        }// end function

        public function getBossObjAtTownId(param1:int) : BossInfo
        {
            var _loc_2:BossInfo = null;
            for each (_loc_2 in _data.worldBoss.bossList)
            {
                
                if (_loc_2.mapId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function set nowBoss(param1:BossInfo) : void
        {
            _data.worldBoss.nowBoss = param1;
            return;
        }// end function

        public function get result() : int
        {
            return _data.worldBoss.result;
        }// end function

        public function get notifyBoss() : BossInfo
        {
            return _data.worldBoss.notifyBoss;
        }// end function

        public function get lowHealthBossId() : int
        {
            return _data.worldBoss.lowHealthBossId;
        }// end function

        public function get combatBuff() : int
        {
            return _data.worldBoss.combatBuff;
        }// end function

        public function get warStatus() : int
        {
            return _data.worldBoss.warStatus;
        }// end function

        public function get warData() : WarData
        {
            var _loc_1:* = new WarData();
            _loc_1.format([0, 0, 0, _data.worldBoss.warData]);
            return _loc_1;
        }// end function

        public function get awards() : Object
        {
            var _loc_1:Object = {};
            var _loc_2:* = _data.worldBoss.awards;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                switch(parseInt(_loc_2[_loc_3][0]))
                {
                    case 0:
                    {
                        _loc_1["coin"] = _loc_2[_loc_3][1];
                        break;
                    }
                    case 1:
                    {
                        _loc_1["exp"] = _loc_2[_loc_3][1];
                        break;
                    }
                    case 2:
                    {
                        _loc_1["fame"] = _loc_2[_loc_3][1];
                        break;
                    }
                    case 10:
                    {
                        _loc_1["hurt"] = _loc_2[_loc_3][1];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

    }
}
