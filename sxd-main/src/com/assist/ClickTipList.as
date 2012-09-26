package com.assist
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ClickTipList extends Sprite
    {
        public var maxW:int = 0;
        public var onTextClick:Function;
        public var onRemoveStage:Function;
        public var datas:Array;
        public var tfList:Array;
        private static const fun:Function = new Function();

        public function ClickTipList(param1:Array, param2:Array = null, param3:Function = null) : void
        {
            var _loc_5:TextField = null;
            var _loc_6:String = null;
            this.datas = [];
            this.tfList = [];
            this.onRemoveStage = fun;
            this.datas = param2 || param1;
            this.onTextClick = param3 || fun;
            this.maxW = 30;
            var _loc_4:int = 0;
            for each (_loc_6 in param1)
            {
                
                _loc_5 = new TextField();
                _loc_5.width = 100;
                _loc_5.height = 18;
                _loc_5.htmlText = "<P ALIGN=\"center\"><font color=\"#fffffff\">" + _loc_6 + "</font></P>";
                _loc_5.name = _loc_4 + "";
                _loc_5.selectable = false;
                _loc_5.y = _loc_4 * 19;
                _loc_5.addEventListener(MouseEvent.CLICK, this.textClick);
                _loc_5.addEventListener(MouseEvent.MOUSE_OVER, this.onTextMouseOver);
                this.addChild(_loc_5);
                if (this.maxW < _loc_5.textWidth + 3)
                {
                    this.maxW = _loc_5.textWidth + 3;
                }
                this.tfList.push(_loc_5);
                _loc_4++;
            }
            for each (_loc_5 in this.tfList)
            {
                
                _loc_5.width = this.maxW;
            }
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.removeStageHandler, true);
            return;
        }// end function

        private function removeStageHandler(event:Event) : void
        {
            this.onRemoveStage();
            return;
        }// end function

        private function textClick(event:Event) : void
        {
            var _loc_2:* = int(event.currentTarget.name);
            this.onTextClick(this.datas[_loc_2]);
            return;
        }// end function

        private function onTextMouseOver(event:Event) : void
        {
            this.graphics.clear();
            this.graphics.beginFill(6113324, 1);
            this.graphics.drawRect(0, (event.currentTarget.y + 1), this.maxW, 18);
            return;
        }// end function

        private function onTextMouseOut(event:Event) : void
        {
            this.graphics.clear();
            return;
        }// end function

    }
}
