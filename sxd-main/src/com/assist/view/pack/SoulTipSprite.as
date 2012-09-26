package com.assist.view.pack
{
    import com.assist.view.map.*;
    import com.haloer.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;

    final public class SoulTipSprite extends Sprite
    {
        public var iconUrl:String = "";
        public var nameHtml:String = "";
        public var desHtml:String = "";
        public var addHtml:String = "";
        public var star1:int = 0;
        public var star2:int = 0;
        public var star3:int = 0;
        public var ischange:Boolean = true;
        private var _icon:Sprite;
        private var _star1:MovieClip;
        private var _star2:MovieClip;
        private var _star3:MovieClip;
        private var _box:MovieClip;
        private static var _gf:GlowFilter = new GlowFilter(0, 1, 2, 2, 4, 1);
        private static var _tfList:Array = [];

        public function SoulTipSprite()
        {
            this._icon = new Sprite();
            var _loc_1:* = new MovieClip();
            this._star3 = new MovieClip();
            var _loc_1:* = _loc_1;
            this._star2 = _loc_1;
            this._star1 = _loc_1;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this.addEventListener(Event.ADDED_TO_STAGE, this.addtostageHandler);
            return;
        }// end function

        private function addtostageHandler(event:Event) : void
        {
            if (this._box == null)
            {
                this._box = MapStatic.mapInstance.soulBox;
                this._box.x = 145;
                this._box.y = 1;
                this._icon = this._box.MCIcon;
                this._star1 = this._box.MCStar1;
                this._star2 = this._box.MCStar2;
                this._star3 = this._box.MCStar3;
                this.filters = [_gf];
            }
            this.update();
            return;
        }// end function

        private function clearChild(param1:Sprite) : void
        {
            while (param1.numChildren)
            {
                
                BoxIconCache.pushImg(param1.removeChildAt(0) as Image);
            }
            return;
        }// end function

        private function update() : void
        {
            if (this.ischange == false)
            {
                return;
            }
            this.ischange = false;
            this.clear();
            if (this._icon.numChildren == 0)
            {
                this._icon.addChild(BoxIconCache.getImg(this.iconUrl, true));
            }
            this._star1.gotoAndStop(this.star1);
            this._star1.visible = this.star1 != 0;
            this._star2.gotoAndStop(this.star2);
            this._star2.visible = this.star2 != 0;
            this._star3.gotoAndStop(this.star3);
            this._star3.visible = this.star3 != 0;
            var _loc_1:* = getTipTF(this.regStrList([this.nameHtml, this.addHtml, this.desHtml]));
            this.addChild(_loc_1);
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:TextField = null;
            this.graphics.clear();
            while (this.numChildren)
            {
                
                _loc_1 = this.removeChildAt(0) as TextField;
                if (_loc_1 != null)
                {
                    _loc_1.width = 180;
                    _loc_1.height = 20;
                    _tfList.push(_loc_1);
                }
            }
            while (this._icon.numChildren)
            {
                
                this._icon.removeChildAt(0);
            }
            this.addChild(this._box);
            return;
        }// end function

        private function regStrList(param1:Array) : String
        {
            var _loc_3:String = null;
            var _loc_2:Array = [];
            for each (_loc_3 in param1)
            {
                
                if (_loc_3 != "")
                {
                    _loc_3 = _loc_3.split("\r\n").join("\n");
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2.join("\n");
        }// end function

        private static function getTipTF(param1:String, param2:int = 145) : TextField
        {
            var _loc_3:* = _tfList.pop() as TextField;
            if (_loc_3 == null)
            {
                _loc_3 = new TextField();
                _loc_3.mouseEnabled = false;
                _loc_3.wordWrap = true;
                _loc_3.multiline = true;
                _loc_3.textColor = 16777215;
            }
            _loc_3.x = 3;
            _loc_3.y = 0;
            _loc_3.width = param2;
            _loc_3.htmlText = "<textformat leading=\'6\'>" + param1 + "</textformat>";
            _loc_3.height = _loc_3.textHeight + 5;
            return _loc_3;
        }// end function

    }
}
