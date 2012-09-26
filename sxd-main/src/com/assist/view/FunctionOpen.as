package com.assist.view
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class FunctionOpen extends Sprite
    {
        private var _onMcEnd:Function;
        private var _lockMc:MovieClip;
        private var _timer:Timer;
        private var _playNum:int = 0;
        private var _stageWidth:Number = 1250;
        private var _stageHeight:Number = 650;
        private var _rect:Sprite;
        private var _black:MovieClip;

        public function FunctionOpen()
        {
            this._onMcEnd = new Function();
            this._timer = new Timer(20);
            this.alpha = 0;
            this.blackMc();
            this.loadFunctionOpenEffect();
            this.drawBlack();
            this._timer.addEventListener(TimerEvent.TIMER, this.mcTime);
            return;
        }// end function

        public function set onMcEnd(param1:Function) : void
        {
            this._onMcEnd = param1;
            return;
        }// end function

        private function mcTime(event:TimerEvent) : void
        {
            if (this._playNum == 1)
            {
                if (this.alpha < 1)
                {
                    this.alpha = this.alpha + 0.05;
                }
                else
                {
                    this._timer.stop();
                    this.startPlay();
                }
            }
            if (this._playNum == 2)
            {
                if (this.alpha > 0)
                {
                    this.alpha = this.alpha - 0.08;
                }
                else
                {
                    this._playNum = 0;
                    this._timer.stop();
                    this._onMcEnd();
                }
            }
            return;
        }// end function

        public function mcPlay() : void
        {
            this._playNum = 1;
            this.alpha = 0;
            this._timer.start();
            return;
        }// end function

        private function startPlay() : void
        {
            this._lockMc.gotoAndPlay(2);
            return;
        }// end function

        private function loadFunctionOpenEffect() : void
        {
            var _loc_1:* = FunctionBarEffect.functionOpen;
            this._lockMc = new _loc_1 as MovieClip;
            addChild(this._lockMc);
            this._lockMc.addEventListener("finish", this.mcEnd);
            return;
        }// end function

        private function mcEnd(event:Event) : void
        {
            this._lockMc.removeEventListener("finish", this.mcEnd);
            this._playNum = 2;
            this._timer.start();
            return;
        }// end function

        public function structureData(param1:Number, param2:Number) : void
        {
            this._stageWidth = param1;
            this._stageHeight = param2;
            this.drawBlack();
            return;
        }// end function

        public function drawBlack() : void
        {
            this._rect.graphics.beginFill(0);
            this._rect.graphics.drawRect(0, 0, this._stageWidth, this._stageHeight);
            this._rect.graphics.endFill();
            this._lockMc.x = this._stageWidth / 2;
            this._lockMc.y = this._stageHeight / 2;
            return;
        }// end function

        private function blackMc() : void
        {
            if (this._black != null)
            {
                return;
            }
            this._black = new MovieClip();
            addChild(this._black);
            this._black.alpha = 0.5;
            this._rect = new Sprite();
            this._black.addChild(this._rect);
            return;
        }// end function

        public function clear() : void
        {
            this._rect.parent.removeChild(this._rect);
            this._rect = null;
            this._black.parent.removeChild(this._black);
            this._black = null;
            this._lockMc = null;
            this._timer.removeEventListener(TimerEvent.TIMER, this.mcTime);
            this._timer.stop();
            this._timer = null;
            return;
        }// end function

    }
}
