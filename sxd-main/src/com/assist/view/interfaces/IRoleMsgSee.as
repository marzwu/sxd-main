package com.assist.view.interfaces
{
    import com.assist.view.info.*;
    import flash.display.*;
    import flash.text.*;

    public interface IRoleMsgSee extends IContent, IBoxPack, IDragTitleBar
    {

        public function IRoleMsgSee();

        function set onClose(param1:Function) : void;

        function set onLabel(param1:Function) : void;

        function set onSeeRoleInfo(param1:Function) : void;

        function set onStrength(param1:Function) : void;

        function set onFlowers(param1:Function) : void;

        function get selected() : RoleInfo;

        function initHeroNameList(param1:Array) : void;

        function updateRoleMsg() : void;

        function set onTip(param1:Function) : void;

        function get bodyCanvas() : Sprite;

        function get mcFlowers() : Sprite;

        function get mcFate() : Sprite;

        function get mcFateText() : TextField;

        function get tfDuJie() : TextField;

    }
}
