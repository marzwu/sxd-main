package com.assist.view.pack
{
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.item.*;
    import com.haloer.display.*;
    import com.lang.client.com.assist.view.pack.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;

    public class BoxGrid extends Object
    {
        public var id:int = 0;
        public var boxType:int = 0;
        private var _item:ItemInfo;
        public var can:Array;
        public var onDown:Function;
        public var onUp:Function;
        public var onDrag:Function;
        public var onDragView:Function;
        public var onRemove:Function;
        public var onDoubleClick:Function;
        public var onClick:Function;
        public var defaultTips:String = null;
        public var content:Sprite;
        private var _iBox:IBoxUI;
        private var _icon:Sprite;
        public var isLock:Boolean = false;
        private var _mouseDownTime:int = 0;
        private var _mouseUpTime:int = 0;
        private var _downX:int = 0;
        private var _downY:int = 0;
        public static const idPack:int = 1;
        public static const idRole:int = 201;
        public static const idWareHouse:int = 101;
        public static const typePack:int = 1;
        public static const typeRole:int = 2;
        public static const typeWareHouse:int = 3;
        public static const typeShop:int = 4;
        public static const typeFurnace:int = 5;
        public static var isOpenShop:Boolean = false;
        public static var isOpenWareHouse:Boolean = false;
        public static var isOpenRole:Boolean = false;
        public static var isOpenRecycle:Boolean = false;
        private static var emptyFun:Function = new Function();
        private static var cf:ColorMatrixFilter = new ColorMatrixFilter([0.2, 0.2, 0.2, 0, 0, 0.2, 0.2, 0.2, 0, 0, 0.2, 0.2, 0.2, 0, 0, 0, 0, 0, 1, 1]);
        private static var focusBox:BoxGrid;
        public static var itip:ITip;
        public static var dragLayer:Sprite = new Sprite();
        private static var dragIcon:Sprite = new Sprite();
        public static var eqList:Array;

        public function BoxGrid(param1:int, param2:int, param3:IBoxUI)
        {
            this.can = [];
            this._iBox = param3;
            this.id = param1;
            this.boxType = param2;
            this._iBox.num = "";
            this._iBox.itemName = "";
            this._icon = this._iBox.icon;
            this.content = this._iBox.content;
            this.content.addEventListener(MouseEvent.MOUSE_OVER, this.boxOverHandler);
            this.content.addEventListener(MouseEvent.MOUSE_OUT, this.boxOutHandler);
            this.content.addEventListener(MouseEvent.MOUSE_DOWN, this.boxDownHandler);
            this.content.addEventListener(MouseEvent.MOUSE_UP, this.boxUpHandler);
            this._item = new ItemInfo();
            var _loc_4:* = emptyFun;
            this.onDragView = emptyFun;
            var _loc_4:* = _loc_4;
            this.onRemove = _loc_4;
            var _loc_4:* = _loc_4;
            this.onUp = _loc_4;
            var _loc_4:* = _loc_4;
            this.onDown = _loc_4;
            var _loc_4:* = _loc_4;
            this.onClick = _loc_4;
            var _loc_4:* = _loc_4;
            this.onDoubleClick = _loc_4;
            this.onDrag = _loc_4;
            return;
        }// end function

        public function set lockLight(param1:Boolean) : void
        {
            this._iBox.lockLight = param1;
            return;
        }// end function

        public function get item() : ItemInfo
        {
            return this._item;
        }// end function

        public function set item(param1:ItemInfo) : void
        {
            this._item = param1 || new ItemInfo();
            var _loc_2:* = param1 == null;
            this.isLock = param1 == null;
            this._iBox.lock = _loc_2;
            this.updateShow();
            return;
        }// end function

        public function get itemId() : int
        {
            return this._item.itemId;
        }// end function

        public function get itemType() : int
        {
            return this._item.basic.type_id;
        }// end function

        public function get playerItemId() : int
        {
            return this._item.playerItemId;
        }// end function

        public function get itemName() : String
        {
            return this._item.name;
        }// end function

        public function get isPackBox() : Boolean
        {
            return this.boxType == typePack;
        }// end function

        public function get isRoleBox() : Boolean
        {
            return this.boxType == typeRole;
        }// end function

        public function get isWareHouseBox() : Boolean
        {
            return this.boxType == typeWareHouse;
        }// end function

        public function get isShopBox() : Boolean
        {
            return this.boxType == typeShop;
        }// end function

        public function get isFurnace() : Boolean
        {
            return this.boxType == typeFurnace;
        }// end function

        public function hideItem() : void
        {
            this.clearIcon(this._icon);
            this._iBox.num = "";
            itip.removeTarget(this.content);
            return;
        }// end function

        private function updateShow() : void
        {
            this._iBox.id = this._item.itemId;
            this.content.filters = [];
            this.clearIcon(this._icon);
            itip.removeTarget(this.content);
            if (this._item.itemId == 0)
            {
                this._iBox.num = "";
                this._iBox.itemName = "";
                this._iBox.itemPrice = "";
                if (this.defaultTips != null)
                {
                    itip.addTarget(this.content, this.defaultTips);
                }
            }
            else
            {
                this._icon.addChild(this.getImg(this._item.iconUrl, true));
                this._iBox.num = this._item.num + "";
                this._iBox.itemName = HtmlText.format(this._item.name, this._item.color, 13);
                this._iBox.itemPrice = "";
                this.updateItemPrice();
                this.updateTips();
                if (this._item.basic.isStack == false || this.boxType == typeShop && isOpenShop)
                {
                    this._iBox.num = "";
                }
            }
            return;
        }// end function

        private function updateItemPrice() : void
        {
            if (this._item.isCardBuy)
            {
                this._iBox.itemPrice = this._item.basic.card_name + " " + this._item.basic.card_num;
            }
            else if (this._item.basic.ingot > 0)
            {
                this._iBox.itemPrice = "<font color=\'#fff200\'>" + BoxGridLang.Ingot + this._item.basic.ingot + "</font>";
            }
            else
            {
                this._iBox.itemPrice = BoxGridLang.Coin + this._item.totalprice;
            }
            return;
        }// end function

        public function updateTips() : void
        {
            var _loc_2:BoxGrid = null;
            var _loc_3:Sprite = null;
            var _loc_1:* = this._item.getTipsSprite1("", getAddtip(this.boxType, this._item));
            if (this._item.basic.isEquip && this.isPackBox && eqList)
            {
                _loc_2 = eqList[this._item.basic.type_id];
                if (_loc_2.itemId != 0)
                {
                    _loc_3 = _loc_2.item.getTipsSprite2(HtmlText.format(BoxGridLang.CurrentEquip, 8623050), "");
                    itip.addTargetMoreTips(this.content, _loc_1, _loc_3);
                    return;
                }
            }
            itip.addTarget(this.content, _loc_1);
            return;
        }// end function

        public function addFilters() : void
        {
            this.content.filters = [cf];
            return;
        }// end function

        public function removeFilters() : void
        {
            this.content.filters = [];
            return;
        }// end function

        private function boxOverHandler(event:Event) : void
        {
            focusBox = this;
            this._iBox.light = true;
            return;
        }// end function

        private function boxOutHandler(event:Event) : void
        {
            if (focusBox == this)
            {
                focusBox = null;
            }
            this._iBox.light = false;
            return;
        }// end function

        public function set eqUpdateVisible(param1:Boolean) : void
        {
            if (this._iBox is IBoxUpdateUI)
            {
                (this._iBox as IBoxUpdateUI).btnUpdate.visible = param1;
            }
            return;
        }// end function

        public function get btnUpdate() : DisplayObject
        {
            return (this._iBox as IBoxUpdateUI).btnUpdate;
        }// end function

        public function set onEqUpdate(param1:Function) : void
        {
            var box:BoxGrid;
            var fun:* = param1;
            box;
            if (this._iBox is IBoxUpdateUI)
            {
                (this._iBox as IBoxUpdateUI).btnUpdate.addEventListener(MouseEvent.CLICK, function () : void
            {
                fun(box);
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function set goldVisible(param1:Boolean) : void
        {
            if (this._iBox is IBoxUpdateUI)
            {
                (this._iBox as IBoxUpdateUI).btnGold.visible = param1;
            }
            return;
        }// end function

        public function get btnGold() : DisplayObject
        {
            return (this._iBox as IBoxUpdateUI).btnGold;
        }// end function

        public function set onGoldUpdate(param1:Function) : void
        {
            var box:BoxGrid;
            var fun:* = param1;
            box;
            if (this._iBox is IBoxUpdateUI)
            {
                (this._iBox as IBoxUpdateUI).btnGold.addEventListener(MouseEvent.CLICK, function () : void
            {
                fun(box);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function boxUpHandler(event:Event) : void
        {
            this.content.removeEventListener(MouseEvent.MOUSE_MOVE, this.boxMoveHandler);
            if (this._mouseDownTime == 0)
            {
                return;
            }
            var _loc_2:* = getTimer();
            var _loc_3:* = _loc_2 - this._mouseUpTime;
            this._mouseUpTime = _loc_2;
            if (_loc_3 > 50 && _loc_3 < 350)
            {
                this._mouseUpTime = 0;
                if (this._item.itemId != 0)
                {
                    this.onDoubleClick(this);
                }
            }
            else
            {
                setTimeout(this.checkClick, 200, this._mouseDownTime);
            }
            this.onUp(this);
            return;
        }// end function

        private function checkClick(param1:int) : void
        {
            if (this._mouseDownTime == param1)
            {
                this.onClick(this);
            }
            return;
        }// end function

        private function boxDownHandler(event:Event) : void
        {
            this._mouseDownTime = getTimer();
            this._downX = this.content.mouseX;
            this._downY = this.content.mouseY;
            this.content.addEventListener(MouseEvent.MOUSE_MOVE, this.boxMoveHandler);
            itip.hideOpened();
            this.onDown(this);
            return;
        }// end function

        private function boxMoveHandler(event:MouseEvent) : void
        {
            if (event.buttonDown == false)
            {
                this.content.removeEventListener(MouseEvent.MOUSE_MOVE, this.boxMoveHandler);
                return;
            }
            var _loc_2:* = this.content.mouseX - this._downX;
            var _loc_3:* = this.content.mouseY - this._downY;
            if (_loc_2 < 0)
            {
                _loc_2 = -_loc_2;
                ;
            }
            if (_loc_3 < 0)
            {
                _loc_3 = -_loc_3;
                ;
            }
            if (_loc_2 + _loc_3 < 6)
            {
                return;
            }
            this.content.removeEventListener(MouseEvent.MOUSE_MOVE, this.boxMoveHandler);
            this._mouseDownTime = 0;
            if (this._item.itemId == 0)
            {
                return;
            }
            this.addFilters();
            var _loc_4:* = this.content.mouseX;
            var _loc_5:* = this.content.mouseY;
            dragLayer.addChild(dragIcon);
            this.clearIcon(dragIcon);
            dragIcon.addChild(this.getImg(this._item.iconUrl, true));
            dragIcon.x = dragLayer.mouseX - 22;
            dragIcon.y = dragLayer.mouseY - 22;
            dragIcon.startDrag();
            this.content.stage.addEventListener(MouseEvent.MOUSE_UP, this.stageMouseUpHandler);
            return;
        }// end function

        private function stageMouseUpHandler(event:Event) : void
        {
            var _loc_6:Array = null;
            var _loc_7:IBoxPack = null;
            var _loc_2:* = event.currentTarget as Stage;
            _loc_2.removeEventListener(MouseEvent.MOUSE_UP, this.stageMouseUpHandler);
            dragIcon.stopDrag();
            if (dragIcon.parent == dragLayer)
            {
                dragLayer.removeChild(dragIcon);
            }
            this.onUp(this);
            this.removeFilters();
            if (this.onDrag === emptyFun)
            {
                return;
            }
            var _loc_3:BoxGrid = this;
            var _loc_4:* = focusBox;
            if (_loc_3 === _loc_4)
            {
                return;
            }
            var _loc_5:* = _loc_3.itemType;
            if (_loc_4 != null && _loc_4.canPush(_loc_5) && _loc_4.isLock == false)
            {
                this.onDrag(_loc_3, _loc_4);
                return;
            }
            if (_loc_4 == null || _loc_4.isLock == true)
            {
                _loc_6 = _loc_2.getObjectsUnderPoint(new Point(_loc_2.mouseX, _loc_2.mouseY));
                _loc_7 = findBoxPack(_loc_6);
                if (_loc_7 == null)
                {
                    this.onRemove(_loc_3);
                }
                else
                {
                    this.onDragView(_loc_3, _loc_7);
                }
            }
            return;
        }// end function

        public function canPush(param1:int) : Boolean
        {
            if (this.can.length == 0)
            {
                return true;
            }
            if (this.can.indexOf(param1) != -1)
            {
                return true;
            }
            return false;
        }// end function

        private function clearIcon(param1:Sprite) : void
        {
            while (param1.numChildren)
            {
                
                BoxIconCache.pushImg(param1.removeChildAt(0) as Image);
            }
            return;
        }// end function

        private function getImg(param1:String, param2:Boolean) : Image
        {
            return BoxIconCache.getImg(param1, param2);
        }// end function

        private static function findBoxPack(param1:Array) : IBoxPack
        {
            var _loc_2:DisplayObject = null;
            while (param1.length)
            {
                
                _loc_2 = param1.pop() as DisplayObject;
                if (_loc_2 is IBoxPack)
                {
                    return _loc_2 as IBoxPack;
                }
                while (_loc_2.parent)
                {
                    
                    _loc_2 = _loc_2.parent;
                    if (_loc_2 is IBoxPack)
                    {
                        return _loc_2 as IBoxPack;
                    }
                }
            }
            return null;
        }// end function

        public static function initStatic() : void
        {
            dragIcon.mouseChildren = false;
            dragIcon.mouseEnabled = false;
            dragIcon.graphics.beginFill(0, 0.1);
            dragIcon.graphics.drawRect(0, 0, 40, 40);
            return;
        }// end function

        private static function getAddtip(param1:int, param2:ItemInfo) : String
        {
            var _loc_3:String = "";
            if (param1 == BoxGrid.typeShop)
            {
                _loc_3 = isOpenShop ? (BoxGridLang.ClickBuy) : (BoxGridLang.ClickRebuy);
                if (isOpenShop && param2.isCardBuy)
                {
                    _loc_3 = _loc_3 + "\n" + BoxGridLang.JoinGetJade;
                }
            }
            else if (param1 == BoxGrid.typeWareHouse)
            {
                _loc_3 = BoxGridLang.ClickGet;
            }
            else if (param1 == BoxGrid.typeRole)
            {
                _loc_3 = BoxGridLang.ClickUnGet;
            }
            else if (param1 == BoxGrid.typePack)
            {
                if (isOpenShop || isOpenRecycle)
                {
                    if (param2.basic.isBrand)
                    {
                        _loc_3 = BoxGridLang.NoSellJade;
                    }
                    else if (param2.basic.isPackage)
                    {
                        _loc_3 = BoxGridLang.NoSellGift;
                    }
                    else if (param2.useing)
                    {
                        _loc_3 = BoxGridLang.NoSellInUse;
                    }
                    else if (param2.basic.ingot > 0)
                    {
                        _loc_3 = BoxGridLang.NoSellItem;
                    }
                    else if (param2.basic.price == 0)
                    {
                        _loc_3 = BoxGridLang.NoSellItem;
                    }
                    else
                    {
                        _loc_3 = BoxGridLang.ClickSell;
                    }
                }
                else if (isOpenWareHouse)
                {
                    if (param2.useing)
                    {
                        _loc_3 = BoxGridLang.NoIntoWarehouse;
                    }
                    else
                    {
                        _loc_3 = BoxGridLang.ClickIntoWarehouse;
                    }
                }
                else if (param2.basic.isEquip)
                {
                    _loc_3 = BoxGridLang.ClickEquip;
                }
                else if (param2.basic.isMounts)
                {
                    _loc_3 = BoxGridLang.ClickRide;
                }
                else if (param2.basic.isCanUseing)
                {
                    _loc_3 = BoxGridLang.ClickUse;
                }
            }
            if (_loc_3 != "")
            {
                _loc_3 = HtmlText.format(_loc_3, 8947848, 12);
            }
            return _loc_3;
        }// end function

    }
}
