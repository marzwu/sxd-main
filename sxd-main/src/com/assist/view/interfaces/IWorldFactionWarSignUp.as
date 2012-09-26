package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.text.*;

    public interface IWorldFactionWarSignUp extends IContent, IDragTitleBar
    {

        public function IWorldFactionWarSignUp();

        function showSeeWorld(param1:String, param2:Array, param3:Sprite) : void;

        function set signUpVisible(param1:Boolean) : void;

        function set btnVisible(param1:Boolean) : void;

        function set ruleMsg(param1:String) : void;

        function set onClose(param1:Function) : void;

        function set onSignUp(param1:Function) : void;

        function set onSee(param1:Function) : void;

        function set onSeeWorld(param1:Function) : void;

        function get tfGift() : TextField;

    }
}
