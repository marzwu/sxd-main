package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IJoinFaction
    {

        public function IJoinFaction();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function factionData(param1:Array, param2:int, param3:int, param4:String, param5:Boolean) : void;

        function set onCreate(param1:Function) : void;

        function set joinFactionType(param1:Boolean) : void;

        function set onPage(param1:Function) : void;

        function set onApplyIng(param1:Function) : void;

        function set onApply(param1:Function) : void;

        function set onSendFlower(param1:Function) : void;

        function set onRevok(param1:Function) : void;

        function set foundFactionCoin(param1:String) : void;

        function set onSelect(param1:Function) : void;

        function set onPk(param1:Function) : void;

        function set getFactionPersonList(param1:Array) : void;

        function set onCheckFaction(param1:Function) : void;

        function set checkFactionData(param1:Object) : void;

        function set onPersonCheck(param1:Function) : void;

        function set onSendMessige(param1:Function) : void;

        function set onAddFriend(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function clear() : void;

        function close() : void;

    }
}
