package com
{
    import flash.utils.*;

    public class SuperBase extends Object
    {
        private var _superSubBaseList:Object;
        private var _frameProcessList:Object;
        private var _timerProcessList:Object;
        private var _nameHash:Object;

        public function SuperBase()
        {
            this._superSubBaseList = {};
            this._frameProcessList = {};
            this._timerProcessList = {};
            this._nameHash = {};
            return;
        }// end function

        public function get sign() : String
        {
            return getQualifiedClassName(this);
        }// end function

        public function addToFrameProcessList(param1:String, param2:Function) : void
        {
            this._frameProcessList[param1] = param2;
            return;
        }// end function

        public function removeFromFrameProcessList(param1:String) : void
        {
            delete this._frameProcessList[param1];
            return;
        }// end function

        public function frameProcess() : void
        {
            var _loc_1:String = null;
            for (_loc_1 in this._frameProcessList)
            {
                
                var _loc_4:* = this._frameProcessList;
                _loc_4.this._frameProcessList[_loc_1]();
            }
            return;
        }// end function

        public function addToTimerProcessList(param1:String, param2:Function) : void
        {
            this._timerProcessList[param1] = param2;
            return;
        }// end function

        public function removeFromTimerProcessList(param1:String) : void
        {
            delete this._timerProcessList[param1];
            return;
        }// end function

        public function timerProcess() : void
        {
            var _loc_1:String = null;
            for (_loc_1 in this._timerProcessList)
            {
                
                var _loc_4:* = this._timerProcessList;
                _loc_4.this._timerProcessList[_loc_1]();
            }
            return;
        }// end function

        protected function createObjectBase(param1:Class, param2:String, param3:View, param4:Controller, param5:Data) : Object
        {
            var _loc_6:* = this._nameHash[param2];
            if (_loc_6 == null)
            {
                _loc_6 = param2.replace(/^\[class ""^\[class /, "");
                _loc_6 = _loc_6.substring(0, 1).toLowerCase() + _loc_6.substring(1);
                this._nameHash[param2] = _loc_6;
            }
            if (this._superSubBaseList[_loc_6] == null)
            {
                this._superSubBaseList[_loc_6] = new param1;
                (this._superSubBaseList[_loc_6] as SuperSubBase).settle(_loc_6, param3, param4, param5, this);
            }
            return this._superSubBaseList[_loc_6];
        }// end function

        public function destroyObject(param1:String) : void
        {
            delete this._superSubBaseList[param1];
            return;
        }// end function

        public function destroyAllObject(... args) : void
        {
            args = null;
            for (args in this._superSubBaseList)
            {
                
                if (args.indexOf(args) == -1)
                {
                    this.destroyObject(args);
                }
            }
            return;
        }// end function

    }
}
