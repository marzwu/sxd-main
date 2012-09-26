package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IRoleDetailInfo
    {

        public function IRoleDetailInfo();

        function get content() : MovieClip;

        function set onClose(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set playerLevel(param1:int) : void;

        function clear() : void;

        function renderDetailInfo(param1:Object) : void;

        function init() : void;

    }
}
