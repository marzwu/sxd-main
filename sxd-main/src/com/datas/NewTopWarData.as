package com.datas
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;

    public class NewTopWarData extends Base
    {
        public var result:int = 0;
        public var myTeamObj:Object;
        public var requestList:Array;
        public var otherTeamObj:Object;
        public var searchTeamName:String;
        public var searchLeaderName:String;
        public var myRoleList:Array;
        public var deployList:Array;
        public var firstAttack:int = 0;
        public var signList:Array;
        public var signState:int = 0;
        public var topWarStep:int = 0;
        public var otherTeamInfoObj:Object;
        public var warList:Array;
        public var rankList:Array;
        public var topThroneList:Array;

        public function NewTopWarData()
        {
            this.myRoleList = new Array();
            this.deployList = [];
            return;
        }// end function

        public function create_team(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function disband_team(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function accept_request(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function deny_request(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function batch_deny_request(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function kickout_member(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function request(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function cancel_request(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function quit_team(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function my_team_info(param1:Array) : void
        {
            var _loc_4:Array = null;
            var _loc_5:Object = null;
            var _loc_6:String = null;
            this.myTeamObj = new Object();
            this.myTeamObj.teamId = param1[0];
            this.myTeamObj.teamName = param1[1];
            this.myTeamObj.score = param1[2];
            this.myTeamObj.rank = param1[3];
            this.myTeamObj.teamFlag = param1[4];
            this.myTeamObj.isLeader = this.myTeamObj.teamId == _data.player.playerId;
            var _loc_2:* = new Array();
            var _loc_3:int = 0;
            while (_loc_3 < param1[5].length)
            {
                
                _loc_4 = param1[5][_loc_3];
                _loc_5 = new Object();
                _loc_5.iconUrl = URI.iconsMiniUrl + RoleType.getRoleSign(_loc_4[0]) + ".png";
                _loc_5.playerId = _loc_4[1];
                _loc_5.nickName = _loc_4[2];
                _loc_5.nickName = _data.player.removeNickNameSuffix(_loc_5.nickName);
                _loc_5.lv = _loc_4[3];
                _loc_5.roleId = _loc_4[4];
                _loc_5.playerInfo = "";
                if (_loc_5.playerId == this.myTeamObj.teamId)
                {
                    _loc_5.playerInfo = NewTopWarDataLang.DuiZhang;
                }
                else
                {
                    _loc_5.playerInfo = NewTopWarDataLang.DuiYuan;
                }
                _loc_6 = "PlayerInfoShow_" + _loc_5.playerId + "_" + _loc_5.nickName;
                if (_loc_5.playerId == _data.player.playerId)
                {
                    _loc_5.playerInfo = _loc_5.playerInfo + (" <font color=\'#F09600\'><u><a href=\'event:" + _loc_6 + "\'>" + _loc_5.nickName + "</a></u></font>");
                }
                else
                {
                    _loc_5.playerInfo = _loc_5.playerInfo + (" <font color=\'#FFFFFF\'><u><a href=\'event:" + _loc_6 + "\'>" + _loc_5.nickName + "</a></u></font>");
                }
                _loc_5.playerInfo = _loc_5.playerInfo + ("  " + _loc_5.lv + NewTopWarDataLang.DengJi);
                if (_loc_5.roleId != 0)
                {
                    _loc_5.playerInfo = _loc_5.playerInfo + (" " + NewTopWarDataLang.HuoBan + " " + HtmlText.format(RoleType.getRoleName(_loc_5.roleId), RoleType.getRoleColorById(_loc_5.roleId)));
                }
                if (_data.player.playerId != _loc_5.playerId)
                {
                    if (_loc_5.roleId == 0)
                    {
                        _loc_5.playerInfo = _loc_5.playerInfo + (" " + HtmlText.red(NewTopWarDataLang.WeiXuanZeHuoBan));
                    }
                }
                if (_data.player.playerId == _loc_5.playerId)
                {
                    _loc_6 = "ChangeRole";
                    if (_loc_5.roleId == 0)
                    {
                        _loc_5.playerInfo = _loc_5.playerInfo + (" <font color=\'#00b7ee\'><u><a href=\'event:" + _loc_6 + "\'>(" + NewTopWarDataLang.XuanZeHuoBan + ")</a></u></font>");
                    }
                    else
                    {
                        _loc_5.playerInfo = _loc_5.playerInfo + (" <font color=\'#00b7ee\'><u><a href=\'event:" + _loc_6 + "\'>(" + NewTopWarDataLang.GengHuan + ")</a></u></font>");
                    }
                }
                else if (this.myTeamObj.isLeader)
                {
                    _loc_6 = "MemberOut_" + _loc_5.playerId;
                    _loc_5.playerInfo = _loc_5.playerInfo + (" <font color=\'#00b7ee\'><u><a href=\'event:" + _loc_6 + "\'>(" + NewTopWarDataLang.MemberOut + ")</a></u></font>");
                }
                if (_loc_5.playerId == this.myTeamObj.teamId)
                {
                    _loc_2.unshift(_loc_5);
                }
                else
                {
                    _loc_2.push(_loc_5);
                }
                _loc_3++;
            }
            this.myTeamObj.isInWorld = param1[5] == 1;
            this.myTeamObj.memberList = _loc_2;
            return;
        }// end function

        public function request_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            this.requestList = new Array();
            var _loc_2:int = 0;
            while (_loc_2 < param1[0].length)
            {
                
                _loc_3 = param1[0][_loc_2];
                _loc_4 = new Object();
                _loc_4.iconUrl = URI.iconsMiniUrl + RoleType.getRoleSign(_loc_3[0]) + ".png";
                _loc_4.playerId = _loc_3[1];
                _loc_4.nickName = _loc_3[2];
                _loc_4.nickName = _data.player.removeNickNameSuffix(_loc_4.nickName);
                _loc_4.lv = _loc_3[3];
                _loc_4.rank = _loc_3[4];
                _loc_4.playerInfo = " <font color=\'#F09600\'><u><a href=\'event:click\'>" + _loc_4.nickName + "</a></u></font>";
                this.requestList.push(_loc_4);
                _loc_2++;
            }
            return;
        }// end function

        public function team_list(param1:Array) : void
        {
            var _loc_4:Array = null;
            var _loc_5:Object = null;
            this.otherTeamObj = new Object();
            this.otherTeamObj.totalPage = param1[0];
            this.otherTeamObj.curPage = param1[1];
            var _loc_2:* = new Array();
            var _loc_3:int = 0;
            while (_loc_3 < param1[2].length)
            {
                
                _loc_4 = param1[2][_loc_3];
                _loc_5 = new Object();
                _loc_5.playerId = _loc_4[0];
                _loc_5.iconUrl = URI.iconsMiniUrl + RoleType.getRoleSign(_loc_4[1]) + ".png";
                _loc_5.leaderName = _loc_4[2];
                _loc_5.leaderName = _data.player.removeNickNameSuffix(_loc_5.leaderName);
                _loc_5.teamName = _loc_4[3];
                _loc_5.memberNum = _loc_4[4];
                _loc_5.state = _loc_4[5];
                _loc_5.isSign = _loc_4[6] == 1;
                _loc_5.canSign = this.topWarStep == Mod_NewTopWar_Base.SIGN_OPEN;
                _loc_5.hasTeam = this.myTeamObj.teamId != 0;
                _loc_2.push(_loc_5);
                _loc_3++;
            }
            this.searchTeamName = param1[3];
            this.searchLeaderName = param1[4];
            this.otherTeamObj.teamList = _loc_2;
            return;
        }// end function

        public function helper_role_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            while (this.myRoleList.length > 0)
            {
                
                this.myRoleList.pop();
            }
            var _loc_2:int = 0;
            while (_loc_2 < param1[0].length)
            {
                
                _loc_3 = param1[0][_loc_2];
                _loc_4 = 0;
                _loc_5 = new Object();
                _loc_5.playerRoleId = _loc_3[_loc_4++];
                _loc_5.roleId = _loc_3[_loc_4++];
                _loc_5.name = RoleType.getRoleName(_loc_5.roleId);
                _loc_5.sign = RoleType.getRoleSign(_loc_5.roleId);
                _loc_5.headUrl = URI.iconsUrl + _loc_5.sign + ".png";
                _loc_5.jobId = RoleType.getJobIdByRoleId(_loc_5.roleId);
                _loc_5.lv = _loc_3[_loc_4++];
                _loc_5.inBody = _loc_3[_loc_4++] == Mod_NewTopWar_Base.DEPLOY;
                this.myRoleList.push(_loc_5);
                _loc_2++;
            }
            return;
        }// end function

        public function choose_helper_role(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function deploy_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_6:String = null;
            this.deployList.length = 0;
            this.firstAttack = param1[0];
            var _loc_2:int = 0;
            while (_loc_2 < param1[1].length)
            {
                
                _loc_3 = param1[1][_loc_2];
                _loc_4 = 0;
                _loc_5 = new Object();
                _loc_5.playerId = _loc_3[_loc_4++];
                _loc_5.name = _loc_3[_loc_4++];
                _loc_5.roleId = _loc_3[_loc_4++];
                _loc_5.position = _loc_3[_loc_4++];
                _loc_6 = RoleType.getRoleSign(_loc_5.roleId);
                _loc_5.iconUrl = URI.iconsUrl + _loc_6 + ".png";
                if (!RoleType.isMainRole(_loc_6))
                {
                    _loc_5.name = RoleType.getRoleNameByRoleSign(_loc_6);
                }
                this.deployList.push(_loc_5);
                _loc_2++;
            }
            return;
        }// end function

        public function change_position(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function sign_up(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function sign_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            this.signList = new Array();
            var _loc_2:int = 0;
            while (_loc_2 < param1[0].length)
            {
                
                _loc_3 = param1[0][_loc_2];
                _loc_4 = new Object();
                var _loc_5:* = _loc_3[0];
                _loc_4.leaderId = _loc_3[0];
                new Object().teamId = _loc_5;
                _loc_4.teamName = _loc_3[1];
                _loc_4.leaderName = _loc_3[2];
                _loc_4.leaderName = _data.player.removeNickNameSuffix(_loc_4.leaderName);
                _loc_4.score = _loc_3[3];
                _loc_4.time = _loc_3[4];
                _loc_4.isMyTeam = false;
                if (this.myTeamObj.teamId == _loc_4.teamId)
                {
                    _loc_4.isMyTeam = true;
                }
                this.signList.push(_loc_4);
                _loc_2++;
            }
            this.signList.sortOn(["score", "time"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
            _loc_2 = 0;
            while (_loc_2 < this.signList.length)
            {
                
                this.signList[_loc_2].rank = _loc_2 + 1;
                _loc_2++;
            }
            return;
        }// end function

        public function get_top_war_step(param1:Array) : void
        {
            this.signState = param1[0];
            this.topWarStep = param1[1];
            return;
        }// end function

        public function team_info(param1:Array) : void
        {
            var _loc_4:Array = null;
            var _loc_5:Object = null;
            var _loc_6:String = null;
            this.otherTeamInfoObj = new Object();
            this.otherTeamInfoObj.teamId = param1[0];
            this.otherTeamInfoObj.teamName = param1[1];
            this.otherTeamInfoObj.score = param1[2];
            this.otherTeamInfoObj.rank = param1[3];
            this.otherTeamInfoObj.teamFlag = param1[4];
            var _loc_2:* = new Array();
            var _loc_3:int = 0;
            while (_loc_3 < param1[5].length)
            {
                
                _loc_4 = param1[5][_loc_3];
                _loc_5 = new Object();
                _loc_5.iconUrl = URI.iconsMiniUrl + RoleType.getRoleSign(_loc_4[0]) + ".png";
                _loc_5.playerId = _loc_4[1];
                _loc_5.nickName = _loc_4[2];
                _loc_5.nickName = _data.player.removeNickNameSuffix(_loc_5.nickName);
                _loc_5.lv = _loc_4[3];
                _loc_5.roleId = _loc_4[4];
                _loc_5.playerInfo = "";
                if (_loc_5.playerId == this.otherTeamInfoObj.teamId)
                {
                    _loc_5.playerInfo = NewTopWarDataLang.DuiZhang;
                }
                else
                {
                    _loc_5.playerInfo = NewTopWarDataLang.DuiYuan;
                }
                _loc_6 = "PlayerInfoShow_" + _loc_5.playerId + "_" + _loc_5.nickName;
                if (this.topWarStep == Mod_NewTopWar_Base.SIGN_OPEN || this.topWarStep == Mod_NewTopWar_Base.SIGN_CLOSE || this.topWarStep == Mod_NewTopWar_Base.TAOTAI || this.topWarStep == Mod_NewTopWar_Base.TAOTAI_END)
                {
                    if (_loc_5.playerId == _data.player.playerId)
                    {
                        _loc_5.playerInfo = _loc_5.playerInfo + (" <font color=\'#F09600\'><u><a href=\'event:" + _loc_6 + "\'>" + _loc_5.nickName + "</a></u></font>");
                    }
                    else
                    {
                        _loc_5.playerInfo = _loc_5.playerInfo + (" <font color=\'#FFFFFF\'><u><a href=\'event:" + _loc_6 + "\'>" + _loc_5.nickName + "</a></u></font>");
                    }
                    _loc_5.playerInfo = _loc_5.playerInfo + (" " + _loc_5.lv + NewTopWarDataLang.DengJi);
                    if (_loc_5.roleId != 0)
                    {
                        _loc_5.playerInfo = _loc_5.playerInfo + (" " + NewTopWarDataLang.HuoBan + " " + HtmlText.format(RoleType.getRoleName(_loc_5.roleId), RoleType.getRoleColorById(_loc_5.roleId)));
                    }
                }
                else
                {
                    if (_loc_5.playerId == _data.player.playerId)
                    {
                        _loc_5.playerInfo = _loc_5.playerInfo + (" <font color=\'#F09600\'>" + _loc_5.nickName + "</font>");
                    }
                    else
                    {
                        _loc_5.playerInfo = _loc_5.playerInfo + (" <font color=\'#FFFFFF\'>" + _loc_5.nickName + "</font>");
                    }
                    _loc_5.playerInfo = _loc_5.playerInfo + (" " + _loc_5.lv + NewTopWarDataLang.DengJi);
                    if (_loc_5.roleId != 0)
                    {
                        _loc_5.playerInfo = _loc_5.playerInfo + (" " + NewTopWarDataLang.HuoBan + " " + HtmlText.format(RoleType.getRoleName(_loc_5.roleId), RoleType.getRoleColorById(_loc_5.roleId)));
                    }
                }
                if (_loc_5.playerId == this.otherTeamInfoObj.teamId)
                {
                    _loc_2.unshift(_loc_5);
                }
                else
                {
                    _loc_2.push(_loc_5);
                }
                _loc_3++;
            }
            this.otherTeamInfoObj.memberList = _loc_2;
            return;
        }// end function

        public function local_war_report_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_4:Object = null;
            var _loc_6:Object = null;
            var _loc_7:Array = null;
            var _loc_8:int = 0;
            var _loc_9:Object = null;
            var _loc_10:Array = null;
            this.warList = new Array();
            var _loc_3:int = 0;
            var _loc_5:int = 0;
            while (_loc_5 < param1[0].length)
            {
                
                _loc_3 = 0;
                _loc_2 = param1[0][_loc_5];
                _loc_4 = new Object();
                _loc_4.myTeamId = _loc_2[_loc_3++];
                _loc_4.otherTeamId = _loc_2[_loc_3++];
                _loc_4.round = _loc_2[_loc_3++];
                _loc_4.teamName = _loc_2[_loc_3++];
                _loc_4.bWin = _loc_2[_loc_3++] == 1;
                _loc_4.winTeamId = _loc_2[_loc_3++];
                _loc_4.score = _loc_2[_loc_3++];
                _loc_4.warId = _loc_2[_loc_3++];
                _loc_4.version = _loc_2[_loc_3++];
                _loc_4.isTaoTai = true;
                _loc_4.day = NewTopWarDataLang.TaoTaiSai;
                if (_loc_4.bWin)
                {
                    _loc_4.win = NewTopWarDataLang.Win;
                }
                else
                {
                    _loc_4.win = NewTopWarDataLang.Lost;
                }
                _loc_4.step = Mod_NewTopWar_Base.TAOTAI;
                this.warList.push(_loc_4);
                _loc_5++;
            }
            _loc_5 = 0;
            while (_loc_5 < param1[1].length)
            {
                
                _loc_2 = param1[1][_loc_5];
                _loc_3 = 0;
                _loc_6 = new Object();
                _loc_4 = new Object();
                _loc_4.step = _loc_2[_loc_3++];
                _loc_4.round = _loc_2[_loc_3++];
                var _loc_11:* = _loc_2[_loc_3++];
                _loc_4.score = _loc_2[_loc_3++];
                _loc_6.score = _loc_11;
                var _loc_11:* = _loc_2[_loc_3++];
                _loc_4.teamName = _loc_2[_loc_3++];
                _loc_6.teamName = _loc_11;
                _loc_4.stageName = _loc_2[_loc_3++];
                _loc_4.servername = _loc_2[_loc_3++];
                _loc_4.machScore = _loc_2[_loc_3++];
                var _loc_11:* = _loc_2[_loc_3++];
                _loc_4.rank = _loc_2[_loc_3++];
                _loc_6.rank = _loc_11;
                var _loc_11:* = _loc_2[_loc_3++];
                _loc_4.teamFlag = _loc_2[_loc_3++];
                _loc_6.teamFlag = _loc_11;
                _loc_4.my_fight_apply_id = _loc_2[_loc_3++];
                _loc_4.match_fight_apply_id = _loc_2[_loc_3++];
                _loc_4.bWin = _loc_2[_loc_3++] == 1;
                _loc_4.winTeamId = _loc_2[_loc_3++];
                _loc_4.warId = _loc_2[_loc_3++];
                _loc_4.version = _loc_2[_loc_3++];
                var _loc_11:int = 0;
                _loc_4.otherTeamId = 0;
                _loc_6.teamId = _loc_11;
                _loc_4.isTaoTai = false;
                _loc_4.day = "";
                switch(_loc_4.step)
                {
                    case Mod_NewTopWar_Base.WORLD_1:
                    {
                        _loc_4.day = NewTopWarDataLang.DiYiTian;
                        break;
                    }
                    case Mod_NewTopWar_Base.WORLD_2:
                    {
                        _loc_4.day = NewTopWarDataLang.DiErTian;
                        break;
                    }
                    case Mod_NewTopWar_Base.WORLD_3:
                    {
                        _loc_4.day = NewTopWarDataLang.DiSanTian;
                        break;
                    }
                    case Mod_NewTopWar_Base.WORLD_4:
                    {
                        _loc_4.day = NewTopWarDataLang.DiSitian;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_4.bWin)
                {
                    _loc_4.win = NewTopWarDataLang.Win;
                }
                else
                {
                    _loc_4.win = NewTopWarDataLang.Lost;
                }
                _loc_7 = new Array();
                _loc_8 = 0;
                while (_loc_8 < _loc_2[_loc_3].length)
                {
                    
                    _loc_9 = new Object();
                    _loc_10 = _loc_2[_loc_3][_loc_8];
                    _loc_9.nickName = _loc_10[0];
                    _loc_9.iconUrl = URI.iconsMiniUrl + RoleType.getRoleSign(_loc_10[1]) + ".png";
                    _loc_9.isLeader = _loc_10[2] == 1;
                    _loc_9.lv = _loc_10[3];
                    _loc_9.roleId = _loc_10[4];
                    _loc_9.playerInfo = "";
                    if (_loc_9.isLeader)
                    {
                        _loc_9.playerInfo = NewTopWarDataLang.DuiZhang;
                    }
                    else
                    {
                        _loc_9.playerInfo = NewTopWarDataLang.DuiYuan;
                    }
                    _loc_9.playerInfo = _loc_9.playerInfo + (" <font color=\'#F09600\'>" + _loc_9.nickName + "</font>");
                    _loc_9.playerInfo = _loc_9.playerInfo + (" " + _loc_9.lv + NewTopWarDataLang.DengJi);
                    if (_loc_9.roleId != 0)
                    {
                        _loc_9.playerInfo = _loc_9.playerInfo + (" " + NewTopWarDataLang.HuoBan + " " + HtmlText.format(RoleType.getRoleName(_loc_9.roleId), RoleType.getRoleColorById(_loc_9.roleId)));
                    }
                    if (_loc_9.isLeader)
                    {
                        _loc_7.unshift(_loc_9);
                    }
                    else
                    {
                        _loc_7.push(_loc_9);
                    }
                    _loc_8++;
                }
                _loc_6.memberList = _loc_7;
                _loc_4.teamInfo = _loc_6;
                this.warList.push(_loc_4);
                _loc_5++;
            }
            this.warList.sortOn(["step", "round"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
            return;
        }// end function

        public function get_war_report(param1:Array) : void
        {
            return;
        }// end function

        public function update_step(param1:Array) : void
        {
            this.topWarStep = param1[0];
            return;
        }// end function

        public function rank_list(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:Array = null;
            var _loc_9:Object = null;
            this.rankList = new Array();
            var _loc_2:int = 0;
            while (_loc_2 < param1[0].length)
            {
                
                _loc_3 = param1[0][_loc_2];
                _loc_4 = new Object();
                _loc_5 = 0;
                _loc_4.teamName = _loc_3[_loc_5++];
                _loc_4.stageName = _loc_3[_loc_5++];
                _loc_4.servername = _loc_3[_loc_5++];
                _loc_4.score = _loc_3[_loc_5++];
                _loc_4.rank = _loc_3[_loc_5++];
                _loc_4.preRank = _loc_3[_loc_5++];
                _loc_4.teamFlag = _loc_3[_loc_5++];
                _loc_4.upSign = 1;
                _loc_4.teamId = 0;
                if (_loc_4.rank > _loc_4.preRank)
                {
                    _loc_4.upSign = 1;
                }
                else if (_loc_4.rank < _loc_4.preRank)
                {
                    _loc_4.upSign = 2;
                }
                else
                {
                    _loc_4.upSign = 3;
                }
                _loc_6 = new Array();
                _loc_7 = 0;
                while (_loc_7 < _loc_3[_loc_5].length)
                {
                    
                    _loc_8 = _loc_3[_loc_5][_loc_7];
                    _loc_9 = new Object();
                    _loc_9.nickName = _loc_8[0];
                    _loc_9.iconUrl = URI.iconsMiniUrl + RoleType.getRoleSign(_loc_8[1]) + ".png";
                    _loc_9.isLeader = _loc_8[2] == 1;
                    _loc_9.lv = _loc_8[3];
                    _loc_9.roleId = _loc_8[4];
                    _loc_9.playerInfo = "";
                    if (_loc_9.isLeader)
                    {
                        _loc_9.playerInfo = NewTopWarDataLang.DuiZhang;
                    }
                    else
                    {
                        _loc_9.playerInfo = NewTopWarDataLang.DuiYuan;
                    }
                    _loc_9.playerInfo = _loc_9.playerInfo + (" <font color=\'#F09600\'>" + _loc_9.nickName + "</font>");
                    _loc_9.playerInfo = _loc_9.playerInfo + (" " + _loc_9.lv + NewTopWarDataLang.DengJi);
                    if (_loc_9.roleId != 0)
                    {
                        _loc_9.playerInfo = _loc_9.playerInfo + (" " + NewTopWarDataLang.HuoBan + " " + HtmlText.format(RoleType.getRoleName(_loc_9.roleId), RoleType.getRoleColorById(_loc_9.roleId)));
                    }
                    if (_loc_9.isLeader)
                    {
                        _loc_6.unshift(_loc_9);
                    }
                    else
                    {
                        _loc_6.push(_loc_9);
                    }
                    _loc_7++;
                }
                _loc_4.memberList = _loc_6;
                this.rankList.push(_loc_4);
                _loc_2++;
            }
            this.rankList.sortOn("rank", Array.NUMERIC);
            return;
        }// end function

        public function throne(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:Array = null;
            var _loc_9:Object = null;
            this.topThroneList = new Array();
            this.rankList = new Array();
            var _loc_2:int = 0;
            while (_loc_2 < param1[0].length)
            {
                
                _loc_3 = param1[0][_loc_2];
                _loc_4 = new Object();
                _loc_5 = 0;
                _loc_5 = _loc_5 + 1;
                _loc_4.teamName = _loc_3[_loc_5++];
                _loc_4.stageName = _loc_3[_loc_5++];
                _loc_4.servername = _loc_3[_loc_5++];
                _loc_4.score = _loc_3[_loc_5++];
                _loc_4.rank = _loc_3[_loc_5++];
                _loc_4.teamFlag = _loc_3[_loc_5++];
                if (_loc_4.rank == 1)
                {
                    _loc_4.teamFlag = 1;
                }
                _loc_4.teamId = 0;
                _loc_4.urlPath = "";
                _loc_6 = new Array();
                _loc_7 = 0;
                while (_loc_7 < _loc_3[_loc_5].length)
                {
                    
                    _loc_8 = _loc_3[_loc_5][_loc_7];
                    _loc_9 = new Object();
                    _loc_9.nickName = _loc_8[0];
                    _loc_9.sign = RoleType.getRoleSign(_loc_8[1]);
                    _loc_9.iconUrl = URI.iconsMiniUrl + _loc_9.sign + ".png";
                    _loc_9.isLeader = _loc_8[2] == 1;
                    _loc_9.lv = _loc_8[3];
                    _loc_9.roleId = _loc_8[4];
                    if (_loc_9.isLeader)
                    {
                        _loc_4.urlPath = URI.topWarRole + _loc_9.sign + _loc_4.rank + ".swf";
                        _loc_9.playerInfo = NewTopWarDataLang.DuiZhang;
                    }
                    else
                    {
                        _loc_9.playerInfo = NewTopWarDataLang.DuiYuan;
                    }
                    _loc_9.playerInfo = _loc_9.playerInfo + (" <font color=\'#d76018\'>" + _loc_9.nickName + "</font>");
                    _loc_9.playerInfo = _loc_9.playerInfo + (" " + _loc_9.lv + NewTopWarDataLang.DengJi);
                    if (_loc_9.roleId != 0)
                    {
                        _loc_9.playerInfo = _loc_9.playerInfo + (" " + NewTopWarDataLang.HuoBan + " " + RoleType.getRoleName(_loc_9.roleId));
                    }
                    if (_loc_9.isLeader)
                    {
                        _loc_6.unshift(_loc_9);
                    }
                    else
                    {
                        _loc_6.push(_loc_9);
                    }
                    _loc_7++;
                }
                _loc_4.memberList = _loc_6;
                this.topThroneList.push(_loc_4);
                _loc_2++;
            }
            this.topThroneList.sortOn("rank", Array.NUMERIC);
            return;
        }// end function

    }
}
