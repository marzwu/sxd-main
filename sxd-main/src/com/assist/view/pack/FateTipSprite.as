package com.assist.view.pack
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.map.*;
    import com.haloer.net.*;
    import flash.display.*;
    import flash.text.*;

    public class FateTipSprite extends Sprite
    {
        private var _fateMcData:Object;
        private var _fateSign:String;
        private var colorObj:Object;
        private var _tip:ITip;
        private var _fateMc:MovieClip;
        private var _box:MovieClip;
        private var _fateFile:TextField;
        private var _textFromat:TextFormat;
        private var _rect:Sprite;
        private var _fateMcList:Array;
        private var _isLoader:Boolean = false;
        private var _fateIconList:Array;

        public function FateTipSprite()
        {
            this.colorObj = {1:10066329, 2:2272312, 3:44783, 4:16711935, 5:16773376, 6:16711680};
            this._fateMcData = {};
            this.addMc();
            this.createRect();
            this.addFile();
            return;
        }// end function

        public function set tip(param1:ITip) : void
        {
            this._tip = param1;
            return;
        }// end function

        public function set target(param1:DisplayObject) : void
        {
            var _loc_2:* = this._tip.clickToOpen(this._fateMc);
            return;
        }// end function

        public function set getFateId(param1:int) : void
        {
            var _loc_2:* = FateType.getFateSign(param1);
            if (this._fateSign == _loc_2)
            {
                return;
            }
            this._fateSign = _loc_2;
            var _loc_3:Object = {};
            _loc_3.fateId = param1;
            _loc_3.fateLevel = 1;
            _loc_3.quality = FateType.getFateQuality(_loc_3.fateId);
            _loc_3.fateName = FateType.getFateName(_loc_3.fateId);
            _loc_3.color = this.colorObj[_loc_3.quality];
            _loc_3.info = FateType.getFateDescription(_loc_3.fateId);
            _loc_3.sell = FateType.getSalePriceByFateId(_loc_3.fateId);
            _loc_3.addValue = FateType.getFateAddonValue(_loc_3.fateId, _loc_3.fateLevel);
            _loc_3.maxLevel = FateType.getMaxFateLevel(_loc_3.fateId);
            _loc_3.url = URI.fateUrl + _loc_3.sign + ".swf";
            _loc_3.baseExp = FateType.getExperienceByQualityId(_loc_3.quality);
            _loc_3.warType = FateType.getWarAttributeType(_loc_3.fateId);
            if (_loc_3.warType == FateType.Hit || _loc_3.warType == FateType.Block || _loc_3.warType == FateType.Dodge || _loc_3.warType == FateType.Critical || _loc_3.warType == FateType.BreakBlock || _loc_3.warType == FateType.BreakCritical || _loc_3.warType == FateType.Kill)
            {
                _loc_3.addValue = _loc_3.addValue * 10;
            }
            var _loc_4:* = URI.fateUrl + this._fateSign + ".swf";
            this.renderFateData(_loc_3);
            if (this._fateMcData[this._fateSign] != null)
            {
                this.oldFateDate();
            }
            else
            {
                this.getFataUrl(_loc_4);
            }
            return;
        }// end function

        private function oldFateDate() : void
        {
            var _loc_1:Object = {};
            _loc_1.loader = this._fateMcData[this._fateSign];
            this.renderLootFate([_loc_1]);
            return;
        }// end function

        private function addMc() : void
        {
            this._fateMc = new MovieClip();
            this._box = MapStatic.mapInstance.boxObj;
            this._fateMc.addChild(this._box);
            return;
        }// end function

        private function addFile() : void
        {
            this._textFromat = new TextFormat();
            this._textFromat.leading = 8;
            this._fateFile = new TextField();
            this._fateFile.autoSize = TextFieldAutoSize.LEFT;
            this._fateFile.textColor = 16777215;
            this._fateFile.selectable = false;
            this._fateMc.addChild(this._fateFile);
            return;
        }// end function

        private function renderFateData(param1:Object) : void
        {
            var _loc_2:String = "";
            this._fateFile.htmlText = htmlFormat(param1.fateName, 14, param1.color, false) + htmlFormat(" Lv." + param1.fateLevel, 12, param1.color, false) + htmlFormat("\n" + param1.info + " " + param1.addValue, 12, 13382400, false) + "  ";
            this._fateFile.setTextFormat(this._textFromat);
            return;
        }// end function

        private function createRect() : void
        {
            this._rect = new Sprite();
            this._rect.graphics.beginFill(0);
            this._rect.graphics.drawRect(0, 0, 160, 60);
            this._rect.graphics.endFill();
            this._rect.mouseEnabled = false;
            this._fateMc.addChild(this._rect);
            this._rect.alpha = 0;
            return;
        }// end function

        private function getFataUrl(param1:String) : void
        {
            this._fateMcList = [];
            this._fateMcList.push(param1);
            File.loadList(this._fateMcList, this.renderLootFate);
            return;
        }// end function

        private function renderLootFate(param1:Array) : void
        {
            if (this._isLoader)
            {
                this._fateIconList[0].parent.removeChild(this._fateIconList[0]);
                this._isLoader = false;
            }
            this._fateIconList = [];
            this._fateMcList = null;
            this._fateIconList.push(param1[0].loader);
            this._fateMcData[this._fateSign] = param1[0].loader;
            this._box.Icon.addChild(param1[0].loader);
            var _loc_2:* = Math.max(100, this._fateFile.width + 10);
            this._box.x = _loc_2 + 5;
            this._box.y = 3;
            param1[0].loader.scaleX = 0.8;
            param1[0].loader.scaleY = 0.8;
            param1[0].loader.x = 20;
            param1[0].loader.y = 20;
            this._isLoader = true;
            return;
        }// end function

        private function clearFateMc() : void
        {
            if (this._isLoader && this._fateIconList[0].parent)
            {
                this._fateIconList[0].content.stop();
                this._fateIconList[0].parent.removeChild(this._fateIconList[0]);
                this._isLoader = false;
            }
            return;
        }// end function

    }
}
