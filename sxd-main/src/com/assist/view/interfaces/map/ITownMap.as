package com.assist.view.interfaces.map
{
    import com.assist.view.info.*;
    import flash.display.*;

    public interface ITownMap extends IMap
    {

        public function ITownMap();

        function set onBuildClick(param1:Function) : void;

        function set onNpcSpeak(param1:Function) : void;

        function set onPortal(param1:Function) : void;

        function set onNpcRange(param1:Function) : void;

        function set onMapClick(param1:Function) : void;

        function moveToPortal(param1:Boolean) : void;

        function moveToNPCAtId(param1:int) : void;

        function setNpcGetVisible(param1:int, param2:Boolean) : void;

        function setNPCHead(param1:int, param2:int) : NPCInfo;

        function resetNPCHead(param1:Object) : void;

        function getBuildTarget(param1:int) : Sprite;

        function set otherCount(param1:int) : void;

        function set otherVisible(param1:Boolean) : void;

        function set upTipLayer(param1:Sprite) : void;

        function moveToBuildId(param1:int) : void;

        function set onWarFactionMonster(param1:Function) : void;

    }
}
