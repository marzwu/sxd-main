package com
{
    import com.assist.*;
    import com.lang.client.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class DataBase extends SuperBase
    {
        protected var _ctrl:Controller;
        protected var _view:View;
        protected var _notAllowList:Object;
        protected var _sock:Socket;
        private var _host:String;
        private var _port:int;
        private var _useProxy:Boolean = false;
        protected var _onConnect:Function;
        protected var _onClose:Function;
        private var connectSucceed:Boolean = false;
        private var pack_len:int = -1;
        private var buffer:ByteArray;
        private var _event:EventDispatcher;
        private var _eventList:Object;

        public function DataBase() : void
        {
            this._notAllowList = {};
            this._sock = new Socket();
            this._onConnect = new Function();
            this.buffer = new ByteArray();
            this._event = new EventDispatcher();
            this._eventList = {};
            return;
        }// end function

        public function get controller() : Controller
        {
            return this._ctrl;
        }// end function

        public function init(param1:View, param2:Controller) : void
        {
            this._view = param1;
            this._ctrl = param2;
            return;
        }// end function

        protected function createObject(param1:Class, param2:String = "") : Object
        {
            param2 = param1 + "";
            param2 = param2.replace(/Data\]$""Data\]$/, "");
            return createObjectBase(param1, param2, this._view, this._ctrl, this as Data);
        }// end function

        protected function hasNotAllow(param1:int, param2:int) : Boolean
        {
            var _loc_4:Object = null;
            var _loc_3:* = this._notAllowList[Protocol.concat(param1, param2)] || 0;
            if (_loc_3 == 0 || new Date().getTime() - _loc_3 > 900)
            {
                return false;
            }
            _loc_4 = Protocol.lookupProtocol(param1, param2);
            Helper.alert(Protocol.getProtocolDescription(_loc_4["request"]) + " 请求间隔太短。");
            return true;
        }// end function

        protected function addNotAllow(param1:int, param2:int) : void
        {
            this._notAllowList[Protocol.concat(param1, param2)] = new Date().getTime();
            return;
        }// end function

        protected function removeNotAllow(param1:int, param2:int) : void
        {
            return;
        }// end function

        public function call(param1:Object, param2:Function, param3:Array, param4:Boolean = true) : void
        {
            if (this._sock.connected == false)
            {
                this._view.tip2.showAlert(DataBaseLang.connected);
                return;
            }
            var _loc_5:* = param1["module"];
            var _loc_6:* = param1["action"];
            if (this.hasNotAllow(_loc_5, _loc_6))
            {
                return;
            }
            if (param4 == false)
            {
                this.addNotAllow(_loc_5, _loc_6);
            }
            if (param2 is Function)
            {
                this.patchBase(_loc_5, _loc_6, this.patchHandler(_loc_5, _loc_6, param2));
            }
            Helper.recordInteraction(Helper.REQUEST, _loc_5, _loc_6, param3);
            this.netCall(_loc_5, _loc_6, param1["request"], param3);
            return;
        }// end function

        private function patchHandler(param1:uint, param2:uint, param3:Function) : Function
        {
            var modId:* = param1;
            var funId:* = param2;
            var callback:* = param3;
            return function (event:Event) : void
            {
                if (!Protocol.keepAlive(modId, funId))
                {
                    cancelPatchBase(modId, funId);
                }
                callback();
                return;
            }// end function
            ;
        }// end function

        private function netCall(param1:uint, param2:uint, param3:Array, param4:Array) : void
        {
            var _loc_5:* = new ByteArray();
            new ByteArray().writeByte(param1);
            _loc_5.writeByte(param2);
            var _loc_6:* = Protocol.synthesize(param4, param3);
            this._sock.writeInt(_loc_5.length + _loc_6.length);
            this._sock.writeBytes(_loc_5, 0, _loc_5.length);
            this._sock.writeBytes(_loc_6, 0, _loc_6.length);
            this._sock.flush();
            return;
        }// end function

        public function set onConnect(param1:Function) : void
        {
            this._onConnect = param1;
            return;
        }// end function

        public function set onClose(param1:Function) : void
        {
            this._onClose = param1;
            return;
        }// end function

        public function connect(param1:String, param2:int) : void
        {
            this._host = param1;
            this._port = param2;
            this.addListener();
            if (this._sock.connected)
            {
                this._sock.close();
            }
            this._sock.connect(param1, this._port);
            return;
        }// end function

        public function close() : void
        {
            if (this._sock && this._sock.connected)
            {
                this._sock.close();
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._sock.addEventListener(Event.CONNECT, this.onConnectHandler);
            this._sock.addEventListener(IOErrorEvent.IO_ERROR, this.onIoErrorHandler);
            this._sock.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityErrorHandler);
            this._sock.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketDataHandler);
            this._sock.addEventListener(Event.CLOSE, this.onCloseHandler);
            return;
        }// end function

        private function removeListener() : void
        {
            this._sock.removeEventListener(Event.CONNECT, this.onConnectHandler);
            this._sock.removeEventListener(IOErrorEvent.IO_ERROR, this.onIoErrorHandler);
            this._sock.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityErrorHandler);
            this._sock.removeEventListener(ProgressEvent.SOCKET_DATA, this.onSocketDataHandler);
            this._sock.removeEventListener(Event.CLOSE, this.onCloseHandler);
            return;
        }// end function

        private function onConnectHandler(event:Event) : void
        {
            var _loc_2:ByteArray = null;
            if (this._useProxy)
            {
                _loc_2 = new ByteArray();
                _loc_2.writeInt(6);
                _loc_2.writeByte(100);
                _loc_2.writeByte(0);
                _loc_2.writeInt(this._port);
                this._sock.writeBytes(_loc_2, 0, _loc_2.length);
                this.onConnectHandlerReal();
            }
            else
            {
                this.onConnectHandlerReal();
            }
            return;
        }// end function

        private function onConnectHandlerReal() : void
        {
            Helper.backtrace("onConnectHandler");
            this.connectSucceed = true;
            if (this._onConnect is Function)
            {
                this._onConnect();
                this._onConnect = null;
            }
            return;
        }// end function

        private function onCloseHandler(event:Event) : void
        {
            Helper.backtrace("onCloseHandler");
            this._view.tip2.showAlert(DataBaseLang.connected);
            this._view.resetHost();
            if (this._onClose is Function)
            {
                this._onClose();
            }
            return;
        }// end function

        private function onIoErrorHandler(event:IOErrorEvent) : void
        {
            if (this._useProxy == false)
            {
                this.connectProxy();
            }
            else
            {
                Helper.backtrace("onIoErrorHandler");
                this._view.alert.socketClosed("连接不到服务器！", "Socket 错误。 URL: " + this._host + ":" + this._port + "，该地址没有提供Socket服务。");
                this._view.resetHost();
            }
            return;
        }// end function

        private function onSecurityErrorHandler(event:SecurityErrorEvent) : void
        {
            if (this._useProxy == false)
            {
                this.connectProxy();
            }
            else
            {
                Helper.backtrace("onSecurityErrorHandler");
                this._view.alert.socketClosed("安全沙箱冲突！", "安全沙箱冲突: 不能从" + this._host + ":" + this._port + "加载数据。");
                this._view.resetHost();
            }
            return;
        }// end function

        private function connectProxy() : void
        {
            if (this.connectSucceed == true)
            {
                this._view.tip2.showAlert(DataBaseLang.connected);
                return;
            }
            this._sock.close();
            this.removeListener();
            this._useProxy = true;
            this._sock = new Socket();
            this.addListener();
            this._sock.connect(this._host, 443);
            return;
        }// end function

        private function onSocketDataHandler(event:ProgressEvent) : void
        {
            while (this._sock.bytesAvailable >= this.pack_len)
            {
                
                if (this.pack_len == -1 && this._sock.bytesAvailable >= 4)
                {
                    this.pack_len = this._sock.readUnsignedInt();
                }
                if (this.pack_len == -1)
                {
                    return;
                }
                if (this._sock.bytesAvailable < this.pack_len)
                {
                    return;
                }
                this.buffer = new ByteArray();
                this._sock.readBytes(this.buffer, 0, this.pack_len);
                this.parseSocketData(this.buffer);
                this.pack_len = -1;
                this.onSocketDataHandler(null);
            }
            return;
        }// end function

        protected function parseSocketData(param1:ByteArray) : void
        {
            return;
        }// end function

        public function patch(param1:Object, param2:Function) : void
        {
            var _loc_3:* = param1["module"];
            var _loc_4:* = param1["action"];
            this.patchBase(_loc_3, _loc_4, this.patchHandler(_loc_3, _loc_4, param2));
            Protocol.addWired(param1);
            return;
        }// end function

        private function patchBase(param1:uint, param2:uint, param3:Function) : void
        {
            var _loc_4:* = Protocol.concat(param1, param2);
            if (this._eventList[_loc_4] is Function)
            {
                this.cancelPatchBase(param1, param2);
            }
            this._eventList[_loc_4] = param3;
            this._event.addEventListener(_loc_4, param3);
            return;
        }// end function

        public function cancelPatch(param1:Object) : void
        {
            var _loc_2:* = param1["module"];
            var _loc_3:* = param1["action"];
            Protocol.removeWired(_loc_2, _loc_3);
            this.cancelPatchBase(_loc_2, _loc_3);
            return;
        }// end function

        private function cancelPatchBase(param1:uint, param2:uint) : void
        {
            var _loc_3:* = Protocol.concat(param1, param2);
            var _loc_4:* = this._eventList[_loc_3];
            if (this._eventList[_loc_3] is Function)
            {
                this._event.removeEventListener(_loc_3, _loc_4);
            }
            return;
        }// end function

        protected function dispatch(param1:uint, param2:uint) : void
        {
            var _loc_4:Object = null;
            var _loc_3:* = Protocol.concat(param1, param2);
            if (this._eventList[_loc_3] is Function)
            {
                this._event.dispatchEvent(new Event(_loc_3));
            }
            else
            {
                _loc_4 = Protocol.lookupProtocol(param1, param2);
                Helper.alert("[response]接口没有注册UI回调方法：", Protocol.getProtocolDescription(_loc_4["request"]));
            }
            return;
        }// end function

    }
}
