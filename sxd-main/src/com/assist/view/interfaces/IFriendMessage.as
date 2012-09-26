package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface IFriendMessage
    {

        public function IFriendMessage();

        function get content() : MovieClip;

        function init() : void;

        function clear() : void;

        function set changeEndPoint(param1:int) : void;

        function set additionalHeight(param1:int) : void;

        function set onOpenFriend(param1:Function) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

        function set geMessageList(param1:Array) : void;

        function set geMessageData(param1:Object) : void;

        function set addSingularMissage(param1:Object) : void;

        function set clearAble(param1:int) : void;

        function set onOpenFriendList(param1:Function) : void;

        function set onShowMost(param1:Function) : void;

        function set onClearAll(param1:Function) : void;

        function clearMostMessage() : void;

    }
}
