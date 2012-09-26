package com.views.structure
{
    import com.*;
    import com.assist.view.*;
    import com.haloer.data.*;
    import com.views.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Popup extends Base
    {
        private var _superViews:Array;
        private var _coexistViews:Array;
        private var _exclusiveViews:Array;
        private var _inTownViews:Array;
        private var _freeViews:Array;
        public var structure:Structure;
        private var _view:View;
        private var _currentAddedView:IView;
        private var _supers:Dictionary;
        private var _views:Dictionary;
        private var _frees:Dictionary;
        private var _supersList:Array;
        private var _viewsList:Array;
        private var _timerOut:Timer;
        private var _hasFade:Boolean = false;
        private var _fadeOutList:Dictionary;
        private var _shape:Sprite;
        private var _alphp:Number = 0;
        private var _processList:Dictionary;
        private var _focusView:IView;

        public function Popup(param1:View) : void
        {
            this._supers = new Dictionary();
            this._views = new Dictionary();
            this._frees = new Dictionary();
            this._supersList = [];
            this._viewsList = [];
            this._fadeOutList = new Dictionary();
            this._processList = new Dictionary();
            this._view = param1;
            this._superViews = this._view.superViews;
            this._coexistViews = this._view.coexistViews;
            this._exclusiveViews = this._view.exclusiveViews;
            this._inTownViews = this._view.inTownViews;
            this._freeViews = this._view.freeViews;
            this._view.addToFrameProcessList(this.toString(), this.process);
            return;
        }// end function

        public function addView(param1:IView, param2:Sprite) : void
        {
            if (this.hasViewIncluded(param1, this._freeViews))
            {
                this.removeFadeOutList(param1);
                this._frees[param1] = param2;
                this.addChildWithFade(param1, param2);
                this._view.chat.updateDepth(param1);
                this._view.friendMessage.updateDepth(param1);
                if (param1 is TakeBibleRoadView)
                {
                    this._view.toolbar.functionBarParent = this;
                }
                return;
            }
            if (this.hasViewIncluded(param1, this._superViews))
            {
                this.closeAll();
                this.removeFadeOutList(param1);
                this._supers[param1] = param2;
                this.addChildWithFade(param1, param2);
                this._view.chat.updateDepth(param1);
                return;
            }
            var _loc_3:* = this.getCoexistViews(param1);
            if (_loc_3.length > 0)
            {
                _loc_3 = _loc_3[0];
            }
            _loc_3.push(param1);
            this.closeExclude(_loc_3);
            this.removeFadeOutList(param1);
            this._views[param1] = param2;
            this.addChildWithFade(param1, param2);
            this.setfocusView(param1);
            param2.mouseChildren = true;
            param2.mouseEnabled = true;
            if (param2.width < Structure.stageWidth)
            {
                param2.x = Math.floor((Structure.stageWidth - param2.width) / 2);
                param2.y = Math.floor((Structure.stageHeight - param2.height) / 2);
            }
            if (this._viewsList.indexOf(param1) == -1)
            {
                this._viewsList.push(param1);
            }
            this._currentAddedView = param1;
            this.reposition();
            setTimeout(this.reposition, 10);
            return;
        }// end function

        private function addChildWithFade(param1:IView, param2:Sprite) : void
        {
            var bm:Bitmap;
            var handle:Function;
            var timer:Timer;
            var view:* = param1;
            var panel:* = param2;
            addChild(panel);
            return;
        }// end function

        public function closeView(param1:IView) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Sprite = null;
            var _loc_4:Sprite = null;
            if (this.hasViewIncluded(param1, this._freeViews))
            {
                _loc_3 = this._frees[param1];
                if (_loc_3)
                {
                    this.startFadeOut(param1, true);
                    this._view.cancelCenter(param1.sign);
                    delete this._frees[param1];
                    removeChild(_loc_3);
                    Shortcut.removeView(param1);
                }
                return;
            }
            if (this.hasViewIncluded(param1, this._superViews))
            {
                _loc_4 = this._supers[param1];
                if (_loc_4)
                {
                    if (!(param1 is WorldView))
                    {
                        this.startFadeOut(param1, true);
                    }
                    if (!(param1 is NewWorldView))
                    {
                        this.startFadeOut(param1, true);
                    }
                    this._view.cancelCenter(param1.sign);
                    delete this._supers[param1];
                    removeChild(_loc_4);
                    Shortcut.removeView(param1);
                }
                return;
            }
            if (this._views[param1] is Sprite)
            {
                this._views[param1].mouseChildren = false;
                this._views[param1].mouseEnabled = false;
                this.closeView0(param1, true);
            }
            this.setfocusView(null);
            for (_loc_2 in this._views)
            {
                
                if (this.focusView == null)
                {
                    this.setfocusView(_loc_2 as IView);
                    break;
                }
            }
            setTimeout(this.reposition, 100);
            return;
        }// end function

        private function closeView0(param1:IView, param2:Boolean) : void
        {
            this._view.cancelCenter(param1.sign);
            this.startFadeOut(param1);
            this.removeView(param1);
            if (param2 == false)
            {
                param1.close();
            }
            var _loc_3:* = this._viewsList.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (param1 == this._viewsList[_loc_4])
                {
                    this._viewsList.splice(_loc_4, 1);
                    break;
                }
                _loc_4++;
            }
            Shortcut.removeView(param1);
            return;
        }// end function

        private function removeView(param1:IView) : void
        {
            if (this._views[param1] && this._views[param1].parent)
            {
                removeChild(this._views[param1]);
            }
            delete this._views[param1];
            return;
        }// end function

        private function closeExclude(param1:Array) : void
        {
            var _loc_2:* = oObject.getKeys(this._views);
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (param1.indexOf(_loc_2[_loc_3]) == -1)
                {
                    this.closeView0(_loc_2[_loc_3] as IView, false);
                }
                _loc_3++;
            }
            return;
        }// end function

        override public function closeAll() : void
        {
            var _loc_3:IView = null;
            var _loc_1:* = oObject.getKeys(this._views);
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = _loc_1[_loc_2];
                this._view.cancelCenter(_loc_3.sign);
                this.startFadeOut(_loc_3);
                this.closeView0(_loc_3, false);
                _loc_2++;
            }
            this.setfocusView(null);
            return;
        }// end function

        public function hasView(param1:IView) : Boolean
        {
            return this._views[param1] || this._supers[param1] || this._frees[param1];
        }// end function

        public function updateFocusView(param1:Sprite) : void
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this._views)
            {
                
                if (this._views[_loc_2] == param1)
                {
                    if (this.focusView != _loc_2)
                    {
                        this.setfocusView(_loc_2 as IView);
                    }
                    break;
                }
            }
            return;
        }// end function

        public function getRelatedView(param1:DisplayObject) : IView
        {
            var obj:* = param1;
            var handler:* = function (param1:Dictionary) : IView
            {
                var _loc_2:* = undefined;
                for (_loc_2 in param1)
                {
                    
                    if (param1[_loc_2].contains(obj))
                    {
                        return _loc_2;
                    }
                }
                return null;
            }// end function
            ;
            return this.handler(this._views) || this.handler(this._supers) || this.handler(this._frees);
        }// end function

        private function getCoexistViews(param1:IView) : Array
        {
            var _loc_5:Array = null;
            var _loc_6:Array = null;
            var _loc_7:Object = null;
            var _loc_2:Array = [];
            var _loc_3:* = this._coexistViews.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = this._coexistViews[_loc_4];
                if (this.hasViewIncluded(param1, _loc_5) == false)
                {
                }
                else
                {
                    _loc_6 = [];
                    for (_loc_7 in this._views)
                    {
                        
                        if (this.hasViewIncluded(_loc_7 as IView, _loc_5) == true)
                        {
                            _loc_6.push(_loc_7);
                        }
                    }
                    if (_loc_6.length > 0)
                    {
                        if (_loc_6.length == 1 && _loc_6[0] is PanelLoadingView)
                        {
                        }
                        else
                        {
                            _loc_2.push(_loc_6);
                        }
                    }
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function hasViewIncluded(param1:IView, param2:Array) : Boolean
        {
            var _loc_3:* = param2 ? (param2.length) : (0);
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (param1 is param2[_loc_4])
                {
                    return true;
                }
                _loc_4++;
            }
            return false;
        }// end function

        public function allowToOpen(param1:IView) : Boolean
        {
            var _loc_2:Object = null;
            for (_loc_2 in this._views)
            {
                
                if (this.hasExclusive(_loc_2 as IView, param1))
                {
                    return false;
                }
            }
            for (_loc_2 in this._supers)
            {
                
                if (this.hasExclusive(_loc_2 as IView, param1))
                {
                    return false;
                }
            }
            if (this.hasViewIncluded(param1, this._freeViews))
            {
                return true;
            }
            if (this._view.townMap.inStage == false && this.hasViewIncluded(_loc_2 as IView, this._inTownViews))
            {
                return false;
            }
            return true;
        }// end function

        private function hasExclusive(param1:IView, param2:IView) : Boolean
        {
            var _loc_5:Object = null;
            var _loc_6:Array = null;
            var _loc_7:Array = null;
            var _loc_3:* = this._exclusiveViews.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = this._exclusiveViews[_loc_4];
                if (param1 is _loc_5["master"])
                {
                    _loc_6 = _loc_5["black"];
                    _loc_7 = _loc_5["white"];
                    if (_loc_6.length == 0 && _loc_7.length == 0)
                    {
                        return true;
                    }
                    if (_loc_7.length > 0)
                    {
                        if (this.hasViewIncluded(param2, _loc_7))
                        {
                            return false;
                        }
                        return true;
                    }
                    if (_loc_6.length > 0)
                    {
                        if (this.hasViewIncluded(param2, _loc_6))
                        {
                            return true;
                        }
                        return false;
                    }
                }
                _loc_4++;
            }
            return false;
        }// end function

        private function hasViewInstance(param1:Class, param2:Array) : Boolean
        {
            var _loc_3:* = param2.length;
            var _loc_4:uint = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (param2[_loc_4] is param1)
                {
                    return true;
                }
                _loc_4 = _loc_4 + 1;
            }
            return false;
        }// end function

        public function hasExclusiveView(param1:Class) : int
        {
            var _loc_4:Object = null;
            var _loc_2:* = this._exclusiveViews.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._exclusiveViews[_loc_3];
                if (_loc_4["master"] == param1)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function addExclusiveView(param1:Class) : void
        {
            if (this.hasExclusiveView(param1) > -1)
            {
                return;
            }
            this._exclusiveViews.push({master:param1, black:[], white:[]});
            return;
        }// end function

        public function removeExclusiveView(param1:Class) : void
        {
            var _loc_2:* = this.hasExclusiveView(param1);
            if (_loc_2 > -1)
            {
                this._exclusiveViews.splice(_loc_2, 1);
            }
            return;
        }// end function

        private function removeFadeOutList(param1:IView) : void
        {
            if (this._fadeOutList[param1])
            {
                removeChild(this._fadeOutList[param1]);
                delete this._fadeOutList[param1];
                if (param1 is TakeBibleRoadView)
                {
                    this._view.toolbar.functionBarParent = null;
                }
            }
            return;
        }// end function

        private function startFadeOut(param1:IView, param2:Boolean = false) : void
        {
            var _loc_4:BitmapData = null;
            var _loc_5:Bitmap = null;
            if (this._timerOut == null)
            {
                this._timerOut = new Timer(10);
                this._timerOut.addEventListener(TimerEvent.TIMER, this.onFadeOut);
            }
            var _loc_3:* = this._views[param1] || (param2 == false ? (this._supers[param1]) : (this._frees[param1]));
            if (_loc_3 && _loc_3.width > 0 && _loc_3.height > 0)
            {
                _loc_4 = new BitmapData(_loc_3.width, _loc_3.height, true, 0);
                _loc_4.draw(_loc_3);
                _loc_5 = new Bitmap(_loc_4);
                _loc_5.x = _loc_3.x;
                _loc_5.y = _loc_3.y;
                addChildAt(_loc_5, getChildIndex(_loc_3));
                this.removeFadeOutList(param1);
                this._fadeOutList[param1] = _loc_5;
            }
            this._hasFade = true;
            this._timerOut.start();
            return;
        }// end function

        private function onFadeOut(event:TimerEvent) : void
        {
            var _loc_3:Object = null;
            var _loc_4:Bitmap = null;
            var _loc_2:int = 0;
            for (_loc_3 in this._fadeOutList)
            {
                
                _loc_4 = this._fadeOutList[_loc_3];
                if (_loc_4.alpha > 0)
                {
                    _loc_4.alpha = _loc_4.alpha - 0.08;
                    _loc_2++;
                    continue;
                }
                delete this._fadeOutList[_loc_3];
                removeChild(_loc_4);
            }
            if (_loc_2 == 0)
            {
                this._hasFade = false;
                this._timerOut.stop();
            }
            return;
        }// end function

        public function addMask(param1:Boolean = false, param2:Number = 0) : void
        {
            if (this._shape == null)
            {
                this._shape = new Sprite();
            }
            this._alphp = param2;
            if (param1)
            {
                addChild(this._shape);
            }
            else
            {
                addChildAt(this._shape, 0);
            }
            this.reposition();
            return;
        }// end function

        public function removeMask() : void
        {
            if (this._shape && this._shape.parent)
            {
                removeChild(this._shape);
            }
            return;
        }// end function

        public function reposition() : void
        {
            var _loc_2:IView = null;
            var _loc_3:Sprite = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:Boolean = false;
            var _loc_10:Number = NaN;
            var _loc_11:Boolean = false;
            var _loc_12:Boolean = false;
            var _loc_13:Boolean = false;
            if (this._shape != null && this._shape.parent != null)
            {
                this._shape.graphics.clear();
                this._shape.graphics.beginFill(0, this._alphp);
                this._shape.graphics.drawRect(-50, -50, 1350, 750);
                this._shape.graphics.endFill();
            }
            var _loc_1:int = 10;
            var _loc_4:Number = 0;
            var _loc_5:* = this._viewsList.length;
            var _loc_6:* = this._viewsList.length - 1;
            while (_loc_6 > -1)
            {
                
                _loc_2 = this._viewsList[_loc_6];
                if (_loc_2 is WorldView)
                {
                    return;
                }
                if (_loc_2 is NewWorldView)
                {
                    return;
                }
                _loc_3 = this._views[_loc_2];
                if (_loc_3)
                {
                    _loc_4 = _loc_4 + (_loc_3.width + (_loc_6 > 0 ? (_loc_1) : (0)));
                }
                _loc_6 = _loc_6 - 1;
            }
            if (_loc_5 == 1)
            {
                _loc_3 = this._views[this._viewsList[0]];
                _loc_7 = Math.floor((Structure.stageWidth - _loc_3.width) / 2);
                _loc_8 = Math.floor((Structure.stageHeight - _loc_3.height) / 2);
                this.moveTo(this._viewsList[0], _loc_3, _loc_7, _loc_8);
            }
            else if (_loc_5 > 1)
            {
                _loc_9 = _loc_4 > Structure.stageWidth;
                _loc_10 = (Structure.stageWidth - _loc_4) / 2;
                _loc_11 = this._currentAddedView is PackView && this.hasViewInstance(RoleMsgView, this._viewsList) && this.hasViewInstance(PackView, this._viewsList);
                _loc_12 = this._currentAddedView is RoleMsgView && this.hasViewInstance(RoleMsgView, this._viewsList) && this.hasViewInstance(PackView, this._viewsList);
                _loc_13 = _loc_11 || !_loc_11 && !_loc_12;
                _loc_6 = _loc_13 ? (0) : ((_loc_5 - 1));
                while (_loc_13 ? (_loc_6 < _loc_5) : (_loc_6 > -1))
                {
                    
                    _loc_3 = this._views[this._viewsList[_loc_6]];
                    if (_loc_3)
                    {
                        _loc_7 = Math.floor(_loc_9 ? ((Structure.stageWidth - _loc_3.width) / 2) : (_loc_10));
                        _loc_8 = Math.floor((Structure.stageHeight - _loc_3.height) / 2);
                        this.moveTo(this._viewsList[_loc_6], _loc_3, _loc_7, _loc_8);
                        _loc_10 = _loc_10 + (_loc_3.width + _loc_1);
                    }
                    if (_loc_13)
                    {
                        _loc_6++;
                        continue;
                    }
                    _loc_6 = _loc_6 - 1;
                }
            }
            return;
        }// end function

        private function moveTo(param1:IView, param2:Sprite, param3:Number, param4:Number) : void
        {
            var _loc_5:* = param3 - param2.x;
            var _loc_6:* = param4 - param2.y;
            var _loc_7:int = 6;
            var _loc_8:* = _loc_5 / _loc_7;
            var _loc_9:* = _loc_6 / _loc_7;
            this._processList[param1] = {panel:param2, x:param2.x, y:param2.y, dx:_loc_8, dy:_loc_9, i:0, n:_loc_7};
            return;
        }// end function

        private function process() : void
        {
            var _loc_4:IView = null;
            var _loc_5:Object = null;
            var _loc_1:* = oObject.getKeys(this._processList);
            var _loc_2:* = _loc_1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _loc_1[_loc_3];
                _loc_5 = this._processList[_loc_4];
                if (_loc_5.panel.parent && _loc_5.i < _loc_5.n)
                {
                    _loc_5.panel.x = _loc_5.panel.x + _loc_5.dx;
                    _loc_5.panel.y = _loc_5.panel.y + _loc_5.dy;
                    var _loc_6:* = _loc_5;
                    var _loc_7:* = _loc_5.i + 1;
                    _loc_6.i = _loc_7;
                }
                else
                {
                    delete this._processList[_loc_4];
                }
                _loc_3++;
            }
            return;
        }// end function

        private function setfocusView(param1:IView) : void
        {
            this._focusView = param1;
            Shortcut.focusView = param1;
            return;
        }// end function

        public function get views() : Dictionary
        {
            return this._views;
        }// end function

        public function get focusView() : IView
        {
            return this._focusView;
        }// end function

    }
}
