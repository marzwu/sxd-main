package com.assist.view.interfaces.map
{

    public interface IDramaManage extends IContent
    {

        public function IDramaManage();

        function get toWar() : Boolean;

        function set closeVisible(param1:Boolean) : void;

        function initXMLUrl(param1:String, param2:String, param3:String, param4:String) : void;

        function play(param1:Function = null, param2:Function = null) : void;

        function actionBackMask(param1:Number = 0) : void;

    }
}
