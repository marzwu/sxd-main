package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface IFate
    {

        public function IFate();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set fatePower(param1:int) : void;

        function set onClose(param1:Function) : void;

        function set loadImage(param1:Class) : void;

        function close() : void;

        function set onMergeAll(param1:Function) : void;

        function reposition(param1:Point) : void;

        function set onFateInfo(param1:Function) : void;

        function hideShive() : void;

        function set onOpenLodge(param1:Function) : void;

        function set onCheckPlayer(param1:Function) : void;

        function getPlayerList(param1:Array, param2:int) : void;

        function set getFateGridList(param1:Array) : void;

        function set getPlayerFate(param1:Array) : void;

        function set onSendType(param1:Function) : void;

        function set onBuyFateGrid(param1:Function) : void;

        function upPlayerLive() : void;

        function preload() : void;

        function set isShowExchange(param1:Boolean) : void;

        function FragmentNum(param1:int) : void;

    }
}
