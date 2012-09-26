package com.assist.view.interfaces
{
    import flash.display.*;

    public interface ICheckFaction
    {

        public function ICheckFaction();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set joinFactionType(param1:Boolean) : void;

        function set onApply(param1:Function) : void;

        function set onSendFlower(param1:Function) : void;

        function set getFactionPersonList(param1:Array) : void;

        function set checkFactionData(param1:Object) : void;

        function set onPersonCheck(param1:Function) : void;

        function set onSendMessige(param1:Function) : void;

        function set onAddFriend(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function clear() : void;

        function close() : void;

    }
}
