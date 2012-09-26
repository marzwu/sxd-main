package com.assist.view.interfaces
{
    import com.assist.view.interfaces.map.*;
    import flash.display.*;
    import flash.geom.*;

    public interface INewWorld
    {

        public function INewWorld();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set alert(param1:IAlert) : void;

        function set logoVisible(param1:Boolean) : void;

        function set onArrive(param1:Function) : void;

        function set onTownClick(param1:Function) : void;

        function set defaultTown(param1:String) : void;

        function autoTown(param1:Array) : void;

        function set townOpened(param1:Array) : void;

        function set townAllowed(param1:Array) : void;

        function set townInfo(param1:Array) : void;

        function playerPosition(param1:String, param2:IWorldFrame) : void;

        function set onClose(param1:Function) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

        function clear() : void;

        function close() : void;

        function set onClickGoTo(param1:Function) : void;

        function showDoor(param1:Boolean) : void;

        function hiddenThis() : void;

        function showThis() : void;

    }
}
