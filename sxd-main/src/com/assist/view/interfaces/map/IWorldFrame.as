package com.assist.view.interfaces.map
{
    import com.assist.view.info.*;

    public interface IWorldFrame extends IContent
    {

        public function IWorldFrame();

        function pass(param1:int) : void;

        function set playerInfo(param1:PlayerInfo) : void;

        function updateBodyUrl(param1:String = null) : void;

        function move(param1:int, param2:int) : void;

        function moveTo(param1:int, param2:int, param3:int = 0) : void;

        function set dir(param1:int) : void;

        function get dir() : int;

    }
}
