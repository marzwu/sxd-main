package com.assist.view.interfaces.map
{

    public interface IFactionBossSelect extends IContent, IDragTitleBar
    {

        public function IFactionBossSelect();

        function setSelectDefault(param1:int = 5, param2:int = 6) : void;

        function setSelectMsg(param1:int, param2:String) : void;

        function setSelectEnabled(param1:int, param2:Boolean) : void;

        function set See(param1:Boolean) : void;

        function set onClose(param1:Function) : void;

        function set onOk(param1:Function) : void;

    }
}
