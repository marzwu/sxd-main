package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IFuranceRoleDialog extends IDragTitleBar
    {

        public function IFuranceRoleDialog();

        function get content() : MovieClip;

        function openDialog(param1:Object) : void;

        function openSendItem(param1:Object, param2:int = 0) : void;

        function onOpenSend(param1:Function) : void;

        function onClose(param1:Function) : void;

        function onSendItem(param1:Function) : void;

        function onLevelUp(param1:Function) : void;

        function set onTip(param1:Function) : void;

    }
}
