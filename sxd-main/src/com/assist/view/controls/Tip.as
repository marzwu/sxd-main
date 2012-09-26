package com.assist.view.controls
{
    import com.assist.*;
    import com.assist.view.interfaces.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class Tip extends Sprite implements ITip
    {
        private var _parent:Sprite;
        private var _targets:Dictionary;
        private var _target:DisplayObject;
        private var _content:DisplayObject;
        private var _contentOffset:Point;
        private var _contentSpan:Point;
        private var _mouseOffset:Point;
        private var _dir:int = 0;
        private var _openedTarget:Object;
        private var _tempX:Number = 0;
        private var _tempY:Number = 0;
        private var _enterFrame:Function;
        private var _txtTween:TextField;
        private var _speed:Number = 0.15;
        private var _angle:Number = 0;
        private static var _offset:Point = new Point(0, 0);
        private static var _obj:Tip;
        public static const LEFT:int = -1;
        public static const RIGHT:int = 1;

        public function Tip()
        {
            this._targets = new Dictionary();
            this._contentOffset = new Point(6, 6);
            this._contentSpan = new Point(10, 0);
            this._mouseOffset = new Point(15, 15);
            this._openedTarget = {};
            mouseEnabled = false;
            this.initTextTip();
            return;
        }// end function

        public function get stageOffset() : Point
        {
            return _offset;
        }// end function

        public function addTarget(param1:DisplayObject, param2 = null) : void
        {
            this.clearTarget(param1);
            this.addOne(param1, param2);
            this.addEvent(param1);
            return;
        }// end function

        public function addTargetMoreTips(param1:DisplayObject, ... args) : void
        {
            this.clearTarget(param1);
            args = args.length;
            var _loc_4:int = 0;
            while (_loc_4 < args)
            {
                
                this.addOne(param1, args[_loc_4]);
                _loc_4++;
            }
            this.addEvent(param1);
            return;
        }// end function

        public function addFixedTarget(param1:DisplayObject, param2, param3:Point, param4:Boolean = true) : void
        {
            this.clearTarget(param1);
            this.addOne(param1, param2, param3, param4);
            this.addEvent(param1);
            return;
        }// end function

        private function addOne(param1:DisplayObject, param2, param3:Point = null, param4:Boolean = true) : void
        {
            var d:DisplayObject;
            var tf:TextFormat;
            var target:* = param1;
            var content:* = param2;
            var pos:* = param3;
            var topBase:* = param4;
            if (content is String)
            {
                d = new TextField();
                var _loc_6:* = d as TextField;
                with (d as TextField)
                {
                    selectable = false;
                    autoSize = TextFieldAutoSize.LEFT;
                    multiline = true;
                    htmlText = HtmlText.white(content);
                }
                if (d.height > 20)
                {
                    tf = new TextFormat();
                    tf.leading = 3;
                    (d as TextField).setTextFormat(tf);
                }
            }
            else if (content is DisplayObject)
            {
                d = content;
            }
            if (this._targets[target] == null)
            {
                this._targets[target] = {contents:[], pos:pos, topBase:topBase};
            }
            this._targets[target]["contents"].push(d);
            return;
        }// end function

        public function removeTarget(param1:DisplayObject) : void
        {
            if (param1 && this._targets[param1])
            {
                if (this._target == param1)
                {
                    this.hide();
                }
                this.removeEvent(param1);
                delete this._targets[param1];
            }
            return;
        }// end function

        private function addEvent(param1:DisplayObject) : void
        {
            var mouseMove:Function;
            var target:* = param1;
            mouseMove = function (event:MouseEvent) : void
            {
                var _loc_5:int = 0;
                var _loc_6:int = 0;
                var _loc_7:int = 0;
                if (stage == null)
                {
                    return;
                }
                _target = target;
                if (!_targets[target] || !_targets[target]["contents"])
                {
                    return;
                }
                var _loc_2:* = _targets[target]["contents"][0];
                if (_content && _content != _loc_2)
                {
                    while (numChildren)
                    {
                        
                        removeChildAt(0);
                    }
                    _content = null;
                }
                if (_content != _loc_2)
                {
                    _content = _loc_2;
                    _loc_6 = _targets[target]["contents"].length;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6)
                    {
                        
                        _loc_2 = _targets[target]["contents"][_loc_7];
                        addChild(_loc_2);
                        _loc_7++;
                    }
                    draw();
                }
                var _loc_3:* = _parent.mouseX + _mouseOffset.x;
                var _loc_4:* = _parent.mouseY + _mouseOffset.y;
                if (_loc_3 + width > stage.stageWidth - _offset.x * 2)
                {
                    _loc_3 = _parent.mouseX - width - _mouseOffset.x + 5;
                    _loc_5 = Tip.LEFT;
                }
                else
                {
                    _loc_5 = Tip.RIGHT;
                }
                if (_loc_4 + height > stage.stageHeight - _offset.y * 2)
                {
                    _loc_4 = _parent.mouseY - height - _mouseOffset.y + 5;
                }
                if (_loc_4 < _mouseOffset.y)
                {
                    _loc_4 = _mouseOffset.y;
                }
                if (_targets[target].pos != null)
                {
                    x = _targets[target].pos.x;
                    y = _targets[target].pos.y - height;
                }
                else
                {
                    x = Math.floor(_loc_3);
                    y = Math.floor(_loc_4);
                }
                if (_loc_5 != _dir)
                {
                    _dir = _loc_5;
                    draw();
                }
                event.updateAfterEvent();
                return;
            }// end function
            ;
            var mouseOver:* = function (event:MouseEvent) : void
            {
                removeEnterFrame();
                show();
                target.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false, 0, true);
                return;
            }// end function
            ;
            var mouseOut:* = function (event:MouseEvent) : void
            {
                hide();
                target.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
                return;
            }// end function
            ;
            this._targets[target].mouseOver = mouseOver;
            this._targets[target].mouseOut = mouseOut;
            this._targets[target].mouseMove = mouseMove;
            target.addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0, true);
            target.addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0, true);
            return;
        }// end function

        private function removeEvent(param1:DisplayObject) : void
        {
            param1.removeEventListener(MouseEvent.MOUSE_OVER, this._targets[param1].mouseOver);
            param1.removeEventListener(MouseEvent.MOUSE_OUT, this._targets[param1].mouseOut);
            param1.removeEventListener(MouseEvent.MOUSE_MOVE, this._targets[param1].mouseMove);
            return;
        }// end function

        private function clearTarget(param1:DisplayObject) : void
        {
            if (param1 == null)
            {
                throw new Error("target不能为null！");
            }
            if (this._targets[param1])
            {
                this.removeTarget(param1);
            }
            return;
        }// end function

        public function updateTarget(param1:DisplayObject = null) : void
        {
            this.draw();
            this.updateTarget1();
            return;
        }// end function

        private function show() : void
        {
            if (this._parent)
            {
                this._parent.addChild(this);
            }
            if (x == 0 && y == 0)
            {
                x = 10000;
                y = 10000;
            }
            return;
        }// end function

        public function hide() : void
        {
            this._target = null;
            this._content = null;
            graphics.clear();
            this.removeEnterFrame();
            if (this._parent && parent)
            {
                parent.removeChild(this);
            }
            while (numChildren)
            {
                
                removeChildAt(0);
            }
            return;
        }// end function

        private function draw() : void
        {
            var addonX:int;
            var addonY:int;
            var i:int;
            if (this._target == null)
            {
                return;
            }
            graphics.clear();
            addonX;
            addonY;
            var handler:* = function (param1:int) : void
            {
                var _loc_2:* = _targets[_target]["contents"][param1];
                visible = _loc_2.visible;
                var _loc_3:* = _loc_2 ? (_loc_2.width + _contentOffset.x * 2) : (100);
                var _loc_4:* = _loc_2 ? (_loc_2.height + _contentOffset.y * 2) : (50);
                var _loc_5:int = 8;
                graphics.lineStyle(1, 0, 0.3);
                graphics.beginFill(0, 0.75);
                graphics.drawRoundRect(2 + addonX, 2 + addonY, _loc_3, _loc_4, _loc_5, _loc_5);
                graphics.endFill();
                graphics.lineStyle(1, 8082482);
                graphics.beginFill(1118481);
                graphics.drawRoundRect(0 + addonX, 0 + addonY, _loc_3, _loc_4, _loc_5, _loc_5);
                graphics.endFill();
                _loc_2.x = _contentOffset.x + addonX;
                _loc_2.y = _contentOffset.y + addonY;
                addonX = addonX + (_loc_3 + 5);
                addonY = addonY + _contentSpan.y;
                return;
            }// end function
            ;
            var start:int;
            var end:* = this._targets[this._target]["contents"].length;
            if (Tip.LEFT == this._dir)
            {
                i = (end - 1);
                while (i >= start)
                {
                    
                    this.handler(i);
                    i = (i - 1);
                }
            }
            else
            {
                i = start;
                while (i < end)
                {
                    
                    this.handler(i);
                    i = (i + 1);
                }
            }
            return;
        }// end function

        public function clickToOpen(param1, param2:Event = null) : Sprite
        {
            var d:DisplayObject;
            var content:* = param1;
            var e:* = param2;
            var container:* = new Sprite();
            this._parent.addChild(container);
            if (content is DisplayObject)
            {
                d = content;
            }
            else
            {
                d = new TextField();
                var _loc_4:* = d as TextField;
                with (d as TextField)
                {
                    selectable = false;
                    autoSize = TextFieldAutoSize.LEFT;
                    multiline = true;
                    htmlText = "<font color=\"#ffffff\">" + content + "</font>";
                }
            }
            this._openedTarget["container"] = container;
            this._openedTarget["content"] = d;
            d.x = this._contentOffset.x;
            d.y = this._contentOffset.y;
            container.addChild(d);
            var handler:* = this.clickToClose(container);
            this._parent.stage.addEventListener(MouseEvent.CLICK, handler);
            this._parent.stage.addEventListener(MouseEvent.CLICK, handler, true);
            this._openedTarget["mouseX"] = this._parent.mouseX;
            this._openedTarget["mouseY"] = this._parent.mouseY;
            this.updateTarget1();
            return container;
        }// end function

        private function clickToClose(param1:DisplayObject) : Function
        {
            var handler:Function;
            var container:* = param1;
            handler = function (event:MouseEvent) : void
            {
                var _loc_2:* = event.target as DisplayObject;
                while (_loc_2)
                {
                    
                    if (_loc_2 == container)
                    {
                        break;
                        continue;
                    }
                    _loc_2 = _loc_2.parent;
                }
                _parent.stage.removeEventListener(MouseEvent.CLICK, handler);
                _parent.stage.removeEventListener(MouseEvent.CLICK, handler, true);
                if (container && container.parent)
                {
                    container.parent.removeChild(container);
                }
                return;
            }// end function
            ;
            return handler;
        }// end function

        public function hideOpened() : void
        {
            var _loc_1:* = this._openedTarget["container"];
            if (_loc_1 && _loc_1.parent)
            {
                _loc_1.parent.removeChild(_loc_1);
            }
            return;
        }// end function

        private function updateTarget1() : void
        {
            var _loc_1:* = this._openedTarget["container"];
            var _loc_2:* = this._openedTarget["content"];
            if (_loc_1 == null || _loc_1.parent == null)
            {
                return;
            }
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:* = _loc_2 ? (_loc_2.width + this._contentOffset.x * 2) : (100);
            var _loc_6:* = _loc_2 ? (_loc_2.height + this._contentOffset.y * 2) : (50);
            var _loc_7:int = 8;
            _loc_1.graphics.clear();
            _loc_1.graphics.lineStyle(1, 0, 0.3);
            _loc_1.graphics.beginFill(0, 0.75);
            _loc_1.graphics.drawRoundRect(2 + _loc_3, 2 + _loc_4, _loc_5, _loc_6, _loc_7, _loc_7);
            _loc_1.graphics.endFill();
            _loc_1.graphics.lineStyle(1, 8082482);
            _loc_1.graphics.beginFill(1118481);
            _loc_1.graphics.drawRoundRect(0 + _loc_3, 0 + _loc_4, _loc_5, _loc_6, _loc_7, _loc_7);
            _loc_1.graphics.endFill();
            this.updatePosition(_loc_1);
            return;
        }// end function

        private function updatePosition(param1:Sprite) : void
        {
            var _loc_2:* = this._openedTarget["mouseX"];
            var _loc_3:* = this._openedTarget["mouseY"];
            var _loc_4:* = _loc_2 + this._mouseOffset.x;
            var _loc_5:* = _loc_3 + this._mouseOffset.y;
            if (_loc_4 + param1.width > this._parent.stage.stageWidth - _offset.x * 2)
            {
                _loc_4 = _loc_2 - param1.width - this._mouseOffset.x;
            }
            if (_loc_5 + param1.height > this._parent.stage.stageHeight - _offset.y * 2)
            {
                _loc_5 = _loc_3 - param1.height - this._mouseOffset.y;
            }
            if (_loc_5 < this._mouseOffset.y)
            {
                _loc_5 = this._mouseOffset.y;
            }
            param1.x = Math.floor(_loc_4);
            param1.y = Math.floor(_loc_5);
            return;
        }// end function

        private function moveTo(param1:Array, param2:Array) : void
        {
            var offsetX:Number;
            var offsetY:Number;
            var start:* = param1;
            var end:* = param2;
            this.removeEnterFrame();
            var tempEnd:* = end;
            if (this._parent.mouseX > x && this._parent.mouseX <= end[0])
            {
                tempEnd[0] = this._parent.mouseX - 10;
            }
            else if (this._parent.mouseX <= x && this._parent.mouseX > end[0])
            {
                tempEnd[0] = this._parent.mouseX + 10;
            }
            if (this._parent.mouseY > y && this._parent.mouseY <= end[1])
            {
                tempEnd[1] = this._parent.mouseY - 10;
            }
            else if (this._parent.mouseY <= y && this._parent.mouseY > end[1])
            {
                tempEnd[1] = this._parent.mouseY + 10;
            }
            offsetX = tempEnd[0] - start[0];
            offsetY = tempEnd[1] - start[1];
            this._enterFrame = function () : void
            {
                if (Math.abs(offsetX) < 1 && Math.abs(offsetY) < 1)
                {
                    removeEnterFrame();
                    x = end[0];
                    y = end[1];
                    return;
                }
                offsetX = offsetX / 2;
                offsetY = offsetY / 2;
                x = x + offsetX;
                y = y + offsetY;
                return;
            }// end function
            ;
            addEventListener(Event.ENTER_FRAME, this._enterFrame);
            return;
        }// end function

        private function removeEnterFrame() : void
        {
            if (this._enterFrame is Function)
            {
                removeEventListener(Event.ENTER_FRAME, this._enterFrame);
            }
            return;
        }// end function

        public function textTip(param1:DisplayObject, param2:String, param3:uint = 16776960, param4:int = 18) : void
        {
            this._angle = 0;
            var _loc_5:* = htmlFormat(param2, param4, param3, true);
            this._txtTween.filters = [Filter.filter2];
            this._txtTween.htmlText = _loc_5;
            this._txtTween.alpha = this._angle;
            this._txtTween.x = param1.x + (param1.width - this._txtTween.width) / 2;
            this._txtTween.y = param1.y - 27;
            param1.parent.addChild(this._txtTween);
            addEventListener(Event.ENTER_FRAME, this.enterFrame);
            return;
        }// end function

        private function initTextTip() : void
        {
            this._txtTween = new TextField();
            this._txtTween.mouseEnabled = false;
            this._txtTween.autoSize = TextFieldAutoSize.LEFT;
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:* = Math.sin(this._angle);
            this._txtTween.alpha = _loc_2;
            this._angle = this._angle + this._speed;
            if (this._angle >= 1.5)
            {
                this._txtTween.y = this._txtTween.y - 0.5;
            }
            if (this._angle >= 3.2)
            {
                this._angle = 0;
                removeEventListener(Event.ENTER_FRAME, this.enterFrame);
                this._txtTween.parent.removeChild(this._txtTween);
            }
            return;
        }// end function

        public function set oParent(param1:Sprite) : void
        {
            this._parent = param1;
            return;
        }// end function

        public function get oParent() : Sprite
        {
            return this._parent;
        }// end function

        public function get targets() : Dictionary
        {
            return this._targets;
        }// end function

        override public function toString() : String
        {
            var _loc_3:Object = null;
            var _loc_1:int = 1;
            var _loc_2:String = "============\n";
            for (_loc_3 in this._targets)
            {
                
                _loc_2 = _loc_2 + ("[" + _loc_1 + "], " + _loc_3 + " : \n" + "\tname   : " + _loc_3.name + "\n" + "\tparent : " + _loc_3.parent + "\n" + "\n");
                _loc_1++;
            }
            _loc_2 = _loc_2 + "============\n";
            return _loc_2;
        }// end function

        public static function set offset(param1:Point) : void
        {
            _offset = param1;
            _obj.hideOpened();
            return;
        }// end function

        public static function getInstance() : ITip
        {
            if (!_obj)
            {
                _obj = new Tip;
            }
            return _obj;
        }// end function

    }
}
