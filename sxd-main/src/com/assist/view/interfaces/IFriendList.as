package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IFriendList
    {

        public function IFriendList();

        function get content() : MovieClip;

        function get width() : Number;

        function get height() : Number;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set getPlayerData(param1:Object) : void;

        function set onInvitation(param1:Function) : void;

        function set isShowInvitation(param1:Boolean) : void;

        function set getFriendList(param1:Array) : void;

        function set onMsgOpen(param1:Function) : void;

        function set onFriend(param1:Function) : void;

        function set onOpenFriendType(param1:String) : void;

        function set isOpenPk(param1:Boolean) : void;

        function set onAudience(param1:Function) : void;

        function set isOpenSendFlower(param1:Boolean) : void;

        function set onSendFlower(param1:Function) : void;

        function set onRecent(param1:Function) : void;

        function set isMerge(param1:Boolean) : void;

        function set onBlackList(param1:Function) : void;

        function set isOnLine(param1:Object) : void;

        function set onShowPerson(param1:Function) : void;

        function set friendMsgNum(param1:Object) : void;

        function set onButtleFriend(param1:Function) : void;

        function set onAddInfo(param1:Function) : void;

        function set onDeleteFriend(param1:Function) : void;

        function set onMoveFriend(param1:Function) : void;

        function set addFriendInfo(param1:String) : void;

        function close() : void;

        function set onClose(param1:Function) : void;

        function set onChatShow(param1:Function) : void;

        function set onAddFavourite(param1:Function) : void;

        function set onCancelFavourite(param1:Function) : void;

    }
}
