package com.controllers
{
    import com.*;
    import com.assist.view.*;
    import com.lang.client.com.controllers.*;

    public class RedEnvelopesController extends Base
    {
        public var showTime:String = "";
        private var _endTime:Number;

        public function RedEnvelopesController()
        {
            return;
        }// end function

        public function get getEnvelopsList() : Array
        {
            var _loc_9:Object = null;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_1:* = _data.redEnvelopes.getEnvelopsInfo;
            var _loc_2:Array = [];
            var _loc_3:* = _loc_1.length;
            var _loc_4:* = this._endTime * 1000;
            var _loc_5:* = _ctrl.player.serverTime * 1000;
            var _loc_6:* = (_loc_4 - _loc_5) / 1000;
            var _loc_7:* = (_loc_4 - _loc_5) / 1000 / 86400;
            this.showTime = "";
            if (_loc_6 > 0)
            {
                if (_loc_7 >= 1)
                {
                    this.showTime = Lang.sprintf(RedEnvelopesControllerLang.DiffDay, _loc_7);
                }
                else
                {
                    this.showTime = RedEnvelopesControllerLang.Diff + TimeChange.mainTime(_loc_6, ":");
                }
            }
            else
            {
                this.showTime = RedEnvelopesControllerLang.CanGet;
            }
            var _loc_8:int = 0;
            while (_loc_8 < _loc_3)
            {
                
                _loc_9 = {};
                _loc_10 = Math.floor(_loc_1[_loc_8][0] / 10);
                _loc_9.coin = _loc_10 == 0 ? (1) : (_loc_10);
                _loc_11 = Math.floor(_loc_1[_loc_8][1] / 10);
                _loc_9.ingot = _loc_11 == 0 ? (1) : (_loc_11);
                _loc_9.time = _loc_1[_loc_8][2];
                _loc_9.mainTime = _loc_5;
                _loc_9.showTime = this.showTime;
                _loc_2.push(_loc_9);
                _loc_8++;
            }
            return _loc_2;
        }// end function

        public function get GetEnvelope() : Object
        {
            var _loc_1:* = _data.redEnvelopes.GetEnvelope;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.redList = _loc_1[1];
            return _loc_2;
        }// end function

        public function get GetDate() : Number
        {
            this._endTime = _data.redEnvelopes.getDate[0];
            return this._endTime;
        }// end function

    }
}
