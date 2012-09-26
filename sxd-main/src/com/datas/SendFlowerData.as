package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.haloer.data.*;

    public class SendFlowerData extends Base
    {
        private var _arySendFlowerRecord:Array;
        private var _objSendFlowerInfo:Object;
        private var _objSendPlayerFlower:Object;
        private var _arySendFlowerRanking:Array;
        private var _aryGetSendFlowerRankingWeek:Array;

        public function SendFlowerData()
        {
            this._arySendFlowerRecord = [];
            this._objSendFlowerInfo = {};
            this._objSendPlayerFlower = {};
            this._arySendFlowerRanking = [];
            this._aryGetSendFlowerRankingWeek = [];
            return;
        }// end function

        public function sendFlowerRecord() : Array
        {
            return this._arySendFlowerRecord;
        }// end function

        public function sendFlowerInfo() : Object
        {
            return this._objSendFlowerInfo;
        }// end function

        public function sendPlayerFlower() : Object
        {
            return this._objSendPlayerFlower;
        }// end function

        public function sendFlowerRanking() : Array
        {
            return this._arySendFlowerRanking;
        }// end function

        public function getSendFlowerRankingWeek() : Array
        {
            return this._aryGetSendFlowerRankingWeek;
        }// end function

        private function sortBySendTime(param1:Object, param2:Object) : int
        {
            var _loc_3:* = param1["send_time"];
            var _loc_4:* = param2["send_time"];
            if (_loc_3 < _loc_4)
            {
                return 1;
            }
            if (_loc_3 > _loc_4)
            {
                return -1;
            }
            return 0;
        }// end function

        private function sortByFlowerCount(param1:Object, param2:Object) : int
        {
            var _loc_3:* = param1["flower_count"];
            var _loc_4:* = param2["flower_count"];
            if (_loc_3 < _loc_4)
            {
                return 1;
            }
            if (_loc_3 > _loc_4)
            {
                return -1;
            }
            return 0;
        }// end function

        public function player_send_flower_info(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            this._objSendFlowerInfo = {};
            this._arySendFlowerRecord = [];
            oObject.list(param1, this._objSendFlowerInfo, ["result", "player_id", "nickname", "role_id", "max_player_id", "max_nickname", "max_flower_count", "total_flower_count", "is_can_send"]);
            this._objSendFlowerInfo["nickname_new"] = this._data.player.removeNickNameSuffix(this._objSendFlowerInfo["nickname"]);
            this._objSendFlowerInfo["max_nickname_new"] = this._data.player.removeNickNameSuffix(this._objSendFlowerInfo["max_nickname"]);
            this._objSendFlowerInfo["url"] = URI.iconsUrl + RoleType.getRoleSign(this._objSendFlowerInfo["role_id"]) + ".png";
            for each (_loc_2 in param1[9])
            {
                
                _loc_3 = {};
                oObject.list(_loc_2, _loc_3, ["player_id", "nickname", "role_id", "flower_type", "send_time"]);
                _loc_3["nickname_new"] = this._data.player.removeNickNameSuffix(_loc_3["nickname"]);
                _loc_3["url"] = URI.iconsUrl + RoleType.getRoleSign(_loc_3["role_id"]) + ".png";
                this._arySendFlowerRecord.push(_loc_3);
            }
            this._arySendFlowerRecord.sort(this.sortBySendTime);
            return;
        }// end function

        public function send_player_flower(param1:Array) : void
        {
            this._objSendPlayerFlower = {result:param1[0]};
            return;
        }// end function

        public function send_flower_ranking(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this._arySendFlowerRanking = [];
            for each (_loc_3 in param1[0])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["player_id", "nickname", "role_id", "flower_count"]);
                _loc_2["nickname_new"] = this._data.player.removeNickNameSuffix(_loc_2["nickname"]);
                _loc_2["sex"] = RoleType.getRoleGender(_loc_2["role_id"]) == "Nv" ? (1) : (2);
                this._arySendFlowerRanking.push(_loc_2);
            }
            return;
        }// end function

        public function get_send_flower_ranking_week(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this._aryGetSendFlowerRankingWeek = [];
            for each (_loc_3 in param1[0])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["player_id", "role_id", "nickname", "flower_count"]);
                _loc_2["nickname_new"] = this._data.player.removeNickNameSuffix(_loc_2["nickname"]);
                _loc_2["url"] = URI.iconsUrl + RoleType.getRoleSign(_loc_2["role_id"]) + ".png";
                this._aryGetSendFlowerRankingWeek.push(_loc_2);
            }
            this._aryGetSendFlowerRankingWeek.sort(this.sortByFlowerCount);
            return;
        }// end function

    }
}
