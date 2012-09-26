package com.views
{
    import com.*;
    import com.assist.data.*;
    import com.assist.view.*;
    import com.haloer.net.*;
    import com.views.structure.*;

    public class Base extends SuperSubBase
    {
        protected var _instanceName:String;
        protected var _view:View;
        protected var _ctrl:Controller;
        protected var _data:IData;
        protected var _structure:Structure;
        protected var _popup:Popup;
        protected var _requested:Boolean = false;
        protected var _inStageTipTitle:String;
        protected var _inStageTipContent:String;
        protected var _ignoreKeyboardEvent:Boolean = false;
        private var _assetsLoaded:Boolean = false;

        public function Base()
        {
            return;
        }// end function

        public function get inStage() : Boolean
        {
            var _loc_1:Object = this;
            return this._popup.hasView(_loc_1 as IView);
        }// end function

        public function get inStageWithTip() : Boolean
        {
            if (this.inStage && this._inStageTipTitle)
            {
                this._view.showTip(this._inStageTipTitle, this._inStageTipContent);
            }
            return this.inStage;
        }// end function

        public function get requested() : Boolean
        {
            return this._requested;
        }// end function

        public function get ignoreKeyboardEvent() : Boolean
        {
            return this._ignoreKeyboardEvent;
        }// end function

        override public function settle(param1:String, param2:View, param3:Controller, param4:Data, param5:SuperBase) : void
        {
            if (this._view == null)
            {
                this._instanceName = param1;
                this._view = param2;
                if (this._view != param5)
                {
                    throw new Error(inheritError());
                }
                this._ctrl = param3;
                this._data = param4 as IData;
                if (this._ctrl.hasOwnProperty(param1) && hasOwnProperty("ownCtrl"))
                {
                    this["ownCtrl"] = this._ctrl[param1];
                }
            }
            this._structure = this._view.structure;
            this._popup = this._view.structure.popup;
            return;
        }// end function

        public function destroy() : void
        {
            this._view.destroyObject(this._instanceName);
            return;
        }// end function

        public function switchSelf() : void
        {
            if (this._ignoreKeyboardEvent)
            {
                return;
            }
            var _loc_1:Object = this;
            if (this._popup.hasView(_loc_1 as IView))
            {
                var _loc_2:String = this;
                _loc_2.this["close"]();
            }
            else
            {
                var _loc_2:String = this;
                _loc_2.this["show"]();
            }
            return;
        }// end function

        protected function loadAssetsList(param1:Array, param2:Function, param3:String = "") : void
        {
            var list:* = param1;
            var callback:* = param2;
            var description:* = param3;
            var onProgress:* = function (param1:uint, param2:uint, param3:Number) : void
            {
                _view.showLoading(description, param2);
                return;
            }// end function
            ;
            var onComplete:* = function (param1:int, param2:Boolean) : void
            {
                if (param2)
                {
                    _view.hideLoading();
                }
                return;
            }// end function
            ;
            File.loadList(list, callback, onProgress, onComplete);
            return;
        }// end function

        protected function loadAssets(param1:String, param2:Function, param3:String = "", param4:Boolean = false, param5:Boolean = false, param6:Function = null) : void
        {
            var self:Object;
            var lr:LoadResponder;
            var sign:* = param1;
            var callback:* = param2;
            var description:* = param3;
            var hideLoading:* = param4;
            var ignoreCheck:* = param5;
            var callback2:* = param6;
            if (this.inStage)
            {
                if (callback2 is Function)
                {
                    this.callback2();
                }
                return;
            }
            self;
            var allowToOpen:* = function () : Boolean
            {
                if (hideLoading == false)
                {
                    _view.hideLoading();
                }
                if (ignoreCheck == false && _popup.allowToOpen(self as IView) == false)
                {
                    return false;
                }
                return true;
            }// end function
            ;
            var handler:* = function () : void
            {
                if (allowToOpen())
                {
                    if (callback is Function)
                    {
                        callback();
                    }
                    if (callback2 is Function)
                    {
                        callback2();
                    }
                }
                return;
            }// end function
            ;
            if (this._view.hasResource(sign))
            {
                this.handler();
            }
            else
            {
                if (this.allowToOpen() == false)
                {
                    return;
                }
                if (this._assetsLoaded)
                {
                    return;
                }
                this._assetsLoaded = true;
                lr = new LoadResponder(handler, function (param1:String, param2:int) : void
            {
                if (hideLoading == false)
                {
                    _view.showLoading(description, param2);
                }
                return;
            }// end function
            );
                this._view.loadResources([sign], lr);
            }
            return;
        }// end function

        public function removeResource(param1:String) : void
        {
            this._assetsLoaded = false;
            this._view.removeResource(param1);
            return;
        }// end function

    }
}
