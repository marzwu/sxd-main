package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.info.*;
    import com.haloer.data.*;
    import com.protocols.*;

    public class TownData extends Base
    {
        public var allList:Array;
        public var showCount:int = 0;
        public var count:int = 0;
        public var result:int;
        public var playercount:int = 0;
        public var showList:Array;
        public var entownList:Array;
        public var moveList:Array;
        public var leaveList:Array;
        public var followList:Array;
        public var factionId:int = 0;
        public var followChangePlayerId:int = 0;
        public static var maxCount:int = 500;

        public function TownData()
        {
            this.allList = [];
            this.showList = [];
            this.entownList = [];
            this.moveList = [];
            this.leaveList = [];
            this.followList = [];
            return;
        }// end function

        public function getPlayerInfo(param1:int) : PlayerInfo
        {
            var _loc_2:* = new PlayerInfo();
            this.allList[param1] = new PlayerInfo();
            return this.allList[param1] || _loc_2;
        }// end function

        public function enter_town(param1:Array) : void
        {
            var _loc_4:* = _data.player.playerInfo;
            PlayerInfo.info = _data.player.playerInfo;
            var _loc_2:* = _loc_4;
            this.allList[_loc_2.id] = _loc_2;
            this.result = param1.shift();
            if (this.result != Mod_Town_Base.SUCCESS)
            {
                this.entownList[param1[0]] = param1[0];
                return;
            }
            var _loc_3:Object = {};
            oObject.list(param1, _loc_3, ["player_id", "role_id", "follow_role_id", "is_have_cat", "is_role_follow", "is_pet_follow", "is_cat_follow", "nickname", "position_x", "position_y", "transport", "avatar", "camp_id", "equip_item_id", "warState", "practice_status", "is_on_mission_practice", "faction_id", "faction_name", "is_star", "is_world_war_top", "player_pet_animal_lv", "player_pet_animal_stage", "world_faction_war_award"]);
            _loc_2 = this.parsePlayer(_loc_3);
            if (_loc_2.isMine)
            {
                this.factionId = _loc_2.factionId;
                _loc_2.factionColor = 8438377;
            }
            var _loc_4:String = this;
            var _loc_5:* = this.count + 1;
            _loc_4.count = _loc_5;
            return;
        }// end function

        public function move_to(param1:Array) : void
        {
            var _loc_2:* = param1[0];
            var _loc_3:* = this.allList[_loc_2] as PlayerInfo;
            if (_loc_3 != null)
            {
                _loc_3.x = param1[3];
                _loc_3.y = param1[4];
                _loc_3.practice = Mod_Town_Base.OFF_PRACTICE;
            }
            if (this.showList[_loc_2] is PlayerInfo)
            {
                this.moveList[_loc_2] = _loc_2;
            }
            return;
        }// end function

        public function leave_town(param1:Array) : void
        {
            var _loc_2:* = param1[0];
            if (this.allList[_loc_2] is PlayerInfo)
            {
                var _loc_3:String = this;
                var _loc_4:* = this.count - 1;
                _loc_3.count = _loc_4;
            }
            if (this.showList[_loc_2] is PlayerInfo)
            {
                this.leaveList[_loc_2] = _loc_2;
                var _loc_3:String = this;
                var _loc_4:* = this.showCount - 1;
                _loc_3.showCount = _loc_4;
                delete this.showList[_loc_2];
            }
            return;
        }// end function

        public function get_players(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            param1 = param1[0];
            this.count = param1.length;
            var _loc_2:* = _data.player.playerInfo.id;
            for each (_loc_3 in param1)
            {
                
                if (_loc_3[0] != _loc_2)
                {
                    _loc_4 = {};
                    oObject.list(_loc_3, _loc_4, ["player_id", "role_id", "follow_role_id", "is_have_cat", "is_role_follow", "is_pet_follow", "is_cat_follow", "nickname", "position_x", "position_y", "transport", "avatar", "camp_id", "equip_item_id", "warState", "practice_status", "is_on_mission_practice", "faction_id", "faction_name", "is_star", "is_world_war_top", "player_pet_animal_lv", "player_pet_animal_stage"]);
                    this.parsePlayer(_loc_4);
                }
            }
            return;
        }// end function

        public function player_follow_role_change(param1:Array) : void
        {
            var _loc_2:* = param1[0];
            if (this.allList[_loc_2] is PlayerInfo)
            {
                (this.allList[_loc_2] as PlayerInfo).followRoleId = param1[1];
            }
            if (this.showList[_loc_2] is PlayerInfo)
            {
                this.followList[_loc_2] = _loc_2;
            }
            return;
        }// end function

        public function player_follow_setting_change(param1:Array) : void
        {
            this.followChangePlayerId = param1[0];
            var _loc_2:* = param1[1];
            var _loc_3:* = param1[2];
            if (this.allList[this.followChangePlayerId] is PlayerInfo)
            {
                switch(_loc_2)
                {
                    case Mod_Town_Base.TYPE_PARTNER:
                    {
                        (this.allList[this.followChangePlayerId] as PlayerInfo).is_role_follow = _loc_3 == 1;
                        break;
                    }
                    case Mod_Town_Base.TYPE_PET:
                    {
                        (this.allList[this.followChangePlayerId] as PlayerInfo).is_pet_follow = _loc_3 == 1;
                        break;
                    }
                    case Mod_Town_Base.TYPE_CAT:
                    {
                        (this.allList[this.followChangePlayerId] as PlayerInfo).is_cat_follow = _loc_3 == 1;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function player_count(param1:Array) : void
        {
            this.playercount = param1[0];
            return;
        }// end function

        private function parsePlayer(param1:Object) : PlayerInfo
        {
            var _loc_2:* = param1.player_id;
            var _loc_3:* = this.allList[_loc_2] || new PlayerInfo();
            _loc_3.followRoleId = param1.follow_role_id;
            _loc_3.id = _loc_2;
            _loc_3.roleId = param1.role_id;
            _loc_3.name = param1.nickname;
            _loc_3.x = param1.position_x;
            _loc_3.y = param1.position_y;
            _loc_3.warState = param1.warState;
            _loc_3.starUser = param1.is_star;
            _loc_3.topUser = param1.is_world_war_top;
            _loc_3.signSuffix = ItemType.getItemSuffix(param1.equip_item_id);
            if (_loc_3.signSuffix == "F0" || _loc_3.signSuffix == "F1")
            {
                _loc_3.bPutOnClothes = true;
            }
            else
            {
                _loc_3.bPutOnClothes = false;
            }
            _loc_3.practice = param1.practice_status;
            _loc_3.factionId = int(param1.faction_id);
            _loc_3.factionName = param1.faction_name;
            _loc_3.factionColor = _loc_3.factionId == this.factionId ? (8438377) : (15658734);
            _loc_3.petLv = param1.player_pet_animal_lv;
            _loc_3.petStar = param1.player_pet_animal_stage;
            _loc_3.isChampion = param1.world_faction_war_award && param1.world_faction_war_award != 0;
            _loc_3.is_have_cat = param1.is_have_cat;
            _loc_3.is_role_follow = param1.is_role_follow;
            _loc_3.is_pet_follow = param1.is_pet_follow;
            _loc_3.is_cat_follow = param1.is_cat_follow;
            var _loc_4:* = RoleType.getRoleSign(_loc_3.roleId);
            _loc_3.sign = _loc_4;
            _loc_3.fullHeadUrl = URI.iconsUrl + _loc_4 + ".png";
            this.allList[_loc_3.id] = _loc_3;
            this.setPlayerMount(param1.transport, _loc_2);
            this.setPlayerAvatar(param1.avatar, _loc_2);
            if (_loc_3.isMine)
            {
                _data.player.signSuffix = _loc_3.signSuffix;
            }
            if (this.showList[_loc_2] == null && (_loc_3.isMine || this.showCount < maxCount))
            {
                this.entownList[_loc_2] = _loc_2;
                this.showList[_loc_2] = _loc_3;
                var _loc_5:String = this;
                var _loc_6:* = this.showCount + 1;
                _loc_5.showCount = _loc_6;
            }
            _loc_3.name = _data.player.removeNickNameSuffix(_loc_3.name);
            _loc_3.factionName = _data.player.removeNickNameSuffix(_loc_3.factionName);
            return _loc_3;
        }// end function

        public function clearPlayer() : void
        {
            this.showList = [];
            this.allList = [];
            this.entownList = [];
            this.moveList = [];
            this.leaveList = [];
            this.showCount = 0;
            this.count = 0;
            var _loc_1:* = _data.player.playerInfo;
            this.allList[_loc_1.id] = _loc_1;
            return;
        }// end function

        public function setPlayerMount(param1:int, param2:int) : void
        {
            var _loc_3:* = this.allList[param2] as PlayerInfo;
            if (_loc_3 == null)
            {
                return;
            }
            _loc_3.setMount(param1);
            return;
        }// end function

        public function setPlayerAvatar(param1:int, param2:int) : void
        {
            var _loc_3:* = this.allList[param2] as PlayerInfo;
            if (_loc_3 == null)
            {
                return;
            }
            _loc_3.setAvatar(param1);
            return;
        }// end function

    }
}
