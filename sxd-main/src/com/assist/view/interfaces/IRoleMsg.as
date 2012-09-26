package com.assist.view.interfaces
{
    import com.assist.view.info.*;
    import flash.display.*;
    import flash.text.*;

    public interface IRoleMsg extends IContent, IBoxPack, IDragTitleBar
    {

        public function IRoleMsg();

        function set onClose(param1:Function) : void;

        function set onLabel(param1:Function) : void;

        function set onTraining(param1:Function) : void;

        function set onFate(param1:Function) : void;

        function set onFire(param1:Function) : void;

        function set onGenSui(param1:Function) : void;

        function set onDanYao(param1:Function) : void;

        function set onFlower(param1:Function) : void;

        function set onChuanCheng(param1:Function) : void;

        function set onSeeRoleInfo(param1:Function) : void;

        function set onPetShow(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function set onYaoQing(param1:Function) : void;

        function set onDuJie(param1:Function) : void;

        function set onDuJieAdd(param1:Function) : void;

        function get selected() : RoleInfo;

        function initHeroNameList(param1:Array) : void;

        function updateRoleMsg() : void;

        function get btnTraining() : DisplayObject;

        function get btnDueJie() : DisplayObject;

        function get btnPoint() : DisplayObject;

        function get mcFate() : Sprite;

        function get tfFate() : TextField;

        function get tfFame() : TextField;

        function get bodyCanvas() : Sprite;

        function resetDuJie() : void;

        function updateDuJie(param1:int, param2:String, param3:int) : void;

    }
}
