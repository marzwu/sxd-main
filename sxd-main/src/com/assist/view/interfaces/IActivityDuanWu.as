package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IActivityDuanWu
    {

        public function IActivityDuanWu();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function set onZhongzi(param1:Function) : void;

        function set onQuYuan(param1:Function) : void;

        function set onCaiQuan(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function caiQuanState(param1:Object) : void;

        function quYuanState(param1:Object) : void;

        function zhongZhiState(param1:Object) : void;

    }
}
