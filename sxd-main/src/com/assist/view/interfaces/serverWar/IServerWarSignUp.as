package com.assist.view.interfaces.serverWar
{
    import flash.display.*;

    public interface IServerWarSignUp extends IContent, IDragTitleBar
    {

        public function IServerWarSignUp();

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
