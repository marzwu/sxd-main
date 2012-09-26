package com.assist.view.interfaces.map
{

    public interface IWorldBossMap extends IMap
    {

        public function IWorldBossMap();

        function set onMapClick(param1:Function) : void;

        function set onWar(param1:Function) : void;

        function set zhangAiVisible(param1:Boolean) : void;

        function movePlayerToBoss() : void;

        function warClose(param1:Boolean) : void;

        function updatePlayerState(param1:int) : void;

        function bossKill() : void;

        function bossMoveto(param1:int, param2:int) : void;

    }
}
