package com.datas
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.lang.client.com.datas.*;
    import com.lang.client_resources.NineRegions.*;
    import com.protocols.*;

    public class NineRegionsData extends Base
    {
        public var nineRegionsInfo:NineRegionsInfo;
        public var warObj:Object;
        public var warData:Object;
        public var hiddenLevel:int = 0;
        public var teamList:Array;
        public var result:int = 0;
        public var myTeamId:int = 0;
        public var notifyValue:int = 0;
        public var newTeam:Object;
        public var delTeamId:int = 0;
        public var changeMemberObj:Object;
        public var myTeamList:Array;
        public var roleList:Array;
        public var leaderId:int = 0;
        public var exitFlag:int = 0;
        public var warResult:int;
        public var equitData:Object;
        public var playerIdList:Array;
        public var hiddenWarResult:int = 0;
        public var hiddenWarData:Object;

        public function NineRegionsData()
        {
            this.nineRegionsInfo = new NineRegionsInfo();
            this.warObj = {};
            this.warData = {};
            this.teamList = new Array();
            this.newTeam = new Object();
            this.changeMemberObj = new Object();
            this.myTeamList = [];
            this.roleList = [];
            this.hiddenWarData = {};
            return;
        }// end function

        public function openPanel(param1:Array) : void
        {
            this.nineRegionsInfo.isFrist = param1[0] == 1;
            this.nineRegionsInfo.curJie = param1[1];
            this.nineRegionsInfo.curLevel = param1[2];
            this.hiddenLevel = param1[3];
            return;
        }// end function

        public function startChallenge(param1:Array) : void
        {
            this.warObj = new Object();
            this.warObj.firstChallenge = param1[0] == 1;
            this.warObj.challengeResult = param1[1];
            return;
        }// end function

        public function close_team_panel(param1:Array) : void
        {
            return;
        }// end function

        public function open_team_panel(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_6:Array = null;
            while (this.teamList.length > 0)
            {
                
                this.teamList.pop();
            }
            var _loc_2:* = param1[0];
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = 0;
                _loc_5 = new Object();
                _loc_5.teamId = _loc_2[_loc_3][_loc_4++];
                _loc_5.jieId = _loc_2[_loc_3][_loc_4++];
                _loc_5.lvId = _loc_2[_loc_3][_loc_4++];
                _loc_5.leaderName = _loc_2[_loc_3][_loc_4++];
                _loc_5.curMenberNum = _loc_2[_loc_3][_loc_4++];
                _loc_5.canJoin = _loc_2[_loc_3][_loc_4++];
                _loc_5.creatTime = _loc_2[_loc_3][_loc_4++];
                if (_loc_5.jieId * 10 + _loc_5.lvId > this.nineRegionsInfo.curJie * 10 + this.nineRegionsInfo.curLevel)
                {
                    _loc_6 = NineRegionsType.getAward(_loc_5.jieId, _loc_5.lvId);
                    _loc_5.awardInfo = Lang.sprintf(McNineRegionsMainLang.HasAward, _loc_6[0], NineRegionsType.coinsString(_loc_6[1]));
                }
                else
                {
                    _loc_5.awardInfo = HtmlText.green(McNineRegionsMainLang.FullAward);
                }
                this.teamList.push(_loc_5);
                _loc_3++;
            }
            return;
        }// end function

        public function create_region_team(param1:Array) : void
        {
            this.result = param1[0];
            this.myTeamId = param1[1];
            return;
        }// end function

        public function join_region_team(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function notify(param1:Array) : void
        {
            this.notifyValue = param1[0];
            return;
        }// end function

        public function notify_new_team(param1:Array) : void
        {
            var _loc_4:Array = null;
            var _loc_2:int = 0;
            var _loc_3:* = new Object();
            _loc_3.teamId = param1[_loc_2++];
            _loc_3.jieId = param1[_loc_2++];
            _loc_3.lvId = param1[_loc_2++];
            _loc_3.leaderName = param1[_loc_2++];
            _loc_3.curMenberNum = param1[_loc_2++];
            _loc_3.canJoin = param1[_loc_2++];
            _loc_3.creatTime = param1[_loc_2++];
            if (_loc_3.jieId * 10 + _loc_3.lvId > this.nineRegionsInfo.curJie * 10 + this.nineRegionsInfo.curLevel)
            {
                _loc_4 = NineRegionsType.getAward(_loc_3.jieId, _loc_3.lvId);
                _loc_3.awardInfo = Lang.sprintf(McNineRegionsMainLang.HasAward, _loc_4[0], NineRegionsType.coinsString(_loc_4[1]));
            }
            else
            {
                _loc_3.awardInfo = HtmlText.green(McNineRegionsMainLang.FullAward);
            }
            this.newTeam = _loc_3;
            return;
        }// end function

        public function notify_drop_team(param1:Array) : void
        {
            this.delTeamId = param1[0];
            return;
        }// end function

        public function notify_update_member_number(param1:Array) : void
        {
            this.changeMemberObj.teamId = param1[0];
            this.changeMemberObj.memberNum = param1[1];
            return;
        }// end function

        public function get_player_bless_level(param1:Array) : void
        {
            _data.player.BlessLevel = param1[0];
            this.nineRegionsInfo.curJie = param1[1];
            this.nineRegionsInfo.curLevel = param1[2];
            return;
        }// end function

        public function getPlayerTeamInfo(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Array = null;
            var _loc_6:Object = null;
            var _loc_7:Array = null;
            var _loc_8:Array = null;
            while (this.myTeamList.length > 0)
            {
                
                this.myTeamList.pop();
            }
            this.leaderId = param1[0];
            var _loc_2:* = param1[1];
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = 0;
                _loc_5 = _loc_2[_loc_3];
                _loc_6 = new Object();
                _loc_6.isMine = false;
                _loc_6.playerId = _loc_5[_loc_4++];
                if (_data.player.playerId == _loc_6.playerId)
                {
                    _loc_6.isMine = true;
                }
                _loc_6.myTeam = false;
                if (_data.player.playerId == this.leaderId)
                {
                    _loc_6.myTeam = true;
                }
                _loc_6.playerName = _loc_5[_loc_4++];
                _loc_6.playerSign = _loc_5[_loc_4++];
                _loc_6.headUrl = URI.iconsMiniUrl + _loc_6.playerSign + ".png";
                _loc_6.lv = _loc_5[_loc_4++];
                _loc_6.petLv = _loc_5[_loc_4++];
                _loc_6.petStage = _loc_5[_loc_4++];
                if (_loc_6.petLv == 0)
                {
                    _loc_6.petInfo = "";
                }
                else
                {
                    _loc_7 = ["", NineRegionsDataLang.Jie1, NineRegionsDataLang.Jie2, NineRegionsDataLang.Jie3, NineRegionsDataLang.Jie4, NineRegionsDataLang.Jie5, NineRegionsDataLang.Jie6, NineRegionsDataLang.Jie7, NineRegionsDataLang.Jie8, NineRegionsDataLang.Jie9, NineRegionsDataLang.Jie10];
                    _loc_8 = ["", NineRegionsDataLang.Bian1, NineRegionsDataLang.Bian2, NineRegionsDataLang.Bian3, NineRegionsDataLang.Bian4, NineRegionsDataLang.Bian5, NineRegionsDataLang.Bian6, NineRegionsDataLang.Bian7, NineRegionsDataLang.Bian8, NineRegionsDataLang.Bian9];
                    if (_loc_6.petLv == 1)
                    {
                        _loc_6.petInfo = "<font color=\'#" + PetType.getColor(_loc_6.petLv).toString(16) + "\'>" + _loc_7[_loc_6.petStage] + PetType.getName(_loc_6.petLv) + "</font>";
                    }
                    else
                    {
                        _loc_6.petInfo = "<font color=\'#" + PetType.getColor(_loc_6.petLv).toString(16) + "\'>" + _loc_7[_loc_6.petStage] + PetType.getName(_loc_6.petLv) + " (" + _loc_8[(_loc_6.petLv - 1)] + ")</font>";
                    }
                }
                _loc_6.roleId = _loc_5[_loc_4++];
                _loc_6.roleName = _loc_5[_loc_4++];
                _loc_6.isLeader = false;
                if (_loc_6.playerId == this.leaderId)
                {
                    _loc_6.isLeader = true;
                    this.myTeamList.unshift(_loc_6);
                }
                else
                {
                    this.myTeamList.push(_loc_6);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function getHelperRoleList(param1:Array) : void
        {
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            while (this.roleList.length > 0)
            {
                
                this.roleList.pop();
            }
            var _loc_2:* = param1[0];
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                _loc_5 = 0;
                _loc_6 = new Object();
                _loc_6.roleId = _loc_4[_loc_5++];
                _loc_6.name = _loc_4[_loc_5++];
                _loc_6.lv = _loc_4[_loc_5++];
                _loc_6.jobId = _loc_4[_loc_5++];
                _loc_6.sign = RoleType.getRoleSign(_loc_6.roleId);
                _loc_6.headUrl = URI.iconsUrl + _loc_6.sign + ".png";
                _loc_6.inBody = _loc_4[_loc_5++] == Mod_NineRegions_Base.DEPLOY;
                this.roleList.push(_loc_6);
                _loc_3++;
            }
            return;
        }// end function

        public function exitTeam(param1:Array) : void
        {
            this.exitFlag = param1[0];
            return;
        }// end function

        public function kicked_out_member(param1:Array) : void
        {
            return;
        }// end function

        public function chooseelperRole(param1:Array) : void
        {
            return;
        }// end function

        public function sortBeelzebubTrialsTeam(param1:Array) : void
        {
            return;
        }// end function

        public function fightBeelzebubTrials(param1:Array) : void
        {
            return;
        }// end function

        public function get_war_result(param1:Array) : void
        {
            this.warResult = param1[0];
            this.warData = param1[4][0];
            this.equitData = this.renderEquitList(param1[5]);
            return;
        }// end function

        private function renderEquitList(param1:Array) : Object
        {
            var _loc_5:Object = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:String = null;
            var _loc_2:Object = {};
            this.playerIdList = [];
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_6 = param1[_loc_4][0];
                _loc_7 = param1[_loc_4][1];
                _loc_8 = param1[_loc_4][2];
                _loc_9 = param1[_loc_4][3] || "";
                _loc_5.equitItemId = _loc_8;
                _loc_5.nickName = _loc_9;
                _loc_2[_loc_7] = _loc_5;
                this.playerIdList.push(_loc_6);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function challenge_hidden_level(param1:Array) : void
        {
            this.hiddenWarResult = param1[0];
            this.hiddenWarData = param1[1][0];
            return;
        }// end function

    }
}
