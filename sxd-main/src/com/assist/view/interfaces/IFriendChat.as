package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IFriendChat
    {

        public function IFriendChat();

        function get content() : MovieClip;

        function init() : void;

        function set onClearFriend(param1:Function) : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set isShowSendFlower(param1:Boolean) : void;

        function set onSendFlower(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onTip(param1:Function) : void;

        function set onShowPerson(param1:Function) : void;

        function set onBlackList(param1:Function) : void;

        function set onButtleFriend(param1:Function) : void;

        function set onDeleteFriend(param1:Function) : void;

        function set onAddFriend(param1:Function) : void;

        function clear() : void;

        function set getPlayerInfo(param1:Object) : void;

        function set onlineState(param1:Object) : void;

        function btnState(param1:int, param2:int) : void;

        function set onSendChat(param1:Function) : void;

        function getChatList(param1:Array, param2:int) : void;

        function getChatData(param1:Object, param2:int) : void;

        function set onEnterState(param1:Function) : void;

        function getFriendEnterState(param1:int, param2:int) : void;

    }
}
