package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.text.*;

    public interface ITraining extends IContent, IDragTitleBar
    {

        public function ITraining();

        function playSaveOK() : void;

        function get radioIdx() : int;

        function set onClose(param1:Function) : void;

        function set onPeiyang(param1:Function) : void;

        function set onSave(param1:Function) : void;

        function set onCancel(param1:Function) : void;

        function set radio(param1:int) : void;

        function set headIcon(param1:Sprite) : void;

        function get tfCoin() : TextField;

        function get tfIngot1() : TextField;

        function get tfIngot2() : TextField;

        function get tfIngot3() : TextField;

        function get tfIngot4() : TextField;

        function get tfIngot5() : TextField;

        function set favItemVisible(param1:Boolean) : void;

        function get tfName() : TextField;

        function get tfLv() : TextField;

        function set onTip(param1:Function) : void;

        function set favItemNum(param1:int) : void;

        function setProperty(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int, param7:String, param8:String, param9:String, param10:int, param11:int, param12:int, param13:Boolean, param14:Boolean) : void;

    }
}
