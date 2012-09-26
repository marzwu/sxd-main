﻿package 
{
    import Main.*;
    import com.*;
    import com.assist.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class Main extends Sprite
    {
        private var _ctrl:Controller;
        private var _data:Data;
        private var _view:View;
        private var _lang:Lang;
        private var _timer:Timer;
        private var _target:Sprite;
        public static var Instance:Main;

        public function Main() : void
        {
            addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
            return;
        }// end function

        protected function addedToStage(event:Event) : void
        {
            var e:* = event;
            Instance = this;
            Security.allowDomain("*");
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            URI.test = Config.EnableDomainSelector;
            URI.analyze(this);
            Helper.test = Config.EnableProtocolHelper;
            Helper.initStage(stage);
            this._data = new Data();
            this._ctrl = new Controller();
            this._view = new View(stage);
            this._lang = new Lang();
            this._data.onConnect = function () : void
            {
                Helper.backtrace("connected");
                _view.show();
                return;
            }// end function
            ;
            this._view.init(this._data, this._ctrl, this._lang);
            this._ctrl.init(this._data, this._lang);
            this._data.init(this._view, this._ctrl);
            Helper.backtrace("init");
            this.settleAge();
            return;
        }// end function

        private function settleAge() : void
        {
            this._timer = new Timer(1000);
            this._timer.addEventListener(TimerEvent.TIMER, this.timerHandler);
            this._timer.start();
            this._target = new Sprite();
            this._target.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
            return;
        }// end function

        public function unsettleAge() : void
        {
            if (this._timer)
            {
                this._timer.removeEventListener(TimerEvent.TIMER, this.timerHandler);
                this._timer = null;
            }
            if (this._target)
            {
                this._target.removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
                this._target = null;
            }
            return;
        }// end function

        private function timerHandler(event:TimerEvent) : void
        {
            this._data.timerProcess();
            this._ctrl.timerProcess();
            this._view.timerProcess();
            return;
        }// end function

        private function enterFrameHandler(event:Event) : void
        {
            this._data.frameProcess();
            this._ctrl.frameProcess();
            this._view.frameProcess();
            return;
        }// end function

    }
}
