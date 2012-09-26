package com.assist.view.interfaces
{
    import com.assist.data.mission.*;
    import com.haloer.net.*;
    import flash.display.*;
    import flash.geom.*;

    public interface IWar
    {

        public function IWar();

        function set isAdvancedTester(param1:Boolean) : void;

        function get content() : Sprite;

        function set inGame(param1:Boolean) : void;

        function set isStrategy(param1:Boolean) : void;

        function set warType(param1:String) : void;

        function set tip(param1:ITip) : void;

        function set alert(param1:IAlert) : void;

        function get width() : Number;

        function get height() : Number;

        function set playerId(param1:int) : void;

        function set leaderId(param1:int) : void;

        function set nickName(param1:String) : void;

        function set roleId(param1:int) : void;

        function set playerRoleId(param1:int) : void;

        function set mainRoleStunt(param1:Object) : void;

        function set warData(param1:WarData) : void;

        function set warIcon(param1:Bitmap) : void;

        function set background(param1:BitmapData) : void;

        function set warResources(param1:File) : void;

        function set roleBitmapDatas(param1:Object) : void;

        function set assetsUrl(param1:String) : void;

        function set iconsUrl(param1:String) : void;

        function get iconsUrl() : String;

        function set goodsIconUrl(param1:String) : void;

        function get goodsIconUrl() : String;

        function set reportUrl(param1:String) : void;

        function set autoClose(param1:Boolean) : void;

        function set copyReportEnabled(param1:Boolean) : void;

        function set onSendChat(param1:Function) : void;

        function set onCopy(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onWin(param1:Function) : void;

        function set sportDetailUrl(param1:String) : void;

        function set sportDetailData(param1:Object) : void;

        function set onSportDetail(param1:Function) : void;

        function set onSportDetailLink(param1:Function) : void;

        function set sportReportUrl(param1:String) : void;

        function set sportAwardText(param1:String) : void;

        function set autoWar(param1:Boolean) : void;

        function set compareStrengthVisible(param1:Boolean) : void;

        function set onCompareStrength(param1:Function) : void;

        function set equitData(param1:Object) : void;

        function init() : void;

        function replay() : void;

        function close() : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

    }
}
