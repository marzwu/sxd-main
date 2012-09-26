package com.assist.view.controls
{
    import com.assist.view.interfaces.*;
    import com.views.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Drag extends Object implements IDrag
    {
        private var _targets:Dictionary;
        private var _target:DisplayObject;
        private var _onMouseDown:Function;
        private static var _obj:Drag;

        public function Drag()
        {
            this._targets = new Dictionary();
            return;
        }// end function

        public function addTarget(param1:DisplayObject, param2:DisplayObject) : void
        {
            if (this._targets[param1])
            {
                this.removeTarget(param1);
            }
            this._targets[param1] = {container:param2};
            this.addEvent(param1, param2);
            return;
        }// end function

        public function removeTarget(param1:DisplayObject) : void
        {
            if (param1 && this._targets[param1])
            {
                this.removeEvent(param1);
                delete this._targets[param1];
            }
            return;
        }// end function

        public function get targets() : Dictionary
        {
            return this._targets;
        }// end function

        public function set onMouseDown(param1:Function) : void
        {
            this._onMouseDown = param1;
            return;
        }// end function

        public function toString() : String
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

        private function addEvent(param1:DisplayObject, param2:DisplayObject) : void
        {
            var isMouseDown:Boolean;
            var curX:Number;
            var curY:Number;
            var mouseX:Number;
            var mouseY:Number;
            var pLT:Point;
            var pRB:Point;
            var pTemp:Point;
            var mouseMove:Function;
            var mouseUp:Function;
            var titleBar:* = param1;
            var window:* = param2;
            isMouseDown;
            pLT = new Point(0, 0);
            pRB = new Point(0, 0);
            var updatePLT:* = function (param1:Stage) : void
            {
                var _loc_2:Number = 0;
                var _loc_3:Number = 0;
                if (param1.stageWidth > Structure.maxStageWidth)
                {
                    _loc_2 = (param1.stageWidth - Structure.maxStageWidth) / 2;
                }
                if (param1.stageHeight > Structure.maxStageHeight)
                {
                    _loc_3 = (param1.stageHeight - Structure.maxStageHeight) / 2;
                }
                pLT.x = _loc_2;
                pLT.y = _loc_3;
                return;
            }// end function
            ;
            var mouseDown:* = function () : void
            {
                isMouseDown = true;
                var _loc_1:* = titleBar.stage;
                var _loc_2:* = window.parent;
                window.parent.addChild(window);
                curX = window.x;
                curY = window.y;
                mouseX = _loc_2.mouseX;
                mouseY = _loc_2.mouseY;
                updatePLT(_loc_1);
                var _loc_3:* = pLT.x;
                var _loc_4:* = pLT.y;
                pTemp = _loc_2.globalToLocal(pLT);
                pLT.x = pTemp.x;
                pLT.y = pTemp.y;
                pTemp = new Point(_loc_3 + Structure.stageWidth - window.width, _loc_4 + Structure.stageHeight - window.height);
                pTemp = _loc_2.globalToLocal(pTemp);
                pRB.x = pTemp.x;
                pRB.y = pTemp.y;
                _loc_1.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
                _loc_1.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
                if (_onMouseDown is Function)
                {
                    _onMouseDown(window);
                }
                return;
            }// end function
            ;
            mouseMove = function () : void
            {
                if (isMouseDown == false)
                {
                    return;
                }
                var _loc_1:* = titleBar.stage;
                if (_loc_1 == null)
                {
                    return;
                }
                var _loc_2:* = window.parent;
                var _loc_3:* = Math.floor(curX + _loc_2.mouseX - mouseX);
                var _loc_4:* = Math.floor(curY + _loc_2.mouseY - mouseY);
                if (_loc_3 < pLT.x)
                {
                    _loc_3 = pLT.x;
                }
                else if (_loc_3 > pRB.x)
                {
                    _loc_3 = pRB.x;
                }
                if (_loc_4 < pLT.y)
                {
                    _loc_4 = pLT.y;
                }
                else if (_loc_4 > pRB.y)
                {
                    _loc_4 = pRB.y;
                }
                window.x = _loc_3;
                window.y = _loc_4;
                return;
            }// end function
            ;
            mouseUp = function () : void
            {
                isMouseDown = false;
                var _loc_1:* = titleBar.stage;
                if (_loc_1 == null)
                {
                    return;
                }
                _loc_1.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
                _loc_1.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
                return;
            }// end function
            ;
            this._targets[titleBar].mouseDown = mouseDown;
            titleBar.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
            return;
        }// end function

        private function removeEvent(param1:DisplayObject) : void
        {
            param1.removeEventListener(MouseEvent.MOUSE_DOWN, this._targets[param1].mouseDown);
            return;
        }// end function

        public static function getInstance() : IDrag
        {
            if (!_obj)
            {
                _obj = new Drag;
            }
            return _obj;
        }// end function

    }
}
