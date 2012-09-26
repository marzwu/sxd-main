package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IRune
    {

        public function IRune();

        function get content() : MovieClip;

        function set onRuneSure(param1:Function) : void;

        function set onBatchRune(param1:Function) : void;

        function set onSetAutoRune(param1:Function) : void;

        function set isVip6(param1:Boolean) : void;

        function set isVip10(param1:Boolean) : void;

        function set batchRuneData(param1:Object) : void;

        function set autoRuneInfo(param1:Object) : void;

        function set runeInfo(param1:String) : void;

        function set sureBtnShow(param1:Boolean) : void;

        function set upGrade(param1:int) : void;

        function set onClose(param1:Function) : void;

        function close() : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

    }
}
