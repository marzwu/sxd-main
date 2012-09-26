package com.assist.view
{
    import com.assist.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class TextAnimation extends Sprite
    {
        private var _textInfo:String;
        private var _fieldMap:Bitmap;
        private var _bmpData:BitmapData;
        private var _speed:Number = -2;
        private var _alphaNum:Number = 0.05;
        private var _startAlphaNum:int = 30;
        private var _startPlay:int = 0;
        private var _stopPlay:int = 0;
        private var _target:DisplayObject;
        private var _txtX:Number = 0;
        private var _txtY:Number = 0;
        private var _onAnimationEnd:Function;
        private var _textField:TextField;
        private var _textFromet:TextFormat;
        private var _timer:Timer;
        private var _timerNum:int = 0;
        private var _numY:int = 0;

        public function TextAnimation()
        {
            this._onAnimationEnd = new Function();
            this._timer = new Timer(10);
            this._textField = new TextField();
            this._textField.autoSize = TextFieldAutoSize.LEFT;
            this._textField.mouseEnabled = false;
            this._textField.mouseWheelEnabled = false;
            this._textField.selectable = false;
            this._textField.filters = [Filter.filter2];
            this._textFromet = new TextFormat();
            this._textFromet.size = 12;
            this._timer.addEventListener(TimerEvent.TIMER, this.onTimerEvent);
            this._textField.alpha = 0;
            return;
        }// end function

        public function set textInfo(param1:String) : void
        {
            this._textField.htmlText = param1;
            this._textField.setTextFormat(this._textFromet);
            this.drawFile();
            return;
        }// end function

        private function drawFile() : void
        {
            this._bmpData = new BitmapData(this._textField.width, this._textField.height, true, 0);
            this._bmpData.draw(this._textField);
            this._fieldMap = new Bitmap(this._bmpData);
            return;
        }// end function

        public function set color(param1:uint) : void
        {
            this._textFromet.color = param1;
            return;
        }// end function

        public function set bold(param1:Boolean) : void
        {
            this._textFromet.bold = param1;
            return;
        }// end function

        public function set size(param1:int) : void
        {
            this._textFromet.size = param1;
            return;
        }// end function

        public function set speed(param1:Number) : void
        {
            this._speed = param1;
            return;
        }// end function

        public function set alphaNum(param1:Number) : void
        {
            this._alphaNum = param1;
            return;
        }// end function

        public function set startAlphaNum(param1:int) : void
        {
            this._startAlphaNum = param1;
            return;
        }// end function

        public function set starPlay(param1:int) : void
        {
            this._startPlay = param1;
            return;
        }// end function

        public function set stopPlay(param1:int) : void
        {
            this._stopPlay = param1;
            return;
        }// end function

        public function set target(param1:DisplayObject) : void
        {
            this._target = param1;
            if (this._target.parent)
            {
                this._target.parent.addChild(this._fieldMap);
                this._fieldMap.alpha = 0;
            }
            if (this._txtX == 0)
            {
                return;
            }
            this._fieldMap.y = this._fieldMap.y + this._numY + this._txtY;
            this.textLive();
            return;
        }// end function

        public function upChildIndex() : void
        {
            if (this._target.parent)
            {
                this._target.parent.setChildIndex(this._fieldMap, (this._target.parent.numChildren - 1));
            }
            return;
        }// end function

        public function point(param1:Number, param2:Number) : void
        {
            this._txtX = param1;
            this._txtY = param2;
            if (this._target == null)
            {
                return;
            }
            this._fieldMap.y = this._fieldMap.y + this._numY + this._txtY;
            this.textLive();
            return;
        }// end function

        public function start() : void
        {
            if (this._target == null || this._textField.length <= 0)
            {
                this._onAnimationEnd("");
                this._timer.stop();
                return;
            }
            this._timer.start();
            return;
        }// end function

        private function clear() : void
        {
            this._bmpData.dispose();
            this._bmpData = null;
            if (this._fieldMap != null && this._fieldMap.parent)
            {
                this._fieldMap.parent.removeChild(this._fieldMap);
                this._fieldMap = null;
            }
            this._textField = null;
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
            this._timer = null;
            return;
        }// end function

        public function set onAnimationEnd(param1:Function) : void
        {
            this._onAnimationEnd = param1;
            return;
        }// end function

        private function onTimerEvent(event:TimerEvent) : void
        {
            if (this._startPlay > 0)
            {
                var _loc_2:String = this;
                var _loc_3:* = this._startPlay - 1;
                _loc_2._startPlay = _loc_3;
                return;
            }
            if (this._stopPlay > 0)
            {
                var _loc_2:String = this;
                var _loc_3:* = this._stopPlay - 1;
                _loc_2._stopPlay = _loc_3;
            }
            else
            {
                this.textLive();
            }
            if (this._timerNum == 0)
            {
                this._fieldMap.y = this._target.y + this._numY + this._txtY;
                this.textLive();
            }
            var _loc_2:String = this;
            var _loc_3:* = this._timerNum + 1;
            _loc_2._timerNum = _loc_3;
            if (this._timerNum >= this._startAlphaNum)
            {
                if (this._fieldMap.alpha <= 0)
                {
                    this.clear();
                    this._onAnimationEnd("");
                }
                else
                {
                    this._fieldMap.alpha = this._fieldMap.alpha - this._alphaNum;
                }
            }
            else
            {
                this._fieldMap.alpha = this._fieldMap.alpha + this._alphaNum;
            }
            return;
        }// end function

        public function set numY(param1:int) : void
        {
            this._numY = param1;
            return;
        }// end function

        private function textLive() : void
        {
            this._fieldMap.y = this._fieldMap.y + this._speed;
            this._fieldMap.x = this._target.x - this._fieldMap.width / 2 + this._txtX;
            if (this._fieldMap.parent && this._fieldMap)
            {
                this._fieldMap.parent.setChildIndex(this._fieldMap, (this._fieldMap.parent.numChildren - 1));
            }
            return;
        }// end function

    }
}
