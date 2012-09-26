package com.datas
{

    public class FriendData extends Base
    {
        private var _addFriend:Array;
        private var _addBlack:Array;
        private var _deleteFriend:Array;
        private var _moveFriend:Array;
        private var _updateSignature:Object;
        private var _getFriendList:Array;
        private var _getFriendInfo:Object;
        private var _messageCount:Object;
        private var _getGroup:Array;
        private var _onlineState:Object;
        private var _getPlayerinfo:Array;
        private var _getFriendinfoChatrecordList:Array;
        private var _receiveUnreceiveMessage:Array;
        private var _sendMessageToFriend:Array;
        private var _receiveMessageFromFriend:Array;
        private var _checkReceiveMessage:Array;
        private var _isInFriend:Array;
        private var _getListeners:Array;
        public var getUnreceiveFriendList:Array;
        public var messageBoxList:Array;
        public var notifyEnterState:Array;
        public var receiveFriendEnterState:Array;
        public var getVipList:Array;
        public var addFriendById:Array;
        public var addFavouriteFriend:Array;
        public var cancelFavouriteFriend:Array;

        public function FriendData()
        {
            return;
        }// end function

        public function get addFriend() : Array
        {
            return this._addFriend;
        }// end function

        public function get addBlack() : Array
        {
            return this._addBlack;
        }// end function

        public function get deleteFriend() : Array
        {
            return this._deleteFriend;
        }// end function

        public function get moveFriend() : Array
        {
            return this._moveFriend;
        }// end function

        public function get updateSignature() : Object
        {
            return this._updateSignature;
        }// end function

        public function get getFriendList() : Array
        {
            return this._getFriendList;
        }// end function

        public function get getFriendInfo() : Object
        {
            return this._getFriendInfo;
        }// end function

        public function get messageCount() : Object
        {
            return this._messageCount;
        }// end function

        public function get getGroup() : Array
        {
            return this._getGroup;
        }// end function

        public function get onlineState() : Object
        {
            return this._onlineState;
        }// end function

        public function get getPlayerinfo() : Array
        {
            return this._getPlayerinfo;
        }// end function

        public function get getFriendinfoChatrecordList() : Array
        {
            return this._getFriendinfoChatrecordList;
        }// end function

        public function get receiveUnreceiveMessage() : Array
        {
            return this._receiveUnreceiveMessage;
        }// end function

        public function get sendMessageToFriend() : Array
        {
            return this._sendMessageToFriend;
        }// end function

        public function get receiveMessageFromFriend() : Array
        {
            return this._receiveMessageFromFriend;
        }// end function

        public function get checkReceiveMessage() : Array
        {
            return this._checkReceiveMessage;
        }// end function

        public function get isInFriend() : Array
        {
            return this._isInFriend;
        }// end function

        public function get getListeners() : Array
        {
            return this._getListeners;
        }// end function

        public function add_friend(param1:Array) : void
        {
            this._addFriend = param1;
            return;
        }// end function

        public function add_to_black(param1:Array) : void
        {
            this._addBlack = param1;
            return;
        }// end function

        public function delete_friend(param1:Array) : void
        {
            this._deleteFriend = param1;
            return;
        }// end function

        public function move_friend(param1:Array) : void
        {
            this._moveFriend = param1;
            return;
        }// end function

        public function update_signature(param1:Object) : void
        {
            this._updateSignature = param1;
            return;
        }// end function

        public function get_friend_list(param1:Array) : void
        {
            this._getFriendList = param1;
            return;
        }// end function

        public function get_group(param1:Array) : void
        {
            this._getGroup = param1;
            return;
        }// end function

        public function get_friend_details_info(param1:Object) : void
        {
            this._getFriendInfo = param1;
            return;
        }// end function

        public function get_Playerinfo(param1:Array) : void
        {
            this._getPlayerinfo = param1;
            return;
        }// end function

        public function notify_message_count(param1:Array) : void
        {
            this._messageCount = param1;
            return;
        }// end function

        public function notify_online_state(param1:Array) : void
        {
            this._onlineState = param1;
            return;
        }// end function

        public function get_friendinfo_chatrecord_list(param1:Array) : void
        {
            this._getFriendinfoChatrecordList = param1;
            return;
        }// end function

        public function receive_unreceive_message(param1:Array) : void
        {
            this._receiveUnreceiveMessage = param1;
            return;
        }// end function

        public function send_message_to_friend(param1:Array) : void
        {
            this._sendMessageToFriend = param1;
            return;
        }// end function

        public function receive_message_from_friend(param1:Array) : void
        {
            this._receiveMessageFromFriend = param1;
            return;
        }// end function

        public function check_receive_message(param1:Array) : void
        {
            this._checkReceiveMessage = param1;
            return;
        }// end function

        public function get_unreceive_friend_list(param1:Array) : void
        {
            this.getUnreceiveFriendList = param1[0];
            return;
        }// end function

        public function set clearUnreceiveId(param1:int) : void
        {
            var _loc_4:int = 0;
            if (this.getUnreceiveFriendList == null)
            {
                return;
            }
            var _loc_2:* = this.getUnreceiveFriendList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this.getUnreceiveFriendList[_loc_3];
                if (_loc_4 == param1)
                {
                    this.getUnreceiveFriendList.splice(_loc_3, 1);
                    return;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function is_in_friend(param1:Array) : void
        {
            this._isInFriend = param1;
            return;
        }// end function

        public function get_listeners(param1:Array) : void
        {
            this._getListeners = param1;
            return;
        }// end function

        public function message_box_list(param1:Array) : void
        {
            this.messageBoxList = param1[0];
            return;
        }// end function

        public function notify_enter_state(param1:Array) : void
        {
            this.notifyEnterState = param1;
            return;
        }// end function

        public function receive_friend_enter_state(param1:Array) : void
        {
            this.receiveFriendEnterState = param1;
            return;
        }// end function

        public function vip_player_list(param1:Array) : void
        {
            this.getVipList = param1;
            return;
        }// end function

        public function add_friend_by_id(param1:Array) : void
        {
            this.addFriendById = param1;
            return;
        }// end function

        public function add_favourite_friend(param1:Array) : void
        {
            this.addFavouriteFriend = param1;
            return;
        }// end function

        public function cancel_favourite_friend(param1:Array) : void
        {
            this.cancelFavouriteFriend = param1;
            return;
        }// end function

    }
}
