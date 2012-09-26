package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IDuanWuWorship
    {

        public function IDuanWuWorship();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function clear() : void;

        function set coins(param1:int) : void;

        function set ingot(param1:int) : void;

        function set vipLevel(param1:int) : void;

        function dialogue() : void;

        function set onClose(param1:Function) : void;

        function set onWorship(param1:Function) : void;

        function set onTextLink(param1:Function) : void;

        function render() : void;

        function set recordAry(param1:Array) : void;

        function set isWorshiped(param1:int) : void;

        function set zongziNum(param1:int) : void;

    }
}
