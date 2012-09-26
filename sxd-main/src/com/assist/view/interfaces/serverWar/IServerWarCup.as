package com.assist.view.interfaces.serverWar
{
    import com.assist.view.info.*;
    import flash.display.*;
    import flash.text.*;

    public interface IServerWarCup extends IContent
    {

        public function IServerWarCup();

        function init(param1:ServerWarInfo) : void;

        function set onRecord(param1:Function) : void;

        function set onSee(param1:Function) : void;

        function set onRoleMsg(param1:Function) : void;

        function set onPack(param1:Function) : void;

        function set onUpgrade(param1:Function) : void;

        function set onDeploy(param1:Function) : void;

        function set onResearch(param1:Function) : void;

        function set onFate(param1:Function) : void;

        function set onSealSoul(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function set onBet(param1:Function) : void;

        function set onTianBan(param1:Function) : void;

        function set onDiBan(param1:Function) : void;

        function set onLink(param1:Function) : void;

        function set onChat(param1:Function) : void;

        function get chatMark() : Sprite;

        function showMineRecord(param1:ServerWarInfo) : void;

        function showSeeRecord(param1:ServerWarInfo) : void;

        function reset() : void;

        function closeBet() : void;

        function get tfTime() : TextField;

        function get tfIngot() : TextField;

        function get tfCoins() : TextField;

    }
}
