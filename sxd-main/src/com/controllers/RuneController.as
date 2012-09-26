package com.controllers
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.datas.*;
    import com.lang.client.com.controllers.*;

    public class RuneController extends Base
    {
        public var ownData:RuneData;
        private var _batchRuneUse:Array;
        private var _autoRuneInfo:Array;

        public function RuneController()
        {
            return;
        }// end function

        public function get runeList() : Object
        {
            var _loc_1:* = this.ownData.runeList;
            var _loc_2:Object = {};
            _loc_2.count = _loc_1[0];
            _loc_2.ingot = _loc_1[1];
            _loc_2.coins = _loc_1[2];
            _loc_2.isUser = _data.player.ingot >= _loc_2.ingot;
            return _loc_2;
        }// end function

        public function get runeUse() : Object
        {
            var _loc_1:* = this.ownData.runeUse;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.coins = _loc_1[1];
            _loc_2.count = _loc_1[2];
            _loc_2.ingot = _loc_1[3];
            _loc_2.isUser = _data.player.ingot >= _loc_2.ingot;
            return _loc_2;
        }// end function

        public function get batchRuneData() : Object
        {
            var _loc_1:* = this.ownData.batchRuneList;
            var _loc_2:Object = {};
            _loc_2.count = _loc_1[0];
            _loc_2.useCount = _loc_1[1];
            _loc_2.myIngot = _data.player.ingot;
            _loc_2.ingot = _loc_1[2];
            _loc_2.coins = _loc_1[3];
            this.renderBatchUseInfo(_loc_2);
            return _loc_2;
        }// end function

        public function get batchRuneUse() : Object
        {
            var _loc_1:* = this.ownData.batchRuneUse;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            _loc_2.newCoins = _loc_1[1];
            _loc_2.count = _loc_1[2];
            _loc_2.ingot = _loc_1[3];
            _loc_2.coins = _loc_1[4];
            return _loc_2;
        }// end function

        public function get runeUseNotify() : Object
        {
            var _loc_1:* = this.ownData.runeUseNotify;
            var _loc_2:Object = {};
            _loc_2.coins = _loc_1[0];
            _loc_2.count = _loc_1[1];
            _loc_2.ingot = _loc_1[2];
            _loc_2.newcoins = _loc_1[3];
            return _loc_2;
        }// end function

        public function renderBatchUseInfo(param1:Object) : void
        {
            param1.isVip6 = VIPType.check(VIPType.Level6);
            param1.isVip10 = VIPType.check(VIPType.Level10);
            param1.info = Lang.sprintf(HtmlText.white(RuneControllerLang.UserIngot), HtmlText.yellow(param1.ingot), param1.coins);
            return;
        }// end function

        public function get autoRuneInfo() : Object
        {
            var _loc_1:* = this.ownData.autoRuneInfo;
            var _loc_2:Object = {};
            _loc_2.isAutoRune = _loc_1[0];
            _loc_2.typeList = this.renderAutoRuneInfo(_loc_1[1]);
            _loc_2.key = _loc_1[2];
            _loc_2.value = this.renderAutoRuneValue(_loc_2.typeList, _loc_1[2]);
            return _loc_2;
        }// end function

        private function renderAutoRuneInfo(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.key = param1[_loc_4][0];
                _loc_5.value = param1[_loc_4][1] + RuneControllerLang.W;
                _loc_5.name = _loc_5.value;
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function renderAutoRuneValue(param1:Array, param2:int) : String
        {
            var _loc_5:Object = null;
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1[_loc_4];
                if (_loc_5.key == param2)
                {
                    return _loc_5.value;
                }
                _loc_4++;
            }
            return "";
        }// end function

        public function get setAutoRune() : Object
        {
            var _loc_1:* = this.ownData.setAutoRune;
            var _loc_2:Object = {};
            _loc_2.msg = _loc_1[0];
            return _loc_2;
        }// end function

    }
}
