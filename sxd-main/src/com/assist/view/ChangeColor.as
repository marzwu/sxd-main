package com.assist.view
{
    import com.assist.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.assist.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ChangeColor extends Sprite
    {
        private var _tip:ITip;
        private var _isFirst:Boolean = true;
        private var _downTimer:int = 6;
        private var _countTimer:int = 6;
        private var _timer:Timer;
        private var _isPlay:Boolean = false;
        private var _oldStr:String = "";
        private var _newStr:String = "";
        private var _textField:TextField;
        private var _oldColor:uint;
        private var _newColor:uint;
        private var _isSize:int;
        private var _isBold:Boolean;

        public function ChangeColor()
        {
            this._timer = new Timer(100);
            return;
        }// end function

        public function set tip(param1:ITip) : void
        {
            this._tip = param1;
            return;
        }// end function

        public function newTextColor(param1:TextField, param2:uint, param3:uint = 16777215, param4:int = 12, param5:Boolean = false) : void
        {
            var _loc_6:* = param1.text;
            if (this._isFirst)
            {
                this._textField = param1;
                this._textField.htmlText = htmlFormat(_loc_6, param4, param3, param5);
                this._isFirst = false;
                return;
            }
            this._oldStr = _loc_6;
            this._newStr = _loc_6;
            this._oldColor = param3;
            this._newColor = param2;
            this._downTimer = this._countTimer;
            this._isSize = param4;
            this._isBold = param5;
            if (this._isPlay == false)
            {
                this._timer.addEventListener(TimerEvent.TIMER, this.playTimerStart);
                this._isPlay = true;
                this._timer.start();
            }
            return;
        }// end function

        public function textColor(param1:TextField, param2:Number, param3:uint, param4:uint = 16777215, param5:int = 12, param6:Boolean = false) : void
        {
            this.textColorForCpom(param1, param2.toString(), param3, param4, param5, param6);
            return;
        }// end function

        public function textColorForIngot(param1:TextField, param2:Number, param3:uint, param4:uint = 16777215, param5:int = 12, param6:Boolean = false) : void
        {
            var _loc_7:* = param2.toString();
            if (param2 >= 99999)
            {
                _loc_7 = Math.floor(Number(param2 / 10000)) + ChangeColorLang.TenThousand;
            }
            this.textColorForCpom(param1, _loc_7, param3, param4, param5, param6);
            return;
        }// end function

        public function textColorForCoins(param1:TextField, param2:Number, param3:uint, param4:uint = 16777215, param5:int = 12, param6:Boolean = false) : void
        {
            var _loc_7:* = param2.toString();
            if (param2 >= 999999999)
            {
                _loc_7 = Math.floor(Number(param2 / 100000000)) + ChangeColorLang.YI;
            }
            else if (param2 >= 99999)
            {
                _loc_7 = Math.floor(Number(param2 / 10000)) + ChangeColorLang.TenThousand;
            }
            this.textColorForCpom(param1, _loc_7, param3, param4, param5, param6);
            return;
        }// end function

        public function textColorForCpom(param1:TextField, param2:String, param3:uint, param4:uint = 16777215, param5:int = 12, param6:Boolean = false) : void
        {
            if (this._isFirst)
            {
                this._textField = param1;
                this._textField.htmlText = htmlFormat(param2, param5, param4, param6);
                this._isFirst = false;
                this._oldStr = param2;
                return;
            }
            this._newStr = param2;
            this._oldColor = param4;
            this._newColor = param3;
            this._downTimer = this._countTimer;
            this._isSize = param5;
            this._isBold = param6;
            if (this._isPlay == false)
            {
                this._timer.addEventListener(TimerEvent.TIMER, this.playTimerStart);
                this._isPlay = true;
                this._timer.start();
            }
            else
            {
                this.endTextField();
            }
            return;
        }// end function

        public function set downTimer(param1:int) : void
        {
            this._downTimer = param1;
            this._countTimer = param1;
            return;
        }// end function

        private function playTimerStart(event:TimerEvent) : void
        {
            if (this._downTimer == 0)
            {
                this._timer.removeEventListener(TimerEvent.TIMER, this.playTimerStart);
                this._timer.stop();
                this.endTextField();
                this._isPlay = false;
            }
            else
            {
                if (this._downTimer % 2 == 0 && this._downTimer != 0)
                {
                    this._textField.htmlText = htmlFormat(this._oldStr.toString(), this._isSize, this._newColor, this._isBold);
                }
                else
                {
                    this._textField.htmlText = htmlFormat(this._oldStr.toString(), this._isSize, this._oldColor, this._isBold);
                }
                var _loc_2:String = this;
                var _loc_3:* = this._downTimer - 1;
                _loc_2._downTimer = _loc_3;
            }
            return;
        }// end function

        private function endTextField() : void
        {
            this._textField.htmlText = htmlFormat(this._newStr.toString(), this._isSize, this._oldColor, this._isBold);
            this._oldStr = this._newStr;
            return;
        }// end function

    }
}
