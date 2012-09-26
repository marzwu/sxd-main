package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IAlert
    {

        public function IAlert();

        function get content() : Sprite;

        function set oParent(param1:Sprite) : void;

        function set tip(param1:ITip) : void;

        function set yesLabel(param1:String) : void;

        function set noLabel(param1:String) : void;

        function set cancelLabel(param1:String) : void;

        function set yesEnabled(param1:Boolean) : void;

        function set noEnabled(param1:Boolean) : void;

        function set cancelEnabled(param1:Boolean) : void;

        function set yesLabelTip(param1:String) : void;

        function set noLabelTip(param1:String) : void;

        function set cancelLabelTip(param1:String) : void;

        function set hasCheckbox(param1:Boolean) : void;

        function get checked() : Boolean;

        function get visible() : Boolean;

        function show(param1:String, param2:uint = 1, param3:Function = null) : void;

        function hide() : void;

        function updateContent(param1:String) : void;

        function defaultCloseEvent() : void;

        function reposition(param1:int, param2:int, param3:int, param4:int) : void;

    }
}
