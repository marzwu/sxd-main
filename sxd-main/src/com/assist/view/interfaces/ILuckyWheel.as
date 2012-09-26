package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ILuckyWheel
    {

        public function ILuckyWheel();

        function get content() : MovieClip;

        function clear() : void;

        function set tip(param1:ITip) : void;

        function set state(param1:int) : void;

        function render() : void;

        function set onClose(param1:Function) : void;

        function set openInfo(param1:Object) : void;

        function set onStart(param1:Function) : void;

        function set awardInfo(param1:Object) : void;

        function set cardInfo(param1:Object) : void;

        function set showMessage(param1:Function) : void;

        function set onShowChat(param1:Function) : void;

        function set playerLevel(param1:int) : void;

        function movie() : void;

        function get isMovie() : Boolean;

        function set isMovieTip(param1:Function) : void;

        function set onGetItem(param1:Function) : void;

    }
}
