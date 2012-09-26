package com.assist.view.interfaces.map
{
    import com.assist.view.interfaces.*;

    public interface IMiniMap extends IContent
    {

        public function IMiniMap();

        function set mapName(param1:String) : void;

        function set worldVisible(param1:Boolean) : void;

        function set settingVisible(param1:Boolean) : void;

        function set showVisible(param1:Boolean) : void;

        function set hideVisible(param1:Boolean) : void;

        function set gameHelpVisible(param1:Boolean) : void;

        function set onWorld(param1:Function) : void;

        function set onSetting(param1:Function) : void;

        function set onShow(param1:Function) : void;

        function set onHide(param1:Function) : void;

        function set onGameHelp(param1:Function) : void;

        function set tip(param1:ITip) : void;

    }
}
