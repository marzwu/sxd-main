package com.assist.view.interfaces.map
{

    public interface IMissionGet extends IContent
    {

        public function IMissionGet();

        function get boxList() : Array;

        function set onPickup(param1:Function) : void;

        function set onPickupClose(param1:Function) : void;

    }
}
