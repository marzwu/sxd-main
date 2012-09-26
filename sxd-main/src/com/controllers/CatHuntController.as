package com.controllers
{
    import com.assist.view.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class CatHuntController extends Base
    {
        private var _bonusInfoList:Array;

        public function CatHuntController()
        {
            this._bonusInfoList = [];
            return;
        }// end function

        public function get autoSearchBonus() : Object
        {
            var _loc_1:* = _data.catHunt.AutoSearchBonus;
            var _loc_2:Object = {};
            _loc_2.playerKarma = _loc_1[0];
            _loc_2.useMapTime = _loc_1[1];
            this.renderArray(_loc_1[2]);
            _loc_2.bonusItem = this.renderAward(this._bonusInfoList);
            return _loc_2;
        }// end function

        public function get useMapSearch() : Object
        {
            var _loc_1:* = _data.catHunt.UseMapSearch;
            var _loc_2:Object = {};
            _loc_2.result = _loc_1[0];
            _loc_2.failedReason = _loc_1[1];
            _loc_2.playerKarma = _loc_1[2];
            _loc_2.useMapTime = _loc_1[3];
            var _loc_3:Array = [];
            _loc_3.push(_loc_1[4]);
            _loc_3.push(_loc_1[5]);
            _loc_3.push(_loc_1[6]);
            this.renderArray([_loc_3]);
            _loc_2.bonusItem = this.renderAward(this._bonusInfoList);
            return _loc_2;
        }// end function

        private function renderArray(param1:Array) : void
        {
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                this._bonusInfoList.push(param1[_loc_3]);
                _loc_3++;
            }
            this.sortTime(this._bonusInfoList);
            var _loc_4:* = this._bonusInfoList.length;
            var _loc_5:* = this._bonusInfoList.length - 15;
            _loc_3 = _loc_4 - 1;
            while (_loc_3 >= 0)
            {
                
                if (_loc_3 < _loc_5)
                {
                    this._bonusInfoList.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
            }
            return;
        }// end function

        private function sortTime(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 1;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = 0;
                while (_loc_4 < (_loc_2 - 1))
                {
                    
                    if (param1[_loc_4][0] > param1[(_loc_4 + 1)][0])
                    {
                        _loc_5 = param1[_loc_4];
                        param1[_loc_4] = param1[(_loc_4 + 1)];
                        param1[(_loc_4 + 1)] = _loc_5;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function renderAward(param1:Array) : Array
        {
            var _loc_6:Object = null;
            var _loc_7:Object = null;
            var _loc_8:Array = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:* = _ctrl.player.serverTime;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = {};
                _loc_6.searchTime = param1[_loc_5][0];
                _loc_6.serverTime = _loc_4;
                _loc_6.boxType = param1[_loc_5][1];
                _loc_7 = this.boxData(_loc_6.boxType);
                _loc_6.boxName = _loc_7.boxName;
                _loc_6.boxColor = _loc_7.boxColor;
                _loc_8 = param1[_loc_5][2];
                _loc_6.bonusItem = this.renderBonusItem(_loc_8);
                _loc_2.push(_loc_6);
                _loc_5++;
            }
            return _loc_2;
        }// end function

        private function boxData(param1:int) : Object
        {
            var _loc_2:Object = {};
            switch(param1)
            {
                case Mod_CatHunt_Base.BOX_NONE:
                {
                    _loc_2.boxName = "";
                    _loc_2.boxColor = 0;
                    break;
                }
                case Mod_CatHunt_Base.BOX_GOLDEN:
                {
                    _loc_2.boxName = CatHuntControllerLang.BOX_GOLDEN;
                    _loc_2.boxColor = HtmlText.Orange;
                    break;
                }
                case Mod_CatHunt_Base.BOX_BLUE:
                {
                    _loc_2.boxName = CatHuntControllerLang.BOX_BLUE;
                    _loc_2.boxColor = HtmlText.Blue2;
                    break;
                }
                case Mod_CatHunt_Base.BOX_PURPLE:
                {
                    _loc_2.boxName = CatHuntControllerLang.BOX_PURPLE;
                    _loc_2.boxColor = HtmlText.Purple;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function renderBonusItem(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.type = param1[_loc_4][0];
                _loc_5.bonusValue = param1[_loc_4][1];
                _loc_5.name = this.renderAwardType(_loc_5.type);
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function renderAwardType(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_CatHunt_Base.BT_COIN:
                {
                    _loc_2 = CatHuntControllerLang.BT_COIN;
                    break;
                }
                case Mod_CatHunt_Base.BT_VIGOUR:
                {
                    _loc_2 = CatHuntControllerLang.BT_VIGOUR;
                    break;
                }
                case Mod_CatHunt_Base.BT_REPUTATION:
                {
                    _loc_2 = CatHuntControllerLang.BT_REPUTATION;
                    break;
                }
                case Mod_CatHunt_Base.BT_EXPERIENCE:
                {
                    _loc_2 = CatHuntControllerLang.BT_EXPERIENCE;
                    break;
                }
                case Mod_CatHunt_Base.BT_KARMA:
                {
                    _loc_2 = CatHuntControllerLang.BT_KARMA;
                    break;
                }
                case Mod_CatHunt_Base.BT_REACHED:
                {
                    _loc_2 = CatHuntControllerLang.BT_REACHED;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
