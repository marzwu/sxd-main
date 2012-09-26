package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.haloer.data.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;

    public class PartnersData extends Base
    {
        private var _aryPartnersList:Array;
        private var _aryPartnersInvite:Array;
        public var recommend:String;

        public function PartnersData()
        {
            this._aryPartnersList = [];
            this._aryPartnersInvite = [];
            return;
        }// end function

        public function getPartnersList() : Array
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            var _loc_1:Array = [];
            for each (_loc_3 in this._aryPartnersList[0])
            {
                
                _loc_2 = {};
                oObject.list(_loc_3, _loc_2, ["role_id", "level", "fees", "fame", "stunt_name", "stunt_info", "health", "max_health", "strength", "agile", "intellect", "is_recommend", "fame_level", "is_invite_before", "is_invite"]);
                _loc_2["role_job_name"] = RoleType.getJobName(RoleType.getJobIdByRoleId(_loc_2["role_id"]));
                _loc_2["name"] = RoleType.getRoleName(_loc_2["role_id"]);
                _loc_2["role_sign"] = RoleType.getRoleSign(_loc_2["role_id"]);
                _loc_2["job_sign"] = RoleType.getJobSign(RoleType.getJobIdByRoleId(_loc_2["role_id"]));
                _loc_2.isSuperRole = RoleType.checkSuperRole(_loc_2["role_id"]);
                _loc_2.isInvite = _loc_2.is_invite_before == Mod_Partners_Base.YES;
                _loc_2.url = URI.getRoleIconUrl(_loc_2.role_sign);
                _loc_2.isPurpleRole = RoleType.isPurpleRole(_loc_2.role_id);
                _loc_2.color = RoleType.getRoleColorById(_loc_2.role_id);
                _loc_1.push(_loc_2);
            }
            this.sortLock(_loc_1);
            return _loc_1;
        }// end function

        private function sortLock(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 1;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = 0;
                while (_loc_4 < (_loc_2 - 1))
                {
                    
                    if (param1[_loc_4].fame_level < param1[(_loc_4 + 1)].fame_level)
                    {
                        _loc_5 = param1[_loc_4];
                        param1[_loc_4] = param1[(_loc_4 + 1)];
                        param1[(_loc_4 + 1)] = _loc_5;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function getRecruitCount() : Object
        {
            var _loc_1:Object = {};
            _loc_1["max_count"] = this._aryPartnersList[1];
            _loc_1["curr_count"] = this._aryPartnersList[2];
            _loc_1["fame_level"] = this._aryPartnersList[3];
            return _loc_1;
        }// end function

        public function Recruit() : int
        {
            var _loc_1:* = this._aryPartnersInvite[0];
            return _loc_1;
        }// end function

        private function sortFame(param1:Object, param2:Object) : int
        {
            var _loc_3:* = param1["fame"];
            var _loc_4:* = param2["fame"];
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

        public function partners_list(param1:Array) : void
        {
            this._aryPartnersList = param1;
            return;
        }// end function

        public function partners_invite(param1:Array) : void
        {
            this._aryPartnersInvite = param1;
            return;
        }// end function

        public function now_and_next_Recommend_role_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            this.recommend = PartnersDataLang.Fame + _data.player.fame + "(Lv" + param1[2] + ")";
            this.recommend = "<font size=\'18\'> </font>" + htmlFormat(this.recommend, 14, 15425792, true);
            var _loc_2:* = "(" + HtmlText.green(PartnersDataLang.Recommend) + ")";
            var _loc_4:String = "\n<font size=\'18\'> </font>";
            if (param1[0].length > 0)
            {
                this.recommend = this.recommend + _loc_4 + HtmlText.yellow(PartnersDataLang.NowPartner);
                for each (_loc_3 in param1[0])
                {
                    
                    this.recommend = this.recommend + _loc_4 + RoleType.getRoleName(_loc_3[0]) + ", " + RoleType.getJobName(RoleType.getJobIdByRoleId(_loc_3[0])) + _loc_2;
                }
            }
            if (param1[1].length > 0)
            {
                this.recommend = this.recommend + _loc_4 + HtmlText.yellow(PartnersDataLang.NextPartner);
                for each (_loc_3 in param1[1])
                {
                    
                    if (_loc_3[1] == 1)
                    {
                        this.recommend = this.recommend + _loc_4 + RoleType.getRoleName(_loc_3[0]) + ", " + RoleType.getJobName(RoleType.getJobIdByRoleId(_loc_3[0])) + _loc_2;
                        continue;
                    }
                    this.recommend = this.recommend + _loc_4 + RoleType.getRoleName(_loc_3[0]) + ", " + RoleType.getJobName(RoleType.getJobIdByRoleId(_loc_3[0]));
                }
            }
            if (param1[0].length == 0 && param1[1].length == 0)
            {
                this.recommend = "";
            }
            return;
        }// end function

    }
}
