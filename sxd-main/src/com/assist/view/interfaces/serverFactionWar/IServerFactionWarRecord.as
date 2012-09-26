package com.assist.view.interfaces.serverFactionWar
{

    public interface IServerFactionWarRecord extends IContent, IDragTitleBar
    {

        public function IServerFactionWarRecord();

        function set onClose(param1:Function) : void;

        function set onLink(param1:Function) : void;

        function update(param1:String, param2:String, param3:Array) : void;

    }
}
