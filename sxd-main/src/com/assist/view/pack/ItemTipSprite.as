package com.assist.view.pack
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.map.*;
    import com.haloer.display.*;
    import com.lang.client.com.assist.view.info.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    final public class ItemTipSprite extends Sprite
    {
        public var topString:String = "";
        public var bottomString:String = "";
        public var tipName:String = "";
        public var tipList:Array;
        public var playerItemId:int = 0;
        public var goldId:int = 0;
        public var basic:ItemBasically;
        private var _content:Sprite;
        private var _box:MovieClip;
        private var _gStar:MovieClip;
        private var _otherlist:Array;
        public var _activeBless:Array;
        private var _reqtime:int = 0;
        private var _isChange:Boolean = true;
        public static var iTip:ITip;
        public static var ed:EventDispatcher = new EventDispatcher();
        private static var _goldIdxList:Array = [1, 0, 1203, 1204, 1205, 1206, 1207, 1208, 1209, 1210, 1211];
        private static var _tfList:Array = [];

        public function ItemTipSprite()
        {
            this.tipList = [];
            this._content = new Sprite();
            this._otherlist = [];
            this._activeBless = [];
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this.addEventListener(Event.ADDED_TO_STAGE, this.addtostageHandler);
            this.filters = [Filter.filter2];
            return;
        }// end function

        private function addtostageHandler(event:Event) : void
        {
            if (this.tipName == "")
            {
                return;
            }
            this._box = this._box || MapStatic.mapInstance.boxObj;
            this._box.x = 145;
            this._box.y = 1;
            this._gStar = this._gStar || MapStatic.mapInstance.boxStar;
            this._gStar.x = 1;
            this._gStar.y = 37;
            if (getTimer() > this._reqtime)
            {
                if (this.basic.isJuanZhou)
                {
                    ed.dispatchEvent(new JuanZhouEvent(null, this.basic.item_id, "Item_Req"));
                    ed.addEventListener("Item_" + this.basic.item_id, this.reqJuanZhouHandler);
                }
                else if (this.basic.type_id == ItemType.WuQi && this.playerItemId != 0)
                {
                    ed.dispatchEvent(new JuanZhouEvent(null, this.playerItemId, "ItemSoul_Req"));
                    ed.addEventListener("ItemSoul_" + this.playerItemId, this.reqSoulHandler);
                }
            }
            this.update();
            return;
        }// end function

        public function updateTip(param1:String, param2:Array) : void
        {
            this.tipName = param1;
            this.tipList = param2 || [];
            param2.push(param2.pop() + "\n" + this.bottomString);
            this._isChange = true;
            if (stage)
            {
                this.update();
            }
            return;
        }// end function

        public function reset() : void
        {
            this._otherlist = [];
            this._activeBless = [];
            this.basic = ItemBasically.empty;
            var _loc_1:int = 0;
            this._reqtime = 0;
            var _loc_1:* = _loc_1;
            this.goldId = _loc_1;
            this.playerItemId = _loc_1;
            this.tipList = [];
            this.tipName = "";
            this._isChange = true;
            return;
        }// end function

        private function update() : void
        {
            var _loc_1:TextField = null;
            if (this._isChange == false)
            {
                return;
            }
            this._isChange = false;
            this.clear();
            this._box.Icon.addChild(BoxIconCache.getImg(this.basic.getImgUrl(this.goldId), true));
            this.updateItemTip();
            if (this.topString != "")
            {
                this._content.y = 16;
                _loc_1 = getTipTF(this.topString);
                this.addChild(_loc_1);
            }
            else
            {
                this._content.y = 0;
            }
            iTip.updateTarget();
            return;
        }// end function

        private function updateItemTip() : void
        {
            var _loc_3:TextField = null;
            var _loc_6:int = 0;
            var _loc_7:Sprite = null;
            var _loc_8:int = 0;
            var _loc_9:Image = null;
            var _loc_10:String = null;
            var _loc_1:* = _goldIdxList.indexOf(this.goldId);
            var _loc_2:int = 3;
            this._content.graphics.lineStyle(1, 4012085);
            this._gStar.gotoAndStop(_loc_1);
            _loc_3 = getTipTF(this.tipName, 0);
            _loc_3.y = _loc_2;
            this._content.addChild(_loc_3);
            if (_loc_3.textWidth > 143)
            {
                this._box.x = _loc_3.textWidth + 3;
            }
            _loc_2 = _loc_2 + _loc_3.height;
            if (_loc_1 > 2)
            {
                _loc_2 = _loc_2 + 20;
            }
            var _loc_4:* = this.tipList[0];
            if (this.basic.isEquip == false && this.basic.isDanYao == false)
            {
                _loc_3 = getTipTF(this.tipList[0], 0, 140);
                if (_loc_3.numLines > 1)
                {
                    _loc_4 = _loc_4.replace(_loc_3.getLineText(0), _loc_3.getLineText(0) + "\n");
                }
                _tfList.push(_loc_3);
            }
            _loc_3 = getTipTF(_loc_4);
            _loc_3.y = _loc_2;
            this._content.addChild(_loc_3);
            _loc_2 = _loc_2 + _loc_3.height;
            if (this.basic.type_id == ItemType.WuQi && this._activeBless.length > 0)
            {
                this._activeBless.sort(Array.NUMERIC);
                this._content.graphics.moveTo(2, _loc_2);
                this._content.graphics.lineTo(188, _loc_2);
                _loc_2 = _loc_2 + 4;
                _loc_7 = new Sprite();
                this._content.addChild(_loc_7);
                _loc_7.y = _loc_2;
                _loc_8 = 0;
                _loc_6 = 0;
                while (_loc_6 < this._activeBless.length)
                {
                    
                    _loc_9 = new Image(URI.nineRegionsBlessing + this._activeBless[_loc_6] + ".png");
                    _loc_7.addChild(_loc_9);
                    _loc_9.x = _loc_6 % 6 * 30;
                    _loc_9.y = int(_loc_6 / 6) * 35;
                    _loc_6++;
                }
                _loc_8 = 35;
                _loc_2 = _loc_2 + _loc_8;
            }
            var _loc_5:int = 0;
            if (this._otherlist.length > 0)
            {
                this._content.graphics.moveTo(2, _loc_2);
                this._content.graphics.lineTo(188, _loc_2);
                _loc_2 = _loc_2 + 4;
                if (this.basic.isEquip)
                {
                    _loc_3 = getTipTF(this._otherlist.join("\n"));
                    _loc_3.y = _loc_2;
                    _loc_2 = _loc_2 + _loc_3.height;
                    this._content.addChild(_loc_3);
                }
                else if (this.basic.isJuanZhou)
                {
                    _loc_5 = this._otherlist.length;
                    while (_loc_5 > 0)
                    {
                        
                        _loc_5 = _loc_5 - 1;
                        _loc_3 = getTipTF(this._otherlist[_loc_5], 3);
                        _loc_3.width = _loc_3.textWidth + 6;
                        _loc_3.x = 2 + (_loc_5 & 1) * 100;
                        _loc_3.y = _loc_2 + (_loc_5 >> 1) * 18;
                        this._content.addChild(_loc_3);
                    }
                    _loc_2 = _loc_2 + ((this._otherlist.length + 1) >> 1) * 18 + 5;
                }
            }
            _loc_5 = this.tipList.length;
            _loc_6 = 1;
            while (_loc_6 < _loc_5)
            {
                
                if ((_loc_5 - 1) == _loc_6 && this.basic.tipProduce != "")
                {
                    _loc_10 = "";
                    if (this.basic.type_id == 10006)
                    {
                        _loc_10 = htmlFormat(ItemInfoLang.CanChange + "\n", 12, 16777215) + htmlFormat(this.basic.tipProduce, 12, 15831369);
                    }
                    else
                    {
                        _loc_10 = htmlFormat(ItemInfoLang.CanMakeItem + "\n", 12, 16777215) + htmlFormat(this.basic.tipProduce, 12, 15831369);
                    }
                    this._content.graphics.moveTo(2, _loc_2);
                    this._content.graphics.lineTo(188, _loc_2);
                    _loc_2 = _loc_2 + 4;
                    _loc_3 = getTipTF(this.regStrList([_loc_10]));
                    _loc_3.y = _loc_2;
                    _loc_2 = _loc_2 + _loc_3.height;
                    this._content.addChild(_loc_3);
                }
                this._content.graphics.moveTo(2, _loc_2);
                this._content.graphics.lineTo(188, _loc_2);
                _loc_2 = _loc_2 + 4;
                _loc_3 = getTipTF(this.tipList[_loc_6]);
                _loc_3.y = _loc_2;
                _loc_2 = _loc_2 + _loc_3.height;
                this._content.addChild(_loc_3);
                _loc_6++;
            }
            return;
        }// end function

        private function reqJuanZhouHandler(event:JuanZhouEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:Array = null;
            var _loc_4:ItemBasically = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            if (event.id == this.basic.item_id)
            {
                this._otherlist = [];
                this._activeBless = [];
                this._reqtime = getTimer() + 20000;
                _loc_2 = event.list[7];
                for each (_loc_3 in event.list[4])
                {
                    
                    _loc_4 = ItemBasically.getBasic(_loc_3[0]);
                    _loc_5 = _loc_3[4];
                    _loc_6 = _loc_3[1];
                    _loc_7 = _loc_4.getItemName(_loc_2);
                    if (_loc_5 >= _loc_6)
                    {
                        _loc_7 = HtmlText.format(_loc_7 + " " + _loc_6 + "/" + _loc_6, 65280);
                    }
                    else
                    {
                        _loc_7 = HtmlText.format(_loc_7 + " " + _loc_5 + "/" + _loc_6, 15658734);
                    }
                    this._otherlist.push(_loc_7);
                }
                this._isChange = true;
                if (stage)
                {
                    this.update();
                }
            }
            ed.removeEventListener(event.type, this.reqJuanZhouHandler);
            return;
        }// end function

        private function reqSoulHandler(event:JuanZhouEvent) : void
        {
            var _loc_2:Object = null;
            if (event.id == this.playerItemId)
            {
                this._otherlist = [];
                this._activeBless = [];
                this._reqtime = getTimer() + 20000;
                for each (_loc_2 in event.list)
                {
                    
                    this._otherlist.push(htmlFormat(_loc_2.info, 12, this.basic.getItemColor(this.goldId)));
                    if (_loc_2.isActive)
                    {
                        this._activeBless.push(_loc_2.blessId);
                    }
                }
                this._isChange = true;
                if (stage)
                {
                    this.update();
                }
            }
            ed.removeEventListener(event.type, this.reqSoulHandler);
            return;
        }// end function

        private function clear() : void
        {
            var _loc_1:TextField = null;
            var _loc_2:* = this.numChildren;
            while (--_loc_2 > 0)
            {
                
                _loc_1 = this.removeChildAt(--_loc_2) as TextField;
                if (_loc_1 != null)
                {
                    _loc_1.width = 180;
                    _loc_1.height = 20;
                    _tfList.push(_loc_1);
                }
            }
            _loc_2 = this._content.numChildren;
            while (--_loc_2 > 0)
            {
                
                _loc_1 = this._content.removeChildAt(--_loc_2) as TextField;
                if (_loc_1 != null)
                {
                    _loc_1.width = 180;
                    _loc_1.height = 20;
                    _tfList.push(_loc_1);
                }
            }
            while (this._box.Icon.numChildren)
            {
                
                BoxIconCache.pushImg(this._box.Icon.removeChildAt(0) as Image);
            }
            this._gStar.gotoAndStop(1);
            this._content.graphics.clear();
            this._content.addChild(this._box);
            this._content.addChild(this._gStar);
            this.addChild(this._content);
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

        private static function getTipTF(param1:String, param2:int = 8, param3:int = 190) : TextField
        {
            var _loc_4:* = _tfList.pop() as TextField;
            if (_tfList.pop() as TextField == null)
            {
                _loc_4 = new TextField();
                _loc_4.mouseEnabled = false;
                _loc_4.wordWrap = true;
                _loc_4.multiline = true;
                _loc_4.textColor = 16777215;
            }
            _loc_4.x = 3;
            _loc_4.y = 0;
            _loc_4.width = param3;
            _loc_4.height = 300;
            _loc_4.htmlText = "<textformat leading=\'6\'>" + param1 + "</textformat>";
            _loc_4.height = _loc_4.textHeight + param2;
            return _loc_4;
        }// end function

    }
}
