package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IAudience
    {

        public function IAudience();

        function get content() : MovieClip;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set onGetAudience(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set audienceData(param1:Object) : void;

        function close() : void;

        function set isOpenPk(param1:Boolean) : void;

        function set onChatShow(param1:Function) : void;

        function set onShowPerson(param1:Function) : void;

        function set onButtleFriend(param1:Function) : void;

        function set onMoveFriend(param1:Function) : void;

        function set onSendFlower(param1:Function) : void;

        function set isOnLine(param1:Object) : void;

    }
}
