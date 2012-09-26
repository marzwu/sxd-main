package com.assist.view.interfaces.factionWar
{
    import flash.display.*;

    public interface IFactionWarSignUp extends IContent, IDragTitleBar
    {

        public function IFactionWarSignUp();

        function set onClose(param1:Function) : void;

        function set onSignUp(param1:Function) : void;

        function set onSee(param1:Function) : void;

        function set btnSignUpVisible(param1:Boolean) : void;

        function set TFNumMsg(param1:String) : void;

        function get btnWin1() : DisplayObject;

        function get btnWin2() : DisplayObject;

    }
}
