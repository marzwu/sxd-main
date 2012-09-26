package com.controllers
{
    import com.*;

    public class Base extends SuperSubBase
    {
        protected var _instanceName:String;
        protected var _ctrl:Controller;
        protected var _data:Data;

        public function Base()
        {
            return;
        }// end function

        override public function settle(param1:String, param2:View, param3:Controller, param4:Data, param5:SuperBase) : void
        {
            if (this._ctrl == null)
            {
                this._instanceName = param1;
                this._ctrl = param3;
                if (this._ctrl != param5)
                {
                    throw new Error(inheritError());
                }
                this._data = param4;
                if (this._data.hasOwnProperty(param1) && hasOwnProperty("ownData"))
                {
                    this["ownData"] = this._data[param1];
                }
            }
            return;
        }// end function

        public function destroy() : void
        {
            this._ctrl.destroyObject(this._instanceName);
            return;
        }// end function

    }
}
