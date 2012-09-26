package com.haloer.net
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class File extends Object
    {
        private var _uri:String;
        private var _loader:Loader;
        private var _applicationDomain:ApplicationDomain;
        private var _useNewDomain:Boolean = false;
        public var onProgress:Function;
        public var onComplete:Function;
        public var onError:Function;
        private var _lastBytes:uint = 0;
        private var _speed:Number = 0;
        private var _urlRnd:int = 0;
        private var _timer:Timer;
        private var _reloadCount:int = 3;
        public static var onVersion:Function;
        private static var _temp:Dictionary = new Dictionary();
        public static const limit:int = 3;
        private static var _id:int = 0;
        private static var _processes:Object = {};

        public function File()
        {
            this._loader = new Loader();
            this.addTemp();
            this._reloadCount = File.limit;
            return;
        }// end function

        private function addEvent() : void
        {
            var _loc_1:* = this._loader.contentLoaderInfo;
            _loc_1.addEventListener(Event.COMPLETE, this.complete);
            _loc_1.addEventListener(ProgressEvent.PROGRESS, this.progress);
            _loc_1.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatus);
            _loc_1.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            _loc_1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            return;
        }// end function

        private function removeEvent() : void
        {
            var _loc_1:* = this._loader.contentLoaderInfo;
            _loc_1.removeEventListener(Event.COMPLETE, this.complete);
            _loc_1.removeEventListener(ProgressEvent.PROGRESS, this.progress);
            _loc_1.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatus);
            _loc_1.removeEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            _loc_1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            return;
        }// end function

        public function load(param1:String) : void
        {
            this._uri = param1;
            var _loc_2:String = "";
            if (onVersion is Function)
            {
                _loc_2 = onVersion(param1);
                if (_loc_2 != "")
                {
                    _loc_2 = "?v=" + _loc_2;
                }
            }
            if (this._urlRnd)
            {
                _loc_2 = _loc_2 + ((_loc_2 ? ("&") : ("?")) + "r=" + this._urlRnd);
            }
            var _loc_3:* = new URLRequest(this._uri + _loc_2);
            var _loc_4:* = new LoaderContext();
            new LoaderContext().checkPolicyFile = true;
            _loc_4.applicationDomain = this._useNewDomain ? (new ApplicationDomain()) : (new ApplicationDomain(ApplicationDomain.currentDomain));
            this.addEvent();
            this._loader.load(_loc_3, _loc_4);
            return;
        }// end function

        private function complete(event:Event) : void
        {
            this._applicationDomain = this._loader.contentLoaderInfo.applicationDomain;
            if (this.onComplete is Function)
            {
                this.onComplete();
            }
            this.removeEvent();
            this.removeTemp();
            return;
        }// end function

        private function progress(event:ProgressEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (this.onProgress is Function)
            {
                if (this.onProgress.length == 3)
                {
                    if (event.bytesLoaded - this._lastBytes > 0)
                    {
                        this._speed = event.bytesLoaded - this._lastBytes;
                        this._lastBytes = event.bytesLoaded;
                        _loc_2 = this._speed / 1024;
                        _loc_3 = this._speed % 1024;
                        this._speed = _loc_2 + Math.floor(_loc_3 / 1024 * 10) / 10;
                    }
                    this.onProgress(event.bytesTotal, event.bytesLoaded, this._speed + "kb/s");
                }
                else
                {
                    this.onProgress(event.bytesTotal, event.bytesLoaded);
                }
            }
            return;
        }// end function

        private function httpStatus(event:HTTPStatusEvent) : void
        {
            return;
        }// end function

        private function securityErrorHandler(event:SecurityErrorEvent) : void
        {
            this.delayToLoad();
            return;
        }// end function

        private function ioErrorHandler(event:IOErrorEvent) : void
        {
            this.delayToLoad();
            return;
        }// end function

        private function addTemp() : void
        {
            File._temp[this] = 1;
            return;
        }// end function

        private function removeTemp() : void
        {
            delete File._temp[this];
            return;
        }// end function

        private function delayToLoad() : void
        {
            this._loader.unload();
            if (this._reloadCount <= 0)
            {
                this.stopLoad();
                this.removeEvent();
                this.removeTemp();
                if (this.onError is Function)
                {
                    this.onError();
                }
                return;
            }
            var _loc_1:String = this;
            var _loc_2:* = this._reloadCount - 1;
            _loc_1._reloadCount = _loc_2;
            this._timer = new Timer(100, 1);
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.startLoad);
            this._timer.start();
            return;
        }// end function

        private function startLoad(event:TimerEvent) : void
        {
            this.stopLoad();
            var _loc_2:String = this;
            var _loc_3:* = this._urlRnd + 1;
            _loc_2._urlRnd = _loc_3;
            if (this._urlRnd == 3)
            {
                this._urlRnd = Math.random() * 100;
            }
            this.load(this._uri);
            return;
        }// end function

        private function stopLoad() : void
        {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.startLoad);
            return;
        }// end function

        public function getClassByName(param1:String) : Class
        {
            var className:* = param1;
            try
            {
                return this._applicationDomain.getDefinition(className) as Class;
            }
            catch (e:Error)
            {
                throw new Error(className + " not found in " + _uri + "\n" + e);
            }
            return null;
        }// end function

        public function getClassObject(param1:String) : Object
        {
            var _loc_2:* = this.getClassByName(param1) as Class;
            return new _loc_2;
        }// end function

        public function get loader() : Loader
        {
            return this._loader;
        }// end function

        public function get applicationDomain() : ApplicationDomain
        {
            return this._applicationDomain;
        }// end function

        public function set useNewDomain(param1:Boolean) : void
        {
            this._useNewDomain = param1;
            return;
        }// end function

        public function get bytes() : ByteArray
        {
            return this._loader.contentLoaderInfo.bytes;
        }// end function

        public function get bitmap() : Bitmap
        {
            return this._loader.content as Bitmap;
        }// end function

        public static function loadList(param1:Array, param2:Function, param3:Function = null, param4:Function = null, param5:Function = null) : int
        {
            var _loc_7:* = _id + 1;
            _id = _loc_7;
            _processes[_id] = true;
            loadOne(param1, 0, [], param2, param3, param4, param5, _id);
            return _id;
        }// end function

        public static function stopLoadList(param1:int) : void
        {
            if (param1 && _processes[param1])
            {
                _processes[param1] = false;
            }
            return;
        }// end function

        private static function loadOne(param1:Array, param2:int, param3:Array, param4:Function, param5:Function = null, param6:Function = null, param7:Function = null, param8:int = 0) : void
        {
            var len:int;
            var list:* = param1;
            var index:* = param2;
            var temp:* = param3;
            var callback:* = param4;
            var progress:* = param5;
            var oneCompleted:* = param6;
            var error:* = param7;
            var id:* = param8;
            var file:* = new File;
            temp.push(file);
            len = list.length;
            file.onComplete = function () : void
            {
                if (_processes[id] == false)
                {
                    delete _processes[id];
                    return;
                }
                var _loc_1:* = (index + 1) >= len;
                if (oneCompleted is Function)
                {
                    oneCompleted(index, _loc_1);
                }
                if (_loc_1)
                {
                    delete _processes[id];
                    callback(temp);
                }
                else
                {
                    loadOne(list, (index + 1), temp, callback, progress, oneCompleted, error, id);
                }
                return;
            }// end function
            ;
            file.onProgress = function (param1:int, param2:int, param3:String) : void
            {
                var _loc_4:int = 0;
                if (progress is Function)
                {
                    _loc_4 = Math.floor(param2 / param1 * 100);
                    _loc_4 = Math.min(100, _loc_4);
                    if (progress.length == 4)
                    {
                        progress(len, index, _loc_4, param3);
                    }
                    else if (progress.length == 3)
                    {
                        progress(index, _loc_4, param3);
                    }
                    else
                    {
                        progress(index, _loc_4);
                    }
                }
                return;
            }// end function
            ;
            file.onError = function () : void
            {
                if (error is Function)
                {
                    error(index);
                }
                return;
            }// end function
            ;
            file.load(list[index]);
            return;
        }// end function

    }
}
