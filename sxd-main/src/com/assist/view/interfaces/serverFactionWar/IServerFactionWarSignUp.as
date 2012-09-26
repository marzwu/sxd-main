package com.assist.view.interfaces.serverFactionWar
{
    import flash.display.*;

    public interface IServerFactionWarSignUp extends IContent, IDragTitleBar
    {

        public function IServerFactionWarSignUp();

        function set onSignUp(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function set onSeeWorld(param1:Function) : void;

        function set signUpMsg(param1:String) : void;

        function set ruleMsg(param1:String) : void;

        function set giftMsg(param1:String) : void;

        function set giftTip(param1:String) : void;

        function set titleMsg(param1:String) : void;

        function set seeWorldMsg(param1:String) : void;

        function set signupBtnVisible(param1:Boolean) : void;

        function initSeeWorld(param1:String, param2:Array, param3:Sprite) : void;

    }
}
