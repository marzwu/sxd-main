package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.haloer.net.*;
    import com.protocols.*;
    import flash.net.*;
    import flash.utils.*;

    public class DramaWarView extends WarView implements IView
    {
        private var _tempData:ByteArray;

        public function DramaWarView() : void
        {
            _type = WarType.DramaWar;
            return;
        }// end function

        override public function show() : void
        {
            var http:HTTP;
            http = new HTTP(URLLoaderDataFormat.BINARY);
            http.onComplete = function () : void
            {
                _tempData = http.loader.data as ByteArray;
                loadResources();
                return;
            }// end function
            ;
            http.load(URI.assetsUrl + "war_demo_2011_02_17.17");
            return;
        }// end function

        private function formatWarData(param1:ByteArray) : void
        {
            var _loc_2:* = param1.readByte();
            var _loc_3:* = param1.readByte();
            var _loc_4:* = Protocol.analyze(param1, Mod_Mission_Base.fight_monster["response"]);
            var _loc_5:* = new WarData();
            new WarData().format(_loc_4);
            _warData = _loc_5;
            return;
        }// end function

        override protected function loadRoleResource() : void
        {
            this.formatWarData(this._tempData);
            super.loadRoleResource();
            return;
        }// end function

        override protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            param1.push("WarIcon");
            param2.push(URI.sportUrl + "war_icon.png");
            param1.push("Background");
            param2.push(URI.sportUrl + (Math.floor(Math.random() * 3) + 1) + ".swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            return;
        }// end function

    }
}
