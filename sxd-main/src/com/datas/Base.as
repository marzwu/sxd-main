package com.datas
{
    import com.*;

    public class Base extends SuperSubBase
    {
        protected var _instanceName:String;
        protected var _data:Data;
        protected var _ctrl:Controller;
        protected var _loaded:Boolean = false;

        public function Base()
        {
            return;
        }// end function

        override public function settle(param1:String, param2:View, param3:Controller, param4:Data, param5:SuperBase) : void
        {
            if (this._data == null)
            {
                this._instanceName = param1;
                this._data = param4;
                if (this._data != param5)
                {
                    throw new Error(inheritError());
                }
                this._ctrl = this._ctrl;
            }
            return;
        }// end function

        public function destroy() : void
        {
            this._data.destroyObject(this._instanceName);
            return;
        }// end function

    }
}
