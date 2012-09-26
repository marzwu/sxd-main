package com.controllers
{
    import com.*;
    import com.lang.client.com.controllers.*;
    import com.protocols.*;

    public class TravelEventController extends Base
    {
        private var _activityInfo:Array;
        private var _eventAndAnswer:Array;
        private var _travelEvent:Array;

        public function TravelEventController()
        {
            return;
        }// end function

        public function get activityInfo() : Object
        {
            var _loc_1:* = _data.travelEvent.activityInfo;
            var _loc_2:* = this.renderActivityInfo(_loc_1);
            return _loc_2;
        }// end function

        public function get eventAndAnswer() : Object
        {
            var _loc_1:* = _data.travelEvent.eventAndAnswer;
            var _loc_2:Object = {};
            _loc_2.eventId = _loc_1[0];
            _loc_2.event = _loc_1[1];
            _loc_2.answerList = this.renderAnswer(_loc_1[2]);
            _loc_2.msg = _loc_1[3];
            return _loc_2;
        }// end function

        public function get cancelCd() : Object
        {
            var _loc_1:Object = {};
            var _loc_2:* = _data.travelEvent.cancelCd;
            _loc_1.msg = _loc_2[0];
            return _loc_1;
        }// end function

        private function renderAnswer(param1:Array) : Array
        {
            var _loc_5:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.answerId = param1[_loc_4][0];
                _loc_5.answerSign = param1[_loc_4][1];
                _loc_5.eventAnswer = param1[_loc_4][2];
                _loc_2.push(_loc_5);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function get answer() : Object
        {
            var _loc_1:* = _data.travelEvent.travelEvent;
            var _loc_2:* = _loc_1[0];
            var _loc_3:Object = {};
            _loc_3.answer = TravelEventControllerLang.AnswerInfo;
            _loc_3.answerValue = this.renderAward(_loc_1[1], _loc_3);
            var _loc_4:Array = [];
            [][0] = _loc_1[2];
            _loc_4[1] = _loc_1[3];
            _loc_4[2] = _loc_1[4];
            _loc_4[3] = _loc_1[5];
            _loc_3.activityInfo = this.renderActivityInfo(_loc_4);
            return _loc_3;
        }// end function

        private function renderActivityInfo(param1:Array) : Object
        {
            var _loc_2:Object = {};
            _loc_2.joinCount = param1[0];
            _loc_2.totalCount = param1[1];
            _loc_2.cdTimer = param1[2];
            _loc_2.cdIngot = param1[3];
            _loc_2.info = TravelEventControllerLang.TravelEvent + "（" + _loc_2.joinCount + "/" + _loc_2.totalCount + "）";
            if (_loc_2.cdTimer <= 0)
            {
                _loc_2.cdIngotInfo = TravelEventControllerLang.TravelEventOpen;
                _loc_2.isShow = false;
            }
            else
            {
                _loc_2.cdIngotInfo = "<font color=\"#ff9900\">" + Lang.sprintf(TravelEventControllerLang.ClearCd, _loc_2.cdIngot) + "</font>";
                _loc_2.isShow = true;
            }
            if (_loc_2.joinCount >= _loc_2.totalCount)
            {
                _loc_2.isEnd = true;
            }
            else
            {
                _loc_2.isEnd = false;
            }
            return _loc_2;
        }// end function

        private function renderAward(param1:Array, param2:Object) : Array
        {
            var _loc_6:Object = null;
            var _loc_7:int = 0;
            var _loc_3:Array = [];
            var _loc_4:* = param1.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = {};
                _loc_7 = param1[_loc_5][1];
                switch(param1[_loc_5][0])
                {
                    case Mod_TravelEvent_Base.COIN:
                    {
                        _loc_6.type = TravelEventControllerLang.Coin;
                        break;
                    }
                    case Mod_TravelEvent_Base.EXP:
                    {
                        _loc_6.type = TravelEventControllerLang.Exp;
                        break;
                    }
                    case Mod_TravelEvent_Base.FAME:
                    {
                        _loc_6.type = TravelEventControllerLang.Fame;
                        break;
                    }
                    case Mod_TravelEvent_Base.POWER:
                    {
                        _loc_6.type = TravelEventControllerLang.Power;
                        break;
                    }
                    case Mod_TravelEvent_Base.SKILL:
                    {
                        _loc_6.type = TravelEventControllerLang.Skill;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (param1[_loc_5][1] > 0)
                {
                    _loc_6.color = 16773632;
                    _loc_6.info = TravelEventControllerLang.Get + _loc_6.type + " " + _loc_7;
                    param2.answer = param2.answer + (" " + _loc_7 + _loc_6.type);
                }
                if (param1[_loc_5][1] < 0)
                {
                    _loc_6.color = 16711680;
                    _loc_6.info = TravelEventControllerLang.Loss + _loc_6.type + " " + _loc_7;
                    param2.answer = param2.answer + (" " + _loc_7 + _loc_6.type);
                }
                _loc_6.baseType = _loc_6.type + " " + _loc_7;
                if (param1[_loc_5][1] != 0)
                {
                    _loc_3.push(_loc_6);
                }
                _loc_5++;
            }
            return _loc_3;
        }// end function

    }
}
