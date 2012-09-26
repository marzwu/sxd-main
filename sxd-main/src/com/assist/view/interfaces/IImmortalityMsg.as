package com.assist.view.interfaces
{
    import com.assist.view.info.*;

    public interface IImmortalityMsg extends IContent, IDragTitleBar
    {

        public function IImmortalityMsg();

        function initData(param1:ImmortalityInfo) : void;

        function set onClose(param1:Function) : void;

        function set onFuYong(param1:Function) : void;

        function set onTip(param1:Function) : void;

    }
}
