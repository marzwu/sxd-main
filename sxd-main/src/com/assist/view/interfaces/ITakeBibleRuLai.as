package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ITakeBibleRuLai
    {

        public function ITakeBibleRuLai();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onClose(param1:Function) : void;

        function set onCall(param1:Function) : void;

        function set ruLaiData(param1:Array) : void;

        function render() : void;

        function clear() : void;

        function set memberNum(param1:int) : void;

        function set onZhaoHuan(param1:Function) : void;

        function set awardstate(param1:Number) : void;

        function set isCalled(param1:Boolean) : void;

        function set ingot(param1:int) : void;

        function set showMessage(param1:Function) : void;

        function set canCallruLaiTime(param1:int) : void;

    }
}
