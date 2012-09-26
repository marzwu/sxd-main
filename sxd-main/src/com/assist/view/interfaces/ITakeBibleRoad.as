package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface ITakeBibleRoad
    {

        public function ITakeBibleRoad();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set onClose(param1:Function) : void;

        function set onOpenReady(param1:Function) : void;

        function set callRuLaiState(param1:Object) : void;

        function set vipLevel(param1:int) : void;

        function set isShowBaiMa(param1:Boolean) : void;

        function set onShowBaiMa(param1:Function) : void;

        function clear() : void;

        function get isCdTime() : Boolean;

        function set onMaxSpeedUp(param1:Function) : void;

        function set isUserProtection(param1:int) : void;

        function set getStartTime(param1:String) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

        function isUserSpeedUp() : void;

        function set renderIngot(param1:Number) : void;

        function set renderCoins(param1:Number) : void;

        function TakeBibleRoadData(param1:Object) : void;

        function set onSpeedUp(param1:Function) : void;

        function set takeBibleStatus(param1:int) : void;

        function set getSystemInfo(param1:Object) : void;

        function set onTextLink(param1:Function) : void;

        function set cdTime(param1:Object) : void;

        function set onRefreshCdTime(param1:Function) : void;

        function returnTakeBibleRoadData(param1:Object) : void;

        function set onClearCdTime(param1:Function) : void;

        function set onRob(param1:Function) : void;

        function set onPlayerData(param1:Function) : void;

        function set getTakeBibleTeamList(param1:Array) : void;

        function set onMouseOver(param1:Function) : void;

        function set onMouseOut(param1:Function) : void;

        function set getTakeBibleTeamData(param1:Object) : void;

        function set playerData(param1:Object) : void;

        function clearTeam(param1:int, param2:Boolean) : void;

        function set onMoveEnd(param1:Function) : void;

        function set changeTime(param1:Object) : void;

        function set onRuLaiReady(param1:Function) : void;

        function set getRuLaiData(param1:Object) : void;

        function set getStartRuLaiData(param1:Object) : void;

    }
}
