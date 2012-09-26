package com.assist.view.interfaces
{

    public interface IWarPage extends IContent, IDragTitleBar
    {

        public function IWarPage();

        function set info(param1:Array) : void;

        function onDekaron(param1:Function) : void;

        function onGetReward(param1:Function) : void;

        function onRecord(param1:Function) : void;

        function setRecordInfo(param1:Array) : void;

    }
}
