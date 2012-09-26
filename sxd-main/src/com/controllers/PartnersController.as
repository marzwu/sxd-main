package com.controllers
{
    import com.protocols.*;

    public class PartnersController extends Base
    {

        public function PartnersController()
        {
            return;
        }// end function

        public function getPartnersList() : Array
        {
            var _loc_1:* = _data.partners.getPartnersList();
            var _loc_2:* = this.renderPartnersList(_loc_1);
            return _loc_2;
        }// end function

        private function renderPartnersList(param1:Array) : Array
        {
            var _loc_6:Object = null;
            var _loc_7:Object = null;
            var _loc_8:int = 0;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:Object = {};
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = param1[_loc_5];
                param1[_loc_5].isInviteBefore = _loc_6.is_invite_before == Mod_Partners_Base.YES;
                _loc_7 = this.getRecruitCount();
                _loc_8 = _loc_7.fame_level + 1;
                if (_loc_6.fame_level > _loc_8 && _loc_6.isInviteBefore == false)
                {
                }
                else
                {
                    if (_loc_4[_loc_6.fame_level] == null)
                    {
                        _loc_4[_loc_6.fame_level] = {};
                        _loc_2.push(_loc_4[_loc_6.fame_level]);
                    }
                    _loc_4[_loc_6.fame_level].fameLevel = _loc_6.fame_level;
                    if (_loc_4[_loc_6.fame_level].list == null)
                    {
                        _loc_4[_loc_6.fame_level].list = [];
                    }
                    if (_loc_6.is_invite == Mod_Partners_Base.NO)
                    {
                        _loc_4[_loc_6.fame_level].list.push(_loc_6);
                    }
                }
                _loc_5++;
            }
            return _loc_2;
        }// end function

        private function fameEmpty(param1:int, param2:int, param3:Object, param4:Array) : void
        {
            var _loc_5:* = param2 - 1;
            while (_loc_5 >= param1)
            {
                
                if (param3[_loc_5] == null)
                {
                    param3[_loc_5] = {};
                    param3[_loc_5].fameLevel = _loc_5;
                    param3[_loc_5].list = [];
                    param4.push(param3[_loc_5]);
                }
                _loc_5 = _loc_5 - 1;
            }
            return;
        }// end function

        public function getRecruitCount() : Object
        {
            var _loc_1:* = this._data.partners.getRecruitCount();
            return _loc_1;
        }// end function

        public function Recruit() : int
        {
            var _loc_1:* = this._data.partners.Recruit();
            return _loc_1;
        }// end function

        public function get recommend() : String
        {
            var _loc_1:* = this._data.partners.recommend;
            return _loc_1;
        }// end function

    }
}
