package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ICatHunt
    {

        public function ICatHunt();

        function get content() : MovieClip;

        function clear() : void;

        function set onMapCheck(param1:Function) : void;

        function set onMapIngotCheck(param1:Function) : void;

        function set onShowTip(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set checkMapAwardData(param1:Object) : void;

        function forStandBy() : void;

        function getAwardData(param1:Object, param2:Boolean) : void;

        function set checkMapAwardState(param1:int) : void;

        function mapCheckAward() : void;

    }
}
