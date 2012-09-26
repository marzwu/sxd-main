package com.views
{
    import com.*;
    import com.assist.view.*;
    import com.views.structure.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Structure extends Object
    {
        private var _stage:Stage;
        private var _view:View;
        private var _mouse:Sprite;
        private var _tip:Tip;
        private var _alert:Alert;
        private var _load:Load;
        private var _content:Content;
        private var _background:Sprite;
        private var _popup:Popup;
        private static var _instance:Structure;
        public static const minStageWidth:int = 1000;
        public static const minStageHeight:int = 600;
        public static const maxStageWidth:int = 1250;
        public static const maxStageHeight:int = 650;

        public function Structure(param1:Singleton)
        {
            return;
        }// end function

        private function get stage() : Stage
        {
            return this._stage;
        }// end function

        public function get mouse() : Sprite
        {
            return this._mouse;
        }// end function

        public function get tip() : Tip
        {
            return this._tip;
        }// end function

        public function get alert() : Alert
        {
            return this._alert;
        }// end function

        public function get load() : Load
        {
            return this._load;
        }// end function

        public function get popup() : Popup
        {
            return this._popup;
        }// end function

        public function get content() : Content
        {
            return this._content;
        }// end function

        public function get background() : Sprite
        {
            return this._background;
        }// end function

        private function init(param1:Stage, param2:View) : void
        {
            this._stage = param1;
            this._view = param2;
            this._mouse = new Sprite();
            this._tip = new Tip();
            this._load = new Load();
            this._alert = new Alert();
            this._popup = new Popup(this._view);
            this._content = new Content();
            this._background = new Background();
            this._stage.addChild(this._background);
            this._stage.addChild(this._content);
            this._stage.addChild(this._popup);
            this._stage.addChild(this._alert);
            this._stage.addChild(this._load);
            this._stage.addChild(this._tip);
            this._stage.addChild(this._mouse);
            this._popup.structure = this;
            this._mouse.mouseEnabled = false;
            this._mouse.mouseChildren = false;
            this._tip.mouseEnabled = false;
            this._popup.mouseEnabled = false;
            var _loc_3:Boolean = false;
            this._popup.tabChildren = false;
            this._content.tabChildren = _loc_3;
            var _loc_3:Boolean = false;
            this._popup.tabEnabled = false;
            this._content.tabEnabled = _loc_3;
            Shortcut.getRelatedView = this._popup.getRelatedView;
            return;
        }// end function

        public function drawMark() : void
        {
            this.drawBlack(-600, -200, 2500, 200);
            this.drawBlack(1250, 0, 1000, 1000);
            this.drawBlack(-600, 650, 2500, 200);
            this.drawBlack(-1000, 0, 1000, 1000);
            return;
        }// end function

        private function drawBlack(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this._mouse.graphics.beginFill(0, 1);
            this._mouse.graphics.drawRect(param1, param2, param3, param4);
            this._mouse.graphics.endFill();
            return;
        }// end function

        public function reposition() : void
        {
            var _loc_1:* = stageOffset.x;
            this._background.x = stageOffset.x;
            var _loc_1:* = _loc_1;
            this._content.x = _loc_1;
            var _loc_1:* = _loc_1;
            this._popup.x = _loc_1;
            var _loc_1:* = _loc_1;
            this._alert.x = _loc_1;
            var _loc_1:* = _loc_1;
            this._load.x = _loc_1;
            var _loc_1:* = _loc_1;
            this._tip.x = _loc_1;
            this._mouse.x = _loc_1;
            var _loc_1:* = stageOffset.y;
            this._background.y = stageOffset.y;
            var _loc_1:* = _loc_1;
            this._content.y = _loc_1;
            var _loc_1:* = _loc_1;
            this._popup.y = _loc_1;
            var _loc_1:* = _loc_1;
            this._alert.y = _loc_1;
            var _loc_1:* = _loc_1;
            this._load.y = _loc_1;
            var _loc_1:* = _loc_1;
            this._tip.y = _loc_1;
            this._mouse.y = _loc_1;
            setTimeout(this._popup.reposition, 10);
            return;
        }// end function

        public static function getInstance(param1:Stage, param2:ViewBase) : Structure
        {
            if (Structure._instance == null)
            {
                Structure._instance = new Structure(new Singleton());
                Structure._instance.init(param1, param2 as View);
            }
            return Structure._instance;
        }// end function

        public static function get stageWidth() : Number
        {
            return Math.max(minStageWidth, Math.min(maxStageWidth, _instance.stage.stageWidth)) - stageClip.x;
        }// end function

        public static function get stageHeight() : Number
        {
            return Math.max(minStageHeight, Math.min(maxStageHeight, _instance.stage.stageHeight)) - stageClip.y;
        }// end function

        public static function get stageOffset() : Point
        {
            var _loc_1:Number = 0;
            var _loc_2:Number = 0;
            if (_instance.stage.stageWidth > maxStageWidth)
            {
                _loc_1 = (_instance.stage.stageWidth - maxStageWidth) / 2;
            }
            if (_instance.stage.stageHeight > maxStageHeight)
            {
                _loc_2 = (_instance.stage.stageHeight - maxStageHeight) / 2;
            }
            return new Point(Math.floor(_loc_1), Math.floor(_loc_2));
        }// end function

        public static function get stageClip() : Point
        {
            var _loc_1:Number = 0;
            var _loc_2:Number = 0;
            if (_instance.stage.stageWidth < minStageWidth)
            {
                _loc_1 = minStageWidth - Math.max(500, _instance.stage.stageWidth);
            }
            if (_instance.stage.stageHeight < minStageHeight)
            {
                _loc_2 = minStageHeight - Math.max(400, _instance.stage.stageHeight);
            }
            return new Point(Math.floor(_loc_1), Math.floor(_loc_2));
        }// end function

    }
}

class Singleton extends Object
{

    function Singleton()
    {
        return;
    }// end function

}

