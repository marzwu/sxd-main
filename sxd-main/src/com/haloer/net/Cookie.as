package com.haloer.net
{
    import flash.events.*;
    import flash.net.*;

    public class Cookie extends Object
    {
        private var _so:SharedObject;

        public function Cookie(param1:String)
        {
            if (param1 == "")
            {
                throw new Error("name must not be empty!");
            }
            this._so = SharedObject.getLocal(param1);
            this._so.addEventListener(NetStatusEvent.NET_STATUS, this.handler);
            return;
        }// end function

        private function handler(event:NetStatusEvent) : void
        {
            return;
        }// end function

        public function setCookie(param1:String, param2:Object) : void
        {
            var name:* = param1;
            var value:* = param2;
            try
            {
                this._so.data[name] = value;
                this._so.flush(5000);
            }
            catch (e)
            {
            }
            return;
        }// end function

        public function getCookie(param1:String) : Object
        {
            return this._so.data[param1];
        }// end function

        public function clear(param1:String = "") : void
        {
            if (param1)
            {
                this._so.data[param1] = "";
            }
            else
            {
                this._so.clear();
            }
            return;
        }// end function

    }
}
