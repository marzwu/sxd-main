package com.datas
{

    public class ChatData extends Base
    {
        public var message:Array;
        public var chatWithPlayers:Array;
        private var _disableTalk:Array;
        private var _shieldPlayerTalk:Array;
        private var _shieldPlayerList:Array;
        private var _favFriendAchievementMsg:Array;
        public var SendAll:Array;
        public var sendAllMessage:Array;

        public function ChatData()
        {
            this.message = [];
            this.chatWithPlayers = [];
            return;
        }// end function

        public function get disableTalk() : Array
        {
            return this._disableTalk;
        }// end function

        public function get shieldPlayerTalk() : Array
        {
            return this._shieldPlayerTalk;
        }// end function

        public function get shieldPlayerList() : Array
        {
            return this._shieldPlayerList;
        }// end function

        public function get favFriendAchievementMsg() : Array
        {
            return this._favFriendAchievementMsg;
        }// end function

        public function chat_with_players(param1:Array) : void
        {
            this.chatWithPlayers = param1;
            return;
        }// end function

        public function bro_to_player(param1:Array) : void
        {
            this.message = param1[0];
            return;
        }// end function

        public function disable_player_talk(param1:Array) : void
        {
            this._disableTalk = param1;
            return;
        }// end function

        public function shield_player_talk(param1:Array) : void
        {
            this._shieldPlayerTalk = param1;
            return;
        }// end function

        public function shield_player_list(param1:Array) : void
        {
            this._shieldPlayerList = param1[0];
            return;
        }// end function

        public function fav_friend_achievement_msg(param1:Array) : void
        {
            this._favFriendAchievementMsg = param1;
            return;
        }// end function

        public function send_all(param1:Array) : void
        {
            this.SendAll = param1;
            return;
        }// end function

        public function send_all_message(param1:Array) : void
        {
            this.sendAllMessage = param1;
            return;
        }// end function

    }
}
