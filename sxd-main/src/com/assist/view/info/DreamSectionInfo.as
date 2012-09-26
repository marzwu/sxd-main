package com.assist.view.info
{
    import com.lang.client.com.assist.view.info.*;

    public class DreamSectionInfo extends Object
    {
        public var causal_point:int;
        public var bWin:Boolean;
        public var aura:int;
        public var next_lock:int = 0;
        public var requestRoleId:int;
        private var _roleList:Array;
        public var guanList:Array;
        public static const DEFAULTSTATE:int = 1;
        public static const WARSTATE:int = 2;
        public static const WAREDSTATE:int = 3;

        public function DreamSectionInfo()
        {
            this.guanList = [DreamSectionInfoLang.Guan1, DreamSectionInfoLang.Guan2, DreamSectionInfoLang.Guan3, DreamSectionInfoLang.Guan4, DreamSectionInfoLang.Guan5];
            return;
        }// end function

        public function set roleList(param1:Array) : void
        {
            this._roleList = param1;
            return;
        }// end function

        public function get roleList() : Array
        {
            return this._roleList;
        }// end function

        public function get requestRoleObj() : Object
        {
            var _loc_2:Object = null;
            var _loc_1:int = 0;
            while (_loc_1 < this._roleList.length)
            {
                
                _loc_2 = this._roleList[_loc_1];
                if (_loc_2.roleId == this.requestRoleId)
                {
                    return _loc_2;
                }
                _loc_1++;
            }
            return {};
        }// end function

        public function get requestGuanObj() : Object
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            var _loc_1:int = 0;
            while (_loc_1 < this._roleList.length)
            {
                
                _loc_2 = this._roleList[_loc_1];
                if (_loc_2.roleId == this.requestRoleId)
                {
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2.guanList.length)
                    {
                        
                        if (_loc_2.guanList[_loc_3].lock == _loc_2.lock)
                        {
                            return _loc_2.guanList[_loc_3];
                        }
                        _loc_3++;
                    }
                }
                _loc_1++;
            }
            return {};
        }// end function

    }
}
