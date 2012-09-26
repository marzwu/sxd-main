package com.assist.view.interfaces
{
    import flash.display.*;
    import flash.geom.*;

    public interface IChat
    {

        public function IChat();

        function set playerId(param1:int) : void;

        function set nickName(param1:String) : void;

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set onOpenGm(param1:Function) : void;

        function clear() : void;

        function set isOpenActivity(param1:Boolean) : void;

        function set isOpenFaction(param1:Boolean) : void;

        function getShieldPlayerInfo(param1:String, param2:int) : String;

        function isShieldPlayer(param1:Object) : Boolean;

        function set sendSelf(param1:Object) : void;

        function set changeChat(param1:int) : void;

        function set getRemoveSuffixData(param1:Function) : void;

        function set getChatData(param1:Array) : void;

        function directlyChatData(param1:String, param2:int, param3:Boolean) : void;

        function set onSendChat(param1:Function) : void;

        function set onTextLink(param1:Function) : void;

        function addMainShow(param1:String, param2:int, param3:Boolean) : void;

        function set visibleFunction(param1:int) : void;

        function set onCheckData(param1:Function) : void;

        function set onSendFriendChat(param1:Function) : void;

        function set getReceivePostList(param1:Array) : void;

        function set getTownPlaySay(param1:Array) : void;

        function set visiblePost(param1:Boolean) : void;

        function set onSendTownFile(param1:Function) : void;

        function set getPunishmentPostList(param1:String) : void;

        function getLaBaData(param1:Object) : void;

        function reposition(param1:int, param2:int, param3:int, param4:int, param5:Point) : void;

        function set changePoint(param1:int) : void;

        function set chatVisible(param1:Boolean) : void;

        function get chatVisible() : Boolean;

    }
}
