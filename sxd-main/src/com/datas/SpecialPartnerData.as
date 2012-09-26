package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.haloer.data.*;

    public class SpecialPartnerData extends Base
    {
        private var _aryGetPartnerInfo:Array;
        private var _objInvitePartner:Object;
        private var _objIngotComplete:Object;
        private var _aryRequireList:Array;
        private var _objgetMissionAward:Object;

        public function SpecialPartnerData()
        {
            this._aryGetPartnerInfo = [];
            this._objInvitePartner = {};
            this._objIngotComplete = {};
            this._aryRequireList = [];
            this._objgetMissionAward = {};
            return;
        }// end function

        public function get getPartnerInfo() : Array
        {
            return this._aryGetPartnerInfo;
        }// end function

        public function get getMissionAward() : Object
        {
            return this._objgetMissionAward;
        }// end function

        public function get ingotComplete() : Object
        {
            return this._objIngotComplete;
        }// end function

        public function get ingotCompleteRequireList() : Array
        {
            return this._aryRequireList;
        }// end function

        public function get invitePartner() : Object
        {
            return this._objInvitePartner;
        }// end function

        public function get_partner_info(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            var _loc_5:Array = null;
            var _loc_6:Object = null;
            this._aryGetPartnerInfo = [];
            for each (_loc_2 in param1[0])
            {
                
                _loc_3 = {};
                oObject.list(_loc_2, _loc_3, ["role_id", "lock_key", "invite_status"]);
                _loc_3["role_sign"] = RoleType.getRoleSign(_loc_3["role_id"]);
                _loc_3["strength"] = RoleType.getRoleStrength(_loc_3["role_id"]);
                _loc_3["agile"] = RoleType.getRoleAgile(_loc_3["role_id"]);
                _loc_3["intellect"] = RoleType.getRoleIntellect(_loc_3["role_id"]);
                _loc_3["health"] = RoleType.getRoleInitialHealth(_loc_3["role_id"]);
                _loc_3["role_name"] = RoleType.getRoleName(_loc_3["role_id"]);
                _loc_3["job_name"] = RoleType.getJobNameByRoleSign(_loc_3["role_sign"]);
                _loc_3["stunt_id"] = RoleType.getRoleStuntId(_loc_3["role_id"]);
                _loc_3["stunt_name"] = RoleStunt.getStuntName(RoleStunt.getStuntSign(_loc_3["stunt_id"]));
                _loc_3["stunt_description"] = RoleStunt.getStuntDescription(_loc_3["stunt_id"]);
                _loc_3["role_color"] = RoleType.getRoleColorById(_loc_3["role_id"]);
                _loc_3["role_cartoon_url"] = URI.specialPartnerUrl + _loc_3["role_sign"] + ".swf";
                _loc_4 = [];
                for each (_loc_5 in _loc_2[3])
                {
                    
                    _loc_6 = {};
                    oObject.list(_loc_5, _loc_6, ["require_id", "my_item_amount", "require_status"]);
                    _loc_6["require_level"] = SpecialPartnerType.getRequireLevel(_loc_6["require_id"]);
                    _loc_6["require_item_id"] = SpecialPartnerType.getRequireItemId(_loc_6["require_id"]);
                    _loc_6["require_item_name"] = ItemType.getName(_loc_6["require_item_id"]);
                    _loc_6["require_item_amount"] = SpecialPartnerType.getRequireItemAmount(_loc_6["require_id"]);
                    _loc_6["require_item_color"] = ItemType.getItemColor(_loc_6["require_item_id"]);
                    _loc_6["require_item_url"] = URI.specialPartnerGoodUrl(_loc_6["require_item_id"]);
                    _loc_6["require_item_price"] = SpecialPartnerType.getRequireItemPrice(_loc_6["require_id"]);
                    _loc_6["mission_id"] = SpecialPartnerType.getMissionId(_loc_6["require_id"]);
                    _loc_6["mission_name"] = MissionType.getMissionName(_loc_6["mission_id"]);
                    _loc_6["mission_lock"] = MissionType.getMissionLock(_loc_6["mission_id"]);
                    _loc_6["town_name"] = TownType.getName(MissionType.getTownIdByMissionId(_loc_6["mission_id"]));
                    _loc_6["monster_id"] = SpecialPartnerType.getMonsterId(_loc_6["require_id"]);
                    _loc_6["monster_name"] = MonsterType.getMonsterNameById(_loc_6["monster_id"]);
                    _loc_6["award_fame"] = SpecialPartnerType.getAwardFame(_loc_6["require_id"]);
                    _loc_6["award_experience"] = SpecialPartnerType.getAwardExperience(_loc_6["require_id"]);
                    _loc_6["award_power"] = SpecialPartnerType.getAwardPower(_loc_6["require_id"]);
                    _loc_6["award_item_id"] = SpecialPartnerType.getAwardItemId(_loc_6["require_id"]);
                    _loc_6["award_item_amount"] = SpecialPartnerType.getAwardItemAmount(_loc_6["require_id"]);
                    _loc_6["award_item_name"] = ItemType.getName(_loc_6["award_item_id"]);
                    _loc_6["award_item_color"] = ItemType.getItemColor(_loc_6["award_item_id"]);
                    _loc_4.push(_loc_6);
                }
                _loc_4.sortOn("require_level", Array.NUMERIC);
                _loc_3["require_list"] = _loc_4;
                this._aryGetPartnerInfo.push(_loc_3);
            }
            this._aryGetPartnerInfo.sortOn("lock_key", Array.NUMERIC);
            return;
        }// end function

        public function get_mission_award(param1:Array) : void
        {
            oObject.list(param1, this._objgetMissionAward, ["result"]);
            return;
        }// end function

        public function ingot_complete(param1:Array) : void
        {
            oObject.list(param1, this._objIngotComplete, ["result"]);
            this._aryRequireList = param1[1];
            return;
        }// end function

        public function invite_partner(param1:Array) : void
        {
            oObject.list(param1, this._objInvitePartner, ["result"]);
            return;
        }// end function

    }
}
