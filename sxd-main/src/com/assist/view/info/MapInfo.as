package com.assist.view.info
{
    import com.assist.view.map.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class MapInfo extends Object
    {
        public var urlMap:String;
        public var urlMini:String;
        public var urlXML:String;
        public var urlSound:String = "";
        public var portals:Array;
        public var builds:Array;
        public var effects:Array;
        public var xml:XML;
        public var mapW:int;
        public var mapH:int;
        public var barriers:Array;
        public var order:int = 0;
        private var _load:URLLoader;
        private var _funComplete:Function;

        public function MapInfo()
        {
            this.portals = [];
            this.builds = [];
            this.effects = [];
            this.barriers = [];
            this._load = new URLLoader();
            return;
        }// end function

        public function loadXML() : void
        {
            this.xml = null;
            this._load.load(new URLRequest(this.urlXML));
            this._load.addEventListener(Event.COMPLETE, this.xmlLoad);
            return;
        }// end function

        private function xmlLoad(event:Event) : void
        {
            var _loc_2:XML = null;
            var _loc_3:XML = null;
            var _loc_4:int = 0;
            var _loc_5:Array = null;
            var _loc_6:ByteArray = null;
            var _loc_7:String = null;
            var _loc_10:PortalInfo = null;
            var _loc_11:BuildInfo = null;
            var _loc_12:int = 0;
            this.xml = XML(this._load.data);
            this._load = null;
            this.urlSound = String(this.xml.@sound);
            if (this.urlSound != "")
            {
                this.urlSound = MapStatic.FolderMap + "sound/" + this.urlSound;
            }
            this.portals = [];
            for each (_loc_2 in this.xml.portalList.portal)
            {
                
                _loc_10 = new PortalInfo();
                _loc_10.x = int(_loc_2.@x);
                _loc_10.y = int(_loc_2.@y);
                _loc_10.type = int(_loc_2.@type);
                _loc_10.type = _loc_10.type == 0 ? (PortalInfo.TypeMission) : (_loc_10.type);
                if (_loc_10.type == PortalInfo.TypeMission || _loc_10.type == PortalInfo.TypeMissionHero)
                {
                    this.portals.push(_loc_10);
                }
            }
            this.builds = [];
            for each (_loc_2 in this.xml.builds.build)
            {
                
                _loc_11 = new BuildInfo();
                _loc_11.id = int(_loc_2.@id);
                _loc_11.x = int(_loc_2.@x);
                _loc_11.y = int(_loc_2.@y);
                _loc_11.nx = int(_loc_2.@nx);
                _loc_11.ny = int(_loc_2.@ny);
                _loc_11.toX = int(_loc_2.@toX);
                _loc_11.toY = int(_loc_2.@toY);
                _loc_11.url = MapStatic.FolderMap + "build/" + String(_loc_2.@url);
                _loc_11.defaultVisible = int(_loc_2.@show) == 1;
                _loc_11.hasMouse = int(_loc_2.@notmouse) == 0;
                this.builds.push(_loc_11);
                if (_loc_11.toX == 0 && _loc_11.toY == 0)
                {
                    _loc_11.toX = _loc_11.x;
                    _loc_11.toY = _loc_11.y;
                }
            }
            for each (_loc_2 in this.xml.effectData.effect)
            {
                
                this.effects.push({layder:String(_loc_2.@layder), url:MapStatic.FolderMap + "map_effect/" + String(_loc_2.@url)});
            }
            _loc_3 = this.xml.mapData[0];
            _loc_4 = int(_loc_3.yStart);
            this.mapW = int(_loc_3.wCount);
            this.mapH = int(_loc_3.hCount);
            _loc_5 = String(_loc_3.data).split(",");
            _loc_6 = new ByteArray();
            for each (_loc_7 in _loc_5)
            {
                
                _loc_6.writeUnsignedInt(int("0x" + _loc_7));
            }
            _loc_6.uncompress();
            this.barriers = [];
            while (this.barriers.length <= this.mapH)
            {
                
                this.barriers.push([]);
            }
            var _loc_8:int = 0;
            var _loc_9:* = _loc_4;
            while (_loc_9 < this.mapH)
            {
                
                _loc_12 = 0;
                while (_loc_12 < this.mapW)
                {
                    
                    this.barriers[_loc_9][_loc_12] = _loc_6[_loc_8++];
                    _loc_12++;
                }
                _loc_9++;
            }
            if (this._funComplete is Function)
            {
                this._funComplete(this);
            }
            this._funComplete = null;
            return;
        }// end function

        public function set onComplete(param1:Function) : void
        {
            if (this.xml)
            {
                setTimeout(param1, 10, this);
            }
            else
            {
                this._funComplete = param1;
            }
            return;
        }// end function

    }
}
