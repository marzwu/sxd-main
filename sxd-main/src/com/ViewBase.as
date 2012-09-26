package com
{
    import com.assist.*;
    import com.assist.view.*;
    import com.haloer.data.*;
    import com.haloer.net.*;
    import com.views.*;
    import flash.display.*;
    import flash.events.*;

    public class ViewBase extends SuperBase
    {
        protected var _stage:Stage;
        protected var _structure:Structure;
        protected var _ctrl:Controller;
        protected var _data:Data;
        protected var _lang:Lang;
        private var _positionList:Object;
        private var _assets:Object;
        private var _libs:Object;

        public function ViewBase(param1:Stage)
        {
            this._positionList = {};
            this._assets = {};
            this._libs = {};
            this._stage = param1;
            return;
        }// end function

        public function get stage() : Stage
        {
            return this._stage;
        }// end function

        public function get structure() : Structure
        {
            return this._structure;
        }// end function

        public function get ctrl() : Controller
        {
            return this._ctrl;
        }// end function

        public function get lang() : Lang
        {
            return this._lang;
        }// end function

        public function init(param1:Data, param2:Controller, param3:Lang) : void
        {
            this._data = param1;
            this._ctrl = param2;
            this._lang = param3;
            this._structure = Structure.getInstance(this._stage, this);
            this._stage.addEventListener(Event.RESIZE, this.resetPosition);
            return;
        }// end function

        protected function createObject(param1:Class, param2:String = "") : Object
        {
            param2 = (param1 + "").replace(/View\]$""View\]$/, "");
            return createObjectBase(param1, param2, this as View, this._ctrl, this._data);
        }// end function

        public function addToPositionList(param1:String, param2:Function) : void
        {
            this._positionList[param1] = param2;
            return;
        }// end function

        public function removeFromPositionList(param1:String) : void
        {
            delete this._positionList[param1];
            return;
        }// end function

        protected function resetPosition(event:Event) : void
        {
            var _loc_2:String = null;
            for (_loc_2 in this._positionList)
            {
                
                var _loc_5:* = this._positionList;
                _loc_5.this._positionList[_loc_2]();
            }
            return;
        }// end function

        public function center(param1:String, param2:DisplayObject, param3:Function = null) : void
        {
            var sign:* = param1;
            var d:* = param2;
            var func:* = param3;
            if (func == null)
            {
                func = function () : void
            {
                if (d.stage == null)
                {
                    removeFromPositionList(sign);
                    return;
                }
                var _loc_1:* = Structure.stageWidth;
                var _loc_2:* = Structure.stageHeight;
                var _loc_3:* = Math.floor((_loc_2 - d.height) / 2);
                d.x = Math.floor((_loc_1 - d.width) / 2);
                d.y = _loc_3 < 0 ? (60) : (_loc_3);
                return;
            }// end function
            ;
            }
            this.func();
            this.addToPositionList(sign, func);
            return;
        }// end function

        public function cancelCenter(param1:String) : void
        {
            this.removeFromPositionList(param1);
            return;
        }// end function

        public function hasAssets(param1:String) : Boolean
        {
            return this._assets[param1];
        }// end function

        public function addAssets(param1:String, param2:String) : void
        {
            if (this.hasAssets(param1))
            {
                throw new Error("名称为" + param1 + "已经存在。");
            }
            this._assets[param1] = param2;
            return;
        }// end function

        public function getAssetsUrl(param1:String) : String
        {
            if (this.hasAssets(param1) == false)
            {
                throw new Error("对象 _assets 找不到键名为 " + param1 + " 的项。");
            }
            if (param1.indexOf(URI.assetsUrl) == 0)
            {
                return param1;
            }
            return URI.assetsUrl + this._assets[param1];
        }// end function

        public function getAssetsClass(param1:String, param2:String) : Class
        {
            if (this.hasResource(param1) == false)
            {
                throw new Error("找不到名为 " + param1 + " 的资源。请确认资源 " + param1 + " 关联的swf文件已经加载。");
            }
            return (this._libs[param1] as File).getClassByName(param2);
        }// end function

        public function getAssetsObject(param1:String, param2:String) : Object
        {
            var _loc_3:* = this.getAssetsClass(param1, param2) as Class;
            return new _loc_3;
        }// end function

        public function getAssetsObj(param1:String) : File
        {
            return this._libs[param1] as File;
        }// end function

        public function loadResources(param1:Array, param2:LoadResponder, param3:Boolean = false) : void
        {
            var len:int;
            var i:int;
            var list:* = param1;
            var loadResponder:* = param2;
            var fullUrl:* = param3;
            var callback:* = function (param1:Array) : void
            {
                oObject.list(param1, _libs, list);
                loadResponder.lCallback();
                return;
            }// end function
            ;
            var progress:* = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                loadResponder.lProgress(list[param2], param3, param2, param1, param4);
                return;
            }// end function
            ;
            var tempList:Array;
            len = list.length;
            i;
            while (i < len)
            {
                
                tempList[i] = fullUrl ? (list[i]) : (this.getAssetsUrl(list[i]));
                i = (i + 1);
            }
            File.loadList(tempList, callback, progress);
            return;
        }// end function

        public function loadNewResources(param1:String, param2:LoadResponder) : void
        {
            if (this.hasResource(param1) == false)
            {
                this._assets[param1] = param1;
                this.loadResources([param1], param2, true);
            }
            else
            {
                param2.lCallback();
            }
            return;
        }// end function

        public function hasResource(param1:String) : Boolean
        {
            return this._libs[param1];
        }// end function

        public function removeResource(param1:String) : void
        {
            if (this.hasResource(param1))
            {
                delete this._libs[param1];
            }
            return;
        }// end function

    }
}
