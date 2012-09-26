package com.haloer.display
{
    import com.haloer.net.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Image extends Sprite
    {
        private var _file:File;
        private var _time:int = 0;
        private var _startTime:int = 0;
        public var url:String;
        public var bShowErr:Boolean = true;
        public var onComplete:Function;
        public static var errorImage:BitmapData = new BitmapData(1, 1, true, 0);
        public static var loadClass:Class = Sprite;
        private static var _cacheList:Object = {};
        private static var listFadeIn:Array = [];
        private static var listCall:Array = [];
        private static var enterFrameSprite:Sprite = new Sprite();

        public function Image(param1:String, param2:Boolean = false, param3:int = 100)
        {
            this.getImageUrl(param1, param2, param3);
            return;
        }// end function

        public function getImageUrl(param1:String, param2:Boolean = false, param3:int = 100) : void
        {
            if (param1.length <= 0)
            {
                return;
            }
            this.url = param1;
            this._time = param3;
            if (_cacheList[param1])
            {
                if (_cacheList[param1] is BitmapData)
                {
                    addChild(new Bitmap(_cacheList[param1], "auto", true));
                    this.runComplete();
                }
                else if (_cacheList[param1] is Class)
                {
                    addChild(new _cacheList[param1]);
                    this.runComplete();
                }
            }
            else
            {
                this._file = new File();
                this._file.onComplete = this.completeHandler;
                this._file.onError = this.ioErrorHandler;
                this._file.load(param1);
                if (param2 == true)
                {
                    this.addChild(new loadClass());
                }
            }
            return;
        }// end function

        public function set smoothing(param1:Boolean) : void
        {
            return;
        }// end function

        private function ioErrorHandler() : void
        {
            this.clear();
            if (this.bShowErr)
            {
                addChild(new Bitmap(errorImage));
            }
            this.runComplete();
            return;
        }// end function

        private function completeHandler() : void
        {
            var _loc_3:Object = null;
            this.clear();
            var _loc_1:* = this._file.loader;
            addChild(_loc_1.content);
            var _loc_2:Boolean = true;
            if (_loc_1)
            {
                _loc_3 = _loc_1.content;
                if (_loc_3 is Bitmap)
                {
                    (_loc_3 as Bitmap).smoothing = true;
                    if (_cacheList[this.url] == null)
                    {
                        _cacheList[this.url] = (_loc_3 as Bitmap).bitmapData.clone();
                    }
                }
                else if ((this.url.indexOf("icons/farm/") != -1 || this.url.indexOf("icons/fate/") != -1) && _cacheList[this.url] == null || this.url.indexOf("icons/study_stunt/") != -1 || this.url.indexOf("roles/effects/long") != -1)
                {
                    _cacheList[this.url] = _loc_3.constructor as Class;
                }
            }
            this.runComplete();
            return;
        }// end function

        private function runComplete() : void
        {
            listCall.push(this.runCompleteCallback);
            if (this._time > 0)
            {
                this.fadeIn();
            }
            return;
        }// end function

        private function runCompleteCallback() : void
        {
            if (this.onComplete is Function == false)
            {
                return;
            }
            if (this.onComplete.length == 0)
            {
                this.onComplete();
            }
            else
            {
                this.onComplete(this);
            }
            return;
        }// end function

        private function clear() : void
        {
            while (this.numChildren)
            {
                
                this.removeChildAt(0);
            }
            return;
        }// end function

        private function fadeIn() : void
        {
            this._startTime = getTimer();
            alpha = 0;
            listFadeIn.push(this.fadeInPass);
            return;
        }// end function

        private function fadeInPass() : void
        {
            var _loc_1:* = getTimer() - this._startTime;
            this.alpha = _loc_1 / this._time;
            if (this.alpha >= 1)
            {
                this.alpha = 1;
                _loc_1 = listFadeIn.indexOf(this.fadeInPass);
                listFadeIn.splice(_loc_1, 1);
            }
            return;
        }// end function

        public static function isInCache(param1:String) : Boolean
        {
            return _cacheList.hasOwnProperty(param1);
        }// end function

        private static function enterFrameImage(event:Event) : void
        {
            var _loc_2:Function = null;
            if (listCall.length > 0)
            {
                for each (_loc_2 in listCall)
                {
                    
                    Image._loc_2();
                }
                listCall = [];
            }
            for each (_loc_2 in listFadeIn)
            {
                
                Image._loc_2();
            }
            return;
        }// end function

        public static function initImage() : void
        {
            enterFrameSprite.addEventListener(Event.ENTER_FRAME, enterFrameImage);
            return;
        }// end function

    }
}
