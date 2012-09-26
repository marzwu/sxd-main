package com.assist.view.warSoul
{
    import flash.display.*;
    import flash.geom.*;

    public class Soul extends MovieClip
    {
        public var isMcEnd:Boolean = false;
        public var angle:Number = 0;
        private var _playTime:int = 1;
        private var _lostTime:int = 0;
        private var _lostTimeCount:int = 0;
        private var _speed:Number = 5;
        public var DefuleScale:Number = 0;
        private var _onEnd:Function;
        private var _target:MovieClip;
        private var _scal:Number = 0;
        private var _point1:Point;
        private var _omega:Number = 10;

        public function Soul()
        {
            this._onEnd = new Function();
            return;
        }// end function

        public function set onEnd(param1:Function) : void
        {
            this._onEnd = param1;
            return;
        }// end function

        public function lostTime(param1:int) : void
        {
            this._lostTime = param1;
            this._lostTimeCount = param1;
            return;
        }// end function

        public function mcPlay() : void
        {
            this._lostTimeCount = this._lostTime;
            this.isMcEnd = false;
            return;
        }// end function

        public function set target(param1:MovieClip) : void
        {
            this._target = param1;
            return;
        }// end function

        public function get target() : MovieClip
        {
            return this._target;
        }// end function

        public function move() : void
        {
            if (this.isMcEnd == true)
            {
                return;
            }
            if (this._lostTimeCount > 0)
            {
                var _loc_2:String = this;
                var _loc_3:* = this._lostTimeCount - 1;
                _loc_2._lostTimeCount = _loc_3;
                return;
            }
            var _loc_2:String = this;
            var _loc_3:* = this._playTime + 1;
            _loc_2._playTime = _loc_3;
            if (this._playTime <= 1)
            {
                this._speed = 8;
            }
            (this._speed + 1);
            if (this._playTime > 0 && this._playTime < 10)
            {
                this.move1();
            }
            if (this._playTime >= 10 && this._playTime < 20)
            {
                this.move2();
            }
            if (this._playTime >= 20)
            {
                this.move3();
            }
            var _loc_1:* = this._speed / 1000;
            if (this._playTime > 60)
            {
                if (this.scaleX > 0.8)
                {
                    this._scal = this._scal - _loc_1;
                    if (this._scal < 0.6)
                    {
                        this._scal = 0.6;
                    }
                    this.scaleX = this._scal;
                    this.scaleY = this.scaleX;
                }
            }
            if (this._playTime > 15)
            {
                if (this._omega < 20)
                {
                    this._omega = this._omega + 2;
                }
            }
            if (this._speed > WarSoulData.MaxSpeed)
            {
                this._speed = WarSoulData.MaxSpeed;
            }
            if (this._speed < WarSoulData.MinSpeed)
            {
                this._speed = WarSoulData.MinSpeed;
            }
            this.endState();
            return;
        }// end function

        private function move1() : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_1:* = WarSoulData.StartPoint;
            if (this._point1 == null)
            {
                _loc_2 = 50 - int(Math.random() * 100);
                _loc_3 = _loc_2 > 0 ? (50) : (-50);
                this._point1 = new Point(_loc_1.x + _loc_2 + _loc_3, _loc_1.y);
            }
            Moving.rocketMoveForPoint(this, this._point1.x, this._point1.y - 50, this._speed, 5);
            return;
        }// end function

        private function move2() : void
        {
            Moving.rocketMoveForPoint(this, this._point1.x, this._point1.y, this._speed, 5);
            return;
        }// end function

        private function move3() : void
        {
            var _loc_1:* = WarSoulData.EndPoint;
            Moving.rocketMoveForPoint(this, _loc_1.x, _loc_1.y, this._speed, -this._omega);
            return;
        }// end function

        private function endState() : void
        {
            var _loc_1:* = WarSoulData.EndPoint;
            var _loc_2:* = Moving.pointDistance(this, _loc_1.x, _loc_1.y);
            if (_loc_2 <= 80 && this._playTime > 30)
            {
                this.x = _loc_1.x;
                this.y = _loc_1.y;
                this.rotation = 0;
                this.alpha = 0;
                this.isMcEnd = true;
                this._onEnd();
            }
            return;
        }// end function

    }
}
