package com.assist
{
    import com.*;
    import com.haloer.data.*;
    import com.haloer.net.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;

    public class Helper extends Object
    {
        private var _stage:Stage;
        private var _maxLines:int = 300;
        private var _list:Array;
        private var _tfList:Array;
        private var _tfTips:TextField;
        private var _tfSp:Sprite;
        private var _mainSp:Sprite;
        private static var _stage:Stage;
        public static var test:Boolean = true;
        private static var _tf:TextField;
        private static var _down:Point;
        private static var _up:Point;
        private static var _isDown:Boolean = false;
        private static var _trace:TextField;
        public static const REQUEST:int = 1;
        public static const RESPONSE:int = 2;
        private static var _interaction:Object;
        private static var _shortcut:MovieClip;
        private static var _selectedLabel:String;
        private static var _lastSelectedLabel:String;
        private static var _ip:String;
        private static var _protocols:Array = [];
        private static var _pList:Array = [];
        private static var _pHash:Object = {};
        private static var _rnd:String;
        private static var _send:LocalConnection = new LocalConnection();
        private static var _instance:Helper = new Helper;

        public function Helper()
        {
            var _loc_3:* = undefined;
            var _loc_4:Sprite = null;
            var _loc_5:BitmapData = null;
            var _loc_6:TextField = null;
            this._list = [];
            this._tfList = [];
            this._tfTips = new TextField();
            this._tfSp = new Sprite();
            this._mainSp = new Sprite();
            if (test == false)
            {
                return;
            }
            this._mainSp.graphics.beginFill(0, 0.8);
            this._mainSp.graphics.drawRect(0, 0, 1000, 600);
            this._mainSp.graphics.endFill();
            this._list[8] = "lyx";
            var _loc_1:* = new TextFormat();
            _loc_1.size = 13;
            _loc_1.leading = 2;
            var _loc_2:int = 20;
            for (_loc_3 in this._list)
            {
                
                _loc_4 = new Sprite();
                _loc_5 = new BitmapData(100, 25, true, 4284927231);
                _loc_6 = new TextField();
                _loc_6.width = 100;
                _loc_6.htmlText = "<p align=\'center\'><font size=\'17\'>" + this._list[_loc_3] + "</font></p>";
                _loc_5.draw(_loc_6, new Matrix(1, 0, 0, 1, 0, 1), null, null, null, true);
                _loc_5.applyFilter(_loc_5, _loc_5.rect, new Point(), Filter.filter2);
                _loc_4.addEventListener(MouseEvent.MOUSE_OUT, this.btnMouseOut);
                _loc_4.addEventListener(MouseEvent.MOUSE_OVER, this.btnMouseIn);
                _loc_4.addEventListener(MouseEvent.CLICK, this.btnClick);
                _loc_4.addChild(new Bitmap(_loc_5));
                _loc_4.x = _loc_2;
                _loc_4.y = 20;
                _loc_4.name = String(_loc_3);
                _loc_4.buttonMode = true;
                this._mainSp.addChild(_loc_4);
                _loc_2 = _loc_2 + 120;
                var _loc_9:* = new TextField();
                _loc_6 = new TextField();
                this._tfList[_loc_3] = _loc_9;
                _loc_6.width = 960;
                _loc_6.height = 500;
                _loc_6.x = 20;
                _loc_6.y = 80;
                _loc_6.type = TextFieldType.INPUT;
                _loc_6.multiline = true;
                _loc_6.background = true;
                _loc_6.defaultTextFormat = _loc_1;
            }
            this._mainSp.addChild(this._tfSp);
            this._mainSp.addChild(this._tfTips);
            this._tfTips.width = 500;
            this._tfTips.y = 50;
            this._tfTips.x = 20;
            this._tfTips.mouseEnabled = false;
            return;
        }// end function

        public function initStage(param1:Stage) : void
        {
            if (test == false)
            {
                return;
            }
            this._stage = param1;
            param1.addEventListener(KeyboardEvent.KEY_UP, this.stageKeyUp);
            initInteraction();
            return;
        }// end function

        private function stageKeyUp(event:KeyboardEvent) : void
        {
            if (event.keyCode == 113)
            {
                if (this._mainSp.stage == null)
                {
                    this._stage.addChild(this._mainSp);
                }
                else
                {
                    this._stage.removeChild(this._mainSp);
                }
            }
            return;
        }// end function

        private function btnMouseIn(event:Event) : void
        {
            event.currentTarget.alpha = 0.7;
            return;
        }// end function

        private function btnMouseOut(event:Event) : void
        {
            event.currentTarget.alpha = 1;
            return;
        }// end function

        private function btnClick(event:Event) : void
        {
            while (this._tfSp.numChildren)
            {
                
                this._tfSp.removeChildAt(0);
            }
            var _loc_2:* = int(event.currentTarget.name);
            this._tfSp.addChild(this._tfList[_loc_2]);
            this.txTips = "当前显示  " + this._list[_loc_2];
            return;
        }// end function

        private function set txTips(param1:String) : void
        {
            this._tfTips.htmlText = "<font color=\'#ffffff\' size=\'17\'>" + param1 + "</font>";
            return;
        }// end function

        private function showTrace(param1:int, param2:String) : void
        {
            var _loc_4:String = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            if (test == false)
            {
                return;
            }
            var _loc_3:* = this._tfList[param1] as TextField;
            if (_loc_3 == null)
            {
                return;
            }
            _loc_3.appendText(param2);
            if (_loc_3.numLines > this._maxLines)
            {
                _loc_4 = "";
                _loc_5 = 100;
                _loc_6 = _loc_3.numLines;
                while (_loc_5 < _loc_6)
                {
                    
                    _loc_4 = _loc_4 + _loc_3.getLineText(_loc_5);
                    _loc_5++;
                }
                _loc_3.text = _loc_4;
            }
            _loc_3.scrollV = _loc_3.maxScrollV;
            return;
        }// end function

        public static function output(... args) : void
        {
            printToConsole("output", args);
            return;
        }// end function

        public static function alert(... args) : void
        {
            printToConsole("alert", args);
            return;
        }// end function

        public static function error(... args) : void
        {
            printToConsole("error", args);
            return;
        }// end function

        public static function debug(... args) : void
        {
            printToConsole("debug", args);
            return;
        }// end function

        private static function printToConsole(param1:String, param2:Array) : void
        {
            param1 = param1.toUpperCase();
            var _loc_3:* = repeat("-", param1.length + 2);
            return;
        }// end function

        private static function repeat(param1:String, param2:int) : String
        {
            if (param2 > 1)
            {
                return param1 + repeat(param1, (param2 - 1));
            }
            return param1;
        }// end function

        public static function gc() : void
        {
            try
            {
                new LocalConnection().connect("age");
                new LocalConnection().connect("age");
            }
            catch (error:Error)
            {
            }
            return;
        }// end function

        private static function assist() : void
        {
            _stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            _stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            _stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            _stage.addEventListener(MouseEvent.CLICK, onClick);
            return;
        }// end function

        private static function onMouseDown(event:MouseEvent) : void
        {
            _down = new Point(_stage.mouseX, _stage.mouseY);
            _isDown = true;
            return;
        }// end function

        private static function onMouseUp(event:MouseEvent) : void
        {
            _isDown = false;
            return;
        }// end function

        private static function onMouseMove(event:MouseEvent) : void
        {
            if (_isDown)
            {
                _up = new Point(_stage.mouseX, _stage.mouseY);
                draw();
            }
            return;
        }// end function

        private static function onClick(event:MouseEvent) : void
        {
            if (_tf && _tf.parent)
            {
                _tf.parent.removeChild(_tf);
            }
            return;
        }// end function

        private static function draw() : void
        {
            if (_tf == null)
            {
                _tf = new TextField();
                _tf.border = true;
                _tf.borderColor = 16777215;
                _tf.textColor = 16777215;
                _tf.selectable = false;
            }
            _stage.addChild(_tf);
            var _loc_1:* = _up.x - _down.x - 2;
            var _loc_2:* = _up.y - _down.y - 2;
            _tf.x = _down.x;
            _tf.y = _down.y;
            _tf.width = _loc_1;
            _tf.height = _loc_2;
            _tf.text = [_loc_1, _loc_2].join();
            return;
        }// end function

        public static function backtrace(... args) : void
        {
            return;
        }// end function

        private static function initInteraction() : void
        {
            _shortcut = new MovieClip();
            _shortcut.buttonMode = true;
            _shortcut.useHandCursor = true;
            _shortcut.tabEnabled = false;
            _shortcut.graphics.beginFill(3355443, 0);
            _shortcut.graphics.drawRect(0, 0, 20, 20);
            var callback:* = function (event:MouseEvent) : void
            {
                switchInteraction();
                return;
            }// end function
            ;
            var over:* = function (event:MouseEvent) : void
            {
                _shortcut.graphics.clear();
                _shortcut.graphics.beginFill(16711680, 0.2);
                _shortcut.graphics.drawRect(0, 0, 20, 20);
                return;
            }// end function
            ;
            var out:* = function (event:MouseEvent) : void
            {
                _shortcut.graphics.clear();
                _shortcut.graphics.beginFill(3355443, 0);
                _shortcut.graphics.drawRect(0, 0, 20, 20);
                return;
            }// end function
            ;
            var everyFrame:* = function (event:Event) : void
            {
                _stage.addChild(_shortcut);
                return;
            }// end function
            ;
            _shortcut.addEventListener(MouseEvent.CLICK, callback);
            _shortcut.addEventListener(MouseEvent.MOUSE_OVER, over);
            _shortcut.addEventListener(MouseEvent.MOUSE_OUT, out);
            _shortcut.addEventListener(Event.ENTER_FRAME, everyFrame);
            return;
        }// end function

        public static function switchInteraction() : void
        {
            var file:File;
            if (test == false)
            {
                return;
            }
            _ip = ", <u>Domain</u>:<font color=\"#FF0000\">" + URI.ip + ":" + URI.port + "</font>";
            if (_interaction == null)
            {
                file = new File();
                file.onComplete = function () : void
            {
                _interaction = file.getClassObject("Interaction");
                _interaction._Name.htmlText = _ip;
                _interaction.pList = _pList;
                _interaction.pHash = _pHash;
                _interaction.onItemClick = function (param1:Object) : void
                {
                    _selectedLabel = param1.label;
                    _interaction.renderSelectedLabel(_selectedLabel, _pHash, _pList, _ip);
                    return;
                }// end function
                ;
                updateInteraction();
                if (_selectedLabel == null)
                {
                    _interaction._List.dataProvider.addItems(_protocols);
                    _interaction.renderSelectedLabel(_lastSelectedLabel, _pHash, _pList, _ip);
                }
                return;
            }// end function
            ;
                file.load(URI.assetsUrl + "interaction.swf?rnd=" + Math.random());
            }
            else
            {
                updateInteraction();
            }
            return;
        }// end function

        public static function recordInteraction(param1:int, param2:int, param3:int, param4:Array) : void
        {
            var _loc_5:* = new Date();
            var _loc_6:* = Protocol.lookupProtocol(param2, param3);
            var _loc_7:* = ["[" + _loc_5.getHours() + ":" + _loc_5.getMinutes() + ":" + _loc_5.getSeconds() + "." + _loc_5.getMilliseconds() + "]", "[" + (param1 == REQUEST ? ("Request") : ("Response")) + "] " + Protocol.getProtocolDescription(_loc_6["request"]), "[__Tree__]", "----------------------------------", "[__Content__]", "================================================================="].join("\n");
            var _loc_8:* = (param2 > 9 ? (param2) : ("0" + param2)) + " . " + Protocol.funName;
            var _loc_9:* = _pHash[_loc_8] || _pList.length;
            if (_pHash[_loc_8] == null)
            {
                _pHash[_loc_8] = _loc_9;
                _protocols.push({label:_loc_8, data:1});
            }
            if (undefined == _pList[_loc_9])
            {
                _pList[_loc_9] = [];
                getModuleList();
            }
            else if (_pList[_loc_9].length > 6)
            {
                _pList[_loc_9].shift();
                getModuleList();
            }
            _lastSelectedLabel = _loc_8;
            _pList[_loc_9].push([_loc_7, param4]);
            if (_interaction != null)
            {
                _interaction._List.dataProvider.removeAll();
                _interaction._List.dataProvider.addItems(_protocols);
                if (_selectedLabel)
                {
                    _interaction.renderSelectedLabel(_selectedLabel, _pHash, _pList, _ip);
                }
                else
                {
                    _interaction._Name.htmlText = _loc_8 + _ip;
                    _interaction._Info.text = _loc_7.replace("[__Content__]", Dumper(param4));
                }
            }
            return;
        }// end function

        private static function updateInteraction() : void
        {
            if (_interaction.parent == null)
            {
                _stage.addChild(_interaction as Sprite);
            }
            else
            {
                _stage.removeChild(_interaction as Sprite);
            }
            return;
        }// end function

        public static function startConnect(param1:String) : void
        {
            _rnd = param1;
            if (!_send.hasEventListener(StatusEvent.STATUS))
            {
                _send.addEventListener(StatusEvent.STATUS, statusHandler);
            }
            getModuleList();
            return;
        }// end function

        private static function statusHandler(event:StatusEvent) : void
        {
            return;
        }// end function

        public static function getModuleList() : void
        {
            if (!_rnd)
            {
                return;
            }
            try
            {
                _send.send(_rnd, "setModuleList", _pHash, _pList);
            }
            catch (e)
            {
            }
            return;
        }// end function

        public static function initStage(param1:Stage) : void
        {
            _stage = param1;
            _instance.initStage(param1);
            return;
        }// end function

        public static function Trace1(... args) : void
        {
            _instance.showTrace(1, args.join("  ") + "\n");
            return;
        }// end function

        public static function Trace2(... args) : void
        {
            _instance.showTrace(2, args.join("  ") + "\n");
            return;
        }// end function

        public static function Trace3(... args) : void
        {
            _instance.showTrace(3, args.join("  ") + "\n");
            return;
        }// end function

        public static function Trace4(... args) : void
        {
            _instance.showTrace(4, args.join("  ") + "\n");
            return;
        }// end function

        public static function Trace5(... args) : void
        {
            _instance.showTrace(5, args.join("  ") + "\n");
            return;
        }// end function

        public static function Trace6(... args) : void
        {
            _instance.showTrace(6, args.join("  ") + "\n");
            return;
        }// end function

        public static function Trace7(... args) : void
        {
            _instance.showTrace(7, args.join("  ") + "\n");
            return;
        }// end function

        public static function Trace8(... args) : void
        {
            _instance.showTrace(8, args.join("  ") + "\n");
            return;
        }// end function

    }
}
