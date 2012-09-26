package com.assist.view.interfaces.map
{
    import com.assist.view.info.*;
    import flash.display.*;

    public interface IBeelzebubTrialsMap extends IMap
    {

        public function IBeelzebubTrialsMap();

        function set onMapClick(param1:Function) : void;

        function set onWar(param1:Function) : void;

        function movePlayerToBoss() : void;

        function setFollowChange(param1:int, param2:int) : void;

        function set leaderId(param1:int) : void;

        function getPlayerInStage(param1:PlayerInfo) : Boolean;

        function set canWar(param1:Boolean) : void;

        function set errTip(param1:Function) : void;

        function set mcLeader(param1:MovieClip) : void;

        function set bossSayContent(param1:Array) : void;

    }
}
