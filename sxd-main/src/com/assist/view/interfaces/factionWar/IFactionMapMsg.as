package com.assist.view.interfaces.factionWar
{

    public interface IFactionMapMsg extends IContent
    {

        public function IFactionMapMsg();

        function reset() : void;

        function toWait(param1:int) : void;

        function toWar(param1:int) : void;

        function toEnd(param1:Boolean, param2:Array) : void;

        function addMsgShow(param1:String) : void;

        function set TFName1(param1:String) : void;

        function set TFLv1(param1:int) : void;

        function set TFNum1(param1:int) : void;

        function set TFName2(param1:String) : void;

        function set TFLv2(param1:int) : void;

        function set TFNum2(param1:int) : void;

        function set TopIdx(param1:int) : void;

        function set WinIdx(param1:int) : void;

        function set onRankOK(param1:Function) : void;

        function set onCancel(param1:Function) : void;

        function set onCup(param1:Function) : void;

        function set factionCount(param1:int) : void;

    }
}
