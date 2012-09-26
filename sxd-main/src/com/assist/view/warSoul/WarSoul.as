package com.assist.view.warSoul
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class WarSoul extends Sprite
    {
        private var _mcTime:Timer;
        private var _onEnd:Function;
        private var _soulNum:int = 0;
        private var _mcRange:Point;
        private var _isDefuleScale:Boolean = false;
        private var _scale:Number = 1;
        private var _soulList:Array;
        private var _shansuoList:Array;

        public function WarSoul()
        {
            this._mcTime = new Timer(20);
            this._onEnd = new Function();
            this._mcRange = new Point(200, 200);
            this._soulList = [];
            this._shansuoList = [];
            this._mcTime.addEventListener(TimerEvent.TIMER, this.mcTimeHandler);
            return;
        }// end function

        public function getStartPoint(param1:Point) : void
        {
            WarSoulData.StartPoint = param1;
            return;
        }// end function

        public function getEndPoint(param1:Point) : void
        {
            WarSoulData.EndPoint = param1;
            return;
        }// end function

        public function getSoulTarget(param1:Class) : void
        {
            WarSoulData.SoulTarget = param1;
            return;
        }// end function

        public function lightTarget(param1:Class) : void
        {
            WarSoulData.LightTarget = param1;
            return;
        }// end function

        public function set onEnd(param1:Function) : void
        {
            this._onEnd = param1;
            return;
        }// end function

        public function getSoulNum(param1:int) : void
        {
            this._soulNum = param1;
            return;
        }// end function

        public function mcRange(param1:Point) : void
        {
            this._mcRange = param1;
            return;
        }// end function

        public function defuleScale(param1:Number = 1) : void
        {
            this._scale = param1;
            this._isDefuleScale = true;
            return;
        }// end function

        public function mcPlay() : void
        {
            this.renderSoul();
            this._mcTime.start();
            return;
        }// end function

        private function renderSoul() : void
        {
            var soul:Soul;
            var c:Class;
            var soulMc:MovieClip;
            var angle:Number;
            var ran:Number;
            var startPoint:* = WarSoulData.StartPoint;
            var x1:* = startPoint.x - 100;
            var y1:* = startPoint.y - 100;
            var endPoint:* = WarSoulData.EndPoint;
            var i:int;
            while (i < this._soulNum)
            {
                
                soul = new Soul();
                soul.lostTime(WarSoulData.mcLostTime * i);
                c = WarSoulData.SoulTarget;
                soulMc = new c as MovieClip;
                soul.target = soulMc;
                soul.x = x1 + Math.floor(Math.random() * this._mcRange.x);
                soul.y = y1 + Math.floor(Math.random() * this._mcRange.y);
                angle = Moving.mcAngle(startPoint, endPoint);
                soul.angle = angle + Math.floor(Math.random() * 100);
                ran = this._isDefuleScale == true ? (this._scale) : (0.6 + Math.random() * 0.3);
                soul.scaleX = ran;
                soul.scaleY = ran;
                soul.DefuleScale = ran;
                soul.onEnd = function () : void
            {
                addShanSuo();
                return;
            }// end function
            ;
                this._soulList.push(soul);
                this.addChild(soul);
                soul.addChild(soulMc);
                soul.mcPlay();
                i = (i + 1);
            }
            return;
        }// end function

        private function addShanSuo() : void
        {
            return;
        }// end function

        private function ssState() : void
        {
            var _loc_3:Object = null;
            var _loc_4:MovieClip = null;
            var _loc_1:* = this._shansuoList.length;
            var _loc_2:* = _loc_1 - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._shansuoList[_loc_2];
                if (_loc_3.time <= 0)
                {
                    _loc_4 = this._shansuoList[_loc_2].mc;
                    _loc_4.stop();
                    _loc_4.parent.removeChild(_loc_4);
                    _loc_4 = null;
                    this._shansuoList.splice(_loc_2, 1);
                }
                else
                {
                    var _loc_5:* = _loc_3;
                    var _loc_6:* = _loc_3.time - 1;
                    _loc_5.time = _loc_6;
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        private function ssClear() : void
        {
            var _loc_3:Object = null;
            var _loc_4:MovieClip = null;
            var _loc_1:* = this._shansuoList.length;
            var _loc_2:* = _loc_1 - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._shansuoList[_loc_2];
                _loc_4 = this._shansuoList[_loc_2].mc;
                _loc_4.stop();
                _loc_4.parent.removeChild(_loc_4);
                _loc_4 = null;
                _loc_2 = _loc_2 - 1;
            }
            this._shansuoList = null;
            return;
        }// end function

        private function soulPlay() : void
        {
            var _loc_3:Soul = null;
            var _loc_1:* = this._soulList.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._soulList[_loc_2] as Soul;
                _loc_3.move();
                _loc_2++;
            }
            return;
        }// end function

        private function mcTimeHandler(event:TimerEvent) : void
        {
            this.soulPlay();
            this.mcState();
            this.ssState();
            return;
        }// end function

        private function mcState() : void
        {
            var _loc_3:Soul = null;
            var _loc_1:* = this._soulList.length;
            var _loc_2:* = _loc_1 - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._soulList[_loc_2] as Soul;
                if (_loc_3.isMcEnd)
                {
                    _loc_3.target.stop();
                    _loc_3.removeChild(_loc_3.target);
                    _loc_3.target = null;
                    _loc_3.parent.removeChild(_loc_3);
                    _loc_3 = null;
                    this._soulList.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            if (_loc_1 <= 0)
            {
                this._onEnd();
                this._mcTime.stop();
            }
            return;
        }// end function

        private function mcClear() : void
        {
            var _loc_3:Soul = null;
            var _loc_1:* = this._soulList.length;
            var _loc_2:* = _loc_1 - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._soulList[_loc_2] as Soul;
                _loc_3.target.stop();
                _loc_3.removeChild(_loc_3.target);
                _loc_3.target = null;
                _loc_3.parent.removeChild(_loc_3);
                _loc_3 = null;
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function clear() : void
        {
            this._mcTime.stop();
            this.ssClear();
            this.mcClear();
            this._mcTime.addEventListener(TimerEvent.TIMER, this.mcTimeHandler);
            this._mcTime = null;
            return;
        }// end function

    }
}
