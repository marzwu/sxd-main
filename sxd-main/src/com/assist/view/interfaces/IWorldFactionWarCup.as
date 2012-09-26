package com.assist.view.interfaces
{
    import com.assist.view.info.*;
    import flash.text.*;

    public interface IWorldFactionWarCup extends IContent
    {

        public function IWorldFactionWarCup();

        function set onClose(param1:Function) : void;

        function set onLink(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function set onTianBang(param1:Function) : void;

        function set onDiBang(param1:Function) : void;

        function set onBet(param1:Function) : void;

        function set onRecord(param1:Function) : void;

        function set onSee(param1:Function) : void;

        function get tfIngot() : TextField;

        function get tfCoins() : TextField;

        function init(param1:WorldFactionWarInfo) : void;

        function closeBet() : void;

        function reset() : void;

        function showMember(param1:Array, param2:int) : void;

        function showSeeRecord(param1:Array) : void;

        function showRecord(param1:Array, param2:String) : void;

    }
}
