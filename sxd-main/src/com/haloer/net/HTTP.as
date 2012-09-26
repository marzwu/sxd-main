package com.haloer.net
{
    import flash.events.*;
    import flash.net.*;

    public class HTTP extends Object
    {
        private var _loader:URLLoader;
        private var _method:String;
        public var url:String;
        public var data:Object;
        public var onComplete:Function;
        public var onError:Function;

        public function HTTP(param1:String = "text", param2:String = "get")
        {
            this._loader = new URLLoader();
            this._loader.dataFormat = param1;
            this._method = param2;
            return;
        }// end function

        public function load(param1:String = "") : void
        {
            var _loc_3:URLVariables = null;
            var _loc_4:String = null;
            if (param1 == "" && this.url == "")
            {
                throw new Error("无效的url！");
            }
            if (param1)
            {
                this.url = param1;
            }
            this.addEvent();
            var _loc_2:* = new URLRequest(this.url);
            _loc_2.method = this._method;
            if (this.data)
            {
                _loc_3 = new URLVariables();
                for (_loc_4 in this.data)
                {
                    
                    _loc_3[_loc_4] = this.data[_loc_4];
                }
                _loc_2.data = _loc_3;
            }
            this._loader.load(_loc_2);
            return;
        }// end function

        private function addEvent() : void
        {
            this._loader.addEventListener(Event.COMPLETE, this.complete);
            this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatus);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            this._loader.addEventListener(Event.OPEN, this.openHandler);
            this._loader.addEventListener(ProgressEvent.PROGRESS, this.progressHandler);
            return;
        }// end function

        private function removeEvent() : void
        {
            this._loader.removeEventListener(Event.COMPLETE, this.complete);
            this._loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatus);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            this._loader.removeEventListener(Event.OPEN, this.openHandler);
            this._loader.removeEventListener(ProgressEvent.PROGRESS, this.progressHandler);
            return;
        }// end function

        private function progressHandler(event:ProgressEvent) : void
        {
            return;
        }// end function

        private function openHandler(event:Event) : void
        {
            return;
        }// end function

        private function complete(event:Event) : void
        {
            this.removeEvent();
            if (this.onComplete is Function)
            {
                this.onComplete(event.target.data);
            }
            return;
        }// end function

        private function httpStatus(event:HTTPStatusEvent) : void
        {
            return;
        }// end function

        private function ioErrorHandler(event:IOErrorEvent) : void
        {
            this.removeEvent();
            if (this.onError is Function)
            {
                this.onError();
            }
            return;
        }// end function

        private function securityErrorHandler(event:SecurityErrorEvent) : void
        {
            this.removeEvent();
            if (this.onError is Function)
            {
                this.onError();
            }
            return;
        }// end function

        public function get loader() : URLLoader
        {
            return this._loader;
        }// end function

    }
}
