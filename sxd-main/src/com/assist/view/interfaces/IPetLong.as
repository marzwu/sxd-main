package com.assist.view.interfaces
{
    import com.assist.view.info.*;

    public interface IPetLong extends IContent, IDragTitleBar
    {

        public function IPetLong();

        function set onClose(param1:Function) : void;

        function set onCoin(param1:Function) : void;

        function set onIngot(param1:Function) : void;

        function set onUpLv(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function updatePet(param1:PetLongInfo) : void;

    }
}
