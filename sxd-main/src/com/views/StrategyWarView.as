package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.war.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import flash.display.*;
    import flash.net.*;

    public class StrategyWarView extends Base implements IView
    {
        public var warType:String;
        public var version:String;
        public var nickName:String;
        public var reportId:int;
        public var missionId:int;
        public var background:BitmapData;
        public var onSendChat:Function;
        private var _connector:Connector;
        private var _war:File;
        public var onClose:Function;
        public var _opened:Boolean = false;
        public var isServerWar:Boolean = false;
        public var sameServer:Boolean = false;
        public var onWarClose:Function;
        public var wfWarData:Array;
        private var _reportArgs:Array;

        public function StrategyWarView() : void
        {
            this._reportArgs = [];
            this._connector = new Connector();
            this._connector.name = "strategy_connector";
            this._connector.assetsUrl = URI.assetsUrl;
            this._connector.onClose = function (param1:int) : void
            {
                _connector.warData = null;
                _connector.wfWarData = null;
                _connector.background = null;
                _connector.reportUrl = "";
                _connector.onSendChat = null;
                if (_war && _war.loader && _war.loader.parent)
                {
                    _popup.removeChild(_war.loader);
                }
                if (onClose is Function)
                {
                    onClose();
                }
                _popup.removeMask();
                _opened = false;
                isServerWar = false;
                if (onWarClose is Function)
                {
                    onWarClose();
                }
                if (Connector.Exception == param1)
                {
                    _view.alert.confirm(StrategyWarViewLang.Exception);
                }
                else if (Connector.HasNotSwf == param1)
                {
                    _view.alert.confirm(StrategyWarViewLang.HasNotSwf);
                }
                return;
            }// end function
            ;
            return;
        }// end function

        public function get opened() : Boolean
        {
            return this._opened;
        }// end function

        public function show() : void
        {
            this._opened = true;
            this._connector.sameServer = this.warType != WarType.ServerWar || this.sameServer;
            this._connector.playerId = _ctrl.player.playerId;
            this._connector.nickName = _ctrl.player.nickname;
            this._connector.roleId = _ctrl.player.mainRoleId;
            this._connector.playerRoleId = _ctrl.player.mainPlayerRoleId;
            this._connector.defenderNickName = this.nickName;
            this._connector.missionId = this.missionId;
            this._connector.background = this.background;
            this._connector.showLoading = _view.showLoading;
            this._connector.hideLoading = _view.hideLoading;
            this._connector.reportUrl = this.reportUrl;
            this._connector.onSendChat = this.onSendChat;
            this._connector.onVersion = URI.getVersion;
            this._connector.getItemSuffix = ItemType.getItemSuffix;
            this._connector.wfWarData = this.wfWarData || getWFWarData();
            _view.stage.addChild(this._connector);
            this.loadResource();
            return;
        }// end function

        private function loadResource() : void
        {
            var self:StrategyWarView;
            self;
            _popup.addMask(true);
            this._connector.warData = _ctrl.mission.strategyWarData;
            this._war = new File();
            this._war.useNewDomain = true;
            this._war.onProgress = function (param1:Number, param2:Number) : void
            {
                _view.showLoading(StrategyWarViewLang.LoadInfo, Math.floor(param2 / param1 * 100));
                return;
            }// end function
            ;
            this._war.onError = function () : void
            {
                _view.hideLoading();
                _connector.onClose(Connector.HasNotSwf);
                return;
            }// end function
            ;
            this._war.onComplete = function () : void
            {
                try
                {
                    _popup.addChild(_war.loader);
                }
                catch (e)
                {
                    _connector.onClose();
                }
                _view.chat.updateDepth(self);
                _view.friendMessage.updateDepth(self);
                return;
            }// end function
            ;
            this.version = this.version || Config.GameVersion;
            var url:* = "strategy_war/" + this.version + ".swf";
            var clientUrl:* = URI.clientUrl.replace(/\/201\d\d{2}\d{2}\d{2}\/""\/201\d\d{2}\d{2}\d{2}\//, "/" + this.version + "/");
            var serverUrl:* = this.isServerWar ? (URI.worldWarServerUrl) : (URI.serverUrl);
            if (this.warType == WarType.WorldFactionWar)
            {
                serverUrl = URI.worldFactionWarUrl;
            }
            else if (this.warType == WarType.TopWarWar)
            {
                serverUrl = this.isServerWar ? (URI.worldTopWarWarServerUrl) : (URI.serverUrl);
            }
            var v:* = new URLVariables();
            v.w = this.warType;
            v.s = serverUrl;
            v.r = this.reportId;
            v.m = this.missionId;
            v.c = URI.getVersion(URI.assetsUrl + url);
            v.client_url = clientUrl;
            this._connector.url = URI.fullAssetsUrl.replace(/\/201\d\d{2}\d{2}\d{2}\/""\/201\d\d{2}\d{2}\d{2}\//, "/" + this.version + "/") + url + "?" + v.toString();
            this._connector.warType = this.warType;
            this._connector.serverUrl = serverUrl;
            this._connector.reportId = this.reportId;
            this._connector.missionId = this.missionId;
            this._connector.swfVersion = URI.getVersion(URI.assetsUrl + url);
            this._connector.clientUrl = clientUrl;
            url = URI.fullAssetsUrl.replace(/\/201\d\d{2}\d{2}\d{2}\/""\/201\d\d{2}\d{2}\d{2}\//, "/" + this.version + "/") + url + "?v=" + URI.getVersion(URI.assetsUrl + url);
            if (Config.EnableProtocolHelper == true)
            {
                url = URI.assetsUrl + "strategy_war/StrategyWar.swf";
            }
            this._war.load(url);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function get reportArgs() : Array
        {
            return this._reportArgs;
        }// end function

        public function get reportUrl() : String
        {
            var _loc_2:String = null;
            this._reportArgs = [this.version, this.warType, this.reportId, this.missionId, _loc_2];
            var _loc_1:* = "strategy_war/" + this.version + ".swf";
            _loc_2 = URI.getVersion(URI.assetsUrl + _loc_1);
            var _loc_3:* = new URLVariables();
            _loc_3.v = this.version;
            _loc_3.w = this.warType;
            _loc_3.s = this.isServerWar ? (URI.worldWarServerUrl) : (URI.serverUrl);
            _loc_3.r = this.reportId;
            _loc_3.m = this.missionId;
            _loc_3.c = _loc_2;
            return URI.serverUrl + "war.php?" + _loc_3.toString();
        }// end function

    }
}

class Connector extends Sprite
{
    public var url:String;
    public var assetsUrl:String;
    public var warData:ByteArray;
    public var sameServer:Boolean;
    public var background:BitmapData;
    public var playerId:int;
    public var nickName:String;
    public var roleId:int;
    public var playerRoleId:int;
    public var reportUrl:String;
    public var onSendChat:Function;
    public var onVersion:Function;
    public var getItemSuffix:Function;
    public var defenderNickName:String;
    public var missionId:int;
    public var onClose:Function;
    public var showLoading:Function;
    public var hideLoading:Function;
    public var warType:String;
    public var serverUrl:String;
    public var reportId:int;
    public var swfVersion:String;
    public var clientUrl:String;
    public var wfWarData:Array;
    public static const HasNotSwf:int = 1;
    public static const Exception:int = 2;

    function Connector()
    {
        return;
    }// end function

    public function close(param1:int = 0) : void
    {
        if (this.onClose is Function)
        {
            this.onClose(param1);
        }
        return;
    }// end function

}

