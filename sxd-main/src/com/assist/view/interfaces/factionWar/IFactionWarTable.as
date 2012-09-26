package com.assist.view.interfaces.factionWar
{
    import flash.display.*;

    public interface IFactionWarTable extends IContent, IDragTitleBar
    {

        public function IFactionWarTable();

        function set onInto(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set cupObj(param1:Object) : void;

        function set onSeeClick(param1:Function) : void;

        function set buttonEffect(param1:Sprite) : void;

        function set heroRank(param1:Array) : void;

        function set heroRankTip(param1:String) : void;

        function set onTextLink(param1:Function) : void;

        function set intoVisible(param1:Boolean) : void;

        function get jueSaiBtn() : DisplayObject;

    }
}
