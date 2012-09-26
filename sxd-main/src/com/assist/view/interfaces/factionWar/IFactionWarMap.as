package com.assist.view.interfaces.factionWar
{

    public interface IFactionWarMap extends IMap
    {

        public function IFactionWarMap();

        function set onWar(param1:Function) : void;

        function initFactionList(param1:Array) : void;

        function startFactionWar() : void;

        function updatePlayerWarState(param1:int) : void;

    }
}
