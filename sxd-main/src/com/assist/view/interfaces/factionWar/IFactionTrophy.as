package com.assist.view.interfaces.factionWar
{

    public interface IFactionTrophy extends IContent, IDragTitleBar
    {

        public function IFactionTrophy();

        function set onOK(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function get select1() : String;

        function get select2() : String;

        function get select3() : String;

        function resetSelect(param1:Array) : void;

    }
}
