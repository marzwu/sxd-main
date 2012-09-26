package com.assist.view.interfaces
{

    public interface IWorldFactionWarRecord extends IContent, IDragTitleBar
    {

        public function IWorldFactionWarRecord();

        function set onClose(param1:Function) : void;

        function set onLink(param1:Function) : void;

        function update(param1:String, param2:Array) : void;

    }
}
