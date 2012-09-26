package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IStudyStunt
    {

        public function IStudyStunt();

        function get content() : MovieClip;

        function set playerLevel(param1:int) : void;

        function set playerSeat(param1:Sprite) : void;

        function set iconUrl(param1:String) : void;

        function set onClose(param1:Function) : void;

        function set onStudyStunt(param1:Function) : void;

        function set onReturnTown(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function clear() : void;

        function init() : void;

        function renderPlayerStuntInfo(param1:Array, param2:Array, param3:Object) : void;

        function renderPlayStudyStunt(param1:Array, param2:Array, param3:Object, param4:String) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:Number) : void;

    }
}
