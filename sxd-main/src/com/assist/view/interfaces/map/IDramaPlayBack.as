package com.assist.view.interfaces.map
{

    public interface IDramaPlayBack extends IContent, IDragTitleBar
    {

        public function IDramaPlayBack();

        function initData(param1:Function, param2:Function, param3:XML) : void;

        function set onClose(param1:Function) : void;

        function set onSelect(param1:Function) : void;

    }
}
